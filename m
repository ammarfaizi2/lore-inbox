Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbVKEIhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbVKEIhP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 03:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVKEIhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 03:37:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63672 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751237AbVKEIhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 03:37:13 -0500
Date: Sat, 5 Nov 2005 00:36:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new driver synclink_gt
Message-Id: <20051105003653.1966d5c7.akpm@osdl.org>
In-Reply-To: <1130962689.5289.8.camel@deimos.microgate.com>
References: <1130962689.5289.8.camel@deimos.microgate.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum <paulkf@microgate.com> wrote:
>
> Patches for a new character device driver for
>  the SyncLink GT and SyncLink AC families of
>  synchronous and asynchronous serial adapters
>  are located at (patches too large for mailing list):
> 
>  http://www.microgate.com/ftp/linux/synclink_gt-2.6.14/patch-2.6.14-Kconfig
>  http://www.microgate.com/ftp/linux/synclink_gt-2.6.14/patch-2.6.14-Makefile
>  http://www.microgate.com/ftp/linux/synclink_gt-2.6.14/patch-2.6.14-synclink.h
>  http://www.microgate.com/ftp/linux/synclink_gt-2.6.14/patch-2.6.14-synclink_gt.c

There's not much point in presenting it as a patch-per-file, really - we
need all four patches to have a buildable driver, so it may as well be a
single patch.

We need to get a driverdude onto this - I'm not one any more.   Quick notes:

- Tx (at least) appears to DMA straight out of kmalloced memory.  If I
  read it right, it needs to use the PCI DMA API fully - pci_map_single()
  and friends.   <checks>  Maybe I misread it.

- It seems to be both a tty driver and a net driver, or something.  Can
  you please describe the hardware?

- Be aware that the tty ldisc APIs were redone in -mm, so this driver
  probably won't compile in -mm and fixups will be needed sometime.

> 
> /*
>  * compatibility and utility macros
>  */
> #define GET_USER(error,value,addr) error = get_user(value,addr)
> #define COPY_FROM_USER(error,dest,src,size) error = copy_from_user(dest,src,size) ? -EFAULT : 0
> #define PUT_USER(error,value,addr) error = put_user(value,addr)
> #define COPY_TO_USER(error,dest,src,size) error = copy_to_user(dest,src,size) ? -EFAULT : 0

eww.  Please just open-code these.

> /*
>  * module configuration and status
>  */
> static int pci_registered = 0;
> ...
> static struct _slgt_info *slgt_device_list = NULL;
> static int slgt_device_count = 0;
> 
> static int ttymajor=0;
> static int debug_level = 0;
> static int maxframe[MAX_DEVICES] = {0,};
> static int dosyncppp[MAX_DEVICES] = {0,};

None of these initialisations to zero are needed.

> module_param(ttymajor, int, 0);
> module_param(debug_level, int, 0);
> module_param_array(maxframe, int, NULL, 0);
> module_param_array(dosyncppp, int, NULL, 0);

MODULE_PARM_DESCs needed, please.

> 
> /*
>  * device specific structures, macros and functions
>  */
> 
> #define SLGT_MAX_PORTS 4
> #define SLGT_REG_SIZE  256
> 
> /*
>  * DMA buffer descriptor and access macros
>  */
> typedef struct
> {
> 	unsigned short count;
> 	unsigned short status;
> 	unsigned int pbuf;  /* physical address of data buffer */
> 	unsigned int next;  /* physical address of next descriptor */
> 
> 	/* driver book keeping */
> 	char *buf;          /* virtual  address of data buffer */
>     	unsigned int pdesc; /* physical address of this descriptor */
> 	dma_addr_t buf_dma_addr;
> } SLGT_DESC;

typedefs are unpopular in new code.   Just use `struct slgt_desc' everywhere.

> #define set_desc_buffer(a,b) (a).pbuf = cpu_to_le32((unsigned int)(b))
> #define set_desc_next(a,b) (a).next   = cpu_to_le32((unsigned int)(b))
> #define set_desc_count(a,b)(a).count  = cpu_to_le16((unsigned short)(b))
> #define set_desc_eof(a,b)  (a).status = cpu_to_le16((b) ? (le16_to_cpu((a).status) | BIT0) : (le16_to_cpu((a).status) & ~BIT0))
> #define desc_count(a)      (le16_to_cpu((a).count))
> #define desc_status(a)     (le16_to_cpu((a).status))
> #define desc_complete(a)   (le16_to_cpu((a).status) & BIT15)
> #define desc_eof(a)        (le16_to_cpu((a).status) & BIT2)
> #define desc_crc_error(a)  (le16_to_cpu((a).status) & BIT1)
> #define desc_abort(a)      (le16_to_cpu((a).status) & BIT0)
> #define desc_residue(a)    ((le16_to_cpu((a).status) & 0x38) >> 3)

That makes the driver harder to follow, but I guess as long as it's
followed religiously then it can make working on the driver more reliable.

> typedef struct _slgt_info {

Another typedef to remove, please.

> #ifdef CONFIG_HDLC
> 	struct net_device *netdev;
> #endif
> 
> } SLGT_INFO;

Ah, so the netdev is for hdlc transport.

> static MGSL_PARAMS default_params = {
> 	MGSL_MODE_HDLC,			/* unsigned long mode */
> 	0,				/* unsigned char loopback; */
> 	HDLC_FLAG_UNDERRUN_ABORT15,	/* unsigned short flags; */
> 	HDLC_ENCODING_NRZI_SPACE,	/* unsigned char encoding; */
> 	0,				/* unsigned long clock_speed; */
> 	0xff,				/* unsigned char addr_filter; */
> 	HDLC_CRC_16_CCITT,		/* unsigned short crc_type; */
> 	HDLC_PREAMBLE_LENGTH_8BITS,	/* unsigned char preamble_length; */
> 	HDLC_PREAMBLE_PATTERN_NONE,	/* unsigned char preamble; */
> 	9600,				/* unsigned long data_rate; */
> 	8,				/* unsigned char data_bits; */
> 	1,				/* unsigned char stop_bits; */
> 	ASYNC_PARITY_NONE		/* unsigned char parity; */
> };

Please use the

	.field = value,

form here.

> static void set_termios(struct tty_struct *tty, struct termios *old_termios)
> {
> 	SLGT_INFO *info = (SLGT_INFO *)tty->driver_data;
> 	unsigned long flags;
> 
> 	DBGINFO(("%s set_termios\n", tty->driver->name));
> 
> 	/* just return if nothing has changed */
> 	if ((tty->termios->c_cflag == old_termios->c_cflag)
> 	    && (RELEVANT_IFLAG(tty->termios->c_iflag)
> 		== RELEVANT_IFLAG(old_termios->c_iflag)))
> 	  return;

whitespace went weird.

> static void put_char(struct tty_struct *tty, unsigned char ch)
> {
> 	SLGT_INFO *info = (SLGT_INFO *)tty->driver_data;
> 	SLGT_INFO *info = (SLGT_INFO *)tty->driver_data;
> 	unsigned long flags;
> 
> 	if (sanity_check(info, tty->name, "put_char"))
> 		return;
> 	DBGINFO(("%s put_char(%d)\n", info->device_name, ch));
> 	if (!tty || !info->tx_buf)
> 		return;
> 	spin_lock_irqsave(&info->lock,flags);
> 	if (!info->tx_active && (info->tx_count < info->max_frame_size))
> 		info->tx_buf[info->tx_count++] = ch;
> 	spin_unlock_irqrestore(&info->lock,flags);
> }

Is silent droppage on overflow OK?

> /*
>  * Service an IOCTL request
>  *
>  * Arguments
>  *
>  * 	tty	pointer to tty instance data
>  * 	file	pointer to associated file object for device
>  * 	cmd	IOCTL command code
>  * 	arg	command argument/context
>  *
>  * Return 0 if success, otherwise error code
>  */
> static int ioctl(struct tty_struct *tty, struct file *file,
> 		 unsigned int cmd, unsigned long arg)
> {
> 	SLGT_INFO *info = (SLGT_INFO *)tty->driver_data;

Unneeded cast from void* (through the whole file, please).

> 	/* Append serial signal status to end */
> 	ret += sprintf(buf+ret, " %s\n", stat_buf+1);
> 
> 	ret += sprintf(buf+ret, "\ttxactive=%d bh_req=%d bh_run=%d pending_bh=%x\n",
> 	 info->tx_active,info->bh_requested,info->bh_running,
> 	 info->pending_bh);

whitespace funnies.

> static void bh_handler(void* context)
> {
> 	SLGT_INFO *info = (SLGT_INFO*)context;
> 	int action;
> 
> 	if (!info)
> 		return;
> 	info->bh_running = 1;

The handling of bh_running seems vague.  Is some locking needed around it? 
Memory barriers, at least?

> static void ri_change(SLGT_INFO *info)
> {
> 	get_signals(info);
> 	DBGISR(("ri_change %s signals=%04X\n", info->device_name, info->signals));
> 	if ((info->ri_chkcount)++ == IO_PIN_SHUTDOWN_LIMIT) {
> 		slgt_irq_off(info, IRQ_RI);
> 		return;
> 	}
> 	info->icount.dcd++;
> 	if (info->signals & SerialSignal_RI) {
> 		info->input_signal_events.ri_up++;
>         } else {
> 	        info->input_signal_events.ri_down++;
> 	}

whitespace

> /* interrupt service routine
>  *
>  * 	irq	interrupt number
>  * 	dev_id	device ID supplied during interrupt registration
>  * 	regs	interrupted processor context
>  */
> static irqreturn_t slgt_interrupt(int irq, void *dev_id, struct pt_regs * regs)
> {
> 	SLGT_INFO *info;
> 	unsigned int gsr;
> 	unsigned int i;
> 
> 	DBGISR(("slgt_interrupt irq=%d entry\n", irq));
> 
> 	info = (SLGT_INFO *)dev_id;
> 	if (!info)
> 		return IRQ_NONE;
> 
> 	spin_lock(&info->lock);
> 
> 	while((gsr = rd_reg32(info, GSR) & 0xffffff00)) {
> 		DBGISR(("%s gsr=%08x\n", info->device_name, gsr));
> 		info->irq_occurred = 1;
> 		for(i=0; i < info->port_count ; i++) {
> 			if (info->port_array[i] == NULL)
> 				continue;
> 			if (gsr & (BIT8 << i))
> 				isr_serial(info->port_array[i]);
> 			if (gsr & (BIT16 << (i*2)))
> 				isr_rdma(info->port_array[i]);
> 			if (gsr & (BIT17 << (i*2)))
> 				isr_tdma(info->port_array[i]);
> 		}
> 	}

Many ISRs are designed to special-case an irq-pending value of 0xffffffff
so they gracefully handle device unplug.  I guess this device doesn't come
in cardbus (yet), but maybe the same handling is needed for PCI hotplug.

> static void shutdown(SLGT_INFO * info)
> {
> 	unsigned long flags;
> 
> 	if (!(info->flags & ASYNC_INITIALIZED))
> 		return;
> 
> 	DBGINFO(("%s shutdown\n", info->device_name));
> 
> 	/* clear status wait queue because status changes */
> 	/* can't happen after shutting down the hardware */
> 	wake_up_interruptible(&info->status_event_wait_q);
> 	wake_up_interruptible(&info->event_wait_q);
> 
> 	del_timer(&info->tx_timer);
> 	del_timer(&info->rx_timer);

del_timer_sync() needed here - otherwise the timer handler could still be
in progress.

> 	spin_lock_irqsave(&info->lock,flags);
>  	set_signals(info);
> 	spin_unlock_irqrestore(&info->lock,flags);

This happens so often that it's worth creating a new function for it. 
Ditto get_signals().

> 
> static void free_tmp_rbuf(SLGT_INFO *info)
> {
> 	if (info->tmp_rbuf)
> 		kfree(info->tmp_rbuf);

kfree(NULL) is legal.

> 	memset(info->bufs, 0, DESC_LIST_SIZE);
> 
> 	info->rbufs = (SLGT_DESC*)info->bufs;
> 	info->tbufs = ((SLGT_DESC*)info->bufs) + info->rbuf_count;
> 
> 	pbufs = (unsigned int)info->bufs_dma_addr;

No, it shouldn't put a dma_addr_t into an unsigned int.  dma_addr_t is
sometimes 64-bit on 32-bit machines.  Basically, it should remain opaque.

> 		if (request_irq(port_array[0]->irq_level,
> 					slgt_interrupt,
> 					port_array[0]->irq_flags,
> 					port_array[0]->device_name,
> 					port_array[0]) < 0) {

The irq_flags seems a bit obfuscated.  WHy not just remove it and hard-code
SA_SHIRQ?

<attention fades>

Boy, it's a big driver...
