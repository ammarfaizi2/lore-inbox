Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWDZIB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWDZIB5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 04:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWDZIB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 04:01:57 -0400
Received: from mail8.hitachi.co.jp ([133.145.228.43]:65441 "EHLO
	mail8.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1751176AbWDZIB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 04:01:56 -0400
Message-ID: <444F28F1.1060607@sdl.hitachi.co.jp>
Date: Wed, 26 Apr 2006 17:01:53 +0900
From: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
Cc: SystemTAP <systemtap@sources.redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jim Keniston <jkenisto@us.ibm.com>,
       Yumiko Sugita <sugita@sdl.hitachi.co.jp>,
       Satoshi Oshima <soshima@redhat.com>, Hideo Aoki <haoki@redhat.com>
Subject: [PATCH] kprobe: boost 2byte-opcodes on i386
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew

Here is a patch of kprobe-booster enhancement on i386
This patch can be applied against 2.6.17-rc2.

Previous kprobe-booster patch has not handled any 2byte opcodes
and prefixes. I checked whole IA32 opcode map and classified it.

This patch enables kprobe to boost those 2byte opcodes and prefixes.

Best regards,

-- 
Masami HIRAMATSU
2nd Research Dept.
Hitachi, Ltd., Systems Development Laboratory
E-mail: hiramatu@sdl.hitachi.co.jp

Signed-off-by: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>

 kprobes.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 65 insertions(+), 13 deletions(-)
diff -Narup a/arch/i386/kernel/kprobes.c b/arch/i386/kernel/kprobes.c
--- a/arch/i386/kernel/kprobes.c	2006-04-21 12:23:45.000000000 +0900
+++ b/arch/i386/kernel/kprobes.c	2006-04-21 21:27:08.000000000 +0900
@@ -57,30 +57,82 @@ static inline void set_jmp_op(void *from
 /*
  * returns non-zero if opcodes can be boosted.
  */
-static inline int can_boost(kprobe_opcode_t opcode)
+static inline int can_boost(kprobe_opcode_t *opcodes)
 {
-	switch (opcode & 0xf0 ) {
+#define W(row,b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,ba,bb,bc,bd,be,bf)		      \
+	(((b0##UL << 0x0)|(b1##UL << 0x1)|(b2##UL << 0x2)|(b3##UL << 0x3) |   \
+	  (b4##UL << 0x4)|(b5##UL << 0x5)|(b6##UL << 0x6)|(b7##UL << 0x7) |   \
+	  (b8##UL << 0x8)|(b9##UL << 0x9)|(ba##UL << 0xa)|(bb##UL << 0xb) |   \
+	  (bc##UL << 0xc)|(bd##UL << 0xd)|(be##UL << 0xe)|(bf##UL << 0xf))    \
+	 << (row % 32))
+	/*
+	 * Undefined/reserved opcodes, conditional jump, Opcode Extension
+	 * Groups, and some special opcodes can not be boost.
+	 */
+	static const unsigned long twobyte_is_boostable[256 / 32] = {
+		/*      0 1 2 3 4 5 6 7 8 9 a b c d e f         */
+		/*      -------------------------------         */
+		W(0x00, 0,0,1,1,0,0,1,0,1,1,0,0,0,0,0,0)| /* 00 */
+		W(0x10, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0), /* 10 */
+		W(0x20, 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0)| /* 20 */
+		W(0x30, 0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0), /* 30 */
+		W(0x40, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)| /* 40 */
+		W(0x50, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0), /* 50 */
+		W(0x60, 1,1,1,1,1,1,1,1,1,1,1,1,0,0,1,1)| /* 60 */
+		W(0x70, 0,0,0,0,1,1,1,1,0,0,0,0,0,0,1,1), /* 70 */
+		W(0x80, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)| /* 80 */
+		W(0x90, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1), /* 90 */
+		W(0xa0, 1,1,0,1,1,1,0,0,1,1,0,1,1,1,0,1)| /* a0 */
+		W(0xb0, 1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1), /* b0 */
+		W(0xc0, 1,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1)| /* c0 */
+		W(0xd0, 0,1,1,1,0,1,0,0,1,1,0,1,1,1,0,1), /* d0 */
+		W(0xe0, 0,1,1,0,0,1,0,0,1,1,0,1,1,1,0,1)| /* e0 */
+		W(0xf0, 0,1,1,1,0,1,0,0,1,1,1,0,1,1,1,0)  /* f0 */
+		/*      -------------------------------         */
+		/*      0 1 2 3 4 5 6 7 8 9 a b c d e f         */
+	};
+#undef W
+	kprobe_opcode_t opcode;
+	kprobe_opcode_t *orig_opcodes = opcodes;
+retry:
+	if (opcodes - orig_opcodes > MAX_INSN_SIZE - 1)
+		return 0;
+	opcode = *(opcodes++);
+
+	/* 2nd-byte opcode */
+	if (opcode == 0x0f) {
+		if (opcodes - orig_opcodes > MAX_INSN_SIZE - 1)
+			return 0;
+		return test_bit(*opcodes, twobyte_is_boostable);
+	}
+
+	switch (opcode & 0xf0) {
+	case 0x60:
+		if (0x63 < opcode && opcode < 0x67)
+			goto retry; /* prefixes */
+		/* can't boost Address-size override and bound */
+		return (opcode != 0x62 && opcode != 0x67);
 	case 0x70:
 		return 0; /* can't boost conditional jump */
-	case 0x90:
-		/* can't boost call and pushf */
-		return opcode != 0x9a && opcode != 0x9c;
 	case 0xc0:
-		/* can't boost undefined opcodes and soft-interruptions */
-		return (0xc1 < opcode && opcode < 0xc6) ||
-			(0xc7 < opcode && opcode < 0xcc) || opcode == 0xcf;
+		/* can't boost software-interruptions */
+		return (0xc1 < opcode && opcode < 0xcc) || opcode == 0xcf;
 	case 0xd0:
 		/* can boost AA* and XLAT */
 		return (opcode == 0xd4 || opcode == 0xd5 || opcode == 0xd7);
 	case 0xe0:
-		/* can boost in/out and (may be) jmps */
-		return (0xe3 < opcode && opcode != 0xe8);
+		/* can boost in/out and absolute jmps */
+		return ((opcode & 0x04) || opcode == 0xea);
 	case 0xf0:
+		if ((opcode & 0x0c) == 0 && opcode != 0xf1)
+			goto retry; /* lock/rep(ne) prefix */
 		/* clear and set flags can be boost */
 		return (opcode == 0xf5 || (0xf7 < opcode && opcode < 0xfe));
 	default:
-		/* currently, can't boost 2 bytes opcodes */
-		return opcode != 0x0f;
+		if (opcode == 0x26 || opcode == 0x36 || opcode == 0x3e)
+			goto retry; /* prefixes */
+		/* can't boost CS override and call */
+		return (opcode != 0x2e && opcode != 0x9a);
 	}
 }

@@ -109,7 +161,7 @@ int __kprobes arch_prepare_kprobe(struct

 	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
 	p->opcode = *p->addr;
-	if (can_boost(p->opcode)) {
+	if (can_boost(p->addr)) {
 		p->ainsn.boostable = 0;
 	} else {
 		p->ainsn.boostable = -1;




