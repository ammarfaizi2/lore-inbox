Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310182AbSCAXmf>; Fri, 1 Mar 2002 18:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310188AbSCAXm0>; Fri, 1 Mar 2002 18:42:26 -0500
Received: from fungus.teststation.com ([212.32.186.211]:8208 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S310184AbSCAXmS>; Fri, 1 Mar 2002 18:42:18 -0500
Date: Sat, 2 Mar 2002 00:41:58 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Cyrille Chepelov <cyrille@chepelov.org>,
        =?iso-8859-1?Q?Christian_Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>,
        <linux-kernel@vger.kernel.org>
cc: Alexander Viro <viro@math.psu.edu>
Subject: [PATCH] smbfs codepage fixes for 2.4.18
Message-ID: <Pine.LNX.4.33.0203012220240.22195-200000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463780587-1260605775-1015025226=:23050"
Content-ID: <Pine.LNX.4.33.0203020027210.23050@cola.teststation.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463780587-1260605775-1015025226=:23050
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33.0203020027211.23050@cola.teststation.com>


Ok, I think I've got something regarding the 2.4.18 oopses. (oopsen?)

There are two errors in the changes to smbfs in 2.4.18-rc3 (and 2.5.5)
1. SMB_MAXNAMELEN (max length of a single path component) was used where
   SMB_MAXPATHLEN (max total path length) should have been used.
2. The charset conversion routine was modified to return errors as
   negative values but not all callers was changed to handle this. When an 
   "illegal" character was hit the length of the string was set to 
   0xffffffff and when computing the hash value it read outside the kernel 
   memory.

Attached is a patch vs 2.4.18 that fixes these issues for me. Please test
and let me know.

If I select a codepage/charset combination that doesn't match I now get a
somewhat cryptic message instead of an oops (just a temporary thing).
    "smbfs: filename charset conversion failed"

The file is then hidden, which is bad. Conversion errors should map to '?'
as they used to or do some translation into ":####" strings. I'll do
something about that.


Some comments on what some of you have been doing:

The smbfs remote codepage can never be utf8 since there are no smb servers
that talk utf8. It can be one of the dos codepages, it can be blank or
with additional patches it can be a 2 byte little endian unicode format.

Furthermore, the local charset must be one that matches the chars used in
the remote set. Otherwise you get conversion errors. A few known good
combinations are:

cp850 <-> iso8859-1
cp866 <-> koi8-r
cp932 <-> euc-jp
(the right is the local = linux side)

See also the smb.conf manpage.

But even with these it seems to be possible to create chars that do not
match, and I think it is caused by windows trying to map unicode to a
codepage and not finding a matching char to use.

Local utf8 always matches the remote and is preferred if your system is
setup to handle it.

I would explain the reported
    smb_proc_readdir_long: name=<directory> result=-2, rcls=1, err=2
as a name conversion problem. If the conversion failed one way it used to
be truncated and would then fail when sent back to the server. The error
is ERRDOS - ERRbadfile (File not found).

Check the config and the nls maps used.

/Urban

---1463780587-1260605775-1015025226=:23050
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="smbfs-2.4.18-codepage.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0203020027060.23050@cola.teststation.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="smbfs-2.4.18-codepage.patch"

ZGlmZiAtdXJOIC1YIGV4Y2x1ZGUgbGludXgtMi40LjE4LW9yaWcvZnMvc21i
ZnMvY2FjaGUuYyBsaW51eC0yLjQuMTgtc21iZnMvZnMvc21iZnMvY2FjaGUu
Yw0KLS0tIGxpbnV4LTIuNC4xOC1vcmlnL2ZzL3NtYmZzL2NhY2hlLmMJU2F0
IEphbiAxMiAxNjo1NTo1OCAyMDAyDQorKysgbGludXgtMi40LjE4LXNtYmZz
L2ZzL3NtYmZzL2NhY2hlLmMJRnJpIE1hciAgMSAyMTo0NjozNiAyMDAyDQpA
QCAtODQsNyArODQsNyBAQA0KIAlzdHJ1Y3QgbGlzdF9oZWFkICpuZXh0Ow0K
IA0KIAlpZiAoZF92YWxpZGF0ZShkZW50LCBwYXJlbnQpKSB7DQotCQlpZiAo
ZGVudC0+ZF9uYW1lLmxlbiA8PSBTTUJfTUFYUEFUSExFTiAmJg0KKwkJaWYg
KGRlbnQtPmRfbmFtZS5sZW4gPD0gU01CX01BWE5BTUVMRU4gJiYNCiAJCSAg
ICAodW5zaWduZWQgbG9uZylkZW50LT5kX2ZzZGF0YSA9PSBmcG9zKSB7DQog
CQkJaWYgKCFkZW50LT5kX2lub2RlKSB7DQogCQkJCWRwdXQoZGVudCk7DQpk
aWZmIC11ck4gLVggZXhjbHVkZSBsaW51eC0yLjQuMTgtb3JpZy9mcy9zbWJm
cy9wcm9jLmMgbGludXgtMi40LjE4LXNtYmZzL2ZzL3NtYmZzL3Byb2MuYw0K
LS0tIGxpbnV4LTIuNC4xOC1vcmlnL2ZzL3NtYmZzL3Byb2MuYwlGcmkgTWFy
ICAxIDIwOjIzOjM4IDIwMDINCisrKyBsaW51eC0yLjQuMTgtc21iZnMvZnMv
c21iZnMvcHJvYy5jCVNhdCBNYXIgIDIgMDA6MDQ6MjIgMjAwMg0KQEAgLTEx
OSwxMSArMTE5LDYgQEANCiAJaW50IG47DQogCXdjaGFyX3QgY2g7DQogDQot
CWlmICghbmxzX2Zyb20gfHwgIW5sc190bykgew0KLQkJUEFSQU5PSUEoIm5s
c19mcm9tPSVwLCBubHNfdG89JXBcbiIsIG5sc19mcm9tLCBubHNfdG8pOw0K
LQkJcmV0dXJuIGNvbnZlcnRfbWVtY3B5KG91dHB1dCwgb2xlbiwgaW5wdXQs
IGlsZW4sIE5VTEwsIE5VTEwpOw0KLQl9DQotDQogCXdoaWxlIChpbGVuID4g
MCkgew0KIAkJLyogY29udmVydCBieSBjaGFuZ2luZyB0byB1bmljb2RlIGFu
ZCBiYWNrIHRvIHRoZSBuZXcgY3AgKi8NCiAJCW4gPSBubHNfZnJvbS0+Y2hh
cjJ1bmkoKHVuc2lnbmVkIGNoYXIgKilpbnB1dCwgaWxlbiwgJmNoKTsNCkBA
IC0xNDEsNiArMTM2LDEwIEBADQogCQlsZW4gKz0gbjsNCiAJfQ0KIAlyZXR1
cm4gbGVuOw0KKw0KKwkvKiBGSVhNRTogdGhlc2UgZXJyb3IgcmV0dXJucyB3
aWxsIHNpbXBseSBtYWtlIHRoZSBmaWxlcyBkaXNhcHBlYXINCisJICAgaWYg
dGhlcmUgaXMgYSBjb2RlcGFnZSBlcnJvci4gdW5pX3hsYXRlPyBPciB0cmVh
dCBkaWZmZXJlbnQgZXJyb3JzDQorCSAgIGRpZmZlcmVudGx5PyAqLw0KIGZh
aWw6DQogCXJldHVybiBuOw0KIH0NCkBAIC0yMjYsOCArMjI1LDggQEANCiAJ
aWYgKG1heGxlbiA8IDIpDQogCQlyZXR1cm4gLUVOQU1FVE9PTE9ORzsNCiAN
Ci0JaWYgKG1heGxlbiA+IFNNQl9NQVhOQU1FTEVOICsgMSkNCi0JCW1heGxl
biA9IFNNQl9NQVhOQU1FTEVOICsgMTsNCisJaWYgKG1heGxlbiA+IFNNQl9N
QVhQQVRITEVOICsgMSkNCisJCW1heGxlbiA9IFNNQl9NQVhQQVRITEVOICsg
MTsNCiANCiAJaWYgKGVudHJ5ID09IE5VTEwpDQogCQlnb3RvIHRlc3RfbmFt
ZV9hbmRfb3V0Ow0KQEAgLTE1NzksMTIgKzE1NzgsMTYgQEANCiAJfQ0KICNl
bmRpZg0KIA0KLQlxbmFtZS0+bGVuID0gc2VydmVyLT5jb252ZXJ0KHNlcnZl
ci0+bmFtZV9idWYsIFNNQl9NQVhOQU1FTEVOLA0KLQkJCQkgICAgIHFuYW1l
LT5uYW1lLCBsZW4sDQotCQkJCSAgICAgc2VydmVyLT5yZW1vdGVfbmxzLCBz
ZXJ2ZXItPmxvY2FsX25scyk7DQotCXFuYW1lLT5uYW1lID0gc2VydmVyLT5u
YW1lX2J1ZjsNCisJcW5hbWUtPmxlbiA9IDA7DQorCWxlbiA9IHNlcnZlci0+
Y29udmVydChzZXJ2ZXItPm5hbWVfYnVmLCBTTUJfTUFYTkFNRUxFTiwNCisJ
CQkgICAgcW5hbWUtPm5hbWUsIGxlbiwNCisJCQkgICAgc2VydmVyLT5yZW1v
dGVfbmxzLCBzZXJ2ZXItPmxvY2FsX25scyk7DQorCWlmIChsZW4gPiAwKSB7
DQorCQlxbmFtZS0+bGVuID0gbGVuOw0KKwkJcW5hbWUtPm5hbWUgPSBzZXJ2
ZXItPm5hbWVfYnVmOw0KKwkJREVCVUcxKCJsZW49JWQsIG5hbWU9JS4qc1xu
IixxbmFtZS0+bGVuLHFuYW1lLT5sZW4scW5hbWUtPm5hbWUpOw0KKwl9DQog
DQotCURFQlVHMSgibGVuPSVkLCBuYW1lPSUuKnNcbiIsIHFuYW1lLT5sZW4s
IHFuYW1lLT5sZW4sIHFuYW1lLT5uYW1lKTsNCiAJcmV0dXJuIHAgKyAyMjsN
CiB9DQogDQpAQCAtMTcwMCw2ICsxNzAzLDEwIEBADQogCQlmb3IgKGkgPSAw
OyBpIDwgY291bnQ7IGkrKykgew0KIAkJCXAgPSBzbWJfZGVjb2RlX3Nob3J0
X2RpcmVudChzZXJ2ZXIsIHAsIA0KIAkJCQkJCSAgICAmcW5hbWUsICZmYXR0
cik7DQorCQkJaWYgKHFuYW1lLmxlbiA9PSAwKSB7DQorCQkJCXByaW50ayhL
RVJOX0VSUiAic21iZnM6IGZpbGVuYW1lIGNoYXJzZXQgY29udmVyc2lvbiBm
YWlsZWRcbiIpOw0KKwkJCQljb250aW51ZTsNCisJCQl9DQogDQogCQkJaWYg
KGVudHJpZXNfc2VlbiA9PSAyICYmIHFuYW1lLm5hbWVbMF0gPT0gJy4nKSB7
DQogCQkJCWlmIChxbmFtZS5sZW4gPT0gMSkNCkBAIC0xNzM3LDYgKzE3NDQs
NyBAQA0KIHsNCiAJY2hhciAqcmVzdWx0Ow0KIAl1bnNpZ25lZCBpbnQgbGVu
ID0gMDsNCisJaW50IG47DQogCV9fdTE2IGRhdGUsIHRpbWU7DQogDQogCS8q
DQpAQCAtMTgxMiwxMCArMTgyMCwxNCBAQA0KIAl9DQogI2VuZGlmDQogDQot
CXFuYW1lLT5sZW4gPSBzZXJ2ZXItPmNvbnZlcnQoc2VydmVyLT5uYW1lX2J1
ZiwgU01CX01BWE5BTUVMRU4sDQotCQkJCSAgICAgcW5hbWUtPm5hbWUsIGxl
biwNCi0JCQkJICAgICBzZXJ2ZXItPnJlbW90ZV9ubHMsIHNlcnZlci0+bG9j
YWxfbmxzKTsNCi0JcW5hbWUtPm5hbWUgPSBzZXJ2ZXItPm5hbWVfYnVmOw0K
KwlxbmFtZS0+bGVuID0gMDsNCisJbiA9IHNlcnZlci0+Y29udmVydChzZXJ2
ZXItPm5hbWVfYnVmLCBTTUJfTUFYTkFNRUxFTiwNCisJCQkgICAgcW5hbWUt
Pm5hbWUsIGxlbiwNCisJCQkgICAgc2VydmVyLT5yZW1vdGVfbmxzLCBzZXJ2
ZXItPmxvY2FsX25scyk7DQorCWlmIChuID4gMCkgew0KKwkJcW5hbWUtPmxl
biA9IG47DQorCQlxbmFtZS0+bmFtZSA9IHNlcnZlci0+bmFtZV9idWY7DQor
CX0NCiANCiBvdXQ6DQogCXJldHVybiByZXN1bHQ7DQpAQCAtMTg4MSw3ICsx
ODkzLDcgQEANCiAJICovDQogCW1hc2sgPSBwYXJhbSArIDEyOw0KIA0KLQlt
YXNrX2xlbiA9IHNtYl9lbmNvZGVfcGF0aChzZXJ2ZXIsIG1hc2ssIFNNQl9N
QVhOQU1FTEVOKzEsIGRpciwgJnN0YXIpOw0KKwltYXNrX2xlbiA9IHNtYl9l
bmNvZGVfcGF0aChzZXJ2ZXIsIG1hc2ssIFNNQl9NQVhQQVRITEVOKzEsIGRp
ciwgJnN0YXIpOw0KIAlpZiAobWFza19sZW4gPCAwKSB7DQogCQlyZXN1bHQg
PSBtYXNrX2xlbjsNCiAJCWdvdG8gdW5sb2NrX3JldHVybjsNCkBAIC0yMDMw
LDYgKzIwNDIsMTAgQEANCiANCiAJCQlwID0gc21iX2RlY29kZV9sb25nX2Rp
cmVudChzZXJ2ZXIsIHAsIGluZm9fbGV2ZWwsDQogCQkJCQkJICAgJnFuYW1l
LCAmZmF0dHIpOw0KKwkJCWlmIChxbmFtZS5sZW4gPT0gMCkgew0KKwkJCQlw
cmludGsoS0VSTl9FUlIgInNtYmZzOiBmaWxlbmFtZSBjaGFyc2V0IGNvbnZl
cnNpb24gZmFpbGVkXG4iKTsNCisJCQkJY29udGludWU7DQorCQkJfQ0KIA0K
IAkJCS8qIGlnbm9yZSAuIGFuZCAuLiBmcm9tIHRoZSBzZXJ2ZXIgKi8NCiAJ
CQlpZiAoZW50cmllc19zZWVuID09IDIgJiYgcW5hbWUubmFtZVswXSA9PSAn
LicpIHsNCkBAIC0yMDg4LDcgKzIxMDQsNyBAQA0KIAlpbnQgbWFza19sZW4s
IHJlc3VsdDsNCiANCiByZXRyeToNCi0JbWFza19sZW4gPSBzbWJfZW5jb2Rl
X3BhdGgoc2VydmVyLCBtYXNrLCBTTUJfTUFYTkFNRUxFTisxLCBkZW50cnks
IE5VTEwpOw0KKwltYXNrX2xlbiA9IHNtYl9lbmNvZGVfcGF0aChzZXJ2ZXIs
IG1hc2ssIFNNQl9NQVhQQVRITEVOKzEsIGRlbnRyeSwgTlVMTCk7DQogCWlm
IChtYXNrX2xlbiA8IDApIHsNCiAJCXJlc3VsdCA9IG1hc2tfbGVuOw0KIAkJ
Z290byBvdXQ7DQpAQCAtMjIxNCw3ICsyMjMwLDcgQEANCiAgICAgICByZXRy
eToNCiAJV1NFVChwYXJhbSwgMCwgMSk7CS8qIEluZm8gbGV2ZWwgU01CX0lO
Rk9fU1RBTkRBUkQgKi8NCiAJRFNFVChwYXJhbSwgMiwgMCk7DQotCXJlc3Vs
dCA9IHNtYl9lbmNvZGVfcGF0aChzZXJ2ZXIsIHBhcmFtKzYsIFNNQl9NQVhO
QU1FTEVOKzEsIGRpciwgTlVMTCk7DQorCXJlc3VsdCA9IHNtYl9lbmNvZGVf
cGF0aChzZXJ2ZXIsIHBhcmFtKzYsIFNNQl9NQVhQQVRITEVOKzEsIGRpciwg
TlVMTCk7DQogCWlmIChyZXN1bHQgPCAwKQ0KIAkJZ290byBvdXQ7DQogCXAg
PSBwYXJhbSArIDYgKyByZXN1bHQ7DQpAQCAtMjQ2NCw3ICsyNDgwLDcgQEAN
CiAgICAgICByZXRyeToNCiAJV1NFVChwYXJhbSwgMCwgMSk7CS8qIEluZm8g
bGV2ZWwgU01CX0lORk9fU1RBTkRBUkQgKi8NCiAJRFNFVChwYXJhbSwgMiwg
MCk7DQotCXJlc3VsdCA9IHNtYl9lbmNvZGVfcGF0aChzZXJ2ZXIsIHBhcmFt
KzYsIFNNQl9NQVhOQU1FTEVOKzEsIGRpciwgTlVMTCk7DQorCXJlc3VsdCA9
IHNtYl9lbmNvZGVfcGF0aChzZXJ2ZXIsIHBhcmFtKzYsIFNNQl9NQVhQQVRI
TEVOKzEsIGRpciwgTlVMTCk7DQogCWlmIChyZXN1bHQgPCAwKQ0KIAkJZ290
byBvdXQ7DQogCXAgPSBwYXJhbSArIDYgKyByZXN1bHQ7DQo=
---1463780587-1260605775-1015025226=:23050--
