Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288283AbSATLyi>; Sun, 20 Jan 2002 06:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288325AbSATLyT>; Sun, 20 Jan 2002 06:54:19 -0500
Received: from mx2.elte.hu ([157.181.151.9]:50609 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288283AbSATLyR>;
	Sun, 20 Jan 2002 06:54:17 -0500
Date: Sun, 20 Jan 2002 14:51:41 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [sched] [patch] interactiveness-improvements-2.5.3-pre2-A0
Message-ID: <Pine.LNX.4.33.0201201438230.7972-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1042897886-1011534701=:7972"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1042897886-1011534701=:7972
Content-Type: TEXT/PLAIN; charset=US-ASCII


the attached patch cleans up and improves the interactiveness code in
2.5.3-pre2 further. It's the interactiveness code from -J2 that got good
interactiveness feedback.

the patch changes three aspects of interactiveness:

1) the bonus/penalty of SCHED_OTHER tasks has been reduced by 10%, from
   [-20 ... +20] to [ -18 ... +19 ]. The reason is two-fold:

        - protect nice -20 interactive tasks from default-nicelevel
          interactive tasks. This improves audio playback quality, making
          nice -20 a more protected priority domain.

        - protect default-nicelevel CPU hogs from nice +19 CPU hogs. This
          means that nice +19 SETI jobs will not distrupt the timeslices
          of normal kernel compilation jobs.

2) improve the definition of TASK_INTERACTIVE:

       - the bottom 25% of the priority range is for 'unconditionally
         interactive tasks'.

       - the top 25% of the priority range is for 'unconditionally CPU-hog
         tasks'

       - the middle 50% is for 'conditionally interactive' tasks.
         Interactivity depends on whether a task has 'won' at least 3
         priority levels due to being interactive, relative to its default
         priority level.

this change has the following effect: tasks with negative nice values it's
easier to be interactive, and harder to become rated as CPU hogs. For
tasks with positive nice values it's much harder to become rated as
interactive, and easy to be rated as CPU hogs. Tasks on the default
nice-level have none of the 'prejudice' ratings, it depends on its actual
bonus whether it's rated as interactive or not.

3) newly forked children lose 20% of their parent's priority and sleep
   average.

this change has a positive effect on starting xterms during high-load
situations. The process that starts the xterm is usually a heavily
interactive task. But the first xterm process often fork()s a second
process, which was penalized too heavily in the previous fork_wakeup code,
causing that process to get into the 'CPU-bound hell', causing massive
delays of xterm startups. This rule is a purely experimental value, but it
expresses the basic concept correctly as well: we want children to get
some of the benefits of their parents, but we also want them to not get
*all* of the benefits, and work to achieve their own bonuses.

	Ingo

--8323328-1042897886-1011534701=:7972
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="interactiveness-improvements-2.5.3-pre2-A0"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0201201451410.7972@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="interactiveness-improvements-2.5.3-pre2-A0"

LS0tIGxpbnV4L2tlcm5lbC9zY2hlZC5jLm9yaWcJU3VuIEphbiAyMCAxMToz
OTo0MSAyMDAyDQorKysgbGludXgva2VybmVsL3NjaGVkLmMJU3VuIEphbiAy
MCAxMTozOTo1NyAyMDAyDQpAQCAtOTUsMjEgKzk1LDI2IEBADQogfQ0KIA0K
IC8qDQotICogQSB0YXNrIGlzICdoZWF2aWx5IGludGVyYWN0aXZlJyBpZiBp
dCBoYXMgcmVhY2hlZCB0aGUNCi0gKiBib3R0b20gMjUlIG9mIHRoZSBTQ0hF
RF9PVEhFUiBwcmlvcml0eSByYW5nZSAtIGluIHRoaXMNCisgKiBBIHRhc2sg
aXMgJ2hlYXZpbHkgaW50ZXJhY3RpdmUnIGlmIGl0IGVpdGhlciBoYXMgcmVh
Y2hlZCB0aGUNCisgKiBib3R0b20gMjUlIG9mIHRoZSBTQ0hFRF9PVEhFUiBw
cmlvcml0eSByYW5nZSwgb3IgaWYgaXQgaXMgYmVsb3cNCisgKiBpdHMgZGVm
YXVsdCBwcmlvcml0eSBieSBhdCBsZWFzdCAzIHByaW9yaXR5IGxldmVscy4g
SW4gdGhpcw0KICAqIGNhc2Ugd2UgZmF2b3IgaXQgYnkgcmVpbnNlcnRpbmcg
aXQgb24gdGhlIGFjdGl2ZSBhcnJheSwNCiAgKiBldmVuIGFmdGVyIGl0IGV4
cGlyZWQgaXRzIGN1cnJlbnQgdGltZXNsaWNlLg0KICAqDQorICogQSB0YXNr
IGlzIGEgJ0NQVSBob2cnIGlmIGl0J3MgZWl0aGVyIGluIHRoZSB1cHBlciAy
NSUgb2YgdGhlDQorICogU0NIRURfT1RIRVIgcHJpb3JpdHkgcmFuZ2UsIG9y
IGlmJ3Mgbm90IGFuIGludGVyYWN0aXZlIHRhc2suDQorICoNCiAgKiBBIHRh
c2sgY2FuIGdldCBhIHByaW9yaXR5IGJvbnVzIGJ5IGJlaW5nICdzb21ld2hh
dA0KICAqIGludGVyYWN0aXZlJyAtIGFuZCBpdCB3aWxsIGdldCBhIHByaW9y
aXR5IHBlbmFsdHkgZm9yDQogICogYmVpbmcgYSBDUFUgaG9nLg0KICAqDQot
ICogQ1BVLWhvZyBwZW5hbHRpZXMgY2Fubm90IGdvIG1vcmUgdGhhbiA1IGFi
b3ZlIHRoZSBkZWZhdWx0DQotICogcHJpb3JpdHkgbGV2ZWwuIFByaW9yaXR5
IGJvbnVzIGNhbm5vdCBnbyBiZWxvdyB0aGUgbWluaW11bQ0KLSAqIHByaW9y
aXR5IGxldmVsLg0KICAqLw0KLSNkZWZpbmUgUFJJT19JTlRFUkFDVElWRSAo
TUFYX1JUX1BSSU8gKyBNQVhfVVNFUl9QUklPLzMpDQotI2RlZmluZSBUQVNL
X0lOVEVSQUNUSVZFKHApICgocCktPnByaW8gPD0gUFJJT19JTlRFUkFDVElW
RSkNCisjZGVmaW5lIFBSSU9fSU5URVJBQ1RJVkUJKE1BWF9SVF9QUklPICsg
TUFYX1VTRVJfUFJJTy80KQ0KKyNkZWZpbmUgUFJJT19DUFVfSE9HCQkoTUFY
X1JUX1BSSU8gKyBNQVhfVVNFUl9QUklPKjMvNCkNCisNCisjZGVmaW5lIFRB
U0tfSU5URVJBQ1RJVkUocCkgKCgocCktPnByaW8gPD0gUFJJT19JTlRFUkFD
VElWRSkgfHwJCVwNCisJKCgocCktPnByaW8gPCBQUklPX0NQVV9IT0cpICYm
CQkJCQlcDQorCQkoKHApLT5wcmlvIDw9IE5JQ0VfVE9fUFJJTygocCktPl9f
bmljZSktMykpKQ0KIA0KIHN0YXRpYyBpbmxpbmUgaW50IGVmZmVjdGl2ZV9w
cmlvKHRhc2tfdCAqcCkNCiB7DQpAQCAtMTE3LDkgKzEyMiwxOCBAQA0KIA0K
IAkvKg0KIAkgKiBIZXJlIHdlIHNjYWxlIHRoZSBhY3R1YWwgc2xlZXAgYXZl
cmFnZSBbMCAuLi4uIE1BWF9TTEVFUF9BVkddDQotCSAqIGludG8gdGhlIDIw
IC4uLiAtMjAgYm9udXMvcGVuYWx0eSByYW5nZS4NCisJICogaW50byB0aGUg
MTkgLi4uIC0xOCBib251cy9wZW5hbHR5IHJhbmdlLg0KKwkgKg0KKwkgKiBX
ZSB0YWtlIG9mZiB0aGUgMTAlIGZyb20gdGhlIGZ1bGwgMC4uLjM5IHByaW9y
aXR5IHJhbmdlIHNvIHRoYXQ6DQorCSAqDQorCSAqIDEpIG5pY2UgKzE5IENQ
VSBob2dzIGRvIG5vdCBwcmVlbXB0IG5pY2UgMCBDUFUgaG9ncyBqdXN0IHll
dC4NCisJICogMikgbmljZSAtMjAgaW50ZXJhY3RpdmUgdGFza3MgZG8gbm90
IGdldCBwcmVlbXB0ZWQgYnkNCisJICogICAgbmljZSAwIGludGVyYWN0aXZl
IHRhc2tzLg0KKwkgKg0KKwkgKiBCb3RoIHByb3BlcnRpZXMgYXJlIGltcG9y
dGFudCB0byBjZXJ0YWluIGFwcGxpY2F0aW9ucy4NCiAJICovDQotCWJvbnVz
ID0gTUFYX1VTRVJfUFJJTyAqIHAtPnNsZWVwX2F2ZyAvIE1BWF9TTEVFUF9B
VkcgLSBNQVhfVVNFUl9QUklPLzI7DQorCWJvbnVzID0gTUFYX1VTRVJfUFJJ
Tyo5LzEwICogcC0+c2xlZXBfYXZnIC8gTUFYX1NMRUVQX0FWRyAtDQorCQkJ
CQkJCU1BWF9VU0VSX1BSSU8qOS8xMC8yOw0KIAlwcmlvID0gTklDRV9UT19Q
UklPKHAtPl9fbmljZSkgLSBib251czsNCiAJaWYgKHByaW8gPCBNQVhfUlRf
UFJJTykNCiAJCXByaW8gPSBNQVhfUlRfUFJJTzsNCkBAIC0yNjEsOSArMjc1
LDggQEANCiANCiAJcC0+c3RhdGUgPSBUQVNLX1JVTk5JTkc7DQogCWlmICgh
cnRfdGFzayhwKSkgew0KLQkJcC0+cHJpbyArPSBNQVhfVVNFUl9QUklPLzEw
Ow0KLQkJaWYgKHAtPnByaW8gPiBNQVhfUFJJTy0xKQ0KLQkJCXAtPnByaW8g
PSBNQVhfUFJJTy0xOw0KKwkJcC0+c2xlZXBfYXZnID0gKHAtPnNsZWVwX2F2
ZyAqIDQpIC8gNTsNCisJCXAtPnByaW8gPSBlZmZlY3RpdmVfcHJpbyhwKTsN
CiAJfQ0KIAlzcGluX2xvY2tfaXJxKCZycS0+bG9jayk7DQogCWFjdGl2YXRl
X3Rhc2socCwgcnEpOw0K
--8323328-1042897886-1011534701=:7972--
