Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbULGJ5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbULGJ5i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 04:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbULGJ5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 04:57:38 -0500
Received: from dwdmx2.dwd.de ([141.38.3.197]:30028 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id S261764AbULGJ5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 04:57:23 -0500
Date: Tue, 7 Dec 2004 09:56:26 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@diagnostix.dwd.de
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: BUG in fs/ext3/dir.c
Message-ID: <Pine.LNX.4.58.0412070953190.11134@diagnostix.dwd.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="646810922-1664675874-1102413386=:11134"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--646810922-1664675874-1102413386=:11134
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello

[Sorry if you get this twice. This was send to ext3-users@redhat.com and
 the authors of ext3, but got no responce.]

When using readdir() on a directory with many files or long file names
it can happen that it returns the same file name twice. Attached is
a program that demonstrates this. To produce the error start the program
as follows:

     ./a.out 200 20
     BUG: 00000000000000000061 appears twice!
     stat() error (testbugdir/input/00000000000000000061) : No such file or directory
     BUG: 00000000000000000061 appears twice!
     unlink() error (testbugdir/output/00000000000000000061) : No such file or directory

or:

     ./a.out 50 61
     BUG: 0000000000000000000000000000000000000000000000000000000000020 appears twice!
     stat() error (testbugdir/input/0000000000000000000000000000000000000000000000000000000000020) : No such file or directory
     unlink() error (testbugdir/output/0000000000000000000000000000000000000000000000000000000000020) : No such file or directory

First parameter is the number of files, second the file name length.

I have traced this problem back to linux-2.6.10-rc1-bk18 and all kernels
after this one are effected. linux-2.6.10-rc1-bk17 is okay. If I reverse
the following patch in linux-2.6.10-rc1-bk18, readdir() works again
correctly:

diff -Nru linux-2.6.10-rc1-bk17/fs/ext3/dir.c linux-2.6.10-rc1-bk18/fs/ext3/dir.c
--- linux-2.6.10-rc1-bk17/fs/ext3/dir.c	2004-10-18 23:54:30.000000000 +0200
+++ linux-2.6.10-rc1-bk18/fs/ext3/dir.c	2004-12-05 16:44:21.000000000 +0100
@@ -418,7 +418,7 @@
 				get_dtype(sb, fname->file_type));
 		if (error) {
 			filp->f_pos = curr_pos;
-			info->extra_fname = fname->next;
+			info->extra_fname = fname;
 			return error;
 		}
 		fname = fname->next;
@@ -457,9 +457,12 @@
 	 * If there are any leftover names on the hash collision
 	 * chain, return them first.
 	 */
-	if (info->extra_fname &&
-	    call_filldir(filp, dirent, filldir, info->extra_fname))
-		goto finished;
+	if (info->extra_fname) {
+		if(call_filldir(filp, dirent, filldir, info->extra_fname))
+			goto finished;
+		else
+			goto next_entry;
+	}
 
 	if (!info->curr_node)
 		info->curr_node = rb_first(&info->root);
@@ -492,7 +495,7 @@
 		info->curr_minor_hash = fname->minor_hash;
 		if (call_filldir(filp, dirent, filldir, fname))
 			break;
-
+next_entry:
 		info->curr_node = rb_next(info->curr_node);
 		if (!info->curr_node) {
 			if (info->next_hash == ~0) {

Regards,
Holger
-- 
--646810922-1664675874-1102413386=:11134
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="dirtest.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0412070956260.11134@diagnostix.dwd.de>
Content-Description: 
Content-Disposition: attachment; filename="dirtest.c"

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3RyaW5nLmg+DQojaW5j
bHVkZSA8c3RkbGliLmg+DQojaW5jbHVkZSA8c3lzL3R5cGVzLmg+DQojaW5j
bHVkZSA8c3lzL3N0YXQuaD4NCiNpbmNsdWRlIDxkaXJlbnQuaD4NCiNpbmNs
dWRlIDxmY250bC5oPg0KI2luY2x1ZGUgPGVycm5vLmg+DQoNCmludA0KbWFp
bihpbnQgYXJnYywgY2hhciAqYXJndltdKQ0Kew0KICAgaW50ICAgICAgICAg
ICBmZCwgZmlsZW5hbWVfbGVuZ3RoLCBpLCBqLCBub19vZl9maWxlczsNCiAg
IGNoYXIgICAgICAgICAgcGF0aG5hbWVbMjU2XSwgKnB0ciwNCiAgICAgICAg
ICAgICAgICAgcHJldm5hbWVbMjU2XSwNCiAgICAgICAgICAgICAgICAgdG9f
cGF0aG5hbWVbMjU2XSwgKnRvX3B0cjsNCiAgIERJUiAgICAgICAgICAgKmRw
Ow0KICAgc3RydWN0IGRpcmVudCAqcF9kaXI7DQogICBzdHJ1Y3Qgc3RhdCAg
IHN0YXRfYnVmOw0KDQogICBpZiAoYXJnYyAhPSAzKQ0KICAgew0KICAgICAg
ZnByaW50ZihzdGRlcnIsICJVc2FnZTogJXMgPG5vLiBvZiBmaWxlcz4gPGZp
bGVuYW1lIGxlbmd0aD5cbiIsIGFyZ3ZbMF0pOw0KICAgICAgZXhpdCgxKTsN
CiAgIH0NCiAgIGVsc2UNCiAgIHsNCiAgICAgIG5vX29mX2ZpbGVzID0gYXRv
aShhcmd2WzFdKTsNCiAgICAgIGZpbGVuYW1lX2xlbmd0aCA9IGF0b2koYXJn
dlsyXSk7DQogICB9DQoNCiAgIC8qIENyZWF0ZSBuZWNlc3NhcnkgZGlycy4g
Ki8NCiAgICh2b2lkKW1rZGlyKCJ0ZXN0YnVnZGlyIiwgU19JUlVTUnxTX0lX
VVNSfFNfSVhVU1IpOw0KICAgKHZvaWQpbWtkaXIoInRlc3RidWdkaXIvaW5w
dXQiLCBTX0lSVVNSfFNfSVdVU1J8U19JWFVTUik7DQogICAodm9pZClta2Rp
cigidGVzdGJ1Z2Rpci9vdXRwdXQiLCBTX0lSVVNSfFNfSVdVU1J8U19JWFVT
Uik7DQoNCiAgIC8qIENyZWF0ZSBpbnB1dCBmaWxlcy4gKi8NCiAgIHN0cmNw
eShwYXRobmFtZSwgInRlc3RidWdkaXIvaW5wdXQvIik7DQogICBwdHIgPSBw
YXRobmFtZSArIHN0cmxlbihwYXRobmFtZSk7DQogICBmb3IgKGkgPSAwOyBp
IDwgbm9fb2ZfZmlsZXM7IGkrKykNCiAgIHsNCiAgICAgIHNwcmludGYocHRy
LCAiJTAqZCIsIGZpbGVuYW1lX2xlbmd0aCwgaSk7DQogICAgICBpZiAoKGZk
ID0gb3BlbihwYXRobmFtZSwgT19SRFdSfE9fQ1JFQVR8T19UUlVOQywgU19J
UlVTUnxTX0lXVVNSKSkgPT0gLTEpDQogICAgICB7DQogICAgICAgICBmcHJp
bnRmKHN0ZGVyciwgIm9wZW4oKSBlcnJvciAlcyA6ICVzXG4iLCBwYXRobmFt
ZSwgc3RyZXJyb3IoZXJybm8pKTsNCiAgICAgICAgIGV4aXQoMSk7DQogICAg
ICB9DQogICAgICBjbG9zZShmZCk7DQogICB9DQoNCiAgIC8qIE1vdmUgaW5w
dXQgZmlsZXMgdG8gb3V0cHV0LiAqLw0KICAgc3RyY3B5KHRvX3BhdGhuYW1l
LCAidGVzdGJ1Z2Rpci9vdXRwdXQvIik7DQogICB0b19wdHIgPSB0b19wYXRo
bmFtZSArIHN0cmxlbih0b19wYXRobmFtZSk7DQogICAqcHRyID0gJ1wwJzsN
CiAgIGlmICgoZHAgPSBvcGVuZGlyKHBhdGhuYW1lKSkgPT0gTlVMTCkNCiAg
IHsNCiAgICAgIGZwcmludGYoc3RkZXJyLCAib3BlbmRpcigpIGVycm9yICgl
cykgOiAlc1xuIiwNCiAgICAgICAgICAgICAgcGF0aG5hbWUsIHN0cmVycm9y
KGVycm5vKSk7DQogICAgICBleGl0KDEpOw0KICAgfQ0KICAgcHJldm5hbWVb
MF0gPSAnXDAnOw0KICAgd2hpbGUgKChwX2RpciA9IHJlYWRkaXIoZHApKSAh
PSBOVUxMKQ0KICAgew0KICAgICAgaWYgKHBfZGlyLT5kX25hbWVbMF0gPT0g
Jy4nKQ0KICAgICAgew0KICAgICAgICAgY29udGludWU7DQogICAgICB9DQog
ICAgICBpZiAoc3RyY21wKHByZXZuYW1lLCBwX2Rpci0+ZF9uYW1lKSA9PSAw
KQ0KICAgICAgew0KICAgICAgICAgZnByaW50ZihzdGRlcnIsICJCVUc6ICVz
IGFwcGVhcnMgdHdpY2UhXG4iLCBwX2Rpci0+ZF9uYW1lKTsNCiAgICAgIH0N
CiAgICAgIHN0cmNweShwcmV2bmFtZSwgcF9kaXItPmRfbmFtZSk7DQogICAg
ICBzdHJjcHkocHRyLCBwX2Rpci0+ZF9uYW1lKTsNCiAgICAgIGlmIChzdGF0
KHBhdGhuYW1lLCAmc3RhdF9idWYpIDwgMCkNCiAgICAgIHsNCiAgICAgICAg
IGZwcmludGYoc3RkZXJyLCAic3RhdCgpIGVycm9yICglcykgOiAlc1xuIiwN
CiAgICAgICAgICAgICAgICAgcGF0aG5hbWUsIHN0cmVycm9yKGVycm5vKSk7
DQogICAgICAgICBjb250aW51ZTsNCiAgICAgIH0NCiAgICAgIHN0cmNweSh0
b19wdHIsIHBfZGlyLT5kX25hbWUpOw0KICAgICAgaWYgKHJlbmFtZShwYXRo
bmFtZSwgdG9fcGF0aG5hbWUpID09IC0xKQ0KICAgICAgew0KICAgICAgICAg
ZnByaW50ZihzdGRlcnIsICJyZW5hbWUoKSBlcnJvciAoZmlsZSAlZCkgOiAl
c1xuIiwNCiAgICAgICAgICAgICAgICAgcGF0aG5hbWUsIHN0cmVycm9yKGVy
cm5vKSk7DQogICAgICB9DQogICB9DQogICAodm9pZCljbG9zZWRpcihkcCk7
DQoNCiAgIC8qIFJlbW92ZSBldmVyeXRpbmcuICovDQogICAqdG9fcHRyID0g
J1wwJzsNCiAgIGlmICgoZHAgPSBvcGVuZGlyKHRvX3BhdGhuYW1lKSkgPT0g
TlVMTCkNCiAgIHsNCiAgICAgIGZwcmludGYoc3RkZXJyLCAib3BlbmRpcigp
IGVycm9yICglcykgOiAlc1xuIiwNCiAgICAgICAgICAgICAgdG9fcGF0aG5h
bWUsIHN0cmVycm9yKGVycm5vKSk7DQogICAgICBleGl0KDEpOw0KICAgfQ0K
ICAgcHJldm5hbWVbMF0gPSAnXDAnOw0KICAgd2hpbGUgKChwX2RpciA9IHJl
YWRkaXIoZHApKSAhPSBOVUxMKQ0KICAgew0KICAgICAgaWYgKHBfZGlyLT5k
X25hbWVbMF0gPT0gJy4nKQ0KICAgICAgew0KICAgICAgICAgY29udGludWU7
DQogICAgICB9DQogICAgICBpZiAoc3RyY21wKHByZXZuYW1lLCBwX2Rpci0+
ZF9uYW1lKSA9PSAwKQ0KICAgICAgew0KICAgICAgICAgZnByaW50ZihzdGRl
cnIsICJCVUc6ICVzIGFwcGVhcnMgdHdpY2UhXG4iLCBwX2Rpci0+ZF9uYW1l
KTsNCiAgICAgIH0NCiAgICAgIHN0cmNweShwcmV2bmFtZSwgcF9kaXItPmRf
bmFtZSk7DQogICAgICBzdHJjcHkodG9fcHRyLCBwX2Rpci0+ZF9uYW1lKTsN
CiAgICAgIGlmICh1bmxpbmsodG9fcGF0aG5hbWUpID09IC0xKQ0KICAgICAg
ew0KICAgICAgICAgZnByaW50ZihzdGRlcnIsICJ1bmxpbmsoKSBlcnJvciAo
JXMpIDogJXNcbiIsDQogICAgICAgICAgICAgICAgIHRvX3BhdGhuYW1lLCBz
dHJlcnJvcihlcnJubykpOw0KICAgICAgICAgY29udGludWU7DQogICAgICB9
DQogICB9DQogICAodm9pZCljbG9zZWRpcihkcCk7DQogICBpZiAocm1kaXIo
InRlc3RidWdkaXIvaW5wdXQiKSA9PSAtMSkNCiAgIHsNCiAgICAgIGZwcmlu
dGYoc3RkZXJyLCAicm1kaXIoKSBlcnJvciAodGVzdGJ1Z2Rpci9pbnB1dCkg
OiAlc1xuIiwNCiAgICAgICAgICAgICAgc3RyZXJyb3IoZXJybm8pKTsNCiAg
IH0NCiAgIGlmIChybWRpcigidGVzdGJ1Z2Rpci9vdXRwdXQiKSA9PSAtMSkN
CiAgIHsNCiAgICAgIGZwcmludGYoc3RkZXJyLCAicm1kaXIoKSBlcnJvciAo
dGVzdGJ1Z2Rpci9vdXRwdXQpIDogJXNcbiIsDQogICAgICAgICAgICAgIHN0
cmVycm9yKGVycm5vKSk7DQogICB9DQogICBpZiAocm1kaXIoInRlc3RidWdk
aXIiKSA9PSAtMSkNCiAgIHsNCiAgICAgIGZwcmludGYoc3RkZXJyLCAicm1k
aXIoKSBlcnJvciAodGVzdGJ1Z2RpcikgOiAlc1xuIiwgc3RyZXJyb3IoZXJy
bm8pKTsNCiAgIH0NCg0KICAgZXhpdCgwKTsNCn0NCg==

--646810922-1664675874-1102413386=:11134--
