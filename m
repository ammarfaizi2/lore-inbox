Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266575AbUGPUQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266575AbUGPUQy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 16:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266592AbUGPUQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 16:16:39 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:62609 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266575AbUGPUP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 16:15:57 -0400
Subject: Re: [linux-audio-user] 2.6.8-rc1-mm1 [and alsa xrun debugging]
From: Lee Revell <rlrevell@joe-job.com>
To: A list for linux audio users <linux-audio-user@music.columbia.edu>
Cc: linux-audio-dev@music.columbia.edu,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040716162510.7bac6a7c@mango.fruits.de>
References: <20040716162510.7bac6a7c@mango.fruits.de>
Content-Type: text/plain
Message-Id: <1090008963.27995.19.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Jul 2004 16:16:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-16 at 10:25, Florian Schmidt wrote:
> after reading lee's email i had to try this kernel.. so i went over to www.de.kernel.org, grabbed 2.6.8-rc1 and patched it up with this patch: 
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0407.1/1453.html
> 
> On first sight it looks very good. many of the sporadic xruns i experienced 
> with jack in RT mode are gone. even a "find /" parallel to a "make bzImage" 
> seems not to provoke any xruns [i use ext3]. But: i use fluxbox and it supports 
> desktop wheeling [switching desktop via scrollwheel - very handy] and doing this 
> excessively and rapidly provokes xruns easily. Also starting mozilla just provoked 
> an xrun..

Try the included patch.  Andrew Morton suggested this, and it works
great for me, but it is not in -mm1.

Lee

--- drivers/char/tty_io.c_orig  2004-07-16 16:10:11.000000000 -0400
+++ drivers/char/tty_io.c       2004-07-16 16:10:31.000000000 -0400
@@ -679,17 +679,13 @@
                return -ERESTARTSYS;
        }
        if ( test_bit(TTY_NO_WRITE_SPLIT, &tty->flags) ) {
-               lock_kernel();
                written = write(tty, file, buf, count);
-               unlock_kernel();
        } else {
                for (;;) {
                        unsigned long size = max((unsigned long)PAGE_SIZE*2, 16384UL);
                        if (size > count)
                                size = count;
-                       lock_kernel();
                        ret = write(tty, file, buf, size);
-                       unlock_kernel();
                        if (ret <= 0)
                                break;
                        written += ret;


