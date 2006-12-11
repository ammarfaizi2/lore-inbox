Return-Path: <linux-kernel-owner+w=401wt.eu-S1762703AbWLKJ42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762703AbWLKJ42 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 04:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762705AbWLKJ42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 04:56:28 -0500
Received: from nz-out-0506.google.com ([64.233.162.227]:15337 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762703AbWLKJ41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 04:56:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=P+BPvj3RcNsMzYEBMbAc3Q9PzYrm0G6wn27MLGfRNQuOGJAiNRg0AnvVCYhCXdHaGO1rpq7WFpGPpAiKajp7Regqhj3ej3JU8iJb0IEERiURtkG6VAgU+VOGc7/4V68Wa02/jElXOaXttKmXAuJqeCyzJ7giynu0SBQ1sarVCDA=
Message-ID: <cf9d85500612110156y40341563ge96ae598f72ef303@mail.gmail.com>
Date: Mon, 11 Dec 2006 15:26:26 +0530
From: "Amitabha Roy" <amitabha.roy@gmail.com>
To: phil.el@wanadoo.fr
Subject: [patch 1/1] oprofile: Add a special cookie for the VDSO region
Cc: oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emit a special VDSO_COOKIE for VDSO regions instead of simply marking
them as anon.

Signed-off-by: Amitabha Roy <amitabha.roy@gmail.com>
---
diff --git a/drivers/oprofile/buffer_sync.c b/drivers/oprofile/buffer_sync.c
index 78c2e6e..7f879db 100644
--- a/drivers/oprofile/buffer_sync.c
+++ b/drivers/oprofile/buffer_sync.c
@@ -250,7 +250,14 @@ static unsigned long lookup_dcookie(stru
 				vma->vm_file->f_path.mnt);
 			*offset = (vma->vm_pgoff << PAGE_SHIFT) + addr -
 				vma->vm_start;
-		} else {
+		}
+#ifdef CONFIG_X86_32
+		else if(mm->context.vdso==vma->vm_start){
+                        cookie = VDSO_COOKIE;
+		        *offset = addr;
+		}
+#endif
+		else {
 			/* must be an anonymous map */
 			*offset = addr;
 		}
diff --git a/drivers/oprofile/event_buffer.h b/drivers/oprofile/event_buffer.h
index 9241627..edc8ee2 100644
--- a/drivers/oprofile/event_buffer.h
+++ b/drivers/oprofile/event_buffer.h
@@ -35,6 +35,7 @@ #define CTX_TGID_CODE			7
 #define TRACE_BEGIN_CODE		8
 #define TRACE_END_CODE			9

+#define VDSO_COOKIE ~1UL
 #define INVALID_COOKIE ~0UL
 #define NO_COOKIE 0UL
