Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279588AbRKHNcp>; Thu, 8 Nov 2001 08:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279599AbRKHNci>; Thu, 8 Nov 2001 08:32:38 -0500
Received: from posta2.elte.hu ([157.181.151.9]:29671 "HELO posta2.elte.hu")
	by vger.kernel.org with SMTP id <S279588AbRKHNcZ>;
	Thu, 8 Nov 2001 08:32:25 -0500
Date: Thu, 8 Nov 2001 15:30:11 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [patch] scheduler cache affinity improvement for 2.4 kernels
Message-ID: <Pine.LNX.4.33.0111081341400.8863-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-460208262-1005229811=:8863"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-460208262-1005229811=:8863
Content-Type: TEXT/PLAIN; charset=US-ASCII


i've attached a patch that fixes a long-time performance problem in the
Linux scheduler.

it's a fix for a UP and SMP scheduler problem Alan described to me
recently, the 'CPU intensive process scheduling' problem. The essence of
the problem: if there are multiple, CPU-intensive processes running,
intermixed with other scheduling activities such as interactive work or
network-intensive applications, then the Linux scheduler does a poor job
of affinizing processes to processor caches. Such scheduler workload is
common for a large percentage of important application workloads: database
server workloads, webserver workloads and math-intensive clustered jobs,
and other applications.

If there are CPU-intensive processes A B and C, and a scheduling-intensive
X task, then in the stock 2.4 kernels we end up scheduling in the
following way:

    A X A X A ... [timer tick]
    B X B X B ... [timer tick]
    C X C X C ... [timer tick]

ie. we switch between CPU-intensive (and possibly cache-intensive)
processes every timer tick. The timer tick can be 10 msec or shorter,
depending on the HZ value.

the intended length of the timeslice of such processes is supposed to be
dependent on their priority - for typical CPU-intensive processes it's 100
msecs. But in the above case, the effective timeslice of the
CPU/cache-intensive process is 10 msec or lower, causing potential cache
trashing if the working set of A, B and C are larger than the cache size
of the CPU but the invidivual process' workload fits into cache.
Repopulating a large processor cache can take many milliseconds (on a 2MB
on-die cache Xeon CPU it takes more than 10 msecs to repopulate a typical
cache), so the effect can be significant.

The correct behavior would be:

    A X A X A ... [10 timer ticks]
    B X B X B ... [10 timer ticks]
    C X C X C ... [10 timer ticks]

this is in fact what happens if the scheduling acitivity of process 'X'
does not happen.

solution: i've introduced a new current->timer_ticks field (which is not
in the scheduler 'hot cacheline', nor does it cause any scheduling
overhead), which counts the number of timer ticks registered by any
particular process. If the number of timer ticks reaches the number of
available timeslices then the timer interrupt marks the process for
reschedule, clears ->counter and ->timer_ticks. These 'timer ticks' have
to be correctly administered across fork() and exit(), and some places
that touch ->counter need to deal with timer_ticks too, but otherwise the
patch has low impact.

scheduling semantics impact: this causes CPU hogs to be more affine to the
CPU they were running on, and will 'batch' them more agressively - without
giving them more CPU time than under the stock scheduler. The change does
not impact interactive tasks since they grow their ->counter above that of
CPU hogs anyway. It might cause less 'interactivity' in CPU hogs - but
this is the intended effect.

performance impact: this field is never used in the scheduler hotpath.
It's only used by the low frequency timer interrupt, and by the
fork()/exit() path, which can take an extra variable without any visible
impact. Also some fringe cases that touch ->counter needed updating too:
the OOM code and RR RT tasks.

performance results: The cases i've tested appear to work just fine, and
the change has the cache-affinity effect we are looking for. I've measured
'make -j bzImage' execution times on an 8-way, 700 MHz, 2MB cache Xeon
box. (certainly not a box whose caches are easy to trash.) Here are 6
successive make -j execution times with and without the patch applied. (To
avoid pagecache layout and other effects, the box is running a modified
but functionally equivalent version of the patch which allows runtime
switching between the old and new scheduler behavior.)

stock scheduler:

  real    1m1.817s
  real    1m1.871s
  real    1m1.993s
  real    1m2.015s
  real    1m2.049s
  real    1m2.077s

with the patch applied:

  real    1m0.177s
  real    1m0.313s
  real    1m0.331s
  real    1m0.349s
  real    1m0.462s
  real    1m0.792s

ie. stock scheduler is doing it in 62.0 seconds, new scheduler is doing it
in 60.3 seconds, a ~3% improvement - not bad, considering that compilation
is exeucting 99% in user-space, and that there was no 'interactive'
activity during the compilation job.

- to further measure the effects of the patch i've changed HZ to 1024 on a
single-CPU, 700 MHz, 2MB cache Xeon box, which improved 'make -j' kernel
compilation times by 4%.

- Compiling just drivers/block/floppy.c (which is a cache-intensive
operation) in parallel, with a constant single-process Apache network load
in the background shows a 7% improvement.

This shows the results we expected: with smaller timeslices, the effect of
cache trashing shows up more visibly.

(NOTE: i used 'make -j' only to create a well-known workload that has a
high cache footprint. It's not to suggest that 'make -j' makes much sense
on a single-CPU box.)

(it would be nice if those people who suspect scalability problems in
their workloads, could further test/verify the effects this patch.)

the patch is against 2.4.15-pre1 and boots/works just fine on both UP and
SMP systems.

please apply,

	Ingo

--8323328-460208262-1005229811=:8863
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="sched-process-affinity-2.4.15-A3"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0111081530110.8863@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="sched-process-affinity-2.4.15-A3"

LS0tIGxpbnV4L2tlcm5lbC9zY2hlZC5jLm9yaWcJVGh1IE5vdiAgOCAxMTow
NjozMSAyMDAxDQorKysgbGludXgva2VybmVsL3NjaGVkLmMJVGh1IE5vdiAg
OCAxMTowNzoyMiAyMDAxDQpAQCAtNzAzLDYgKzcwMyw3IEBADQogbW92ZV9y
cl9sYXN0Og0KIAlpZiAoIXByZXYtPmNvdW50ZXIpIHsNCiAJCXByZXYtPmNv
dW50ZXIgPSBOSUNFX1RPX1RJQ0tTKHByZXYtPm5pY2UpOw0KKwkJcHJldi0+
dGltZXJfdGlja3MgPSAwOw0KIAkJbW92ZV9sYXN0X3J1bnF1ZXVlKHByZXYp
Ow0KIAl9DQogCWdvdG8gbW92ZV9ycl9iYWNrOw0KLS0tIGxpbnV4L2tlcm5l
bC90aW1lci5jLm9yaWcJVGh1IE5vdiAgOCAxMTowNjoyOSAyMDAxDQorKysg
bGludXgva2VybmVsL3RpbWVyLmMJVGh1IE5vdiAgOCAxMTowNzoyMiAyMDAx
DQpAQCAtNTgzLDggKzU4Myw5IEBADQogDQogCXVwZGF0ZV9vbmVfcHJvY2Vz
cyhwLCB1c2VyX3RpY2ssIHN5c3RlbSwgY3B1KTsNCiAJaWYgKHAtPnBpZCkg
ew0KLQkJaWYgKC0tcC0+Y291bnRlciA8PSAwKSB7DQorCQlpZiAoKytwLT50
aW1lcl90aWNrcyA+PSBwLT5jb3VudGVyKSB7DQogCQkJcC0+Y291bnRlciA9
IDA7DQorCQkJcC0+dGltZXJfdGlja3MgPSAwOw0KIAkJCXAtPm5lZWRfcmVz
Y2hlZCA9IDE7DQogCQl9DQogCQlpZiAocC0+bmljZSA+IDApDQotLS0gbGlu
dXgva2VybmVsL2ZvcmsuYy5vcmlnCVRodSBOb3YgIDggMTE6MDY6MjYgMjAw
MQ0KKysrIGxpbnV4L2tlcm5lbC9mb3JrLmMJVGh1IE5vdiAgOCAxMTowNzoy
MiAyMDAxDQpAQCAtNjgxLDExICs2ODEsMTcgQEANCiAJICogdG90YWwgYW1v
dW50IG9mIGR5bmFtaWMgcHJpb3JpdGllcyBpbiB0aGUgc3lzdGVtIGRvZXNu
dCBjaGFuZ2UsDQogCSAqIG1vcmUgc2NoZWR1bGluZyBmYWlybmVzcy4gVGhp
cyBpcyBvbmx5IGltcG9ydGFudCBpbiB0aGUgZmlyc3QNCiAJICogdGltZXNs
aWNlLCBvbiB0aGUgbG9uZyBydW4gdGhlIHNjaGVkdWxpbmcgYmVoYXZpb3Vy
IGlzIHVuY2hhbmdlZC4NCisJICoNCisJICogYWxzbyBzaGFyZSB0aGUgdGlt
ZXIgdGljayBjb3VudGVyLg0KIAkgKi8NCiAJcC0+Y291bnRlciA9IChjdXJy
ZW50LT5jb3VudGVyICsgMSkgPj4gMTsNCiAJY3VycmVudC0+Y291bnRlciA+
Pj0gMTsNCi0JaWYgKCFjdXJyZW50LT5jb3VudGVyKQ0KKwlwLT50aW1lcl90
aWNrcyA9IChjdXJyZW50LT50aW1lcl90aWNrcyArIDEpID4+IDE7DQorCWN1
cnJlbnQtPnRpbWVyX3RpY2tzID4+PSAxOw0KKwlpZiAoIWN1cnJlbnQtPmNv
dW50ZXIpIHsNCiAJCWN1cnJlbnQtPm5lZWRfcmVzY2hlZCA9IDE7DQorCQlj
dXJyZW50LT50aW1lcl90aWNrcyA9IDA7DQorCX0NCiANCiAJLyoNCiAJICog
T2ssIGFkZCBpdCB0byB0aGUgcnVuLXF1ZXVlcyBhbmQgbWFrZSBpdA0KLS0t
IGxpbnV4L2tlcm5lbC9leGl0LmMub3JpZwlUaHUgTm92ICA4IDExOjA2OjMx
IDIwMDENCisrKyBsaW51eC9rZXJuZWwvZXhpdC5jCVRodSBOb3YgIDggMTE6
MDc6MjIgMjAwMQ0KQEAgLTYwLDEwICs2MCwxOSBAQA0KIAkJICogKHRoaXMg
Y2Fubm90IGJlIHVzZWQgdG8gYXJ0aWZpY2lhbGx5ICdnZW5lcmF0ZScNCiAJ
CSAqIHRpbWVzbGljZXMsIGJlY2F1c2UgYW55IHRpbWVzbGljZSByZWNvdmVy
ZWQgaGVyZQ0KIAkJICogd2FzIGdpdmVuIGF3YXkgYnkgdGhlIHBhcmVudCBp
biB0aGUgZmlyc3QgcGxhY2UuKQ0KKwkJICoNCisJCSAqIEFsc28gcmV0cmll
dmUgdGltZXNsaWNlIHRpY2tzLg0KIAkJICovDQogCQljdXJyZW50LT5jb3Vu
dGVyICs9IHAtPmNvdW50ZXI7DQotCQlpZiAoY3VycmVudC0+Y291bnRlciA+
PSBNQVhfQ09VTlRFUikNCisJCWN1cnJlbnQtPnRpbWVyX3RpY2tzICs9IHAt
PnRpbWVyX3RpY2tzOw0KKwkJaWYgKGN1cnJlbnQtPmNvdW50ZXIgPj0gTUFY
X0NPVU5URVIpIHsNCiAJCQljdXJyZW50LT5jb3VudGVyID0gTUFYX0NPVU5U
RVI7DQorCQkJaWYgKGN1cnJlbnQtPnRpbWVyX3RpY2tzID49IGN1cnJlbnQt
PmNvdW50ZXIpIHsNCisJCQkJY3VycmVudC0+Y291bnRlciA9IDA7DQorCQkJ
CWN1cnJlbnQtPnRpbWVyX3RpY2tzID0gMDsNCisJCQkJY3VycmVudC0+bmVl
ZF9yZXNjaGVkID0gMTsNCisJCQl9DQorCQl9DQogCQlwLT5waWQgPSAwOw0K
IAkJZnJlZV90YXNrX3N0cnVjdChwKTsNCiAJfSBlbHNlIHsNCi0tLSBsaW51
eC9tbS9vb21fa2lsbC5jLm9yaWcJVGh1IE5vdiAgOCAxMTowNjozMyAyMDAx
DQorKysgbGludXgvbW0vb29tX2tpbGwuYwlUaHUgTm92ICA4IDExOjA3OjQ4
IDIwMDENCkBAIC0xNTAsNiArMTUwLDcgQEANCiAJICogZXhpdCgpIGFuZCBj
bGVhciBvdXQgaXRzIHJlc291cmNlcyBxdWlja2x5Li4uDQogCSAqLw0KIAlw
LT5jb3VudGVyID0gNSAqIEhaOw0KKwlwLT50aW1lcl90aWNrcyA9IDA7DQog
CXAtPmZsYWdzIHw9IFBGX01FTUFMTE9DIHwgUEZfTUVNRElFOw0KIA0KIAkv
KiBUaGlzIHByb2Nlc3MgaGFzIGhhcmR3YXJlIGFjY2VzcywgYmUgbW9yZSBj
YXJlZnVsLiAqLw0KLS0tIGxpbnV4L2luY2x1ZGUvbGludXgvc2NoZWQuaC5v
cmlnCVRodSBOb3YgIDggMTE6MDY6MzMgMjAwMQ0KKysrIGxpbnV4L2luY2x1
ZGUvbGludXgvc2NoZWQuaAlUaHUgTm92ICA4IDEyOjE3OjU0IDIwMDENCkBA
IC0zMTIsNiArMzEyLDcgQEANCiAJICovDQogCXN0cnVjdCBsaXN0X2hlYWQg
cnVuX2xpc3Q7DQogCXVuc2lnbmVkIGxvbmcgc2xlZXBfdGltZTsNCisJbG9u
ZyB0aW1lcl90aWNrczsNCiANCiAJc3RydWN0IHRhc2tfc3RydWN0ICpuZXh0
X3Rhc2ssICpwcmV2X3Rhc2s7DQogCXN0cnVjdCBtbV9zdHJ1Y3QgKmFjdGl2
ZV9tbTsNCi0tLSBsaW51eC9kcml2ZXJzL25ldC9zbGlwLmMub3JpZwlUaHUg
Tm92ICA4IDEyOjE4OjUyIDIwMDENCisrKyBsaW51eC9kcml2ZXJzL25ldC9z
bGlwLmMJVGh1IE5vdiAgOCAxMjoxOToxNiAyMDAxDQpAQCAtMTM5NSw2ICsx
Mzk1LDcgQEANCiAJCWRvIHsNCiAJCQlpZiAoYnVzeSkgew0KIAkJCQljdXJy
ZW50LT5jb3VudGVyID0gMDsNCisJCQkJY3VycmVudC0+dGltZXJfdGlja3Mg
PSAwOw0KIAkJCQlzY2hlZHVsZSgpOw0KIAkJCX0NCiANCg==
--8323328-460208262-1005229811=:8863--
