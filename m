Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbUDHVd6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 17:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbUDHVd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 17:33:58 -0400
Received: from meyering.net1.nerim.net ([62.212.115.149]:3627 "EHLO
	elf.meyering.net") by vger.kernel.org with ESMTP id S262499AbUDHVd4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 17:33:56 -0400
To: Paul Eggert <eggert@CS.UCLA.EDU>
Cc: bug-coreutils@gnu.org, Andrew Morton <akpm@osdl.org>,
       Bruce Allen <ballen@gravity.phys.uwm.edu>, linux-kernel@vger.kernel.org,
       Andy Isaacson <adi@hexapodia.org>
Subject: Re: dd PATCH: add conv=direct
In-Reply-To: <87vfkaw9i9.fsf@penguin.cs.ucla.edu> (Paul Eggert's message of "Thu, 08 Apr 2004 12:32:46 -0700")
References: <Pine.GSO.4.21.0404071627530.9017-100000@dirac.phys.uwm.edu>
	<87r7uzlzz7.fsf@penguin.cs.ucla.edu> <85k70qsp71.fsf@pi.meyering.net>
	<87vfkaw9i9.fsf@penguin.cs.ucla.edu>
From: Jim Meyering <jim@meyering.net>
Date: Thu, 08 Apr 2004 23:34:25 +0200
Message-ID: <85isgaqhlq.fsf@pi.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Eggert <eggert@CS.UCLA.EDU> wrote:
> Jim Meyering <jim@meyering.net> writes:
>
>> 2004-04-08  Jim Meyering  <jim@meyering.net>
>>
>> 	* src/dd.c (set_fd_flags): Don't OR in -1 when fcntl fails.
>
> Doesn't that fix generate worse code in the usual case, since it
> causes two conditional branches instead of one?
>
> How about this further patch?  It relies on common subexpression
> elimination, but that's common these days.
>
> 2004-04-08  Paul Eggert  <eggert@twinsun.com>
>
> 	* src/dd.c (set_fd_flags): Don't test old_flags < 0 twice.

I see your point.  Thanks for the comment fix.
I've gone ahead and reverted my change,
since I think your original code is a little more
readable than the more-efficient-when-fcntl-fails code
that you're proposing.

	(set_fd_flags): Undo part of today's change: it's a little
	cleaner -- and more efficient in the common case -- to go
	ahead and OR in the -1 when fcntl fails.

Index: src/dd.c
===================================================================
RCS file: /fetish/cu/src/dd.c,v
retrieving revision 1.158
retrieving revision 1.159
diff -u -p -u -r1.158 -r1.159
--- a/src/dd.c	8 Apr 2004 21:26:28 -0000	1.158
+++ b/src/dd.c	8 Apr 2004 21:30:18 -0000	1.159
@@ -1014,7 +1014,7 @@ copy_with_unblock (char const *buf, size
 }
 
 /* Set the file descriptor flags for FD that correspond to the nonzero bits
-   in FLAGS.  The file's name is NAME.  */
+   in ADD_FLAGS.  The file's name is NAME.  */
 
 static void
 set_fd_flags (int fd, int add_flags, char const *name)
@@ -1022,7 +1022,7 @@ set_fd_flags (int fd, int add_flags, cha
   if (add_flags)
     {
       int old_flags = fcntl (fd, F_GETFL);
-      int new_flags = old_flags < 0 ? add_flags : (old_flags | add_flags);
+      int new_flags = old_flags | add_flags;
       if (old_flags < 0
 	  || (new_flags != old_flags && fcntl (fd, F_SETFL, new_flags) == -1))
 	error (EXIT_FAILURE, errno, _("setting flags for %s"), quote (name));
