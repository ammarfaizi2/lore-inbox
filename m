Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129639AbQK1Bko>; Mon, 27 Nov 2000 20:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129823AbQK1Bke>; Mon, 27 Nov 2000 20:40:34 -0500
Received: from mailb.telia.com ([194.22.194.6]:3345 "EHLO mailb.telia.com")
        by vger.kernel.org with ESMTP id <S129639AbQK1Bk0>;
        Mon, 27 Nov 2000 20:40:26 -0500
From: Roger Larsson <roger.larsson@norran.net>
Date: Tue, 28 Nov 2000 02:07:29 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: Multipart/Mixed;
  charset="us-ascii";
  boundary="------------Boundary-00=_H4NP9EJLAI8HHX05G7IZ"
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>,
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <00112516072500.01122@dox> <20001125192214.R2272@parcelfarce.linux.theplanet.co.uk> <00112522050600.01096@dox>
In-Reply-To: <00112522050600.01096@dox>
Subject: Re: *_trylock return on success?
MIME-Version: 1.0
Message-Id: <00112802072900.32321@dox>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_H4NP9EJLAI8HHX05G7IZ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

On Saturday 25 November 2000 22:05, Roger Larsson wrote:
> On Saturday 25 November 2000 20:22, Philipp Rumpf wrote:
> > On Sat, Nov 25, 2000 at 08:03:49PM +0100, Roger Larsson wrote:
> > > > _trylock functions return 0 for success.
> > >
> > > Not   spin_trylock
> >
> > Argh, I missed the (recent ?) change to make x86 spinlocks use 1 to mean
> > unlocked.  You're correct, and obviously this should be fixed.

Have looked more into this now...
tasklet_trylock is also wrong (but there are only four of them)
Is this 2.4 only, or where there spin locks earlier too?

My suggestion now is a few steps:
1) to release a kernel version that has corrected _trylocks; 
    spin2_trylock and tasklet2_trylock.
    [with corresponding updates in as many places as possible:
      s/!spin_trylock/spin2_trylock/g
      s/spin_trylock/!spin2_trylock/g 
      . . .]
    (ready for spin trylock, not done for tasklet yet..., attached,
     hope it got included OK - not fully used to kmail)

2) This will in house only drives or compilations that in some
    strange way uses this calls...

3a) (DANGEROUS) global rename spin2_trylock to spin_trylock
     [no logic change this time - only name]
3b) (dangerous) add compatibility interface
     #define spin_trylock(L) (!spin2_trylock(L))
     Probably not necessary since it can not be linked against.
     Binary modules will contain their own compatibility code :-) 
     Probably preferred by those who maintain drivers for several
     releases; 2.2, 2.4, ...
3c) do not do anything more...


Alternative:
1b) do nothing at all - suffer later

/RogerL

-- 
Home page:
  http://www.norran.net/nra02596/

--------------Boundary-00=_H4NP9EJLAI8HHX05G7IZ
Content-Type: text/plain;
  name="patch-2.4.0-test11-spin2_trylock"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="patch-2.4.0-test11-spin2_trylock"

diff -Naur v2.4.0-test11-linux/arch/alpha/kernel/alpha_ksyms.c linux/arch=
/alpha/kernel/alpha_ksyms.c
--- v2.4.0-test11-linux/arch/alpha/kernel/alpha_ksyms.c=09Mon Nov 27 21:0=
6:14 2000
+++ linux/arch/alpha/kernel/alpha_ksyms.c=09Tue Nov 28 00:35:13 2000
@@ -198,7 +198,7 @@
 #if DEBUG_SPINLOCK
 EXPORT_SYMBOL(spin_unlock);
 EXPORT_SYMBOL(debug_spin_lock);
-EXPORT_SYMBOL(debug_spin_trylock);
+EXPORT_SYMBOL(debug_spin2_trylock);
 #endif
 #if DEBUG_RWLOCK
 EXPORT_SYMBOL(write_lock);
diff -Naur v2.4.0-test11-linux/arch/alpha/kernel/irq_smp.c linux/arch/alp=
ha/kernel/irq_smp.c
--- v2.4.0-test11-linux/arch/alpha/kernel/irq_smp.c=09Thu Sep 21 19:53:32=
 2000
+++ linux/arch/alpha/kernel/irq_smp.c=09Tue Nov 28 00:35:31 2000
@@ -96,7 +96,7 @@
 =09=09=09if (!local_bh_count(cpu)
 =09=09=09    && spin_is_locked(&global_bh_lock))
 =09=09=09=09continue;
-=09=09=09if (spin_trylock(&global_irq_lock))
+=09=09=09if (!spin2_trylock(&global_irq_lock))
 =09=09=09=09break;
 =09=09}
 =09}
@@ -105,7 +105,7 @@
 static inline void
 get_irqlock(int cpu, void* where)
 {
-=09if (!spin_trylock(&global_irq_lock)) {
+=09if (spin2_trylock(&global_irq_lock)) {
 =09=09/* Do we already hold the lock?  */
 =09=09if (cpu =3D=3D global_irq_holder)
 =09=09=09return;
diff -Naur v2.4.0-test11-linux/arch/alpha/kernel/smp.c linux/arch/alpha/k=
ernel/smp.c
--- v2.4.0-test11-linux/arch/alpha/kernel/smp.c=09Fri Oct 13 00:57:30 200=
0
+++ linux/arch/alpha/kernel/smp.c=09Tue Nov 28 00:34:59 2000
@@ -1078,10 +1078,10 @@
 }
=20
 int
-debug_spin_trylock(spinlock_t * lock, const char *base_file, int line_no=
)
+debug_spin2_trylock(spinlock_t * lock, const char *base_file, int line_n=
o)
 {
 =09int ret;
-=09if ((ret =3D !test_and_set_bit(0, lock))) {
+=09if ((ret =3D test_and_set_bit(0, lock))) {
 =09=09lock->on_cpu =3D smp_processor_id();
 =09=09lock->previous =3D __builtin_return_address(0);
 =09=09lock->task =3D current;
diff -Naur v2.4.0-test11-linux/arch/mips64/sgi-ip27/ip27-irq.c linux/arch=
/mips64/sgi-ip27/ip27-irq.c
--- v2.4.0-test11-linux/arch/mips64/sgi-ip27/ip27-irq.c=09Thu Sep 21 19:5=
3:32 2000
+++ linux/arch/mips64/sgi-ip27/ip27-irq.c=09Tue Nov 28 00:44:48 2000
@@ -480,7 +480,7 @@
 =09=09=09=09continue;
 =09=09=09if (!local_bh_count(cpu) && spin_is_locked(&global_bh_lock))
 =09=09=09=09continue;
-=09=09=09if (spin_trylock(&global_irq_lock))
+=09=09=09if (!spin2_trylock(&global_irq_lock))
 =09=09=09=09break;
 =09=09}
 =09}
@@ -497,7 +497,7 @@
=20
 static inline void get_irqlock(int cpu)
 {
-=09if (!spin_trylock(&global_irq_lock)) {
+=09if (spin2_trylock(&global_irq_lock)) {
 =09=09/* do we already hold the lock? */
 =09=09if ((unsigned char) cpu =3D=3D global_irq_holder)
 =09=09=09return;
diff -Naur v2.4.0-test11-linux/arch/ppc/kernel/misc.S linux/arch/ppc/kern=
el/misc.S
--- v2.4.0-test11-linux/arch/ppc/kernel/misc.S=09Mon Nov 27 21:06:14 2000
+++ linux/arch/ppc/kernel/misc.S=09Tue Nov 28 00:40:02 2000
@@ -434,6 +434,7 @@
  * Environments Manual suggests not doing unnecessary stcwx.'s
  * since they may inhibit forward progress by other CPUs in getting
  * a lock.
+ * Returns:=090 on success ???
  */
 _GLOBAL(__spin_trylock)
 =09mr=09r4,r3
diff -Naur v2.4.0-test11-linux/arch/ppc/kernel/ppc_ksyms.c linux/arch/ppc=
/kernel/ppc_ksyms.c
--- v2.4.0-test11-linux/arch/ppc/kernel/ppc_ksyms.c=09Mon Nov 27 21:06:14=
 2000
+++ linux/arch/ppc/kernel/ppc_ksyms.c=09Tue Nov 28 00:37:23 2000
@@ -197,7 +197,7 @@
 EXPORT_SYMBOL(__global_restore_flags);
 EXPORT_SYMBOL(_spin_lock);
 EXPORT_SYMBOL(_spin_unlock);
-EXPORT_SYMBOL(spin_trylock);
+EXPORT_SYMBOL(spin2_trylock);
 EXPORT_SYMBOL(_read_lock);
 EXPORT_SYMBOL(_read_unlock);
 EXPORT_SYMBOL(_write_lock);
diff -Naur v2.4.0-test11-linux/arch/ppc/lib/locks.c linux/arch/ppc/lib/lo=
cks.c
--- v2.4.0-test11-linux/arch/ppc/lib/locks.c=09Thu Oct  7 19:17:08 1999
+++ linux/arch/ppc/lib/locks.c=09Tue Nov 28 00:41:25 2000
@@ -43,13 +43,13 @@
 =09lock->owner_cpu =3D cpu;
 }
=20
-int spin_trylock(spinlock_t *lock)
+int spin2_trylock(spinlock_t *lock)
 {
 =09if (__spin_trylock(&lock->lock))
-=09=09return 0;
+=09=09return 1;
 =09lock->owner_cpu =3D smp_processor_id();=20
 =09lock->owner_pc =3D (unsigned long)__builtin_return_address(0);
-=09return 1;
+=09return 0;
 }
=20
=20
diff -Naur v2.4.0-test11-linux/arch/sparc/kernel/sparc_ksyms.c linux/arch=
/sparc/kernel/sparc_ksyms.c
--- v2.4.0-test11-linux/arch/sparc/kernel/sparc_ksyms.c=09Thu Sep 21 19:5=
4:24 2000
+++ linux/arch/sparc/kernel/sparc_ksyms.c=09Tue Nov 28 00:35:38 2000
@@ -101,7 +101,7 @@
 #ifdef SPIN_LOCK_DEBUG
 EXPORT_SYMBOL(_do_spin_lock);
 EXPORT_SYMBOL(_do_spin_unlock);
-EXPORT_SYMBOL(_spin_trylock);
+EXPORT_SYMBOL(_spin2_trylock);
 EXPORT_SYMBOL(_do_read_lock);
 EXPORT_SYMBOL(_do_read_unlock);
 EXPORT_SYMBOL(_do_write_lock);
diff -Naur v2.4.0-test11-linux/arch/sparc/lib/debuglocks.c linux/arch/spa=
rc/lib/debuglocks.c
--- v2.4.0-test11-linux/arch/sparc/lib/debuglocks.c=09Fri Sep 10 20:06:19=
 1999
+++ linux/arch/sparc/lib/debuglocks.c=09Tue Nov 28 00:36:37 2000
@@ -85,7 +85,7 @@
 =09lock->owner_pc =3D (cpu & 3) | (caller & ~3);
 }
=20
-int _spin_trylock(spinlock_t *lock)
+int _spin2_trylock(spinlock_t *lock)
 {
 =09unsigned long val;
 =09unsigned long caller;
@@ -98,7 +98,7 @@
 =09=09/* We got it, record our identity for debugging. */
 =09=09lock->owner_pc =3D (cpu & 3) | (caller & ~3);
 =09}
-=09return val =3D=3D 0;
+=09return val !=3D 0;
 }
=20
 void _do_spin_unlock(spinlock_t *lock)
diff -Naur v2.4.0-test11-linux/arch/sparc64/kernel/sparc64_ksyms.c linux/=
arch/sparc64/kernel/sparc64_ksyms.c
--- v2.4.0-test11-linux/arch/sparc64/kernel/sparc64_ksyms.c=09Mon Nov 27 =
21:06:14 2000
+++ linux/arch/sparc64/kernel/sparc64_ksyms.c=09Tue Nov 28 00:48:13 2000
@@ -99,7 +99,7 @@
 #ifdef SPIN_LOCK_DEBUG
 extern void _do_spin_lock (spinlock_t *lock, char *str);
 extern void _do_spin_unlock (spinlock_t *lock);
-extern int _spin_trylock (spinlock_t *lock);
+extern int _spin2_trylock (spinlock_t *lock);
 extern void _do_read_lock(rwlock_t *rw, char *str);
 extern void _do_read_unlock(rwlock_t *rw, char *str);
 extern void _do_write_lock(rwlock_t *rw, char *str);
@@ -142,7 +142,7 @@
 #ifdef SPIN_LOCK_DEBUG
 EXPORT_SYMBOL(_do_spin_lock);
 EXPORT_SYMBOL(_do_spin_unlock);
-EXPORT_SYMBOL(_spin_trylock);
+EXPORT_SYMBOL(_spin2_trylock);
 EXPORT_SYMBOL(_do_read_lock);
 EXPORT_SYMBOL(_do_read_unlock);
 EXPORT_SYMBOL(_do_write_lock);
diff -Naur v2.4.0-test11-linux/arch/sparc64/lib/debuglocks.c linux/arch/s=
parc64/lib/debuglocks.c
--- v2.4.0-test11-linux/arch/sparc64/lib/debuglocks.c=09Wed May 31 20:13:=
23 2000
+++ linux/arch/sparc64/lib/debuglocks.c=09Tue Nov 28 00:44:30 2000
@@ -78,7 +78,7 @@
 =09lock->owner_cpu =3D cpu;
 }
=20
-int _spin_trylock(spinlock_t *lock)
+int _spin2_trylock(spinlock_t *lock)
 {
 =09unsigned long val, caller;
 =09int cpu =3D smp_processor_id();
@@ -93,7 +93,7 @@
 =09=09lock->owner_pc =3D ((unsigned int)caller);
 =09=09lock->owner_cpu =3D cpu;
 =09}
-=09return val =3D=3D 0;
+=09return val !=3D 0;
 }
=20
 void _do_spin_unlock(spinlock_t *lock)
diff -Naur v2.4.0-test11-linux/drivers/net/ppp_async.c linux/drivers/net/=
ppp_async.c
--- v2.4.0-test11-linux/drivers/net/ppp_async.c=09Fri Apr 21 22:31:10 200=
0
+++ linux/drivers/net/ppp_async.c=09Tue Nov 28 00:34:01 2000
@@ -33,9 +33,9 @@
 #include <linux/init.h>
 #include <asm/uaccess.h>
=20
-#ifndef spin_trylock_bh
-#define spin_trylock_bh(lock)=09({ int __r; local_bh_disable();=09\
-=09=09=09=09   __r =3D spin_trylock(lock);=09\
+#ifndef spin2_trylock_bh
+#define spin2_trylock_bh(lock)=09({ int __r; local_bh_disable();=09\
+=09=09=09=09   __r =3D spin2_trylock(lock);=09\
 =09=09=09=09   if (!__r) local_bh_enable();=09\
 =09=09=09=09   __r; })
 #endif
@@ -637,7 +637,7 @@
 =09int tty_stuffed =3D 0;
=20
 =09set_bit(XMIT_WAKEUP, &ap->xmit_flags);
-=09if (!spin_trylock_bh(&ap->xmit_lock))
+=09if (spin2_trylock_bh(&ap->xmit_lock))
 =09=09return 0;
 =09for (;;) {
 =09=09if (test_and_clear_bit(XMIT_WAKEUP, &ap->xmit_flags))
@@ -666,7 +666,7 @@
 =09=09if (!(test_bit(XMIT_WAKEUP, &ap->xmit_flags)
 =09=09      || (!tty_stuffed && ap->tpkt !=3D 0)))
 =09=09=09break;
-=09=09if (!spin_trylock_bh(&ap->xmit_lock))
+=09=09if (spin2_trylock_bh(&ap->xmit_lock))
 =09=09=09break;
 =09}
 =09return done;
diff -Naur v2.4.0-test11-linux/drivers/net/ppp_synctty.c linux/drivers/ne=
t/ppp_synctty.c
--- v2.4.0-test11-linux/drivers/net/ppp_synctty.c=09Wed May 31 20:13:26 2=
000
+++ linux/drivers/net/ppp_synctty.c=09Tue Nov 28 00:34:32 2000
@@ -44,9 +44,9 @@
 #include <linux/init.h>
 #include <asm/uaccess.h>
=20
-#ifndef spin_trylock_bh
-#define spin_trylock_bh(lock)=09({ int __r; local_bh_disable();=09\
-=09=09=09=09   __r =3D spin_trylock(lock);=09\
+#ifndef spin2_trylock_bh
+#define spin2_trylock_bh(lock)=09({ int __r; local_bh_disable();=09\
+=09=09=09=09   __r =3D spin2_trylock(lock);=09\
 =09=09=09=09   if (!__r) local_bh_enable();=09\
 =09=09=09=09   __r; })
 #endif
@@ -590,7 +590,7 @@
 =09int tty_stuffed =3D 0;
=20
 =09set_bit(XMIT_WAKEUP, &ap->xmit_flags);
-=09if (!spin_trylock_bh(&ap->xmit_lock))
+=09if (spin2_trylock_bh(&ap->xmit_lock))
 =09=09return 0;
 =09for (;;) {
 =09=09if (test_and_clear_bit(XMIT_WAKEUP, &ap->xmit_flags))
@@ -615,7 +615,7 @@
 =09=09if (!(test_bit(XMIT_WAKEUP, &ap->xmit_flags)
 =09=09      || (!tty_stuffed && ap->tpkt !=3D 0)))
 =09=09=09break;
-=09=09if (!spin_trylock_bh(&ap->xmit_lock))
+=09=09if (spin2_trylock_bh(&ap->xmit_lock))
 =09=09=09break;
 =09}
 =09return done;
diff -Naur v2.4.0-test11-linux/fs/buffer.c linux/fs/buffer.c
--- v2.4.0-test11-linux/fs/buffer.c=09Mon Nov 27 21:06:27 2000
+++ linux/fs/buffer.c=09Tue Nov 28 00:12:17 2000
@@ -2364,7 +2364,7 @@
 =09=09=09atomic_read(&buffermem_pages) << (PAGE_SHIFT-10));
=20
 #ifdef CONFIG_SMP /* trylock does nothing on UP and so we could deadlock=
 */
-=09if (!spin_trylock(&lru_list_lock))
+=09if (spin2_trylock(&lru_list_lock))
 =09=09return;
 =09for(nlist =3D 0; nlist < NR_LIST; nlist++) {
 =09=09found =3D locked =3D dirty =3D used =3D lastused =3D protected =3D=
 0;
diff -Naur v2.4.0-test11-linux/include/asm-alpha/spinlock.h linux/include=
/asm-alpha/spinlock.h
--- v2.4.0-test11-linux/include/asm-alpha/spinlock.h=09Mon Nov 27 21:06:2=
8 2000
+++ linux/include/asm-alpha/spinlock.h=09Tue Nov 28 00:22:55 2000
@@ -41,10 +41,10 @@
 #if DEBUG_SPINLOCK
 extern void spin_unlock(spinlock_t * lock);
 extern void debug_spin_lock(spinlock_t * lock, const char *, int);
-extern int debug_spin_trylock(spinlock_t * lock, const char *, int);
+extern int debug_spin2_trylock(spinlock_t * lock, const char *, int);
=20
 #define spin_lock(LOCK) debug_spin_lock(LOCK, __BASE_FILE__, __LINE__)
-#define spin_trylock(LOCK) debug_spin_trylock(LOCK, __BASE_FILE__, __LIN=
E__)
+#define spin2_trylock(LOCK) debug_spin2_trylock(LOCK, __BASE_FILE__, __L=
INE__)
=20
 #define spin_lock_own(LOCK, LOCATION)=09=09=09=09=09\
 do {=09=09=09=09=09=09=09=09=09\
@@ -84,7 +84,7 @@
 =09: "m"(lock->lock) : "memory");
 }
=20
-#define spin_trylock(lock) (!test_and_set_bit(0,(lock)))
+#define spin2_trylock(lock) (test_and_set_bit(0,(lock)))
 #define spin_lock_own(LOCK, LOCATION)=09((void)0)
 #endif /* DEBUG_SPINLOCK */
=20
diff -Naur v2.4.0-test11-linux/include/asm-i386/spinlock.h linux/include/=
asm-i386/spinlock.h
--- v2.4.0-test11-linux/include/asm-i386/spinlock.h=09Fri Oct 13 00:58:05=
 2000
+++ linux/include/asm-i386/spinlock.h=09Tue Nov 28 00:21:56 2000
@@ -65,14 +65,14 @@
 #define spin_unlock_string \
 =09"movb $1,%0"
=20
-static inline int spin_trylock(spinlock_t *lock)
+static inline int spin2_trylock(spinlock_t *lock)
 {
 =09char oldval;
 =09__asm__ __volatile__(
 =09=09"xchgb %b0,%1"
 =09=09:"=3Dq" (oldval), "=3Dm" (lock->lock)
 =09=09:"0" (0) : "memory");
-=09return oldval > 0;
+=09return oldval =3D=3D 0;
 }
=20
 static inline void spin_lock(spinlock_t *lock)
diff -Naur v2.4.0-test11-linux/include/asm-ia64/spinlock.h linux/include/=
asm-ia64/spinlock.h
--- v2.4.0-test11-linux/include/asm-ia64/spinlock.h=09Mon Nov 27 21:04:56=
 2000
+++ linux/include/asm-ia64/spinlock.h=09Tue Nov 28 00:29:40 2000
@@ -48,7 +48,7 @@
 =09=09: "ar.ccv", "ar.pfs", "b7", "p15", "r28", "r29", "r30", "memory");=
=09\
 }
=20
-#define spin_trylock(x)=09=09=09=09=09=09=09=09\
+#define spin2_trylock(x)=09=09=09=09=09=09=09=09\
 ({=09=09=09=09=09=09=09=09=09=09\
 =09register char *addr __asm__ ("r31") =3D (char *) &(x)->lock;=09=09\
 =09register long result;=09=09=09=09=09=09=09\
@@ -59,7 +59,7 @@
 =09=09";;\n"=09=09=09=09=09=09=09=09\
 =09=09IA64_SEMFIX"cmpxchg1.acq %0=3D[%1],r30,ar.ccv\n"=09=09=09\
 =09=09: "=3Dr"(result) : "r"(addr) : "ar.ccv", "r30", "memory");=09\
-=09(result =3D=3D 0);=09=09=09=09=09=09=09=09\
+=09(result !=3D 0);=09=09=09=09=09=09=09=09\
 })
=20
 #define spin_is_locked(x)=09((x)->lock !=3D 0)
@@ -98,7 +98,7 @@
=20
 #define spin_is_locked(x)=09((x)->lock !=3D 0)
 #define spin_unlock(x)=09=09do {((spinlock_t *) x)->lock =3D 0; barrier(=
); } while (0)
-#define spin_trylock(x)=09=09(cmpxchg_acq(&(x)->lock, 0, 1) =3D=3D 0)
+#define spin2_trylock(x)=09(cmpxchg_acq(&(x)->lock, 0, 1) !=3D 0)
 #define spin_unlock_wait(x)=09do { barrier(); } while ((x)->lock)
=20
 #endif /* !NEW_LOCK */
diff -Naur v2.4.0-test11-linux/include/asm-mips/spinlock.h linux/include/=
asm-mips/spinlock.h
--- v2.4.0-test11-linux/include/asm-mips/spinlock.h=09Wed May 31 20:13:32=
 2000
+++ linux/include/asm-mips/spinlock.h=09Tue Nov 28 00:22:05 2000
@@ -62,7 +62,7 @@
 =09: "memory");
 }
=20
-#define spin_trylock(lock) (!test_and_set_bit(0,(lock)))
+#define spin2_trylock(lock) (test_and_set_bit(0,(lock)))
=20
 /*
  * Read-write spinlocks, allowing multiple readers but only one writer.
diff -Naur v2.4.0-test11-linux/include/asm-mips64/spinlock.h linux/includ=
e/asm-mips64/spinlock.h
--- v2.4.0-test11-linux/include/asm-mips64/spinlock.h=09Wed May 31 20:13:=
33 2000
+++ linux/include/asm-mips64/spinlock.h=09Tue Nov 28 00:31:05 2000
@@ -65,12 +65,12 @@
 =09: "memory");
 }
=20
-static inline unsigned int spin_trylock(spinlock_t *lock)
+static inline unsigned int spin2_trylock(spinlock_t *lock)
 {
 =09unsigned int temp, res;
=20
 =09__asm__ __volatile__(
-=09".set\tnoreorder\t\t\t# spin_trylock\n\t"
+=09".set\tnoreorder\t\t\t# spin2_trylock\n\t"
 =09"1:\tll\t%0, %1\n\t"
 =09"or\t%2, %0, %3\n\t"
 =09"sc\t%2, %1\n\t"
@@ -81,7 +81,7 @@
 =09:"r" (1), "m" (*lock)
 =09: "memory");
=20
-=09return res =3D=3D 0;
+=09return res !=3D 0;
 }
=20
 /*
diff -Naur v2.4.0-test11-linux/include/asm-ppc/spinlock.h linux/include/a=
sm-ppc/spinlock.h
--- v2.4.0-test11-linux/include/asm-ppc/spinlock.h=09Mon Nov 27 21:06:30 =
2000
+++ linux/include/asm-ppc/spinlock.h=09Tue Nov 28 00:28:14 2000
@@ -19,12 +19,12 @@
=20
 extern void _spin_lock(spinlock_t *lock);
 extern void _spin_unlock(spinlock_t *lock);
-extern int spin_trylock(spinlock_t *lock);
+extern int spin2_trylock(spinlock_t *lock);
=20
 #define spin_lock(lp)=09=09=09_spin_lock(lp)
 #define spin_unlock(lp)=09=09=09_spin_unlock(lp)
=20
-extern unsigned long __spin_trylock(volatile unsigned long *lock);
+extern unsigned long __spin2_trylock(volatile unsigned long *lock);
=20
 /*
  * Read-write spinlocks, allowing multiple readers
diff -Naur v2.4.0-test11-linux/include/asm-s390/spinlock.h linux/include/=
asm-s390/spinlock.h
--- v2.4.0-test11-linux/include/asm-s390/spinlock.h=09Fri May 12 20:41:44=
 2000
+++ linux/include/asm-s390/spinlock.h=09Tue Nov 28 01:04:34 2000
@@ -37,7 +37,7 @@
 =09=09=09   : "0" (lp->lock) : "0", "1");
 }
=20
-extern inline int spin_trylock(spinlock_t *lp)
+extern inline int spin2_trylock(spinlock_t *lp)
 {
 =09unsigned long result;
 =09__asm__ __volatile("    slr   %1,%1\n"
@@ -45,7 +45,7 @@
 =09=09=09   "0:  cs    %1,0,%0"
 =09=09=09   : "=3Dm" (lp->lock), "=3D&d" (result)
 =09=09=09   : "0" (lp->lock) : "0");
-=09return !result;
+=09return result !=3D 0;
 }
=20
=20
diff -Naur v2.4.0-test11-linux/include/asm-sparc/spinlock.h linux/include=
/asm-sparc/spinlock.h
--- v2.4.0-test11-linux/include/asm-sparc/spinlock.h=09Thu Sep 21 19:54:1=
6 2000
+++ linux/include/asm-sparc/spinlock.h=09Tue Nov 28 00:47:42 2000
@@ -33,10 +33,10 @@
 #define spin_unlock_wait(lp)=09do { barrier(); } while(*(volatile unsign=
ed char *)(&(lp)->lock))
=20
 extern void _do_spin_lock(spinlock_t *lock, char *str);
-extern int _spin_trylock(spinlock_t *lock);
+extern int _spin2_trylock(spinlock_t *lock);
 extern void _do_spin_unlock(spinlock_t *lock);
=20
-#define spin_trylock(lp)=09_spin_trylock(lp)
+#define spin2_trylock(lp)=09_spin2_trylock(lp)
 #define spin_lock(lock)=09=09_do_spin_lock(lock, "spin_lock")
 #define spin_unlock(lock)=09_do_spin_unlock(lock)
=20
@@ -115,14 +115,14 @@
 =09: "g2", "memory", "cc");
 }
=20
-extern __inline__ int spin_trylock(spinlock_t *lock)
+extern __inline__ int spin2_trylock(spinlock_t *lock)
 {
 =09unsigned int result;
 =09__asm__ __volatile__("ldstub [%1], %0"
 =09=09=09     : "=3Dr" (result)
 =09=09=09     : "r" (lock)
 =09=09=09     : "memory");
-=09return (result =3D=3D 0);
+=09return (result !=3D 0);
 }
=20
 extern __inline__ void spin_unlock(spinlock_t *lock)
diff -Naur v2.4.0-test11-linux/include/asm-sparc64/spinlock.h linux/inclu=
de/asm-sparc64/spinlock.h
--- v2.4.0-test11-linux/include/asm-sparc64/spinlock.h=09Thu Sep 21 19:54=
:16 2000
+++ linux/include/asm-sparc64/spinlock.h=09Tue Nov 28 00:29:10 2000
@@ -55,7 +55,7 @@
 =09: "g7", "memory");
 }
=20
-extern __inline__ int spin_trylock(spinlock_t *lock)
+extern __inline__ int spin2_trylock(spinlock_t *lock)
 {
 =09unsigned int result;
 =09__asm__ __volatile__("ldstub [%1], %0\n\t"
@@ -63,7 +63,7 @@
 =09=09=09     : "=3Dr" (result)
 =09=09=09     : "r" (lock)
 =09=09=09     : "memory");
-=09return (result =3D=3D 0);
+=09return (result !=3D 0);
 }
=20
 extern __inline__ void spin_unlock(spinlock_t *lock)
@@ -95,9 +95,9 @@
=20
 extern void _do_spin_lock (spinlock_t *lock, char *str);
 extern void _do_spin_unlock (spinlock_t *lock);
-extern int _spin_trylock (spinlock_t *lock);
+extern int _spin2_trylock (spinlock_t *lock);
=20
-#define spin_trylock(lp)=09_spin_trylock(lp)
+#define spin2_trylock(lp)=09_spin2_trylock(lp)
 #define spin_lock(lock)=09=09_do_spin_lock(lock, "spin_lock")
 #define spin_unlock(lock)=09_do_spin_unlock(lock)
=20
diff -Naur v2.4.0-test11-linux/include/linux/spinlock.h linux/include/lin=
ux/spinlock.h
--- v2.4.0-test11-linux/include/linux/spinlock.h=09Thu Sep 21 19:53:48 20=
00
+++ linux/include/linux/spinlock.h=09Tue Nov 28 01:07:34 2000
@@ -58,7 +58,7 @@
 #define spin_lock_init(lock)=09do { } while(0)
 #define spin_lock(lock)=09=09(void)(lock) /* Not "unused variable". */
 #define spin_is_locked(lock)=09(0)
-#define spin_trylock(lock)=09({1; })
+#define spin2_trylock(lock)=09({0; }) /* Note: returns 0 on success */
 #define spin_unlock_wait(lock)=09do { } while(0)
 #define spin_unlock(lock)=09do { } while(0)
=20
@@ -71,7 +71,9 @@
=20
 #define spin_lock_init(x)=09do { (x)->lock =3D 0; } while (0)
 #define spin_is_locked(lock)=09(test_bit(0,(lock)))
-#define spin_trylock(lock)=09(!test_and_set_bit(0,(lock)))
+#define spin2_trylock(lock)=09(test_and_set_bit(0,(lock))) /* Note:
+=09=09=09=09=09=09=09=09returns 0 on
+=09=09=09=09=09=09=09=09success */
=20
 #define spin_lock(x)=09=09do { (x)->lock =3D 1; } while (0)
 #define spin_unlock_wait(x)=09do { } while (0)
@@ -90,7 +92,8 @@
=20
 #define spin_lock_init(x)=09do { (x)->lock =3D 0; } while (0)
 #define spin_is_locked(lock)=09(test_bit(0,(lock)))
-#define spin_trylock(lock)=09(!test_and_set_bit(0,(lock)))
+#define spin2_trylock(lock)=09(test_and_set_bit(0,(lock))) /* Note: retu=
rns
+=09=09=09=09=09=09=09=090 on success */
=20
 #define spin_lock(x)=09=09do {unsigned long __spinflags; save_flags(__sp=
inflags); cli(); if ((x)->lock&&(x)->babble) {printk("%s:%d: spin_lock(%s=
:%p) already locked\n", __BASE_FILE__,__LINE__, (x)->module, (x));(x)->ba=
bble--;} (x)->lock =3D 1; restore_flags(__spinflags);} while (0)
 #define spin_unlock_wait(x)=09do {unsigned long __spinflags; save_flags(=
__spinflags); cli(); if ((x)->lock&&(x)->babble) {printk("%s:%d: spin_unl=
ock_wait(%s:%p) deadlock\n", __BASE_FILE__,__LINE__, (x)->module, (x));(x=
)->babble--;} restore_flags(__spinflags);} while (0)
diff -Naur v2.4.0-test11-linux/kernel/softirq.c linux/kernel/softirq.c
--- v2.4.0-test11-linux/kernel/softirq.c=09Fri Oct 13 00:58:09 2000
+++ linux/kernel/softirq.c=09Tue Nov 28 00:12:31 2000
@@ -246,7 +246,7 @@
 {
 =09int cpu =3D smp_processor_id();
=20
-=09if (!spin_trylock(&global_bh_lock))
+=09if (spin2_trylock(&global_bh_lock))
 =09=09goto resched;
=20
 =09if (!hardirq_trylock(cpu))
diff -Naur v2.4.0-test11-linux/net/core/dev.c linux/net/core/dev.c
--- v2.4.0-test11-linux/net/core/dev.c=09Mon Nov 27 21:06:32 2000
+++ linux/net/core/dev.c=09Tue Nov 28 00:32:08 2000
@@ -1251,7 +1251,7 @@
 =09=09=09smp_mb__before_clear_bit();
 =09=09=09clear_bit(__LINK_STATE_SCHED, &dev->state);
=20
-=09=09=09if (spin_trylock(&dev->queue_lock)) {
+=09=09=09if (!spin2_trylock(&dev->queue_lock)) {
 =09=09=09=09qdisc_run(dev);
 =09=09=09=09spin_unlock(&dev->queue_lock);
 =09=09=09} else {
diff -Naur v2.4.0-test11-linux/net/core/dst.c linux/net/core/dst.c
--- v2.4.0-test11-linux/net/core/dst.c=09Wed May  3 01:48:16 2000
+++ linux/net/core/dst.c=09Tue Nov 28 00:32:18 2000
@@ -45,7 +45,7 @@
 =09int    delayed =3D 0;
 =09struct dst_entry * dst, **dstp;
=20
-=09if (!spin_trylock(&dst_lock)) {
+=09if (spin2_trylock(&dst_lock)) {
 =09=09mod_timer(&dst_gc_timer, jiffies + HZ/10);
 =09=09return;
 =09}
diff -Naur v2.4.0-test11-linux/net/ipv4/icmp.c linux/net/ipv4/icmp.c
--- v2.4.0-test11-linux/net/ipv4/icmp.c=09Thu Sep 21 19:53:51 2000
+++ linux/net/ipv4/icmp.c=09Tue Nov 28 00:32:24 2000
@@ -349,7 +349,7 @@
=20
 static int icmp_xmit_lock_bh(void)
 {
-=09if (!spin_trylock(&icmp_socket->sk->lock.slock)) {
+=09if (spin2_trylock(&icmp_socket->sk->lock.slock)) {
 =09=09if (icmp_xmit_holder =3D=3D smp_processor_id())
 =09=09=09return -EAGAIN;
 =09=09spin_lock(&icmp_socket->sk->lock.slock);
diff -Naur v2.4.0-test11-linux/net/ipv4/ipmr.c linux/net/ipv4/ipmr.c
--- v2.4.0-test11-linux/net/ipv4/ipmr.c=09Thu Sep 21 19:53:51 2000
+++ linux/net/ipv4/ipmr.c=09Tue Nov 28 00:32:31 2000
@@ -319,7 +319,7 @@
 =09unsigned long expires;
 =09struct mfc_cache *c, **cp;
=20
-=09if (!spin_trylock(&mfc_unres_lock)) {
+=09if (spin2_trylock(&mfc_unres_lock)) {
 =09=09mod_timer(&ipmr_expire_timer, jiffies+HZ/10);
 =09=09return;
 =09}
diff -Naur v2.4.0-test11-linux/net/ipv6/icmp.c linux/net/ipv6/icmp.c
--- v2.4.0-test11-linux/net/ipv6/icmp.c=09Mon Mar 27 20:35:57 2000
+++ linux/net/ipv6/icmp.c=09Tue Nov 28 00:32:37 2000
@@ -92,7 +92,7 @@
=20
 static int icmpv6_xmit_lock_bh(void)
 {
-=09if (!spin_trylock(&icmpv6_socket->sk->lock.slock)) {
+=09if (spin2_trylock(&icmpv6_socket->sk->lock.slock)) {
 =09=09if (icmpv6_xmit_holder =3D=3D smp_processor_id())
 =09=09=09return -EAGAIN;
 =09=09spin_lock(&icmpv6_socket->sk->lock.slock);
diff -Naur v2.4.0-test11-linux/net/ipv6/ip6_fib.c linux/net/ipv6/ip6_fib.=
c
--- v2.4.0-test11-linux/net/ipv6/ip6_fib.c=09Fri Oct 13 00:58:10 2000
+++ linux/net/ipv6/ip6_fib.c=09Tue Nov 28 00:32:43 2000
@@ -1174,7 +1174,7 @@
 =09=09gc_args.timeout =3D (int)dummy;
 =09} else {
 =09=09local_bh_disable();
-=09=09if (!spin_trylock(&fib6_gc_lock)) {
+=09=09if (spin2_trylock(&fib6_gc_lock)) {
 =09=09=09mod_timer(&ip6_fib_timer, jiffies + HZ);
 =09=09=09local_bh_enable();
 =09=09=09return;
diff -Naur v2.4.0-test11-linux/net/sched/sch_generic.c linux/net/sched/sc=
h_generic.c
--- v2.4.0-test11-linux/net/sched/sch_generic.c=09Thu Sep 21 19:54:19 200=
0
+++ linux/net/sched/sch_generic.c=09Tue Nov 28 00:32:51 2000
@@ -81,7 +81,7 @@
=20
 =09/* Dequeue packet */
 =09if ((skb =3D q->dequeue(q)) !=3D NULL) {
-=09=09if (spin_trylock(&dev->xmit_lock)) {
+=09=09if (!spin2_trylock(&dev->xmit_lock)) {
 =09=09=09/* Remember that the driver is grabbed by us. */
 =09=09=09dev->xmit_lock_owner =3D smp_processor_id();
=20
diff -Naur v2.4.0-test11-linux/net/sched/sch_teql.c linux/net/sched/sch_t=
eql.c
--- v2.4.0-test11-linux/net/sched/sch_teql.c=09Fri Jul 28 23:45:29 2000
+++ linux/net/sched/sch_teql.c=09Tue Nov 28 00:32:59 2000
@@ -302,7 +302,7 @@
=20
 =09=09switch (teql_resolve(skb, skb_res, slave)) {
 =09=09case 0:
-=09=09=09if (spin_trylock(&slave->xmit_lock)) {
+=09=09=09if (!spin2_trylock(&slave->xmit_lock)) {
 =09=09=09=09slave->xmit_lock_owner =3D smp_processor_id();
 =09=09=09=09if (!netif_queue_stopped(slave) &&
 =09=09=09=09    slave->hard_start_xmit(skb, slave) =3D=3D 0) {

--------------Boundary-00=_H4NP9EJLAI8HHX05G7IZ--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
