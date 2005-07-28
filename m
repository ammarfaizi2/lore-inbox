Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVG1PGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVG1PGG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 11:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVG1PF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 11:05:59 -0400
Received: from imap.gmx.net ([213.165.64.20]:13508 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261534AbVG1PEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 11:04:25 -0400
Date: Thu, 28 Jul 2005 17:04:24 +0200 (MEST)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net, akpm@osdl.org
MIME-Version: 1.0
Subject: =?ISO-8859-1?Q?Broke_nice_range_for_RLIMIT_NICE?=
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <32710.1122563064@www32.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ingo,

I'm guessing that it was you that added the RLIMIT_NICE resource 
limit in 2.6.12.  (A passing note to all kernel developers: when 
making changes that affect userland-kernel interfaces, please 
send me a man-pages patch, or at least a notification of the 
change, so that some information makes its way into the manual 
pages).

I started documenting RLIMIT_NICE and then noticed an 
inconsistency between the use of this limit and the nice
value as manipulated by [sg]etpriority().

This is the documentation I've drafted for RLIMIT_NICE
in getrlimit.2:

   RLIMIT_NICE(since kernel 2.6.12)
      Specifies  a  ceiling  to  which  the process nice
      value  can  be  raised  using  setpriority(2)   or
      nice(2).  The actual ceiling for the nice value is
      calculated as  19 - rlim_cur.
                     ^^^^^^^^^^^^^

And recently I've redrafted the discussion of the nice value
in getpriority.2 and it now reads:

      Since kernel 1.3.43 Linux has  the  range  -20..19.
      Within  the kernel, nice values are actually repre-
      sented using the corresponding range  40..1  (since
      negative numbers are error codes) and these are the
      values employed by the setpriority and  getpriority
      system  calls.   The  glibc  wrapper  functions for
      these system calls handle the translations  between
      the  user-land  and  kernel  representations of the
      nice    value    according    to    the     formula
      user_nice = 20 - kernel_nice.
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In other words, there is an off-by-one mismatch between 
these two interfaces: RLIMIT_NICE is expecting to deal 
with values in the range 39..0, while [gs]etpriority() 
works with the range 40..1.

I suppose that glibc could paper over the cracks here in
a wrapper for getrlimit(), but it seems more sensible 
to make RLIMIT_NICE consistent with [gs]etpriority() --
i.e., change the RLIMIT_NICE interface in 2.6.13 before it 
sees wide use in userland.  What do you think?

Cheers,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  Grab the latest
tarball at ftp://ftp.win.tue.nl/pub/linux-local/manpages/
and grep the source files for 'FIXME'.
