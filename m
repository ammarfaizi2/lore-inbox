Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbUL2XMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbUL2XMP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 18:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbUL2XMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 18:12:14 -0500
Received: from av3-2-sn4.m-sp.skanova.net ([81.228.10.113]:55191 "EHLO
	av3-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S261431AbUL2XMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 18:12:06 -0500
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org, hal@freedesktop.org
Subject: Re: cannot eject drive using pktcdvd
References: <20041025144846.GA2137@gamma.logic.tuwien.ac.at>
	<20041223113248.GB27920@gamma.logic.tuwien.ac.at>
From: Peter Osterlund <petero2@telia.com>
Date: 30 Dec 2004 00:11:54 +0100
In-Reply-To: <20041223113248.GB27920@gamma.logic.tuwien.ac.at>
Message-ID: <m3mzvwya11.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Preining <preining@logic.at> writes:

> Peter Osterlund wrote:
> > I can't reproduce any of these problems on my laptop. I run FC3 and
> > kernel 2.6.10-rc3-bk6. I tried both with a USB CDRW drive and an IDE
> > DVD+RW drive.
> 
> I can reproduce this problem, in fact I experienced it myself and
> disabled udftools.
> 
> > More info is needed. What distribution? What kernel? And please
> > provide strace logs from eject when it fails.
> 
> kernel:		2.6.10-rc3-mm1
> distribution:	debian/sid
...
>  open("/dev/hdc", O_RDONLY|O_NONBLOCK)   = 3
>  ioctl(3, CDROMEJECT, 0xbffffb68)        = -1 EIO (Input/output error)

I got a similar problem on FC3, but it doesn't have anything to do
with pktcdvd. The hal daemon is leaking a file descriptor when
checking a data DVD that doesn't contain a file system.

The effect is that /dev/hdc is kept open which makes eject attempts
from non-root users fail.

Here is a patch to fix the leak. I think it will apply also to the hal
cvs tree.

--- hal-0.4.2/hald/linux/block_class_device.c.old	2004-12-29 23:51:17.200288832 +0100
+++ hal-0.4.2/hald/linux/block_class_device.c	2004-12-29 23:51:23.040401000 +0100
@@ -1055,6 +1055,7 @@
 				if (is_cdrom) {
 					/* volume_id cannot probe blank/audio discs etc,
 					 * so don't fail for them, just set vid to NULL */
+					volume_id_close (vid);
 					vid = NULL;
 				} else {
 					g_object_unref (child);

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
