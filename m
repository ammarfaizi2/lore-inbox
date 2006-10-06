Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422787AbWJFRqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422787AbWJFRqH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 13:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422768AbWJFRqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 13:46:06 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:12771 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1422787AbWJFRqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 13:46:02 -0400
From: Matthew Wilcox <matthew@wil.cx>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-usb-devel@lists.sourceforge.net,
       Grant Grundler <grundler@parisc-linux.org>,
       Matthew Wilcox <matthew@wil.cx>
Subject: [PATCH] extract() and implement() are bit field manipulation routines.
Reply-To: Matthew Wilcox <matthew@wil.cx>
Date: Fri, 06 Oct 2006 11:46:00 -0600
Message-Id: <11601567602932-git-send-email-matthew@wil.cx>
X-Mailer: git-send-email 1.4.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grant Grundler <grundler@parisc-linux.org>

extract() and implement() have brain damaged attempts to handle
32-bit wide "fields".
The problem is the index math in the original code didn't clear all
the relevant bits.  (offset >> 5) only compensated for 32-bit index.
We need (offset >> 6) if we want to use 64-bit loads.

But it was also wrong in that it tried to use quasi-aligned loads.
Ie "report" was only incremented in multiples of 4 bytes and then
the offset was masked off for values greater than 4 bytes.
The right way is to pretend "report" points at a byte array.
And offset is then only minor adjustment for < 8 bits of offset.
"n" (field width) can then be as big as 24 (assuming 32-bit loads)
since "offset" will never be bigger than 7.

If someone needs either function to handle more than 24-bits,
please document why - point at a specification or specific USB
hid device - in comments in the code.

extract/implement() are also an eyesore to read.
Please banish whoever wrote it to read CodingStyle 3 times in a row
to a classroom full of 1st graders armed with rubberbands.
Or just flame them. Whatever. Globbing all the code together
on two lines does NOT make it faster and is Just Wrong.

I've tested this patch on j6000 (dual 750Mhz PA-RISC, 32-bit 2.6.12-rc5).
Kyle McMartin tested on c3000 (up 400Mhz PA-RISC, same kernel).
"p2-mate" (Peter De Schrijver?) tested on sb1250 (dual core Mips,
   broadcom "swarm" eval board).

Signed-off-by: Grant Grundler <grundler@parisc-linux.org>
Signed-off-by: Matthew Wilcox <matthew@wil.cx>
---
 drivers/usb/input/hid-core.c |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
index 8ea9c91..2ceabab 100644
--- a/drivers/usb/input/hid-core.c
+++ b/drivers/usb/input/hid-core.c
@@ -752,21 +752,31 @@ static __inline__ __u32 s32ton(__s32 val
 }
 
 /*
- * Extract/implement a data field from/to a report.
+ * Extract/implement a data field from/to a little endian report (bit array).
  */
 
 static __inline__ __u32 extract(__u8 *report, unsigned offset, unsigned n)
 {
-	report += (offset >> 5) << 2; offset &= 31;
-	return (le64_to_cpu(get_unaligned((__le64*)report)) >> offset) & ((1ULL << n) - 1);
+	u32 x;
+
+	report += offset >> 3;  /* adjust byte index */
+	offset &= 8 - 1;
+	x = get_unaligned((u32 *) report);
+	x = le32_to_cpu(x);
+	x = (x >> offset) & ((1 << n) - 1);
+	return x;
 }
 
 static __inline__ void implement(__u8 *report, unsigned offset, unsigned n, __u32 value)
 {
-	report += (offset >> 5) << 2; offset &= 31;
-	put_unaligned((get_unaligned((__le64*)report)
-		& cpu_to_le64(~((((__u64) 1 << n) - 1) << offset)))
-		| cpu_to_le64((__u64)value << offset), (__le64*)report);
+	u32 x;
+
+	report += offset >> 3;
+	offset &= 8 - 1;
+	x = get_unaligned((u32 *)report);
+	x &= cpu_to_le32(~((((__u32) 1 << n) - 1) << offset));
+	x |= cpu_to_le32(value << offset);
+	put_unaligned(x,(u32 *)report);
 }
 
 /*
-- 
1.4.1.1

