Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbVIILov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbVIILov (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 07:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbVIILov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 07:44:51 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:51497
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932449AbVIILov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 07:44:51 -0400
Message-Id: <432192140200007800024933@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 09 Sep 2005 13:45:56 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [PATCH] reduce x86-64 bug frame by 4 bytes
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part9BB9F4E4.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part9BB9F4E4.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

reduce x86-64 bug frame by 4 bytes

From: Jan Beulich <jbeulich@novell.com>

(Note: Patch also attached because the inline version is certain to
get
line wrapped.)

As mentioned before, the size of the bug frame can be further reduced
while
continuing to use instructions to encode the information.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/arch/x86_64/kernel/traps.c
2.6.13-x86_64-bug-reduction/arch/x86_64/kernel/traps.c
--- 2.6.13/arch/x86_64/kernel/traps.c	2005-08-29 01:41:01.000000000
+0200
+++
2.6.13-x86_64-bug-reduction/arch/x86_64/kernel/traps.c	2005-09-09
11:48:11.009725672 +0200
@@ -323,13 +323,13 @@ void handle_BUG(struct pt_regs *regs)
 	if (__copy_from_user(&f, (struct bug_frame *) regs->rip, 
 			     sizeof(struct bug_frame)))
 		return; 
-	if ((unsigned long)f.filename < __PAGE_OFFSET || 
+	if (f.filename >= 0 || 
 	    f.ud2[0] != 0x0f || f.ud2[1] != 0x0b) 
 		return;
-	if (__get_user(tmp, f.filename))
-		f.filename = "unmapped filename"; 
+	if (__get_user(tmp, (char *)(long)f.filename))
+		f.filename = (int)(long)"unmapped filename"; 
 	printk("----------- [cut here ] --------- [please bite here ]
---------\n");
-	printk(KERN_ALERT "Kernel BUG at %.50s:%d\n", f.filename,
f.line);
+	printk(KERN_ALERT "Kernel BUG at %.50s:%d\n", (char
*)(long)f.filename, f.line);
 } 
 
 #ifdef CONFIG_BUG
diff -Npru 2.6.13/include/asm-x86_64/bug.h
2.6.13-x86_64-bug-reduction/include/asm-x86_64/bug.h
--- 2.6.13/include/asm-x86_64/bug.h	2005-08-29 01:41:01.000000000
+0200
+++
2.6.13-x86_64-bug-reduction/include/asm-x86_64/bug.h	2005-09-09
11:31:11.611697728 +0200
@@ -9,10 +9,8 @@
  */
 struct bug_frame {
 	unsigned char ud2[2];
-	unsigned char mov;
-	/* should use 32bit offset instead, but the assembler doesn't 
-	   like it */
-	char *filename;
+	unsigned char push;
+	signed int filename;
 	unsigned char ret;
 	unsigned short line;
 } __attribute__((packed));
@@ -25,8 +23,8 @@ struct bug_frame {
    The magic numbers generate mov $64bitimm,%eax ; ret $offset. */
 #define BUG()
								\
 	asm
volatile(							\
-	"ud2 ; .byte 0xa3 ; .quad %c1 ; .byte 0xc2 ; .short %c0" ::
	\
-		     "i"(__LINE__), "i" (__stringify(__FILE__)))
+	"ud2 ; pushq $%c1 ; ret $%c0" ::
				\
+		     "i"(__LINE__), "i" (__FILE__))
 void out_of_line_bug(void);
 #else
 static inline void out_of_line_bug(void) { }


--=__Part9BB9F4E4.1__=
Content-Type: application/octet-stream; name="linux-2.6.13-x86_64-bug-reduction.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-x86_64-bug-reduction.patch"

cmVkdWNlIHg4Ni02NCBidWcgZnJhbWUgYnkgNCBieXRlcwoKRnJvbTogSmFuIEJldWxpY2ggPGpi
ZXVsaWNoQG5vdmVsbC5jb20+CgooTm90ZTogUGF0Y2ggYWxzbyBhdHRhY2hlZCBiZWNhdXNlIHRo
ZSBpbmxpbmUgdmVyc2lvbiBpcyBjZXJ0YWluIHRvIGdldApsaW5lIHdyYXBwZWQuKQoKQXMgbWVu
dGlvbmVkIGJlZm9yZSwgdGhlIHNpemUgb2YgdGhlIGJ1ZyBmcmFtZSBjYW4gYmUgZnVydGhlciBy
ZWR1Y2VkIHdoaWxlCmNvbnRpbnVpbmcgdG8gdXNlIGluc3RydWN0aW9ucyB0byBlbmNvZGUgdGhl
IGluZm9ybWF0aW9uLgoKU2lnbmVkLW9mZi1ieTogSmFuIEJldWxpY2ggPGpiZXVsaWNoQG5vdmVs
bC5jb20+CgpkaWZmIC1OcHJ1IDIuNi4xMy9hcmNoL3g4Nl82NC9rZXJuZWwvdHJhcHMuYyAyLjYu
MTMteDg2XzY0LWJ1Zy1yZWR1Y3Rpb24vYXJjaC94ODZfNjQva2VybmVsL3RyYXBzLmMKLS0tIDIu
Ni4xMy9hcmNoL3g4Nl82NC9rZXJuZWwvdHJhcHMuYwkyMDA1LTA4LTI5IDAxOjQxOjAxLjAwMDAw
MDAwMCArMDIwMAorKysgMi42LjEzLXg4Nl82NC1idWctcmVkdWN0aW9uL2FyY2gveDg2XzY0L2tl
cm5lbC90cmFwcy5jCTIwMDUtMDktMDkgMTE6NDg6MTEuMDA5NzI1NjcyICswMjAwCkBAIC0zMjMs
MTMgKzMyMywxMyBAQCB2b2lkIGhhbmRsZV9CVUcoc3RydWN0IHB0X3JlZ3MgKnJlZ3MpCiAJaWYg
KF9fY29weV9mcm9tX3VzZXIoJmYsIChzdHJ1Y3QgYnVnX2ZyYW1lICopIHJlZ3MtPnJpcCwgCiAJ
CQkgICAgIHNpemVvZihzdHJ1Y3QgYnVnX2ZyYW1lKSkpCiAJCXJldHVybjsgCi0JaWYgKCh1bnNp
Z25lZCBsb25nKWYuZmlsZW5hbWUgPCBfX1BBR0VfT0ZGU0VUIHx8IAorCWlmIChmLmZpbGVuYW1l
ID49IDAgfHwgCiAJICAgIGYudWQyWzBdICE9IDB4MGYgfHwgZi51ZDJbMV0gIT0gMHgwYikgCiAJ
CXJldHVybjsKLQlpZiAoX19nZXRfdXNlcih0bXAsIGYuZmlsZW5hbWUpKQotCQlmLmZpbGVuYW1l
ID0gInVubWFwcGVkIGZpbGVuYW1lIjsgCisJaWYgKF9fZ2V0X3VzZXIodG1wLCAoY2hhciAqKShs
b25nKWYuZmlsZW5hbWUpKQorCQlmLmZpbGVuYW1lID0gKGludCkobG9uZykidW5tYXBwZWQgZmls
ZW5hbWUiOyAKIAlwcmludGsoIi0tLS0tLS0tLS0tIFtjdXQgaGVyZSBdIC0tLS0tLS0tLSBbcGxl
YXNlIGJpdGUgaGVyZSBdIC0tLS0tLS0tLVxuIik7Ci0JcHJpbnRrKEtFUk5fQUxFUlQgIktlcm5l
bCBCVUcgYXQgJS41MHM6JWRcbiIsIGYuZmlsZW5hbWUsIGYubGluZSk7CisJcHJpbnRrKEtFUk5f
QUxFUlQgIktlcm5lbCBCVUcgYXQgJS41MHM6JWRcbiIsIChjaGFyICopKGxvbmcpZi5maWxlbmFt
ZSwgZi5saW5lKTsKIH0gCiAKICNpZmRlZiBDT05GSUdfQlVHCmRpZmYgLU5wcnUgMi42LjEzL2lu
Y2x1ZGUvYXNtLXg4Nl82NC9idWcuaCAyLjYuMTMteDg2XzY0LWJ1Zy1yZWR1Y3Rpb24vaW5jbHVk
ZS9hc20teDg2XzY0L2J1Zy5oCi0tLSAyLjYuMTMvaW5jbHVkZS9hc20teDg2XzY0L2J1Zy5oCTIw
MDUtMDgtMjkgMDE6NDE6MDEuMDAwMDAwMDAwICswMjAwCisrKyAyLjYuMTMteDg2XzY0LWJ1Zy1y
ZWR1Y3Rpb24vaW5jbHVkZS9hc20teDg2XzY0L2J1Zy5oCTIwMDUtMDktMDkgMTE6MzE6MTEuNjEx
Njk3NzI4ICswMjAwCkBAIC05LDEwICs5LDggQEAKICAqLwogc3RydWN0IGJ1Z19mcmFtZSB7CiAJ
dW5zaWduZWQgY2hhciB1ZDJbMl07Ci0JdW5zaWduZWQgY2hhciBtb3Y7Ci0JLyogc2hvdWxkIHVz
ZSAzMmJpdCBvZmZzZXQgaW5zdGVhZCwgYnV0IHRoZSBhc3NlbWJsZXIgZG9lc24ndCAKLQkgICBs
aWtlIGl0ICovCi0JY2hhciAqZmlsZW5hbWU7CisJdW5zaWduZWQgY2hhciBwdXNoOworCXNpZ25l
ZCBpbnQgZmlsZW5hbWU7CiAJdW5zaWduZWQgY2hhciByZXQ7CiAJdW5zaWduZWQgc2hvcnQgbGlu
ZTsKIH0gX19hdHRyaWJ1dGVfXygocGFja2VkKSk7CkBAIC0yNSw4ICsyMyw4IEBAIHN0cnVjdCBi
dWdfZnJhbWUgewogICAgVGhlIG1hZ2ljIG51bWJlcnMgZ2VuZXJhdGUgbW92ICQ2NGJpdGltbSwl
ZWF4IDsgcmV0ICRvZmZzZXQuICovCiAjZGVmaW5lIEJVRygpIAkJCQkJCQkJXAogCWFzbSB2b2xh
dGlsZSgJCQkJCQkJXAotCSJ1ZDIgOyAuYnl0ZSAweGEzIDsgLnF1YWQgJWMxIDsgLmJ5dGUgMHhj
MiA7IC5zaG9ydCAlYzAiIDo6IAlcCi0JCSAgICAgImkiKF9fTElORV9fKSwgImkiIChfX3N0cmlu
Z2lmeShfX0ZJTEVfXykpKQorCSJ1ZDIgOyBwdXNocSAkJWMxIDsgcmV0ICQlYzAiIDo6IAkJCQlc
CisJCSAgICAgImkiKF9fTElORV9fKSwgImkiIChfX0ZJTEVfXykpCiB2b2lkIG91dF9vZl9saW5l
X2J1Zyh2b2lkKTsKICNlbHNlCiBzdGF0aWMgaW5saW5lIHZvaWQgb3V0X29mX2xpbmVfYnVnKHZv
aWQpIHsgfQo=

--=__Part9BB9F4E4.1__=--
