Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVB1AlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVB1AlG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 19:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVB1AlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 19:41:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64911 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261524AbVB1Ajm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 19:39:42 -0500
Message-ID: <4222683F.2070609@pobox.com>
Date: Sun, 27 Feb 2005 19:39:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wen Xiong <wendyx@us.ibm.com>
CC: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [ patch 5/7] drivers/serial/jsm: new serial device driver
References: <42225A57.7050200@us.ltcfwd.linux.ibm.com>
In-Reply-To: <42225A57.7050200@us.ltcfwd.linux.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wen Xiong wrote:

> +/* Our "in use" variables, to enforce 1 open only */
> +static int jsm_mgmt_in_use[MAXMGMTDEVICES];

Eliminate MAXMGMTDEVICES


> +
> +/*
> + * jsm_mgmt_open()  
> + *
> + * Open the mgmt/downld/dpa device
> + */  
> +int jsm_mgmt_open(struct inode *inode, struct file *file)
> +{
> +	unsigned long lock_flags;
> +	unsigned int minor = JSM_MINOR(inode);
> +
> +	DPR_MGMT(("jsm_mgmt_open start.\n"));
> +
> +	spin_lock_irqsave(&jsm_global_lock, lock_flags);
> +
> +	/* mgmt device */
> +	if (minor < MAXMGMTDEVICES) {
> +		/* Only allow 1 open at a time on mgmt device */
> +		if (jsm_mgmt_in_use[minor]) {
> +			spin_unlock_irqrestore(&jsm_global_lock, lock_flags);
> +			return -EBUSY;
> +		}
> +		jsm_mgmt_in_use[minor]++;

An interruptible sleep (semaphore?) is usually preferred to EBUSY.


> +	else {
> +		spin_unlock_irqrestore(&jsm_global_lock, lock_flags);
> +		return -ENXIO;
> +	}
> +
> +	spin_unlock_irqrestore(&jsm_global_lock, lock_flags);
> +
> +	DPR_MGMT(("jsm_mgmt_open finish.\n"));
> +
> +	return 0;
> +}
> +
> +/*
> + * jsm_mgmt_close()
> + *
> + * Open the mgmt/dpa device
> + */  
> +int jsm_mgmt_close(struct inode *inode, struct file *file)
> +{
> +	unsigned long lock_flags;
> +	unsigned int minor = JSM_MINOR(inode);
> +
> +	DPR_MGMT(("jsm_mgmt_close start.\n"));
> +
> +	spin_lock_irqsave(&jsm_global_lock, lock_flags);
> +
> +	/* mgmt device */
> +	if (minor < MAXMGMTDEVICES) {
> +		if (jsm_mgmt_in_use[minor])
> +			jsm_mgmt_in_use[minor] = 0;
> +	}
> +	spin_unlock_irqrestore(&jsm_global_lock, lock_flags);
> +
> +	DPR_MGMT(("jsm_mgmt_close finish.\n"));
> +
> +	return 0;
> +}
> +
> +/*
> + * jsm_mgmt_ioctl()
> + *
> + * ioctl the mgmt/dpa device
> + */  
> +
> +int jsm_mgmt_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	unsigned long lock_flags;
> +	void __user *uarg = (void __user *) arg;
> +
> +	DPR_MGMT(("jsm_mgmt_ioctl start.\n"));
> +
> +	switch (cmd) {
> +
> +	case DIGI_GETDD:
> +	{
> +		/*
> +		 * This returns the total number of boards
> +		 * in the system, as well as driver version
> +		 * and has space for a reserved entry
> +		 */
> +		struct digi_dinfo ddi;

stack usage



> +		spin_lock_irqsave(&jsm_global_lock, lock_flags);
> +
> +		ddi.dinfo_nboards = jsm_NumBoards;
> +		sprintf(ddi.dinfo_version, "%s", "40002438_A-INKERNEL");
> +
> +		spin_unlock_irqrestore(&jsm_global_lock, lock_flags);
> +
> +		DPR_MGMT(("DIGI_GETDD returning numboards: %d version: %s\n",
> +			ddi.dinfo_nboards, ddi.dinfo_version));
> +
> +		if (copy_to_user(uarg, &ddi, sizeof (ddi)))
> +			return -EFAULT;
> +
> +		break;
> +	}
> +
> +	case DIGI_GETBD:
> +	{
> +		int brd;
> +
> +		struct digi_info di;

ditto


> +		if (copy_from_user(&brd, uarg, sizeof(int)))
> +			return -EFAULT;
> +
> +		DPR_MGMT(("DIGI_GETBD asking about board: %d\n", brd));
> +
> +		if ((brd < 0) || (brd > jsm_NumBoards) || (jsm_NumBoards == 0))
> +			return -ENODEV;
> +
> +		memset(&di, 0, sizeof(di));
> +
> +		di.info_bdnum = brd;
> +
> +		spin_lock_irqsave(&jsm_Board[brd]->bd_lock, lock_flags);
> +
> +		di.info_bdtype = jsm_Board[brd]->dpatype;
> +		di.info_bdstate = jsm_Board[brd]->dpastatus;
> +		di.info_ioport = 0;
> +		di.info_physaddr = (ulong) jsm_Board[brd]->membase;
> +		di.info_physsize = (ulong) jsm_Board[brd]->membase - jsm_Board[brd]->membase_end;
> +		if (jsm_Board[brd]->state != BOARD_FAILED)
> +			di.info_nports = jsm_Board[brd]->nasync;
> +		else
> +			di.info_nports = 0;
> +
> +		spin_unlock_irqrestore(&jsm_Board[brd]->bd_lock, lock_flags);
> +
> +		DPR_MGMT(("DIGI_GETBD returning type: %x state: %x ports: %x size: %x\n",
> +			di.info_bdtype, di.info_bdstate, di.info_nports, di.info_physsize));
> +
> +		if (copy_to_user(uarg, &di, sizeof (di)))
> +			return -EFAULT;
> +
> +		break;
> +	}
> +
> +	case DIGI_GET_NI_INFO:
> +	{
> +		struct channel_t *ch;
> +		struct ni_info ni;
> +		ulong lock_flags;
> +		uchar mstat = 0;
> +		uint board = 0;
> +		uint channel = 0;
> +
> +		if (copy_from_user(&ni, uarg, sizeof(struct ni_info)))
> +			return -EFAULT;
> +
> +		DPR_MGMT(("DIGI_GETBD asking about board: %d channel: %d\n",
> +			ni.board, ni.channel));
> +
> +		board = ni.board;
> +		channel = ni.channel;
> +
> +		/* Verify boundaries on board */
> +		if ((board < 0) || (board > jsm_NumBoards) || (jsm_NumBoards == 0))
> +			return -ENODEV;
> +
> +		/* Verify boundaries on channel */
> +		if ((channel < 0) || (channel > jsm_Board[board]->nasync))
> +			return -ENODEV;
> +
> +		ch = jsm_Board[board]->channels[channel];
> +
> +		if (!ch || ch->magic != JSM_CHANNEL_MAGIC)
> +			return -ENODEV;
> +
> +		memset(&ni, 0, sizeof(ni));
> +		ni.board = board;
> +		ni.channel = channel;
> +
> +		spin_lock_irqsave(&ch->ch_lock, lock_flags);
> +
> +		mstat = (ch->ch_mostat | ch->ch_mistat);
> +
> +		if (mstat & UART_MCR_DTR) {
> +			ni.mstat |= TIOCM_DTR;
> +			ni.dtr = TIOCM_DTR;
> +		}
> +		if (mstat & UART_MCR_RTS) {
> +			ni.mstat |= TIOCM_RTS;
> +			ni.rts = TIOCM_RTS;
> +		}
> +		if (mstat & UART_MSR_CTS) {
> +			ni.mstat |= TIOCM_CTS;
> +			ni.cts = TIOCM_CTS;
> +		}
> +		if (mstat & UART_MSR_RI) {
> +			ni.mstat |= TIOCM_RI;
> +			ni.ri = TIOCM_RI;
> +		}
> +		if (mstat & UART_MSR_DCD) {
> +			ni.mstat |= TIOCM_CD;
> +			ni.dcd = TIOCM_CD;
> +		}
> +		if (mstat & UART_MSR_DSR)
> +			ni.mstat |= TIOCM_DSR;
> +
> +		ni.iflag = ch->ch_c_iflag;
> +		ni.oflag = ch->ch_c_oflag;
> +		ni.cflag = ch->ch_c_cflag;
> +		ni.lflag = ch->ch_c_lflag;
> +
> +		if (ch->ch_flags & CH_STOPI)
> +			ni.recv_stopped = 1;
> +		else
> +			ni.recv_stopped = 0;
> +
> +		if (ch->ch_flags & CH_STOP)
> +			ni.xmit_stopped = 1;
> +		else
> +			ni.xmit_stopped = 0;
> +
> +		ni.curtx = ch->ch_txcount;
> +		ni.currx = ch->ch_rxcount;
> +
> +		ni.baud = ch->ch_old_baud;
> +
> +		spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
> +
> +		if (copy_to_user(uarg, &ni, sizeof(ni)))
> +			return -EFAULT;
> +
> +		break;
> +	}
> +
> +	}
> +
> +	DPR_MGMT(("jsm_mgmt_ioctl finish.\n"));
> +
> +	return 0;
> +}

