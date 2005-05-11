Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVEKSSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVEKSSX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 14:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVEKSSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 14:18:23 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:44971 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261255AbVEKSPL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 14:15:11 -0400
Date: Wed, 11 May 2005 20:14:49 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, dipankar@in.ibm.com
Subject: Re: [RFC] RCU and CONFIG_PREEMPT_RT progress
In-Reply-To: <20050510144531.GA1566@us.ibm.com>
Message-Id: <Pine.OSF.4.05.10505111837580.6202-200000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-851980082-1115835289=:6202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-851980082-1115835289=:6202
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 10 May 2005, Paul E. McKenney wrote:

> On Tue, May 10, 2005 at 12:55:31PM +0200, Esben Nielsen wrote:
> [...]
> > > 
> > > The current implementation in Ingo's CONFIG_PREEMPT_RT patch uses a
> > > counter-based approach, which seems to work, but which can result in
> > > indefinite-duration grace periods.
> >
> > Is that really a problem in practise? For RCU updates should happen
> > rarely.
> 
> Yes.  Several people have run into serious problems on small-memory
> machines under denial-of-service workloads.  Not pretty.
>
That is what I tell people at work: Dynamic memory allocation is _not_ a
good thing in real-time embedded systems. They call be old fashioned when
I say I want anything important pre-allocated in seperate pools. But it
exactly avoids these kind of surprises, makes the system more
deterministic and makes it easier to find leaks.
 
> [...]
> > 
> > Why bother? What is the overhead of checking relative to just doing the
> > increment/decrement?
> 
> The increment of the per-CPU counter pair is likely to incur a cache miss,
> and thus be orders of magnitude more expensive than the increment of
> the variable in the task structure.  I did not propose this optimization
> lightly.  ;-)
> 
> > I had another idea: Do it in the scheduler:
> >   per_cpu_rcu_count += prev->rcu_read_count;
> >   if(per_cpu_rcu_count==0) {
> >      /* grace period encountered */
> >   }
> >   (do the task switch)
> >   
> >   per_cpu_rcu_count -= count->rcu_read_count;
> > 
> > Then per_cpu_rcu_count is the rcu-read-count for all tasks except the
> > current. During schedule there is no current and therefore it is the total
> > count.
> 
> One downside of this approach is that it would maximally expand the
> RCU read-side critical sections -- one of the things we need is to
> avoid holding onto memory longer than necessary, as noted above.
> 
> Also, what prevents a grace period from ending while a task is
> preempted in an RCU read-side critical section?  Or are you intending
> that synchronize_rcu() scan the task list as well as the per-CPU
> counters?
Eh, if a RCU task is preempted in a read-side CS there IS no grace period!
The trick is to avoid having it haning there for too long (see my boosting
mechanismen below).
> 
> > > [...] 
> > > 2.	#1 above, but use a seqlock to guard the counter selection in
> > > 	rcu_read_lock().  One potential disadvantage of this approach
> > > 	is that an extremely unlucky instance of rcu_read_lock() might
> > > 	be indefinitely delayed by a series of counter flips.  I am
> > > 	concerned that this might actually happen under low-memory
> > > 	conditions.  Also requires memory barriers on the read side,
> > > 	which we might be stuck with, but still hope to be able to
> > > 	get rid of.  And the per-CPU counter manipulation must use
> > > 	atomic instructions.
> >
> > Why not just use 
> >  preempt_disable(); 
> >  manipulate counters; 
> >  preempt_enable();
> > ??
> 
> Because we can race with the counter switch, which can happen on some
> other CPU.  Therefore, preempt_disable() does not help with this race.

Well, the per-cpu counters should be truely per-cpu. I.e. all tasks must
_only_ touch the counter on their current cpu. preempt_disable() prevents
the migration of the current task, right?
 
> 
> > > 3.	#1 above, but use per-CPU locks to guard the counter selection.
> > > 	I don't like this any better than #2, worse, in fact, since it
> > > 	requires expensive atomic instructions as well.
> >
> > local_irqs_disable() andor preempt_disable() should work as they counters
> > are per-cpu, right?
> 
> Again, neither of these help with the race against the counter-switch,
> which would likely be happening on some other CPU.
As above :-)

> 
> > Or see the alternative above: The counter is per task but latched to a
> > per-cpu on schedule().
> 
> This could work (assuming that synchronize_rcu() scanned the task list
> as well as the per-CPU counters), but again would extend grace periods
> too long for small-memory machines subject to denial-of-service attacks.
> 
No, need to traverse the list. Again the syncronize_rcu() waits for all
CPU to check their number _locally_. The task doing that can simply check
it's the latched number as it knows it is not in a read-side CS.

> > [...] 
> > I was playing around with it a little while back. I didn't sned a patch
> > though as I didn't have time. It works on a UP machine but I don't have a
> > SMP to test on :-(
> 
> There are some available from OSDL, right?  Or am I out of date here?
Honestly, I can't remember if I mailed it to anyone. I only have the code
on my home PC, which broke down. I am right now running off a backup. I
have attached the patch to this mail. I don't have time to clean it up :-(
I see it also includes code for a testing device trying where I try 
to meassure the grace period.

> 
> > The ingreedients are:
> > 1) A per-cpu read-side counter, protected locally by preempt_disable().
> 
> In order to avoid too-long grace periods, you need a pair of counters.
> If you only have a single counter, you can end up with a series of
> RCU read-side critical-section preemptions resulting in the counter
> never reaching zero, and thus the grace period never terminating.
> Not good, especially in small-memory machines subject to denial-of-service
> attacks.
See the boosting trick below. That will do the trick.

> 
> > 2) A task read-side counter (doesn't need protectection at all).
> 
> Yep.  Also a field in the task struct indicating which per-CPU counter
> applies (unless the scheduler is managing this).
No, it is _always_ the local CPU which alplies as I have tried to make 3)
below (which isn't tested at all).
> 
> > 3) Tasks having non-zero read-side counter can't be migrated to other
> > CPUs. That is to make the per-cpu counter truely per-cpu.
> 
> If CPU hotplug can be disallowed, then this can work.  Do we really want
> to disallow CPU hotplug?  Especially given that some implementations
> might want to use CPU hotplug to reduce power consumption?  There also
> might be issues with tickless operation.
> 
Yeah, I noticed the hotplog code. What are the RT requirements for
hotplugging? With 4) below it shouldn't be a problem to wait until all
tasks ar out of the read-lock session.

A better alternative is to make migration work like this:
1) Deactive the task.
2) Make the target cpu increment it's rcu-counter.
3) Migrate the task.
4) Make the source cpu increment it's rcu-counter.
Then you can safely migrate tasks preempted in read-side CS as well.
Harder to code than my small hack, though.

> > 4) When the scheduler sees a SCHED_OTHER task with a rcu-read-counter>0 it
> > boost the priority to the maximum non-RT priority such it will not be 
> > preempted by other SCHED_OTHER tasks. This makes the  delay in
> > syncronize_kernel() somewhat deterministic (it depends on how
> > "deterministic" the RT tasks in the system are.)
> 
> But one would only want to do this boost if there was a synchronize_rcu()
> waiting -and- if there is some reason to accelerate grace periods (e.g.,
> low on memory), right?  If there is no reason to accelerate grace periods,
> then extending them increases efficiency by amortizing grace-period
> overhead over many updates.
Well, I only do the boost if the task is actually preempted in the
read-side CS - it should be relatively rare. I could make a check and
only do the boost if their is an request for a grace-period set. BUT the
problem is that when somebody requests a grace-period later on it would
have to traverse the runqueue and boost the tasks in read-side CS. That
sounds like more expensive, but one can only know that by testing....

> 
> > I'll try to send you what I got when I get my computer at home back up.
> > I have only testet id on my UP labtop, where it seems to run fine.
> 
> I look forward to seeing it!
> 
Attached here :-)
> 							Thanx, Paul
> 

Esben

--0-851980082-1115835289=:6202
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="rcu.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.OSF.4.05.10505112014490.6202@da410.phys.au.dk>
Content-Description: 
Content-Disposition: attachment; filename="rcu.patch"

ZGlmZiAtTmF1ciAtLWV4Y2x1ZGUtZnJvbT1kaWZmX2V4Y2x1ZGUgT3JpZy9s
aW51eC0yLjYuMTItcmMxL01ha2VmaWxlIGxpbnV4LTIuNi4xMi1yYzEtUkNV
L01ha2VmaWxlDQotLS0gT3JpZy9saW51eC0yLjYuMTItcmMxL01ha2VmaWxl
CVN1biBNYXIgMjAgMjA6MzA6NTUgMjAwNQ0KKysrIGxpbnV4LTIuNi4xMi1y
YzEtUkNVL01ha2VmaWxlCVN1biBNYXIgMjcgMjE6MDU6NTggMjAwNQ0KQEAg
LTEsNyArMSw3IEBADQogVkVSU0lPTiA9IDINCiBQQVRDSExFVkVMID0gNg0K
IFNVQkxFVkVMID0gMTINCi1FWFRSQVZFUlNJT04gPS1yYzENCitFWFRSQVZF
UlNJT04gPS1yYzEtUkNVLVNNUA0KIE5BTUU9V29venkgTnVtYmF0DQogDQog
IyAqRE9DVU1FTlRBVElPTioNCmRpZmYgLU5hdXIgLS1leGNsdWRlLWZyb209
ZGlmZl9leGNsdWRlIE9yaWcvbGludXgtMi42LjEyLXJjMS9kcml2ZXJzL2No
YXIvS2NvbmZpZyBsaW51eC0yLjYuMTItcmMxLVJDVS9kcml2ZXJzL2NoYXIv
S2NvbmZpZw0KLS0tIE9yaWcvbGludXgtMi42LjEyLXJjMS9kcml2ZXJzL2No
YXIvS2NvbmZpZwlTdW4gTWFyIDIwIDIwOjMxOjAzIDIwMDUNCisrKyBsaW51
eC0yLjYuMTItcmMxLVJDVS9kcml2ZXJzL2NoYXIvS2NvbmZpZwlGcmkgTWFy
IDI1IDAwOjE5OjA3IDIwMDUNCkBAIC05NzgsNiArOTc4LDEzIEBADQogCSAg
VGhlIG1tdGltZXIgZGV2aWNlIGFsbG93cyBkaXJlY3QgdXNlcnNwYWNlIGFj
Y2VzcyB0byB0aGUNCiAJICBBbHRpeCBzeXN0ZW0gdGltZXIuDQogDQorDQor
Y29uZmlnIFJDVV9URVNURVINCisJdHJpc3RhdGUgIlRlc3QgZGV2aWNlIGZv
ciB0ZXN0aW5nIFJDVSBjb2RlLiINCisJZGVmYXVsdCBuDQorCWhlbHANCisJ
ICBUbyBoZWxwIGRlYnVnZ2luZyB0aGUgUkNVIGNvZGUuIERvbid0IGluY2x1
ZGUgdGhpcy4NCisNCiBzb3VyY2UgImRyaXZlcnMvY2hhci90cG0vS2NvbmZp
ZyINCiANCiBlbmRtZW51DQpkaWZmIC1OYXVyIC0tZXhjbHVkZS1mcm9tPWRp
ZmZfZXhjbHVkZSBPcmlnL2xpbnV4LTIuNi4xMi1yYzEvZHJpdmVycy9jaGFy
L01ha2VmaWxlIGxpbnV4LTIuNi4xMi1yYzEtUkNVL2RyaXZlcnMvY2hhci9N
YWtlZmlsZQ0KLS0tIE9yaWcvbGludXgtMi42LjEyLXJjMS9kcml2ZXJzL2No
YXIvTWFrZWZpbGUJU3VuIE1hciAyMCAyMDozMTowMyAyMDA1DQorKysgbGlu
dXgtMi42LjEyLXJjMS1SQ1UvZHJpdmVycy9jaGFyL01ha2VmaWxlCUZyaSBN
YXIgMjUgMDA6MTk6MTEgMjAwNQ0KQEAgLTQ4LDYgKzQ4LDggQEANCiBvYmot
JChDT05GSUdfVklPVEFQRSkJCSs9IHZpb3RhcGUubw0KIG9iai0kKENPTkZJ
R19IVkNTKQkJKz0gaHZjcy5vDQogDQorb2JqLSQoQ09ORklHX1JDVV9URVNU
RVIpCSs9IHJjdV90ZXN0ZXIubw0KKw0KIG9iai0kKENPTkZJR19QUklOVEVS
KSArPSBscC5vDQogb2JqLSQoQ09ORklHX1RJUEFSKSArPSB0aXBhci5vDQog
DQpkaWZmIC1OYXVyIC0tZXhjbHVkZS1mcm9tPWRpZmZfZXhjbHVkZSBPcmln
L2xpbnV4LTIuNi4xMi1yYzEvZHJpdmVycy9jaGFyL3JjdV90ZXN0ZXIuYyBs
aW51eC0yLjYuMTItcmMxLVJDVS9kcml2ZXJzL2NoYXIvcmN1X3Rlc3Rlci5j
DQotLS0gT3JpZy9saW51eC0yLjYuMTItcmMxL2RyaXZlcnMvY2hhci9yY3Vf
dGVzdGVyLmMJVGh1IEphbiAgMSAwMTowMDowMCAxOTcwDQorKysgbGludXgt
Mi42LjEyLXJjMS1SQ1UvZHJpdmVycy9jaGFyL3JjdV90ZXN0ZXIuYwlXZWQg
TWFyIDMwIDAwOjE1OjUyIDIwMDUNCkBAIC0wLDAgKzEsMTIwIEBADQorLyoN
CisgKiB0ZXN0IGRldmljZSBmb3IgdGVzdGluZyBSQ1UgY29kZQ0KKyAqLw0K
Kw0KKyNpbmNsdWRlIDxsaW51eC9mcy5oPg0KKyNpbmNsdWRlIDxsaW51eC9t
aXNjZGV2aWNlLmg+DQorDQorI2RlZmluZSBSQ1VfVEVTVEVSX01JTk9SCSAy
MjINCisNCisjZGVmaW5lIFJDVV9URVNURVJfV1JJVEUJNDI0Nw0KKyNkZWZp
bmUgUkNVX1RFU1RFUl9SRUFEIAk0MjQ4DQorDQorI2RlZmluZSBFUkNVX0ZB
SUxFRCAgICAgICAgICAgICAgIDM1DQorDQorI2lmbmRlZiBub3RyYWNlDQor
I2RlZmluZSBub3RyYWNlDQorI2VuZGlmDQorDQordTY0IG5vdHJhY2UgZ2V0
X2NwdV90aWNrKHZvaWQpDQorew0KKwl1NjQgdHNjOw0KKyNpZmRlZiBBUkNI
QVJNDQorCXRzYyA9ICpvc2NyOw0KKyNlbHNlDQorCV9fYXNtX18gX192b2xh
dGlsZV9fKCJyZHRzYyIgOiAiPUEiICh0c2MpKTsNCisjZW5kaWYNCisJcmV0
dXJuIHRzYzsNCit9DQorDQordm9pZCBub3RyYWNlIGxvb3AoaW50IGxvb3Bz
KQ0KK3sNCisJaW50IGk7DQorDQorCWZvciAoaSA9IDA7IGkgPCBsb29wczsg
aSsrKQ0KKwkJZ2V0X2NwdV90aWNrKCk7DQorfQ0KKw0KK3N0YXRpYyBzcGlu
bG9ja190IHdyaXRlX2xvY2s7DQorc3RhdGljIGludCAqcHJvdGVjdGVkX2Rh
dGEgPSBOVUxMOw0KKw0KK3N0YXRpYyBpbnQgcmN1X3Rlc3Rlcl9vcGVuKHN0
cnVjdCBpbm9kZSAqaW4sIHN0cnVjdCBmaWxlICpmaWxlKQ0KK3sNCisJcmV0
dXJuIDA7DQorfQ0KKw0KK3N0YXRpYyBsb25nIHJjdV90ZXN0ZXJfaW9jdGwo
c3RydWN0IGZpbGUgKmZpbGUsDQorCQkJICB1bnNpZ25lZCBpbnQgY21kLCB1
bnNpZ25lZCBsb25nIGFyZ3MpDQorew0KKwlzd2l0Y2goY21kKSB7DQorCWNh
c2UgUkNVX1RFU1RFUl9SRUFEOiB7DQorCQlpbnQgKmRhdGFwdHIsIGRhdGEx
LGRhdGEyOw0KKwkJcmN1X3JlYWRfbG9jaygpOw0KKwkJZGF0YXB0ciA9IHBy
b3RlY3RlZF9kYXRhOw0KKwkJZGF0YTEgPSAqZGF0YXB0cjsNCisJCWxvb3Ao
YXJncyk7DQorCQlkYXRhMiA9ICpkYXRhcHRyOw0KKwkJcmN1X3JlYWRfdW5s
b2NrKCk7DQorCQlpZihkYXRhMSE9ZGF0YTIpDQorCQkJcmV0dXJuIC1FUkNV
X0ZBSUxFRDsNCisJCWVsc2UNCisJCQlyZXR1cm4gMDsgLyogb2sgKi8NCisJ
fQ0KKwljYXNlIFJDVV9URVNURVJfV1JJVEU6IHsNCisJCWludCAqbmV3ZGF0
YSwgKm9sZGRhdGE7DQorCQluZXdkYXRhID0ga21hbGxvYyhzaXplb2YoaW50
KSwgR0ZQX0tFUk5FTCk7DQorCQlpZighbmV3ZGF0YSkNCisJCQlyZXR1cm4g
LUVOT01FTTsNCisNCisJCXNwaW5fbG9jaygmd3JpdGVfbG9jayk7DQorCQlv
bGRkYXRhID0gcmN1X2RlcmVmZXJlbmNlKHByb3RlY3RlZF9kYXRhKTsNCisJ
CSpuZXdkYXRhID0gKm9sZGRhdGEgKyAxOw0KKwkJcmN1X2Fzc2lnbl9wb2lu
dGVyKHByb3RlY3RlZF9kYXRhLCBuZXdkYXRhKTsNCisJCXNwaW5fdW5sb2Nr
KCZ3cml0ZV9sb2NrKTsNCisJCXN5bmNocm9uaXplX2tlcm5lbCgpOw0KKwkJ
a2ZyZWUob2xkZGF0YSk7DQorCQlyZXR1cm4gMDsNCisJfQ0KKwlkZWZhdWx0
Og0KKwkJcmV0dXJuIC1FSU5WQUw7DQorCX0NCit9DQorDQorc3RhdGljIHN0
cnVjdCBmaWxlX29wZXJhdGlvbnMgcmN1X3Rlc3Rlcl9mb3BzID0gew0KKwku
b3duZXIJCT0gVEhJU19NT0RVTEUsDQorCS5sbHNlZWsJCT0gbm9fbGxzZWVr
LA0KKwkudW5sb2NrZWRfaW9jdGwgPSByY3VfdGVzdGVyX2lvY3RsLA0KKwku
b3BlbgkJPSByY3VfdGVzdGVyX29wZW4sDQorfTsNCisNCitzdGF0aWMgc3Ry
dWN0IG1pc2NkZXZpY2UgcmN1X3Rlc3Rlcl9kZXYgPQ0KK3sNCisJUkNVX1RF
U1RFUl9NSU5PUiwNCisJInJjdV90ZXN0ZXIiLA0KKwkmcmN1X3Rlc3Rlcl9m
b3BzDQorfTsNCisNCitzdGF0aWMgaW50IF9faW5pdCByY3VfdGVzdGVyX2lu
aXQodm9pZCkNCit7DQorCWlmIChtaXNjX3JlZ2lzdGVyKCZyY3VfdGVzdGVy
X2RldikpDQorCQlyZXR1cm4gLUVOT0RFVjsNCisNCisJcHJvdGVjdGVkX2Rh
dGEgPSBrbWFsbG9jKHNpemVvZihpbnQpLCBHRlBfS0VSTkVMKTsNCisJKnBy
b3RlY3RlZF9kYXRhID0gMDsNCisJDQorCXNwaW5fbG9ja19pbml0KCZ3cml0
ZV9sb2NrKTsNCisNCisJcmV0dXJuIDA7DQorfQ0KKw0KK3ZvaWQgX19leGl0
IHJjdV90ZXN0ZXJfZXhpdCh2b2lkKQ0KK3sNCisJcHJpbnRrKEtFUk5fSU5G
TyAicmN1LXRlc3RlciBkZXZpY2UgdW5pbnN0YWxsZWRcbiIpOw0KKwltaXNj
X2RlcmVnaXN0ZXIoJnJjdV90ZXN0ZXJfZGV2KTsNCit9DQorDQorbW9kdWxl
X2luaXQocmN1X3Rlc3Rlcl9pbml0KTsNCittb2R1bGVfZXhpdChyY3VfdGVz
dGVyX2V4aXQpOw0KKw0KK01PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCisNCmRp
ZmYgLU5hdXIgLS1leGNsdWRlLWZyb209ZGlmZl9leGNsdWRlIE9yaWcvbGlu
dXgtMi42LjEyLXJjMS9pbmNsdWRlL2xpbnV4L2luaXRfdGFzay5oIGxpbnV4
LTIuNi4xMi1yYzEtUkNVL2luY2x1ZGUvbGludXgvaW5pdF90YXNrLmgNCi0t
LSBPcmlnL2xpbnV4LTIuNi4xMi1yYzEvaW5jbHVkZS9saW51eC9pbml0X3Rh
c2suaAlTdW4gTWFyIDIwIDIwOjMxOjI4IDIwMDUNCisrKyBsaW51eC0yLjYu
MTItcmMxLVJDVS9pbmNsdWRlL2xpbnV4L2luaXRfdGFzay5oCUZyaSBNYXIg
MjUgMDA6MjI6MDAgMjAwNQ0KQEAgLTc0LDYgKzc0LDcgQEANCiAJLnVzYWdl
CQk9IEFUT01JQ19JTklUKDIpLAkJCQlcDQogCS5mbGFncwkJPSAwLAkJCQkJ
CVwNCiAJLmxvY2tfZGVwdGgJPSAtMSwJCQkJCQlcDQorCS5yY3VfcmVhZF9s
b2NrX25lc3RpbmcgPSAwLAkJCQkgICAgICAgCVwNCiAJLnByaW8JCT0gTUFY
X1BSSU8tMjAsCQkJCQlcDQogCS5zdGF0aWNfcHJpbwk9IE1BWF9QUklPLTIw
LAkJCQkJXA0KIAkucG9saWN5CQk9IFNDSEVEX05PUk1BTCwJCQkJCVwNCmRp
ZmYgLU5hdXIgLS1leGNsdWRlLWZyb209ZGlmZl9leGNsdWRlIE9yaWcvbGlu
dXgtMi42LjEyLXJjMS9pbmNsdWRlL2xpbnV4L3JjdXBkYXRlLmggbGludXgt
Mi42LjEyLXJjMS1SQ1UvaW5jbHVkZS9saW51eC9yY3VwZGF0ZS5oDQotLS0g
T3JpZy9saW51eC0yLjYuMTItcmMxL2luY2x1ZGUvbGludXgvcmN1cGRhdGUu
aAlXZWQgTWFyICAyIDA4OjM3OjUwIDIwMDUNCisrKyBsaW51eC0yLjYuMTIt
cmMxLVJDVS9pbmNsdWRlL2xpbnV4L3JjdXBkYXRlLmgJU3VuIE1hciAyNyAx
ODoxMjo0NSAyMDA1DQpAQCAtNDEsNiArNDEsOCBAQA0KICNpbmNsdWRlIDxs
aW51eC9wZXJjcHUuaD4NCiAjaW5jbHVkZSA8bGludXgvY3B1bWFzay5oPg0K
ICNpbmNsdWRlIDxsaW51eC9zZXFsb2NrLmg+DQorI2luY2x1ZGUgPGxpbnV4
L3NjaGVkLmg+DQorI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPg0KIA0K
IC8qKg0KICAqIHN0cnVjdCByY3VfaGVhZCAtIGNhbGxiYWNrIHN0cnVjdHVy
ZSBmb3IgdXNlIHdpdGggUkNVDQpAQCAtODUsNiArODcsNyBAQA0KICAqIGN1
cmxpc3QgLSBjdXJyZW50IGJhdGNoIGZvciB3aGljaCBxdWllc2NlbnQgY3lj
bGUgc3RhcnRlZCBpZiBhbnkNCiAgKi8NCiBzdHJ1Y3QgcmN1X2RhdGEgew0K
KwlpbnQgICAgICAgICAgICAgYWN0aXZlX3JlYWRlcnM7DQogCS8qIDEpIHF1
aWVzY2VudCBzdGF0ZSBoYW5kbGluZyA6ICovDQogCWxvbmcJCXF1aWVzY2Jh
dGNoOyAgICAgLyogQmF0Y2ggIyBmb3IgZ3JhY2UgcGVyaW9kICovDQogCWlu
dAkJcGFzc2VkX3F1aWVzYzsJIC8qIFVzZXItbW9kZS9pZGxlIGxvb3AgZXRj
LiAqLw0KQEAgLTExNSwxMiArMTE4LDE0IEBADQogc3RhdGljIGlubGluZSB2
b2lkIHJjdV9xc2N0cl9pbmMoaW50IGNwdSkNCiB7DQogCXN0cnVjdCByY3Vf
ZGF0YSAqcmRwID0gJnBlcl9jcHUocmN1X2RhdGEsIGNwdSk7DQotCXJkcC0+
cGFzc2VkX3F1aWVzYyA9IDE7DQorCWlmKHJkcC0+YWN0aXZlX3JlYWRlcnM9
PTApDQorCQlyZHAtPnBhc3NlZF9xdWllc2MgPSAxOw0KIH0NCiBzdGF0aWMg
aW5saW5lIHZvaWQgcmN1X2JoX3FzY3RyX2luYyhpbnQgY3B1KQ0KIHsNCiAJ
c3RydWN0IHJjdV9kYXRhICpyZHAgPSAmcGVyX2NwdShyY3VfYmhfZGF0YSwg
Y3B1KTsNCi0JcmRwLT5wYXNzZWRfcXVpZXNjID0gMTsNCisJaWYocmRwLT5h
Y3RpdmVfcmVhZGVycz09MCkNCisJCXJkcC0+cGFzc2VkX3F1aWVzYyA9IDE7
DQogfQ0KIA0KIHN0YXRpYyBpbmxpbmUgaW50IF9fcmN1X3BlbmRpbmcoc3Ry
dWN0IHJjdV9jdHJsYmxrICpyY3AsDQpAQCAtMTgzLDE0ICsxODgsMzQgQEAN
CiAgKg0KICAqIEl0IGlzIGlsbGVnYWwgdG8gYmxvY2sgd2hpbGUgaW4gYW4g
UkNVIHJlYWQtc2lkZSBjcml0aWNhbCBzZWN0aW9uLg0KICAqLw0KLSNkZWZp
bmUgcmN1X3JlYWRfbG9jaygpCQlwcmVlbXB0X2Rpc2FibGUoKQ0KK3N0YXRp
YyBpbmxpbmUgdm9pZCByY3VfcmVhZF9sb2NrKHZvaWQpDQorewkNCisJdW5z
aWduZWQgbG9uZyBmbGFnczsNCisNCisJbG9jYWxfaXJxX3NhdmUoZmxhZ3Mp
Ow0KKyAJX19nZXRfY3B1X3ZhcihyY3VfZGF0YSkuYWN0aXZlX3JlYWRlcnMr
KzsNCisJY3VycmVudC0+cmN1X3JlYWRfbG9ja19uZXN0aW5nKys7DQorCWxv
Y2FsX2lycV9yZXN0b3JlKGZsYWdzKTsNCit9DQogDQogLyoqDQogICogcmN1
X3JlYWRfdW5sb2NrIC0gbWFya3MgdGhlIGVuZCBvZiBhbiBSQ1UgcmVhZC1z
aWRlIGNyaXRpY2FsIHNlY3Rpb24uDQogICoNCiAgKiBTZWUgcmN1X3JlYWRf
bG9jaygpIGZvciBtb3JlIGluZm9ybWF0aW9uLg0KICAqLw0KLSNkZWZpbmUg
cmN1X3JlYWRfdW5sb2NrKCkJcHJlZW1wdF9lbmFibGUoKQ0KK3N0YXRpYyBp
bmxpbmUgdm9pZCByY3VfcmVhZF91bmxvY2sodm9pZCkNCit7DQorCXVuc2ln
bmVkIGxvbmcgZmxhZ3M7DQorCWludCBjcHU7DQorDQorCWxvY2FsX2lycV9z
YXZlKGZsYWdzKTsNCisJY3B1ID0gc21wX3Byb2Nlc3Nvcl9pZCgpOw0KKwkN
CisgCXBlcl9jcHUocmN1X2RhdGEsY3B1KS5hY3RpdmVfcmVhZGVycy0tOw0K
KwljdXJyZW50LT5yY3VfcmVhZF9sb2NrX25lc3RpbmctLTsNCisJcmN1X3Fz
Y3RyX2luYyhjcHUpOw0KKwlsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7DQor
fQ0KIA0KIC8qDQogICogU28gd2hlcmUgaXMgcmN1X3dyaXRlX2xvY2soKT8g
IEl0IGRvZXMgbm90IGV4aXN0LCBhcyB0aGVyZSBpcyBubw0KQEAgLTIxMywx
NCArMjM4LDM0IEBADQogICogY2FuIHVzZSBqdXN0IHJjdV9yZWFkX2xvY2so
KS4NCiAgKg0KICAqLw0KLSNkZWZpbmUgcmN1X3JlYWRfbG9ja19iaCgpCWxv
Y2FsX2JoX2Rpc2FibGUoKQ0KK3N0YXRpYyBpbmxpbmUgdm9pZCByY3VfcmVh
ZF9sb2NrX2JoKHZvaWQpDQoreyANCisJdW5zaWduZWQgbG9uZyBmbGFnczsN
CisNCisJbG9jYWxfaXJxX3NhdmUoZmxhZ3MpOw0KKyAJX19nZXRfY3B1X3Zh
cihyY3VfYmhfZGF0YSkuYWN0aXZlX3JlYWRlcnMrKzsNCisJY3VycmVudC0+
cmN1X3JlYWRfbG9ja19uZXN0aW5nKys7DQorCWxvY2FsX2lycV9yZXN0b3Jl
KGZsYWdzKTsNCit9DQogDQogLyoNCiAgKiByY3VfcmVhZF91bmxvY2tfYmgg
LSBtYXJrcyB0aGUgZW5kIG9mIGEgc29mdGlycS1vbmx5IFJDVSBjcml0aWNh
bCBzZWN0aW9uDQogICoNCiAgKiBTZWUgcmN1X3JlYWRfbG9ja19iaCgpIGZv
ciBtb3JlIGluZm9ybWF0aW9uLg0KICAqLw0KLSNkZWZpbmUgcmN1X3JlYWRf
dW5sb2NrX2JoKCkJbG9jYWxfYmhfZW5hYmxlKCkNCitzdGF0aWMgaW5saW5l
IHZvaWQgcmN1X3JlYWRfdW5sb2NrX2JoKHZvaWQpCQ0KK3sgDQorCXVuc2ln
bmVkIGxvbmcgZmxhZ3M7DQorCWludCBjcHU7DQorDQorCWxvY2FsX2lycV9z
YXZlKGZsYWdzKTsNCisJY3B1ID0gc21wX3Byb2Nlc3Nvcl9pZCgpOw0KKwkN
CisgCXBlcl9jcHUocmN1X2JoX2RhdGEsY3B1KS5hY3RpdmVfcmVhZGVycy0t
Ow0KKwljdXJyZW50LT5yY3VfcmVhZF9sb2NrX25lc3RpbmctLTsNCisJcmN1
X2JoX3FzY3RyX2luYyhjcHUpOw0KKwlsb2NhbF9pcnFfcmVzdG9yZShmbGFn
cyk7DQorfQ0KIA0KIC8qKg0KICAqIHJjdV9kZXJlZmVyZW5jZSAtIGZldGNo
IGFuIFJDVS1wcm90ZWN0ZWQgcG9pbnRlciBpbiBhbg0KZGlmZiAtTmF1ciAt
LWV4Y2x1ZGUtZnJvbT1kaWZmX2V4Y2x1ZGUgT3JpZy9saW51eC0yLjYuMTIt
cmMxL2luY2x1ZGUvbGludXgvc2NoZWQuaCBsaW51eC0yLjYuMTItcmMxLVJD
VS9pbmNsdWRlL2xpbnV4L3NjaGVkLmgNCi0tLSBPcmlnL2xpbnV4LTIuNi4x
Mi1yYzEvaW5jbHVkZS9saW51eC9zY2hlZC5oCVN1biBNYXIgMjAgMjA6MzE6
MjkgMjAwNQ0KKysrIGxpbnV4LTIuNi4xMi1yYzEtUkNVL2luY2x1ZGUvbGlu
dXgvc2NoZWQuaAlGcmkgTWFyIDI1IDAwOjIyOjAwIDIwMDUNCkBAIC01Njks
NiArNTY5LDkgQEANCiAJdW5zaWduZWQgbG9uZyBwdHJhY2U7DQogDQogCWlu
dCBsb2NrX2RlcHRoOwkJLyogTG9jayBkZXB0aCAqLw0KKwkNCisJaW50IHJj
dV9yZWFkX2xvY2tfbmVzdGluZzsgLyogSG93IG1hbnkgUkNVIHJlYWQgcmVh
Z2lvbnMgdGhlIHRocmVhZCBpcyANCisJCQkJICAgICAgaW4gKi8NCiANCiAJ
aW50IHByaW8sIHN0YXRpY19wcmlvOw0KIAlzdHJ1Y3QgbGlzdF9oZWFkIHJ1
bl9saXN0Ow0KZGlmZiAtTmF1ciAtLWV4Y2x1ZGUtZnJvbT1kaWZmX2V4Y2x1
ZGUgT3JpZy9saW51eC0yLjYuMTItcmMxL2luaXQvbWFpbi5jIGxpbnV4LTIu
Ni4xMi1yYzEtUkNVL2luaXQvbWFpbi5jDQotLS0gT3JpZy9saW51eC0yLjYu
MTItcmMxL2luaXQvbWFpbi5jCVN1biBNYXIgMjAgMjA6MzE6MzAgMjAwNQ0K
KysrIGxpbnV4LTIuNi4xMi1yYzEtUkNVL2luaXQvbWFpbi5jCUZyaSBNYXIg
MjUgMTM6MzY6MjYgMjAwNQ0KQEAgLTY4OCw4ICs2ODgsMTEgQEANCiAJc3lz
dGVtX3N0YXRlID0gU1lTVEVNX1JVTk5JTkc7DQogCW51bWFfZGVmYXVsdF9w
b2xpY3koKTsNCiANCi0JaWYgKHN5c19vcGVuKChjb25zdCBjaGFyIF9fdXNl
ciAqKSAiL2Rldi9jb25zb2xlIiwgT19SRFdSLCAwKSA8IDApDQotCQlwcmlu
dGsoS0VSTl9XQVJOSU5HICJXYXJuaW5nOiB1bmFibGUgdG8gb3BlbiBhbiBp
bml0aWFsIGNvbnNvbGUuXG4iKTsNCisJew0KKwkgIGludCByZXMgPSBzeXNf
b3BlbigoY29uc3QgY2hhciBfX3VzZXIgKikgIi9kZXYvY29uc29sZSIsIE9f
UkRXUiwgMCk7DQorCSAgaWYocmVzPDApDQorCSAgICBwcmludGsoS0VSTl9X
QVJOSU5HICJXYXJuaW5nOiB1bmFibGUgdG8gb3BlbiBhbiBpbml0aWFsIGNv
bnNvbGUuOiByZXR2YWw9JWRcbiIscmVzKTsNCisJfQ0KIA0KIAkodm9pZCkg
c3lzX2R1cCgwKTsNCiAJKHZvaWQpIHN5c19kdXAoMCk7DQpkaWZmIC1OYXVy
IC0tZXhjbHVkZS1mcm9tPWRpZmZfZXhjbHVkZSBPcmlnL2xpbnV4LTIuNi4x
Mi1yYzEva2VybmVsL3JjdXBkYXRlLmMgbGludXgtMi42LjEyLXJjMS1SQ1Uv
a2VybmVsL3JjdXBkYXRlLmMNCi0tLSBPcmlnL2xpbnV4LTIuNi4xMi1yYzEv
a2VybmVsL3JjdXBkYXRlLmMJV2VkIE1hciAgMiAwODozNzozMCAyMDA1DQor
KysgbGludXgtMi42LjEyLXJjMS1SQ1Uva2VybmVsL3JjdXBkYXRlLmMJRnJp
IE1hciAyNSAxMzowODozOCAyMDA1DQpAQCAtNjYsNyArNjYsMTAgQEANCiAJ
ICB7LmxvY2sgPSBTUElOX0xPQ0tfVU5MT0NLRUQsIC5jcHVtYXNrID0gQ1BV
X01BU0tfTk9ORSB9Ow0KIA0KIERFRklORV9QRVJfQ1BVKHN0cnVjdCByY3Vf
ZGF0YSwgcmN1X2RhdGEpID0geyAwTCB9Ow0KK0VYUE9SVF9QRVJfQ1BVX1NZ
TUJPTChyY3VfZGF0YSk7DQogREVGSU5FX1BFUl9DUFUoc3RydWN0IHJjdV9k
YXRhLCByY3VfYmhfZGF0YSkgPSB7IDBMIH07DQorRVhQT1JUX1BFUl9DUFVf
U1lNQk9MKHJjdV9iaF9kYXRhKTsNCisNCiANCiAvKiBGYWtlIGluaXRpYWxp
emF0aW9uIHJlcXVpcmVkIGJ5IGNvbXBpbGVyICovDQogc3RhdGljIERFRklO
RV9QRVJfQ1BVKHN0cnVjdCB0YXNrbGV0X3N0cnVjdCwgcmN1X3Rhc2tsZXQp
ID0ge05VTEx9Ow0KZGlmZiAtTmF1ciAtLWV4Y2x1ZGUtZnJvbT1kaWZmX2V4
Y2x1ZGUgT3JpZy9saW51eC0yLjYuMTItcmMxL2tlcm5lbC9zY2hlZC5jIGxp
bnV4LTIuNi4xMi1yYzEtUkNVL2tlcm5lbC9zY2hlZC5jDQotLS0gT3JpZy9s
aW51eC0yLjYuMTItcmMxL2tlcm5lbC9zY2hlZC5jCVN1biBNYXIgMjAgMjA6
MzE6MzAgMjAwNQ0KKysrIGxpbnV4LTIuNi4xMi1yYzEtUkNVL2tlcm5lbC9z
Y2hlZC5jCVdlZCBNYXIgMzAgMDA6MDY6MzkgMjAwNQ0KQEAgLTU5NCw2ICs1
OTQsOSBAQA0KIAlpZiAocnRfdGFzayhwKSkNCiAJCXJldHVybiBwLT5wcmlv
Ow0KIA0KKwlpZiAocC0+cmN1X3JlYWRfbG9ja19uZXN0aW5nKQ0KKwkJcmV0
dXJuIE1BWF9SVF9QUklPOw0KKw0KIAlib251cyA9IENVUlJFTlRfQk9OVVMo
cCkgLSBNQVhfQk9OVVMgLyAyOw0KIA0KIAlwcmlvID0gcC0+c3RhdGljX3By
aW8gLSBib251czsNCkBAIC05ODYsNiArOTg5LDkgQEANCiAJaWYgKHVubGlr
ZWx5KHRhc2tfcnVubmluZyhycSwgcCkpKQ0KIAkJZ290byBvdXRfYWN0aXZh
dGU7DQogDQorCWlmICh1bmxpa2VseShwLT5yY3VfcmVhZF9sb2NrX25lc3Rp
bmcpKQ0KKwkJZ290byBvdXRfYWN0aXZhdGU7DQorDQogI2lmZGVmIENPTkZJ
R19TQ0hFRFNUQVRTDQogCXNjaGVkc3RhdF9pbmMocnEsIHR0d3VfY250KTsN
CiAJaWYgKGNwdSA9PSB0aGlzX2NwdSkgew0KQEAgLTE2NDQsNiArMTY1MCw4
IEBADQogCQlyZXR1cm4gMDsNCiAJaWYgKCFjcHVfaXNzZXQodGhpc19jcHUs
IHAtPmNwdXNfYWxsb3dlZCkpDQogCQlyZXR1cm4gMDsNCisJaWYgKHAtPnJj
dV9yZWFkX2xvY2tfbmVzdGluZykNCisJCXJldHVybiAwOw0KIA0KIAkvKg0K
IAkgKiBBZ2dyZXNzaXZlIG1pZ3JhdGlvbiBpZjoNCkBAIC0yNjMzLDYgKzI2
NDEsNyBAQA0KIG5lZWRfcmVzY2hlZDoNCiAJcHJlZW1wdF9kaXNhYmxlKCk7
DQogCXByZXYgPSBjdXJyZW50Ow0KKwkgIA0KIAlyZWxlYXNlX2tlcm5lbF9s
b2NrKHByZXYpOw0KIG5lZWRfcmVzY2hlZF9ub25wcmVlbXB0aWJsZToNCiAJ
cnEgPSB0aGlzX3JxKCk7DQpAQCAtMjY3NSw2ICsyNjg0LDcgQEANCiAJCWVs
c2Ugew0KIAkJCWlmIChwcmV2LT5zdGF0ZSA9PSBUQVNLX1VOSU5URVJSVVBU
SUJMRSkNCiAJCQkJcnEtPm5yX3VuaW50ZXJydXB0aWJsZSsrOw0KKw0KIAkJ
CWRlYWN0aXZhdGVfdGFzayhwcmV2LCBycSk7DQogCQl9DQogCX0NCkBAIC0y
NzEwLDYgKzI3MjAsMTcgQEANCiAJfQ0KIA0KIAlhcnJheSA9IHJxLT5hY3Rp
dmU7DQorDQorCWlmKCB1bmxpa2VseShwcmV2LT5yY3VfcmVhZF9sb2NrX25l
c3RpbmcpICYmIA0KKwkgICAgcHJldi0+cHJpbyA+IE1BWF9SVF9QUklPICkg
ew0KKwkJcHJpb19hcnJheV90ICpwcmV2X2FycmF5ID0gcHJldi0+YXJyYXk7
DQorCQlpZihwcmV2X2FycmF5KQ0KKwkJCWRlcXVldWVfdGFzayhwcmV2LCBw
cmV2X2FycmF5KTsNCisJCXByZXYtPnByaW8gPSBNQVhfUlRfUFJJTzsNCisJ
CWlmKHByZXZfYXJyYXkpDQorCQkJZW5xdWV1ZV90YXNrX2hlYWQocHJldiwg
cHJldl9hcnJheSk7DQorCX0NCisNCiAJaWYgKHVubGlrZWx5KCFhcnJheS0+
bnJfYWN0aXZlKSkgew0KIAkJLyoNCiAJCSAqIFN3aXRjaCB0aGUgYWN0aXZl
IGFuZCBleHBpcmVkIGFycmF5cy4NCg==
--0-851980082-1115835289=:6202--
