Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263836AbTLUS7p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 13:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263846AbTLUS7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 13:59:45 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45064 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263836AbTLUS7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 13:59:43 -0500
Date: Sun, 21 Dec 2003 18:59:40 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: [BUG] gunzip/inflate non-terminal on errors
Message-ID: <20031221185940.B12500@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The gunzip/inflate algorithm in 2.6.0 (and previous kernels) found in
lib/inflate.c has some cases which cause it to be non-terminal on error.

The situation I'm presently facing is that the firmware on some NetWinders
scan memory looking for the gzip magic numbers after loading a kernel
image.  If the kernel image is a "zImage", the firmware finds the
compressed piggy image inside zImage, and sets up the initrd to point
there.

The firmware then calls the kernel decompressor, which dutifully
decompresses the image, and calls the kernel.  This image ends up
getting corrupted at some point.

During kernel initialisation, we notice that an initrd was passed to
the kernel, and call gunzip() on it.  During gunzip, we notice that
we run out of bytes, so get_byte() returns -1.

Unfortunately, returning '-1' does not guarantee that gunzip() will
ever terminate; in fact, in my case it does not terminate.

With DEBG() and DEBG1() defined so that they printk, this is what I
see:

h6e h6f huft7 dyn5c huft1 huft2 huft3 huft4 huft5 h6 h6a h6b h6b1
1 2 3 4 5 6 h6c h6d h6e h6f h6b h6b1 h6c h6d h6e h6b1 h6c h6d h6e h6b1
h6c h6d h6e h6b1 h6c h6d h6e h6b1 h6c h6d h6e h6b1 h6c h6d h6e h6b1
h6c h6d h6e h6f h6b h6b1 h6c h6d h6e h6b1 h6c h6d h6e h6b1 h6c h6d h6e h6b1
h6c h6d h6e h6b1 h6c h6d h6e h6b1 h6c h6d h6e h6b1 h6c h6d h6e h6b1
h6c h6d h6e h6b1 h6c h6d h6e h6b1 h6c h6d h6e h6b1 h6c h6d h6e h6b1
h6c h6d h6e h6f h6b h6b1 h6c h6d h6e h6b1 h6c h6d h6e h6b1
h6c h6d h6e h6f h6b h6b1 1 2 3 4 5 6 h6c h6d h6e h6f h6b h6b1
h6c h6d h6e h6f h6b h6b1 h6c h6d h6e h6f h6b h6b1 h6c h6d h6e h6b1
h6c h6d h6e h6f huft7 dyn6 <runs out of bytes>

Userspace gunzip handles this error condition by calling exit() from
the depths of the decompressor.  This is nice and simple, assuming
you can just exit.  Unfortunately, in the kernel we can't, and so
the inflate appears to request more and more data indefinitely.

"dyn6" indicates that we entered inflate_codes(), but we never seem
to leave.  Additionally, we appear to be calling flush_window() fairly
often.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
