Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWC1LoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWC1LoT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 06:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWC1LoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 06:44:19 -0500
Received: from TYO206.gate.nec.co.jp ([202.32.8.206]:20676 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932220AbWC1LoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 06:44:19 -0500
Message-ID: <44292175.6030605@ak.jp.nec.com>
Date: Tue, 28 Mar 2006 20:43:49 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Cc: Roland McGrath <roland@redhat.com>
Subject: Fix pacct bug in multithreading case.
Content-Type: multipart/mixed;
 boundary="------------040100080307080208000807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040100080307080208000807
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hello,

I noticed a bug on the process accounting facility.
In multi-threading process, some data would be recorded incorrectly
when the group_leader dies earlier than one or more threads.
The attached patch fixes this problem.

See below. 'bugacct' is a test program that create a worker thread
after 4 seconds sleeping, then the group_leader dies soon.
The worker thread consume CPU/Memory for 6 seconds, then exit.
We can estimate 10 seconds as etime and 6 seconds as stime + utime.
This is a sample program which the group_leader dies earlier than
other threads.

The results of same binary execution on different kernel are below.
-- accounted records --------------------
         |   btime  | utime | stime | etime | minflt | majflt |   comm  |
original | 13:16:40 |  0.00 |  0.00 |  6.10 |    171 |      0 | bugacct |
 patched | 13:20:21 |  5.83 |  0.18 | 10.03 |  32776 |      0 | bugacct |
(*) bugacct allocates 128MB memory, thus 128MB / 4KB = 32768 of minflt is
    appropriate.

-- Test results in original kernel ------
$ date; time -p ./bugacct
Tue Mar 28 13:16:36 JST 2006  <- But pacct said btime is 13:16:40
real 10.11                    <- But pacct said etime is 6.10
user 5.96                     <- But pacct said utime is 0.00
sys 0.14                      <- But pacct said stime is 0.00
$
-- Test results in patched kernel -------
$ date; time -p ./bugacct
Tue Mar 28 13:20:21 JST 2006
real 10.04
user 5.83
sys 0.19
$

In the original 2.6.16 kernel, pacct records btime, utime, stime, etime and
minflt incorrectly. In my opinion, this problem is caused by an assumption
that group_leader dies last.

The following section calculates process running time for etime and btime.
But it means running time of the thread that dies last, not process.
The start_time of the first thread in the process (group_leader) should
be reduced from uptime to calculate etime and btime correctly.
---- do_acct_process() in kernel/acct.c:
/* calculate run_time in nsec*/
do_posix_clock_monotonic_gettime(&uptime);
run_time = (u64)uptime.tv_sec*NSEC_PER_SEC + uptime.tv_nsec;
run_time -= (u64)current->start_time.tv_sec*NSEC_PER_SEC
                                + current->start_time.tv_nsec;
----

The following section calculates stime and utime of the process.
But it might count the utime and stime of the group_leader duplicatly
and ignore the utime and stime of the thread dies last, when one or
more threads remain after group_leader dead.
The ac_utime should be calculated as the sum of the signal->utime
and utime of the thread dies last. The ac_stime should be done also.
---- do_acct_process() in kernel/acct.c:
jiffies = cputime_to_jiffies(cputime_add(current->group_leader->utime,
                                         current->signal->utime));
ac.ac_utime = encode_comp_t(jiffies_to_AHZ(jiffies));
jiffies = cputime_to_jiffies(cputime_add(current->group_leader->stime,
                                         current->signal->stime));
ac.ac_stime = encode_comp_t(jiffies_to_AHZ(jiffies));
----

The part of the minflt/majflt calculation has same problem.
This patch solves those problems, I think.

Any comments are welcome. Thanks.
-- 
Linux Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------040100080307080208000807
Content-Type: text/plain;
 name="fixbug_pacct_incorrect_records.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="fixbug_pacct_incorrect_records.patch"

LS0tIGxpbnV4LTIuNi4xNi9rZXJuZWwvYWNjdC5jCTIwMDYtMDMtMjAgMTQ6NTM6MjkuMDAw
MDAwMDAwICswOTAwCisrKyBsaW51eC0yLjYuMTYta2cva2VybmVsL2FjY3QuYwkyMDA2LTAz
LTI3IDE2OjI1OjExLjAwMDAwMDAwMCArMDkwMApAQCAtNDQ5LDggKzQ0OSw4IEBAIHN0YXRp
YyB2b2lkIGRvX2FjY3RfcHJvY2Vzcyhsb25nIGV4aXRjb2QKIAkvKiBjYWxjdWxhdGUgcnVu
X3RpbWUgaW4gbnNlYyovCiAJZG9fcG9zaXhfY2xvY2tfbW9ub3RvbmljX2dldHRpbWUoJnVw
dGltZSk7CiAJcnVuX3RpbWUgPSAodTY0KXVwdGltZS50dl9zZWMqTlNFQ19QRVJfU0VDICsg
dXB0aW1lLnR2X25zZWM7Ci0JcnVuX3RpbWUgLT0gKHU2NCljdXJyZW50LT5zdGFydF90aW1l
LnR2X3NlYypOU0VDX1BFUl9TRUMKLQkJCQkJKyBjdXJyZW50LT5zdGFydF90aW1lLnR2X25z
ZWM7CisJcnVuX3RpbWUgLT0gKHU2NCljdXJyZW50LT5ncm91cF9sZWFkZXItPnN0YXJ0X3Rp
bWUudHZfc2VjICogTlNFQ19QRVJfU0VDCisJCSAgICAgICArIGN1cnJlbnQtPmdyb3VwX2xl
YWRlci0+c3RhcnRfdGltZS50dl9uc2VjOwogCS8qIGNvbnZlcnQgbnNlYyAtPiBBSFogKi8K
IAllbGFwc2VkID0gbnNlY190b19BSFoocnVuX3RpbWUpOwogI2lmIEFDQ1RfVkVSU0lPTj09
MwpAQCAtNDY5LDEwICs0NjksMTAgQEAgc3RhdGljIHZvaWQgZG9fYWNjdF9wcm9jZXNzKGxv
bmcgZXhpdGNvZAogI2VuZGlmCiAJZG9fZGl2KGVsYXBzZWQsIEFIWik7CiAJYWMuYWNfYnRp
bWUgPSB4dGltZS50dl9zZWMgLSBlbGFwc2VkOwotCWppZmZpZXMgPSBjcHV0aW1lX3RvX2pp
ZmZpZXMoY3B1dGltZV9hZGQoY3VycmVudC0+Z3JvdXBfbGVhZGVyLT51dGltZSwKKwlqaWZm
aWVzID0gY3B1dGltZV90b19qaWZmaWVzKGNwdXRpbWVfYWRkKGN1cnJlbnQtPnV0aW1lLAog
CQkJCQkJIGN1cnJlbnQtPnNpZ25hbC0+dXRpbWUpKTsKIAlhYy5hY191dGltZSA9IGVuY29k
ZV9jb21wX3QoamlmZmllc190b19BSFooamlmZmllcykpOwotCWppZmZpZXMgPSBjcHV0aW1l
X3RvX2ppZmZpZXMoY3B1dGltZV9hZGQoY3VycmVudC0+Z3JvdXBfbGVhZGVyLT5zdGltZSwK
KwlqaWZmaWVzID0gY3B1dGltZV90b19qaWZmaWVzKGNwdXRpbWVfYWRkKGN1cnJlbnQtPnN0
aW1lLAogCQkJCQkJIGN1cnJlbnQtPnNpZ25hbC0+c3RpbWUpKTsKIAlhYy5hY19zdGltZSA9
IGVuY29kZV9jb21wX3QoamlmZmllc190b19BSFooamlmZmllcykpOwogCS8qIHdlIHJlYWxs
eSBuZWVkIHRvIGJpdGUgdGhlIGJ1bGxldCBhbmQgY2hhbmdlIGxheW91dCAqLwpAQCAtNTIy
LDkgKzUyMiw5IEBAIHN0YXRpYyB2b2lkIGRvX2FjY3RfcHJvY2Vzcyhsb25nIGV4aXRjb2QK
IAlhYy5hY19pbyA9IGVuY29kZV9jb21wX3QoMCAvKiBjdXJyZW50LT5pb191c2FnZSAqLyk7
CS8qICUlICovCiAJYWMuYWNfcncgPSBlbmNvZGVfY29tcF90KGFjLmFjX2lvIC8gMTAyNCk7
CiAJYWMuYWNfbWluZmx0ID0gZW5jb2RlX2NvbXBfdChjdXJyZW50LT5zaWduYWwtPm1pbl9m
bHQgKwotCQkJCSAgICAgY3VycmVudC0+Z3JvdXBfbGVhZGVyLT5taW5fZmx0KTsKKwkJCQkg
ICAgIGN1cnJlbnQtPm1pbl9mbHQpOwogCWFjLmFjX21hamZsdCA9IGVuY29kZV9jb21wX3Qo
Y3VycmVudC0+c2lnbmFsLT5tYWpfZmx0ICsKLQkJCQkgICAgIGN1cnJlbnQtPmdyb3VwX2xl
YWRlci0+bWFqX2ZsdCk7CisJCQkJICAgICBjdXJyZW50LT5tYWpfZmx0KTsKIAlhYy5hY19z
d2FwcyA9IGVuY29kZV9jb21wX3QoMCk7CiAJYWMuYWNfZXhpdGNvZGUgPSBleGl0Y29kZTsK
IAo=
--------------040100080307080208000807
Content-Type: text/plain;
 name="bugacct.c"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="bugacct.c"

I2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxwdGhy
ZWFkLmg+CiNpbmNsdWRlIDxzeXMvdGltZS5oPgoKI2RlZmluZSBCVUZGRVJfU0laRSAoMTI4
ICogMTAyNCAqIDEwMjQpICAvKiAxMjhNQiAqLwoKdm9pZCAqbXljaGlsZCh2b2lkICpidWZm
ZXIpIHsKCXN0cnVjdCB0aW1ldmFsIHR2OwoJdV9pbnQ2NF90IHQxLCB0MjsKCglnZXR0aW1l
b2ZkYXkoJnR2LCBOVUxMKTsKCXQxID0gdHYudHZfc2VjICogMTAwMDAwMCArIHR2LnR2X3Vz
ZWM7Cgl0MiA9IHQxICsgNiAqIDEwMDAwMDA7CgkvKiBoZWF2eSBDUFUvTWVtIGpvYiAqLwoJ
c3JhbmQodHYudHZfdXNlYyk7Cgl3aGlsZSh0MSA8IHQyKSB7CgkgICAgbWVtc2V0KGJ1ZmZl
ciwgcmFuZCgpLCBCVUZGRVJfU0laRSk7CiAgICAgICAgICAgIGdldHRpbWVvZmRheSgmdHYs
IE5VTEwpOwogICAgICAgICAgICB0MSA9IHR2LnR2X3NlYyAqIDEwMDAwMDAgKyB0di50dl91
c2VjOwoJfQoJcmV0dXJuIE5VTEw7Cn0KCmludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2
W10pIHsKCXB0aHJlYWRfdCBwdGhyZWFkOwoJdm9pZCAqYnVmZmVyID0gTlVMTDsKCQoJYnVm
ZmVyID0gbWFsbG9jKEJVRkZFUl9TSVpFKTsKCWlmICghYnVmZmVyKQoJICAgIHJldHVybiAx
OwoKCXNsZWVwKDQpOwoJcHRocmVhZF9jcmVhdGUoJnB0aHJlYWQsIE5VTEwsIG15Y2hpbGQs
IGJ1ZmZlcik7CglzbGVlcCgxKTsKCXB0aHJlYWRfZXhpdCgwKTsKfQo=
--------------040100080307080208000807--
