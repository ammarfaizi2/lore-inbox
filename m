Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264478AbTF0Q7w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 12:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbTF0Q7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 12:59:50 -0400
Received: from fmr02.intel.com ([192.55.52.25]:27347 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S264478AbTF0Q7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 12:59:39 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C33CCF.71F15614"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: ipc semaphore optimization
Date: Fri, 27 Jun 2003 10:13:36 -0700
Message-ID: <41F331DBE1178346A6F30D7CF124B24B2A486E@fmsmsx409.fm.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: ipc semaphore optimization
Thread-Index: AcM8z3HYzGA8E3B1SKKVHyOiZkfjxA==
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Jun 2003 17:13:37.0063 (UTC) FILETIME=[7255D370:01C33CCF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C33CCF.71F15614
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This patch proposes a performance fix for the current IPC semaphore
implementation.

There are two shortcoming in the current implementation:
try_atomic_semop() was called two times to wake up a blocked process,
once from the update_queue() (executed from the process that wakes up
the sleeping process) and once in the retry part of the blocked process
(executed from the block process that gets woken up).

A second issue is that when several sleeping processes that are eligible
for wake up, they woke up in daisy chain formation and each one in turn
to wake up next process in line.  However, every time when a process
wakes up, it start scans the wait queue from the beginning, not from
where it was last scanned.  This causes large number of unnecessary
scanning of the wait queue under a situation of deep wait queue.
Blocked processes come and go, but chances are there are still quite a
few blocked processes sit at the beginning of that queue.

What we are proposing here is to merge the portion of the code in the
bottom part of sys_semtimedop() (code that gets executed when a sleeping
process gets woken up) into update_queue() function.  The benefit is two
folds: (1) is to reduce redundant calls to try_atomic_semop() and (2) to
increase efficiency of finding eligible processes to wake up and higher
concurrency for multiple wake-ups.

We have measured that this patch improves throughput for a large
application significantly on a industry standard benchmark.

This patch is relative to 2.5.72.  Any feedback is very much
appreciated.

Some kernel profile data attached:

Kernel profile before optimization:
-----------------------------------------------
                0.05    0.14   40805/529060      sys_semop [133]
                0.55    1.73  488255/529060      ia64_ret_from_syscall
[2]
[52]     2.5    0.59    1.88  529060         sys_semtimedop [52]
                0.05    0.83  477766/817966      schedule_timeout [62]
                0.34    0.46  529064/989340      update_queue [61]
                0.14    0.00 1006740/6473086     try_atomic_semop [75]
                0.06    0.00  529060/989336      ipcperms [149]
-----------------------------------------------

                0.30    0.40  460276/989340      semctl_main [68]
                0.34    0.46  529064/989340      sys_semtimedop [52]
[61]     1.5    0.64    0.87  989340         update_queue [61]
                0.75    0.00 5466346/6473086     try_atomic_semop [75]
                0.01    0.11  477676/576698      wake_up_process [146]
-----------------------------------------------
                0.14    0.00 1006740/6473086     sys_semtimedop [52]
                0.75    0.00 5466346/6473086     update_queue [61]
[75]     0.9    0.89    0.00 6473086         try_atomic_semop [75]
-----------------------------------------------


Kernel profile with optimization:

-----------------------------------------------
                0.03    0.05   26139/503178      sys_semop [155]
                0.46    0.92  477039/503178      ia64_ret_from_syscall
[2]
[61]     1.2    0.48    0.97  503178         sys_semtimedop [61]
                0.04    0.79  470724/784394      schedule_timeout [62]
                0.05    0.00  503178/3301773     try_atomic_semop [109]
                0.05    0.00  503178/930934      ipcperms [149]
                0.00    0.03   32454/460210      update_queue [99]
-----------------------------------------------
                0.00    0.03   32454/460210      sys_semtimedop [61]
                0.06    0.36  427756/460210      semctl_main [75]
[99]     0.4    0.06    0.39  460210         update_queue [99]
                0.30    0.00 2798595/3301773     try_atomic_semop [109]
                0.00    0.09  470630/614097      wake_up_process [146]
-----------------------------------------------
                0.05    0.00  503178/3301773     sys_semtimedop [61]
                0.30    0.00 2798595/3301773     update_queue [99]
[109]    0.3    0.35    0.00 3301773         try_atomic_semop [109]
-----------------------------------------------=20

Both number of function calls to try_atomic_semop() and update_queue()
are reduced by 50% as a result of the merge.  Execution time of
sys_semtimedop is reduced because of the reduction in the low level
functions.

------_=_NextPart_001_01C33CCF.71F15614
Content-Type: application/octet-stream;
	name="sem25.patch"
Content-Transfer-Encoding: base64
Content-Description: sem25.patch
Content-Disposition: attachment;
	filename="sem25.patch"

ZGlmZiAtTnVyIGxpbnV4LTIuNS43Mi9pcGMvc2VtLmMgbGludXgtMi41LjcyLnNlbS9pcGMvc2Vt
LmMKLS0tIGxpbnV4LTIuNS43Mi9pcGMvc2VtLmMJTW9uIEp1biAxNiAyMToxOTo1OSAyMDAzCisr
KyBsaW51eC0yLjUuNzIuc2VtL2lwYy9zZW0uYwlXZWQgSnVuIDI1IDIwOjI5OjU2IDIwMDMKQEAg
LTI1OCw4ICsyNTgsNyBAQAogICovCiAKIHN0YXRpYyBpbnQgdHJ5X2F0b21pY19zZW1vcCAoc3Ry
dWN0IHNlbV9hcnJheSAqIHNtYSwgc3RydWN0IHNlbWJ1ZiAqIHNvcHMsCi0JCQkgICAgIGludCBu
c29wcywgc3RydWN0IHNlbV91bmRvICp1biwgaW50IHBpZCwKLQkJCSAgICAgaW50IGRvX3VuZG8p
CisJCQkgICAgIGludCBuc29wcywgc3RydWN0IHNlbV91bmRvICp1biwgaW50IHBpZCkKIHsKIAlp
bnQgcmVzdWx0LCBzZW1fb3A7CiAJc3RydWN0IHNlbWJ1ZiAqc29wOwpAQCAtMjg5LDEwICsyODgs
NiBAQAogCQljdXJyLT5zZW12YWwgPSByZXN1bHQ7CiAJfQogCi0JaWYgKGRvX3VuZG8pIHsKLQkJ
cmVzdWx0ID0gMDsKLQkJZ290byB1bmRvOwotCX0KIAlzb3AtLTsKIAl3aGlsZSAoc29wID49IHNv
cHMpIHsKIAkJc21hLT5zZW1fYmFzZVtzb3AtPnNlbV9udW1dLnNlbXBpZCA9IHBpZDsKQEAgLTMz
NCwyMyArMzI5LDE0IEBACiAKIAlmb3IgKHEgPSBzbWEtPnNlbV9wZW5kaW5nOyBxOyBxID0gcS0+
bmV4dCkgewogCQkJCi0JCWlmIChxLT5zdGF0dXMgPT0gMSkKLQkJCWNvbnRpbnVlOwkvKiB0aGlz
IG9uZSB3YXMgd29rZW4gdXAgYmVmb3JlICovCi0KIAkJZXJyb3IgPSB0cnlfYXRvbWljX3NlbW9w
KHNtYSwgcS0+c29wcywgcS0+bnNvcHMsCi0JCQkJCSBxLT51bmRvLCBxLT5waWQsIHEtPmFsdGVy
KTsKKwkJCQkJIHEtPnVuZG8sIHEtPnBpZCk7CiAKIAkJLyogRG9lcyBxLT5zbGVlcGVyIHN0aWxs
IG5lZWQgdG8gc2xlZXA/ICovCiAJCWlmIChlcnJvciA8PSAwKSB7Ci0JCQkJLyogRm91bmQgb25l
LCB3YWtlIGl0IHVwICovCi0JCQl3YWtlX3VwX3Byb2Nlc3MocS0+c2xlZXBlcik7Ci0JCQlpZiAo
ZXJyb3IgPT0gMCAmJiBxLT5hbHRlcikgewotCQkJCS8qIGlmIHEtPiBhbHRlciBsZXQgaXQgc2Vs
ZiB0cnkgKi8KLQkJCQlxLT5zdGF0dXMgPSAxOwotCQkJCXJldHVybjsKLQkJCX0KIAkJCXEtPnN0
YXR1cyA9IGVycm9yOwogCQkJcmVtb3ZlX2Zyb21fcXVldWUoc21hLHEpOworCQkJd2FrZV91cF9w
cm9jZXNzKHEtPnNsZWVwZXIpOwogCQl9CiAJfQogfQpAQCAtMTA3Nyw3ICsxMDYzLDcgQEAKIAl9
IGVsc2UKIAkJdW4gPSBOVUxMOwogCi0JZXJyb3IgPSB0cnlfYXRvbWljX3NlbW9wIChzbWEsIHNv
cHMsIG5zb3BzLCB1biwgY3VycmVudC0+cGlkLCAwKTsKKwllcnJvciA9IHRyeV9hdG9taWNfc2Vt
b3AgKHNtYSwgc29wcywgbnNvcHMsIHVuLCBjdXJyZW50LT5waWQpOwogCWlmIChlcnJvciA8PSAw
KQogCQlnb3RvIHVwZGF0ZTsKIApAQCAtMTA5MCw3ICsxMDc2LDYgQEAKIAlxdWV1ZS5uc29wcyA9
IG5zb3BzOwogCXF1ZXVlLnVuZG8gPSB1bjsKIAlxdWV1ZS5waWQgPSBjdXJyZW50LT5waWQ7Ci0J
cXVldWUuYWx0ZXIgPSBkZWNyZWFzZTsKIAlxdWV1ZS5pZCA9IHNlbWlkOwogCWlmIChhbHRlcikK
IAkJYXBwZW5kX3RvX3F1ZXVlKHNtYSAsJnF1ZXVlKTsKQEAgLTEwOTgsNTMgKzEwODMsNDUgQEAK
IAkJcHJlcGVuZF90b19xdWV1ZShzbWEgLCZxdWV1ZSk7CiAJY3VycmVudC0+c3lzdnNlbS5zbGVl
cF9saXN0ID0gJnF1ZXVlOwogCi0JZm9yICg7OykgewotCQlxdWV1ZS5zdGF0dXMgPSAtRUlOVFI7
Ci0JCXF1ZXVlLnNsZWVwZXIgPSBjdXJyZW50OwotCQljdXJyZW50LT5zdGF0ZSA9IFRBU0tfSU5U
RVJSVVBUSUJMRTsKLQkJc2VtX3VubG9jayhzbWEpOwotCQl1bmxvY2tfc2VtdW5kbygpOworCXF1
ZXVlLnN0YXR1cyA9IC1FSU5UUjsKKwlxdWV1ZS5zbGVlcGVyID0gY3VycmVudDsKKwljdXJyZW50
LT5zdGF0ZSA9IFRBU0tfSU5URVJSVVBUSUJMRTsKKwlzZW1fdW5sb2NrKHNtYSk7CisJdW5sb2Nr
X3NlbXVuZG8oKTsKIAotCQlpZiAodGltZW91dCkKLQkJCWppZmZpZXNfbGVmdCA9IHNjaGVkdWxl
X3RpbWVvdXQoamlmZmllc19sZWZ0KTsKLQkJZWxzZQotCQkJc2NoZWR1bGUoKTsKKwlpZiAodGlt
ZW91dCkKKwkJamlmZmllc19sZWZ0ID0gc2NoZWR1bGVfdGltZW91dChqaWZmaWVzX2xlZnQpOwor
CWVsc2UKKwkJc2NoZWR1bGUoKTsKIAotCQlsb2NrX3NlbXVuZG8oKTsKLQkJc21hID0gc2VtX2xv
Y2soc2VtaWQpOwotCQlpZihzbWE9PU5VTEwpIHsKLQkJCWlmKHF1ZXVlLnByZXYgIT0gTlVMTCkK
LQkJCQlCVUcoKTsKLQkJCWN1cnJlbnQtPnN5c3ZzZW0uc2xlZXBfbGlzdCA9IE5VTEw7Ci0JCQll
cnJvciA9IC1FSURSTTsKLQkJCWdvdG8gb3V0X3NlbXVuZG9fZnJlZTsKLQkJfQotCQkvKgotCQkg
KiBJZiBxdWV1ZS5zdGF0dXMgPT0gMSB3ZSB3aGVyZSB3b2tlbiB1cCBhbmQKLQkJICogaGF2ZSB0
byByZXRyeSBlbHNlIHdlIHNpbXBseSByZXR1cm4uCi0JCSAqIElmIGFuIGludGVycnVwdCBvY2N1
cnJlZCB3ZSBoYXZlIHRvIGNsZWFuIHVwIHRoZQotCQkgKiBxdWV1ZQotCQkgKgotCQkgKi8KLQkJ
aWYgKHF1ZXVlLnN0YXR1cyA9PSAxKQotCQl7Ci0JCQllcnJvciA9IHRyeV9hdG9taWNfc2Vtb3Ag
KHNtYSwgc29wcywgbnNvcHMsIHVuLAotCQkJCQkJICBjdXJyZW50LT5waWQsMCk7Ci0JCQlpZiAo
ZXJyb3IgPD0gMCkgCi0JCQkJYnJlYWs7Ci0JCX0gZWxzZSB7Ci0JCQllcnJvciA9IHF1ZXVlLnN0
YXR1czsKLQkJCWlmIChlcnJvciA9PSAtRUlOVFIgJiYgdGltZW91dCAmJiBqaWZmaWVzX2xlZnQg
PT0gMCkKLQkJCQllcnJvciA9IC1FQUdBSU47Ci0JCQlpZiAocXVldWUucHJldikgLyogZ290IElu
dGVycnVwdCAqLwotCQkJCWJyZWFrOwotCQkJLyogRXZlcnl0aGluZyBkb25lIGJ5IHVwZGF0ZV9x
dWV1ZSAqLwotCQkJY3VycmVudC0+c3lzdnNlbS5zbGVlcF9saXN0ID0gTlVMTDsKLQkJCWdvdG8g
b3V0X3VubG9ja19zZW11bmRvX2ZyZWU7Ci0JCX0KKwlsb2NrX3NlbXVuZG8oKTsKKwlzbWEgPSBz
ZW1fbG9jayhzZW1pZCk7CisJaWYoc21hPT1OVUxMKSB7CisJCWlmKHF1ZXVlLnByZXYgIT0gTlVM
TCkKKwkJCUJVRygpOworCQljdXJyZW50LT5zeXN2c2VtLnNsZWVwX2xpc3QgPSBOVUxMOworCQll
cnJvciA9IC1FSURSTTsKKwkJZ290byBvdXRfc2VtdW5kb19mcmVlOwogCX0KKworCS8qCisJICog
SWYgcXVldWUuc3RhdHVzICE9IC1FSU5UUiB3ZSBhcmUgd29rZW4gdXAgYnkgYW5vdGhlciBwcm9j
ZXNzCisJICovCisJZXJyb3IgPSBxdWV1ZS5zdGF0dXM7CisJaWYgKHF1ZXVlLnN0YXR1cyAhPSAt
RUlOVFIpIHsKKwkJY3VycmVudC0+c3lzdnNlbS5zbGVlcF9saXN0ID0gTlVMTDsKKwkJZ290byBv
dXRfdW5sb2NrX3NlbXVuZG9fZnJlZTsKKwl9CisKKwkvKgorCSAqIElmIGFuIGludGVycnVwdCBv
Y2N1cnJlZCB3ZSBoYXZlIHRvIGNsZWFuIHVwIHRoZSBxdWV1ZQorCSAqLworCWlmICh0aW1lb3V0
ICYmIGppZmZpZXNfbGVmdCA9PSAwKQorCQllcnJvciA9IC1FQUdBSU47CiAJY3VycmVudC0+c3lz
dnNlbS5zbGVlcF9saXN0ID0gTlVMTDsKIAlyZW1vdmVfZnJvbV9xdWV1ZShzbWEsJnF1ZXVlKTsK
Kwlnb3RvIG91dF91bmxvY2tfc2VtdW5kb19mcmVlOworCiB1cGRhdGU6CiAJaWYgKGFsdGVyKQog
CQl1cGRhdGVfcXVldWUgKHNtYSk7Cg==

------_=_NextPart_001_01C33CCF.71F15614--
