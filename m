Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWBFT3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWBFT3j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWBFT3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:29:39 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1773 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932151AbWBFT3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:29:38 -0500
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
Subject: [RFC][PATCH 02/20] pspace: The parent process id of pid 1 is always
 0.
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 12:27:08 -0700
In-Reply-To: <m1vevsmgvz.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
 message of "Mon, 06 Feb 2006 12:22:40 -0700")
Message-ID: <m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Force the parent process id of pid == 1 to always be 0.  Force
this for nested pspaces.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 arch/alpha/kernel/entry.S |    3 +++
 kernel/timer.c            |    2 ++
 2 files changed, 5 insertions(+), 0 deletions(-)

bec203c8a3e7bec5e3bee8086361caffa71ad685
diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
index 7af15bf..38996ab 100644
--- a/arch/alpha/kernel/entry.S
+++ b/arch/alpha/kernel/entry.S
@@ -891,6 +891,9 @@ sys_getxpid:
 	cmpeq	$4, $5, $5
 	beq	$5, 1b
 #endif
+	cmpeq	$0, 1, $5
+	cmoveq	$5, 0, $1
+	
 	stq	$1, 80($sp)
 	ret
 .end sys_getxpid
diff --git a/kernel/timer.c b/kernel/timer.c
index 4f1cb0a..bae17fb 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -987,6 +987,8 @@ asmlinkage long sys_getppid(void)
 #endif
 		break;
 	}
+	if (current->tgid == 1)
+		pid = 0;
 	return pid;
 }
 
-- 
1.1.5.g3480

