Return-Path: <linux-kernel-owner+w=401wt.eu-S932823AbWL0Ngw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932823AbWL0Ngw (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 08:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932826AbWL0Ngw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 08:36:52 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:42948 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932823AbWL0Ngv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 08:36:51 -0500
Message-id: <554564654653216610@wsc.cz>
In-reply-to: <87mz595zlu.fsf@javad.com>
Subject: Re: moxa serial driver testing
From: Jiri Slaby <jirislaby@gmail.com>
To: Sergei Organov <osv@javad.com>
Cc: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
References: <45222E7E.3040904@gmail.com> <87wt7hw97c.fsf@javad.com>
	<4522ABC3.2000604@gmail.com> <878xjx6xtf.fsf@javad.com>
	<4522B5C2.3050004@gmail.com> <87mz8borl2.fsf@javad.com>
	<45251211.7010604@gmail.com> <87zmcaokys.fsf@javad.com>
	<45254F61.1080502@gmail.com> <87vemyo9ck.fsf@javad.com>
	<4af2d03a0610061355p5940a538pdcbd2cda249161e8@mail.gmail.com>
	<87vemtnbyg.fsf@javad.com> <452A1862.9030502@gmail.com>
	<87r6urket6.fsf@javad.com> <552766292581216610@wsc.cz>
	<552766292581216610@wsc.cz>
Date: Wed, 27 Dec 2006 14:36:56 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jiri Slaby <jirislaby@gmail.com> writes:
> 
> > Could you test the patch below, if something changes?
> 
> Just tested with low_latency commented out. Still oopses:
> 
> BUG: unable to handle kernel NULL pointer dereference at virtual address 00000008
>  printing eip:
> f8f1730f
> *pde = 00000000
> Oops: 0000 [#1]
> SMP 
> Modules linked in: nvidia agpgart ipv6 nfs lockd nfs_acl sunrpc dm_mod sr_mod sbp2 ieee1394 ide_generic ide_disk e1000 snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer i2c_i801 tsdev psmouse snd soundcore snd_page_alloc i2c_core serio_raw parport_pc parport mxser_new evdev floppy pcspkr rtc ext3 jbd mbcache usb_storage usbhid ide_cd cdrom sd_mod uhci_hcd piix usbcore skge ata_piix libata scsi_mod generic ide_core thermal processor fan
> CPU:    0
> EIP:    0060:[<f8f1730f>]    Tainted: P      VLI
> EFLAGS: 00010046   (2.6.18-3-686 #1) 
> EIP is at mxser_receive_chars+0x21b/0x249 [mxser_new]

Yes, port->tty still somewhere becomes NULL -- does this patch help?

---

diff -Nrup mxser_newa/mxser_new.c mxser_newb/mxser_new.c
--- mxser_newa/mxser_new.c	2006-12-26 18:22:30.000000000 +0100
+++ mxser_newb/mxser_new.c	2006-12-27 14:26:22.000000000 +0100
@@ -2051,13 +2051,16 @@ static void mxser_wait_until_sent(struct
 void mxser_hangup(struct tty_struct *tty)
 {
 	struct mxser_port *info = tty->driver_data;
+	unsigned long flags;
 
 	mxser_flush_buffer(tty);
 	mxser_shutdown(info);
+	spin_lock_irqsave(&info->slock, flags);
 	info->event = 0;
 	info->count = 0;
 	info->flags &= ~ASYNC_NORMAL_ACTIVE;
 	info->tty = NULL;
+	spin_unlock_irqrestore(&info->slock, flags);
 	wake_up_interruptible(&info->open_wait);
 }
 
@@ -2263,8 +2266,6 @@ static irqreturn_t mxser_interrupt(int i
 			if (bits & irqbits)
 				continue;
 			port = &brd->ports[i];
-			if (!(port->flags & ASYNC_INITIALIZED))
-				continue;
 
 			int_cnt = 0;
 			spin_lock(&port->slock);
@@ -2274,7 +2275,9 @@ static irqreturn_t mxser_interrupt(int i
 					break;
 				iir &= MOXA_MUST_IIR_MASK;
 				if (!port->tty ||
-						(port->flags & ASYNC_CLOSING)) {
+						(port->flags & ASYNC_CLOSING) ||
+						!(port->flags &
+							ASYNC_INITIALIZED)) {
 					status = inb(port->ioaddr + UART_LSR);
 					outb(0x27, port->ioaddr + UART_FCR);
 					inb(port->ioaddr + UART_MSR);
