Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUDHUZj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 16:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUDHUXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 16:23:07 -0400
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:15067 "EHLO kiwi.cs.ucla.edu")
	by vger.kernel.org with ESMTP id S262866AbUDHUWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 16:22:10 -0400
To: bug-coreutils@gnu.org
Cc: Andy Isaacson <adi@hexapodia.org>, Andrew Morton <akpm@osdl.org>,
       Bruce Allen <ballen@gravity.phys.uwm.edu>, linux-kernel@vger.kernel.org
Subject: dd patch to remove noctty
References: <Pine.GSO.4.21.0404071627530.9017-100000@dirac.phys.uwm.edu>
	<87r7uzlzz7.fsf@penguin.cs.ucla.edu> <87vfka30cm.fsf@ceramic.fifi.org>
From: Paul Eggert <eggert@CS.UCLA.EDU>
Date: Thu, 08 Apr 2004 13:20:57 -0700
In-Reply-To: <87vfka30cm.fsf@ceramic.fifi.org> (Philippe Troin's message of
 "08 Apr 2004 09:23:21 -0700")
Message-ID: <87ekqyw79y.fsf_-_@penguin.cs.ucla.edu>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Troin <phil@fifi.org> writes:

> noctty definitely seems overkill... I can't see why dd would ever want
> to open a file without O_NOCTTY.

Good point; it's just a confusion for the user.  Here's a patch to
cause dd to always use O_NOCTTY.  If someone ever needs it the other
way (not likely) I suppose we can add a "ctty" flag.

2004-04-08  Paul Eggert  <eggert@cs.ucla.edu>

	* NEWS: Remove noctty flag from dd.  Suggested by Philippe Troin.
	* doc/coreutils.texi (dd invocation): Likewise.
	* src/shred.c (O_NOCTTY): Remove redundant decl.
	* src/dd.c (flags, usage): Remove noctty flag.
	(main): Always use O_NOCTTY when opening files.

Index: NEWS
===================================================================
RCS file: /home/meyering/coreutils/cu/NEWS,v
retrieving revision 1.199
diff -p -u -r1.199 NEWS
--- NEWS	8 Apr 2004 10:25:27 -0000	1.199
+++ NEWS	8 Apr 2004 20:04:42 -0000
@@ -24,7 +24,6 @@ GNU coreutils NEWS                      
     sync      likewise, but also for metadata
     nonblock  use non-blocking I/O
     nofollow  do not follow symlinks
-    noctty    do not assign controlling terminal from file
 
   stty now provides support (iutf8) for setting UTF-8 input mode.
 
Index: doc/coreutils.texi
===================================================================
RCS file: /home/meyering/coreutils/cu/doc/coreutils.texi,v
retrieving revision 1.176
diff -p -u -r1.176 coreutils.texi
--- doc/coreutils.texi	8 Apr 2004 15:35:40 -0000	1.176
+++ doc/coreutils.texi	8 Apr 2004 20:05:38 -0000
@@ -6666,18 +6666,12 @@ Use non-blocking I/O.
 @cindex symbolic links, following
 Do not follow symbolic links.
 
-@item noctty
-@opindex noctty
-@cindex controlling terminal
-Do not assign the file to be a controlling terminal for @command{dd}.
-This has no effect when the file is not a terminal.
-
 @end table
 
 These flags are not supported on all systems, and @samp{dd} rejects
 attempts to use them when they are not supported.  When reading from
-standard input or writing to standard output, the @samp{nofollow} and
-@samp{noctty} flags should not be specified, and the other flags
+standard input or writing to standard output, the @samp{nofollow} flag
+should not be specified, and the other flags
 (e.g., @samp{nonblock}) can affect how other processes behave with the
 affected file descriptors, even after @command{dd} exits.
 
Index: src/shred.c
===================================================================
RCS file: /home/meyering/coreutils/cu/src/shred.c,v
retrieving revision 1.84
diff -p -u -r1.84 shred.c
--- src/shred.c	21 Jan 2004 23:39:34 -0000	1.84
+++ src/shred.c	8 Apr 2004 20:04:45 -0000
@@ -110,10 +110,6 @@
 #include "quotearg.h"		/* For quotearg_colon */
 #include "quote.h"		/* For quotearg_colon */
 
-#ifndef O_NOCTTY
-# define O_NOCTTY 0  /* This is a very optional frill */
-#endif
-
 #define DEFAULT_PASSES 25	/* Default */
 
 /* How many seconds to wait before checking whether to output another
--- src/dd.c-bak	Thu Apr  8 12:17:02 2004
+++ src/dd.c	Thu Apr  8 13:18:30 2004
@@ -192,7 +192,6 @@ static struct symbol_value const flags[]
   {"append",	O_APPEND},
   {"direct",	O_DIRECT},
   {"dsync",	O_DSYNC},
-  {"noctty",	O_NOCTTY},
   {"nofollow",	O_NOFOLLOW},
   {"nonblock",	O_NONBLOCK},
   {"sync",	O_SYNC},
@@ -384,9 +383,6 @@ Each FLAG symbol may be:\n\
 	fputs (_("  nonblock  use non-blocking I/O\n"), stdout);
       if (O_NOFOLLOW)
 	fputs (_("  nofollow  do not follow symlinks\n"), stdout);
-      if (O_NOCTTY)
-	fputs (_("  noctty    do not assign controlling terminal from file\n"),
-	       stdout);
       fputs (_("\
 \n\
 Note that sending a SIGUSR1 signal to a running `dd' process makes it\n\
@@ -1300,7 +1296,8 @@ main (int argc, char **argv)
     }
   else
     {
-      if (open_fd (STDIN_FILENO, input_file, O_RDONLY | input_flags, 0) < 0)
+      int opts = input_flags | O_NOCTTY;
+      if (open_fd (STDIN_FILENO, input_file, O_RDONLY | opts, 0) < 0)
 	error (EXIT_FAILURE, errno, _("opening %s"), quote (input_file));
     }
 
@@ -1313,7 +1310,7 @@ main (int argc, char **argv)
     {
       mode_t perms = S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH;
       int opts
-	= (output_flags
+	= (output_flags | O_NOCTTY
 	   | (conversions_mask & C_NOCREAT ? 0 : O_CREAT)
 	   | (conversions_mask & C_EXCL ? O_EXCL : 0)
 	   | (seek_records || (conversions_mask & C_NOTRUNC) ? 0 : O_TRUNC));
