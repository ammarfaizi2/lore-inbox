Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbVDOVTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVDOVTo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 17:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbVDOVTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 17:19:44 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:10175 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S261973AbVDOVTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 17:19:37 -0400
Subject: [PATCH] SELinux:  fix deadlock on dcache lock
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 15 Apr 2005 17:10:11 -0400
Message-Id: <1113599411.3810.165.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-14) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a deadlock on the dcache lock detected during testing
at IBM by moving the logging of the current executable information
from the SELinux avc_audit function to audit_log_exit (via an
audit_log_task_info helper) for processing upon syscall exit.  For
consistency, the patch also removes the logging of other task-related
information from avc_audit, deferring handling to audit_log_exit
instead.  This allows simplification of the avc_audit code, allows the
exe information to be obtained more reliably, always includes the comm
information (useful for scripts), and avoids including bogus task
information for checks performed from irq or softirq.  Please apply.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by:  James Morris <jmorris@redhat.com>

--

 kernel/auditsc.c       |   28 ++++++++++++++++++++++++++++
 security/selinux/avc.c |   34 ----------------------------------
 2 files changed, 28 insertions(+), 34 deletions(-)

===== kernel/auditsc.c 1.10 vs edited =====
--- 1.10/kernel/auditsc.c	2005-03-17 11:33:20 -05:00
+++ edited/kernel/auditsc.c	2005-04-15 09:22:15 -04:00
@@ -610,6 +610,33 @@
 		printk(KERN_ERR "audit: freed %d contexts\n", count);
 }
 
+static void audit_log_task_info(struct audit_buffer *ab)
+{
+	char name[sizeof(current->comm)];
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+
+	get_task_comm(name, current);
+	audit_log_format(ab, " comm=%s", name);
+
+	if (!mm)
+		return;
+
+	down_read(&mm->mmap_sem);
+	vma = mm->mmap;
+	while (vma) {
+		if ((vma->vm_flags & VM_EXECUTABLE) &&
+		    vma->vm_file) {
+			audit_log_d_path(ab, "exe=",
+					 vma->vm_file->f_dentry,
+					 vma->vm_file->f_vfsmnt);
+			break;
+		}
+		vma = vma->vm_next;
+	}
+	up_read(&mm->mmap_sem);
+}
+
 static void audit_log_exit(struct audit_context *context)
 {
 	int i;
@@ -639,6 +666,7 @@
 		  context->gid,
 		  context->euid, context->suid, context->fsuid,
 		  context->egid, context->sgid, context->fsgid);
+	audit_log_task_info(ab);
 	audit_log_end(ab);
 	while (context->aux) {
 		struct audit_aux_data *aux;
===== security/selinux/avc.c 1.23 vs edited =====
--- 1.23/security/selinux/avc.c	2005-03-28 17:21:18 -05:00
+++ edited/security/selinux/avc.c	2005-04-15 09:22:16 -04:00
@@ -532,7 +532,6 @@
                u16 tclass, u32 requested,
                struct av_decision *avd, int result, struct avc_audit_data *a)
 {
-	struct task_struct *tsk = current;
 	struct inode *inode = NULL;
 	u32 denied, audited;
 	struct audit_buffer *ab;
@@ -556,39 +555,6 @@
 	audit_log_format(ab, "avc:  %s ", denied ? "denied" : "granted");
 	avc_dump_av(ab, tclass,audited);
 	audit_log_format(ab, " for ");
-	if (a && a->tsk)
-		tsk = a->tsk;
-	if (tsk && tsk->pid) {
-		struct mm_struct *mm;
-		struct vm_area_struct *vma;
-		audit_log_format(ab, " pid=%d", tsk->pid);
-		if (tsk == current)
-			mm = current->mm;
-		else
-			mm = get_task_mm(tsk);
-		if (mm) {
-			if (down_read_trylock(&mm->mmap_sem)) {
-				vma = mm->mmap;
-				while (vma) {
-					if ((vma->vm_flags & VM_EXECUTABLE) &&
-					    vma->vm_file) {
-						audit_log_d_path(ab, "exe=",
-							vma->vm_file->f_dentry,
-							vma->vm_file->f_vfsmnt);
-						break;
-					}
-					vma = vma->vm_next;
-				}
-				up_read(&mm->mmap_sem);
-			} else {
-				audit_log_format(ab, " comm=%s", tsk->comm);
-			}
-			if (tsk != current)
-				mmput(mm);
-		} else {
-			audit_log_format(ab, " comm=%s", tsk->comm);
-		}
-	}
 	if (a) {
 		switch (a->type) {
 		case AVC_AUDIT_DATA_IPC:


-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency

