Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUDHTdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 15:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbUDHTdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 15:33:12 -0400
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:3286 "EHLO kiwi.cs.ucla.edu")
	by vger.kernel.org with ESMTP id S262356AbUDHTdG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:33:06 -0400
To: Jim Meyering <jim@meyering.net>
Cc: bug-coreutils@gnu.org, Andrew Morton <akpm@osdl.org>,
       Bruce Allen <ballen@gravity.phys.uwm.edu>, linux-kernel@vger.kernel.org,
       Andy Isaacson <adi@hexapodia.org>
Subject: Re: dd PATCH: add conv=direct
References: <Pine.GSO.4.21.0404071627530.9017-100000@dirac.phys.uwm.edu>
	<87r7uzlzz7.fsf@penguin.cs.ucla.edu> <85k70qsp71.fsf@pi.meyering.net>
From: Paul Eggert <eggert@CS.UCLA.EDU>
Date: Thu, 08 Apr 2004 12:32:46 -0700
In-Reply-To: <85k70qsp71.fsf@pi.meyering.net> (Jim Meyering's message of
 "Thu, 08 Apr 2004 13:07:30 +0200")
Message-ID: <87vfkaw9i9.fsf@penguin.cs.ucla.edu>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Meyering <jim@meyering.net> writes:

> 2004-04-08  Jim Meyering  <jim@meyering.net>
>
> 	* src/dd.c (set_fd_flags): Don't OR in -1 when fcntl fails.

Doesn't that fix generate worse code in the usual case, since it
causes two conditional branches instead of one?

How about this further patch?  It relies on common subexpression
elimination, but that's common these days.

2004-04-08  Paul Eggert  <eggert@twinsun.com>

	* src/dd.c (set_fd_flags): Don't test old_flags < 0 twice.

Index: src/dd.c
===================================================================
RCS file: /home/meyering/coreutils/cu/src/dd.c,v
retrieving revision 1.157
diff -p -u -r1.157 dd.c
--- src/dd.c	8 Apr 2004 15:25:39 -0000	1.157
+++ src/dd.c	8 Apr 2004 19:17:02 -0000
@@ -1014,7 +1014,7 @@ copy_with_unblock (char const *buf, size
 }
 
 /* Set the file descriptor flags for FD that correspond to the nonzero bits
-   in FLAGS.  The file's name is NAME.  */
+   in ADD_FLAGS.  The file's name is NAME.  */
 
 static void
 set_fd_flags (int fd, int add_flags, char const *name)
@@ -1022,9 +1022,9 @@ set_fd_flags (int fd, int add_flags, cha
   if (add_flags)
     {
       int old_flags = fcntl (fd, F_GETFL);
-      int new_flags = old_flags < 0 ? add_flags : (old_flags | add_flags);
       if (old_flags < 0
-	  || (new_flags != old_flags && fcntl (fd, F_SETFL, new_flags) == -1))
+	  || (old_flags != (old_flags | add_flags)
+	      && fcntl (fd, F_SETFL, old_flags | add_flags) == -1))
 	error (EXIT_FAILURE, errno, _("setting flags for %s"), quote (name));
     }
 }
