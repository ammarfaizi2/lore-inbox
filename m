Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWJEVrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWJEVrL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWJEVlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:41:55 -0400
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95]:4995 "HELO
	smtp006.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932252AbWJEVlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:41:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=Aife7E/6whuQvOUDXHucps6tse6VjLnm4C9MmwtqmpEdDzz5/iwiR614bIcDs9BXe0m3Heyc2Ul8WLeffqiqlED9tduvuwz3epctk5RGX7EbLlh2MAuO8YTvElqJyNNIDuYE9Fm9+xGHNVbTFfnhV2/gWcig/DUQPOw2EhLCthg=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 05/14] uml: make TT mode compile after setjmp-related changes
Date: Thu, 05 Oct 2006 23:38:49 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20061005213849.17268.88029.stgit@memento.home.lan>
In-Reply-To: <20061005213212.17268.7409.stgit@memento.home.lan>
References: <20061005213212.17268.7409.stgit@memento.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Make TT mode compile after the introduction of klibc's implementation of setjmp.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/tt/uaccess_user.c |    6 +++---
 arch/um/os-Linux/tt.c            |    1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/um/kernel/tt/uaccess_user.c b/arch/um/kernel/tt/uaccess_user.c
index 6c92bbc..ed1abcf 100644
--- a/arch/um/kernel/tt/uaccess_user.c
+++ b/arch/um/kernel/tt/uaccess_user.c
@@ -4,13 +4,13 @@
  * Licensed under the GPL
  */
 
-#include <setjmp.h>
 #include <string.h>
 #include "user_util.h"
 #include "uml_uaccess.h"
 #include "task.h"
 #include "kern_util.h"
 #include "os.h"
+#include "longjmp.h"
 
 int __do_copy_from_user(void *to, const void *from, int n,
 			void **fault_addr, void **fault_catcher)
@@ -80,10 +80,10 @@ int __do_strnlen_user(const char *str, u
 	struct tt_regs save = TASK_REGS(get_current())->tt;
 	int ret;
 	unsigned long *faddrp = (unsigned long *)fault_addr;
-	sigjmp_buf jbuf;
+	jmp_buf jbuf;
 
 	*fault_catcher = &jbuf;
-	if(sigsetjmp(jbuf, 1) == 0)
+	if(UML_SETJMP(&jbuf) == 0)
 		ret = strlen(str) + 1;
 	else ret = *faddrp - (unsigned long) str;
 
diff --git a/arch/um/os-Linux/tt.c b/arch/um/os-Linux/tt.c
index 5461a06..3dc3a02 100644
--- a/arch/um/os-Linux/tt.c
+++ b/arch/um/os-Linux/tt.c
@@ -10,7 +10,6 @@ #include <sched.h>
 #include <errno.h>
 #include <stdarg.h>
 #include <stdlib.h>
-#include <setjmp.h>
 #include <sys/time.h>
 #include <sys/ptrace.h>
 #include <linux/ptrace.h>
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
