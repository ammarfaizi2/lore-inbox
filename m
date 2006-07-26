Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWGZKbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWGZKbT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 06:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWGZKbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 06:31:19 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:44176 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932181AbWGZKbS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 06:31:18 -0400
Subject: Require mmap handler for a.out executables
From: Marcel Holtmann <marcel@holtmann.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Eugene Teo <eteo@redhat.com>
Content-Type: multipart/mixed; boundary="=-oRIaeFemI07HbbrC9oFm"
Date: Wed, 26 Jul 2006 12:31:21 +0200
Message-Id: <1153909881.746.39.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oRIaeFemI07HbbrC9oFm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Linus,

with the nasty /proc privilege escalation (CVE-2006-3626) it became
clear that we need to do something more to better protect us against
people exploiting stuff in /proc. Besides the don't allow chmod stuff,
Eugene also proposed to depend the a.out execution on the existence of
the mmap handler. Since we are doing the same for ELF, this makes
totally sense to me.

The attached patch implements the additional check for the mmap handler
and I hope you consider it for upstream inclusion.

Regards

Marcel


--=-oRIaeFemI07HbbrC9oFm
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

[PATCH] Require mmap handler for a.out executables

Files supported by fs/proc/base.c, i.e. /proc/<pid>/*, are not capable
of meeting the validity checks in ELF load_elf_*() handling because they
have no mmap handler which is required by ELF. In order to stop a.out
executables being used as part of an exploit attack against /proc-related
vulnerabilities, we make a.out executables depend on ->mmap() existing.

Signed-off-by: Eugene Teo <eteo@redhat.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

---
commit 1597cf8405734e4747c808bb7e04115a6670dccf
tree 49050549aee6406dab0c021c5aa4e9bfc337bd8f
parent 44eb123126d289bac398cac0232309c228386671
author Marcel Holtmann <marcel@holtmann.org> Wed, 26 Jul 2006 12:12:14 +0200
committer Marcel Holtmann <marcel@holtmann.org> Wed, 26 Jul 2006 12:12:14 +0200

 fs/binfmt_aout.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
index f312103..5638acf 100644
--- a/fs/binfmt_aout.c
+++ b/fs/binfmt_aout.c
@@ -278,6 +278,9 @@ static int load_aout_binary(struct linux
 		return -ENOEXEC;
 	}
 
+	if (!bprm->file->f_op || !bprm->file->f_op->mmap)
+		return -ENOEXEC;
+
 	fd_offset = N_TXTOFF(ex);
 
 	/* Check initial limits. This avoids letting people circumvent
@@ -476,6 +479,9 @@ static int load_aout_library(struct file
 		goto out;
 	}
 
+	if (!file->f_op || !file->f_op->mmap)
+		goto out;
+
 	if (N_FLAGS(ex))
 		goto out;
 

--=-oRIaeFemI07HbbrC9oFm--

