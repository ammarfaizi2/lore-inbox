Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267180AbTGGT7x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 15:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267182AbTGGT7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 15:59:53 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:5797 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP id S267180AbTGGT7s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 15:59:48 -0400
Message-ID: <3F09D485.2090305@redhat.com>
Date: Mon, 07 Jul 2003 13:13:57 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030703 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: [patch] updated: tgkill patch for safe inter-thread signals
X-Enigmail-Version: 0.80.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080302040909000706000900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080302040909000706000900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This are updated versions of the patch Ingo sent some time ago to
implement a new tgkill() syscall which can in theory replace kill() and
tkill().

The first patch is just Ingo's patch, relative to the current BK
sources, plus the fix to send the correct si_pid value.

The second patch implementation the additional functionality Linus
proposed.  They allow using tgkill as a replacement for kill/tkill by
recognizing special -1 values.  This is the interdiff:

- --- linux-2.5/kernel/signal.c   2003-07-07 12:39:36.000000000 -0700
+++ linux-2.5/kernel/signal.c   2003-07-07 13:03:15.000000000 -0700
@@ -2104,8 +2104,12 @@
        int error;
        struct task_struct *p;

+       /* Handle tgkill(tgid, -1, sig) like kill(tgid, sig).  */
+       if (pid == -1)
+               return sys_kill(tgid, sig);
+
        /* This is only valid for single tasks */
- -       if (pid <= 0 || tgid <= 0)
+       if (pid <= 0 || tgid < -1 || tgid == 0)
                return -EINVAL;

        info.si_signo = sig;
@@ -2117,7 +2121,8 @@
        read_lock(&tasklist_lock);
        p = find_task_by_pid(pid);
        error = -ESRCH;
- -       if (p && (p->tgid == tgid)) {
+       /* Handle tgkill(-1, pid, sig) like tkill(pid, sig).  */
+       if (p && (p->tgid == tgid || tgid == -1)) {
                error = check_kill_permission(sig, &info, p);
                /*
                 * The null signal is a permissions and process existence


I personally would think that this addition is overkill since we cannot
get rid of the kill/tkill syscalls anyway.

I've tested both patches.  Having one of them included is really needed
since many/most people still run with limited PID ranges (maybe due to
legacy apps breaking) and the PID reuse can cause problems.

Let me know if there are any problems.  I'll try to address them right away.

- --
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/CdSE2ijCOnn/RHQRAiytAJwJq8BYPRu9Ep6U8krubKafW7nVwwCeKsq7
LKsQB68ROJYi8OrdUPFOZ5M=
=HdOW
-----END PGP SIGNATURE-----

--------------080302040909000706000900
Content-Type: text/plain;
 name="d-kernel-tgkill1"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="d-kernel-tgkill1"

LS0tIGxpbnV4LTIuNS9hcmNoL2kzODYva2VybmVsL2VudHJ5LlMtb2xkCTIwMDMtMDYtMjQg
MDk6NDA6MTIuMDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC0yLjUvYXJjaC9pMzg2L2tlcm5l
bC9lbnRyeS5TCTIwMDMtMDctMDcgMTI6MzY6NTUuMDAwMDAwMDAwIC0wNzAwCkBAIC04NzYs
NSArODc2LDYgQEAgRU5UUlkoc3lzX2NhbGxfdGFibGUpCiAgCS5sb25nIHN5c19jbG9ja19u
YW5vc2xlZXAKIAkubG9uZyBzeXNfc3RhdGZzNjQKIAkubG9uZyBzeXNfZnN0YXRmczY0CQor
CS5sb25nIHN5c190Z2tpbGwKICAKIG5yX3N5c2NhbGxzPSguLXN5c19jYWxsX3RhYmxlKS80
Ci0tLSBsaW51eC0yLjUvaW5jbHVkZS9hc20taTM4Ni91bmlzdGQuaC1vbGQJMjAwMy0wNi0y
NCAwOTo0MDoxMy4wMDAwMDAwMDAgLTA3MDAKKysrIGxpbnV4LTIuNS9pbmNsdWRlL2FzbS1p
Mzg2L3VuaXN0ZC5oCTIwMDMtMDctMDcgMTI6MzI6MzcuMDAwMDAwMDAwIC0wNzAwCkBAIC0y
NzUsOCArMjc1LDkgQEAKICNkZWZpbmUgX19OUl9jbG9ja19uYW5vc2xlZXAJKF9fTlJfdGlt
ZXJfY3JlYXRlKzgpCiAjZGVmaW5lIF9fTlJfc3RhdGZzNjQJCTI2OAogI2RlZmluZSBfX05S
X2ZzdGF0ZnM2NAkJMjY5CisjZGVmaW5lIF9fTlJfdGdraWxsCQkyNzAKIAotI2RlZmluZSBO
Ul9zeXNjYWxscyAyNzAKKyNkZWZpbmUgTlJfc3lzY2FsbHMgMjcxCiAKIC8qIHVzZXItdmlz
aWJsZSBlcnJvciBudW1iZXJzIGFyZSBpbiB0aGUgcmFuZ2UgLTEgLSAtMTI0OiBzZWUgPGFz
bS1pMzg2L2Vycm5vLmg+ICovCiAKLS0tIGxpbnV4LTIuNS9rZXJuZWwvc2lnbmFsLmMtb2xk
CTIwMDMtMDctMDUgMTI6MDg6NDguMDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC0yLjUva2Vy
bmVsL3NpZ25hbC5jCTIwMDMtMDctMDcgMTI6Mzk6MzYuMDAwMDAwMDAwIC0wNzAwCkBAIC01
NzksOCArNTc5LDggQEAgc3RhdGljIGludCBybV9mcm9tX3F1ZXVlKHVuc2lnbmVkIGxvbmcg
bQogLyoKICAqIEJhZCBwZXJtaXNzaW9ucyBmb3Igc2VuZGluZyB0aGUgc2lnbmFsCiAgKi8K
LXN0YXRpYyBpbmxpbmUgaW50IGNoZWNrX2tpbGxfcGVybWlzc2lvbihpbnQgc2lnLCBzdHJ1
Y3Qgc2lnaW5mbyAqaW5mbywKLQkJCQkJc3RydWN0IHRhc2tfc3RydWN0ICp0KQorc3RhdGlj
IGludCBjaGVja19raWxsX3Blcm1pc3Npb24oaW50IHNpZywgc3RydWN0IHNpZ2luZm8gKmlu
Zm8sCisJCQkJIHN0cnVjdCB0YXNrX3N0cnVjdCAqdCkKIHsKIAlpbnQgZXJyb3IgPSAtRUlO
VkFMOwogCWlmIChzaWcgPCAwIHx8IHNpZyA+IF9OU0lHKQpAQCAtMjA4OCw2ICsyMDg4LDUy
IEBAIHN5c19raWxsKGludCBwaWQsIGludCBzaWcpCiAJcmV0dXJuIGtpbGxfc29tZXRoaW5n
X2luZm8oc2lnLCAmaW5mbywgcGlkKTsKIH0KIAorLyoqCisgKiAgc3lzX3RraWxsIC0gc2Vu
ZCBzaWduYWwgdG8gb25lIHNwZWNpZmljIHRocmVhZAorICogIEB0Z2lkOiB0aGUgdGhyZWFk
IGdyb3VwIElEIG9mIHRoZSB0aHJlYWQKKyAqICBAcGlkOiB0aGUgUElEIG9mIHRoZSB0aHJl
YWQKKyAqICBAc2lnOiBzaWduYWwgdG8gYmUgc2VudAorICoKKyAqICBUaGlzIHN5c2NhbGwg
YWxzbyBjaGVja3MgdGhlIHRnaWQgYW5kIHJldHVybnMgLUVTUkNIIGV2ZW4gaWYgdGhlIFBJ
RAorICogIGV4aXN0cyBidXQgaXQncyBub3QgYmVsb25naW5nIHRvIHRoZSB0YXJnZXQgcHJv
Y2VzcyBhbnltb3JlLiBUaGlzCisgKiAgbWV0aG9kIHNvbHZlcyB0aGUgcHJvYmxlbSBvZiB0
aHJlYWRzIGV4aXRpbmcgYW5kIFBJRHMgZ2V0dGluZyByZXVzZWQuCisgKi8KK2FzbWxpbmth
Z2UgbG9uZyBzeXNfdGdraWxsKGludCB0Z2lkLCBpbnQgcGlkLCBpbnQgc2lnKQoreworCXN0
cnVjdCBzaWdpbmZvIGluZm87CisJaW50IGVycm9yOworCXN0cnVjdCB0YXNrX3N0cnVjdCAq
cDsKKworCS8qIFRoaXMgaXMgb25seSB2YWxpZCBmb3Igc2luZ2xlIHRhc2tzICovCisJaWYg
KHBpZCA8PSAwIHx8IHRnaWQgPD0gMCkKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwlpbmZvLnNp
X3NpZ25vID0gc2lnOworCWluZm8uc2lfZXJybm8gPSAwOworCWluZm8uc2lfY29kZSA9IFNJ
X1RLSUxMOworCWluZm8uc2lfcGlkID0gY3VycmVudC0+dGdpZDsKKwlpbmZvLnNpX3VpZCA9
IGN1cnJlbnQtPnVpZDsKKworCXJlYWRfbG9jaygmdGFza2xpc3RfbG9jayk7CisJcCA9IGZp
bmRfdGFza19ieV9waWQocGlkKTsKKwllcnJvciA9IC1FU1JDSDsKKwlpZiAocCAmJiAocC0+
dGdpZCA9PSB0Z2lkKSkgeworCQllcnJvciA9IGNoZWNrX2tpbGxfcGVybWlzc2lvbihzaWcs
ICZpbmZvLCBwKTsKKwkJLyoKKwkJICogVGhlIG51bGwgc2lnbmFsIGlzIGEgcGVybWlzc2lv
bnMgYW5kIHByb2Nlc3MgZXhpc3RlbmNlCisJCSAqIHByb2JlLiAgTm8gc2lnbmFsIGlzIGFj
dHVhbGx5IGRlbGl2ZXJlZC4KKwkJICovCisJCWlmICghZXJyb3IgJiYgc2lnICYmIHAtPnNp
Z2hhbmQpIHsKKwkJCXNwaW5fbG9ja19pcnEoJnAtPnNpZ2hhbmQtPnNpZ2xvY2spOworCQkJ
aGFuZGxlX3N0b3Bfc2lnbmFsKHNpZywgcCk7CisJCQllcnJvciA9IHNwZWNpZmljX3NlbmRf
c2lnX2luZm8oc2lnLCAmaW5mbywgcCk7CisJCQlzcGluX3VubG9ja19pcnEoJnAtPnNpZ2hh
bmQtPnNpZ2xvY2spOworCQl9CisJfQorCXJlYWRfdW5sb2NrKCZ0YXNrbGlzdF9sb2NrKTsK
KwlyZXR1cm4gZXJyb3I7Cit9CisKIC8qCiAgKiAgU2VuZCBhIHNpZ25hbCB0byBvbmx5IG9u
ZSB0YXNrLCBldmVuIGlmIGl0J3MgYSBDTE9ORV9USFJFQUQgdGFzay4KICAqLwo=
--------------080302040909000706000900
Content-Type: text/plain;
 name="d-kernel-tgkill2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="d-kernel-tgkill2"

LS0tIGxpbnV4LTIuNS9hcmNoL2kzODYva2VybmVsL2VudHJ5LlMtb2xkCTIwMDMtMDYtMjQg
MDk6NDA6MTIuMDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC0yLjUvYXJjaC9pMzg2L2tlcm5l
bC9lbnRyeS5TCTIwMDMtMDctMDcgMTI6MzY6NTUuMDAwMDAwMDAwIC0wNzAwCkBAIC04NzYs
NSArODc2LDYgQEAgRU5UUlkoc3lzX2NhbGxfdGFibGUpCiAgCS5sb25nIHN5c19jbG9ja19u
YW5vc2xlZXAKIAkubG9uZyBzeXNfc3RhdGZzNjQKIAkubG9uZyBzeXNfZnN0YXRmczY0CQor
CS5sb25nIHN5c190Z2tpbGwKICAKIG5yX3N5c2NhbGxzPSguLXN5c19jYWxsX3RhYmxlKS80
Ci0tLSBsaW51eC0yLjUvaW5jbHVkZS9hc20taTM4Ni91bmlzdGQuaC1vbGQJMjAwMy0wNi0y
NCAwOTo0MDoxMy4wMDAwMDAwMDAgLTA3MDAKKysrIGxpbnV4LTIuNS9pbmNsdWRlL2FzbS1p
Mzg2L3VuaXN0ZC5oCTIwMDMtMDctMDcgMTI6MzI6MzcuMDAwMDAwMDAwIC0wNzAwCkBAIC0y
NzUsOCArMjc1LDkgQEAKICNkZWZpbmUgX19OUl9jbG9ja19uYW5vc2xlZXAJKF9fTlJfdGlt
ZXJfY3JlYXRlKzgpCiAjZGVmaW5lIF9fTlJfc3RhdGZzNjQJCTI2OAogI2RlZmluZSBfX05S
X2ZzdGF0ZnM2NAkJMjY5CisjZGVmaW5lIF9fTlJfdGdraWxsCQkyNzAKIAotI2RlZmluZSBO
Ul9zeXNjYWxscyAyNzAKKyNkZWZpbmUgTlJfc3lzY2FsbHMgMjcxCiAKIC8qIHVzZXItdmlz
aWJsZSBlcnJvciBudW1iZXJzIGFyZSBpbiB0aGUgcmFuZ2UgLTEgLSAtMTI0OiBzZWUgPGFz
bS1pMzg2L2Vycm5vLmg+ICovCiAKLS0tIGxpbnV4LTIuNS9rZXJuZWwvc2lnbmFsLmMtb2xk
CTIwMDMtMDctMDUgMTI6MDg6NDguMDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC0yLjUva2Vy
bmVsL3NpZ25hbC5jCTIwMDMtMDctMDcgMTM6MDM6MTUuMDAwMDAwMDAwIC0wNzAwCkBAIC01
NzksOCArNTc5LDggQEAgc3RhdGljIGludCBybV9mcm9tX3F1ZXVlKHVuc2lnbmVkIGxvbmcg
bQogLyoKICAqIEJhZCBwZXJtaXNzaW9ucyBmb3Igc2VuZGluZyB0aGUgc2lnbmFsCiAgKi8K
LXN0YXRpYyBpbmxpbmUgaW50IGNoZWNrX2tpbGxfcGVybWlzc2lvbihpbnQgc2lnLCBzdHJ1
Y3Qgc2lnaW5mbyAqaW5mbywKLQkJCQkJc3RydWN0IHRhc2tfc3RydWN0ICp0KQorc3RhdGlj
IGludCBjaGVja19raWxsX3Blcm1pc3Npb24oaW50IHNpZywgc3RydWN0IHNpZ2luZm8gKmlu
Zm8sCisJCQkJIHN0cnVjdCB0YXNrX3N0cnVjdCAqdCkKIHsKIAlpbnQgZXJyb3IgPSAtRUlO
VkFMOwogCWlmIChzaWcgPCAwIHx8IHNpZyA+IF9OU0lHKQpAQCAtMjA4OCw2ICsyMDg4LDU3
IEBAIHN5c19raWxsKGludCBwaWQsIGludCBzaWcpCiAJcmV0dXJuIGtpbGxfc29tZXRoaW5n
X2luZm8oc2lnLCAmaW5mbywgcGlkKTsKIH0KIAorLyoqCisgKiAgc3lzX3RraWxsIC0gc2Vu
ZCBzaWduYWwgdG8gb25lIHNwZWNpZmljIHRocmVhZAorICogIEB0Z2lkOiB0aGUgdGhyZWFk
IGdyb3VwIElEIG9mIHRoZSB0aHJlYWQKKyAqICBAcGlkOiB0aGUgUElEIG9mIHRoZSB0aHJl
YWQKKyAqICBAc2lnOiBzaWduYWwgdG8gYmUgc2VudAorICoKKyAqICBUaGlzIHN5c2NhbGwg
YWxzbyBjaGVja3MgdGhlIHRnaWQgYW5kIHJldHVybnMgLUVTUkNIIGV2ZW4gaWYgdGhlIFBJ
RAorICogIGV4aXN0cyBidXQgaXQncyBub3QgYmVsb25naW5nIHRvIHRoZSB0YXJnZXQgcHJv
Y2VzcyBhbnltb3JlLiBUaGlzCisgKiAgbWV0aG9kIHNvbHZlcyB0aGUgcHJvYmxlbSBvZiB0
aHJlYWRzIGV4aXRpbmcgYW5kIFBJRHMgZ2V0dGluZyByZXVzZWQuCisgKi8KK2FzbWxpbmth
Z2UgbG9uZyBzeXNfdGdraWxsKGludCB0Z2lkLCBpbnQgcGlkLCBpbnQgc2lnKQoreworCXN0
cnVjdCBzaWdpbmZvIGluZm87CisJaW50IGVycm9yOworCXN0cnVjdCB0YXNrX3N0cnVjdCAq
cDsKKworCS8qIEhhbmRsZSB0Z2tpbGwodGdpZCwgLTEsIHNpZykgbGlrZSBraWxsKHRnaWQs
IHNpZykuICAqLworCWlmIChwaWQgPT0gLTEpCisJCXJldHVybiBzeXNfa2lsbCh0Z2lkLCBz
aWcpOworCisJLyogVGhpcyBpcyBvbmx5IHZhbGlkIGZvciBzaW5nbGUgdGFza3MgKi8KKwlp
ZiAocGlkIDw9IDAgfHwgdGdpZCA8IC0xIHx8IHRnaWQgPT0gMCkKKwkJcmV0dXJuIC1FSU5W
QUw7CisKKwlpbmZvLnNpX3NpZ25vID0gc2lnOworCWluZm8uc2lfZXJybm8gPSAwOworCWlu
Zm8uc2lfY29kZSA9IFNJX1RLSUxMOworCWluZm8uc2lfcGlkID0gY3VycmVudC0+dGdpZDsK
KwlpbmZvLnNpX3VpZCA9IGN1cnJlbnQtPnVpZDsKKworCXJlYWRfbG9jaygmdGFza2xpc3Rf
bG9jayk7CisJcCA9IGZpbmRfdGFza19ieV9waWQocGlkKTsKKwllcnJvciA9IC1FU1JDSDsK
KwkvKiBIYW5kbGUgdGdraWxsKC0xLCBwaWQsIHNpZykgbGlrZSB0a2lsbChwaWQsIHNpZyku
ICAqLworCWlmIChwICYmIChwLT50Z2lkID09IHRnaWQgfHwgdGdpZCA9PSAtMSkpIHsKKwkJ
ZXJyb3IgPSBjaGVja19raWxsX3Blcm1pc3Npb24oc2lnLCAmaW5mbywgcCk7CisJCS8qCisJ
CSAqIFRoZSBudWxsIHNpZ25hbCBpcyBhIHBlcm1pc3Npb25zIGFuZCBwcm9jZXNzIGV4aXN0
ZW5jZQorCQkgKiBwcm9iZS4gIE5vIHNpZ25hbCBpcyBhY3R1YWxseSBkZWxpdmVyZWQuCisJ
CSAqLworCQlpZiAoIWVycm9yICYmIHNpZyAmJiBwLT5zaWdoYW5kKSB7CisJCQlzcGluX2xv
Y2tfaXJxKCZwLT5zaWdoYW5kLT5zaWdsb2NrKTsKKwkJCWhhbmRsZV9zdG9wX3NpZ25hbChz
aWcsIHApOworCQkJZXJyb3IgPSBzcGVjaWZpY19zZW5kX3NpZ19pbmZvKHNpZywgJmluZm8s
IHApOworCQkJc3Bpbl91bmxvY2tfaXJxKCZwLT5zaWdoYW5kLT5zaWdsb2NrKTsKKwkJfQor
CX0KKwlyZWFkX3VubG9jaygmdGFza2xpc3RfbG9jayk7CisJcmV0dXJuIGVycm9yOworfQor
CiAvKgogICogIFNlbmQgYSBzaWduYWwgdG8gb25seSBvbmUgdGFzaywgZXZlbiBpZiBpdCdz
IGEgQ0xPTkVfVEhSRUFEIHRhc2suCiAgKi8K
--------------080302040909000706000900--

