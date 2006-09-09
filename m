Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWIIIPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWIIIPi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 04:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWIIIPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 04:15:38 -0400
Received: from gw.goop.org ([64.81.55.164]:21467 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932350AbWIIIPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 04:15:37 -0400
Message-ID: <45027822.2010906@goop.org>
Date: Sat, 09 Sep 2006 01:15:30 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386-pda updates
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updates to i386-pda:

- fix typo
- add a self-pointer to the PDA, so that finding its
  linear address is easy
- add type checking to PDA write operations
- add byte-sized read/writes to the PDA

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 arch/i386/kernel/cpu/common.c |    4 +++-
 include/asm-i386/pda.h        |   19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff -r 69614542c834 arch/i386/kernel/cpu/common.c
--- a/arch/i386/kernel/cpu/common.c	Fri Sep 08 16:53:26 2006 -0700
+++ b/arch/i386/kernel/cpu/common.c	Sat Sep 09 00:19:48 2006 -0700
@@ -588,7 +588,7 @@ void __init early_cpu_init(void)
 #endif
 }
 
-/* Make sure %gs it initialized properly in idle threads */
+/* Make sure %gs is initialized properly in idle threads */
 struct pt_regs * __devinit idle_regs(struct pt_regs *regs)
 {
 	memset(regs, 0, sizeof(struct pt_regs));
@@ -648,6 +648,8 @@ static __cpuinit void pda_init(int cpu, 
 
 	memset(pda, 0, sizeof(*pda));
 
+	pda->_pda = pda;
+
 	pda->cpu_number = cpu;
 	pda->pcurrent = curr;
 
diff -r 69614542c834 include/asm-i386/pda.h
--- a/include/asm-i386/pda.h	Fri Sep 08 16:53:26 2006 -0700
+++ b/include/asm-i386/pda.h	Sat Sep 09 00:19:48 2006 -0700
@@ -3,6 +3,8 @@
 
 struct i386_pda
 {
+	struct i386_pda *_pda;		/* pointer to self */
+
 	struct task_struct *pcurrent;	/* current process */
 	int cpu_number;
 };
@@ -20,7 +22,14 @@ extern struct i386_pda _proxy_pda;
 #define pda_to_op(op,field,val)						\
 	do {								\
 		typedef typeof(_proxy_pda.field) T__;			\
+		if (0) { T__ tmp__; tmp__ = (val); }			\
 		switch (sizeof(_proxy_pda.field)) {			\
+		case 1:							\
+			asm(op "b %1,%%gs:%c2"				\
+			    : "+m" (_proxy_pda.field)			\
+			    :"ri" ((T__)val),				\
+			     "i"(pda_offset(field)));			\
+			break;						\
 		case 2:							\
 			asm(op "w %1,%%gs:%c2"				\
 			    : "+m" (_proxy_pda.field)			\
@@ -41,6 +50,12 @@ extern struct i386_pda _proxy_pda;
 	({								\
 		typeof(_proxy_pda.field) ret__;				\
 		switch (sizeof(_proxy_pda.field)) {			\
+		case 1:							\
+			asm(op "b %%gs:%c1,%0"				\
+			    : "=r" (ret__)				\
+			    : "i" (pda_offset(field)),			\
+			      "m" (_proxy_pda.field));			\
+			break;						\
 		case 2:							\
 			asm(op "w %%gs:%c1,%0"				\
 			    : "=r" (ret__)				\
@@ -57,6 +72,10 @@ extern struct i386_pda _proxy_pda;
 		}							\
 		ret__; })
 
+/* Return a pointer to a pda field */
+#define pda_addr(field)							\
+	((typeof(_proxy_pda.field) *)((unsigned char *)read_pda(_pda) + \
+				      pda_offset(field)))
 
 #define read_pda(field) pda_from_op("mov",field)
 #define write_pda(field,val) pda_to_op("mov",field,val)

