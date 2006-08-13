Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932638AbWHMCrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbWHMCrZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 22:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbWHMCrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 22:47:25 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:53667 "EHLO
	fmmailgate01.web.de") by vger.kernel.org with ESMTP id S932638AbWHMCrX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 22:47:23 -0400
From: Gerhard =?iso-8859-1?q?Gau=DFling?= <ggrubbish@web.de>
Reply-To: ggrubbish@web.de
To: Majordomo@vger.kernel.org
Subject: 2.6.17.8-rt8: Compile Error in module realtime-lsm/realcap.c and misdn/avm_fritz.c - error: syntax error before string constant
Date: Sun, 13 Aug 2006 04:39:39 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608130439.42751.ggrubbish@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm not a programmer at all, but I tried to compile a new kernel due to 
needed realtime capabilities for JACK audio server, though.

I followed mainly this howto 
http://ubuntustudio.com/wiki/index.php/Dapper:Vanilla_Kernel_With_Realtime_Preemption

But I ran into problems with the needed rt patch of Ingo Molnar: 
http://people.redhat.com/mingo/realtime-preempt/patch-2.6.17-rt8

It failed on the 2.6.17.8 in 1 chunk on the Makefile and 1 chunk of 
kernel/sched.c .

Therefore I searched the mentioned first lines, and did it by 'hand' :-(

=================
This is what I changed in Makefile:
=================

EXTRAVERSION = .8-rt8

=================
This is what I did in kernel/sched.c:
=================

   4763
   4764 /*
   4765  * cond_resched_lock() - if a reschedule is pending, drop the 
given lock,
   4766  * call schedule, and on return reacquire the lock.
   4767  *
   4768  * This works OK both with and without CONFIG_PREEMPT.  We do 
strange low-level
   4769  * operations here to prevent schedule() from being called twice 
(once via
   4770  *    * spin_unlock(), once by hand).
   4771  *       */
   4772  int __cond_resched_raw_spinlock(raw_spinlock_t *lock)
   4773   {
   4774         int ret = 0;
   4775
   4776         if (need_lockbreak_raw(lock)) {
   4777                 spin_unlock(lock);
   4778                 cpu_relax();
   4779                 spin_lock(lock);
   4780                 ret = 1;
   4781         }
   4782         if (need_resched()) {
   4783                 spin_unlock_no_resched(lock);
   4784                 __cond_resched();
   4785                 spin_lock(lock);
   4786                 ret = 1;
   4787         }
   4788         return ret;
   4789   }
   4790
   4791  EXPORT_SYMBOL(__cond_resched_raw_spinlock);
   4792
   4793  #ifdef CONFIG_PREEMPT_RT
   4794
   4795  int __cond_resched_spinlock(spinlock_t *lock)
   4796  {
   4797  #if (defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)) || 
defined(CONFIG_PREEMPT_RT)
   4798         if (lock->break_lock) {
   4799                 lock->break_lock = 0;
   4800                 _spin_unlock(lock);
   4801                 __cond_resched();
   4802                 _spin_lock(lock);
   4803                 return 1;
   4804         }
   4805 #endif
   4806         return 0;
   4807  }
   4808
   4809  EXPORT_SYMBOL(__cond_resched_spinlock);
   4810
   4811  #endif
   4812
   4813
   4814  /*
   4815   * Preempt a softirq context if necessary:
   4816   */
   4817   int __sched cond_resched_softirq(void)
   4818   {
   4819  #ifndef CONFIG_PREEMPT_RT
   4820         BUG_ON(!in_softirq());
   4821
   4822         if (softirq_need_resched()) {
   4823                 __local_bh_enable();
   4824                 __cond_resched();
   4825                 local_bh_disable();
   4826                 return 1;
   4827         }
   4828  #endif
   4829         return 0;
   4830  }
   4831
   4832  EXPORT_SYMBOL(cond_resched_softirq);
   4833
   4834  /*
   4835   * Preempt a hardirq context if necessary:
   4836   */
   4837  int cond_resched_hardirq(void)
   4838  {
   4839         BUG_ON(!in_irq());
   4840
   4841         if (hardirq_need_resched()) {
   4842                 irq_exit();
   4843                 __cond_resched();
   4844                 irq_enter();
   4845                 return 1;
   4846         }
   4847         return 0;
   4848  }
   4849
   4850  EXPORT_SYMBOL(cond_resched_hardirq);
   4851
   4852  /*
   4853   * Preempt any context:
   4854   */
   4855  int cond_resched_all(void)
   4856  {
   4857         if (hardirq_count())
   4858                 return cond_resched_hardirq();
   4859         if (softirq_count())
   4860                 return cond_resched_softirq();
   4861         return cond_resched();
   4862  }
   4863
   4864  EXPORT_SYMBOL(cond_resched_all);
   4865
   4866  #ifdef CONFIG_PREEMPT_VOLUNTARY
   4867
   4868  int voluntary_preemption = 1;
   4869
   4870  EXPORT_SYMBOL(voluntary_preemption);
   4871
   4872  static int __init voluntary_preempt_setup (char *str)
   4873  {
   4874         if (!strncmp(str, "off", 3))
   4875                 voluntary_preemption = 0;
   4876         else
   4877                 get_option(&str, &voluntary_preemption);
   4878         if (!voluntary_preemption)
   4879                 printk("turning off voluntary preemption!\n");
   4880
   4881         return 1;
   4882  }
   4883
   4884  __setup("voluntary-preempt=", voluntary_preempt_setup);
   4885
   4886  #endif
   4887
   4888  /**
   4889  *    * yield - yield the current processor to other threads.
   4890  *
   4891  *
   4892  * this is a shortcut for kernel-space yielding - it marks the
   4893  * thread runnable and calls sys_sched_yield().
   4894  */

====================
diff -u format kernel/sched.c
====================

root@ubuntu:/usr/src/linux # diff -u  ../../sched.c.old  kernel/sched.c
--- ../../sched.c.old   2006-08-12 19:01:20.000000000 +0200
+++ kernel/sched.c      2006-08-12 19:21:09.000000000 +0200
@@ -4767,45 +4767,127 @@
  *
  * This works OK both with and without CONFIG_PREEMPT.  We do strange 
low-level
  * operations here to prevent schedule() from being called twice (once 
via
- * spin_unlock(), once by hand).
- */
-int cond_resched_lock(spinlock_t *lock)
-{
-       int ret = 0;
-
-       if (need_lockbreak(lock)) {
-               spin_unlock(lock);
-               cpu_relax();
+ *    * spin_unlock(), once by hand).
+ *       */
+ int __cond_resched_raw_spinlock(raw_spinlock_t *lock)
+  {
+       int ret = 0;
+
+       if (need_lockbreak_raw(lock)) {
+               spin_unlock(lock);
+               cpu_relax();
+               spin_lock(lock);
                ret = 1;
-               spin_lock(lock);
+       }
+       if (need_resched()) {
+               spin_unlock_no_resched(lock);
+               __cond_resched();
+               spin_lock(lock);
+               ret = 1;
+       }
+       return ret;
+  }
+
+ EXPORT_SYMBOL(__cond_resched_raw_spinlock);
+
+ #ifdef CONFIG_PREEMPT_RT
+
+ int __cond_resched_spinlock(spinlock_t *lock)
+ {
+ #if (defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)) || 
defined(CONFIG_PREEMPT_RT)
+       if (lock->break_lock) {
+               lock->break_lock = 0;
+               _spin_unlock(lock);
+               __cond_resched();
+               _spin_lock(lock);
+               return 1;
        }
-       if (need_resched() && __resched_legal(1)) {
-               _raw_spin_unlock(lock);
-               preempt_enable_no_resched();
-               __cond_resched();
-               ret = 1;
-               spin_lock(lock);
-       }
-       return ret;
-}
-EXPORT_SYMBOL(cond_resched_lock);
-
-int __sched cond_resched_softirq(void)
-{
-       BUG_ON(!in_softirq());
-
-       if (need_resched() && __resched_legal(0)) {
-               __local_bh_enable();
-               __cond_resched();
-               local_bh_disable();
+#endif
+       return 0;
+ }
+
+ EXPORT_SYMBOL(__cond_resched_spinlock);
+
+ #endif
+
+
+ /*
+  * Preempt a softirq context if necessary:
+  */
+  int __sched cond_resched_softirq(void)
+  {
+ #ifndef CONFIG_PREEMPT_RT
+       BUG_ON(!in_softirq());
+
+       if (softirq_need_resched()) {
+               __local_bh_enable();
+               __cond_resched();
+               local_bh_disable();
                return 1;
        }
+ #endif
+       return 0;
+ }
+
+ EXPORT_SYMBOL(cond_resched_softirq);
+
+ /*
+  * Preempt a hardirq context if necessary:
+  */
+ int cond_resched_hardirq(void)
+ {
+       BUG_ON(!in_irq());
+
+       if (hardirq_need_resched()) {
+               irq_exit();
+               __cond_resched();
+               irq_enter();
+               return 1;
+       }
        return 0;
-}
-EXPORT_SYMBOL(cond_resched_softirq);
-
-/**
- * yield - yield the current processor to other threads.
+ }
+
+ EXPORT_SYMBOL(cond_resched_hardirq);
+
+ /*
+  * Preempt any context:
+  */
+ int cond_resched_all(void)
+ {
+       if (hardirq_count())
+               return cond_resched_hardirq();
+       if (softirq_count())
+               return cond_resched_softirq();
+       return cond_resched();
+ }
+
+ EXPORT_SYMBOL(cond_resched_all);
+
+ #ifdef CONFIG_PREEMPT_VOLUNTARY
+
+ int voluntary_preemption = 1;
+
+ EXPORT_SYMBOL(voluntary_preemption);
+
+ static int __init voluntary_preempt_setup (char *str)
+ {
+       if (!strncmp(str, "off", 3))
+               voluntary_preemption = 0;
+       else
+               get_option(&str, &voluntary_preemption);
+       if (!voluntary_preemption)
+               printk("turning off voluntary preemption!\n");
+
+       return 1;
+ }
+
+ __setup("voluntary-preempt=", voluntary_preempt_setup);
+
+ #endif
+
+ /**
+ *    * yield - yield the current processor to other threads.
+ *
  *
  * this is a shortcut for kernel-space yielding - it marks the
  * thread runnable and calls sys_sched_yield().


==================
Now I get this errors on compiling the modules:
==================

make[1]: Entering directory `/usr/src/modules/realtime-lsm'
/usr/bin/make -w -f debian/rules kdist_clean kdist_config binary-modules
make[2]: Entering directory `/usr/src/modules/realtime-lsm'
dh_clean
make COMMONCAP=none clean
make[3]: Entering directory `/usr/src/modules/realtime-lsm'
rm -f *.ko *.o none
rm -f *.mod.* .*.cmd
make[3]: Leaving directory `/usr/src/modules/realtime-lsm'
/usr/bin/gcc-4.0
for templ 
in /usr/src/modules/realtime-lsm/debian/realtime-lsm-module-_KVERS_.postinst /usr/src/modules/realtime-lsm/debian/realtime-lsm-module-_KVERS_.postinst.modules.in; 
do \
    cp $templ `echo $templ | sed -e 's/_KVERS_/2.6.17.8-rt8/g'` ; \
  done
for templ in `ls debian/*.modules.in` ; do \
    test -e ${templ%.modules.in}.backup || cp ${templ%.modules.in} 
${templ%.modules.in}.backup 2>/dev/null || true; \
    sed -e 's/##KVERS##/2.6.17.8-rt8/g ;s/#KVERS#/2.6.17.8-rt8/g ; 
s/_KVERS_/2.6.17.8-rt8/g ; s/##KDREV##/1/g ; s/#KDREV#/1/g ; 
s/_KDREV_/1/g' < $templ > ${templ%.modules.in}; \
  done
dh_testdir
dh_testroot
dh_clean -k
make KERNEL_DIR=/usr/src/linux MODVERSIONS=detect 
KERNEL=linux-2.6.17.8-rt8 COMMONCAP=none
make[3]: Entering directory `/usr/src/modules/realtime-lsm'
CONFIG_SECURITY_CAPABILITIES=m
make CC=gcc-4.0 modules -C /usr/src/linux 
SUBDIRS=/usr/src/modules/realtime-lsm
make[4]: Entering directory `/usr/src/linux-2.6.17-rt8'
  CC [M]  /usr/src/modules/realtime-lsm/realcap.o
/usr/src/modules/realtime-lsm/realcap.c:1: warning: -ffunction-sections 
disabled; it makes profiling impossible
/usr/src/modules/realtime-lsm/realcap.c:36: error: syntax error before 
string constant
/usr/src/modules/realtime-lsm/realcap.c:36: warning: type defaults 
to 'int' in declaration of 'MODULE_PARM'
/usr/src/modules/realtime-lsm/realcap.c:36: warning: function 
declaration isn't a prototype
/usr/src/modules/realtime-lsm/realcap.c:36: warning: data definition has 
no type or storage class
/usr/src/modules/realtime-lsm/realcap.c:40: error: syntax error before 
string constant
/usr/src/modules/realtime-lsm/realcap.c:40: warning: type defaults 
to 'int' in declaration of 'MODULE_PARM'
/usr/src/modules/realtime-lsm/realcap.c:40: warning: function 
declaration isn't a prototype
/usr/src/modules/realtime-lsm/realcap.c:40: warning: data definition has 
no type or storage class
/usr/src/modules/realtime-lsm/realcap.c:44: error: syntax error before 
string constant
/usr/src/modules/realtime-lsm/realcap.c:44: warning: type defaults 
to 'int' in declaration of 'MODULE_PARM'
/usr/src/modules/realtime-lsm/realcap.c:44: warning: function 
declaration isn't a prototype
/usr/src/modules/realtime-lsm/realcap.c:44: warning: data definition has 
no type or storage class
/usr/src/modules/realtime-lsm/realcap.c:48: error: syntax error before 
string constant
/usr/src/modules/realtime-lsm/realcap.c:48: warning: type defaults 
to 'int' in declaration of 'MODULE_PARM'
/usr/src/modules/realtime-lsm/realcap.c:48: warning: function 
declaration isn't a prototype
/usr/src/modules/realtime-lsm/realcap.c:48: warning: data definition has 
no type or storage class
make[5]: *** [/usr/src/modules/realtime-lsm/realcap.o] Error 1
make[4]: *** [_module_/usr/src/modules/realtime-lsm] Error 2
make[4]: Leaving directory `/usr/src/linux-2.6.17-rt8'
make[3]: *** [all] Error 2
make[3]: Leaving directory `/usr/src/modules/realtime-lsm'
make[2]: *** [binary-modules] Error 2
make[2]: Leaving directory `/usr/src/modules/realtime-lsm'
make[1]: *** [kdist_build] Error 2
make[1]: Leaving directory `/usr/src/modules/realtime-lsm'
Module /usr/src/modules/realtime-lsm failed.
Hit return to Continue
[...]
make[1]: Entering directory `/usr/src/modules/misdn'
/usr/bin/make -w -f debian/rules  binary-modules
make[2]: Entering directory `/usr/src/modules/misdn'
sed -e 's/@@Kernel\-Version@@/2.6.17.8-rt8.8-rt8/' \
            debian/control.in > debian/control
dh_testdir
dh_testroot
dh_clean -k
dh_clean: Compatibility levels before 4 are deprecated.
echo "kpkg:Kernel-Version=2.6.17.8-rt8.8-rt8" > \
            debian/misdn-kernel-modules-2.6.17.8-rt8.8-rt8.substvars
/usr/bin/make -C /usr/src/linux M=/usr/src/modules/misdn   modules
make[3]: Entering directory `/usr/src/linux-2.6.17-rt8'
  CC [M]  /usr/src/modules/misdn/avm_fritz.o
/usr/src/modules/misdn/avm_fritz.c:1: warning: -ffunction-sections 
disabled; it makes profiling impossible
In file included from /usr/src/modules/misdn/avm_fritz.c:24:
/usr/src/modules/misdn/helper.h: In function 'alloc_stack_skb':
/usr/src/modules/misdn/helper.h:60: warning: format '%d' expects 
type 'int', but argument 3 has type 'size_t'
/usr/src/modules/misdn/helper.h:60: warning: format '%d' expects 
type 'int', but argument 4 has type 'size_t'
/usr/src/modules/misdn/avm_fritz.c: At top level:
/usr/src/modules/misdn/avm_fritz.c:1013: error: syntax error before 
string constant
/usr/src/modules/misdn/avm_fritz.c:1013: warning: type defaults to 'int' 
in declaration of 'MODULE_PARM'
/usr/src/modules/misdn/avm_fritz.c:1013: warning: function declaration 
isn't a prototype
/usr/src/modules/misdn/avm_fritz.c:1013: warning: data definition has no 
type or storage class
/usr/src/modules/misdn/avm_fritz.c:1014: error: syntax error before 
string constant
/usr/src/modules/misdn/avm_fritz.c:1014: warning: type defaults to 'int' 
in declaration of 'MODULE_PARM'
/usr/src/modules/misdn/avm_fritz.c:1014: warning: function declaration 
isn't a prototype
/usr/src/modules/misdn/avm_fritz.c:1014: warning: data definition has no 
type or storage class
/usr/src/modules/misdn/avm_fritz.c:1015: error: syntax error before 
string constant
/usr/src/modules/misdn/avm_fritz.c:1015: warning: type defaults to 'int' 
in declaration of 'MODULE_PARM'
/usr/src/modules/misdn/avm_fritz.c:1015: warning: function declaration 
isn't a prototype
/usr/src/modules/misdn/avm_fritz.c:1015: warning: data definition has no 
type or storage class
make[4]: *** [/usr/src/modules/misdn/avm_fritz.o] Error 1
make[3]: *** [_module_/usr/src/modules/misdn] Error 2
make[3]: Leaving directory `/usr/src/linux-2.6.17-rt8'
make[2]: *** [binary-modules] Error 2
make[2]: Leaving directory `/usr/src/modules/misdn'
make[1]: *** [kdist_image] Error 2
make[1]: Leaving directory `/usr/src/modules/misdn'
Module /usr/src/modules/misdn failed.
Hit return to Continue

=================
=================

I got in almost every line this warning:
warning: -ffunction-sections disabled; it makes profiling impossible

I think that does not affect the kernel ?

Can someone help me to get the realtime-lsm compiled on the new 2.6.17.8 
kernel, please?

Kind regards

Gerhard Gauﬂling
