Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751691AbWHSKF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbWHSKF5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 06:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbWHSKF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 06:05:57 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:9374 "EHLO
	mail.arcor.de") by vger.kernel.org with ESMTP id S1751292AbWHSKF5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 06:05:57 -0400
Date: Sat, 19 Aug 2006 12:05:50 +0200
From: Baurzhan Ismagulov <ibr@radix50.net>
To: linux-kernel@vger.kernel.org
Cc: msushchi@thermawave.com
Subject: Re: Help: error 514 in select()
Message-ID: <20060819100550.GA3238@radix50.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, msushchi@thermawave.com
References: <s4e61722.051@smtp.thermawave.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s4e61722.051@smtp.thermawave.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
