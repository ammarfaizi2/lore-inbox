Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266076AbUBBUqM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265932AbUBBUol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 15:44:41 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:64335 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S265945AbUBBUmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 15:42:32 -0500
Date: Mon, 2 Feb 2004 20:42:34 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] bitmap double fault, gdt
Message-ID: <Pine.LNX.4.44.0402021958130.16648-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1329723834-1075754554=:16648"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1329723834-1075754554=:16648
Content-Type: TEXT/PLAIN; charset=US-ASCII

With 2.6.2-rc1-mm3 I started getting occasional double faults when idle.
Seemed to be irqbalance (with NR_CPUS 2) using new bitmap_parse calling
bitmap_shift_right: collapse when it reloads %esp with 0 before return.

Google tells me that there were compiler code generation problems
around here before, but I didn't track down quite what: are we sure
they've been eliminated?  Disassembly of bitmap_shift_right attached,
that's with an RH 3.2.3-20 gcc, but I see similar code from more recent
SuSE 3.3.2 gcc: sub $0x4,%esp ... sub %eax,%esp ... lea 0x1b(%esp,1),%esi

CONFIG_CPU_PENTIUMIII=y; and I do have CONFIG_FRAME_POINTER=y, but
it looks like that makes no difference, that this alloca kind of code
uses frame pointer anyway.  I've tried but failed to produce similar
disassembly compiling outside the kernel, despite using kernel cflags.

If you think there is still a code generation problem here with popular
versions of gcc, perhaps we should stop that variable stack declaration?

Hugh

--- 2.6.2-rc2-mm2/lib/bitmap.c	2004-01-25 18:04:19.000000000 +0000
+++ linux/lib/bitmap.c	2004-01-30 20:44:44.000000000 +0000
@@ -12,6 +12,8 @@
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 
+#define MAX_BITMAP_BITS	512U	/* for ia64 NR_CPUS maximum */
+
 int bitmap_empty(const unsigned long *bitmap, int bits)
 {
 	int k, lim = bits/BITS_PER_LONG;
@@ -73,8 +75,9 @@
 			const unsigned long *src, int shift, int bits)
 {
 	int k;
-	DECLARE_BITMAP(__shr_tmp, bits);
+	DECLARE_BITMAP(__shr_tmp, MAX_BITMAP_BITS);
 
+	BUG_ON(bits > MAX_BITMAP_BITS);
 	bitmap_clear(__shr_tmp, bits);
 	for (k = 0; k < bits - shift; ++k)
 		if (test_bit(k + shift, src))
@@ -87,8 +90,9 @@
 			const unsigned long *src, int shift, int bits)
 {
 	int k;
-	DECLARE_BITMAP(__shl_tmp, bits);
+	DECLARE_BITMAP(__shl_tmp, MAX_BITMAP_BITS);
 
+	BUG_ON(bits > MAX_BITMAP_BITS);
 	bitmap_clear(__shl_tmp, bits);
 	for (k = bits; k >= shift; --k)
 		if (test_bit(k - shift, src))

--8323328-1329723834-1075754554=:16648
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="bitmapsr.s"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0402022042340.16648@localhost.localdomain>
Content-Description: bitmap_shift_right disassembly
Content-Disposition: attachment; filename="bitmapsr.s"

MDAwMDAxODAgPGJpdG1hcF9zaGlmdF9yaWdodD46DQogMTgwOgk1NSAgICAg
ICAgICAgICAgICAgICAJcHVzaCAgICVlYnANCiAxODE6CTg5IGU1ICAgICAg
ICAgICAgICAgIAltb3YgICAgJWVzcCwlZWJwDQogMTgzOgk1NyAgICAgICAg
ICAgICAgICAgICAJcHVzaCAgICVlZGkNCiAxODQ6CTU2ICAgICAgICAgICAg
ICAgICAgIAlwdXNoICAgJWVzaQ0KIDE4NToJNTMgICAgICAgICAgICAgICAg
ICAgCXB1c2ggICAlZWJ4DQogMTg2Ogk4MyBlYyAwNCAgICAgICAgICAgICAJ
c3ViICAgICQweDQsJWVzcA0KIDE4OToJOGIgNWQgMTQgICAgICAgICAgICAg
CW1vdiAgICAweDE0KCVlYnApLCVlYngNCiAxOGM6CTg5IDY1IGYwICAgICAg
ICAgICAgIAltb3YgICAgJWVzcCwweGZmZmZmZmYwKCVlYnApDQogMThmOgk4
OSBkYSAgICAgICAgICAgICAgICAJbW92ICAgICVlYngsJWVkeA0KIDE5MToJ
ODMgYzIgMWYgICAgICAgICAgICAgCWFkZCAgICAkMHgxZiwlZWR4DQogMTk0
Ogk4ZCA0MyAzZSAgICAgICAgICAgICAJbGVhICAgIDB4M2UoJWVieCksJWVh
eA0KIDE5NzoJMGYgNDggZDAgICAgICAgICAgICAgCWNtb3ZzICAlZWF4LCVl
ZHgNCiAxOWE6CWMxIGZhIDA1ICAgICAgICAgICAgIAlzYXIgICAgJDB4NSwl
ZWR4DQogMTlkOgljMSBlMiAwMiAgICAgICAgICAgICAJc2hsICAgICQweDIs
JWVkeA0KIDFhMDoJOGQgNDIgMTAgICAgICAgICAgICAgCWxlYSAgICAweDEw
KCVlZHgpLCVlYXgNCiAxYTM6CTI5IGM0ICAgICAgICAgICAgICAgIAlzdWIg
ICAgJWVheCwlZXNwDQogMWE1Ogk4ZCA3NCAyNCAxYiAgICAgICAgICAJbGVh
ICAgIDB4MWIoJWVzcCwxKSwlZXNpDQogMWE5Ogk4MyBlNiBmMCAgICAgICAg
ICAgICAJYW5kICAgICQweGZmZmZmZmYwLCVlc2kNCiAxYWM6CTg5IGQxICAg
ICAgICAgICAgICAgIAltb3YgICAgJWVkeCwlZWN4DQogMWFlOgkzMSBjMCAg
ICAgICAgICAgICAgICAJeG9yICAgICVlYXgsJWVheA0KIDFiMDoJYzEgZTkg
MDIgICAgICAgICAgICAgCXNociAgICAkMHgyLCVlY3gNCiAxYjM6CTg5IGY3
ICAgICAgICAgICAgICAgIAltb3YgICAgJWVzaSwlZWRpDQogMWI1OglmMyBh
YiAgICAgICAgICAgICAgICAJcmVweiBzdG9zICVlYXgsJWVzOiglZWRpKQ0K
IDFiNzoJZjYgYzIgMDIgICAgICAgICAgICAgCXRlc3QgICAkMHgyLCVkbA0K
IDFiYToJNzQgMDIgICAgICAgICAgICAgICAgCWplICAgICAxYmUgPGJpdG1h
cF9zaGlmdF9yaWdodCsweDNlPg0KIDFiYzoJNjYgYWIgICAgICAgICAgICAg
ICAgCXN0b3MgICAlYXgsJWVzOiglZWRpKQ0KIDFiZToJZjYgYzIgMDEgICAg
ICAgICAgICAgCXRlc3QgICAkMHgxLCVkbA0KIDFjMToJNzQgMDEgICAgICAg
ICAgICAgICAgCWplICAgICAxYzQgPGJpdG1hcF9zaGlmdF9yaWdodCsweDQ0
Pg0KIDFjMzoJYWEgICAgICAgICAgICAgICAgICAgCXN0b3MgICAlYWwsJWVz
OiglZWRpKQ0KIDFjNDoJOGIgN2QgMTAgICAgICAgICAgICAgCW1vdiAgICAw
eDEwKCVlYnApLCVlZGkNCiAxYzc6CTg5IGQ4ICAgICAgICAgICAgICAgIAlt
b3YgICAgJWVieCwlZWF4DQogMWM5OgkzMSBkMiAgICAgICAgICAgICAgICAJ
eG9yICAgICVlZHgsJWVkeA0KIDFjYjoJMjkgZjggICAgICAgICAgICAgICAg
CXN1YiAgICAlZWRpLCVlYXgNCiAxY2Q6CTM5IGMyICAgICAgICAgICAgICAg
IAljbXAgICAgJWVheCwlZWR4DQogMWNmOgk3ZCAyYSAgICAgICAgICAgICAg
ICAJamdlICAgIDFmYiA8Yml0bWFwX3NoaWZ0X3JpZ2h0KzB4N2I+DQogMWQx
Ogk4OSBjMSAgICAgICAgICAgICAgICAJbW92ICAgICVlYXgsJWVjeA0KIDFk
MzoJOGQgYjYgMDAgMDAgMDAgMDAgICAgCWxlYSAgICAweDAoJWVzaSksJWVz
aQ0KIDFkOToJOGQgYmMgMjcgMDAgMDAgMDAgMDAgCWxlYSAgICAweDAoJWVk
aSwxKSwlZWRpDQogMWUwOgk4YiA3ZCAxMCAgICAgICAgICAgICAJbW92ICAg
IDB4MTAoJWVicCksJWVkaQ0KIDFlMzoJOGQgMDQgMTcgICAgICAgICAgICAg
CWxlYSAgICAoJWVkaSwlZWR4LDEpLCVlYXgNCiAxZTY6CThiIDdkIDBjICAg
ICAgICAgICAgIAltb3YgICAgMHhjKCVlYnApLCVlZGkNCiAxZTk6CTBmIGEz
IDA3ICAgICAgICAgICAgIAlidCAgICAgJWVheCwoJWVkaSkNCiAxZWM6CTE5
IGMwICAgICAgICAgICAgICAgIAlzYmIgICAgJWVheCwlZWF4DQogMWVlOgk4
NSBjMCAgICAgICAgICAgICAgICAJdGVzdCAgICVlYXgsJWVheA0KIDFmMDoJ
NzQgMDQgICAgICAgICAgICAgICAgCWplICAgICAxZjYgPGJpdG1hcF9zaGlm
dF9yaWdodCsweDc2Pg0KIDFmMjoJZjAgMGYgYWIgMTYgICAgICAgICAgCWxv
Y2sgYnRzICVlZHgsKCVlc2kpDQogMWY2Ogk0MiAgICAgICAgICAgICAgICAg
ICAJaW5jICAgICVlZHgNCiAxZjc6CTM5IGNhICAgICAgICAgICAgICAgIAlj
bXAgICAgJWVjeCwlZWR4DQogMWY5Ogk3YyBlNSAgICAgICAgICAgICAgICAJ
amwgICAgIDFlMCA8Yml0bWFwX3NoaWZ0X3JpZ2h0KzB4NjA+DQogMWZiOgk4
OSBkOCAgICAgICAgICAgICAgICAJbW92ICAgICVlYngsJWVheA0KIDFmZDoJ
OGQgNTMgM2UgICAgICAgICAgICAgCWxlYSAgICAweDNlKCVlYngpLCVlZHgN
CiAyMDA6CTgzIGMwIDFmICAgICAgICAgICAgIAlhZGQgICAgJDB4MWYsJWVh
eA0KIDIwMzoJMGYgNDggYzIgICAgICAgICAgICAgCWNtb3ZzICAlZWR4LCVl
YXgNCiAyMDY6CWMxIGY4IDA1ICAgICAgICAgICAgIAlzYXIgICAgJDB4NSwl
ZWF4DQogMjA5OgljMSBlMCAwMiAgICAgICAgICAgICAJc2hsICAgICQweDIs
JWVheA0KIDIwYzoJODkgYzEgICAgICAgICAgICAgICAgCW1vdiAgICAlZWF4
LCVlY3gNCiAyMGU6CWMxIGU5IDAyICAgICAgICAgICAgIAlzaHIgICAgJDB4
MiwlZWN4DQogMjExOgk4YiA3ZCAwOCAgICAgICAgICAgICAJbW92ICAgIDB4
OCglZWJwKSwlZWRpDQogMjE0OglmMyBhNSAgICAgICAgICAgICAgICAJcmVw
eiBtb3ZzbCAlZHM6KCVlc2kpLCVlczooJWVkaSkNCiAyMTY6CWE4IDAyICAg
ICAgICAgICAgICAgIAl0ZXN0ICAgJDB4MiwlYWwNCiAyMTg6CTc0IDAyICAg
ICAgICAgICAgICAgIAlqZSAgICAgMjFjIDxiaXRtYXBfc2hpZnRfcmlnaHQr
MHg5Yz4NCiAyMWE6CTY2IGE1ICAgICAgICAgICAgICAgIAltb3ZzdyAgJWRz
OiglZXNpKSwlZXM6KCVlZGkpDQogMjFjOglhOCAwMSAgICAgICAgICAgICAg
ICAJdGVzdCAgICQweDEsJWFsDQogMjFlOgk3NCAwMSAgICAgICAgICAgICAg
ICAJamUgICAgIDIyMSA8Yml0bWFwX3NoaWZ0X3JpZ2h0KzB4YTE+DQogMjIw
OglhNCAgICAgICAgICAgICAgICAgICAJbW92c2IgICVkczooJWVzaSksJWVz
OiglZWRpKQ0KIDIyMToJOGIgNjUgZjAgICAgICAgICAgICAgCW1vdiAgICAw
eGZmZmZmZmYwKCVlYnApLCVlc3ANCiAyMjQ6CThkIDY1IGY0ICAgICAgICAg
ICAgIAlsZWEgICAgMHhmZmZmZmZmNCglZWJwKSwlZXNwDQogMjI3Ogk1YiAg
ICAgICAgICAgICAgICAgICAJcG9wICAgICVlYngNCiAyMjg6CTVlICAgICAg
ICAgICAgICAgICAgIAlwb3AgICAgJWVzaQ0KIDIyOToJNWYgICAgICAgICAg
ICAgICAgICAgCXBvcCAgICAlZWRpDQogMjJhOgk1ZCAgICAgICAgICAgICAg
ICAgICAJcG9wICAgICVlYnANCiAyMmI6CWMzICAgICAgICAgICAgICAgICAg
IAlyZXQgICAgDQo=
--8323328-1329723834-1075754554=:16648--
