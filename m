Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422759AbWKHT7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422759AbWKHT7W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422764AbWKHT7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:59:21 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38313 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422759AbWKHT7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:59:20 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Andrew Morton" <akpm@osdl.org>
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Jesper Juhl" <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       "Andi Kleen" <ak@suse.de>, alan@redhat.com,
       "Russell King" <rmk+lkml@arm.linux.org.uk>,
       "Jakub Jelinek" <jakub@redhat.com>, "Mike Galbraith" <efault@gmx.de>,
       "Albert Cahalan" <acahalan@gmail.com>,
       "Bill Nottingham" <notting@redhat.com>,
       "Marco Roeland" <marco.roeland@xs4all.nl>,
       "Michael Kerrisk" <mtk-manpages@gmx.net>
Subject: [PATCH] sysctl:  Undeprecate sys_sysctl (take 2)
References: <m1zmb13gsl.fsf@ebiederm.dsl.xmission.com>
	<9a8748490611081110m4cc62c1bp3a36aba3fc314e56@mail.gmail.com>
Date: Wed, 08 Nov 2006 12:58:35 -0700
In-Reply-To: <9a8748490611081110m4cc62c1bp3a36aba3fc314e56@mail.gmail.com>
	(Jesper Juhl's message of "Wed, 8 Nov 2006 20:10:30 +0100")
Message-ID: <m1ejsd3e38.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The basic issue is that despite have been ``deprecated'' and
warned about as a very bad thing in the man pages since it's
inception there are a few real users of sys_sysctl.  It was
my assumption that because sysctl had been ``deprecated''
for all of 2.6 there would be no user space users by this
point, so I initially gave sys_sysctl a very short deprecation
period.

Now that I know there are a few real users the only sane way
to proceed with deprecation is to push the time limit out
to a year or two work and work with distributions that
have big testing pools like fedora core to find these last
remaining users.

Which means that the sys_sysctl interface needs to be maintained
in the meantime.

Since I have provided a technical measure that allows us
to add new sysctl entries without reserving more binary
numbers I believe that is enough to fix the sys_sysctl
binary interface maintenance problems (I.e. don't grow it
any more).

Since the sys_sysctl implementation needs to stay around for
a while and the worst of the maintenance issues that caused us
to occassionally break the ABI have been addressed I don't
see any advantage in continuing with the removal of sys_sysctl.

With committing to maintain sys_sysctl we get all of the
advantages of a fast interface for anything that needs
it.  Currently sys_sysctl is about 5x faster than /proc/sys,
for the same string data.

The Kconfig help text is now also fixed.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 Documentation/feature-removal-schedule.txt |   12 ------------
 init/Kconfig                               |   19 +++++++++----------
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 1ac3c74..d52c4aa 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -53,18 +53,6 @@ Who:	Mauro Carvalho Chehab <mchehab@brtu
 
 ---------------------------
 
-What:	sys_sysctl
-When:	January 2007
-Why:	The same information is available through /proc/sys and that is the
-	interface user space prefers to use. And there do not appear to be
-	any existing user in user space of sys_sysctl.  The additional
-	maintenance overhead of keeping a set of binary names gets
-	in the way of doing a good job of maintaining this interface.
-
-Who:	Eric Biederman <ebiederm@xmission.com>
-
----------------------------
-
 What:	PCMCIA control ioctl (needed for pcmcia-cs [cardmgr, cardctl])
 When:	November 2005
 Files:	drivers/pcmcia/: pcmcia_ioctl.c
diff --git a/init/Kconfig b/init/Kconfig
index c8b2624..ffe945a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -304,20 +304,19 @@ config UID16
 
 config SYSCTL_SYSCALL
 	bool "Sysctl syscall support" if EMBEDDED
-	default n
+	default y
 	select SYSCTL
 	---help---
-	  Enable the deprecated sysctl system call.  sys_sysctl uses
-	  binary paths that have been found to be a major pain to maintain
-	  and use.  The interface in /proc/sys is now the primary and what
-	  everyone uses.
+	  sys_sysctl uses binary paths that have been found challenging
+	  to properly maintain and use.  The interface in /proc/sys
+	  using paths with ascii names is now the primary path to this
+	  information. 
 
-	  Nothing has been using the binary sysctl interface for some
-	  time now so nothing should break if you disable sysctl syscall
-	  support, and your kernel will get marginally smaller.
+	  Almost nothing using the binary sysctl interface so if you are
+	  trying to save some space it is probably safe to disable this,
+	  making your kernel marginally smaller.
 
-	  Unless you have an application that uses the sys_sysctl interface
- 	  you should probably say N here.
+	  If unsure say Y here.
 
 config KALLSYMS
 	 bool "Load all symbols for debugging/kksymoops" if EMBEDDED
-- 
1.4.2.rc3.g7e18e-dirty

