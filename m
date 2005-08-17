Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbVHQUMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbVHQUMK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 16:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbVHQUMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 16:12:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15317 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751226AbVHQUMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 16:12:08 -0400
Date: Wed, 17 Aug 2005 13:14:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrey Panin <pazke@donpac.ru>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 5/5] 2.6.13-rc5-mm1, driver for IBM Automatic Server
 Restart watchdog
Message-Id: <20050817131415.3bd1d5af.akpm@osdl.org>
In-Reply-To: <11236699783884@donpac.ru>
References: <11236699751680@donpac.ru>
	<11236699783884@donpac.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Panin <pazke@donpac.ru> wrote:
>
> 
> This patch adds driver for IBM Automatic Server Restart watchdog hardware
> found in some IBM eServer xSeries machines. This driver is based on the ugly
> driver provided by IBM. Driver was tested on IBM eServer 226.
> 
> ...
> +
> +	case ASMTYPE_JASPER:
> +		type = "Jaspers ";
> +
> +		/* FIXME: need to use pci_config_lock here, but it's not exported */

That's gregkh material.

> +
> +/*		spin_lock_irqsave(&pci_config_lock, flags);*/
> +
> +		/* Select the SuperIO chip in the PCI I/O port register */
> +		outl(0x8000f858, 0xcf8);
> +
> +		/* 
> +		 * Read the base address for the SuperIO chip.
> +		 * Only the lower 16 bits are valid, but the address is word 
> +		 * aligned so the last bit must be masked off.
> +		 */
> +		asr_base = inl(0xcfc) & 0xfffe;
> +
> +/*		spin_unlock_irqrestore(&pci_config_lock, flags);*/
>
> ...
>
> +static int asr_ioctl(struct inode *inode, struct file *file,
> +		     unsigned int cmd, unsigned long arg)
> +{
> +	static const struct watchdog_info ident = {
> +		.options =	WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT |
> +				WDIOF_MAGICCLOSE,
> +		.identity =	"IBM ASR"
> +	};
> +	void __user *argp = (void __user *)arg;
> +	int __user *p = argp;
> +	int heartbeat;
> +
> +	switch (cmd) {
> +		case WDIOC_GETSUPPORT:
> +			return copy_to_user(argp, &ident, sizeof(ident)) ? 
> +				-EFAULT : 0;
> +
> +		case WDIOC_GETSTATUS:
> +		case WDIOC_GETBOOTSTATUS:
> +			return put_user(0, p);
> +
> +		case WDIOC_KEEPALIVE:
> +			asr_toggle();
> +			return 0;
> +
> +
> +		case WDIOC_SETTIMEOUT:
> +			if (get_user(heartbeat, p))
> +				return -EFAULT;
> +			/* Fall */
> +
> +		case WDIOC_GETTIMEOUT:
> +			heartbeat = 256;
> +			return put_user(heartbeat, p);

Something very wrong is happening with WDIOC_SETTIMEOUT and
WDIOC_GETTIMEOUT.  They're both no-ops and the effect of WDIOC_SETTIMEOUT
is immidiately overwritten.

