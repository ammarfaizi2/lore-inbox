Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316747AbSF0BSN>; Wed, 26 Jun 2002 21:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316751AbSF0BSN>; Wed, 26 Jun 2002 21:18:13 -0400
Received: from dc-mx08.cluster1.charter.net ([209.225.8.18]:932 "EHLO
	dc-mx08.cluster1.charter.net") by vger.kernel.org with ESMTP
	id <S316747AbSF0BSK>; Wed, 26 Jun 2002 21:18:10 -0400
From: Cory Watson <gphat@cafes.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Add KERN_* constants to printk()s
Date: Wed, 26 Jun 2002 20:19:06 -0500
X-Mailer: KMail [version 1.3.2]
Cc: torvalds@transmeta.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_UNBCPFVV12FIIJDRG9XQ"
Message-ID: <auto-000059811429@dc-mx08.cluster1.charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_UNBCPFVV12FIIJDRG9XQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

>From Kernel-Janitor todo, make sure printk() calls have the appropriate 
KERN_* constant.  These are only from the kernel/ subdir.

Some of these might be off by a level, but I gave them the level that looked 
appropriate.  If this is accepted, I'll do more of them.  This is a good 
excercise for newbies like myself ;)

Thanks

-- 
Cory 'G' Watson
+ Hack, lest ye rust.

diff -Nru linux-2.5.24/kernel/dma.c linux-2.5.24-g/kernel/dma.c
--- linux-2.5.24/kernel/dma.c	Sun Jun  2 21:44:43 2002
+++ linux-2.5.24-g/kernel/dma.c	Wed Jun 26 09:08:35 2002
@@ -98,12 +98,12 @@
 void free_dma(unsigned int dmanr)
 {
 	if (dmanr >= MAX_DMA_CHANNELS) {
-		printk("Trying to free DMA%d\n", dmanr);
+		printk(KERN_WARNING "Trying to free DMA%d\n", dmanr);
 		return;
 	}
 
 	if (xchg(&dma_chan_busy[dmanr].lock, 0) == 0) {
-		printk("Trying to free free DMA%d\n", dmanr);
+		printk(KERN_WARNING "Trying to free free DMA%d\n", dmanr);
 		return;
 	}	
 
diff -Nru linux-2.5.24/kernel/panic.c linux-2.5.24-g/kernel/panic.c
--- linux-2.5.24/kernel/panic.c	Sun Jun  2 21:44:47 2002
+++ linux-2.5.24-g/kernel/panic.c	Wed Jun 26 08:57:42 2002
@@ -88,7 +88,7 @@
 		extern int stop_a_enabled;
 		/* Make sure the user can actually press L1-A */
 		stop_a_enabled = 1;
-		printk("Press L1-A to return to the boot prom\n");
+		printk(KERN_EMERG "Press L1-A to return to the boot prom\n");
 	}
 #endif
 #if defined(CONFIG_ARCH_S390)
diff -Nru linux-2.5.24/kernel/resource.c linux-2.5.24-g/kernel/resource.c
--- linux-2.5.24/kernel/resource.c	Sun Jun  2 21:44:51 2002
+++ linux-2.5.24-g/kernel/resource.c	Wed Jun 26 09:08:41 2002
@@ -290,7 +290,7 @@
 		}
 		p = &res->sibling;
 	}
-	printk("Trying to free nonexistent resource <%08lx-%08lx>\n", start, end);
+	printk(KERN_WARNING "Trying to free nonexistent resource <%08lx-%08lx>\n", 
start, end);
 }
 
 /*
diff -Nru linux-2.5.24/kernel/signal.c linux-2.5.24-g/kernel/signal.c
--- linux-2.5.24/kernel/signal.c	Wed Jun 26 09:03:40 2002
+++ linux-2.5.24-g/kernel/signal.c	Wed Jun 26 09:00:35 2002
@@ -270,7 +270,7 @@
 	int sig = 0;
 
 #if DEBUG_SIG
-printk("SIG dequeue (%s:%d): %d ", current->comm, current->pid,
+printk(KERN_DEBUG "SIG dequeue (%s:%d): %d ", current->comm, current->pid,
 	signal_pending(current));
 #endif
 
@@ -294,7 +294,7 @@
 	recalc_sigpending();
 
 #if DEBUG_SIG
-printk(" %d -> %d\n", signal_pending(current), sig);
+printk(KERN_DEBUG " %d -> %d\n", signal_pending(current), sig);
 #endif
 
 	return sig;
@@ -538,7 +538,7 @@
 
 
 #if DEBUG_SIG
-printk("SIG queue (%s:%d): %d ", t->comm, t->pid, sig);
+printk(KERN_DEBUG "SIG queue (%s:%d): %d ", t->comm, t->pid, sig);
 #endif
 
 	ret = -EINVAL;
@@ -576,7 +576,7 @@
 	spin_unlock_irqrestore(&t->sigmask_lock, flags);
 out_nolock:
 #if DEBUG_SIG
-printk(" %d -> %d\n", signal_pending(t), ret);
+printk(KERN_DEBUG " %d -> %d\n", signal_pending(t), ret);
 #endif
 
 	return ret;
diff -Nru linux-2.5.24/kernel/softirq.c linux-2.5.24-g/kernel/softirq.c
--- linux-2.5.24/kernel/softirq.c	Wed Jun 26 09:03:40 2002
+++ linux-2.5.24-g/kernel/softirq.c	Wed Jun 26 08:51:51 2002
@@ -259,7 +259,7 @@
 void tasklet_kill(struct tasklet_struct *t)
 {
 	if (in_interrupt())
-		printk("Attempt to kill tasklet from interrupt\n");
+		printk(KERN_WARNING "Attempt to kill tasklet from interrupt\n");
 
 	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
 		current->state = TASK_RUNNING;
@@ -407,7 +407,7 @@
 			continue;
 		if (kernel_thread(ksoftirqd, (void *) (long) cpu,
 				  CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0)
-			printk("spawn_ksoftirqd() failed for cpu %d\n", cpu);
+			printk(KERN_WARNING "spawn_ksoftirqd() failed for cpu %d\n", cpu);
 		else
 			while (!ksoftirqd_task(cpu))
 				yield();
diff -Nru linux-2.5.24/kernel/suspend.c linux-2.5.24-g/kernel/suspend.c
--- linux-2.5.24/kernel/suspend.c	Wed Jun 26 09:03:33 2002
+++ linux-2.5.24-g/kernel/suspend.c	Wed Jun 26 08:48:18 2002
@@ -335,7 +335,7 @@
 		  	memcpy(cur->swh.magic.magic,"SWAP-SPACE",10);
 		else if (!memcmp("SUSP2R",cur->swh.magic.magic,6))
 			memcpy(cur->swh.magic.magic,"SWAPSPACE2",10);
-		else printk("%sUnable to find suspended-data signature (%.10s - 
misspelled?\n", 
+		else printk(KERN_WARNING "%sUnable to find suspended-data signature (%.10s 
- misspelled?\n", 
 		      	name_resume, cur->swh.magic.magic);
 	} else {
 	  	if ((!memcmp("SWAP-SPACE",cur->swh.magic.magic,10)))
diff -Nru linux-2.5.24/kernel/timer.c linux-2.5.24-g/kernel/timer.c
--- linux-2.5.24/kernel/timer.c	Wed Jun 26 09:03:40 2002
+++ linux-2.5.24-g/kernel/timer.c	Wed Jun 26 08:46:09 2002
@@ -194,7 +194,7 @@
 	return;
 bug:
 	spin_unlock_irqrestore(&timerlist_lock, flags);
-	printk("bug: kernel timer added twice at %p.\n",
+	printk(KERN_ERR "bug: kernel timer added twice at %p.\n",
 			__builtin_return_address(0));
 }


--------------Boundary-00=_UNBCPFVV12FIIJDRG9XQ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="printk-KERN-constants.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="printk-KERN-constants.patch"

ZGlmZiAtTnJ1IGxpbnV4LTIuNS4yNC9rZXJuZWwvZG1hLmMgbGludXgtMi41LjI0LWcva2VybmVs
L2RtYS5jCi0tLSBsaW51eC0yLjUuMjQva2VybmVsL2RtYS5jCVN1biBKdW4gIDIgMjE6NDQ6NDMg
MjAwMgorKysgbGludXgtMi41LjI0LWcva2VybmVsL2RtYS5jCVdlZCBKdW4gMjYgMDk6MDg6MzUg
MjAwMgpAQCAtOTgsMTIgKzk4LDEyIEBACiB2b2lkIGZyZWVfZG1hKHVuc2lnbmVkIGludCBkbWFu
cikKIHsKIAlpZiAoZG1hbnIgPj0gTUFYX0RNQV9DSEFOTkVMUykgewotCQlwcmludGsoIlRyeWlu
ZyB0byBmcmVlIERNQSVkXG4iLCBkbWFucik7CisJCXByaW50ayhLRVJOX1dBUk5JTkcgIlRyeWlu
ZyB0byBmcmVlIERNQSVkXG4iLCBkbWFucik7CiAJCXJldHVybjsKIAl9CiAKIAlpZiAoeGNoZygm
ZG1hX2NoYW5fYnVzeVtkbWFucl0ubG9jaywgMCkgPT0gMCkgewotCQlwcmludGsoIlRyeWluZyB0
byBmcmVlIGZyZWUgRE1BJWRcbiIsIGRtYW5yKTsKKwkJcHJpbnRrKEtFUk5fV0FSTklORyAiVHJ5
aW5nIHRvIGZyZWUgZnJlZSBETUElZFxuIiwgZG1hbnIpOwogCQlyZXR1cm47CiAJfQkKIApkaWZm
IC1OcnUgbGludXgtMi41LjI0L2tlcm5lbC9wYW5pYy5jIGxpbnV4LTIuNS4yNC1nL2tlcm5lbC9w
YW5pYy5jCi0tLSBsaW51eC0yLjUuMjQva2VybmVsL3BhbmljLmMJU3VuIEp1biAgMiAyMTo0NDo0
NyAyMDAyCisrKyBsaW51eC0yLjUuMjQtZy9rZXJuZWwvcGFuaWMuYwlXZWQgSnVuIDI2IDA4OjU3
OjQyIDIwMDIKQEAgLTg4LDcgKzg4LDcgQEAKIAkJZXh0ZXJuIGludCBzdG9wX2FfZW5hYmxlZDsK
IAkJLyogTWFrZSBzdXJlIHRoZSB1c2VyIGNhbiBhY3R1YWxseSBwcmVzcyBMMS1BICovCiAJCXN0
b3BfYV9lbmFibGVkID0gMTsKLQkJcHJpbnRrKCJQcmVzcyBMMS1BIHRvIHJldHVybiB0byB0aGUg
Ym9vdCBwcm9tXG4iKTsKKwkJcHJpbnRrKEtFUk5fRU1FUkcgIlByZXNzIEwxLUEgdG8gcmV0dXJu
IHRvIHRoZSBib290IHByb21cbiIpOwogCX0KICNlbmRpZgogI2lmIGRlZmluZWQoQ09ORklHX0FS
Q0hfUzM5MCkKZGlmZiAtTnJ1IGxpbnV4LTIuNS4yNC9rZXJuZWwvcmVzb3VyY2UuYyBsaW51eC0y
LjUuMjQtZy9rZXJuZWwvcmVzb3VyY2UuYwotLS0gbGludXgtMi41LjI0L2tlcm5lbC9yZXNvdXJj
ZS5jCVN1biBKdW4gIDIgMjE6NDQ6NTEgMjAwMgorKysgbGludXgtMi41LjI0LWcva2VybmVsL3Jl
c291cmNlLmMJV2VkIEp1biAyNiAwOTowODo0MSAyMDAyCkBAIC0yOTAsNyArMjkwLDcgQEAKIAkJ
fQogCQlwID0gJnJlcy0+c2libGluZzsKIAl9Ci0JcHJpbnRrKCJUcnlpbmcgdG8gZnJlZSBub25l
eGlzdGVudCByZXNvdXJjZSA8JTA4bHgtJTA4bHg+XG4iLCBzdGFydCwgZW5kKTsKKwlwcmludGso
S0VSTl9XQVJOSU5HICJUcnlpbmcgdG8gZnJlZSBub25leGlzdGVudCByZXNvdXJjZSA8JTA4bHgt
JTA4bHg+XG4iLCBzdGFydCwgZW5kKTsKIH0KIAogLyoKZGlmZiAtTnJ1IGxpbnV4LTIuNS4yNC9r
ZXJuZWwvc2lnbmFsLmMgbGludXgtMi41LjI0LWcva2VybmVsL3NpZ25hbC5jCi0tLSBsaW51eC0y
LjUuMjQva2VybmVsL3NpZ25hbC5jCVdlZCBKdW4gMjYgMDk6MDM6NDAgMjAwMgorKysgbGludXgt
Mi41LjI0LWcva2VybmVsL3NpZ25hbC5jCVdlZCBKdW4gMjYgMDk6MDA6MzUgMjAwMgpAQCAtMjcw
LDcgKzI3MCw3IEBACiAJaW50IHNpZyA9IDA7CiAKICNpZiBERUJVR19TSUcKLXByaW50aygiU0lH
IGRlcXVldWUgKCVzOiVkKTogJWQgIiwgY3VycmVudC0+Y29tbSwgY3VycmVudC0+cGlkLAorcHJp
bnRrKEtFUk5fREVCVUcgIlNJRyBkZXF1ZXVlICglczolZCk6ICVkICIsIGN1cnJlbnQtPmNvbW0s
IGN1cnJlbnQtPnBpZCwKIAlzaWduYWxfcGVuZGluZyhjdXJyZW50KSk7CiAjZW5kaWYKIApAQCAt
Mjk0LDcgKzI5NCw3IEBACiAJcmVjYWxjX3NpZ3BlbmRpbmcoKTsKIAogI2lmIERFQlVHX1NJRwot
cHJpbnRrKCIgJWQgLT4gJWRcbiIsIHNpZ25hbF9wZW5kaW5nKGN1cnJlbnQpLCBzaWcpOworcHJp
bnRrKEtFUk5fREVCVUcgIiAlZCAtPiAlZFxuIiwgc2lnbmFsX3BlbmRpbmcoY3VycmVudCksIHNp
Zyk7CiAjZW5kaWYKIAogCXJldHVybiBzaWc7CkBAIC01MzgsNyArNTM4LDcgQEAKIAogCiAjaWYg
REVCVUdfU0lHCi1wcmludGsoIlNJRyBxdWV1ZSAoJXM6JWQpOiAlZCAiLCB0LT5jb21tLCB0LT5w
aWQsIHNpZyk7CitwcmludGsoS0VSTl9ERUJVRyAiU0lHIHF1ZXVlICglczolZCk6ICVkICIsIHQt
PmNvbW0sIHQtPnBpZCwgc2lnKTsKICNlbmRpZgogCiAJcmV0ID0gLUVJTlZBTDsKQEAgLTU3Niw3
ICs1NzYsNyBAQAogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnQtPnNpZ21hc2tfbG9jaywgZmxh
Z3MpOwogb3V0X25vbG9jazoKICNpZiBERUJVR19TSUcKLXByaW50aygiICVkIC0+ICVkXG4iLCBz
aWduYWxfcGVuZGluZyh0KSwgcmV0KTsKK3ByaW50ayhLRVJOX0RFQlVHICIgJWQgLT4gJWRcbiIs
IHNpZ25hbF9wZW5kaW5nKHQpLCByZXQpOwogI2VuZGlmCiAKIAlyZXR1cm4gcmV0OwpkaWZmIC1O
cnUgbGludXgtMi41LjI0L2tlcm5lbC9zb2Z0aXJxLmMgbGludXgtMi41LjI0LWcva2VybmVsL3Nv
ZnRpcnEuYwotLS0gbGludXgtMi41LjI0L2tlcm5lbC9zb2Z0aXJxLmMJV2VkIEp1biAyNiAwOTow
Mzo0MCAyMDAyCisrKyBsaW51eC0yLjUuMjQtZy9rZXJuZWwvc29mdGlycS5jCVdlZCBKdW4gMjYg
MDg6NTE6NTEgMjAwMgpAQCAtMjU5LDcgKzI1OSw3IEBACiB2b2lkIHRhc2tsZXRfa2lsbChzdHJ1
Y3QgdGFza2xldF9zdHJ1Y3QgKnQpCiB7CiAJaWYgKGluX2ludGVycnVwdCgpKQotCQlwcmludGso
IkF0dGVtcHQgdG8ga2lsbCB0YXNrbGV0IGZyb20gaW50ZXJydXB0XG4iKTsKKwkJcHJpbnRrKEtF
Uk5fV0FSTklORyAiQXR0ZW1wdCB0byBraWxsIHRhc2tsZXQgZnJvbSBpbnRlcnJ1cHRcbiIpOwog
CiAJd2hpbGUgKHRlc3RfYW5kX3NldF9iaXQoVEFTS0xFVF9TVEFURV9TQ0hFRCwgJnQtPnN0YXRl
KSkgewogCQljdXJyZW50LT5zdGF0ZSA9IFRBU0tfUlVOTklORzsKQEAgLTQwNyw3ICs0MDcsNyBA
QAogCQkJY29udGludWU7CiAJCWlmIChrZXJuZWxfdGhyZWFkKGtzb2Z0aXJxZCwgKHZvaWQgKikg
KGxvbmcpIGNwdSwKIAkJCQkgIENMT05FX0ZTIHwgQ0xPTkVfRklMRVMgfCBDTE9ORV9TSUdOQUwp
IDwgMCkKLQkJCXByaW50aygic3Bhd25fa3NvZnRpcnFkKCkgZmFpbGVkIGZvciBjcHUgJWRcbiIs
IGNwdSk7CisJCQlwcmludGsoS0VSTl9XQVJOSU5HICJzcGF3bl9rc29mdGlycWQoKSBmYWlsZWQg
Zm9yIGNwdSAlZFxuIiwgY3B1KTsKIAkJZWxzZQogCQkJd2hpbGUgKCFrc29mdGlycWRfdGFzayhj
cHUpKQogCQkJCXlpZWxkKCk7CmRpZmYgLU5ydSBsaW51eC0yLjUuMjQva2VybmVsL3N1c3BlbmQu
YyBsaW51eC0yLjUuMjQtZy9rZXJuZWwvc3VzcGVuZC5jCi0tLSBsaW51eC0yLjUuMjQva2VybmVs
L3N1c3BlbmQuYwlXZWQgSnVuIDI2IDA5OjAzOjMzIDIwMDIKKysrIGxpbnV4LTIuNS4yNC1nL2tl
cm5lbC9zdXNwZW5kLmMJV2VkIEp1biAyNiAwODo0ODoxOCAyMDAyCkBAIC0zMzUsNyArMzM1LDcg
QEAKIAkJICAJbWVtY3B5KGN1ci0+c3doLm1hZ2ljLm1hZ2ljLCJTV0FQLVNQQUNFIiwxMCk7CiAJ
CWVsc2UgaWYgKCFtZW1jbXAoIlNVU1AyUiIsY3VyLT5zd2gubWFnaWMubWFnaWMsNikpCiAJCQlt
ZW1jcHkoY3VyLT5zd2gubWFnaWMubWFnaWMsIlNXQVBTUEFDRTIiLDEwKTsKLQkJZWxzZSBwcmlu
dGsoIiVzVW5hYmxlIHRvIGZpbmQgc3VzcGVuZGVkLWRhdGEgc2lnbmF0dXJlICglLjEwcyAtIG1p
c3NwZWxsZWQ/XG4iLCAKKwkJZWxzZSBwcmludGsoS0VSTl9XQVJOSU5HICIlc1VuYWJsZSB0byBm
aW5kIHN1c3BlbmRlZC1kYXRhIHNpZ25hdHVyZSAoJS4xMHMgLSBtaXNzcGVsbGVkP1xuIiwgCiAJ
CSAgICAgIAluYW1lX3Jlc3VtZSwgY3VyLT5zd2gubWFnaWMubWFnaWMpOwogCX0gZWxzZSB7CiAJ
ICAJaWYgKCghbWVtY21wKCJTV0FQLVNQQUNFIixjdXItPnN3aC5tYWdpYy5tYWdpYywxMCkpKQpk
aWZmIC1OcnUgbGludXgtMi41LjI0L2tlcm5lbC90aW1lci5jIGxpbnV4LTIuNS4yNC1nL2tlcm5l
bC90aW1lci5jCi0tLSBsaW51eC0yLjUuMjQva2VybmVsL3RpbWVyLmMJV2VkIEp1biAyNiAwOTow
Mzo0MCAyMDAyCisrKyBsaW51eC0yLjUuMjQtZy9rZXJuZWwvdGltZXIuYwlXZWQgSnVuIDI2IDA4
OjQ2OjA5IDIwMDIKQEAgLTE5NCw3ICsxOTQsNyBAQAogCXJldHVybjsKIGJ1ZzoKIAlzcGluX3Vu
bG9ja19pcnFyZXN0b3JlKCZ0aW1lcmxpc3RfbG9jaywgZmxhZ3MpOwotCXByaW50aygiYnVnOiBr
ZXJuZWwgdGltZXIgYWRkZWQgdHdpY2UgYXQgJXAuXG4iLAorCXByaW50ayhLRVJOX0VSUiAiYnVn
OiBrZXJuZWwgdGltZXIgYWRkZWQgdHdpY2UgYXQgJXAuXG4iLAogCQkJX19idWlsdGluX3JldHVy
bl9hZGRyZXNzKDApKTsKIH0KIAo=

--------------Boundary-00=_UNBCPFVV12FIIJDRG9XQ--
