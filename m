Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282489AbRLXExt>; Sun, 23 Dec 2001 23:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282497AbRLXExb>; Sun, 23 Dec 2001 23:53:31 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:9744 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S282489AbRLXEx0>;
	Sun, 23 Dec 2001 23:53:26 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        linux-kernel@vger.kernel.org
Subject: Re: How to fix false positives on references to discarded text/data? 
In-Reply-To: Your message of "Sun, 23 Dec 2001 16:15:47 -0800."
             <3C2673B3.78E21527@zip.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 24 Dec 2001 15:53:00 +1100
Message-ID: <27651.1009169580@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2001 16:15:47 -0800, 
Andrew Morton <akpm@zip.com.au> wrote:
>Kai Germaschewski wrote:
>> 
>>         asm volatile(LOCK "subl $1,(%0)\n\t" \
>>                      "js 2f\n" \
>>                      "1:\n" \
>> -                    ".section .text.lock,\"ax\"\n" \
>> +                    ".subsection 1\n" \
>>                      "2:\tcall " helper "\n\t" \
>>                      "jmp 1b\n" \
>>                      ".previous" \
>
>Don't we want `.subsection 0' here, rather than .previous?
>
>Apart from that, it looks like a winner.

One downside, subsections mess up backtrace.  The out of line code
shows up as belonging to the last function in subsection 0, which will
confuse users.  It will also break kdb backtrace which knows that the
out of line code in section .text.lock is special.

Easily fixed, add label .text.lock.basename at the start of each chunk
of subsection 1 code.  As an added bonus, oops backtrace and ksymoops
will now say .text.lock.floppy+offset instead of stext_lock+some large
number, IOW the traces will show which source the failing lock is in.
Not 100% unambiguous because some sources have the same base name, but
better than we already have, the rest of the trace should help
disambiguate the problem source.

gcc/as generates worse code for the local branches in the out of line
subsection.  With .text.lock we get

   0:   80 bd f8 00 00 00 00    cmpb   $0x0,0xf8(%ebp)
   7:   f3 90                   repz nop 
   9:   7e f5                   jle    0 <.text.lock>		<=== 2 bytes
   b:   e9 ca 01 00 00          jmp    1da <.text.lock+0x1da>

With .subsection 1 it generates

.text.lock.es1371:
6387:   80 bd f8 00 00 00 00    cmpb   $0x0,0xf8(%ebp)
638e:   f3 90                   repz nop 
6390:   0f 8e f1 ff ff ff       jle    6387 <.text.lock.es1371>	<=== 6 bytes
6396:   e9 33 9e ff ff          jmp    1ce <set_adc_rate+0x8e>

The inline code is unchanged, it is only the out of line code that is
bigger.  IMHO the subsection difference is a gcc/as bug which should
not stop us using this fix.

Unless anybody objects, I will send this patch to Marcelo and, once it
is in 2.4.18-pre, do separate patches for each architecture.  Normally
I would apply this to 2.5 first then backport to 2.4 but 2.5 is not
taking patches at the moment (it does not even have the __devexit fix)
and this problem is already affecting 2.4 users.


============ patch 2.4.17

Drop section .text.lock, use subsections in the current section instead
to avoid dangling references to discarded sections and give better
debugging on oops.  Add a standard __stringify macro instead of
everybody writing their own macros.  Kai Germaschewski, Keith Owens.

Index: 17.1/include/asm-i386/rwlock.h
--- 17.1/include/asm-i386/rwlock.h Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/T/20_rwlock.h 1.1 644)
+++ 17.1(w)/include/asm-i386/rwlock.h Mon, 24 Dec 2001 15:26:16 +1100 kaos (linux-2.4/T/20_rwlock.h 1.1 644)
@@ -17,6 +17,8 @@
 #ifndef _ASM_I386_RWLOCK_H
 #define _ASM_I386_RWLOCK_H
 
+#include <linux/stringify.h>
+
 #define RW_LOCK_BIAS		 0x01000000
 #define RW_LOCK_BIAS_STR	"0x01000000"
 
@@ -24,23 +26,29 @@
 	asm volatile(LOCK "subl $1,(%0)\n\t" \
 		     "js 2f\n" \
 		     "1:\n" \
-		     ".section .text.lock,\"ax\"\n" \
+		     ".subsection 1\n" \
+		     ".ifndef .text.lock." __stringify(KBUILD_BASENAME) "\n" \
+		     ".text.lock." __stringify(KBUILD_BASENAME) ":\n" \
+		     ".endif\n" \
 		     "2:\tcall " helper "\n\t" \
 		     "jmp 1b\n" \
-		     ".previous" \
+		     ".subsection 0\n" \
 		     ::"a" (rw) : "memory")
 
 #define __build_read_lock_const(rw, helper)   \
 	asm volatile(LOCK "subl $1,%0\n\t" \
 		     "js 2f\n" \
 		     "1:\n" \
-		     ".section .text.lock,\"ax\"\n" \
+		     ".subsection 1\n" \
+		     ".ifndef .text.lock." __stringify(KBUILD_BASENAME) "\n" \
+		     ".text.lock." __stringify(KBUILD_BASENAME) ":\n" \
+		     ".endif\n" \
 		     "2:\tpushl %%eax\n\t" \
 		     "leal %0,%%eax\n\t" \
 		     "call " helper "\n\t" \
 		     "popl %%eax\n\t" \
 		     "jmp 1b\n" \
-		     ".previous" \
+		     ".subsection 0\n" \
 		     :"=m" (*(volatile int *)rw) : : "memory")
 
 #define __build_read_lock(rw, helper)	do { \
@@ -54,23 +62,29 @@
 	asm volatile(LOCK "subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
 		     "jnz 2f\n" \
 		     "1:\n" \
-		     ".section .text.lock,\"ax\"\n" \
+		     ".subsection 1\n" \
+		     ".ifndef .text.lock." __stringify(KBUILD_BASENAME) "\n" \
+		     ".text.lock." __stringify(KBUILD_BASENAME) ":\n" \
+		     ".endif\n" \
 		     "2:\tcall " helper "\n\t" \
 		     "jmp 1b\n" \
-		     ".previous" \
+		     ".subsection 0\n" \
 		     ::"a" (rw) : "memory")
 
 #define __build_write_lock_const(rw, helper) \
 	asm volatile(LOCK "subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
 		     "jnz 2f\n" \
 		     "1:\n" \
-		     ".section .text.lock,\"ax\"\n" \
+		     ".subsection 1\n" \
+		     ".ifndef .text.lock." __stringify(KBUILD_BASENAME) "\n" \
+		     ".text.lock." __stringify(KBUILD_BASENAME) ":\n" \
+		     ".endif\n" \
 		     "2:\tpushl %%eax\n\t" \
 		     "leal %0,%%eax\n\t" \
 		     "call " helper "\n\t" \
 		     "popl %%eax\n\t" \
 		     "jmp 1b\n" \
-		     ".previous" \
+		     ".subsection 0\n" \
 		     :"=m" (*(volatile int *)rw) : : "memory")
 
 #define __build_write_lock(rw, helper)	do { \
Index: 17.1/include/asm-i386/spinlock.h
--- 17.1/include/asm-i386/spinlock.h Fri, 26 Oct 2001 15:50:03 +1000 kaos (linux-2.4/T/50_spinlock.h 1.1.2.2 644)
+++ 17.1(w)/include/asm-i386/spinlock.h Mon, 24 Dec 2001 15:34:15 +1100 kaos (linux-2.4/T/50_spinlock.h 1.1.2.2 644)
@@ -5,6 +5,7 @@
 #include <asm/rwlock.h>
 #include <asm/page.h>
 #include <linux/config.h>
+#include <linux/stringify.h>
 
 extern int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
@@ -56,7 +57,10 @@ typedef struct {
 	"\n1:\t" \
 	"lock ; decb %0\n\t" \
 	"js 2f\n" \
-	".section .text.lock,\"ax\"\n" \
+	".subsection 1\n" \
+	".ifndef .text.lock." __stringify(KBUILD_BASENAME) "\n" \
+	".text.lock." __stringify(KBUILD_BASENAME) ":\n" \
+	".endif\n" \
 	"2:\t" \
 	"cmpb $0,%0\n\t" \
 	"rep;nop\n\t" \
Index: 17.1/include/asm-i386/softirq.h
--- 17.1/include/asm-i386/softirq.h Sun, 09 Sep 2001 19:22:07 +1000 kaos (linux-2.4/T/51_softirq.h 1.8.1.1 644)
+++ 17.1(w)/include/asm-i386/softirq.h Mon, 24 Dec 2001 15:46:39 +1100 kaos (linux-2.4/T/51_softirq.h 1.8.1.1 644)
@@ -3,6 +3,7 @@
 
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
+#include <linux/stringify.h>
 
 #define __cpu_bh_enable(cpu) \
 		do { barrier(); local_bh_count(cpu)--; } while (0)
@@ -33,12 +34,15 @@ do {									\
 			"jnz 2f;"					\
 			"1:;"						\
 									\
-			".section .text.lock,\"ax\";"			\
+			".subsection 1;"				\
+			".ifndef .text.lock." __stringify(KBUILD_BASENAME) "\n"		\
+			".text.lock." __stringify(KBUILD_BASENAME) ":\n"		\
+			".endif\n"					\
 			"2: pushl %%eax; pushl %%ecx; pushl %%edx;"	\
 			"call %c1;"					\
 			"popl %%edx; popl %%ecx; popl %%eax;"		\
 			"jmp 1b;"					\
-			".previous;"					\
+			".subsection 0;"				\
 									\
 		: /* no output */					\
 		: "r" (ptr), "i" (do_softirq)				\
Index: 17.1/include/asm-i386/semaphore.h
--- 17.1/include/asm-i386/semaphore.h Fri, 14 Sep 2001 12:20:01 +1000 kaos (linux-2.4/U/13_semaphore. 1.1.1.3 644)
+++ 17.1(w)/include/asm-i386/semaphore.h Mon, 24 Dec 2001 15:46:39 +1100 kaos (linux-2.4/U/13_semaphore. 1.1.1.3 644)
@@ -40,6 +40,7 @@
 #include <asm/atomic.h>
 #include <linux/wait.h>
 #include <linux/rwsem.h>
+#include <linux/stringify.h>
 
 struct semaphore {
 	atomic_t count;
@@ -122,10 +123,13 @@ static inline void down(struct semaphore
 		LOCK "decl %0\n\t"     /* --sem->count */
 		"js 2f\n"
 		"1:\n"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
+		".ifndef .text.lock." __stringify(KBUILD_BASENAME) "\n"
+		".text.lock." __stringify(KBUILD_BASENAME) ":\n"
+		".endif\n"
 		"2:\tcall __down_failed\n\t"
 		"jmp 1b\n"
-		".previous"
+		".subsection 0\n"
 		:"=m" (sem->count)
 		:"c" (sem)
 		:"memory");
@@ -149,10 +153,13 @@ static inline int down_interruptible(str
 		"js 2f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
+		".ifndef .text.lock." __stringify(KBUILD_BASENAME) "\n"
+		".text.lock." __stringify(KBUILD_BASENAME) ":\n"
+		".endif\n"
 		"2:\tcall __down_failed_interruptible\n\t"
 		"jmp 1b\n"
-		".previous"
+		".subsection 0\n"
 		:"=a" (result), "=m" (sem->count)
 		:"c" (sem)
 		:"memory");
@@ -177,10 +184,13 @@ static inline int down_trylock(struct se
 		"js 2f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
+		".ifndef .text.lock." __stringify(KBUILD_BASENAME) "\n"
+		".text.lock." __stringify(KBUILD_BASENAME) ":\n"
+		".endif\n"
 		"2:\tcall __down_failed_trylock\n\t"
 		"jmp 1b\n"
-		".previous"
+		".subsection 0\n"
 		:"=a" (result), "=m" (sem->count)
 		:"c" (sem)
 		:"memory");
@@ -203,10 +213,13 @@ static inline void up(struct semaphore *
 		LOCK "incl %0\n\t"     /* ++sem->count */
 		"jle 2f\n"
 		"1:\n"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
+		".ifndef .text.lock." __stringify(KBUILD_BASENAME) "\n"
+		".text.lock." __stringify(KBUILD_BASENAME) ":\n"
+		".endif\n"
 		"2:\tcall __up_wakeup\n\t"
 		"jmp 1b\n"
-		".previous"
+		".subsection 0\n"
 		:"=m" (sem->count)
 		:"c" (sem)
 		:"memory");
Index: 17.1/arch/i386/vmlinux.lds
--- 17.1/arch/i386/vmlinux.lds Tue, 03 Jul 2001 11:11:12 +1000 kaos (linux-2.4/R/c/35_vmlinux.ld 1.1.4.1 644)
+++ 17.1(w)/arch/i386/vmlinux.lds Mon, 24 Dec 2001 13:01:08 +1100 kaos (linux-2.4/R/c/35_vmlinux.ld 1.1.4.1 644)
@@ -13,7 +13,6 @@ SECTIONS
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x9090
-  .text.lock : { *(.text.lock) }	/* out-of-line lock text */
 
   _etext = .;			/* End of text section */
 
Index: 17.1/arch/i386/boot/compressed/Makefile
--- 17.1/arch/i386/boot/compressed/Makefile Fri, 14 Sep 2001 12:20:01 +1000 kaos (linux-2.4/T/c/42_Makefile 1.2 644)
+++ 17.1(w)/arch/i386/boot/compressed/Makefile Mon, 24 Dec 2001 15:28:45 +1100 kaos (linux-2.4/T/c/42_Makefile 1.2 644)
@@ -33,7 +33,7 @@ head.o: head.S
 	$(CC) $(AFLAGS) -traditional -c head.S
 
 misc.o: misc.c
-	$(CC) $(CFLAGS) -c misc.c
+	$(CC) $(CFLAGS) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) -c misc.c
 
 piggy.o:	$(SYSTEM)
 	tmppiggy=_tmp_$$$$piggy; \
Index: 17.1/Rules.make
--- 17.1/Rules.make Wed, 07 Mar 2001 23:04:43 +1100 kaos (linux-2.4/T/c/47_Rules.make 1.1.2.2 644)
+++ 17.1(w)/Rules.make Mon, 24 Dec 2001 15:29:41 +1100 kaos (linux-2.4/T/c/47_Rules.make 1.1.2.2 644)
@@ -31,6 +31,8 @@ unexport subdir-m
 unexport subdir-n
 unexport subdir-
 
+comma	:= ,
+
 #
 # Get things started.
 #
@@ -54,7 +56,7 @@ ALL_SUB_DIRS	:= $(sort $(subdir-y) $(sub
 	$(CPP) $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) $< > $@
 
 %.o: %.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) -c -o $@ $<
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) $(CFLAGS_$@) -c -o $@ $<
 	@ ( \
 	    echo 'ifeq ($(strip $(subst $(comma),:,$(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@))),$$(strip $$(subst $$(comma),:,$$(CFLAGS) $$(EXTRA_CFLAGS) $$(CFLAGS_$@))))' ; \
 	    echo 'FILES_FLAGS_UP_TO_DATE += $@' ; \
@@ -270,7 +272,7 @@ endif # CONFIG_MODVERSIONS
 
 ifneq "$(strip $(export-objs))" ""
 $(export-objs): $(export-objs:.o=.c) $(TOPDIR)/include/linux/modversions.h
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) -DEXPORT_SYMTAB -c $(@:.o=.c)
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) $(CFLAGS_$@) -DEXPORT_SYMTAB -c $(@:.o=.c)
 	@ ( \
 	    echo 'ifeq ($(strip $(subst $(comma),:,$(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) -DEXPORT_SYMTAB)),$$(strip $$(subst $$(comma),:,$$(CFLAGS) $$(EXTRA_CFLAGS) $$(CFLAGS_$@) -DEXPORT_SYMTAB)))' ; \
 	    echo 'FILES_FLAGS_UP_TO_DATE += $@' ; \
Index: 17.1/Makefile
--- 17.1/Makefile Sat, 22 Dec 2001 12:56:52 +1100 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29.1.40 644)
+++ 17.1(w)/Makefile Mon, 24 Dec 2001 15:29:22 +1100 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29.1.40 644)
@@ -330,10 +330,10 @@ include/linux/version.h: ./Makefile
 	@mv -f .ver $@
 
 init/version.o: init/version.c include/linux/compile.h include/config/MARKER
-	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) -DUTS_MACHINE='"$(ARCH)"' -c -o init/version.o init/version.c
+	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) -DUTS_MACHINE='"$(ARCH)"' -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) -c -o init/version.o init/version.c
 
 init/main.o: init/main.c include/config/MARKER
-	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) $(PROFILING) -c -o $*.o $<
+	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) $(PROFILING) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) -c -o $*.o $<
 
 fs lib mm ipc kernel drivers net: dummy
 	$(MAKE) CFLAGS="$(CFLAGS) $(CFLAGS_KERNEL)" $(subst $@, _dir_$@, $@)
Index: 17.1/include/asm-i386/rwsem.h
--- 17.1/include/asm-i386/rwsem.h Thu, 26 Apr 2001 12:48:22 +1000 kaos (linux-2.4/K/d/10_rwsem.h 1.5 644)
+++ 17.1(w)/include/asm-i386/rwsem.h Mon, 24 Dec 2001 15:46:39 +1100 kaos (linux-2.4/K/d/10_rwsem.h 1.5 644)
@@ -40,6 +40,7 @@
 
 #include <linux/list.h>
 #include <linux/spinlock.h>
+#include <linux/stringify.h>
 
 struct rwsem_waiter;
 
@@ -101,7 +102,10 @@ static inline void __down_read(struct rw
 LOCK_PREFIX	"  incl      (%%eax)\n\t" /* adds 0x00000001, returns the old value */
 		"  js        2f\n\t" /* jump if we weren't granted the lock */
 		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
+		".ifndef .text.lock." __stringify(KBUILD_BASENAME) "\n"
+		".text.lock." __stringify(KBUILD_BASENAME) ":\n"
+		".endif\n"
 		"2:\n\t"
 		"  pushl     %%ecx\n\t"
 		"  pushl     %%edx\n\t"
@@ -109,7 +113,7 @@ LOCK_PREFIX	"  incl      (%%eax)\n\t" /*
 		"  popl      %%edx\n\t"
 		"  popl      %%ecx\n\t"
 		"  jmp       1b\n"
-		".previous"
+		".subsection 0\n"
 		"# ending down_read\n\t"
 		: "+m"(sem->count)
 		: "a"(sem)
@@ -130,13 +134,16 @@ LOCK_PREFIX	"  xadd      %0,(%%eax)\n\t"
 		"  testl     %0,%0\n\t" /* was the count 0 before? */
 		"  jnz       2f\n\t" /* jump if we weren't granted the lock */
 		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
+		".ifndef .text.lock." __stringify(KBUILD_BASENAME) "\n"
+		".text.lock." __stringify(KBUILD_BASENAME) ":\n"
+		".endif\n"
 		"2:\n\t"
 		"  pushl     %%ecx\n\t"
 		"  call      rwsem_down_write_failed\n\t"
 		"  popl      %%ecx\n\t"
 		"  jmp       1b\n"
-		".previous\n"
+		".subsection 0\n"
 		"# ending down_write"
 		: "+d"(tmp), "+m"(sem->count)
 		: "a"(sem)
@@ -154,7 +161,10 @@ static inline void __up_read(struct rw_s
 LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n\t" /* subtracts 1, returns the old value */
 		"  js        2f\n\t" /* jump if the lock is being waited upon */
 		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
+		".ifndef .text.lock." __stringify(KBUILD_BASENAME) "\n"
+		".text.lock." __stringify(KBUILD_BASENAME) ":\n"
+		".endif\n"
 		"2:\n\t"
 		"  decw      %%dx\n\t" /* do nothing if still outstanding active readers */
 		"  jnz       1b\n\t"
@@ -162,7 +172,7 @@ LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n
 		"  call      rwsem_wake\n\t"
 		"  popl      %%ecx\n\t"
 		"  jmp       1b\n"
-		".previous\n"
+		".subsection 0\n"
 		"# ending __up_read\n"
 		: "+m"(sem->count), "+d"(tmp)
 		: "a"(sem)
@@ -180,7 +190,10 @@ static inline void __up_write(struct rw_
 LOCK_PREFIX	"  xaddl     %%edx,(%%eax)\n\t" /* tries to transition 0xffff0001 -> 0x00000000 */
 		"  jnz       2f\n\t" /* jump if the lock is being waited upon */
 		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
+		".ifndef .text.lock." __stringify(KBUILD_BASENAME) "\n"
+		".text.lock." __stringify(KBUILD_BASENAME) ":\n"
+		".endif\n"
 		"2:\n\t"
 		"  decw      %%dx\n\t" /* did the active count reduce to 0? */
 		"  jnz       1b\n\t" /* jump back if not */
@@ -188,7 +201,7 @@ LOCK_PREFIX	"  xaddl     %%edx,(%%eax)\n
 		"  call      rwsem_wake\n\t"
 		"  popl      %%ecx\n\t"
 		"  jmp       1b\n"
-		".previous\n"
+		".subsection 0\n"
 		"# ending __up_write\n"
 		: "+m"(sem->count)
 		: "a"(sem), "i"(-RWSEM_ACTIVE_WRITE_BIAS)
Index: 17.1/include/linux/stringify.h
--- 17.1/include/linux/stringify.h Mon, 24 Dec 2001 15:49:02 +1100 kaos ()
+++ 17.1(w)/include/linux/stringify.h Mon, 24 Dec 2001 15:48:13 +1100 kaos (linux-2.4/O/f/50_stringify.  644)
@@ -0,0 +1,12 @@
+#ifndef __LINUX_STRINGIFY_H
+#define __LINUX_STRINGIFY_H
+
+/* Indirect stringification.  Doing two levels allows the parameter to be a
+ * macro itself.  For example, compile with -DFOO=bar, __stringify(FOO)
+ * converts to "bar".
+ */
+
+#define __stringify_1(x)	#x
+#define __stringify(x)		__stringify_1(x)
+
+#endif	/* !__LINUX_STRINGIFY_H */

