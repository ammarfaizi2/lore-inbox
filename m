Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264827AbUEKQft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264827AbUEKQft (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 12:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264873AbUEKQfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 12:35:48 -0400
Received: from pop.gmx.net ([213.165.64.20]:32486 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264827AbUEKQd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 12:33:58 -0400
X-Authenticated: #18147109
From: Gerald Schaefer <gerald.schaefer@gmx.net>
Reply-To: gerald.schaefer@gmx.net
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-2.6.5] oops when plugging CDC USB network
Date: Tue, 11 May 2004 18:33:51 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200405111833.51508.gerald.schaefer@gmx.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Blueman wrote:
> Unable to handle kernel NULL pointer dereference at virtual address 00000004
>  printing eip:
> c028ff64
> *pde = 00000000
> Oops: 0000 [#1]
> DEBUG_PAGEALLOC
> CPU:    0
> EIP:    0060:[<c028ff64>]    Not tainted
> EFLAGS: 00010296   (2.6.5) 
> EIP is at usb_disable_interface+0x14/0x50
> eax: df3a4ef8   ebx: 00000000   ecx: 00000000   edx: dffdaf38
> esi: 00000001   edi: 00000000   ebp: df3aabf8   esp: df98bcfc   
> ds: 007b   es: 007b   ss: 0068
> Process khubd (pid: 5, threadinfo=df98a000 task=df9bb9e0)
> Stack: 00000001 0000000b 00000001 00000001 df3d5d94 df3aabf8 c0290257
> df3aabf8
>        df3a4ef8 0000000b 00000001 00000001 00000001 00000000 00000000
> 00001388
>        00000000 df3a4ef8 df3d5d94 df3d5d94 df3d5d44 00000001 c029e301
> df3aabf8
> Call Trace:
>  [<c0290257>] usb_set_interface+0xb7/0x1a0

I had the same problem with my USB DSL Modem. After looking at
usb_set_interface() I noticed that iface->cur_altsetting is set
after calling usb_disable_interface(), although iface->cur_altsetting
is being accessed at the beginning of usb_disable_interface().

The following patch solved my problem, maybe it helps you too (the
patch is for 2.6.6, but my problem also existed in 2.6.5).
I am however not at all familiar with the USB kernel code, so it may
be a good idea to wait for a comment on this patch from someone who is...


--
Gerald

--- linux-2.6.6/drivers/usb/core/message.c	2004-05-11 18:11:52.000000000 +0200
+++ linux-2.6.6-new/drivers/usb/core/message.c	2004-05-11 18:15:53.000000000 +0200
@@ -965,9 +965,8 @@
 	 */
 
 	/* prevent submissions using previous endpoint settings */
-	usb_disable_interface(dev, iface);
-
 	iface->cur_altsetting = alt;
+	usb_disable_interface(dev, iface);
 
 	/* If the interface only has one altsetting and the device didn't
 	 * accept the request, we attempt to carry out the equivalent action
