Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbUDHLHG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 07:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUDHLHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 07:07:06 -0400
Received: from meyering.net1.nerim.net ([62.212.115.149]:54519 "EHLO
	elf.meyering.net") by vger.kernel.org with ESMTP id S261615AbUDHLHD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 07:07:03 -0400
To: Paul Eggert <eggert@CS.UCLA.EDU>
Cc: bug-coreutils@gnu.org, Andrew Morton <akpm@osdl.org>,
       Bruce Allen <ballen@gravity.phys.uwm.edu>, linux-kernel@vger.kernel.org,
       Andy Isaacson <adi@hexapodia.org>
Subject: Re: dd PATCH: add conv=direct
In-Reply-To: <87r7uzlzz7.fsf@penguin.cs.ucla.edu> (Paul Eggert's message of "Wed, 07 Apr 2004 23:56:28 -0700")
References: <Pine.GSO.4.21.0404071627530.9017-100000@dirac.phys.uwm.edu>
	<87r7uzlzz7.fsf@penguin.cs.ucla.edu>
From: Jim Meyering <jim@meyering.net>
Date: Thu, 08 Apr 2004 13:07:30 +0200
Message-ID: <85k70qsp71.fsf@pi.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Eggert <eggert@CS.UCLA.EDU> wrote:
> At the end of this message is a proposed patch to implement everything
> people other than myself have asked for so far, along with several
> other things since I was in the neighborhood.

Thanks for that nice patch!
I've applied it, and made these additional changes:

2004-04-08  Jim Meyering  <jim@meyering.net>

	* src/dd.c (set_fd_flags): Don't OR in -1 when fcntl fails.
	Rename parameter, flags, to avoid shadowing global.

Index: dd.c
===================================================================
RCS file: /fetish/cu/src/dd.c,v
retrieving revision 1.155
diff -u -p -r1.155 dd.c
--- a/dd.c	8 Apr 2004 10:22:05 -0000	1.155
+++ b/dd.c	8 Apr 2004 11:02:20 -0000
@@ -1017,12 +1017,12 @@ copy_with_unblock (char const *buf, size
    in FLAGS.  The file's name is NAME.  */
 
 static void
-set_fd_flags (int fd, int flags, char const *name)
+set_fd_flags (int fd, int add_flags, char const *name)
 {
-  if (flags)
+  if (add_flags)
     {
       int old_flags = fcntl (fd, F_GETFL);
-      int new_flags = old_flags | flags;
+      int new_flags = old_flags < 0 ? add_flags : (old_flags | add_flags);
       if (old_flags < 0
 	  || (new_flags != old_flags && fcntl (fd, F_SETFL, new_flags) == -1))
 	error (EXIT_FAILURE, errno, _("setting flags for %s"), quote (name));


