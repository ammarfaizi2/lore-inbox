Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317615AbSFIOiD>; Sun, 9 Jun 2002 10:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317616AbSFIOiC>; Sun, 9 Jun 2002 10:38:02 -0400
Received: from [195.63.194.11] ([195.63.194.11]:61709 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317615AbSFIOhv>; Sun, 9 Jun 2002 10:37:51 -0400
Message-ID: <3D035A80.7030404@evision-ventures.com>
Date: Sun, 09 Jun 2002 15:39:12 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.20 locks.h
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------040705070500040101090800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040705070500040101090800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Since I have been looking in to the lcoking issues recently
the following rather trivial gabrage code collection became
obvious...


- Remove "not jet used" code from 1995 in asm/locks.h. It's garbage.

- Remove useless DEBUG_SPINLOCK code from generic spinlock.h code. Just
   compiling for SMP does the trick already.

- Replace all usages of SPINLOCK_DEBUG with the now global
   CONFIG_DEBUG_SPINLOCK.

--------------040705070500040101090800
Content-Type: text/plain;
 name="locks-2.5.20.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="locks-2.5.20.diff"

diff -urN linux-2.5.20/arch/alpha/kernel/smc37c669.c linux/arch/alpha/ker=
nel/smc37c669.c
--- linux-2.5.20/arch/alpha/kernel/smc37c669.c	2002-06-03 03:44:51.000000=
000 +0200
+++ linux/arch/alpha/kernel/smc37c669.c	2002-06-09 04:58:37.000000000 +02=
00
@@ -7,6 +7,7 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/spinlock.h>
=20
 #include <asm/hwrpb.h>
 #include <asm/io.h>
@@ -1103,66 +1104,7 @@
     unsigned int drq=20
 );
=20
-#if 0
-/*
-** External Data Declarations
-*/
-
-extern struct LOCK spl_atomic;
-
-/*
-** External Function Prototype Declarations
-*/
-
-/* From kernel_alpha.mar */
-extern spinlock(=20
-    struct LOCK *spl=20
-);
-
-extern spinunlock(=20
-    struct LOCK *spl=20
-);
-
-/* From filesys.c */
-int allocinode(
-    char *name,=20
-    int can_create,=20
-    struct INODE **ipp
-);
-
-extern int null_procedure( void );
-
-int smcc669_init( void );
-int smcc669_open( struct FILE *fp, char *info, char *next, char *mode );=

-int smcc669_read( struct FILE *fp, int size, int number, unsigned char *=
buf );
-int smcc669_write( struct FILE *fp, int size, int number, unsigned char =
*buf );
-int smcc669_close( struct FILE *fp );
-
-struct DDB smc_ddb =3D {
-	"smc",			/* how this routine wants to be called	*/
-	smcc669_read,		/* read routine				*/
-	smcc669_write,		/* write routine			*/
-	smcc669_open,		/* open routine				*/
-	smcc669_close,		/* close routine			*/
-	null_procedure,		/* name expansion routine		*/
-	null_procedure,		/* delete routine			*/
-	null_procedure,		/* create routine			*/
-	null_procedure,		/* setmode				*/
-	null_procedure,		/* validation routine			*/
-	0,			/* class specific use			*/
-	1,			/* allows information			*/
-	0,			/* must be stacked			*/
-	0,			/* is a flash update driver		*/
-	0,			/* is a block device			*/
-	0,			/* not seekable				*/
-	0,			/* is an Ethernet device		*/
-	0,			/* is a filesystem driver		*/
-};
-#endif
-
-#define spinlock(x)
-#define spinunlock(x)
-
+static spinlock_t smc_lock __cacheline_aligned =3D SPIN_LOCK_UNLOCKED;
 =0C
 /*
 **++
@@ -2042,10 +1984,10 @@
 ** mode.  Therefore, a spinlock is placed around the two writes to=20
 ** guarantee that they complete uninterrupted.
 */
-	spinlock( &spl_atomic );
+	spin_lock(&smc_lock);
     	wb( &SMC37c669->index_port, SMC37c669_CONFIG_ON_KEY );
     	wb( &SMC37c669->index_port, SMC37c669_CONFIG_ON_KEY );
-	spinunlock( &spl_atomic );
+	spin_unlock(&smc_lock);
     }
     else {
     	wb( &SMC37c669->index_port, SMC37c669_CONFIG_OFF_KEY );
diff -urN linux-2.5.20/arch/ppc/kernel/ppc_ksyms.c linux/arch/ppc/kernel/=
ppc_ksyms.c
--- linux-2.5.20/arch/ppc/kernel/ppc_ksyms.c	2002-06-03 03:44:53.00000000=
0 +0200
+++ linux/arch/ppc/kernel/ppc_ksyms.c	2002-06-09 04:58:37.000000000 +0200=

@@ -217,7 +217,7 @@
 EXPORT_SYMBOL(__global_sti);
 EXPORT_SYMBOL(__global_save_flags);
 EXPORT_SYMBOL(__global_restore_flags);
-#ifdef SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 EXPORT_SYMBOL(_raw_spin_lock);
 EXPORT_SYMBOL(_raw_spin_unlock);
 EXPORT_SYMBOL(_raw_spin_trylock);
diff -urN linux-2.5.20/arch/ppc/lib/locks.c linux/arch/ppc/lib/locks.c
--- linux-2.5.20/arch/ppc/lib/locks.c	2002-06-03 03:44:44.000000000 +0200=

+++ linux/arch/ppc/lib/locks.c	2002-06-09 04:58:37.000000000 +0200
@@ -16,7 +16,7 @@
 #include <asm/system.h>
 #include <asm/io.h>
=20
-#ifdef SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
=20
 #undef INIT_STUCK
 #define INIT_STUCK 200000000 /*0xffffffff*/
diff -urN linux-2.5.20/drivers/scsi/tmscsim.c linux/drivers/scsi/tmscsim.=
c
--- linux-2.5.20/drivers/scsi/tmscsim.c	2002-06-03 03:44:50.000000000 +02=
00
+++ linux/drivers/scsi/tmscsim.c	2002-06-09 04:58:38.000000000 +0200
@@ -254,8 +254,6 @@
  * undef  : traditional save_flags; cli; restore_flags;
  */
=20
-//#define DEBUG_SPINLOCKS 2	/* Set to 0, 1 or 2 in include/linux/spinloc=
k.h */
-
 #if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,1,30)
 # include <linux/init.h>
 #if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,3,30)
@@ -293,7 +291,7 @@
=20
 # if USE_SPINLOCKS =3D=3D 3 /* both */
=20
-#  if defined (CONFIG_SMP) || DEBUG_SPINLOCKS > 0
+#  if defined (CONFIG_SMP)
 #   define DC390_LOCKA_INIT { spinlock_t __unlocked =3D SPIN_LOCK_UNLOCK=
ED; pACB->lock =3D __unlocked; };
 #  else
 #   define DC390_LOCKA_INIT
@@ -322,7 +320,7 @@
=20
 #  if USE_SPINLOCKS =3D=3D 2 /* adapter specific locks */
=20
-#   if defined (CONFIG_SMP) || DEBUG_SPINLOCKS > 0
+#   if defined (CONFIG_SMP)
 #    define DC390_LOCKA_INIT { spinlock_t __unlocked =3D SPIN_LOCK_UNLOC=
KED; pACB->lock =3D __unlocked; };
 #   else
 #    define DC390_LOCKA_INIT
diff -urN linux-2.5.20/include/asm-cris/locks.h linux/include/asm-cris/lo=
cks.h
--- linux-2.5.20/include/asm-cris/locks.h	2002-06-03 03:44:48.000000000 +=
0200
+++ linux/include/asm-cris/locks.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,133 +0,0 @@
-/*
- *	SMP locks primitives for building ix86 locks
- *	(not yet used).
- *
- *		Alan Cox, alan@cymru.net, 1995
- */
-=20
-/*
- *	This would be much easier but far less clear and easy
- *	to borrow for other processors if it was just assembler.
- */
-
-extern __inline__ void prim_spin_lock(struct spinlock *sp)
-{
-	int processor=3Dsmp_processor_id();
-=09
-	/*
-	 *	Grab the lock bit
-	 */
-	=20
-	while(lock_set_bit(0,&sp->lock))
-	{
-		/*
-		 *	Failed, but that's cos we own it!
-		 */
-		=20
-		if(sp->cpu=3D=3Dprocessor)
-		{
-			sp->users++;
-			return 0;
-		}
-		/*
-		 *	Spin in the cache S state if possible
-		 */
-		while(sp->lock)
-		{
-			/*
-			 *	Wait for any invalidates to go off
-			 */
-			=20
-			if(smp_invalidate_needed&(1<<processor))
-				while(lock_clear_bit(processor,&smp_invalidate_needed))
-					local_flush_tlb();
-			sp->spins++;
-		}
-		/*
-		 *	Someone wrote the line, we go 'I' and get
-		 *	the cache entry. Now try to regrab
-		 */
-	}
-	sp->users++;sp->cpu=3Dprocessor;
-	return 1;
-}
-
-/*
- *	Release a spin lock
- */
-=20
-extern __inline__ int prim_spin_unlock(struct spinlock *sp)
-{
-	/* This is safe. The decrement is still guarded by the lock. A multiloc=
k would
-	   not be safe this way */
-	if(!--sp->users)
-	{
-		lock_clear_bit(0,&sp->lock);sp->cpu=3D NO_PROC_ID;
-		return 1;
-	}
-	return 0;
-}
-
-
-/*
- *	Non blocking lock grab
- */
-=20
-extern __inline__ int prim_spin_lock_nb(struct spinlock *sp)
-{
-	if(lock_set_bit(0,&sp->lock))
-		return 0;		/* Locked already */
-	sp->users++;
-	return 1;			/* We got the lock */
-}
-
-
-/*
- *	These wrap the locking primitives up for usage
- */
-=20
-extern __inline__ void spinlock(struct spinlock *sp)
-{
-	if(sp->priority<current->lock_order)
-		panic("lock order violation: %s (%d)\n", sp->name, current->lock_order=
);
-	if(prim_spin_lock(sp))
-	{
-		/*
-		 *	We got a new lock. Update the priority chain
-		 */
-		sp->oldpri=3Dcurrent->lock_order;
-		current->lock_order=3Dsp->priority;
-	}
-}
-
-extern __inline__ void spinunlock(struct spinlock *sp)
-{
-	if(current->lock_order!=3Dsp->priority)
-		panic("lock release order violation %s (%d)\n", sp->name, current->loc=
k_order);
-	if(prim_spin_unlock(sp))
-	{
-		/*
-		 *	Update the debugging lock priority chain. We dumped
-		 *	our last right to the lock.
-		 */
-		current->lock_order=3Dsp->oldpri;
-	}=09
-}
-
-extern __inline__ void spintestlock(struct spinlock *sp)
-{
-	/*
-	 *	We do no sanity checks, it's legal to optimistically
-	 *	get a lower lock.
-	 */
-	prim_spin_lock_nb(sp);
-}
-
-extern __inline__ void spintestunlock(struct spinlock *sp)
-{
-	/*
-	 *	A testlock doesn't update the lock chain so we
-	 *	must not update it on free
-	 */
-	prim_spin_unlock(sp);
-}
diff -urN linux-2.5.20/include/asm-i386/locks.h linux/include/asm-i386/lo=
cks.h
--- linux-2.5.20/include/asm-i386/locks.h	2002-06-03 03:44:51.000000000 +=
0200
+++ linux/include/asm-i386/locks.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,135 +0,0 @@
-/*
- *	SMP locks primitives for building ix86 locks
- *	(not yet used).
- *
- *		Alan Cox, alan@redhat.com, 1995
- */
-=20
-/*
- *	This would be much easier but far less clear and easy
- *	to borrow for other processors if it was just assembler.
- */
-
-static __inline__ void prim_spin_lock(struct spinlock *sp)
-{
-	int processor=3Dsmp_processor_id();
-=09
-	/*
-	 *	Grab the lock bit
-	 */
-	=20
-	while(lock_set_bit(0,&sp->lock))
-	{
-		/*
-		 *	Failed, but that's cos we own it!
-		 */
-		 
-		if(sp->cpu=3D=3Dprocessor)
-		{
-			sp->users++;
-			return 0;
-		}
-		/*
-		 *	Spin in the cache S state if possible
-		 */
-		while(sp->lock)
-		{
-			/*
-			 *	Wait for any invalidates to go off
-			 */
-			=20
-			if(smp_invalidate_needed&(1<<processor))
-				while(lock_clear_bit(processor,&smp_invalidate_needed))
-					local_flush_tlb();
-			sp->spins++;
-		}
-		/*
-		 *	Someone wrote the line, we go 'I' and get
-		 *	the cache entry. Now try to regrab
-		 */
-	}
-	sp->users++;sp->cpu=3Dprocessor;
-	return 1;
-}
-
-/*
- *	Release a spin lock
- */
-=20
-static __inline__ int prim_spin_unlock(struct spinlock *sp)
-{
-	/* This is safe. The decrement is still guarded by the lock. A multiloc=
k would
-	   not be safe this way */
-	if(!--sp->users)
-	{
-		sp->cpu=3D NO_PROC_ID;lock_clear_bit(0,&sp->lock);
-		return 1;
-	}
-	return 0;
-}
-
-
-/*
- *	Non blocking lock grab
- */
-=20
-static __inline__ int prim_spin_lock_nb(struct spinlock *sp)
-{
-	if(lock_set_bit(0,&sp->lock))
-		return 0;		/* Locked already */
-	sp->users++;
-	return 1;			/* We got the lock */
-}
-
-
-/*
- *	These wrap the locking primitives up for usage
- */
-=20
-static __inline__ void spinlock(struct spinlock *sp)
-{
-	if(sp->priority<current->lock_order)
-		panic("lock order violation: %s (%d)\n", sp->name, current->lock_order=
);
-	if(prim_spin_lock(sp))
-	{
-		/*
-		 *	We got a new lock. Update the priority chain
-		 */
-		sp->oldpri=3Dcurrent->lock_order;
-		current->lock_order=3Dsp->priority;
-	}
-}
-
-static __inline__ void spinunlock(struct spinlock *sp)
-{
-	int pri;
-	if(current->lock_order!=3Dsp->priority)
-		panic("lock release order violation %s (%d)\n", sp->name, current->loc=
k_order);
-	pri=3Dsp->oldpri;
-	if(prim_spin_unlock(sp))
-	{
-		/*
-		 *	Update the debugging lock priority chain. We dumped
-		 *	our last right to the lock.
-		 */
-		current->lock_order=3Dsp->pri;
-	}=09
-}
-
-static __inline__ void spintestlock(struct spinlock *sp)
-{
-	/*
-	 *	We do no sanity checks, it's legal to optimistically
-	 *	get a lower lock.
-	 */
-	prim_spin_lock_nb(sp);
-}
-
-static __inline__ void spintestunlock(struct spinlock *sp)
-{
-	/*
-	 *	A testlock doesn't update the lock chain so we
-	 *	must not update it on free
-	 */
-	prim_spin_unlock(sp);
-}
diff -urN linux-2.5.20/include/asm-i386/spinlock.h linux/include/asm-i386=
/spinlock.h
--- linux-2.5.20/include/asm-i386/spinlock.h	2002-06-03 03:44:44.00000000=
0 +0200
+++ linux/include/asm-i386/spinlock.h	2002-06-09 04:58:38.000000000 +0200=

@@ -9,30 +9,20 @@
 extern int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
=20
-/* It seems that people are forgetting to
- * initialize their spinlocks properly, tsk tsk.
- * Remember to turn this off in 2.4. -ben
- */
-#if defined(CONFIG_DEBUG_SPINLOCK)
-#define SPINLOCK_DEBUG	1
-#else
-#define SPINLOCK_DEBUG	0
-#endif
-
 /*
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
  */
=20
 typedef struct {
 	volatile unsigned int lock;
-#if SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 	unsigned magic;
 #endif
 } spinlock_t;
=20
 #define SPINLOCK_MAGIC	0xdead4ead
=20
-#if SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 #define SPINLOCK_MAGIC_INIT	, SPINLOCK_MAGIC
 #else
 #define SPINLOCK_MAGIC_INIT	/* */
@@ -79,7 +69,7 @@
=20
 static inline void _raw_spin_unlock(spinlock_t *lock)
 {
-#if SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 	if (lock->magic !=3D SPINLOCK_MAGIC)
 		BUG();
 	if (!spin_is_locked(lock))
@@ -100,7 +90,7 @@
 static inline void _raw_spin_unlock(spinlock_t *lock)
 {
 	char oldval =3D 1;
-#if SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 	if (lock->magic !=3D SPINLOCK_MAGIC)
 		BUG();
 	if (!spin_is_locked(lock))
@@ -125,7 +115,7 @@
=20
 static inline void _raw_spin_lock(spinlock_t *lock)
 {
-#if SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 	__label__ here;
 here:
 	if (lock->magic !=3D SPINLOCK_MAGIC) {
@@ -151,14 +141,14 @@
  */
 typedef struct {
 	volatile unsigned int lock;
-#if SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 	unsigned magic;
 #endif
 } rwlock_t;
=20
 #define RWLOCK_MAGIC	0xdeaf1eed
=20
-#if SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 #define RWLOCK_MAGIC_INIT	, RWLOCK_MAGIC
 #else
 #define RWLOCK_MAGIC_INIT	/* */
@@ -181,7 +171,7 @@
=20
 static inline void _raw_read_lock(rwlock_t *rw)
 {
-#if SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 	if (rw->magic !=3D RWLOCK_MAGIC)
 		BUG();
 #endif
@@ -190,7 +180,7 @@
=20
 static inline void _raw_write_lock(rwlock_t *rw)
 {
-#if SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 	if (rw->magic !=3D RWLOCK_MAGIC)
 		BUG();
 #endif
diff -urN linux-2.5.20/include/asm-ppc/spinlock.h linux/include/asm-ppc/s=
pinlock.h
--- linux-2.5.20/include/asm-ppc/spinlock.h	2002-06-03 03:44:47.000000000=
 +0200
+++ linux/include/asm-ppc/spinlock.h	2002-06-09 04:58:38.000000000 +0200
@@ -7,22 +7,20 @@
 #include <asm/system.h>
 #include <asm/processor.h>
=20
-#undef SPINLOCK_DEBUG
-
 /*
  * Simple spin lock operations.
  */
=20
 typedef struct {
 	volatile unsigned long lock;
-#ifdef SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 	volatile unsigned long owner_pc;
 	volatile unsigned long owner_cpu;
 #endif
 } spinlock_t;
=20
 #ifdef __KERNEL__
-#if SPINLOCK_DEBUG
+#if CONFIG_DEBUG_SPINLOCK
 #define SPINLOCK_DEBUG_INIT     , 0, 0
 #else
 #define SPINLOCK_DEBUG_INIT     /* */
@@ -34,7 +32,7 @@
 #define spin_is_locked(x)	((x)->lock !=3D 0)
 #define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
=20
-#ifndef SPINLOCK_DEBUG
+#ifndef CONFIG_DEBUG_SPINLOCK
=20
 static inline void _raw_spin_lock(spinlock_t *lock)
 {
@@ -88,12 +86,12 @@
  */
 typedef struct {
 	volatile unsigned long lock;
-#ifdef SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 	volatile unsigned long owner_pc;
 #endif
 } rwlock_t;
=20
-#if SPINLOCK_DEBUG
+#if CONFIG_DEBUG_SPINLOCK
 #define RWLOCK_DEBUG_INIT     , 0
 #else
 #define RWLOCK_DEBUG_INIT     /* */
@@ -102,7 +100,7 @@
 #define RW_LOCK_UNLOCKED (rwlock_t) { 0 RWLOCK_DEBUG_INIT }
 #define rwlock_init(lp) do { *(lp) =3D RW_LOCK_UNLOCKED; } while(0)
=20
-#ifndef SPINLOCK_DEBUG
+#ifndef CONFIG_DEBUG_SPINLOCK
=20
 static __inline__ void _raw_read_lock(rwlock_t *rw)
 {
diff -urN linux-2.5.20/include/asm-x86_64/locks.h linux/include/asm-x86_6=
4/locks.h
--- linux-2.5.20/include/asm-x86_64/locks.h	2002-06-03 03:44:40.000000000=
 +0200
+++ linux/include/asm-x86_64/locks.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,135 +0,0 @@
-/*
- *	SMP locks primitives for building ix86 locks
- *	(not yet used).
- *
- *		Alan Cox, alan@redhat.com, 1995
- */
-=20
-/*
- *	This would be much easier but far less clear and easy
- *	to borrow for other processors if it was just assembler.
- */
-
-extern __inline__ void prim_spin_lock(struct spinlock *sp)
-{
-	int processor=3Dsmp_processor_id();
-=09
-	/*
-	 *	Grab the lock bit
-	 */
-	=20
-	while(lock_set_bit(0,&sp->lock))
-	{
-		/*
-		 *	Failed, but that's cos we own it!
-		 */
-		=20
-		if(sp->cpu=3D=3Dprocessor)
-		{
-			sp->users++;
-			return 0;
-		}
-		/*
-		 *	Spin in the cache S state if possible
-		 */
-		while(sp->lock)
-		{
-			/*
-			 *	Wait for any invalidates to go off
-			 */
-			=20
-			if(smp_invalidate_needed&(1<<processor))
-				while(lock_clear_bit(processor,&smp_invalidate_needed))
-					local_flush_tlb();
-			sp->spins++;
-		}
-		/*
-		 *	Someone wrote the line, we go 'I' and get
-		 *	the cache entry. Now try to regrab
-		 */
-	}
-	sp->users++;sp->cpu=3Dprocessor;
-	return 1;
-}
-
-/*
- *	Release a spin lock
- */
-=20
-extern __inline__ int prim_spin_unlock(struct spinlock *sp)
-{
-	/* This is safe. The decrement is still guarded by the lock. A multiloc=
k would
-	   not be safe this way */
-	if(!--sp->users)
-	{
-		sp->cpu=3D NO_PROC_ID;lock_clear_bit(0,&sp->lock);
-		return 1;
-	}
-	return 0;
-}
-
-
-/*
- *	Non blocking lock grab
- */
-=20
-extern __inline__ int prim_spin_lock_nb(struct spinlock *sp)
-{
-	if(lock_set_bit(0,&sp->lock))
-		return 0;		/* Locked already */
-	sp->users++;
-	return 1;			/* We got the lock */
-}
-
-
-/*
- *	These wrap the locking primitives up for usage
- */
-=20
-extern __inline__ void spinlock(struct spinlock *sp)
-{
-	if(sp->priority<current->lock_order)
-		panic("lock order violation: %s (%d)\n", sp->name, current->lock_order=
);
-	if(prim_spin_lock(sp))
-	{
-		/*
-		 *	We got a new lock. Update the priority chain
-		 */
-		sp->oldpri=3Dcurrent->lock_order;
-		current->lock_order=3Dsp->priority;
-	}
-}
-
-extern __inline__ void spinunlock(struct spinlock *sp)
-{
-	int pri;
-	if(current->lock_order!=3Dsp->priority)
-		panic("lock release order violation %s (%d)\n", sp->name, current->loc=
k_order);
-	pri=3Dsp->oldpri;
-	if(prim_spin_unlock(sp))
-	{
-		/*
-		 *	Update the debugging lock priority chain. We dumped
-		 *	our last right to the lock.
-		 */
-		current->lock_order=3Dsp->pri;
-	}=09
-}
-
-extern __inline__ void spintestlock(struct spinlock *sp)
-{
-	/*
-	 *	We do no sanity checks, it's legal to optimistically
-	 *	get a lower lock.
-	 */
-	prim_spin_lock_nb(sp);
-}
-
-extern __inline__ void spintestunlock(struct spinlock *sp)
-{
-	/*
-	 *	A testlock doesn't update the lock chain so we
-	 *	must not update it on free
-	 */
-	prim_spin_unlock(sp);
-}
diff -urN linux-2.5.20/include/asm-x86_64/spinlock.h linux/include/asm-x8=
6_64/spinlock.h
--- linux-2.5.20/include/asm-x86_64/spinlock.h	2002-06-03 03:44:53.000000=
000 +0200
+++ linux/include/asm-x86_64/spinlock.h	2002-06-09 04:58:38.000000000 +02=
00
@@ -9,30 +9,20 @@
 extern int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
=20
-/* It seems that people are forgetting to
- * initialize their spinlocks properly, tsk tsk.
- * Remember to turn this off in 2.4. -ben
- */
-#if defined(CONFIG_DEBUG_SPINLOCK)
-#define SPINLOCK_DEBUG	1
-#else
-#define SPINLOCK_DEBUG	0
-#endif
-
 /*
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
  */
=20
 typedef struct {
 	volatile unsigned int lock;
-#if SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 	unsigned magic;
 #endif
 } spinlock_t;
=20
 #define SPINLOCK_MAGIC	0xdead4ead
=20
-#if SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 #define SPINLOCK_MAGIC_INIT	, SPINLOCK_MAGIC
 #else
 #define SPINLOCK_MAGIC_INIT	/* */
@@ -82,7 +72,7 @@
=20
 static inline void _raw_spin_lock(spinlock_t *lock)
 {
-#if SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 	__label__ here;
 here:
 	if (lock->magic !=3D SPINLOCK_MAGIC) {
@@ -97,7 +87,7 @@
=20
 static inline void _raw_spin_unlock(spinlock_t *lock)
 {
-#if SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 	if (lock->magic !=3D SPINLOCK_MAGIC)
 		BUG();
 	if (!spin_is_locked(lock))
@@ -120,14 +110,14 @@
  */
 typedef struct {
 	volatile unsigned int lock;
-#if SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 	unsigned magic;
 #endif
 } rwlock_t;
=20
 #define RWLOCK_MAGIC	0xdeaf1eed
=20
-#if SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 #define RWLOCK_MAGIC_INIT	, RWLOCK_MAGIC
 #else
 #define RWLOCK_MAGIC_INIT	/* */
@@ -150,7 +140,7 @@
=20
 extern inline void _raw_read_lock(rwlock_t *rw)
 {
-#if SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 	if (rw->magic !=3D RWLOCK_MAGIC)
 		BUG();
 #endif
@@ -159,7 +149,7 @@
=20
 static inline void _raw_write_lock(rwlock_t *rw)
 {
-#if SPINLOCK_DEBUG
+#ifdef CONFIG_DEBUG_SPINLOCK
 	if (rw->magic !=3D RWLOCK_MAGIC)
 		BUG();
 #endif
diff -urN linux-2.5.20/include/linux/spinlock.h linux/include/linux/spinl=
ock.h
--- linux-2.5.20/include/linux/spinlock.h	2002-06-03 03:44:49.000000000 +=
0200
+++ linux/include/linux/spinlock.h	2002-06-09 04:58:38.000000000 +0200
@@ -62,13 +62,9 @@
 #elif !defined(spin_lock_init) /* !SMP and spin_lock_init not previously=

                                   defined (e.g. by including asm/spinloc=
k.h */
=20
-#define DEBUG_SPINLOCKS	0	/* 0 =3D=3D no debugging, 1 =3D=3D maintain lo=
ck state, 2 =3D=3D full debug */
-
-#if (DEBUG_SPINLOCKS < 1)
-
 #ifndef CONFIG_PREEMPT
-#define atomic_dec_and_lock(atomic,lock) atomic_dec_and_test(atomic)
-#define ATOMIC_DEC_AND_LOCK
+# define atomic_dec_and_lock(atomic,lock) atomic_dec_and_test(atomic)
+# define ATOMIC_DEC_AND_LOCK
 #endif
=20
 /*
@@ -78,10 +74,10 @@
  */
 #if (__GNUC__ > 2)
   typedef struct { } spinlock_t;
-  #define SPIN_LOCK_UNLOCKED (spinlock_t) { }
+# define SPIN_LOCK_UNLOCKED (spinlock_t) { }
 #else
   typedef struct { int gcc_is_buggy; } spinlock_t;
-  #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
+# define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
 #endif
=20
 #define spin_lock_init(lock)	do { (void)(lock); } while(0)
@@ -91,42 +87,6 @@
 #define spin_unlock_wait(lock)	do { (void)(lock); } while(0)
 #define _raw_spin_unlock(lock)	do { (void)(lock); } while(0)
=20
-#elif (DEBUG_SPINLOCKS < 2)
-
-typedef struct {
-	volatile unsigned long lock;
-} spinlock_t;
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
-
-#define spin_lock_init(x)	do { (x)->lock =3D 0; } while (0)
-#define spin_is_locked(lock)	(test_bit(0,(lock)))
-#define spin_trylock(lock)	(!test_and_set_bit(0,(lock)))
-
-#define spin_lock(x)		do { (x)->lock =3D 1; } while (0)
-#define spin_unlock_wait(x)	do { } while (0)
-#define spin_unlock(x)		do { (x)->lock =3D 0; } while (0)
-
-#else /* (DEBUG_SPINLOCKS >=3D 2) */
-
-typedef struct {
-	volatile unsigned long lock;
-	volatile unsigned int babble;
-	const char *module;
-} spinlock_t;
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { 0, 25, __BASE_FILE__ }
-
-#include <linux/kernel.h>
-
-#define spin_lock_init(x)	do { (x)->lock =3D 0; } while (0)
-#define spin_is_locked(lock)	(test_bit(0,(lock)))
-#define spin_trylock(lock)	(!test_and_set_bit(0,(lock)))
-
-#define spin_lock(x)		do {unsigned long __spinflags; save_flags(__spinfl=
ags); cli(); if ((x)->lock&&(x)->babble) {printk("%s:%d: spin_lock(%s:%p)=
 already locked\n", __BASE_FILE__,__LINE__, (x)->module, (x));(x)->babble=
--;} (x)->lock =3D 1; restore_flags(__spinflags);} while (0)
-#define spin_unlock_wait(x)	do {unsigned long __spinflags; save_flags(__=
spinflags); cli(); if ((x)->lock&&(x)->babble) {printk("%s:%d: spin_unloc=
k_wait(%s:%p) deadlock\n", __BASE_FILE__,__LINE__, (x)->module, (x));(x)-=
>babble--;} restore_flags(__spinflags);} while (0)
-#define spin_unlock(x)		do {unsigned long __spinflags; save_flags(__spin=
flags); cli(); if (!(x)->lock&&(x)->babble) {printk("%s:%d: spin_unlock(%=
s:%p) not locked\n", __BASE_FILE__,__LINE__, (x)->module, (x));(x)->babbl=
e--;} (x)->lock =3D 0; restore_flags(__spinflags);} while (0)
-
-#endif	/* DEBUG_SPINLOCKS */
-
 /*
  * Read-write spinlocks, allowing multiple readers
  * but only one writer.

--------------040705070500040101090800--

