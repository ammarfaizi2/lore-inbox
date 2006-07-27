Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWG0OOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWG0OOs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWG0OOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:14:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20955 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751340AbWG0OOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:14:47 -0400
Message-ID: <44C8950C.3080609@redhat.com>
Date: Thu, 27 Jul 2006 18:27:24 +0800
From: Eugene Teo <eteo@redhat.com>
Organization: Red Hat Asia-Pacific
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Marcel Holtmann <holtmann@redhat.com>
Subject: [PATCH] Require mmap handler for a.out executables (was Re: 2.6.18-rc2-mm1)
References: <20060727015639.9c89db57.akpm@osdl.org>
In-Reply-To: <20060727015639.9c89db57.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Andrew Morton wrote:
[snipped]
> - Lots of random patches.  Many of them are bugfixes and I shall, as usual,
>   go through them all identifying 2.6.18 material.  But I can miss things, so
>   please don't be afraid to point 2.6.18 candidates out to me.
[snipped]

The following patch provides better protection against people exploiting stuff
in /proc and I hope you consider it for upstream inclusion.

Thanks.

Eugene

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


-- 
eteo redhat.com  ph: +65 6490 4142  http://www.kernel.org/~eugeneteo
gpg fingerprint:  47B9 90F6 AE4A 9C51 37E0  D6E1 EA84 C6A2 58DF 8823
