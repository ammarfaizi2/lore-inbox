Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTKVEm1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 23:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTKVEm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 23:42:27 -0500
Received: from CPE-144-136-188-60.sa.bigpond.net.au ([144.136.188.60]:64009
	"EHLO bubble.modra.org") by vger.kernel.org with ESMTP
	id S262001AbTKVEmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 23:42:24 -0500
Date: Sat, 22 Nov 2003 15:12:21 +1030
From: Alan Modra <amodra@bigpond.net.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
       bug-binutils@gnu.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ionice kills vanilla 2.6.0-test9 was [Re: [PATCH] cfq + io priorities (fwd)]
Message-ID: <20031122044221.GN2900@bubble.sa.bigpond.net.au>
References: <Pine.LNX.4.44.0311211439120.13789-100000@home.osdl.org> <Pine.LNX.4.44.0311211455510.13789-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311211455510.13789-100000@home.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 21, 2003 at 03:05:23PM -0800, Linus Torvalds wrote:
> So it definitely _does_ work in some versions, and the bug appears to be 
> new to binutils 2.14, with 2.13 doing the right thing.
> 
> You can trivially see if with a simple assembly file like
> 
> 	start:
> 		.long 1,2,3,a
> 	a=(.-start)/4

Broken with http://sources.redhat.com/ml/binutils/2003-04/msg00412.html
and http://sources.redhat.com/ml/binutils/2003-04/msg00414.html.
That '/' is being treated as a start of line comment char, thus trimming
the rest of the line.

I think gas/app.c:do_scrub_chars is such an awful mess that it's
impossible to get right.  Needs to be tossed out and rewritten.  The
fundamental problem is that you can't track which component of an
assember input line you're preprocessing without more information on the
particular target syntax.  And most of the current complexity is just
for deciding whether to remove whitespace!  That at least needs to go.

For now, I'm reverting HJ's patches and including your testcase in
the gas testsuite.

gas/ChangeLog
	* app.c (do_scrub_chars): Revert 2003-04-23 and 2003-04-22.

gas/testsuite/ChangeLog
	* gas/i386/divide.s: New.
	* gas/i386/divide.d: New.
	* gas/i386/i386.exp (gas_32_check): Run it.

Index: app.c
===================================================================
RCS file: /cvs/src/src/gas/app.c,v
retrieving revision 1.26
diff -u -p -r1.26 app.c
--- app.c	21 Nov 2003 01:52:16 -0000	1.26
+++ app.c	22 Nov 2003 04:24:01 -0000
@@ -1308,13 +1308,11 @@ do_scrub_chars (int (*get) (char *, int)
 	  /* Some relatively `normal' character.  */
 	  if (state == 0)
 	    {
-	      if (IS_SYMBOL_COMPONENT (ch))
-		state = 11;	/* Now seeing label definition.  */
+	      state = 11;	/* Now seeing label definition.  */
 	    }
 	  else if (state == 1)
 	    {
-	      if (IS_SYMBOL_COMPONENT (ch))
-		state = 2;	/* Ditto.  */
+	      state = 2;	/* Ditto.  */
 	    }
 	  else if (state == 9)
 	    {
Index: testsuite/gas/i386/divide.d
===================================================================
RCS file: testsuite/gas/i386/divide.d
diff -N testsuite/gas/i386/divide.d
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ testsuite/gas/i386/divide.d	22 Nov 2003 04:41:09 -0000
@@ -0,0 +1,8 @@
+#objdump: -s
+#name: i386 divide
+
+.*: +file format .*
+
+Contents of section .*
+ 0000 01000000 02000000 03000000 04000000 .*
+ 0010 05000000 .*
Index: testsuite/gas/i386/divide.s
===================================================================
RCS file: testsuite/gas/i386/divide.s
diff -N testsuite/gas/i386/divide.s
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ testsuite/gas/i386/divide.s	22 Nov 2003 04:41:09 -0000
@@ -0,0 +1,4 @@
+start:
+ .long 1,2,3,a,b
+ a=(.-start)/4-1
+b=(.-start)/4
Index: testsuite/gas/i386/i386.exp
===================================================================
RCS file: /cvs/src/src/gas/testsuite/gas/i386/i386.exp,v
retrieving revision 1.19
diff -u -p -r1.19 i386.exp
--- testsuite/gas/i386/i386.exp	23 Jun 2003 20:15:33 -0000	1.19
+++ testsuite/gas/i386/i386.exp	22 Nov 2003 04:41:09 -0000
@@ -57,6 +57,7 @@ if [expr ([istarget "i*86-*-*"] ||  [ist
     run_dump_test "pcrel"
     run_dump_test "sub"
     run_dump_test "prescott"
+    run_dump_test "divide"
 
     # PIC is only supported on ELF targets.
     if { ([istarget "*-*-elf*"] || [istarget "*-*-linux*"] )

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
