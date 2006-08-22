Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWHVBtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWHVBtT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 21:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWHVBtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 21:49:19 -0400
Received: from smtp.thermawave.com ([12.16.197.83]:30822 "EHLO
	smtp.thermawave.com") by vger.kernel.org with ESMTP
	id S1751115AbWHVBtS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 21:49:18 -0400
Message-Id: <s4ea002d.085@smtp.thermawave.com>
X-Mailer: Novell GroupWise Internet Agent 6.0.4
Date: Mon, 21 Aug 2006 18:49:03 -0700
From: "Misha Sushchik" <msushchi@thermawave.com>
To: <ibr@radix50.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Help: error 514 in select()
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Baurzhan:

Thank you for this information. 
We are now trying to get someone fix the problem for us. 
Unfortunately I know nothing of kernel-level programming and do not have the time to get up to speed in it myself.

At my level (application developer, not very deep) I have several pieces that I am missing.
1) I do not know when this problem first appeared (or, re-appeared, as I can see from searching the web). If we knew the latest version where this problem was not, we would consider just going back to that version, instead of waiting for the bug to be fixed.
2) I do not have a sensible way of reproducing this error in a short time. It may take a few days of running our application in order for it to fail in this way. This is killing us (timewise) in testing possible solutions.

The latest kernel we had this reproduced with was 2.6.17.

Thanks a lot for your help. 
Misha.


>>> Baurzhan Ismagulov <ibr@radix50.net> 08/19/06 03:05AM >>>
Hello Misha,

On Fri, Aug 18, 2006 at 07:37:50PM -0700, Misha Sushchik wrote:
> I am writing to you because I found a post by you in a newsgroup that
> described improper error reporting by select(), reporting error 514.

So if you don't mind, I'm taking this to linux-kernel, please answer to
the list and Cc to me.


> We recently tried to upgrade our server from RedHat 7 to RHEL 4, with
> kernel version 2.6.9. Our CORBA-based communication now is halted now
> and then due to "unknown error 514" in select().

include/linux/errno.h says user space should never see this error code,
so this is a bug in your kernel. core_sys_select returns this code if a
signal is pending for the current process. You have the following
options:

* Test with the latest kernel. 2.6.9 is almost two years old.

* Ask RedHat to fix the problem in 2.6.9.

* Fix the problem yourself.

You may try applying something like the following to your current kernel
in order to understand how to reproduce the problem (untested):

diff -Naurp linux-2.6.orig/fs/select.c linux-2.6/fs/select.c
--- linux-2.6.orig/fs/select.c	2006-08-19 11:57:53.000000000 +0200
+++ linux-2.6/fs/select.c	2006-08-19 11:57:43.000000000 +0200
@@ -430,6 +430,8 @@ asmlinkage long sys_select(int n, fd_set
 		}
 	}
 
+	if (ret == -ERESTARTNOHAND)
+		BUG();
 	return ret;
 }
 
IIUC, this should print a backtrace every time the problem occurs.


With kind regards,
Baurzhan.

