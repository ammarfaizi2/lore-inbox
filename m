Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131508AbQL3Dji>; Fri, 29 Dec 2000 22:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132152AbQL3Dj2>; Fri, 29 Dec 2000 22:39:28 -0500
Received: from winds.org ([209.115.81.9]:30469 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S131508AbQL3DjX>;
	Fri, 29 Dec 2000 22:39:23 -0500
Date: Fri, 29 Dec 2000 22:08:49 -0500 (EST)
From: Byron Stanoszek <gandalf@winds.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <aviro@redhat.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, "Marco d'Itri" <md@Linux.IT>,
        Jeff Lightfoot <jeffml@pobox.com>, Dan Aloni <karrde@callisto.yi.org>,
        Anton Blanchard <anton@linuxcare.com.au>
Subject: Re: test13-pre6 (Fork Bug with Athlons? Temporary Fix)
In-Reply-To: <Pine.LNX.4.10.10012291609470.1123-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0012292156200.11714-200000@winds.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1943079249-703973798-978145729=:11714"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1943079249-703973798-978145729=:11714
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 29 Dec 2000, Linus Torvalds wrote:

> 
> Ok, there's a test13-pre6 out there now, which does a partial sync with
> Alan, in addition to hopefully fixing the innd shared mapping writeback
> problem for good.  Thanks to Marcelo Tosatti and others..

I've been noticing a problem with the memory context switching conflicting with
fork() on my Athlon. The problem began in the test13-pre2 patch, and because
nobody else has seen this problem (or otherwise reported it) since then, I
felt I should look into it a little further.

I narrowed the problem down to a subset of patches from the MM set in
test13-pre2. Reversing the attached 'context.patch' fixes the problem (only for
i386), but I'm not yet sure why. test13-pre2 and up work without any problems
on an Intel cpu (Pentium 180 & P3 800 tested).

Anyways, I can't seem to find out what really changes with the patch except for
the obvious 'void *segment' changing into a typedef-struct. The only thing I
can think of is that the compiler decodes it differently, but I think I can
safely rule that out. I tried both 2.91.66 and 2.95.2, using both different
types of parameters for P5 & K7 (-march=i586 & -march=i686 -malign-functions=4)
and it still gives the problem on the Athlon. Maybe there's something I've
overlooked in that attached patch. Request for an extra pair of eyes please. :)


Here are the casual symptoms. The parent seems to die as soon as a forked child
exits, which seems to me that a new LDT isn't being initialized correctly:

root:~> ps -aux
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  1.1  0.4  1228  532 ?        S    21:42   0:05 init [3]
root         2  0.0  0.0     0    0 ?        SW   21:42   0:00 [keventd]
root         3  0.0  0.0     0    0 ?        SW   21:42   0:00 [kswapd]
root         4  0.0  0.0     0    0 ?        SW   21:42   0:00 [kreclaimd]
root         5  0.0  0.0     0    0 ?        SW   21:42   0:00 [bdflush]
root         6  0.0  0.0     0    0 ?        SW   21:42   0:00 [kupdate]
root       289  0.0  0.4  1284  604 ?        S    21:42   0:00 syslogd -m 0
root       299  0.0  0.8  1912 1104 ?        S    21:42   0:00 klogd
root       351  0.0  1.2  9292 1576 ?        S    21:42   0:00 named
root       361  0.0  0.0     0    0 ?        Z    21:42   0:00 [named <defunct>]
root       363  0.0  1.2  9292 1576 ?        S    21:42   0:00 named
root       364  0.0  1.2  9292 1576 ?        S    21:42   0:00 named
root       365  0.0  0.7  2064  936 ?        S    21:42   0:00 /usr/sbin/sshd
..etc
(Note PID 361)

root:~> strace nslookup sunsite.unc.edu
 :
 :
rt_sigaction(SIGINT, {0x4003ce78, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGTERM, {0x4003ce78, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGPIPE, {SIG_IGN}, NULL, 8) = 0
rt_sigaction(SIGHUP, {SIG_DFL}, NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [HUP INT TERM], NULL, 8) = 0
getpid()                                = 2615
socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 3
close(3)                                = 0
socket(PF_INET6, SOCK_STREAM, 0)        = -1 ENOSYS (Function not implemented)
socket(PF_INET6, SOCK_STREAM, 0)        = -1 ENOSYS (Function not implemented)
socket(PF_INET6, SOCK_STREAM, 0)        = -1 EAFNOSUPPORT (Address family not supported by protocol)--- SIGSEGV (Segmentation fault) ---
+++ killed by SIGSEGV +++


---Example parent/child process:

root:~> tar -xzvvf ../pkgs/zgv-5.2.tar.gz
 :
 :
-rw------- rus/users      1356 2000-06-01 11:46:57 zgv-5.2/INSTALL
-rw------- rus/users     17976 1994-08-23 16:09:05 zgv-5.2/COPYING
-rw------- rus/users      1077 1998-08-26 09:24:31 zgv-5.2/README.fonts
-rw------- rus/users       120 2000-04-22 22:46:49 zgv-5.2/AUTHORS
-rw------- rus/users      3714 2000-01-23 16:29:40 zgv-5.2/SECURITY
Segmentation fault (core dumped)

root:~> strace tar -xzvvf ../pkgs/zgv-5.2.tar.gz
 :
 :
open("zgv-5.2/COPYING", O_WRONLY|O_CREAT|O_EXCL|O_LARGEFILE, 0600) = 4
write(4, "\t\t    GNU GENERAL PUBLIC LICENSE"..., 9728) = 9728
read(3, "ccept this License.  Therefore, "..., 10240) = 10240
write(4, "ccept this License.  Therefore, "..., 8248) = 8248
close(4)                                = 0
utime("zgv-5.2/COPYING", [2000/12/29-20:21:16, 1994/08/23-16:09:05]) = 0
chown32("zgv-5.2/COPYING", 500, 100)    = 0
write(1, "-rw------- rus/users      1077 1"..., 72-rw------- rus/users      1077 1998-08-26 09:24:31 zgv-5.2/README.fonts
) = 72
open("zgv-5.2/README.fonts", O_WRONLY|O_CREAT|O_EXCL|O_LARGEFILE, 0600) = 4
write(4, "The copyright for *.bdf (taken f"..., 1024) = 1024
read(3, "\"as\nis\" without express or impli"..., 10240) = 8192
--- SIGCHLD (Child exited) ---
--- SIGSEGV (Segmentation fault) ---
+++ killed by SIGSEGV +++

Ideas, anyone?

 -Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: bstanoszek@comtime.com

--1943079249-703973798-978145729=:11714
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="context.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0012292208490.11714@winds.org>
Content-Description: 
Content-Disposition: attachment; filename="context.patch"

ZGlmZiAtdSAtLXJlY3Vyc2l2ZSAtLW5ldy1maWxlIHYyLjQuMC10ZXN0MTIv
bGludXgvYXJjaC9pMzg2L2tlcm5lbC9sZHQuYyBsaW51eC9hcmNoL2kzODYv
a2VybmVsL2xkdC5jDQotLS0gdjIuNC4wLXRlc3QxMi9saW51eC9hcmNoL2kz
ODYva2VybmVsL2xkdC5jCVNhdCBNYXkgMjAgMTA6Mzk6NTggMjAwMA0KKysr
IGxpbnV4L2FyY2gvaTM4Ni9rZXJuZWwvbGR0LmMJRnJpIERlYyAxNSAxMzow
MTo1OSAyMDAwDQpAQCAtMzEsNyArMzEsNyBAQA0KIAlzdHJ1Y3QgbW1fc3Ry
dWN0ICogbW0gPSBjdXJyZW50LT5tbTsNCiANCiAJZXJyID0gMDsNCi0JaWYg
KCFtbS0+c2VnbWVudHMpDQorCWlmICghbW0tPmNvbnRleHQuc2VnbWVudHMp
DQogCQlnb3RvIG91dDsNCiANCiAJc2l6ZSA9IExEVF9FTlRSSUVTKkxEVF9F
TlRSWV9TSVpFOw0KQEAgLTM5LDcgKzM5LDcgQEANCiAJCXNpemUgPSBieXRl
Y291bnQ7DQogDQogCWVyciA9IHNpemU7DQotCWlmIChjb3B5X3RvX3VzZXIo
cHRyLCBtbS0+c2VnbWVudHMsIHNpemUpKQ0KKwlpZiAoY29weV90b191c2Vy
KHB0ciwgbW0tPmNvbnRleHQuc2VnbWVudHMsIHNpemUpKQ0KIAkJZXJyID0g
LUVGQVVMVDsNCiBvdXQ6DQogCXJldHVybiBlcnI7DQpAQCAtODcsMTMgKzg3
LDEyIEBADQogCSAqIGxpbWl0ZWQgYnkgTUFYX0xEVF9ERVNDUklQVE9SUy4N
CiAJICovDQogCWRvd24oJm1tLT5tbWFwX3NlbSk7DQotCWlmICghbW0tPnNl
Z21lbnRzKSB7DQotCQkNCisJaWYgKCFtbS0+Y29udGV4dC5zZWdtZW50cykg
ew0KIAkJZXJyb3IgPSAtRU5PTUVNOw0KLQkJbW0tPnNlZ21lbnRzID0gdm1h
bGxvYyhMRFRfRU5UUklFUypMRFRfRU5UUllfU0laRSk7DQotCQlpZiAoIW1t
LT5zZWdtZW50cykNCisJCW1tLT5jb250ZXh0LnNlZ21lbnRzID0gdm1hbGxv
YyhMRFRfRU5UUklFUypMRFRfRU5UUllfU0laRSk7DQorCQlpZiAoIW1tLT5j
b250ZXh0LnNlZ21lbnRzKQ0KIAkJCWdvdG8gb3V0X3VubG9jazsNCi0JCW1l
bXNldChtbS0+c2VnbWVudHMsIDAsIExEVF9FTlRSSUVTKkxEVF9FTlRSWV9T
SVpFKTsNCisJCW1lbXNldChtbS0+Y29udGV4dC5zZWdtZW50cywgMCwgTERU
X0VOVFJJRVMqTERUX0VOVFJZX1NJWkUpOw0KIAkJDQogCQlpZiAoYXRvbWlj
X3JlYWQoJm1tLT5tbV91c2VycykgPiAxKQ0KIAkJCXByaW50ayhLRVJOX1dB
Uk5JTkcgIkxEVCBhbGxvY2F0ZWQgZm9yIGNsb25lZCB0YXNrIVxuIik7DQpA
QCAtMTA0LDcgKzEwMyw3IEBADQogCQlsb2FkX0xEVChtbSk7DQogCX0NCiAN
Ci0JbHAgPSAoX191MzIgKikgKChsZHRfaW5mby5lbnRyeV9udW1iZXIgPDwg
MykgKyAoY2hhciAqKSBtbS0+c2VnbWVudHMpOw0KKwlscCA9IChfX3UzMiAq
KSAoKGxkdF9pbmZvLmVudHJ5X251bWJlciA8PCAzKSArIChjaGFyICopIG1t
LT5jb250ZXh0LnNlZ21lbnRzKTsNCiANCiAgICAJLyogQWxsb3cgTERUcyB0
byBiZSBjbGVhcmVkIGJ5IHRoZSB1c2VyLiAqLw0KICAgIAlpZiAobGR0X2lu
Zm8uYmFzZV9hZGRyID09IDAgJiYgbGR0X2luZm8ubGltaXQgPT0gMCkgew0K
ZGlmZiAtdSAtLXJlY3Vyc2l2ZSAtLW5ldy1maWxlIHYyLjQuMC10ZXN0MTIv
bGludXgvYXJjaC9pMzg2L2tlcm5lbC9wcm9jZXNzLmMgbGludXgvYXJjaC9p
Mzg2L2tlcm5lbC9wcm9jZXNzLmMNCi0tLSB2Mi40LjAtdGVzdDEyL2xpbnV4
L2FyY2gvaTM4Ni9rZXJuZWwvcHJvY2Vzcy5jCU1vbiBEZWMgMTEgMTc6NTk6
NDMgMjAwMA0KKysrIGxpbnV4L2FyY2gvaTM4Ni9rZXJuZWwvcHJvY2Vzcy5j
CUZyaSBEZWMgMTUgMTU6Mzc6MDkgMjAwMA0KQEAgLTQxMiwxNSArNDEyLDE1
IEBADQogLyoNCiAgKiBObyBuZWVkIHRvIGxvY2sgdGhlIE1NIGFzIHdlIGFy
ZSB0aGUgbGFzdCB1c2VyDQogICovDQotdm9pZCByZWxlYXNlX3NlZ21lbnRz
KHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQ0KK3ZvaWQgZGVzdHJveV9jb250ZXh0
KHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQ0KIHsNCi0Jdm9pZCAqIGxkdCA9IG1t
LT5zZWdtZW50czsNCisJdm9pZCAqIGxkdCA9IG1tLT5jb250ZXh0LnNlZ21l
bnRzOw0KIA0KIAkvKg0KIAkgKiBmcmVlIHRoZSBMRFQNCiAJICovDQogCWlm
IChsZHQpIHsNCi0JCW1tLT5zZWdtZW50cyA9IE5VTEw7DQorCQltbS0+Y29u
dGV4dC5zZWdtZW50cyA9IE5VTEw7DQogCQljbGVhcl9MRFQoKTsNCiAJCXZm
cmVlKGxkdCk7DQogCX0NCkBAIC00NzgsNyArNDc4LDcgQEANCiB2b2lkIHJl
bGVhc2VfdGhyZWFkKHN0cnVjdCB0YXNrX3N0cnVjdCAqZGVhZF90YXNrKQ0K
IHsNCiAJaWYgKGRlYWRfdGFzay0+bW0pIHsNCi0JCXZvaWQgKiBsZHQgPSBk
ZWFkX3Rhc2stPm1tLT5zZWdtZW50czsNCisJCXZvaWQgKiBsZHQgPSBkZWFk
X3Rhc2stPm1tLT5jb250ZXh0LnNlZ21lbnRzOw0KIA0KIAkJLy8gdGVtcG9y
YXJ5IGRlYnVnZ2luZyBjaGVjaw0KIAkJaWYgKGxkdCkgew0KQEAgLTQ5Mywy
OSArNDkzLDI0IEBADQogICogd2UgZG8gbm90IGhhdmUgdG8gbXVjayB3aXRo
IGRlc2NyaXB0b3JzIGhlcmUsIHRoYXQgaXMNCiAgKiBkb25lIGluIHN3aXRj
aF9tbSgpIGFzIG5lZWRlZC4NCiAgKi8NCi12b2lkIGNvcHlfc2VnbWVudHMo
c3RydWN0IHRhc2tfc3RydWN0ICpwLCBzdHJ1Y3QgbW1fc3RydWN0ICpuZXdf
bW0pDQoraW50IGluaXRfbmV3X2NvbnRleHQoc3RydWN0IHRhc2tfc3RydWN0
ICpwLCBzdHJ1Y3QgbW1fc3RydWN0ICpuZXdfbW0pDQogew0KLQlzdHJ1Y3Qg
bW1fc3RydWN0ICogb2xkX21tID0gY3VycmVudC0+bW07DQotCXZvaWQgKiBv
bGRfbGR0ID0gb2xkX21tLT5zZWdtZW50cywgKiBsZHQ7DQorCXN0cnVjdCBt
bV9zdHJ1Y3QgKiBvbGRfbW07DQorCXZvaWQgKm9sZF9sZHQsICpsZHQ7DQog
DQotCWlmICghb2xkX2xkdCkgew0KKwlsZHQgPSBOVUxMOw0KKwlvbGRfbW0g
PSBjdXJyZW50LT5tbTsNCisJaWYgKG9sZF9tbSAmJiAob2xkX2xkdCA9IG9s
ZF9tbS0+Y29udGV4dC5zZWdtZW50cykgIT0gTlVMTCkgew0KIAkJLyoNCi0J
CSAqIGRlZmF1bHQgTERUIC0gdXNlIHRoZSBvbmUgZnJvbSBpbml0X3Rhc2sN
CisJCSAqIENvbXBsZXRlbHkgbmV3IExEVCwgd2UgaW5pdGlhbGl6ZSBpdCBm
cm9tIHRoZSBwYXJlbnQ6DQogCQkgKi8NCi0JCW5ld19tbS0+c2VnbWVudHMg
PSBOVUxMOw0KLQkJcmV0dXJuOw0KLQl9DQotDQotCS8qDQotCSAqIENvbXBs
ZXRlbHkgbmV3IExEVCwgd2UgaW5pdGlhbGl6ZSBpdCBmcm9tIHRoZSBwYXJl
bnQ6DQotCSAqLw0KLQlsZHQgPSB2bWFsbG9jKExEVF9FTlRSSUVTKkxEVF9F
TlRSWV9TSVpFKTsNCi0JaWYgKCFsZHQpDQotCQlwcmludGsoS0VSTl9XQVJO
SU5HICJsZHQgYWxsb2NhdGlvbiBmYWlsZWRcbiIpOw0KLQllbHNlDQorCQls
ZHQgPSB2bWFsbG9jKExEVF9FTlRSSUVTKkxEVF9FTlRSWV9TSVpFKTsNCisJ
CWlmICghbGR0KQ0KKwkJCXJldHVybiAtRU5PTUVNOw0KIAkJbWVtY3B5KGxk
dCwgb2xkX2xkdCwgTERUX0VOVFJJRVMqTERUX0VOVFJZX1NJWkUpOw0KLQlu
ZXdfbW0tPnNlZ21lbnRzID0gbGR0Ow0KLQlyZXR1cm47DQorCX0NCisJbmV3
X21tLT5jb250ZXh0LnNlZ21lbnRzID0gbGR0Ow0KKwlyZXR1cm4gMDsNCiB9
DQogDQogLyoNCmRpZmYgLXUgLS1yZWN1cnNpdmUgLS1uZXctZmlsZSB2Mi40
LjAtdGVzdDEyL2xpbnV4L2luY2x1ZGUvYXNtLWkzODYvZGVzYy5oIGxpbnV4
L2luY2x1ZGUvYXNtLWkzODYvZGVzYy5oDQotLS0gdjIuNC4wLXRlc3QxMi9s
aW51eC9pbmNsdWRlL2FzbS1pMzg2L2Rlc2MuaAlTYXQgU2VwICA0IDEzOjA2
OjA4IDE5OTkNCisrKyBsaW51eC9pbmNsdWRlL2FzbS1pMzg2L2Rlc2MuaAlG
cmkgRGVjIDE1IDEyOjQwOjUzIDIwMDANCkBAIC04Miw3ICs4Miw3IEBADQog
ZXh0ZXJuIGlubGluZSB2b2lkIGxvYWRfTERUIChzdHJ1Y3QgbW1fc3RydWN0
ICptbSkNCiB7DQogCWludCBjcHUgPSBzbXBfcHJvY2Vzc29yX2lkKCk7DQot
CXZvaWQgKnNlZ21lbnRzID0gbW0tPnNlZ21lbnRzOw0KKwl2b2lkICpzZWdt
ZW50cyA9IG1tLT5jb250ZXh0LnNlZ21lbnRzOw0KIAlpbnQgY291bnQgPSBM
RFRfRU5UUklFUzsNCiANCiAJaWYgKCFzZWdtZW50cykgew0KZGlmZiAtdSAt
LXJlY3Vyc2l2ZSAtLW5ldy1maWxlIHYyLjQuMC10ZXN0MTIvbGludXgvaW5j
bHVkZS9hc20taTM4Ni9tbXUuaCBsaW51eC9pbmNsdWRlL2FzbS1pMzg2L21t
dS5oDQotLS0gdjIuNC4wLXRlc3QxMi9saW51eC9pbmNsdWRlL2FzbS1pMzg2
L21tdS5oCVdlZCBEZWMgMzEgMTY6MDA6MDAgMTk2OQ0KKysrIGxpbnV4L2lu
Y2x1ZGUvYXNtLWkzODYvbW11LmgJRnJpIERlYyAxNSAxMjozODoyNCAyMDAw
DQpAQCAtMCwwICsxLDEyIEBADQorI2lmbmRlZiBfX2kzODZfTU1VX0gNCisj
ZGVmaW5lIF9faTM4Nl9NTVVfSA0KKw0KKy8qDQorICogVGhlIGkzODYgZG9l
c24ndCBoYXZlIGEgbW11IGNvbnRleHQsIGJ1dA0KKyAqIHdlIHB1dCB0aGUg
c2VnbWVudCBpbmZvcm1hdGlvbiBoZXJlLg0KKyAqLw0KK3R5cGVkZWYgc3Ry
dWN0IHsgDQorCXZvaWQgKnNlZ21lbnRzOw0KK30gbW1fY29udGV4dF90Ow0K
Kw0KKyNlbmRpZg0KZGlmZiAtdSAtLXJlY3Vyc2l2ZSAtLW5ldy1maWxlIHYy
LjQuMC10ZXN0MTIvbGludXgvaW5jbHVkZS9hc20taTM4Ni9tbXVfY29udGV4
dC5oIGxpbnV4L2luY2x1ZGUvYXNtLWkzODYvbW11X2NvbnRleHQuaA0KLS0t
IHYyLjQuMC10ZXN0MTIvbGludXgvaW5jbHVkZS9hc20taTM4Ni9tbXVfY29u
dGV4dC5oCUZyaSBTZXAgIDggMTI6NTI6NDEgMjAwMA0KKysrIGxpbnV4L2lu
Y2x1ZGUvYXNtLWkzODYvbW11X2NvbnRleHQuaAlGcmkgRGVjIDE1IDE4OjI5
OjE5IDIwMDANCkBAIC02LDExICs2LDkgQEANCiAjaW5jbHVkZSA8YXNtL2F0
b21pYy5oPg0KICNpbmNsdWRlIDxhc20vcGdhbGxvYy5oPg0KIA0KLS8qDQot
ICogcG9zc2libHkgZG8gdGhlIExEVCB1bmxvYWQgaGVyZT8NCi0gKi8NCi0j
ZGVmaW5lIGRlc3Ryb3lfY29udGV4dChtbSkJCWRvIHsgfSB3aGlsZSgwKQ0K
LSNkZWZpbmUgaW5pdF9uZXdfY29udGV4dCh0c2ssbW0pCTANCisvKiBTZWdt
ZW50IGluZm9ybWF0aW9uICovDQorZXh0ZXJuIHZvaWQgZGVzdHJveV9jb250
ZXh0KHN0cnVjdCBtbV9zdHJ1Y3QgKik7DQorZXh0ZXJuIGludCBpbml0X25l
d19jb250ZXh0KHN0cnVjdCB0YXNrX3N0cnVjdCAqLCBzdHJ1Y3QgbW1fc3Ry
dWN0ICopOw0KIA0KICNpZmRlZiBDT05GSUdfU01QDQogDQpAQCAtMzMsNyAr
MzEsNyBAQA0KIAkJLyoNCiAJCSAqIFJlLWxvYWQgTERUIGlmIG5lY2Vzc2Fy
eQ0KIAkJICovDQotCQlpZiAocHJldi0+c2VnbWVudHMgIT0gbmV4dC0+c2Vn
bWVudHMpDQorCQlpZiAocHJldi0+Y29udGV4dC5zZWdtZW50cyAhPSBuZXh0
LT5jb250ZXh0LnNlZ21lbnRzKQ0KIAkJCWxvYWRfTERUKG5leHQpOw0KICNp
ZmRlZiBDT05GSUdfU01QDQogCQljcHVfdGxic3RhdGVbY3B1XS5zdGF0ZSA9
IFRMQlNUQVRFX09LOw0KZGlmZiAtdSAtLXJlY3Vyc2l2ZSAtLW5ldy1maWxl
IHYyLjQuMC10ZXN0MTIvbGludXgvaW5jbHVkZS9hc20taTM4Ni9wcm9jZXNz
b3IuaCBsaW51eC9pbmNsdWRlL2FzbS1pMzg2L3Byb2Nlc3Nvci5oDQotLS0g
djIuNC4wLXRlc3QxMi9saW51eC9pbmNsdWRlL2FzbS1pMzg2L3Byb2Nlc3Nv
ci5oCU1vbiBEZWMgMTEgMTc6NTk6NDUgMjAwMA0KKysrIGxpbnV4L2luY2x1
ZGUvYXNtLWkzODYvcHJvY2Vzc29yLmgJRnJpIERlYyAxNSAxODoyOToxOCAy
MDAwDQpAQCAtNDI3LDExICs0MjcsNiBAQA0KICAqLw0KIGV4dGVybiBpbnQg
a2VybmVsX3RocmVhZChpbnQgKCpmbikodm9pZCAqKSwgdm9pZCAqIGFyZywg
dW5zaWduZWQgbG9uZyBmbGFncyk7DQogDQotLyogQ29weSBhbmQgcmVsZWFz
ZSBhbGwgc2VnbWVudCBpbmZvIGFzc29jaWF0ZWQgd2l0aCBhIFZNICovDQot
ZXh0ZXJuIHZvaWQgY29weV9zZWdtZW50cyhzdHJ1Y3QgdGFza19zdHJ1Y3Qg
KnAsIHN0cnVjdCBtbV9zdHJ1Y3QgKiBtbSk7DQotZXh0ZXJuIHZvaWQgcmVs
ZWFzZV9zZWdtZW50cyhzdHJ1Y3QgbW1fc3RydWN0ICogbW0pOw0KLWV4dGVy
biB2b2lkIGZvcmdldF9zZWdtZW50cyh2b2lkKTsNCi0NCiAvKg0KICAqIFJl
dHVybiBzYXZlZCBQQyBvZiBhIGJsb2NrZWQgdGhyZWFkLg0KICAqLw0KZGlm
ZiAtdSAtLXJlY3Vyc2l2ZSAtLW5ldy1maWxlIHYyLjQuMC10ZXN0MTIvbGlu
dXgvaW5jbHVkZS9saW51eC9zY2hlZC5oIGxpbnV4L2luY2x1ZGUvbGludXgv
c2NoZWQuaA0KLS0tIHYyLjQuMC10ZXN0MTIvbGludXgvaW5jbHVkZS9saW51
eC9zY2hlZC5oCU1vbiBEZWMgMTEgMTc6NTk6NDUgMjAwMA0KKysrIGxpbnV4
L2luY2x1ZGUvbGludXgvc2NoZWQuaAlGcmkgRGVjIDE1IDE4OjI5OjE5IDIw
MDANCkBAIC0xOCw2ICsxOCw3IEBADQogI2luY2x1ZGUgPGFzbS9zZW1hcGhv
cmUuaD4NCiAjaW5jbHVkZSA8YXNtL3BhZ2UuaD4NCiAjaW5jbHVkZSA8YXNt
L3B0cmFjZS5oPg0KKyNpbmNsdWRlIDxhc20vbW11Lmg+DQogDQogI2luY2x1
ZGUgPGxpbnV4L3NtcC5oPg0KICNpbmNsdWRlIDxsaW51eC90dHkuaD4NCkBA
IC0yMDgsNyArMjA5LDYgQEANCiAJaW50IG1hcF9jb3VudDsJCQkJLyogbnVt
YmVyIG9mIFZNQXMgKi8NCiAJc3RydWN0IHNlbWFwaG9yZSBtbWFwX3NlbTsN
CiAJc3BpbmxvY2tfdCBwYWdlX3RhYmxlX2xvY2s7DQotCXVuc2lnbmVkIGxv
bmcgY29udGV4dDsNCiAJdW5zaWduZWQgbG9uZyBzdGFydF9jb2RlLCBlbmRf
Y29kZSwgc3RhcnRfZGF0YSwgZW5kX2RhdGE7DQogCXVuc2lnbmVkIGxvbmcg
c3RhcnRfYnJrLCBicmssIHN0YXJ0X3N0YWNrOw0KIAl1bnNpZ25lZCBsb25n
IGFyZ19zdGFydCwgYXJnX2VuZCwgZW52X3N0YXJ0LCBlbnZfZW5kOw0KQEAg
LTIxNywxMSArMjE3LDkgQEANCiAJdW5zaWduZWQgbG9uZyBjcHVfdm1fbWFz
azsNCiAJdW5zaWduZWQgbG9uZyBzd2FwX2NudDsJLyogbnVtYmVyIG9mIHBh
Z2VzIHRvIHN3YXAgb24gbmV4dCBwYXNzICovDQogCXVuc2lnbmVkIGxvbmcg
c3dhcF9hZGRyZXNzOw0KLQkvKg0KLQkgKiBUaGlzIGlzIGFuIGFyY2hpdGVj
dHVyZS1zcGVjaWZpYyBwb2ludGVyOiB0aGUgcG9ydGFibGUNCi0JICogcGFy
dCBvZiBMaW51eCBkb2VzIG5vdCBrbm93IGFib3V0IGFueSBzZWdtZW50cy4N
Ci0JICovDQotCXZvaWQgKiBzZWdtZW50czsNCisNCisJLyogQXJjaGl0ZWN0
dXJlLXNwZWNpZmljIE1NIGNvbnRleHQgKi8NCisJbW1fY29udGV4dF90IGNv
bnRleHQ7DQogfTsNCiANCiAjZGVmaW5lIElOSVRfTU0obmFtZSkgXA0KQEAg
LTIzNSw3ICsyMzMsNiBAQA0KIAltYXBfY291bnQ6CTEsIAkJCQlcDQogCW1t
YXBfc2VtOglfX01VVEVYX0lOSVRJQUxJWkVSKG5hbWUubW1hcF9zZW0pLCBc
DQogCXBhZ2VfdGFibGVfbG9jazogU1BJTl9MT0NLX1VOTE9DS0VELCAJCVwN
Ci0Jc2VnbWVudHM6CU5VTEwgCQkJCVwNCiB9DQogDQogc3RydWN0IHNpZ25h
bF9zdHJ1Y3Qgew0KZGlmZiAtdSAtLXJlY3Vyc2l2ZSAtLW5ldy1maWxlIHYy
LjQuMC10ZXN0MTIvbGludXgva2VybmVsL2ZvcmsuYyBsaW51eC9rZXJuZWwv
Zm9yay5jDQotLS0gdjIuNC4wLXRlc3QxMi9saW51eC9rZXJuZWwvZm9yay5j
CU1vbiBEZWMgMTEgMTc6NTk6NDUgMjAwMA0KKysrIGxpbnV4L2tlcm5lbC9m
b3JrLmMJRnJpIERlYyAxNSAxMjo0NTo1OCAyMDAwDQpAQCAtMTMzLDExICsx
MzMsOSBAQA0KIAltbS0+bW1hcF9hdmwgPSBOVUxMOw0KIAltbS0+bW1hcF9j
YWNoZSA9IE5VTEw7DQogCW1tLT5tYXBfY291bnQgPSAwOw0KLQltbS0+Y29u
dGV4dCA9IDA7DQogCW1tLT5jcHVfdm1fbWFzayA9IDA7DQogCW1tLT5zd2Fw
X2NudCA9IDA7DQogCW1tLT5zd2FwX2FkZHJlc3MgPSAwOw0KLQltbS0+c2Vn
bWVudHMgPSBOVUxMOw0KIAlwcHJldiA9ICZtbS0+bW1hcDsNCiAJZm9yICht
cG50ID0gY3VycmVudC0+bW0tPm1tYXAgOyBtcG50IDsgbXBudCA9IG1wbnQt
PnZtX25leHQpIHsNCiAJCXN0cnVjdCBmaWxlICpmaWxlOw0KQEAgLTMxOSwx
MSArMzE3LDYgQEANCiAJdXAoJmN1cnJlbnQtPm1tLT5tbWFwX3NlbSk7DQog
CWlmIChyZXR2YWwpDQogCQlnb3RvIGZyZWVfcHQ7DQotDQotCS8qDQotCSAq
IGNoaWxkIGdldHMgYSBwcml2YXRlIExEVCAoaWYgdGhlcmUgd2FzIGFuIExE
VCBpbiB0aGUgcGFyZW50KQ0KLQkgKi8NCi0JY29weV9zZWdtZW50cyh0c2ss
IG1tKTsNCiANCiAJaWYgKGluaXRfbmV3X2NvbnRleHQodHNrLG1tKSkNCiAJ
CWdvdG8gZnJlZV9wdDsNCmRpZmYgLXUgLS1yZWN1cnNpdmUgLS1uZXctZmls
ZSB2Mi40LjAtdGVzdDEyL2xpbnV4L21tL21tYXAuYyBsaW51eC9tbS9tbWFw
LmMNCi0tLSB2Mi40LjAtdGVzdDEyL2xpbnV4L21tL21tYXAuYwlNb24gRGVj
IDExIDE3OjU5OjQ1IDIwMDANCisrKyBsaW51eC9tbS9tbWFwLmMJRnJpIERl
YyAxNSAxMjo1Nzo1NCAyMDAwDQpAQCAtODg1LDcgKzg4NSw2IEBADQogew0K
IAlzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKiBtcG50Ow0KIA0KLQlyZWxlYXNl
X3NlZ21lbnRzKG1tKTsNCiAJc3Bpbl9sb2NrKCZtbS0+cGFnZV90YWJsZV9s
b2NrKTsNCiAJbXBudCA9IG1tLT5tbWFwOw0KIAltbS0+bW1hcCA9IG1tLT5t
bWFwX2F2bCA9IG1tLT5tbWFwX2NhY2hlID0gTlVMTDsNCg==
--1943079249-703973798-978145729=:11714--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
