Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVD0QWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVD0QWb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 12:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVD0QWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 12:22:22 -0400
Received: from fmr18.intel.com ([134.134.136.17]:58312 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261798AbVD0QVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 12:21:02 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C54B45.121D49E7"
Subject: RE: [discuss] [Patch] X86_64 TASK_SIZE cleanup - more comments
Date: Thu, 28 Apr 2005 00:20:47 +0800
Message-ID: <894E37DECA393E4D9374E0ACBBE74270013E8BDD@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [discuss] [Patch] X86_64 TASK_SIZE cleanup - more comments
Thread-Index: AcVH5ED6hBWD1Y97Sn2U0Hi9Ih8jdwDXlEQQ
From: "Zou, Nanhai" <nanhai.zou@intel.com>
To: "Alexander Nyberg" <alexn@dsv.su.se>
Cc: "Andi Kleen" <ak@suse.de>, <discuss@x86-64.org>,
       <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
X-OriginalArrivalTime: 27 Apr 2005 16:20:48.0612 (UTC) FILETIME=[128F1240:01C54B45]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C54B45.121D49E7
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
That patch is wrong for earlier kernel. There will be a memory leak on
page tables.
The reason is syscall page was not backup by VMA, clear_page_tables will
only clear up to TASK_SIZE, so there will be a leak on syscall page.

But in 2.6.11 kernel, clear_page_range will clear more page tables than
that.
I have tested my patch on 2.6.11 kernel.
Do a chroot bash to 32 bit system, then a 32 bit ltp test. No issue was
found.

However I found the patch is not compatible with recent 2.6.12-rc3
kernel.
In rc3 kernel, syscall page is backup with VMA, thus the special case
code to deal with syscall page was removed from arch/x86_64/mm/fault.c.

So I changed the patch to rebase it on 2.6.12-rc3,=20
This patch has been tested on 2.6.12-rc3

by chroot to a 32 bit system,=20
then follow an 32 bit ltp test.

Signed-off-by: Suresh Siddha <suresh.b.siddha@xxxxxxxxx>=20
Signed-off-by: Zou Nan hai <Nanhai.zou@xxxxxxxxx>

> -----Original Message-----
> From: Alexander Nyberg [mailto:alexn@dsv.su.se]
> Sent: Saturday, April 23, 2005 5:10 PM
> To: Zou, Nanhai
> Cc: Andi Kleen; discuss@x86-64.org; linux-kernel@vger.kernel.org;
Siddha,
> Suresh B
> Subject: RE: [discuss] [Patch] X86_64 TASK_SIZE cleanup - more
comments
>=20
> > PPC64 IA64 and S390 use variable size TASK_SIZE for 32 bit and 64
bit
> > program.
> > I feel it is hard to maintain if we try to audit TASK_SIZE use
> > everywhere, because most of them are in generic code.
> >
> > And maintaining those audit code in separate place is also a
problem.
> > E.g. in current 32 bit emulation code
> > TASK_SIZE is defined as 0xfffffff in elf loading, but defined as
> > 0xffffe000 in mmaping.
> >
> > How did that earlier patch break applications?
>=20
> http://www.ussg.iu.edu/hypermail/linux/kernel/0408.2/1605.html
>=20
> I never investigated specifically what broke down


------_=_NextPart_001_01C54B45.121D49E7
Content-Type: application/octet-stream;
	name="x86_64-compat-tasksize-fix.patch"
Content-Transfer-Encoding: base64
Content-Description: x86_64-compat-tasksize-fix.patch
Content-Disposition: attachment;
	filename="x86_64-compat-tasksize-fix.patch"

ZGlmZiAtTnJhdXAgYS9hcmNoL3g4Nl82NC9pYTMyL2lhMzJfYmluZm10LmMgYi9hcmNoL3g4Nl82
NC9pYTMyL2lhMzJfYmluZm10LmMKLS0tIGEvYXJjaC94ODZfNjQvaWEzMi9pYTMyX2JpbmZtdC5j
CTIwMDUtMDQtMjcgMDc6MDQ6MzMuMDAwMDAwMDAwICswODAwCisrKyBiL2FyY2gveDg2XzY0L2lh
MzIvaWEzMl9iaW5mbXQuYwkyMDA1LTA0LTI3IDA3OjA5OjMzLjAwMDAwMDAwMCArMDgwMApAQCAt
NDYsNyArNDYsNyBAQCBzdHJ1Y3QgZWxmX3BoZHI7IAogCiAjZGVmaW5lIElBMzJfRU1VTEFUT1Ig
MQogCi0jZGVmaW5lIEVMRl9FVF9EWU5fQkFTRQkJKFRBU0tfVU5NQVBQRURfMzIgKyAweDEwMDAw
MDApCisjZGVmaW5lIEVMRl9FVF9EWU5fQkFTRQkJKFRBU0tfVU5NQVBQRURfQkFTRSArIDB4MTAw
MDAwMCkKIAogI3VuZGVmIEVMRl9BUkNICiAjZGVmaW5lIEVMRl9BUkNIIEVNXzM4NgpAQCAtMzA3
LDkgKzMwNyw2IEBAIE1PRFVMRV9BVVRIT1IoIkVyaWMgWW91bmdkYWxlLCBBbmRpIEtsZWUKIAog
I2RlZmluZSBlbGZfYWRkcl90IF9fdTMyCiAKLSN1bmRlZiBUQVNLX1NJWkUKLSNkZWZpbmUgVEFT
S19TSVpFIDB4ZmZmZmZmZmYKLQogc3RhdGljIHZvaWQgZWxmMzJfaW5pdChzdHJ1Y3QgcHRfcmVn
cyAqKTsKIAogI2RlZmluZSBBUkNIX0hBU19TRVRVUF9BRERJVElPTkFMX1BBR0VTIDEKZGlmZiAt
TnJhdXAgYS9hcmNoL3g4Nl82NC9rZXJuZWwvc3lzX3g4Nl82NC5jIGIvYXJjaC94ODZfNjQva2Vy
bmVsL3N5c194ODZfNjQuYwotLS0gYS9hcmNoL3g4Nl82NC9rZXJuZWwvc3lzX3g4Nl82NC5jCTIw
MDUtMDQtMjcgMDc6MDQ6MzMuMDAwMDAwMDAwICswODAwCisrKyBiL2FyY2gveDg2XzY0L2tlcm5l
bC9zeXNfeDg2XzY0LmMJMjAwNS0wNC0yNyAwNzowOTo1OC4wMDAwMDAwMDAgKzA4MDAKQEAgLTY4
LDEzICs2OCw3IEBAIG91dDoKIHN0YXRpYyB2b2lkIGZpbmRfc3RhcnRfZW5kKHVuc2lnbmVkIGxv
bmcgZmxhZ3MsIHVuc2lnbmVkIGxvbmcgKmJlZ2luLAogCQkJICAgdW5zaWduZWQgbG9uZyAqZW5k
KQogewotI2lmZGVmIENPTkZJR19JQTMyX0VNVUxBVElPTgotCWlmICh0ZXN0X3RocmVhZF9mbGFn
KFRJRl9JQTMyKSkgeyAKLQkJKmJlZ2luID0gVEFTS19VTk1BUFBFRF8zMjsKLQkJKmVuZCA9IElB
MzJfUEFHRV9PRkZTRVQ7IAotCX0gZWxzZSAKLSNlbmRpZgotCWlmIChmbGFncyAmIE1BUF8zMkJJ
VCkgeyAKKwlpZiAoIXRlc3RfdGhyZWFkX2ZsYWcoVElGX0lBMzIpICYmIChmbGFncyAmIE1BUF8z
MkJJVCkpIHsKIAkJLyogVGhpcyBpcyB1c3VhbGx5IHVzZWQgbmVlZGVkIHRvIG1hcCBjb2RlIGlu
IHNtYWxsCiAJCSAgIG1vZGVsLCBzbyBpdCBuZWVkcyB0byBiZSBpbiB0aGUgZmlyc3QgMzFiaXQu
IExpbWl0CiAJCSAgIGl0IHRvIHRoYXQuICBUaGlzIG1lYW5zIHdlIG5lZWQgdG8gbW92ZSB0aGUK
QEAgLTg0LDEwICs3OCwxMCBAQCBzdGF0aWMgdm9pZCBmaW5kX3N0YXJ0X2VuZCh1bnNpZ25lZCBs
b25nCiAJCSAgIG9mIHBsYXlncm91bmQgZm9yIG5vdy4gLUFLICovIAogCQkqYmVnaW4gPSAweDQw
MDAwMDAwOyAKIAkJKmVuZCA9IDB4ODAwMDAwMDA7CQkKLQl9IGVsc2UgeyAKLQkJKmJlZ2luID0g
VEFTS19VTk1BUFBFRF82NDsgCisJfSBlbHNlIHsKKwkJKmJlZ2luID0gVEFTS19VTk1BUFBFRF9C
QVNFOwogCQkqZW5kID0gVEFTS19TSVpFOyAKLQkJfQorCX0KIH0gCiAKIHVuc2lnbmVkIGxvbmcK
ZGlmZiAtTnJhdXAgYS9hcmNoL3g4Nl82NC9tbS9mYXVsdC5jIGIvYXJjaC94ODZfNjQvbW0vZmF1
bHQuYwotLS0gYS9hcmNoL3g4Nl82NC9tbS9mYXVsdC5jCTIwMDUtMDQtMjcgMDc6MDQ6MzMuMDAw
MDAwMDAwICswODAwCisrKyBiL2FyY2gveDg2XzY0L21tL2ZhdWx0LmMJMjAwNS0wNC0yNyAwNzow
ODozOS4wMDAwMDAwMDAgKzA4MDAKQEAgLTc0LDcgKzc0LDcgQEAgc3RhdGljIG5vaW5saW5lIGlu
dCBpc19wcmVmZXRjaChzdHJ1Y3QgcAogCWluc3RyID0gKHVuc2lnbmVkIGNoYXIgKiljb252ZXJ0
X3JpcF90b19saW5lYXIoY3VycmVudCwgcmVncyk7CiAJbWF4X2luc3RyID0gaW5zdHIgKyAxNTsK
IAotCWlmICgocmVncy0+Y3MgJiAzKSAhPSAwICYmIGluc3RyID49ICh1bnNpZ25lZCBjaGFyICop
VEFTS19TSVpFKQorCWlmICgocmVncy0+Y3MgJiAzKSAhPSAwICYmIGluc3RyID49ICh1bnNpZ25l
ZCBjaGFyICopVEFTS19TSVpFNjQpCiAJCXJldHVybiAwOwogCiAJd2hpbGUgKHNjYW5fbW9yZSAm
JiBpbnN0ciA8IG1heF9pbnN0cikgeyAKQEAgLTM0NSw3ICszNDUsNyBAQCBhc21saW5rYWdlIHZv
aWQgZG9fcGFnZV9mYXVsdChzdHJ1Y3QgcHRfCiAJICogKGVycm9yX2NvZGUgJiA0KSA9PSAwLCBh
bmQgdGhhdCB0aGUgZmF1bHQgd2FzIG5vdCBhCiAJICogcHJvdGVjdGlvbiBlcnJvciAoZXJyb3Jf
Y29kZSAmIDEpID09IDAuCiAJICovCi0JaWYgKHVubGlrZWx5KGFkZHJlc3MgPj0gVEFTS19TSVpF
KSkgeworCWlmICh1bmxpa2VseShhZGRyZXNzID49IFRBU0tfU0laRTY0KSkgewogCQlpZiAoIShl
cnJvcl9jb2RlICYgNSkpIHsKIAkJCWlmICh2bWFsbG9jX2ZhdWx0KGFkZHJlc3MpIDwgMCkKIAkJ
CQlnb3RvIGJhZF9hcmVhX25vc2VtYXBob3JlOwpAQCAtNDgxLDcgKzQ4MSw3IEBAIGJhZF9hcmVh
X25vc2VtYXBob3JlOgogICAgICAgIAogCQl0c2stPnRocmVhZC5jcjIgPSBhZGRyZXNzOwogCQkv
KiBLZXJuZWwgYWRkcmVzc2VzIGFyZSBhbHdheXMgcHJvdGVjdGlvbiBmYXVsdHMgKi8KLQkJdHNr
LT50aHJlYWQuZXJyb3JfY29kZSA9IGVycm9yX2NvZGUgfCAoYWRkcmVzcyA+PSBUQVNLX1NJWkUp
OworCQl0c2stPnRocmVhZC5lcnJvcl9jb2RlID0gZXJyb3JfY29kZSB8IChhZGRyZXNzID49IFRB
U0tfU0laRTY0KTsKIAkJdHNrLT50aHJlYWQudHJhcF9ubyA9IDE0OwogCQlpbmZvLnNpX3NpZ25v
ID0gU0lHU0VHVjsKIAkJaW5mby5zaV9lcnJubyA9IDA7CmRpZmYgLU5yYXVwIGEvaW5jbHVkZS9h
c20teDg2XzY0L2Eub3V0LmggYi9pbmNsdWRlL2FzbS14ODZfNjQvYS5vdXQuaAotLS0gYS9pbmNs
dWRlL2FzbS14ODZfNjQvYS5vdXQuaAkyMDA1LTA0LTI3IDA3OjA0OjU3LjAwMDAwMDAwMCArMDgw
MAorKysgYi9pbmNsdWRlL2FzbS14ODZfNjQvYS5vdXQuaAkyMDA1LTA0LTI3IDA3OjEwOjMxLjAw
MDAwMDAwMCArMDgwMApAQCAtMjEsNyArMjEsNyBAQCBzdHJ1Y3QgZXhlYwogCiAjaWZkZWYgX19L
RVJORUxfXwogI2luY2x1ZGUgPGxpbnV4L3RocmVhZF9pbmZvLmg+Ci0jZGVmaW5lIFNUQUNLX1RP
UCAodGVzdF90aHJlYWRfZmxhZyhUSUZfSUEzMikgPyBJQTMyX1BBR0VfT0ZGU0VUIDogVEFTS19T
SVpFKQorI2RlZmluZSBTVEFDS19UT1AgVEFTS19TSVpFCiAjZW5kaWYKIAogI2VuZGlmIC8qIF9f
QV9PVVRfR05VX0hfXyAqLwpkaWZmIC1OcmF1cCBhL2luY2x1ZGUvYXNtLXg4Nl82NC9wcm9jZXNz
b3IuaCBiL2luY2x1ZGUvYXNtLXg4Nl82NC9wcm9jZXNzb3IuaAotLS0gYS9pbmNsdWRlL2FzbS14
ODZfNjQvcHJvY2Vzc29yLmgJMjAwNS0wNC0yNyAwNzowNDo1Ny4wMDAwMDAwMDAgKzA4MDAKKysr
IGIvaW5jbHVkZS9hc20teDg2XzY0L3Byb2Nlc3Nvci5oCTIwMDUtMDQtMjcgMDc6MTE6MTIuMDAw
MDAwMDAwICswODAwCkBAIC0xNjEsMTYgKzE2MSwxNSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgY2xl
YXJfaW5fY3I0ICh1bnNpZ25lCiAvKgogICogVXNlciBzcGFjZSBwcm9jZXNzIHNpemUuIDQ3Yml0
cy4KICAqLwotI2RlZmluZSBUQVNLX1NJWkUJKDB4ODAwMDAwMDAwMDAwVUwpCisKKyNkZWZpbmUg
VEFTS19TSVpFNjQJKDB4ODAwMDAwMDAwMDAwVUwpCisjZGVmaW5lIFRBU0tfU0laRSAodGVzdF90
aHJlYWRfZmxhZyhUSUZfSUEzMikgPyBJQTMyX1BBR0VfT0ZGU0VUIDogVEFTS19TSVpFNjQpCiAK
IC8qIFRoaXMgZGVjaWRlcyB3aGVyZSB0aGUga2VybmVsIHdpbGwgc2VhcmNoIGZvciBhIGZyZWUg
Y2h1bmsgb2Ygdm0KICAqIHNwYWNlIGR1cmluZyBtbWFwJ3MuCiAgKi8KICNkZWZpbmUgSUEzMl9Q
QUdFX09GRlNFVCAoKGN1cnJlbnQtPnBlcnNvbmFsaXR5ICYgQUREUl9MSU1JVF8zR0IpID8gMHhj
MDAwMDAwMCA6IDB4RkZGRmUwMDApCi0jZGVmaW5lIFRBU0tfVU5NQVBQRURfMzIgUEFHRV9BTElH
TihJQTMyX1BBR0VfT0ZGU0VULzMpCi0jZGVmaW5lIFRBU0tfVU5NQVBQRURfNjQgUEFHRV9BTElH
TihUQVNLX1NJWkUvMykgCi0jZGVmaW5lIFRBU0tfVU5NQVBQRURfQkFTRQlcCi0JKHRlc3RfdGhy
ZWFkX2ZsYWcoVElGX0lBMzIpID8gVEFTS19VTk1BUFBFRF8zMiA6IFRBU0tfVU5NQVBQRURfNjQp
ICAKKyNkZWZpbmUgVEFTS19VTk1BUFBFRF9CQVNFIFBBR0VfQUxJR04oVEFTS19TSVpFLzMpCiAK
IC8qCiAgKiBTaXplIG9mIGlvX2JpdG1hcC4K

------_=_NextPart_001_01C54B45.121D49E7--
