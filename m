Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbSI2QcL>; Sun, 29 Sep 2002 12:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262802AbSI2QcL>; Sun, 29 Sep 2002 12:32:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:59897 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262796AbSI2QcJ>;
	Sun, 29 Sep 2002 12:32:09 -0400
From: Axel <Axel.Zeuner@gmx.de>
Reply-To: Axel.Zeuner@gmx.de
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.5.39: Signal delivery to thread groups: Bug or feature
Date: Sun, 29 Sep 2002 18:56:40 +0200
X-Mailer: KMail [version 1.3.2]
References: <Pine.LNX.4.44.0209291023500.12464-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0209291023500.12464-100000@localhost.localdomain>
Cc: linux-kernel@vger.kernel.org, Axel.Zeuner@systor.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_GQL7KAFUQS4YHMT680KZ"
Message-Id: <20020929163209Z262796-8740+3068@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_GQL7KAFUQS4YHMT680KZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hello Ingo,
On Sunday 29 September 2002 10:25, you wrote:
> On Sat, 28 Sep 2002, Axel wrote:
> > I played a little bit with the new clone flags and wrote a small test
> > program using two threads: The first (initial) thread blocks all
> > signals. The second thread is created with all signals blocked and
> > inherits the signal mask of the initial thread. It unblocks SIGINT and
> > calls sys_rt_sigtimedwait with the remaining signal mask. Therefore it
> > waits for all signals with exception of SIGINT. In the kernel this
> > yields to an empty signal mask for this thread during the sigwait. No
> > signal handler is installed by the process. Now an external SIGINT is
> > delivered to the whole process: The signal delivery code decides to send
> > this signal directly to the initial thread because no user handler is
> > installed and the signal mask for this thread blocks the signal. The
> > second thread never receives the SIGINT.
>
> could you send me the testcase? Thanks,
unfortunately, my test case is part of a thread library which was intended as
replacement for the old linuxthreads library. The idea of this library is to 
have a two level thread library, i.e. posix threads with M:N scheduling on 
top of posix threads with 1:1 scheduling. Starting with a 2.4.18+NGPT patches 
(futexes+tkill) kernel, I implemented a user level signal forwarding scheme, 
for the kernel threads, which worked as expected - slow and with a lot of 
system calls. 
The test program is attached - in principle a test case from NGPT (change 
kth* to pthread*) and use NPT(L) as underlying library.  

After having a look at your changes starting with 2.5.35? i decided to drop 
further development for the old signal scheme and converted the library to 
use all the advantages of the 2.5.X kernels - some of the test cases stopped 
working and I had to look for the reasons. 

I will test your changes to the kernel as soon as possible
IMHO, they will not work as expected, because in the function 
find_unblocked_thread() the real_blocked mask of the thread is also checked:
a thread with all signals blocked calls sys_rt_sigtimedwait to wait for all 
signals, all other threads block all signals. If no signal is pending, the 
real_blocked mask of this thread is set to all filled and the blocked mask
of this thread is set to empty. Later a signal is sent to the process and the 
find_blocked_thread function detects that the sigwait thread has this signal 
not set in its blocked mask but set in its real_blocked mask and does not 
deliver the signal to this thread as it should.
BTW, what is the reason for the existance of the real_blocked mask? I found a 
usage of it only during the sigwaits to store the original signal mask. May 
be a local variable would be a cleaner solution.

Axel

Please CC all mails to me, because I read only the archives of the 
linux-kernel mailing list.





--------------Boundary-00=_GQL7KAFUQS4YHMT680KZ
Content-Type: text/x-c;
  charset="iso-8859-1";
  name="test_signal2.c"
Content-Transfer-Encoding: base64
Content-Description: Sigwait test program,
Content-Disposition: attachment; filename="test_signal2.c"

I2luY2x1ZGUgPGt0aC5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxzdGRpby5oPgoj
aW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxzaWduYWwuaD4KI2luY2x1ZGUgPHN0cmluZy5o
PgojaW5jbHVkZSA8c3lzL3R5cGVzLmg+Cgp2b2lkICpjYXRjaF91c3IxKHZvaWQgKik7Cgp2b2lk
ICpjYXRjaF91c3IxKHZvaWQgKnApCnsKCWludCBzaWdubyA9IFNJR1VTUjE7CglpbnQgY2F1Z2h0
OwoJc2lnc2V0X3Qgc2lnc190b19jYXRjaDsKCXNpZ3NldF90IHM7CgkvKiBVbmJsb2NrIFNJR0lO
VCAqLwoJc2lnZW1wdHlzZXQoJnNpZ3NfdG9fY2F0Y2gpOwoJc2lnYWRkc2V0KCZzaWdzX3RvX2Nh
dGNoLCBTSUdJTlQpOwoJa3RoX3NpZ21hc2soU0lHX1VOQkxPQ0ssICZzaWdzX3RvX2NhdGNoLCAm
cyk7CgkvKiBJZGVudGlmeSBvdXIgdGhyZWFkICovCglwcmludGYoImNhdGNoX3VzcjE6IHNpZ25h
bCAlZCBwcm9jZXNzaW5nIHJ1bm5pbmcgYXMgdGhyZWFkICVsdSBcbiIsCgkgICAgICAgc2lnbm8s
IGt0aF9zZWxmKCkpOwoJcHJpbnRmKCJjYXRjaF91c3IxOiBTb21lb25lIHBsZWFzZSBzZW5kIHBp
ZCAlZCBhIFNJR1VTUjFcbiIsIGdldHBpZCgpKTsKCgkvKgoJICogV2UgaW5oZXJpdGVkIGEgdGhy
ZWFkIHNpZ21hc2sgd2l0aCBhbGwgdGhlIHNpZ25hbHMgCgkgKiBibG9ja2VkLiAgU28sIHdlIGNh
biB3YWl0IG9uIHdoYXRldmVyIHNpZ25hbHMgd2UncmUKCSAqIGludGVyZXN0ZWQgaW4gYW5kIChh
cyBsb25nIGFzIG5vIG90aGVyIHRocmVhZCB3YWl0cwoJICogZm9yIHRoZW0pIHdlJ2xsIGJlIHN1
cmUgcmV0dXJuIGZyb20gc2lnd2FpdCgpIHRvCgkgKiBoYW5kbGUgaXQuCgkgKi8KCgkvKiBzZXQg
dGhpcyB0aHJlYWQncyBzaWduYWwgbWFzayB0byBibG9jayBvdXQgYWxsIG90aGVyIHNpZ25hbHMg
Ki8KCXNpZ2FkZHNldCgmc2lnc190b19jYXRjaCwgc2lnbm8pOwoJc2lnd2FpdCgmc2lnc190b19j
YXRjaCwgJmNhdWdodCk7CgoJcHJpbnRmKCJjYXRjaF91c3IxOiBzaWduYWwgJWQgcHJvY2Vzc2lu
ZyB0aHJlYWQgY2F1Z2h0IHNpZ25hbCAlZFxuIiwKCSAgICAgICBzaWdubywgY2F1Z2h0KTsKCXJl
dHVybiAocCk7Cn0KCmV4dGVybiBpbnQgbWFpbih2b2lkKQp7CglpbnQgaTsKCWt0aF90IHRocmVh
ZHNbMV07CglpbnQgbnVtX3RocmVhZHMgPSAwOwoJc2lnc2V0X3Qgc2lnc190b19ibG9jazsKCgkv
KiBJZGVudGlmeSBvdXIgdGhyZWFkICovCglwcmludGYoIm1haW46IHJ1bm5pbmcgaW4gdGhyZWFk
IDB4JXhcbiIsIChpbnQpa3RoX3NlbGYoKSk7CgkvKiAKCSAqIFNldCB0aGlzIHRocmVhZCdzIHNp
Z25hbCBtYXNrIHRvIGJsb2NrIG91dCBhbGwgb3RoZXIgc2lnbmFscwoJICogT3RoZXIgdGhyZWFk
J3Mgd2lsbCBpbmhlcml0IHRoZSBtYXNrCgkgKi8KCS8qIEJMT0NLIEFMTCBTSUdOQUxTICovCglz
aWdmaWxsc2V0KCZzaWdzX3RvX2Jsb2NrKTsKCS8qIHNpZ2RlbHNldCgmc2lnc190b19ibG9jayxT
SUdJTlQpOyAqLwoJa3RoX3NpZ21hc2soU0lHX0JMT0NLLCAmc2lnc190b19ibG9jaywgTlVMTCk7
CgkvKiBTZXQgc2lnbmFsIGhhbmRsZXIgZm9yIGNhdGNoaW5nIFNJR1NFR1YgYW5kIFNJR0JVUyAq
LwoKCS8qIFJhdGhlciB0aGFuIGluc3RhbGwgdGhlIGFjdGlvbi9oYW5kbGVyIGZvciB0aGUgcHJv
Y2VzcywKCSAgIHdlIGNyZWF0ZSBhIHRocmVhZCB0byB3YWl0IGZvciB0aGUgc2lnbmFsICovCglr
dGhfY3JlYXRlKCZ0aHJlYWRzW251bV90aHJlYWRzKytdLCBOVUxMLCBjYXRjaF91c3IxLCBOVUxM
KTsKCXByaW50ZigibWFpbjogJWQgdGhyZWFkcyBjcmVhdGVkXG4iLCBudW1fdGhyZWFkcyk7Cgkv
KiB3YWl0IHVudGlsIGFsbCB0aHJlYWRzIGhhdmUgZmluaXNoZWQgKi8KCWZvciAoaSA9IDA7IGkg
PCBudW1fdGhyZWFkczsgaSsrKSB7CgkJa3RoX2pvaW4odGhyZWFkc1tpXSwgTlVMTCk7CgkJcHJp
bnRmKCJtYWluOiBqb2luZWQgdG8gdGhyZWFkICVkIFxuIiwgaSk7Cgl9CglwcmludGYoIm1haW46
IGFsbCAlZCB0aHJlYWRzIGhhdmUgZmluaXNoZWQuIFxuIiwgbnVtX3RocmVhZHMpOwoJcmV0dXJu
IDA7Cn0K

--------------Boundary-00=_GQL7KAFUQS4YHMT680KZ--
