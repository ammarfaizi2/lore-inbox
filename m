Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266287AbUHaC37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266287AbUHaC37 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 22:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUHaC37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 22:29:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:61877 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266287AbUHaC35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 22:29:57 -0400
Date: Mon, 30 Aug 2004 19:29:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Tim Fairchild <tim@bcs4me.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: K3b and 2.6.9?
In-Reply-To: <200408311151.25854.tim@bcs4me.com>
Message-ID: <Pine.LNX.4.58.0408301917360.2295@ppc970.osdl.org>
References: <200408301047.06780.tim@bcs4me.com> <1093871277.30082.7.camel@localhost.localdomain>
 <200408311151.25854.tim@bcs4me.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Aug 2004, Tim Fairchild wrote:
> 
> Thanks. Yes I realize that and understand why this is a good idea to
> have. But most of the verify_command list seems fine and I find the
> following works, but don't know if this is any 'safer' or not... This is
> the particular test that makes the difference to k3b/cdrecord, but I
> don't know enough to work out what it actually does... (this is with
> 2.6.9-rc1-bk6)
> 
> --- a/drivers/block/scsi_ioctl.c.original  2004-08-30 23:50:16.000000000 +1000
> +++ b/drivers/block/scsi_ioctl.c  2004-08-31 08:37:56.000000000 +1000
> @@ -192,7 +192,7 @@
> 
>         /* Write-safe commands just require a writable open.. */
>         if (type & CMD_WRITE_SAFE) {
> -               if (file->f_mode & FMODE_WRITE)
> +/*              if (file->f_mode & FMODE_WRITE)      */
>                         return 0;
>         }

Ehh.. This seems to imply that K3b opens the device for _reading_ when it 
wants to burn a CD-ROM. It also implies that K3b only uses the commands 
that are already marked as being "safe for writing", so the kernel command 
list is apparently fine. 

Which implies that the only way to fix it sanely is literally to have K3b 
open the device for writing, and then everything will be happy.

As far as I can tell, the fix should be a simple one-liner: make sure that 
K3b opens the device with O_RDWR | O_NONBLOCK instead of using O_RDONLY | 
O_NONBLOCK. The fix looks trivial, it's in

   src/device/k3bdevice.cpp:
	int K3bCdDevice::openDevice( const char* name );

(two places).

That "kind of" makes sense anyway - if you want to write to the disk, you 
damn well should open the disk for writing, no? So clearly K3b right now 
is doing something pretty nonsensical.

Can somebody who is active in the K3b community check with the K3b 
authors, and please try to get that fixed?

			Linus
