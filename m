Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267382AbTALSbo>; Sun, 12 Jan 2003 13:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267383AbTALSbn>; Sun, 12 Jan 2003 13:31:43 -0500
Received: from host194.steeleye.com ([66.206.164.34]:12563 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267382AbTALSbl>; Sun, 12 Jan 2003 13:31:41 -0500
Message-Id: <200301121840.h0CIeMd11612@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: [PATCH] fix broken kallsyms on non-x86 archs
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_16034931560"
Date: Sun, 12 Jan 2003 13:40:22 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_16034931560
Content-Type: text/plain; charset=us-ascii

kallsyms is broken in parisc on 2.5.56 again because of assembler syntax 
subtleties.  This is the offending line:

printf("\t.byte 0x%02x ; .asciz\t\"%s\"\n"

Note the `;' separating the two statements.  On some platforms `;' is a 
comment in assembly code, and thus the following .asciz is ignored.  The fix 
is attached.

James


--==_Exmh_16034931560
Content-Type: text/plain ; name="tmp.diff"; charset=us-ascii
Content-Description: tmp.diff
Content-Disposition: attachment; filename="tmp.diff"

===== scripts/kallsyms.c 1.6 vs edited =====
--- 1.6/scripts/kallsyms.c	Thu Jan  2 04:02:18 2003
+++ edited/scripts/kallsyms.c	Sun Jan 12 12:23:03 2003
@@ -144,7 +144,7 @@
 		for (k = 0; table[i].sym[k] && table[i].sym[k] == prev[k]; ++k)
 			; 
 
-		printf("\t.byte 0x%02x ; .asciz\t\"%s\"\n", k, table[i].sym + k);
+		printf("\t.byte 0x%02x\n\t.asciz\t\"%s\"\n", k, table[i].sym + k);
 		last_addr = table[i].addr;
 		prev = table[i].sym;
 	}

--==_Exmh_16034931560--


