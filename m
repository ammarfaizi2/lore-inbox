Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267823AbUHPRrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267823AbUHPRrt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 13:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267822AbUHPRrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 13:47:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:39091 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267828AbUHPRqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 13:46:03 -0400
X-Authenticated: #1725425
Date: Mon, 16 Aug 2004 19:57:50 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jwendel10@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
Message-Id: <20040816195750.6419699f.Ballarin.Marc@gmx.de>
In-Reply-To: <1092661385.20528.25.camel@localhost.localdomain>
References: <411FD919.9030702@comcast.net>
	<20040816143817.0de30197.Ballarin.Marc@gmx.de>
	<1092661385.20528.25.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004 14:03:06 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Llu, 2004-08-16 at 13:38, Marc Ballarin wrote:
> > Due to the newly added command filtering, you now need to run cdrecord as
> > root. Since cdrecord will drop root privileges before accessing the drive,
> > setuid root won't help
> 
> cdrecord should be fine. k3b is issuing something not on the filter
> list.
> 
> > This patch restores the behaviour of previous kernels, security issues included:
> 
> Like allowing any user to erase your drive firmware. What you could do
> which is much more useful is printk the command byte that gets refused
> and see if you can pin down what commands are being blocked that
> are needed by K3B 
> 
> Alan
> 

cdrecord 2.01a28 wants:
when doing dev=/dev/dvd -atip:
OR
dev=/dev/cdrom blank=fast

0x46 0x55 0x1e 0x1 0x35

when trying to write:
0x46 0x55

dvd+rw-mediainfo wants:
0x46

k3b wants:
0x46 0x55 0xac

Those are all command I've seen so far:
0x1 REWIND
0x1e PREVENT ALLOW MEDIUM REMOVAL
0x35 SYNCHRONIZE_CACHE
0x46 ?
0x55 MODE SELECT(10)
0xac ERASE(12)

Here is the patch I've been using:

--- linux-2.6.8/drivers/block/scsi_ioctl.c.orig	2004-08-16 19:48:15.083524248 +0200
+++ linux-2.6.8/drivers/block/scsi_ioctl.c	2004-08-16 19:09:19.000000000 +0200
@@ -174,0 +175,2 @@
+	else	
+		printk(KERN_WARNING "FILTERED: %x \n", cmd[0]);
