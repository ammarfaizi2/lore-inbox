Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWHXNLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWHXNLk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWHXNLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:11:40 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:5307 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751400AbWHXNLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:11:39 -0400
Subject: [patch 1/1] selinux: fix tty locking
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
       James Morris <jmorris@namei.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 24 Aug 2006 09:13:12 -0400
Message-Id: <1156425192.8506.167.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Take tty_mutex when accessing ->signal->tty in selinux code.
Noted by Alan Cox.  Longer term, we are looking at refactoring the code to provide better encapsulation of the tty layer, but this is a simple fix that addresses the immediate bug.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/hooks.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5d1b8c7..4b0f904 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1711,10 +1711,12 @@ static inline void flush_unauthorized_fi
 {
 	struct avc_audit_data ad;
 	struct file *file, *devnull = NULL;
-	struct tty_struct *tty = current->signal->tty;
+	struct tty_struct *tty;
 	struct fdtable *fdt;
 	long j = -1;
 
+	mutex_lock(&tty_mutex);
+	tty = current->signal->tty;
 	if (tty) {
 		file_list_lock();
 		file = list_entry(tty->tty_files.next, typeof(*file), f_u.fu_list);
@@ -1734,6 +1736,7 @@ static inline void flush_unauthorized_fi
 		}
 		file_list_unlock();
 	}
+	mutex_unlock(&tty_mutex);
 
 	/* Revalidate access to inherited open files. */
 

-- 
Stephen Smalley
National Security Agency

