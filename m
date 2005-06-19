Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVFSHvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVFSHvC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 03:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVFSHvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 03:51:02 -0400
Received: from njord.oit.pdx.edu ([131.252.122.32]:24520 "EHLO
	njord.oit.pdx.edu") by vger.kernel.org with ESMTP id S261272AbVFSHux
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 03:50:53 -0400
To: Kai Germaschewski <kai@germaschewski.name>,
       Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: PATCH Makefile, Make 'cscope -q' play well with cscope.el
From: Karl Hegbloom <hegbloom@pdx.edu>
Date: Sun, 19 Jun 2005 00:50:47 -0700
Message-ID: <87br62hjjc.fsf@journeyhawk.karlheg.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LinuxVersion: 2.6-git 2005/06/19

I tried the Linux Makefile 'make cscope' target, and found that the
generated database is not compatible with 'cscope.el' under XEmacs.
The thing is that 'cscope.el' does not allow setting the command line
options to the 'cscope' commands it runs, and it errors with a message
about the options not matching the ones used to generate the index.

It turns out the cscope designers already thought of this.  The
options can be written into the "cscope.files".  The included patch
moves the "-q" and "-k" options from the 'cmd_cscope' to the
'cmd_cscope-file', echoing them into the top of the files listing.

Now the index is generated with the "-q" option, and when 'cscope.el'
performs it's search, it uses that argument as well.  Lookups are fast
and everyone is happy.


diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -1173,10 +1173,10 @@ define all-sources
 endef
 
 quiet_cmd_cscope-file = FILELST cscope.files
-      cmd_cscope-file = $(all-sources) > cscope.files
+      cmd_cscope-file = (echo \-k; echo \-q; $(all-sources)) > cscope.files
 
 quiet_cmd_cscope = MAKE    cscope.out
-      cmd_cscope = cscope -k -b -q
+      cmd_cscope = cscope -b
 
 cscope: FORCE
 	$(call cmd,cscope-file)


I sent a previous patch for this, but it is wrong, since I had placed
the 'echo' statements directly inside of 'all-sources'.  If
'all-sources' is used anyplace else in the Makefile, that would lead
to file not found errors.  This patch corrects that mistake.


[ I am not currently a subscriber to LKML. ]
-- 
Karl Hegbloom <hegbloom@pdx.edu>
