Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311121AbSEMKMh>; Mon, 13 May 2002 06:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311180AbSEMKMg>; Mon, 13 May 2002 06:12:36 -0400
Received: from web10406.mail.yahoo.com ([216.136.130.98]:25107 "HELO
	web10406.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S311121AbSEMKMe>; Mon, 13 May 2002 06:12:34 -0400
Message-ID: <20020513101234.7076.qmail@web10406.mail.yahoo.com>
Date: Mon, 13 May 2002 03:12:34 -0700 (PDT)
From: "D.J. Barrow" <barrow_dj@yahoo.com>
Subject: Mips scalibility problems & softirq.c improvments
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Netfilter <netfilter-devel@lists.samba.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2015820736-1021284754=:4869"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-2015820736-1021284754=:4869
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
While testing the SMP performance of iptables with a lot of rules on a mips based cpu,
I found that the SMP performance was 40% lower on 2 cpus than 1 cpu.

There is a number of reasons for this the primary being that the rules were bigger
than the shared L2 cache, little enough can be done about this.

The second is that interrupts are on every mips port I bothered checking
are only delivered on cpu 0 ( this is really pathetic ).


See the code that prints /proc/interrupts in arch/mips/kernel/irq.c
int get_irq_list(char *buf)
{
	struct irqaction * action;
	char *p = buf;
	int i;

	p += sprintf(p, "           ");
	for (i=0; i < 1 /*smp_num_cpus*/; i++)

Need I say more.....

As softirqs are usually bound to the same
cpu that start the softirqs softirqs performs really really badly,
also the fact that the softirq.c code checks in_interrupt on
entry means that it frequently does a quick exit.


I also will be providing a patch I developed to the developers of a mips based
system on chip which distributes the irqs over all cpus using 2 polices
even interrupts to cpu 0 odd interrupts to cpu 1 or leaving the interrupts
enter in all cpus & only call do_IRQ on the cpu with the lowest local_irq_count
 & local_bh_count this should cause softirqs to perform will on this
system anyway.


I've provided a small patch to irq.c which fixes /proc/interrupts in 2.4.18 mips32
hopefully somebody will be kind enough to fix up the 64 bit &
the latest stuff in mips64 & the latest oss.sgi.com cvs trees.

--- linux.orig/arch/mips/kernel/irq.c   Sun Sep  9 18:43:01 2001
+++ linux/arch/mips/kernel/irq.c        Mon May 13 10:34:15 2002
@@ -71,13 +71,13 @@

 int get_irq_list(char *buf)
 {
+       int i, j;
        struct irqaction * action;
        char *p = buf;
-       int i;

        p += sprintf(p, "           ");
-       for (i=0; i < 1 /*smp_num_cpus*/; i++)
-               p += sprintf(p, "CPU%d       ", i);
+       for (j=0; j<smp_num_cpus; j++)
+               p += sprintf(p, "CPU%d       ",j);
        *p++ = '\n';

        for (i = 0 ; i < NR_IRQS ; i++) {
@@ -85,7 +85,13 @@
                if (!action)
                        continue;
                p += sprintf(p, "%3d: ",i);
+#ifndef CONFIG_SMP
                p += sprintf(p, "%10u ", kstat_irqs(i));
+#else
+               for (j = 0; j < smp_num_cpus; j++)
+                       p += sprintf(p, "%10u ",
+                               kstat.irqs[cpu_logical_map(j)][i]);
+#endif
                p += sprintf(p, " %14s", irq_desc[i].handler->typename);
                p += sprintf(p, "  %s", action->name);

@@ -93,7 +99,7 @@
                        p += sprintf(p, ", %s", action->name);
                *p++ = '\n';
        }
-       p += sprintf(p, "ERR: %10lu\n", irq_err_count);
+       p += sprintf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
        return p - buf;
 }



I also provide a small patch for softirq.c which makes sure the
the softirqs stay running if in cpu_idle & no reschedule is pending.
This improves softirq.c performance a small bit as it usually exits
after calling each softirq once rather than staying in the loop
if it has nothing better to do.

--- linux.old/kernel/softirq.c  Tue Jan 15 04:13:43 2002
+++ linux.new/kernel/softirq.c  Thu May  9 12:36:46 2002
@@ -95,7 +95,8 @@
                local_irq_disable();

                pending = softirq_pending(cpu);
-               if (pending & mask) {
+               if ((pending && current==idle_task(cpu) && !current->need_resched )
+                   || (pending & mask) ) {
                        mask &= ~pending;
                        goto restart;
                }
diff -u -r linux.old/include/linux/sched.h linux.new/include/linux/sched.h
--- linux.old/include/linux/sched.h     Thu May  9 18:08:42 2002
+++ linux.new/include/linux/sched.h     Thu May  9 10:30:34 2002
@@ -936,6 +936,19 @@
        return res;
 }

+#ifdef CONFIG_SMP
+
+#define idle_task(cpu) (init_tasks[cpu_number_map(cpu)])
+#define can_schedule(p,cpu) \
+       ((p)->cpus_runnable & (p)->cpus_allowed & (1 << cpu))
+
+#else
+
+#define idle_task(cpu) (&init_task)
+#define can_schedule(p,cpu) (1)
+
+#endif
+
 #endif /* __KERNEL__ */

 #endif

diff -u -r linux.old/kernel/sched.c linux.new/kernel/sched.c
--- linux.old/kernel/sched.c    Wed May  1 10:40:26 2002
+++ linux.new/kernel/sched.c    Thu May  9 10:30:26 2002
@@ -112,18 +112,7 @@
 struct kernel_stat kstat;
 extern struct task_struct *child_reaper;

-#ifdef CONFIG_SMP

-#define idle_task(cpu) (init_tasks[cpu_number_map(cpu)])
-#define can_schedule(p,cpu) \
-       ((p)->cpus_runnable & (p)->cpus_allowed & (1 << cpu))
-
-#else
-
-#define idle_task(cpu) (&init_task)
-#define can_schedule(p,cpu) (1)
-
-#endif

 void scheduling_functions_start_here(void) { }


Also find the patches sent as attachments.


=====
D.J. Barrow Linux kernel developer
eMail: dj_barrow@ariasoft.ie 
Home: +353-22-47196.
Work: +353-91-758353

__________________________________________________
Do You Yahoo!?
LAUNCH - Your Yahoo! Music Experience
http://launch.yahoo.com
--0-2015820736-1021284754=:4869
Content-Type: application/x-unknown; name="softirq_fix.diff"
Content-Transfer-Encoding: base64
Content-Description: softirq_fix.diff
Content-Disposition: attachment; filename="softirq_fix.diff"

LS0tIGxpbnV4Lm9sZC9rZXJuZWwvc29mdGlycS5jCVR1ZSBKYW4gMTUgMDQ6
MTM6NDMgMjAwMgorKysgbGludXgubmV3L2tlcm5lbC9zb2Z0aXJxLmMJVGh1
IE1heSAgOSAxMjozNjo0NiAyMDAyCkBAIC05NSw3ICs5NSw4IEBACiAJCWxv
Y2FsX2lycV9kaXNhYmxlKCk7CiAKIAkJcGVuZGluZyA9IHNvZnRpcnFfcGVu
ZGluZyhjcHUpOwotCQlpZiAocGVuZGluZyAmIG1hc2spIHsKKwkJaWYgKChw
ZW5kaW5nICYmIGN1cnJlbnQ9PWlkbGVfdGFzayhjcHUpICYmICFjdXJyZW50
LT5uZWVkX3Jlc2NoZWQgKQorCQkgICAgfHwgKHBlbmRpbmcgJiBtYXNrKSAp
IHsKIAkJCW1hc2sgJj0gfnBlbmRpbmc7CiAJCQlnb3RvIHJlc3RhcnQ7CiAJ
CX0KZGlmZiAtdSAtciBsaW51eC5vbGQvaW5jbHVkZS9saW51eC9zY2hlZC5o
IGxpbnV4Lm5ldy9pbmNsdWRlL2xpbnV4L3NjaGVkLmgKLS0tIGxpbnV4Lm9s
ZC9pbmNsdWRlL2xpbnV4L3NjaGVkLmgJVGh1IE1heSAgOSAxODowODo0MiAy
MDAyCisrKyBsaW51eC5uZXcvaW5jbHVkZS9saW51eC9zY2hlZC5oCVRodSBN
YXkgIDkgMTA6MzA6MzQgMjAwMgpAQCAtOTM2LDYgKzkzNiwxOSBAQAogCXJl
dHVybiByZXM7CiB9CiAKKyNpZmRlZiBDT05GSUdfU01QCisKKyNkZWZpbmUg
aWRsZV90YXNrKGNwdSkgKGluaXRfdGFza3NbY3B1X251bWJlcl9tYXAoY3B1
KV0pCisjZGVmaW5lIGNhbl9zY2hlZHVsZShwLGNwdSkgXAorCSgocCktPmNw
dXNfcnVubmFibGUgJiAocCktPmNwdXNfYWxsb3dlZCAmICgxIDw8IGNwdSkp
CisKKyNlbHNlCisKKyNkZWZpbmUgaWRsZV90YXNrKGNwdSkgKCZpbml0X3Rh
c2spCisjZGVmaW5lIGNhbl9zY2hlZHVsZShwLGNwdSkgKDEpCisKKyNlbmRp
ZgorCiAjZW5kaWYgLyogX19LRVJORUxfXyAqLwogCiAjZW5kaWYKCmRpZmYg
LXUgLXIgbGludXgub2xkL2tlcm5lbC9zY2hlZC5jIGxpbnV4Lm5ldy9rZXJu
ZWwvc2NoZWQuYwotLS0gbGludXgub2xkL2tlcm5lbC9zY2hlZC5jCVdlZCBN
YXkgIDEgMTA6NDA6MjYgMjAwMgorKysgbGludXgubmV3L2tlcm5lbC9zY2hl
ZC5jCVRodSBNYXkgIDkgMTA6MzA6MjYgMjAwMgpAQCAtMTEyLDE4ICsxMTIs
NyBAQAogc3RydWN0IGtlcm5lbF9zdGF0IGtzdGF0OwogZXh0ZXJuIHN0cnVj
dCB0YXNrX3N0cnVjdCAqY2hpbGRfcmVhcGVyOwogCi0jaWZkZWYgQ09ORklH
X1NNUAogCi0jZGVmaW5lIGlkbGVfdGFzayhjcHUpIChpbml0X3Rhc2tzW2Nw
dV9udW1iZXJfbWFwKGNwdSldKQotI2RlZmluZSBjYW5fc2NoZWR1bGUocCxj
cHUpIFwKLQkoKHApLT5jcHVzX3J1bm5hYmxlICYgKHApLT5jcHVzX2FsbG93
ZWQgJiAoMSA8PCBjcHUpKQotCi0jZWxzZQotCi0jZGVmaW5lIGlkbGVfdGFz
ayhjcHUpICgmaW5pdF90YXNrKQotI2RlZmluZSBjYW5fc2NoZWR1bGUocCxj
cHUpICgxKQotCi0jZW5kaWYKIAogdm9pZCBzY2hlZHVsaW5nX2Z1bmN0aW9u
c19zdGFydF9oZXJlKHZvaWQpIHsgfQoKCgoKCgoKCg==

--0-2015820736-1021284754=:4869
Content-Type: application/x-unknown; name="mips32_irq.c_fix.diff"
Content-Transfer-Encoding: base64
Content-Description: mips32_irq.c_fix.diff
Content-Disposition: attachment; filename="mips32_irq.c_fix.diff"

LS0tIGxpbnV4Lm9yaWcvYXJjaC9taXBzL2tlcm5lbC9pcnEuYwlTdW4gU2Vw
ICA5IDE4OjQzOjAxIDIwMDEKKysrIGxpbnV4L2FyY2gvbWlwcy9rZXJuZWwv
aXJxLmMJTW9uIE1heSAxMyAxMDozNDoxNSAyMDAyCkBAIC03MSwxMyArNzEs
MTMgQEAKIAogaW50IGdldF9pcnFfbGlzdChjaGFyICpidWYpCiB7CisJaW50
IGksIGo7CiAJc3RydWN0IGlycWFjdGlvbiAqIGFjdGlvbjsKIAljaGFyICpw
ID0gYnVmOwotCWludCBpOwogCiAJcCArPSBzcHJpbnRmKHAsICIgICAgICAg
ICAgICIpOwotCWZvciAoaT0wOyBpIDwgMSAvKnNtcF9udW1fY3B1cyovOyBp
KyspCi0JCXAgKz0gc3ByaW50ZihwLCAiQ1BVJWQgICAgICAgIiwgaSk7CisJ
Zm9yIChqPTA7IGo8c21wX251bV9jcHVzOyBqKyspCisJCXAgKz0gc3ByaW50
ZihwLCAiQ1BVJWQgICAgICAgIixqKTsKIAkqcCsrID0gJ1xuJzsKIAogCWZv
ciAoaSA9IDAgOyBpIDwgTlJfSVJRUyA7IGkrKykgewpAQCAtODUsNyArODUs
MTMgQEAKIAkJaWYgKCFhY3Rpb24pIAogCQkJY29udGludWU7CiAJCXAgKz0g
c3ByaW50ZihwLCAiJTNkOiAiLGkpOworI2lmbmRlZiBDT05GSUdfU01QCiAJ
CXAgKz0gc3ByaW50ZihwLCAiJTEwdSAiLCBrc3RhdF9pcnFzKGkpKTsKKyNl
bHNlCisJCWZvciAoaiA9IDA7IGogPCBzbXBfbnVtX2NwdXM7IGorKykKKwkJ
CXAgKz0gc3ByaW50ZihwLCAiJTEwdSAiLAorCQkJCWtzdGF0LmlycXNbY3B1
X2xvZ2ljYWxfbWFwKGopXVtpXSk7CisjZW5kaWYKIAkJcCArPSBzcHJpbnRm
KHAsICIgJTE0cyIsIGlycV9kZXNjW2ldLmhhbmRsZXItPnR5cGVuYW1lKTsK
IAkJcCArPSBzcHJpbnRmKHAsICIgICVzIiwgYWN0aW9uLT5uYW1lKTsKIApA
QCAtOTMsNyArOTksNyBAQAogCQkJcCArPSBzcHJpbnRmKHAsICIsICVzIiwg
YWN0aW9uLT5uYW1lKTsKIAkJKnArKyA9ICdcbic7CiAJfQotCXAgKz0gc3By
aW50ZihwLCAiRVJSOiAlMTBsdVxuIiwgaXJxX2Vycl9jb3VudCk7CisJcCAr
PSBzcHJpbnRmKHAsICJFUlI6ICUxMHVcbiIsIGF0b21pY19yZWFkKCZpcnFf
ZXJyX2NvdW50KSk7CiAJcmV0dXJuIHAgLSBidWY7CiB9CiAK

--0-2015820736-1021284754=:4869--
