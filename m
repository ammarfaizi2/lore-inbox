Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVCLLmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVCLLmn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 06:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVCLLmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 06:42:43 -0500
Received: from mailfe03.swip.net ([212.247.154.65]:57825 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261674AbVCLLma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 06:42:30 -0500
X-T2-Posting-ID: icQHdNe7aEavrnKIz+aKnQ==
Subject: Capabilities across execve
From: Alexander Nyberg <alexn@dsv.su.se>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Content-Type: multipart/mixed; boundary="=-Ti4FV4AOprQBUIHW2kgM"
Date: Sat, 12 Mar 2005 12:42:28 +0100
Message-Id: <1110627748.2376.6.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ti4FV4AOprQBUIHW2kgM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This makes it possible for a root-task to pass capabilities to
nonroot-task across execve. The root-task needs to change it's
cap_inheritable mask and set prctl(PR_SET_KEEPCAPS, 1) to pass on
capabilities. 
At execve time the capabilities will be passed on to the new
nonroot-task and any non-inheritable effective and permitted
capabilities will be masked out.
The effective capability of the new nonroot-task will be set to the
maximum permitted.

>From here on the inheritable mask will be passed on unchanged to the new
tasks children unless told otherwise (effectively the complete
capability state is passed on).

With a small insert of prctl(PR_SET_KEEPCAPS, 1) into pam_cap.c at the
correct place this makes pam_cap work as expected. I'm also attaching a
test-case that tests capabilities across setuid => execve (makes the new
task inherit CAP_CHOWN).


Signed-off-by: Alexander Nyberg <alexn@dsv.su.se>

===== security/commoncap.c 1.15 vs edited =====
--- 1.15/security/commoncap.c	2005-01-11 02:29:23 +01:00
+++ edited/security/commoncap.c	2005-03-12 12:04:34 +01:00
@@ -111,13 +111,19 @@ void cap_capset_set (struct task_struct 
 
 int cap_bprm_set_security (struct linux_binprm *bprm)
 {
-	/* Copied from fs/exec.c:prepare_binprm. */
-
-	/* We don't have VFS support for capabilities yet */
-	cap_clear (bprm->cap_inheritable);
-	cap_clear (bprm->cap_permitted);
-	cap_clear (bprm->cap_effective);
+	struct task_struct *p = current;
 
+	/*
+	 * Mask out the non-inheritable capabilities.
+	 * Note: init has a zero mask of cap_inheritable, so a root-task will not
+	 * pass on any capabilities unless explicitly told to do so. If a non-zero
+	 * inheritable mask is passed to a positive uid task it will then pass on 
+	 * its inheritable mask to all children unless told otherwise.
+	 */
+	bprm->cap_permitted = cap_intersect(p->cap_permitted, p->cap_inheritable);
+	bprm->cap_effective = cap_intersect(p->cap_effective, p->cap_inheritable);
+	bprm->cap_inheritable = p->cap_inheritable;
+	
 	/*  To support inheritance of root-permissions and suid-root
 	 *  executables under compatibility mode, we raise all three
 	 *  capability sets for the file.
@@ -127,7 +133,7 @@ int cap_bprm_set_security (struct linux_
 	 */
 
 	if (!issecure (SECURE_NOROOT)) {
-		if (bprm->e_uid == 0 || current->uid == 0) {
+		if (bprm->e_uid == 0 || p->uid == 0) {
 			cap_set_full (bprm->cap_inheritable);
 			cap_set_full (bprm->cap_permitted);
 		}
@@ -139,13 +145,9 @@ int cap_bprm_set_security (struct linux_
 
 void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
 {
-	/* Derived from fs/exec.c:compute_creds. */
-	kernel_cap_t new_permitted, working;
+	kernel_cap_t new_permitted;
 
 	new_permitted = cap_intersect (bprm->cap_permitted, cap_bset);
-	working = cap_intersect (bprm->cap_inheritable,
-				 current->cap_inheritable);
-	new_permitted = cap_combine (new_permitted, working);
 
 	if (bprm->e_uid != current->uid || bprm->e_gid != current->gid ||
 	    !cap_issubset (new_permitted, current->cap_permitted)) {
@@ -166,14 +168,9 @@ void cap_bprm_apply_creds (struct linux_
 	current->suid = current->euid = current->fsuid = bprm->e_uid;
 	current->sgid = current->egid = current->fsgid = bprm->e_gid;
 
-	/* For init, we want to retain the capabilities set
-	 * in the init_task struct. Thus we skip the usual
-	 * capability rules */
-	if (current->pid != 1) {
-		current->cap_permitted = new_permitted;
-		current->cap_effective =
-		    cap_intersect (new_permitted, bprm->cap_effective);
-	}
+	current->cap_permitted = new_permitted;
+	current->cap_effective =
+			cap_intersect (new_permitted, bprm->cap_effective);
 
 	/* AUD: Audit candidate if current->cap_effective is set */
 
@@ -249,9 +246,9 @@ static inline void cap_emulate_setxuid (
 		cap_clear (current->cap_permitted);
 		cap_clear (current->cap_effective);
 	}
-	if (old_euid == 0 && current->euid != 0) {
+	if (old_euid == 0 && current->euid != 0 && !current->keep_capabilities)
 		cap_clear (current->cap_effective);
-	}
+
 	if (old_euid != 0 && current->euid == 0) {
 		current->cap_effective = current->cap_permitted;
 	}


--=-Ti4FV4AOprQBUIHW2kgM
Content-Disposition: attachment; filename=cap_test.c
Content-Type: text/x-csrc; name=cap_test.c; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/capability.h>
#include <sys/prctl.h>

struct caph {
	int version;
	int pid;
};

struct capd {
	__u32 effective;
	__u32 permitted;
	__u32 inheritable;
};

gid_t gid = 1000;
uid_t uid = 1000;


void printcap(char *str)
{
	int ret;
	struct caph caph;
	struct capd capd;
	
	memset(&capd, 0, sizeof(capd));	
	
	caph.version = 0x19980330;
	caph.pid = getpid();

	ret = capget(&caph, &capd);
	if (ret < 0)
		perror("capget");
	printf("%s: ", str);
	printf("eff:%u perm:%u inh:%u\n", capd.effective, capd.permitted, capd.inheritable);
}

void lower_uid()
{
	int ret;
	gid_t gidlist[1];
	
	gidlist[0] = gid;
	ret = setgroups(1, gidlist);
	if (ret < 0)
		perror("setgroups");
	if (setgid(gid))
		perror("setgid");
	if (setuid(uid))
		perror("setuid");
}

const char *bash[] = { "bash", NULL };

int main(int argc, char **argv)
{
	int ret;
	struct caph caph;
	struct capd capd;

	if (argc == 3) {
		uid = strtoul(argv[1], NULL, 0);
		gid = strtoul(argv[2], NULL, 0);
	} else {
		printf("Usage: \"./program uid gid\" where uid & gid\n");
		printf("are the ids you want to change to (then run bash)\n");
		exit(1);
	}

	printcap("caps when started");

	memset(&capd, 0, sizeof(capd));	

	caph.version = 0x19980330;
	caph.pid = getpid();

	ret = capget(&caph, &capd);
	if (ret < 0)
		perror("capget");
	
	capd.inheritable |= (1 << CAP_CHOWN);
	
	ret = capset(&caph, &capd);
	if (ret < 0)
		perror("capset");

	printf("new inheritable mask: %u\n", capd.inheritable);
	
	ret = prctl(PR_SET_KEEPCAPS, 1);
	if (ret)
		perror("prctl");
	
	lower_uid();

	printcap("after setuid");
        
	ret = execv("/bin/bash", bash);
	if (ret < 0)
		perror("execve");
		
	return 0;
}

--=-Ti4FV4AOprQBUIHW2kgM--

