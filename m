Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266922AbRGMCcd>; Thu, 12 Jul 2001 22:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266924AbRGMCcY>; Thu, 12 Jul 2001 22:32:24 -0400
Received: from mel227.freeonline.com.au ([203.76.6.227]:47283 "EHLO
	freeonline.com.au") by vger.kernel.org with ESMTP
	id <S266922AbRGMCcL>; Thu, 12 Jul 2001 22:32:11 -0400
Date: Fri, 13 Jul 2001 02:33:30 +0000
From: Andrew Wansink <andy@sharinga.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: RLIM_INFINITY support for RLIMIT_NOFILE (patch)
Message-ID: <20010713023329.A7928@freeonline.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day all, I recently found that the linux kernel does not support setting
a process' RLIMIT_NOFILE limits to the #define RLIM_INFINITY.  My patch will
add such support by setting the limit to the maximum supported by the kernel
when a call to set a limit to RLIM_INFINITY is made.

I understand that the semantics do not match exactly but all kernels are limited
by real hard limits and/or available memory, I think that it is therefore 
acceptable to have a call to set a limit to RLIM_INFINITY actually set the 
limit to the maximum extent supported by the kernel.

Patch by: Andrew Wansink & Chris Leishman
Against:  Linux 2.4.6
Date:     (Friday the 13th) 13th July 2001
File:     kernel/sys.c

--- sys.c.orig	Fri Jul 13 02:03:19 2001
+++ sys.c	Fri Jul 13 01:41:57 2001
@@ -1119,6 +1119,10 @@
 		return -EINVAL;
 	if(copy_from_user(&new_rlim, rlim, sizeof(*rlim)))
 		return -EFAULT;
+	if (new_rlim.rlim_cur == RLIM_INFINITY)
+		new_rlim.rlim_cur = NR_OPEN;
+	if (new_rlim.rlim_max == RLIM_INFINITY)
+		new_rlim.rlim_max = NR_OPEN;
 	if (new_rlim.rlim_cur < 0 || new_rlim.rlim_max < 0)
 		return -EINVAL;
 	old_rlim = current->rlim + resource;
