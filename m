Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVCTNaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVCTNaY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 08:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVCTNaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 08:30:23 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:56495 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S262168AbVCTNaA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 08:30:00 -0500
Date: Sun, 20 Mar 2005 14:29:17 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, dipankar@in.ibm.com,
       shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
In-Reply-To: <20050318171929.GC30310@elte.hu>
Message-Id: <Pine.OSF.4.05.10503181836520.5287-200000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-154843471-1111325357=:5287"
X-DAIMI-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-154843471-1111325357=:5287
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 18 Mar 2005, Ingo Molnar wrote:

> 
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> > Why can should there only be one RCU-reader per CPU at each given
> > instance? Even on a real-time UP system it would be very helpfull to
> > have RCU areas to be enterable by several tasks as once. It would
> > perform better, both wrt. latencies and throughput: With the above
> > implementation an high priority task entering an RCU area will have to
> > boost the current RCU reader, make a task switch until that one
> > finishes and makes yet another task switch. to get back to the high
> > priority task. With an RCU implementation which can take n RCU readers
> > per CPU there is no such problem.
> 
> correct, for RCU we could allow multiple readers per lock, because the
> 'blocking' side of RCU (callback processing) is never (supposed to be)
> in any latency path.
> 
> except if someone wants to make RCU callback processing deterministic at
> some point. (e.g. for memory management reasons.)

I think it can be deterministic (on the long timescale of memory management) 
anyway: Boost any non-RT task entering an RCU region to the lowest RT priority.
This way only all the RT tasks + one non-RT task can be within those
regions. The RT-tasks are supposed to have some kind of upper bound to
their CPU-usage. The non-RT task will also finish "soon" as it is
boosted. If the RCU batches are also at the lowest RT-priority they can be
run immediately after the non-RT task is done.

> 
> clearly the simplest solution is to go with the single-reader locks for
> now - a separate experiment could be done with a new type of rwlock that
> can only be used by the RCU code. (I'm not quite sure whether we could
> guarantee a minimum rate of RCU callback processing under such a scheme
> though. It's an eventual memory DoS otherwise.)
> 

Why are a lock needed at all? If it is doable without locking for an
non-preemptable SMP kernel it must be doable for an preemptable kernel as
well.I am convinced some kind of per-CPU rcu_read_count as I specified in
my previous mail can work some way or the other. call_rcu() might need to
do more complicated stuff and thus use CPU but call_rcu() is supposed to
be an relative rare event not worth optimizing for.  Such an
implementation will work for any preemptable kernel, not only PREEMPT_RT. 
For performance is considered it is important not to acquire any locks in
the rcu-read regions. 

I tried this approach. My UP labtop did boot on it, but I haven't testet
it further. I have included the very small patch as an attachment.

> 	Ingo

I have not yet looked at -V0.7.41-00...

Esben


--0-154843471-1111325357=:5287
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=rcu_patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.OSF.4.05.10503201429170.5287@da410.phys.au.dk>
Content-Description: 
Content-Disposition: attachment; filename=rcu_patch

ZGlmZiAtTmF1ciAtLWV4Y2x1ZGUtZnJvbSBkaWZmX2V4Y2x1ZGUgbGludXgt
Mi42LjExLWZpbmFsLVYwLjcuNDAtMDAvaW5jbHVkZS9saW51eC9yY3VwZGF0
ZS5oIGxpbnV4LTIuNi4xMS1maW5hbC1WMC43LjQwLTAwLVJDVS9pbmNsdWRl
L2xpbnV4L3JjdXBkYXRlLmgNCi0tLSBsaW51eC0yLjYuMTEtZmluYWwtVjAu
Ny40MC0wMC9pbmNsdWRlL2xpbnV4L3JjdXBkYXRlLmgJMjAwNS0wMy0xMSAy
Mzo0MDoxMy4wMDAwMDAwMDAgKzAxMDANCisrKyBsaW51eC0yLjYuMTEtZmlu
YWwtVjAuNy40MC0wMC1SQ1UvaW5jbHVkZS9saW51eC9yY3VwZGF0ZS5oCTIw
MDUtMDMtMTkgMTI6NDc6MDkuMDAwMDAwMDAwICswMTAwDQpAQCAtODUsNiAr
ODUsNyBAQA0KICAqIGN1cmxpc3QgLSBjdXJyZW50IGJhdGNoIGZvciB3aGlj
aCBxdWllc2NlbnQgY3ljbGUgc3RhcnRlZCBpZiBhbnkNCiAgKi8NCiBzdHJ1
Y3QgcmN1X2RhdGEgew0KKwlsb25nICAgICAgICAgICAgYWN0aXZlX3JlYWRl
cnM7DQogCS8qIDEpIHF1aWVzY2VudCBzdGF0ZSBoYW5kbGluZyA6ICovDQog
CWxvbmcJCXF1aWVzY2JhdGNoOyAgICAgLyogQmF0Y2ggIyBmb3IgZ3JhY2Ug
cGVyaW9kICovDQogCWludAkJcGFzc2VkX3F1aWVzYzsJIC8qIFVzZXItbW9k
ZS9pZGxlIGxvb3AgZXRjLiAqLw0KQEAgLTExNSwxMiArMTE2LDE0IEBADQog
c3RhdGljIGlubGluZSB2b2lkIHJjdV9xc2N0cl9pbmMoaW50IGNwdSkNCiB7
DQogCXN0cnVjdCByY3VfZGF0YSAqcmRwID0gJnBlcl9jcHUocmN1X2RhdGEs
IGNwdSk7DQotCXJkcC0+cGFzc2VkX3F1aWVzYyA9IDE7DQorCWlmKHJkcC0+
YWN0aXZlX3JlYWRlcnM9PTApDQorCQlyZHAtPnBhc3NlZF9xdWllc2MgPSAx
Ow0KIH0NCiBzdGF0aWMgaW5saW5lIHZvaWQgcmN1X2JoX3FzY3RyX2luYyhp
bnQgY3B1KQ0KIHsNCiAJc3RydWN0IHJjdV9kYXRhICpyZHAgPSAmcGVyX2Nw
dShyY3VfYmhfZGF0YSwgY3B1KTsNCi0JcmRwLT5wYXNzZWRfcXVpZXNjID0g
MTsNCisJaWYocmRwLT5hY3RpdmVfcmVhZGVycz09MCkNCisJCXJkcC0+cGFz
c2VkX3F1aWVzYyA9IDE7DQogfQ0KIA0KIHN0YXRpYyBpbmxpbmUgaW50IF9f
cmN1X3BlbmRpbmcoc3RydWN0IHJjdV9jdHJsYmxrICpyY3AsDQpAQCAtMTgz
LDI5ICsxODYsMjcgQEANCiAgKg0KICAqIEl0IGlzIGlsbGVnYWwgdG8gYmxv
Y2sgd2hpbGUgaW4gYW4gUkNVIHJlYWQtc2lkZSBjcml0aWNhbCBzZWN0aW9u
Lg0KICAqLw0KLSNkZWZpbmUgcmN1X3JlYWRfbG9jaygpCQlwcmVlbXB0X2Rp
c2FibGUoKQ0KK3N0YXRpYyBpbmxpbmUgdm9pZCByY3VfcmVhZF9sb2NrKHZv
aWQpDQorewkNCisJcHJlZW1wdF9kaXNhYmxlKCk7IA0KKwlfX2dldF9jcHVf
dmFyKHJjdV9kYXRhKS5hY3RpdmVfcmVhZGVycysrOw0KKwlwcmVlbXB0X2Vu
YWJsZSgpOw0KK30NCiANCiAvKioNCiAgKiByY3VfcmVhZF91bmxvY2sgLSBt
YXJrcyB0aGUgZW5kIG9mIGFuIFJDVSByZWFkLXNpZGUgY3JpdGljYWwgc2Vj
dGlvbi4NCiAgKg0KICAqIFNlZSByY3VfcmVhZF9sb2NrKCkgZm9yIG1vcmUg
aW5mb3JtYXRpb24uDQogICovDQotI2RlZmluZSByY3VfcmVhZF91bmxvY2so
KQlwcmVlbXB0X2VuYWJsZSgpDQorc3RhdGljIGlubGluZSB2b2lkIHJjdV9y
ZWFkX3VubG9jayh2b2lkKQ0KK3sJDQorCXByZWVtcHRfZGlzYWJsZSgpOyAN
CisJX19nZXRfY3B1X3ZhcihyY3VfZGF0YSkuYWN0aXZlX3JlYWRlcnMtLTsN
CisJcHJlZW1wdF9lbmFibGUoKTsNCit9DQogDQogI2RlZmluZSBJR05PUkVf
TE9DSyhvcCwgbG9jaykJZG8geyAodm9pZCkobG9jayk7IG9wKCk7IH0gd2hp
bGUgKDApDQogDQotI2lmZGVmIENPTkZJR19QUkVFTVBUX1JUDQotIyBkZWZp
bmUgcmN1X3JlYWRfbG9ja19zcGluKGxvY2spCXNwaW5fbG9jayhsb2NrKQ0K
LSMgZGVmaW5lIHJjdV9yZWFkX3VubG9ja19zcGluKGxvY2spCXNwaW5fdW5s
b2NrKGxvY2spDQotIyBkZWZpbmUgcmN1X3JlYWRfbG9ja19yZWFkKGxvY2sp
CXJlYWRfbG9jayhsb2NrKQ0KLSMgZGVmaW5lIHJjdV9yZWFkX3VubG9ja19y
ZWFkKGxvY2spCXJlYWRfdW5sb2NrKGxvY2spDQotIyBkZWZpbmUgcmN1X3Jl
YWRfbG9ja19iaF9yZWFkKGxvY2spCXJlYWRfbG9ja19iaChsb2NrKQ0KLSMg
ZGVmaW5lIHJjdV9yZWFkX3VubG9ja19iaF9yZWFkKGxvY2spCXJlYWRfdW5s
b2NrX2JoKGxvY2spDQotIyBkZWZpbmUgcmN1X3JlYWRfbG9ja19kb3duX3Jl
YWQocndzZW0pCWRvd25fcmVhZChyd3NlbSkNCi0jIGRlZmluZSByY3VfcmVh
ZF91bmxvY2tfdXBfcmVhZChyd3NlbSkJdXBfcmVhZChyd3NlbSkNCi0jIGRl
ZmluZSByY3VfcmVhZF9sb2NrX25vcnQoKQkJZG8geyB9IHdoaWxlICgwKQ0K
LSMgZGVmaW5lIHJjdV9yZWFkX3VubG9ja19ub3J0KCkJCWRvIHsgfSB3aGls
ZSAoMCkNCi0jZWxzZQ0KICMgZGVmaW5lIHJjdV9yZWFkX2xvY2tfc3Bpbihs
b2NrKQlJR05PUkVfTE9DSyhyY3VfcmVhZF9sb2NrLCBsb2NrKQ0KICMgZGVm
aW5lIHJjdV9yZWFkX3VubG9ja19zcGluKGxvY2spCUlHTk9SRV9MT0NLKHJj
dV9yZWFkX3VubG9jaywgbG9jaykNCiAjIGRlZmluZSByY3VfcmVhZF9sb2Nr
X3JlYWQobG9jaykJSUdOT1JFX0xPQ0socmN1X3JlYWRfbG9jaywgbG9jaykN
CkBAIC0yMTYsMTUgKzIxNywxMCBAQA0KICMgZGVmaW5lIHJjdV9yZWFkX3Vu
bG9ja19ub3J0KCkJCXJjdV9yZWFkX3VubG9jaygpDQogIyBkZWZpbmUgcmN1
X3JlYWRfbG9ja19iaF9yZWFkKGxvY2spCUlHTk9SRV9MT0NLKHJjdV9yZWFk
X2xvY2tfYmgsIGxvY2spDQogIyBkZWZpbmUgcmN1X3JlYWRfdW5sb2NrX2Jo
X3JlYWQobG9jaykJSUdOT1JFX0xPQ0socmN1X3JlYWRfdW5sb2NrX2JoLCBs
b2NrKQ0KLSNlbmRpZg0KIA0KLSNpZmRlZiBDT05GSUdfUFJFRU1QVF9SVA0K
LSMgZGVmaW5lIHJjdV9yZWFkX2xvY2tfc2VtKGxvY2spCWRvd24obG9jaykN
Ci0jIGRlZmluZSByY3VfcmVhZF91bmxvY2tfc2VtKGxvY2spCXVwKGxvY2sp
DQotI2Vsc2UNCiAjIGRlZmluZSByY3VfcmVhZF9sb2NrX3NlbShsb2NrKQlJ
R05PUkVfTE9DSyhyY3VfcmVhZF9sb2NrLCBsb2NrKQ0KICMgZGVmaW5lIHJj
dV9yZWFkX3VubG9ja19zZW0obG9jaykJSUdOT1JFX0xPQ0socmN1X3JlYWRf
dW5sb2NrLCBsb2NrKQ0KLSNlbmRpZg0KKw0KIC8qDQogICogU28gd2hlcmUg
aXMgcmN1X3dyaXRlX2xvY2soKT8gIEl0IGRvZXMgbm90IGV4aXN0LCBhcyB0
aGVyZSBpcyBubw0KICAqIHdheSBmb3Igd3JpdGVycyB0byBsb2NrIG91dCBS
Q1UgcmVhZGVycy4gIFRoaXMgaXMgYSBmZWF0dXJlLCBub3QNCmRpZmYgLU5h
dXIgLS1leGNsdWRlLWZyb20gZGlmZl9leGNsdWRlIGxpbnV4LTIuNi4xMS1m
aW5hbC1WMC43LjQwLTAwL01ha2VmaWxlIGxpbnV4LTIuNi4xMS1maW5hbC1W
MC43LjQwLTAwLVJDVS9NYWtlZmlsZQ0KLS0tIGxpbnV4LTIuNi4xMS1maW5h
bC1WMC43LjQwLTAwL01ha2VmaWxlCTIwMDUtMDMtMTEgMjM6NDA6MTMuMDAw
MDAwMDAwICswMTAwDQorKysgbGludXgtMi42LjExLWZpbmFsLVYwLjcuNDAt
MDAtUkNVL01ha2VmaWxlCTIwMDUtMDMtMTkgMTI6NDE6MDkuMDAwMDAwMDAw
ICswMTAwDQpAQCAtMSw3ICsxLDcgQEANCiBWRVJTSU9OID0gMg0KIFBBVENI
TEVWRUwgPSA2DQogU1VCTEVWRUwgPSAxMQ0KLUVYVFJBVkVSU0lPTiA9IC1S
VC1WMC43LjQwLTAwDQorRVhUUkFWRVJTSU9OID0gLVJULVYwLjcuNDAtMDAt
UkNVDQogTkFNRT1Xb296eSBOdW1iYXQNCiANCiAjICpET0NVTUVOVEFUSU9O
Kg0K
--0-154843471-1111325357=:5287--
