Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287545AbSAEGd7>; Sat, 5 Jan 2002 01:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287550AbSAEGds>; Sat, 5 Jan 2002 01:33:48 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:54283 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287545AbSAEGde>; Sat, 5 Jan 2002 01:33:34 -0500
Message-ID: <3C369D1C.771BA518@zip.com.au>
Date: Fri, 04 Jan 2002 22:28:44 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank Davis <fdavis@si.rr.com>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Dave Jones <davej@suse.de>
Subject: Re: 2.5.2-pre8: fs/ext3/super.c compile error
In-Reply-To: <Pine.LNX.4.33.0201050053070.6939-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Davis wrote:
> 
> Hello all,
>   I haven't seen the following posted.
> While 'make bzImage', I received the following compile error:
> ...
> super.c: In function 'make_rdonly':
> super.c:59: invalid operands to binary !=
> super.c:62: invalid operands to binary +
> make[3]: *** [super.o] Error 1
> make[3]: Leaving directory '/usr/src/linux/fs/ext3'
> ...

This is a piece of debug code - it's enabled by CONFIG_JBD_DEBUG,
and you can just disable that option to make the error go away.

The code in question is designed to tell the disk device driver
to start silently discarding all writes to the underlying device a
certain number of seconds after the filesystem is mounted.  This simulates
a machine crash.  It is for scripted crash+recovery testing.

The fix is:

--- linux-2.5.2-pre7/fs/ext3/super.c	Fri Jan  4 18:48:43 2002
+++ 25/fs/ext3/super.c	Fri Jan  4 22:22:03 2002
@@ -56,10 +56,10 @@ int journal_no_write[2];
 
 static void make_rdonly(kdev_t dev, int *no_write)
 {
-	if (dev) {
+	if (kdev_val(dev)) {
 		printk(KERN_WARNING "Turning device %s read-only\n", 
 		       bdevname(dev));
-		*no_write = 0xdead0000 + dev;
+		*no_write = 0xdead0000 + kdev_val(dev);
 	}
 }
