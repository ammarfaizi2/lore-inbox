Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWFUPhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWFUPhF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 11:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWFUPhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 11:37:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:36294 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932194AbWFUPhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 11:37:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=GuG/Fl/dFu2xO0TGGmRm/Bv5gTxbfBnMgcob5gRvPQUgQJX8/BctvgOOH4fgCBUSVFv4cE+QBIqtt0wikSIwF7qQvfUcJqddJqDrtZuCJvzgagERyNNHGwLdUJI4o0IWsa4w/0ey5AKwHaeAQmshxFm51QMLnsUEnwd9eWd1mTY=
Date: Wed, 21 Jun 2006 17:37:02 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Steven Rostedt <rostedt@goodmis.org>
cc: Esben Nielsen <nielsen.esben@googlemail.com>,
       Esben Nielsen <nielsen.esben@gogglemail.com>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
In-Reply-To: <Pine.LNX.4.58.0606211114140.29348@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.64.0606211736080.7939@localhost.localdomain>
References: <20060618070641.GA6759@elte.hu>  <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
  <1150816429.6780.222.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain> 
 <Pine.LNX.4.58.0606201229310.729@gandalf.stny.rr.com> 
 <Pine.LNX.4.64.0606201903030.11643@localhost.localdomain>
 <1150824092.6780.255.camel@localhost.localdomain>
 <Pine.LNX.4.64.0606202217160.11643@localhost.localdomain>
 <Pine.LNX.4.58.0606210418160.29673@gandalf.stny.rr.com>
 <Pine.LNX.4.64.0606211204220.10723@localhost.localdomain>
 <Pine.LNX.4.64.0606211638560.6572@localhost.localdomain>
 <Pine.LNX.4.58.0606211114140.29348@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-867731332-1150907822=:7939"
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-867731332-1150907822=:7939
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed



On Wed, 21 Jun 2006, Steven Rostedt wrote:

>
> On Wed, 21 Jun 2006, Esben Nielsen wrote:
>
>>> Yeah, I saw. Move it out in setscheduler() then. I'll try to fix it, but I am
>>> not sure I can make a test if it works.
>>
>> What about the patch below. It compiles and my UP labtop runs fine, but I
>> haven't otherwise tested it.  My labtop runs RTExec without hichups
>> until now.
>
> Hm, I take it that English is not your native language (maybe it its??)
> You do write very well regardless, but I notice with my German colleagues,
> that they seem to always translate "bis jetzt" to "until now" when I would
> use something like "as of yet".  The "until now" (at least to me) gives
> the impression that it hasn't happened up till now, but it has happended
> now.  So one could say after running their car into a tree "Oh well,
> I haven't had an accident until now". So I'm assuming that you still don't
> have hichups.
>  OK enough about that ;)
>
> The below patch has whitespace damage.  Could you resend?
>

Does it help if I send it as an attachment?

Esben


> Thanks,
>
> -- Steve
>
>>
>> Esben
>>
>> Index: linux-2.6.17-rt1/kernel/rtmutex.c
>> ===================================================================
>> --- linux-2.6.17-rt1.orig/kernel/rtmutex.c
>> +++ linux-2.6.17-rt1/kernel/rtmutex.c
>> @@ -625,6 +625,7 @@ rt_lock_slowlock(struct rt_mutex *lock _
>>
>>   	debug_rt_mutex_init_waiter(&waiter);
>>   	waiter.task = NULL;
>> +	waiter.save_state = 1;
>>
>>   	spin_lock(&lock->wait_lock);
>>
>> @@ -687,6 +688,19 @@ rt_lock_slowlock(struct rt_mutex *lock _
>>   		state = xchg(&current->state, TASK_UNINTERRUPTIBLE);
>>   		if (unlikely(state == TASK_RUNNING))
>>   			saved_state = TASK_RUNNING;
>> +
>> +		if (unlikely(waiter.task) &&
>> +		    waiter.list_entry.prio != current->prio) {
>> +			/*
>> +			 * We still not have the lock, but we are woken up with
>> +			 * a different prio than the one we waited with
>> +			 * originally. We remove the wait entry now and then
>> +			 * reinsert ourselves with the right priority
>> +			 */
>> +			remove_waiter(lock, &waiter __IP__);
>> +			waiter.task = NULL;
>> +		}
>> +
>>   	}
>>
>>   	state = xchg(&current->state, saved_state);
>> @@ -798,6 +812,7 @@ rt_mutex_slowlock(struct rt_mutex *lock,
>>
>>   	debug_rt_mutex_init_waiter(&waiter);
>>   	waiter.task = NULL;
>> +	waiter.save_state = 0;
>>
>>   	spin_lock(&lock->wait_lock);
>>
>> @@ -877,6 +892,18 @@ rt_mutex_slowlock(struct rt_mutex *lock,
>>
>>   		current->flags |= saved_flags;
>>   		set_current_state(state);
>> +
>> +		if (unlikely(waiter.task) &&
>> +		    waiter.list_entry.prio != current->prio) {
>> +			/*
>> +			 * We still not have the lock, but we are woken up with
>> +			 * a different prio than the one we waited with
>> +			 * originally. We remove the wait entry now and then
>> +			 * reinsert ourselves with the right priority
>> +			 */
>> +			remove_waiter(lock, &waiter __IP__);
>> +			waiter.task = NULL;
>> +		}
>>   	}
>>
>>   	set_current_state(TASK_RUNNING);
>> Index: linux-2.6.17-rt1/kernel/sched.c
>> ===================================================================
>> --- linux-2.6.17-rt1.orig/kernel/sched.c
>> +++ linux-2.6.17-rt1/kernel/sched.c
>> @@ -57,6 +57,8 @@
>>
>>   #include <asm/unistd.h>
>>
>> +#include "rtmutex_common.h"
>> +
>>   /*
>>    * Convert user-nice values [ -20 ... 0 ... 19 ]
>>    * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
>> @@ -646,7 +648,9 @@ static inline void sched_info_switch(tas
>>   #define sched_info_switch(t, next)	do { } while (0)
>>   #endif /* CONFIG_SCHEDSTATS */
>>
>> +#ifdef CONFIG_SMP
>>   static __cacheline_aligned_in_smp atomic_t rt_overload;
>> +#endif
>>
>>   static inline void inc_rt_tasks(task_t *p, runqueue_t *rq)
>>   {
>> @@ -1473,10 +1477,11 @@ static inline int wake_idle(int cpu, tas
>>   static int try_to_wake_up(task_t *p, unsigned int state, int sync, int mutex)
>>   {
>>   	int cpu, this_cpu, success = 0;
>> -	runqueue_t *this_rq, *rq;
>> +	runqueue_t *rq;
>>   	unsigned long flags;
>>   	long old_state;
>>   #ifdef CONFIG_SMP
>> +	runqueue_t *this_rq;
>>   	unsigned long load, this_load;
>>   	struct sched_domain *sd, *this_sd = NULL;
>>   	int new_cpu;
>> @@ -4351,6 +4356,18 @@ int setscheduler(struct task_struct *p,
>>   			resched_task(rq->curr);
>>   	}
>>   	task_rq_unlock(rq, &flags);
>> +
>> +	/*
>> +	 * If the process is blocked on rt-mutex, it will now wake up and
>> +	 * reinsert itself into the wait list and boost the owner correctly
>> +	 */
>> +	if (p->pi_blocked_on) {
>> +		if (p->pi_blocked_on->save_state)
>> +			wake_up_process_mutex(p);
>> +		else
>> +			wake_up_process(p);
>> +	}
>> +
>>   	spin_unlock_irqrestore(&p->pi_lock, fp);
>>   	return 0;
>>   }
>> @@ -7086,4 +7103,3 @@ void notrace preempt_enable_no_resched(v
>>
>>   EXPORT_SYMBOL(preempt_enable_no_resched);
>>   #endif
>> -
>> Index: linux-2.6.17-rt1/kernel/rtmutex_common.h
>> ===================================================================
>> --- linux-2.6.17-rt1.orig/kernel/rtmutex_common.h
>> +++ linux-2.6.17-rt1/kernel/rtmutex_common.h
>> @@ -49,6 +49,7 @@ struct rt_mutex_waiter {
>>   	struct plist_node	pi_list_entry;
>>   	struct task_struct	*task;
>>   	struct rt_mutex		*lock;
>> +	int                     save_state;
>>   #ifdef CONFIG_DEBUG_RT_MUTEXES
>>   	unsigned long		ip;
>>   	pid_t			deadlock_task_pid;
>>
>
--8323328-867731332-1150907822=:7939
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=setscheduler_pi.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0606211737020.7939@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename=setscheduler_pi.patch

SW5kZXg6IGxpbnV4LTIuNi4xNy1ydDEva2VybmVsL3J0bXV0ZXguYw0KPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQ0KLS0tIGxpbnV4LTIuNi4xNy1ydDEub3Jp
Zy9rZXJuZWwvcnRtdXRleC5jDQorKysgbGludXgtMi42LjE3LXJ0MS9rZXJu
ZWwvcnRtdXRleC5jDQpAQCAtNjI1LDYgKzYyNSw3IEBAIHJ0X2xvY2tfc2xv
d2xvY2soc3RydWN0IHJ0X211dGV4ICpsb2NrIF8NCiANCiAJZGVidWdfcnRf
bXV0ZXhfaW5pdF93YWl0ZXIoJndhaXRlcik7DQogCXdhaXRlci50YXNrID0g
TlVMTDsNCisJd2FpdGVyLnNhdmVfc3RhdGUgPSAxOw0KIA0KIAlzcGluX2xv
Y2soJmxvY2stPndhaXRfbG9jayk7DQogDQpAQCAtNjg3LDYgKzY4OCwxOSBA
QCBydF9sb2NrX3Nsb3dsb2NrKHN0cnVjdCBydF9tdXRleCAqbG9jayBfDQog
CQlzdGF0ZSA9IHhjaGcoJmN1cnJlbnQtPnN0YXRlLCBUQVNLX1VOSU5URVJS
VVBUSUJMRSk7DQogCQlpZiAodW5saWtlbHkoc3RhdGUgPT0gVEFTS19SVU5O
SU5HKSkNCiAJCQlzYXZlZF9zdGF0ZSA9IFRBU0tfUlVOTklORzsNCisNCisJ
CWlmICh1bmxpa2VseSh3YWl0ZXIudGFzaykgJiYNCisJCSAgICB3YWl0ZXIu
bGlzdF9lbnRyeS5wcmlvICE9IGN1cnJlbnQtPnByaW8pIHsNCisJCQkvKg0K
KwkJCSAqIFdlIHN0aWxsIG5vdCBoYXZlIHRoZSBsb2NrLCBidXQgd2UgYXJl
IHdva2VuIHVwIHdpdGgNCisJCQkgKiBhIGRpZmZlcmVudCBwcmlvIHRoYW4g
dGhlIG9uZSB3ZSB3YWl0ZWQgd2l0aA0KKwkJCSAqIG9yaWdpbmFsbHkuIFdl
IHJlbW92ZSB0aGUgd2FpdCBlbnRyeSBub3cgYW5kIHRoZW4NCisJCQkgKiBy
ZWluc2VydCBvdXJzZWx2ZXMgd2l0aCB0aGUgcmlnaHQgcHJpb3JpdHkNCisJ
CQkgKi8NCisJCQlyZW1vdmVfd2FpdGVyKGxvY2ssICZ3YWl0ZXIgX19JUF9f
KTsNCisJCQl3YWl0ZXIudGFzayA9IE5VTEw7DQorCQl9DQorDQogCX0NCiAN
CiAJc3RhdGUgPSB4Y2hnKCZjdXJyZW50LT5zdGF0ZSwgc2F2ZWRfc3RhdGUp
Ow0KQEAgLTc5OCw2ICs4MTIsNyBAQCBydF9tdXRleF9zbG93bG9jayhzdHJ1
Y3QgcnRfbXV0ZXggKmxvY2ssDQogDQogCWRlYnVnX3J0X211dGV4X2luaXRf
d2FpdGVyKCZ3YWl0ZXIpOw0KIAl3YWl0ZXIudGFzayA9IE5VTEw7DQorCXdh
aXRlci5zYXZlX3N0YXRlID0gMDsNCiANCiAJc3Bpbl9sb2NrKCZsb2NrLT53
YWl0X2xvY2spOw0KIA0KQEAgLTg3Nyw2ICs4OTIsMTggQEAgcnRfbXV0ZXhf
c2xvd2xvY2soc3RydWN0IHJ0X211dGV4ICpsb2NrLA0KIA0KIAkJY3VycmVu
dC0+ZmxhZ3MgfD0gc2F2ZWRfZmxhZ3M7DQogCQlzZXRfY3VycmVudF9zdGF0
ZShzdGF0ZSk7DQorDQorCQlpZiAodW5saWtlbHkod2FpdGVyLnRhc2spICYm
DQorCQkgICAgd2FpdGVyLmxpc3RfZW50cnkucHJpbyAhPSBjdXJyZW50LT5w
cmlvKSB7DQorCQkJLyoNCisJCQkgKiBXZSBzdGlsbCBub3QgaGF2ZSB0aGUg
bG9jaywgYnV0IHdlIGFyZSB3b2tlbiB1cCB3aXRoDQorCQkJICogYSBkaWZm
ZXJlbnQgcHJpbyB0aGFuIHRoZSBvbmUgd2Ugd2FpdGVkIHdpdGgNCisJCQkg
KiBvcmlnaW5hbGx5LiBXZSByZW1vdmUgdGhlIHdhaXQgZW50cnkgbm93IGFu
ZCB0aGVuDQorCQkJICogcmVpbnNlcnQgb3Vyc2VsdmVzIHdpdGggdGhlIHJp
Z2h0IHByaW9yaXR5DQorCQkJICovDQorCQkJcmVtb3ZlX3dhaXRlcihsb2Nr
LCAmd2FpdGVyIF9fSVBfXyk7DQorCQkJd2FpdGVyLnRhc2sgPSBOVUxMOw0K
KwkJfQ0KIAl9DQogDQogCXNldF9jdXJyZW50X3N0YXRlKFRBU0tfUlVOTklO
Ryk7DQpJbmRleDogbGludXgtMi42LjE3LXJ0MS9rZXJuZWwvc2NoZWQuYw0K
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KLS0tIGxpbnV4LTIuNi4xNy1ydDEu
b3JpZy9rZXJuZWwvc2NoZWQuYw0KKysrIGxpbnV4LTIuNi4xNy1ydDEva2Vy
bmVsL3NjaGVkLmMNCkBAIC01Nyw2ICs1Nyw4IEBADQogDQogI2luY2x1ZGUg
PGFzbS91bmlzdGQuaD4NCiANCisjaW5jbHVkZSAicnRtdXRleF9jb21tb24u
aCINCisNCiAvKg0KICAqIENvbnZlcnQgdXNlci1uaWNlIHZhbHVlcyBbIC0y
MCAuLi4gMCAuLi4gMTkgXQ0KICAqIHRvIHN0YXRpYyBwcmlvcml0eSBbIE1B
WF9SVF9QUklPLi5NQVhfUFJJTy0xIF0sDQpAQCAtNjQ2LDcgKzY0OCw5IEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCBzY2hlZF9pbmZvX3N3aXRjaCh0YXMNCiAj
ZGVmaW5lIHNjaGVkX2luZm9fc3dpdGNoKHQsIG5leHQpCWRvIHsgfSB3aGls
ZSAoMCkNCiAjZW5kaWYgLyogQ09ORklHX1NDSEVEU1RBVFMgKi8NCiANCisj
aWZkZWYgQ09ORklHX1NNUA0KIHN0YXRpYyBfX2NhY2hlbGluZV9hbGlnbmVk
X2luX3NtcCBhdG9taWNfdCBydF9vdmVybG9hZDsNCisjZW5kaWYNCiANCiBz
dGF0aWMgaW5saW5lIHZvaWQgaW5jX3J0X3Rhc2tzKHRhc2tfdCAqcCwgcnVu
cXVldWVfdCAqcnEpDQogew0KQEAgLTE0NzMsMTAgKzE0NzcsMTEgQEAgc3Rh
dGljIGlubGluZSBpbnQgd2FrZV9pZGxlKGludCBjcHUsIHRhcw0KIHN0YXRp
YyBpbnQgdHJ5X3RvX3dha2VfdXAodGFza190ICpwLCB1bnNpZ25lZCBpbnQg
c3RhdGUsIGludCBzeW5jLCBpbnQgbXV0ZXgpDQogew0KIAlpbnQgY3B1LCB0
aGlzX2NwdSwgc3VjY2VzcyA9IDA7DQotCXJ1bnF1ZXVlX3QgKnRoaXNfcnEs
ICpycTsNCisJcnVucXVldWVfdCAqcnE7DQogCXVuc2lnbmVkIGxvbmcgZmxh
Z3M7DQogCWxvbmcgb2xkX3N0YXRlOw0KICNpZmRlZiBDT05GSUdfU01QDQor
CXJ1bnF1ZXVlX3QgKnRoaXNfcnE7DQogCXVuc2lnbmVkIGxvbmcgbG9hZCwg
dGhpc19sb2FkOw0KIAlzdHJ1Y3Qgc2NoZWRfZG9tYWluICpzZCwgKnRoaXNf
c2QgPSBOVUxMOw0KIAlpbnQgbmV3X2NwdTsNCkBAIC00MzUxLDYgKzQzNTYs
MTggQEAgaW50IHNldHNjaGVkdWxlcihzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAs
IA0KIAkJCXJlc2NoZWRfdGFzayhycS0+Y3Vycik7DQogCX0NCiAJdGFza19y
cV91bmxvY2socnEsICZmbGFncyk7DQorDQorCS8qDQorCSAqIElmIHRoZSBw
cm9jZXNzIGlzIGJsb2NrZWQgb24gcnQtbXV0ZXgsIGl0IHdpbGwgbm93IHdh
a2UgdXAgYW5kDQorCSAqIHJlaW5zZXJ0IGl0c2VsZiBpbnRvIHRoZSB3YWl0
IGxpc3QgYW5kIGJvb3N0IHRoZSBvd25lciBjb3JyZWN0bHkNCisJICovDQor
CWlmIChwLT5waV9ibG9ja2VkX29uKSB7DQorCQlpZiAocC0+cGlfYmxvY2tl
ZF9vbi0+c2F2ZV9zdGF0ZSkNCisJCQl3YWtlX3VwX3Byb2Nlc3NfbXV0ZXgo
cCk7DQorCQllbHNlDQorCQkJd2FrZV91cF9wcm9jZXNzKHApOw0KKwl9DQor
DQogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnAtPnBpX2xvY2ssIGZwKTsN
CiAJcmV0dXJuIDA7DQogfQ0KQEAgLTcwODYsNCArNzEwMywzIEBAIHZvaWQg
bm90cmFjZSBwcmVlbXB0X2VuYWJsZV9ub19yZXNjaGVkKHYNCiANCiBFWFBP
UlRfU1lNQk9MKHByZWVtcHRfZW5hYmxlX25vX3Jlc2NoZWQpOw0KICNlbmRp
Zg0KLQ0KSW5kZXg6IGxpbnV4LTIuNi4xNy1ydDEva2VybmVsL3J0bXV0ZXhf
Y29tbW9uLmgNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCi0tLSBsaW51eC0y
LjYuMTctcnQxLm9yaWcva2VybmVsL3J0bXV0ZXhfY29tbW9uLmgNCisrKyBs
aW51eC0yLjYuMTctcnQxL2tlcm5lbC9ydG11dGV4X2NvbW1vbi5oDQpAQCAt
NDksNiArNDksNyBAQCBzdHJ1Y3QgcnRfbXV0ZXhfd2FpdGVyIHsNCiAJc3Ry
dWN0IHBsaXN0X25vZGUJcGlfbGlzdF9lbnRyeTsNCiAJc3RydWN0IHRhc2tf
c3RydWN0CSp0YXNrOw0KIAlzdHJ1Y3QgcnRfbXV0ZXgJCSpsb2NrOw0KKwlp
bnQgICAgICAgICAgICAgICAgICAgICBzYXZlX3N0YXRlOw0KICNpZmRlZiBD
T05GSUdfREVCVUdfUlRfTVVURVhFUw0KIAl1bnNpZ25lZCBsb25nCQlpcDsN
CiAJcGlkX3QJCQlkZWFkbG9ja190YXNrX3BpZDsNCg==

--8323328-867731332-1150907822=:7939--
