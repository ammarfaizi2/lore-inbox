Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261385AbREZWuO>; Sat, 26 May 2001 18:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261458AbREZWuE>; Sat, 26 May 2001 18:50:04 -0400
Received: from chiara.elte.hu ([157.181.150.200]:4360 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S261385AbREZWt6>;
	Sat, 26 May 2001 18:49:58 -0400
Date: Sat, 26 May 2001 19:59:28 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "David S. Miller" <davem@redhat.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: [patch] severe softirq handling performance bug, fix, 2.4.5
Message-ID: <Pine.LNX.4.33.0105261920030.3336-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1508077854-990899968=:3336"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1508077854-990899968=:3336
Content-Type: TEXT/PLAIN; charset=US-ASCII


i've been seeing really bad average TCP latencies on certain gigabit cards
(~300-400 microseconds instead of the expected 100-200 microseconds), ever
since softnet went into the main kernel, and never found a real
explanation for it, until today.

the problem always went away when i tried to use tcpdump or strace, so the
bug remained hidden and was hard to prove that it actually existed. (apart
from the bad lat_tcp numbers.) We found many related bugs, but this
problem remained. tcpdumps done on the network did not show any fault of
the TCP stack. The lat_tcp latencies fluctuated alot, but for certain
cards the latencies were stable, so i suspected some sort of hw problem.
The loopback networking device never showed these problems, which added to
the mystery.

the problem turned out to be a severe softirq handling bug in the x86
code.

background: soft interrupts were introduced as a generic kernel framework
around January 2000, as part of the softnet networking-rewrite, that
predated the final scalability rewrite of the Linux TCP/IP networking
code. Soft interrupts have unique semantics, they can be best described as
'IRQ-triggered atomic system calls'. (unlike bottom halves, soft-IRQs do
not preempt kernel code.)

soft-IRQs, like their name suggest, are used from device interrupts ('hard
interrupts') to trigger 'background' work related to interrupts. Soft-IRQs
are triggered per-CPU, and they are supposed to execute whenever nothing
else is done by the kernel on that particular CPU. Softirqs are executed
with interrupts enabled, so hard interrupts can re-enable them while they
are executing. do_softirq() is a kernel function that returns with IRQs
disabled and at this point it's guaranteed that there are no more pending
softirqs for this CPU.

this mechanizm was the intention, but not the reality. In two important
and frequently used code paths it was possible for an active soft-IRQ to
"go unnoticed": i measured as long as 140 milliseconds (!!!) latency
between softirq activation and softirq execution in certain cases. This is
obviously bad behavior.

the two error cases are:

 #1 hard-IRQ interrupts user-space code, activates softirq, and returns to
    user-space code

 #2 hard-IRQ interrupts the idle task, activates softirq and returns to
    the idle task.

category #1 is easy to fix, in entry.S we have to check active softirqs
not only the exception and ret-from-syscall cases, but also in the
IRQ-ret-to-userspace case.

category #2 is subtle, because the idle process is kernel code, so
returning to it we do not execute active softirqs. The main two types of
idle handlers both had a window do 'miss' softirq execution:

- the HLT-based default handler could be called after schedule()'s check
  for softirqs, but after enabling IRQs. In this case an interrupt handler
  has a window to activate a softirq and neither the IRQ return code, nor
  the idle loop would execute it immediately. The fix is to do a softirq
  check right before the safe_halt call.

- the idle-poll handler does not check for softirqs either, it now does
  this in every iteration.

with the attached softirq-2.4.5-A0 patch applied to vanilla 2.4.5, i see
picture-perfect lat_tcp latencies of 109 microseconds over real gigabit
network. I see very stable (and very good) TUX latencies as well. TCP
bandwidth got better as well, probably due to the caching-locality bonus
when executing softirqs right after hardirqs.

[I'd like to ask everyone who had TCP latency problems (or other
networking performance problems) to test 2.4.5 with this patch applied -
thanks!]

impact of the bug: all softirq-using code is affected, mostly networking.
The loopback net driver was not affected because it's not interrupt-based.
The bug went away due to strace or tcpdump because those two utilities
pumped system-calls into the system which 'fixed' the softirq handling
bug.

(other softirq-based code is the tasklet code, and the keyboard code is
using tasklets, so the keyboard code might be affected as well.)

	Ingo

--8323328-1508077854-990899968=:3336
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="softirq-2.4.5-A0"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0105261959280.3336@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="softirq-2.4.5-A0"

LS0tIGxpbnV4L2FyY2gvaTM4Ni9rZXJuZWwvZW50cnkuUy5vcmlnCVNhdCBN
YXkgMjYgMTk6MjA6NDggMjAwMQ0KKysrIGxpbnV4L2FyY2gvaTM4Ni9rZXJu
ZWwvZW50cnkuUwlTYXQgTWF5IDI2IDE5OjIxOjUyIDIwMDENCkBAIC0yMTQs
NyArMjE0LDYgQEANCiAjZW5kaWYNCiAJam5lICAgaGFuZGxlX3NvZnRpcnEN
CiAJDQotcmV0X3dpdGhfcmVzY2hlZHVsZToNCiAJY21wbCAkMCxuZWVkX3Jl
c2NoZWQoJWVieCkNCiAJam5lIHJlc2NoZWR1bGUNCiAJY21wbCAkMCxzaWdw
ZW5kaW5nKCVlYngpDQpAQCAtMjc1LDcgKzI3NCw3IEBADQogCW1vdmwgRUZM
QUdTKCVlc3ApLCVlYXgJCSMgbWl4IEVGTEFHUyBhbmQgQ1MNCiAJbW92YiBD
UyglZXNwKSwlYWwNCiAJdGVzdGwgJChWTV9NQVNLIHwgMyksJWVheAkjIHJl
dHVybiB0byBWTTg2IG1vZGUgb3Igbm9uLXN1cGVydmlzb3I/DQotCWpuZSBy
ZXRfd2l0aF9yZXNjaGVkdWxlDQorCWpuZSByZXRfZnJvbV9zeXNfY2FsbA0K
IAlqbXAgcmVzdG9yZV9hbGwNCiANCiAJQUxJR04NCi0tLSBsaW51eC9hcmNo
L2kzODYva2VybmVsL3Byb2Nlc3MuYy5vcmlnCVNhdCBNYXkgMjYgMTk6MjE6
NTYgMjAwMQ0KKysrIGxpbnV4L2FyY2gvaTM4Ni9rZXJuZWwvcHJvY2Vzcy5j
CVNhdCBNYXkgMjYgMTk6Mjg6MDYgMjAwMQ0KQEAgLTc5LDggKzc5LDEyIEBA
DQogICovDQogc3RhdGljIHZvaWQgZGVmYXVsdF9pZGxlKHZvaWQpDQogew0K
KwlpbnQgdGhpc19jcHUgPSBzbXBfcHJvY2Vzc29yX2lkKCk7DQorDQogCWlm
IChjdXJyZW50X2NwdV9kYXRhLmhsdF93b3Jrc19vayAmJiAhaGx0X2NvdW50
ZXIpIHsNCiAJCV9fY2xpKCk7DQorCQlpZiAoc29mdGlycV9hY3RpdmUodGhp
c19jcHUpICYgc29mdGlycV9tYXNrKHRoaXNfY3B1KSkNCisJCQlkb19zb2Z0
aXJxKCk7DQogCQlpZiAoIWN1cnJlbnQtPm5lZWRfcmVzY2hlZCkNCiAJCQlz
YWZlX2hhbHQoKTsNCiAJCWVsc2UNCkBAIC05NSw2ICs5OSw3IEBADQogICov
DQogc3RhdGljIHZvaWQgcG9sbF9pZGxlICh2b2lkKQ0KIHsNCisJaW50IHRo
aXNfY3B1ID0gc21wX3Byb2Nlc3Nvcl9pZCgpOw0KIAlpbnQgb2xkdmFsOw0K
IA0KIAlfX3N0aSgpOw0KQEAgLTEwNCwxNCArMTA5LDE3IEBADQogCSAqIHJ1
biBoZXJlOg0KIAkgKi8NCiAJb2xkdmFsID0geGNoZygmY3VycmVudC0+bmVl
ZF9yZXNjaGVkLCAtMSk7DQorCWlmIChvbGR2YWwpDQorCQlyZXR1cm47DQog
DQotCWlmICghb2xkdmFsKQ0KLQkJYXNtIHZvbGF0aWxlKA0KLQkJCSIyOiIN
Ci0JCQkiY21wbCAkLTEsICUwOyINCi0JCQkicmVwOyBub3A7Ig0KLQkJCSJq
ZSAyYjsiDQotCQkJCTogOiJtIiAoY3VycmVudC0+bmVlZF9yZXNjaGVkKSk7
DQorCXdoaWxlIChjdXJyZW50LT5uZWVkX3Jlc2NoZWQgPT0gLTEpIHsNCisJ
CWlmIChzb2Z0aXJxX2FjdGl2ZSh0aGlzX2NwdSkgJiBzb2Z0aXJxX21hc2so
dGhpc19jcHUpKSB7DQorCQkJX19jbGkoKTsNCisJCQlkb19zb2Z0aXJxKCk7
DQorCQkJX19zdGkoKTsNCisJCX0NCisJCWFzbSB2b2xhdGlsZSggInJlcDsg
bm9wOyIgKTsNCisJfQ0KIH0NCiANCiAvKg0K
--8323328-1508077854-990899968=:3336--
