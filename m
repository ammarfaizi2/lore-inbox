Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWDRRja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWDRRja (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 13:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWDRRja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 13:39:30 -0400
Received: from apis.di.unipi.it ([131.114.3.6]:16797 "EHLO
	mailserver.di.unipi.it") by vger.kernel.org with ESMTP
	id S932181AbWDRRj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 13:39:29 -0400
Organization: Dipartimento di Informatica
From: Claudio Scordino <cloud.of.andor@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Improved getrusage
Date: Tue, 18 Apr 2006 19:37:07 +0200
User-Agent: KMail/1.8
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, kernel-janitors@lists.osdl.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_EPSREUVu70oG9/n"
Message-Id: <200604181937.08224.cloud.of.andor@gmail.com>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: non spam, SpamAssassin (punteggio=-1.44,
	necessario 5, autolearn=disabled, ALL_TRUSTED -1.44)
X-MailScanner-From: cloud.of.andor@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_EPSREUVu70oG9/n
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all!

A couple of months ago we discussed the possibility of improving the getrusage 
syscall to read usage information about tasks belonging to the same owner 
(not just about current and children).

After an extensive discussion on the mailing list, some of us agreed about the 
following patch. Some others, instead, said that it is too permissive. 

Should we definitely drop this idea ??

Thanks,

           Claudio

--Boundary-00=_EPSREUVu70oG9/n
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch.diff"

Signed-off-by: Claudio Scordino <cloud.of.andor@gmail.com>
--- sys.c	2006-04-18 12:54:38.000000000 -0400
+++ sys.new.c	2006-04-18 12:58:41.000000000 -0400
@@ -1767,9 +1767,29 @@
 
 asmlinkage long sys_getrusage(int who, struct rusage __user *ru)
 {
-	if (who != RUSAGE_SELF && who != RUSAGE_CHILDREN)
-		return -EINVAL;
-	return getrusage(current, who, ru);
+	struct rusage r;
+	struct task_struct* tsk = current;
+	read_lock(&tasklist_lock);
+	if ((who != RUSAGE_SELF) && (who != RUSAGE_CHILDREN)) {
+		tsk = find_task_by_pid(who);
+		if ((tsk == NULL) || (who <=0)) 
+			goto bad;
+		if (((current->uid != tsk->euid) ||
+			(current->uid != tsk->suid) ||
+			(current->uid != tsk->uid) ||
+			(current->gid != tsk->egid) ||
+			(current->gid != tsk->sgid) ||
+			(current->gid != tsk->gid)) && !capable(CAP_SYS_PTRACE))
+				goto bad;
+		who = RUSAGE_SELF;
+	}
+	k_getrusage(tsk, who, &r);
+	read_unlock(&tasklist_lock);
+	return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
+
+bad:
+	read_unlock(&tasklist_lock);
+	return tsk ? -EPERM : -EINVAL;
 }
 
 asmlinkage long sys_umask(int mask)

--Boundary-00=_EPSREUVu70oG9/n--
