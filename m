Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbVJXHQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbVJXHQz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 03:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbVJXHQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 03:16:55 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:4066 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751056AbVJXHQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 03:16:55 -0400
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: linux-kernel@vger.kernel.org
Subject: [patch] zap broken heuristic in init/main.c
Date: Mon, 24 Oct 2005 02:16:49 -0500
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510240216.49358.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Landley <rob@landley.net>
Signed-off-by Rob landley <rob@landley.net>

Unknown linux kernel command line arguments are passed through as arguments to
init, unless they have a period in them.
---
I'm trying to run a shell script inside User Mode Linux.  I have an init
wrapper that forks and attaches the child process to /dev/tty0, then waits for
the child to exit.  (I need to do this for ctrl-c to work, pid 1 has kill
blocked and /dev/console has no controlling tty.)  This wrapper uses the
standard execvp(argv[1],argv+1) trick from detach/nohup/setsid and so on.

It worked until I tried to run the production shell script, the name of which
includes the build stage (which has a period in it), and like all the build
shell scripts it ends in .sh.  I get this:

  UML running in SKAS0 mode
  Checking PROT_EXEC mmap in /tmp...OK
  Unknown boot option
    `/home/landley/newbuild/firmware-build/sources/scripts/1.0-tools-umlsetup.sh':
    ignoring
  System halted.

Which sucks.

--- linux-old/init/main.c 2005-09-09 21:42:58.000000000 -0500
+++ linux-new/init/main.c 2005-10-24 02:07:37.683498720 -0500
@@ -242,15 +242,6 @@
  if (obsolete_checksetup(param))
   return 0;
 
- /*
-  * Preemptive maintenance for "why didn't my mispelled command
-  * line work?"
-  */
- if (strchr(param, '.') && (!val || strchr(param, '.') < val)) {
-  printk(KERN_ERR "Unknown boot option `%s': ignoring\n", param);
-  return 0;
- }
-
  if (panic_later)
   return 0;
 
