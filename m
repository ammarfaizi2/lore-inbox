Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbTIPR43 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 13:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbTIPR43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 13:56:29 -0400
Received: from mail.kroah.org ([65.200.24.183]:45000 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261982AbTIPR4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 13:56:22 -0400
Date: Tue, 16 Sep 2003 10:41:19 -0700
From: Greg KH <greg@kroah.com>
To: felipe_alfaro@linuxmail.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 1227] New: Oops with SynCE and Compaq iPAQ 3600
Message-ID: <20030916174119.GB3893@kroah.com>
References: <1504610000.1063637215@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504610000.1063637215@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 07:46:55AM -0700, Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=1227
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000010c
>  printing eip:
> e08794d4
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT
> CPU:    0
> EIP:    0060:[<e08794d4>]     Not tainted VLI
> EFLAGS: 00010297
> EIP is at ipaq_read_bulk_callback+0xca/0x282 [ipaq]
> eax: 00000006   ebx: 00000000   ecx: de7cd600   edx: 00000006
> esi: de9fc200   edi: df4f9600   ebp: 00000000   esp: c038dee0
> ds: 007b   es: 007b   ss:0068
> Process swapper (pid: 0, threadinfo=c038c000 task=c03169c0)
> Stack: 00000046 00000086 de9fc200 de9fc200 00000006 dd273000 de7cd600 de9fc200
>        c038dfa4 de9fc200 df765c00 e08421ea de9fc200 c038dfa4 c038c000 00000286
>        e082ed9a df765c00 de9fc200 c038dfa4 df765df8 c038dfa4 df765c00 00000001
> Call Trace:
>  [<e08421ea>] usb_hcd_giveback_urb+0x25/0x39 [usbcore]
>  [<e082ed9a>] uhci_finish_completion+0x6a/0xac [uhci_hcd]
>  [<e0842234>] usb_hcd_irq+0x36/0x5f [usbcore]
>  [<c010c633>] handle_IRQ_event+0x3a/0x64
>  [<c010c999>] do_IRQ+0x94/0x135
>  [<c0107000>] _stext+0x0/0x5d
>  [<c02d404c>] common_interrupt+0x18/0x20
>  [<c0107000>] _stext+0x0/0x5d
>  [<c012007b>] __wake_up_common+0x31/0x50
>  [<c0109041>] default_idle+0x23/0x26
>  [<c010909f>] cpu_idle+0x2c/0x35
>  [<c038e6cc>] start_kernel+0x17d/0x1ab
>  [<c038e426>] unknown_bootoption+0x0/0xfd

Does the following patch solve this oops?

thanks,

greg k-h


--- a/drivers/usb/serial/ipaq.c	Wed Sep  3 08:47:21 2003
+++ b/drivers/usb/serial/ipaq.c	Tue Sep 16 10:34:30 2003
@@ -341,7 +341,7 @@
 	usb_serial_debug_data (__FILE__, __FUNCTION__, urb->actual_length, data);
 
 	tty = port->tty;
-	if (urb->actual_length) {
+	if (tty && urb->actual_length) {
 		for (i = 0; i < urb->actual_length ; ++i) {
 			/* if we insert more than TTY_FLIPBUF_SIZE characters, we drop them. */
 			if(tty->flip.count >= TTY_FLIPBUF_SIZE) {
