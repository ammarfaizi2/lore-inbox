Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbUCAVn7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 16:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbUCAVn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 16:43:58 -0500
Received: from fmr09.intel.com ([192.52.57.35]:35469 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261445AbUCAVnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 16:43:49 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3FFD2.C4ACBE65"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: per-cpu blk_plug_list
Date: Mon, 1 Mar 2004 13:18:40 -0800
Message-ID: <B05667366EE6204181EABE9C1B1C0EB501F2AB4C@scsmsx401.sc.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: per-cpu blk_plug_list
Thread-Index: AcP/0sSU4QS9NX+lTcastR9Zr4cWlA==
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 01 Mar 2004 21:18:41.0147 (UTC) FILETIME=[C518FCB0:01C3FFD2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3FFD2.C4ACBE65
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

We were surprised to find global lock in I/O path still exists on 2.6
kernel.  This global lock triggers unacceptable lock contention and
prevents 2.6 kernel to scale on the I/O side.

blk_plug_list/blk_plug_lock manages plug/unplug action.  When you have
lots of cpu simultaneously submits I/O, there are lots of movement with
the device queue on and off that global list.  Our measurement showed
that blk_plug_lock contention prevents linux-2.6.3 kernel to scale pass
beyond 40 thousand I/O per second in the I/O submit path.

Looking at the vmstat and readprofile output with vanilla 2.6.3 kernel:

procs -----------memory---------- -----io---- -system-- ----cpu----
 r  b  swpd   free   buff  cache    bi    bo   in    cs   us sy id wa
409 484  0 22470560  10160 181792  89456  5867 46899 26383 7 93  0  0
427 488  0 22466176  10160 181792  90307  6057 46818 26155 7 93  0  0
448 469  0 22462208  10160 181792  84076  5769 48217 26782 7 93  0  0

575324 total                                      0.0818
225342 blk_run_queues                           391.2188
140164 __make_request                            38.4221
131765 scsi_request_fn                           55.6440
 21566 generic_unplug_device                     61.2670
  6050 get_request                                3.7812

All cpus are pegged at 93% kernel time spinning on the lock.
blk_plug_device() and blk_remove_plug() didn't show up in readprofile
because they spin with irq disabled and readprofile is based on timer
interrupt.  Nevertheless, it's obvious from blk_run_queues().

The plug management need to be converted into per-cpu.  The idea here
is to manage device queue on per-cpu plug list.  This would also allows
optimal queue kick-off since submit/kick-off typically occurs within
same system call. With our proof-of-concept patch, here are the results,
again vmstat and readprofile output:

procs -----------memory---------- -----io----   -system--    ----cpu----
 r  b  swpd   free   buff  cache    bi    bo     in    cs    us sy id wa
30 503  0 22506176   9536 172096  212849 20251 102537 177093 27 20  0 53
11 532  0 22505792   9536 172096  209073 21235 103374 177183 29 20  0 51
27 499  0 22505408   9536 172096  205334 21943 103883 176649 30 20  0 50

1988800 total                                      0.2828
1174759 cpu_idle                                2447.4146
156385 default_idle                             4887.0312
 72586 do_softirq                                108.0149
 62463 schedule                                   12.0492
 51913 scsi_request_fn                            21.9227
 34351 __make_request                              9.4164
 24370 dio_bio_end_io                             63.4635
 22652 scsi_end_request                           44.2422

It clearly relieves the global lock contention and the kernel time is
now in the expected range.  I/O has been improved to 110K random I/O
per second and is now only limited by the disks instead of kernel.

The workload that triggers this scalability issue is an I/O intensive
database workload running on a 32P system.

Comments on the patch are welcome, I'm sure there will be a couple of
iterations on the solution.

- Ken

------_=_NextPart_001_01C3FFD2.C4ACBE65
Content-Type: application/octet-stream;
	name="percpu_blk_plug.patch"
Content-Transfer-Encoding: base64
Content-Description: percpu_blk_plug.patch
Content-Disposition: attachment;
	filename="percpu_blk_plug.patch"

ZGlmZiAtTnVycCBsaW51eC0yLjYuMy9kcml2ZXJzL2Jsb2NrL2xsX3J3X2Jsay5jIGxpbnV4LTIu
Ni4zLmJsay9kcml2ZXJzL2Jsb2NrL2xsX3J3X2Jsay5jCi0tLSBsaW51eC0yLjYuMy9kcml2ZXJz
L2Jsb2NrL2xsX3J3X2Jsay5jCTIwMDQtMDItMTcgMTk6NTc6MTYuMDAwMDAwMDAwIC0wODAwCisr
KyBsaW51eC0yLjYuMy5ibGsvZHJpdmVycy9ibG9jay9sbF9yd19ibGsuYwkyMDA0LTAzLTAxIDEx
OjM2OjA5LjAwMDAwMDAwMCAtMDgwMApAQCAtMzksOCArMzksNyBAQCBzdGF0aWMga21lbV9jYWNo
ZV90ICpyZXF1ZXN0X2NhY2hlcDsKIC8qCiAgKiBwbHVnIG1hbmFnZW1lbnQKICAqLwotc3RhdGlj
IExJU1RfSEVBRChibGtfcGx1Z19saXN0KTsKLXN0YXRpYyBzcGlubG9ja190IGJsa19wbHVnX2xv
Y2sgX19jYWNoZWxpbmVfYWxpZ25lZF9pbl9zbXAgPSBTUElOX0xPQ0tfVU5MT0NLRUQ7CitzdGF0
aWMgc3RydWN0IGJsa19wbHVnX3N0cnVjdCBibGtfcGx1Z19hcnJheVtOUl9DUFVTXTsKIAogc3Rh
dGljIHdhaXRfcXVldWVfaGVhZF90IGNvbmdlc3Rpb25fd3FoWzJdOwogCkBAIC0xMDk2LDEwICsx
MDk1LDE0IEBAIHZvaWQgYmxrX3BsdWdfZGV2aWNlKHJlcXVlc3RfcXVldWVfdCAqcSkKIAkgKi8K
IAlpZiAoIWJsa19xdWV1ZV9wbHVnZ2VkKHEpCiAJICAgICYmICF0ZXN0X2JpdChRVUVVRV9GTEFH
X1NUT1BQRUQsICZxLT5xdWV1ZV9mbGFncykpIHsKLQkJc3Bpbl9sb2NrKCZibGtfcGx1Z19sb2Nr
KTsKLQkJbGlzdF9hZGRfdGFpbCgmcS0+cGx1Z19saXN0LCAmYmxrX3BsdWdfbGlzdCk7CisJCXN0
cnVjdCBibGtfcGx1Z19zdHJ1Y3QgKiBsb2NhbF9ibGtfcGx1ZyA9CisJCQkJCSAmYmxrX3BsdWdf
YXJyYXlbc21wX3Byb2Nlc3Nvcl9pZCgpXTsKKworCQlzcGluX2xvY2soJmxvY2FsX2Jsa19wbHVn
LT5ibGtfcGx1Z19sb2NrKTsKKwkJbGlzdF9hZGRfdGFpbCgmcS0+cGx1Z19saXN0LCAmbG9jYWxf
YmxrX3BsdWctPmJsa19wbHVnX2hlYWQpOworCQlxLT5ibGtfcGx1ZyA9IGxvY2FsX2Jsa19wbHVn
OwogCQltb2RfdGltZXIoJnEtPnVucGx1Z190aW1lciwgamlmZmllcyArIHEtPnVucGx1Z19kZWxh
eSk7Ci0JCXNwaW5fdW5sb2NrKCZibGtfcGx1Z19sb2NrKTsKKwkJc3Bpbl91bmxvY2soJmxvY2Fs
X2Jsa19wbHVnLT5ibGtfcGx1Z19sb2NrKTsKIAl9CiB9CiAKQEAgLTExMTMsMTAgKzExMTYsMTEg
QEAgaW50IGJsa19yZW1vdmVfcGx1ZyhyZXF1ZXN0X3F1ZXVlX3QgKnEpCiB7CiAJV0FSTl9PTigh
aXJxc19kaXNhYmxlZCgpKTsKIAlpZiAoYmxrX3F1ZXVlX3BsdWdnZWQocSkpIHsKLQkJc3Bpbl9s
b2NrKCZibGtfcGx1Z19sb2NrKTsKKwkJc3RydWN0IGJsa19wbHVnX3N0cnVjdCAqIGJsa19wbHVn
ID0gcS0+YmxrX3BsdWc7CisJCXNwaW5fbG9jaygmYmxrX3BsdWctPmJsa19wbHVnX2xvY2spOwog
CQlsaXN0X2RlbF9pbml0KCZxLT5wbHVnX2xpc3QpOwogCQlkZWxfdGltZXIoJnEtPnVucGx1Z190
aW1lcik7Ci0JCXNwaW5fdW5sb2NrKCZibGtfcGx1Z19sb2NrKTsKKwkJc3Bpbl91bmxvY2soJmJs
a19wbHVnLT5ibGtfcGx1Z19sb2NrKTsKIAkJcmV0dXJuIDE7CiAJfQogCkBAIC0xMjM3LDYgKzEy
NDEsMjYgQEAgdm9pZCBibGtfcnVuX3F1ZXVlKHN0cnVjdCByZXF1ZXN0X3F1ZXVlIAogCiBFWFBP
UlRfU1lNQk9MKGJsa19ydW5fcXVldWUpOwogCisvKgorICogYmxrX3J1bl9xdWV1ZXNfY3B1IC0g
ZmlyZSBhbGwgcGx1Z2dlZCBxdWV1ZXMgb24gdGhpcyBjcHUKKyAqLworI2RlZmluZSBibGtfcGx1
Z19lbnRyeShlbnRyeSkgbGlzdF9lbnRyeSgoZW50cnkpLCByZXF1ZXN0X3F1ZXVlX3QsIHBsdWdf
bGlzdCkKK3ZvaWQgYmxrX3J1bl9xdWV1ZXNfY3B1KGludCBjcHUpCit7CisJc3RydWN0IGJsa19w
bHVnX3N0cnVjdCAqIGN1cl9ibGtfcGx1ZyA9ICZibGtfcGx1Z19hcnJheVtjcHVdOworCXN0cnVj
dCBsaXN0X2hlYWQgKiBoZWFkID0gJmN1cl9ibGtfcGx1Zy0+YmxrX3BsdWdfaGVhZDsKKwlzcGlu
bG9ja190ICpsb2NrID0gJmN1cl9ibGtfcGx1Zy0+YmxrX3BsdWdfbG9jazsKKworCXNwaW5fbG9j
a19pcnEobG9jayk7CisJd2hpbGUgKCFsaXN0X2VtcHR5KGhlYWQpKSB7CisJCXJlcXVlc3RfcXVl
dWVfdCAqcSA9IGJsa19wbHVnX2VudHJ5KGhlYWQtPm5leHQpOworCQlzcGluX3VubG9ja19pcnEo
bG9jayk7CisJCXEtPnVucGx1Z19mbihxKTsKKwkJc3Bpbl9sb2NrX2lycShsb2NrKTsKKwl9CisJ
c3Bpbl91bmxvY2tfaXJxKGxvY2spOworfQorCiAvKioKICAqIGJsa19ydW5fcXVldWVzIC0gZmly
ZSBhbGwgcGx1Z2dlZCBxdWV1ZXMKICAqCkBAIC0xMjQ1LDMwICsxMjY5LDEyIEBAIEVYUE9SVF9T
WU1CT0woYmxrX3J1bl9xdWV1ZSk7CiAgKiAgIGFyZSBjdXJyZW50bHkgc3RvcHBlZCBhcmUgaWdu
b3JlZC4gVGhpcyBpcyBlcXVpdmFsZW50IHRvIHRoZSBvbGRlcgogICogICB0cV9kaXNrIHRhc2sg
cXVldWUgcnVuLgogICoqLwotI2RlZmluZSBibGtfcGx1Z19lbnRyeShlbnRyeSkgbGlzdF9lbnRy
eSgoZW50cnkpLCByZXF1ZXN0X3F1ZXVlX3QsIHBsdWdfbGlzdCkKIHZvaWQgYmxrX3J1bl9xdWV1
ZXModm9pZCkKIHsKLQlMSVNUX0hFQUQobG9jYWxfcGx1Z19saXN0KTsKLQotCXNwaW5fbG9ja19p
cnEoJmJsa19wbHVnX2xvY2spOwotCi0JLyoKLQkgKiB0aGlzIHdpbGwgaGFwcGVuIGZhaXJseSBv
ZnRlbgotCSAqLwotCWlmIChsaXN0X2VtcHR5KCZibGtfcGx1Z19saXN0KSkKLQkJZ290byBvdXQ7
Ci0KLQlsaXN0X3NwbGljZV9pbml0KCZibGtfcGx1Z19saXN0LCAmbG9jYWxfcGx1Z19saXN0KTsK
LQkKLQl3aGlsZSAoIWxpc3RfZW1wdHkoJmxvY2FsX3BsdWdfbGlzdCkpIHsKLQkJcmVxdWVzdF9x
dWV1ZV90ICpxID0gYmxrX3BsdWdfZW50cnkobG9jYWxfcGx1Z19saXN0Lm5leHQpOworCWludCBp
OwogCi0JCXNwaW5fdW5sb2NrX2lycSgmYmxrX3BsdWdfbG9jayk7Ci0JCXEtPnVucGx1Z19mbihx
KTsKLQkJc3Bpbl9sb2NrX2lycSgmYmxrX3BsdWdfbG9jayk7Ci0JfQotb3V0OgotCXNwaW5fdW5s
b2NrX2lycSgmYmxrX3BsdWdfbG9jayk7CisJZm9yX2VhY2hfY3B1KGkpCisJCWJsa19ydW5fcXVl
dWVzX2NwdShpKTsKIH0KIAogRVhQT1JUX1NZTUJPTChibGtfcnVuX3F1ZXVlcyk7CkBAIC0yNjg3
LDYgKzI2OTMsMTEgQEAgaW50IF9faW5pdCBibGtfZGV2X2luaXQodm9pZCkKIAogCWZvciAoaSA9
IDA7IGkgPCBBUlJBWV9TSVpFKGNvbmdlc3Rpb25fd3FoKTsgaSsrKQogCQlpbml0X3dhaXRxdWV1
ZV9oZWFkKCZjb25nZXN0aW9uX3dxaFtpXSk7CisKKwlmb3IgKGkgPSAwOyBpIDwgTlJfQ1BVUzsg
aSsrKSB7CisJCUlOSVRfTElTVF9IRUFEKCZibGtfcGx1Z19hcnJheVtpXS5ibGtfcGx1Z19oZWFk
KTsKKwkJc3Bpbl9sb2NrX2luaXQoJmJsa19wbHVnX2FycmF5W2ldLmJsa19wbHVnX2xvY2spOwor
CX0KIAlyZXR1cm4gMDsKIH0KIApkaWZmIC1OdXJwIGxpbnV4LTIuNi4zL2ZzL2RpcmVjdC1pby5j
IGxpbnV4LTIuNi4zLmJsay9mcy9kaXJlY3QtaW8uYwotLS0gbGludXgtMi42LjMvZnMvZGlyZWN0
LWlvLmMJMjAwNC0wMi0xNyAxOTo1ODoxNi4wMDAwMDAwMDAgLTA4MDAKKysrIGxpbnV4LTIuNi4z
LmJsay9mcy9kaXJlY3QtaW8uYwkyMDA0LTAzLTAxIDExOjM2OjA5LjAwMDAwMDAwMCAtMDgwMApA
QCAtMzI5LDcgKzMyOSw3IEBAIHN0YXRpYyBzdHJ1Y3QgYmlvICpkaW9fYXdhaXRfb25lKHN0cnVj
dCAKIAkJaWYgKGRpby0+YmlvX2xpc3QgPT0gTlVMTCkgewogCQkJZGlvLT53YWl0ZXIgPSBjdXJy
ZW50OwogCQkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZGlvLT5iaW9fbGlzdF9sb2NrLCBmbGFn
cyk7Ci0JCQlibGtfcnVuX3F1ZXVlcygpOworCQkJYmxrX3J1bl9xdWV1ZXNfY3B1KHNtcF9wcm9j
ZXNzb3JfaWQoKSk7CiAJCQlpb19zY2hlZHVsZSgpOwogCQkJc3Bpbl9sb2NrX2lycXNhdmUoJmRp
by0+YmlvX2xpc3RfbG9jaywgZmxhZ3MpOwogCQkJZGlvLT53YWl0ZXIgPSBOVUxMOwpAQCAtOTYw
LDcgKzk2MCw3IEBAIGRpcmVjdF9pb193b3JrZXIoaW50IHJ3LCBzdHJ1Y3Qga2lvY2IgKmkKIAkJ
aWYgKHJldCA9PSAwKQogCQkJcmV0ID0gZGlvLT5yZXN1bHQ7CS8qIEJ5dGVzIHdyaXR0ZW4gKi8K
IAkJZmluaXNoZWRfb25lX2JpbyhkaW8pOwkJLyogVGhpcyBjYW4gZnJlZSB0aGUgZGlvICovCi0J
CWJsa19ydW5fcXVldWVzKCk7CisJCWJsa19ydW5fcXVldWVzX2NwdShzbXBfcHJvY2Vzc29yX2lk
KCkpOwogCX0gZWxzZSB7CiAJCWZpbmlzaGVkX29uZV9iaW8oZGlvKTsKIAkJcmV0MiA9IGRpb19h
d2FpdF9jb21wbGV0aW9uKGRpbyk7CmRpZmYgLU51cnAgbGludXgtMi42LjMvaW5jbHVkZS9saW51
eC9ibGtkZXYuaCBsaW51eC0yLjYuMy5ibGsvaW5jbHVkZS9saW51eC9ibGtkZXYuaAotLS0gbGlu
dXgtMi42LjMvaW5jbHVkZS9saW51eC9ibGtkZXYuaAkyMDA0LTAyLTE3IDE5OjU3OjIwLjAwMDAw
MDAwMCAtMDgwMAorKysgbGludXgtMi42LjMuYmxrL2luY2x1ZGUvbGludXgvYmxrZGV2LmgJMjAw
NC0wMy0wMSAxMTozNjowOS4wMDAwMDAwMDAgLTA4MDAKQEAgLTI2Nyw2ICsyNjcsMTEgQEAgc3Ry
dWN0IGJsa19xdWV1ZV90YWcgewogCWF0b21pY190IHJlZmNudDsJCS8qIG1hcCBjYW4gYmUgc2hh
cmVkICovCiB9OwogCitzdHJ1Y3QgYmxrX3BsdWdfc3RydWN0IHsKKwlzdHJ1Y3QgbGlzdF9oZWFk
CWJsa19wbHVnX2hlYWQ7CisJc3BpbmxvY2tfdAkJYmxrX3BsdWdfbG9jazsKK30gX19fX2NhY2hl
bGluZV9hbGlnbmVkOworCiBzdHJ1Y3QgcmVxdWVzdF9xdWV1ZQogewogCS8qCkBAIC0zMTYsNiAr
MzIxLDcgQEAgc3RydWN0IHJlcXVlc3RfcXVldWUKIAlpbnQJCQlib3VuY2VfZ2ZwOwogCiAJc3Ry
dWN0IGxpc3RfaGVhZAlwbHVnX2xpc3Q7CisJc3RydWN0IGJsa19wbHVnX3N0cnVjdAkqYmxrX3Bs
dWc7CS8qIGJsa19wbHVnIGl0IGJlbG9uZ3MgdG8gKi8KIAogCS8qCiAJICogdmFyaW91cyBxdWV1
ZSBmbGFncywgc2VlIFFVRVVFXyogYmVsb3cKZGlmZiAtTnVycCBsaW51eC0yLjYuMy9pbmNsdWRl
L2xpbnV4L2ZzLmggbGludXgtMi42LjMuYmxrL2luY2x1ZGUvbGludXgvZnMuaAotLS0gbGludXgt
Mi42LjMvaW5jbHVkZS9saW51eC9mcy5oCTIwMDQtMDItMTcgMTk6NTc6MjAuMDAwMDAwMDAwIC0w
ODAwCisrKyBsaW51eC0yLjYuMy5ibGsvaW5jbHVkZS9saW51eC9mcy5oCTIwMDQtMDMtMDEgMTE6
MzY6MDkuMDAwMDAwMDAwIC0wODAwCkBAIC0xMTUyLDYgKzExNTIsNyBAQCBleHRlcm4gaW50IGJs
a2Rldl9wdXQoc3RydWN0IGJsb2NrX2RldmljCiBleHRlcm4gaW50IGJkX2NsYWltKHN0cnVjdCBi
bG9ja19kZXZpY2UgKiwgdm9pZCAqKTsKIGV4dGVybiB2b2lkIGJkX3JlbGVhc2Uoc3RydWN0IGJs
b2NrX2RldmljZSAqKTsKIGV4dGVybiB2b2lkIGJsa19ydW5fcXVldWVzKHZvaWQpOworZXh0ZXJu
IHZvaWQgYmxrX3J1bl9xdWV1ZXNfY3B1KGludCk7CiAKIC8qIGZzL2NoYXJfZGV2LmMgKi8KIGV4
dGVybiBpbnQgYWxsb2NfY2hyZGV2X3JlZ2lvbihkZXZfdCAqLCB1bnNpZ25lZCwgdW5zaWduZWQs
IGNoYXIgKik7Cg==

------_=_NextPart_001_01C3FFD2.C4ACBE65--
