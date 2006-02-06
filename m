Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWBFTlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWBFTlg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWBFTlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:41:36 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36333 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932321AbWBFTle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:41:34 -0500
To: <linux-kernel@vger.kernel.org>
Cc: <vserver@list.linux-vserver.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: [RFC][PATCH 06/20] cad_pid: Fixup the cad_pid users to assume it is
 in the initial process id namespace.
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com>
	<m17j88mg8l.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 12:39:02 -0700
In-Reply-To: <m17j88mg8l.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Mon, 06 Feb 2006 12:36:42 -0700")
Message-ID: <m13biwmg4p.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Having the kernel memorize pids of running processes is ugly.  Especially if
those processes are allowed to exit.  So we don't introduce any lifetime issues
or any other weird uglyness and simply insist that the cad_pid is always
interpreted with respect to the initial process id namespace.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 drivers/parisc/power.c |    3 ++-
 kernel/sys.c           |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

f343da178ee420b5b35a7fa43cc7995f47024004
diff --git a/drivers/parisc/power.c b/drivers/parisc/power.c
index 54b2b7f..fbf14d9 100644
--- a/drivers/parisc/power.c
+++ b/drivers/parisc/power.c
@@ -45,6 +45,7 @@
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
+#include <linux/pspace.h>
 
 #include <asm/pdc.h>
 #include <asm/io.h>
@@ -86,7 +87,7 @@
 static void deferred_poweroff(void *dummy)
 {
 	extern int cad_pid;	/* from kernel/sys.c */
-	if (kill_proc(cad_pid, SIGINT, 1)) {
+	if (kill_proc(&init_pspace, cad_pid, SIGINT, 1)) {
 		/* just in case killing init process failed */
 		machine_power_off();
 	}
diff --git a/kernel/sys.c b/kernel/sys.c
index bd594c3..d9fcc0e 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -581,7 +581,7 @@ void ctrl_alt_del(void)
 	if (C_A_D)
 		schedule_work(&cad_work);
 	else
-		kill_proc(cad_pid, SIGINT, 1);
+		kill_proc(&init_pspace, cad_pid, SIGINT, 1);
 }
 	
 
-- 
1.1.5.g3480

