Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314553AbSF3Ehi>; Sun, 30 Jun 2002 00:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314596AbSF3Ehh>; Sun, 30 Jun 2002 00:37:37 -0400
Received: from aboukir-101-1-23-willy.adsl.nerim.net ([62.212.114.60]:14341
	"EHLO www.home.local") by vger.kernel.org with ESMTP
	id <S314553AbSF3Ehc>; Sun, 30 Jun 2002 00:37:32 -0400
Date: Sun, 30 Jun 2002 06:39:50 +0200
From: Willy TARREAU <willy@w.ods.org>
To: linux-kernel@vger.kernel.org, Ronald.Wahl@informatik.tu-chemnitz.de
Subject: [ANNOUNCE] CMOV emulation for 2.4.19-rc1
Message-ID: <20020630043950.GA15516@pcw.home.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

OK, I know that many people dislike this, but I know others
who occasionally need it anyway. So I don't post it for general
inclusion, but for interested people.

What is it ? it's a software emulator for x86 opcodes not handled
by the processor. Emulations available are :
  - BSWAP, CMPXCHG, XADD on 386 (486 instructions)
  - CMOV on any x86 processor (pentium-pro instructions)

It is not meant to replace a correct compilation, but it may have
happened to all of us to try to rescue a damaged system or with a
boot disk, and copying some programs with a floppy, and then get
an 'Illegal instruction' because these programs have been compiled
with a badly configured compiler. I once had a gcc which did i686
by default, and I had a hard time trying to execute an e2fsck it
had compiled, on my k6 notebook !

Same if you take a disk from a system, and try to boot it on
another one. Well, I won't spend more time finding examples.

I've been using the 486 emulation on my 386 firewall for a few
years now, and have been quite happy with it. I cleaned the code
a bit and added support for cmov. All this will grow your bzImage
with less than 1kB.

As I stated above, it is *NOT* meant to replace a recompilation
for the correct target. Emulation is quite slow because of the
time the CPU spends processing the trap. I measured about 450
cycles for a cmov, which is quite a overhead, but still
acceptable for occasionnal purposes (1us on my k6/450).

I was thinking about adding some statistics informations, such
as the number of traps caught, globally and by process, but
finally realized that this was only bloat for something that
should not be used permanently.

I didn't have the time to try VMWare on top of this. It could
be interesting to be able to provide CMOV or other instructions
to guest systems.

Here is the patch against 2.4.19-rc1.

Comments and criticisms welcome, but flames to /dev/null.

Cheers,
Willy


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-2.4.19-rc1-emux86-0.2"

diff -ur 2.4.19-rc1/Documentation/Configure.help 2.4.19-rc1-emux86-0.2/Documentation/Configure.help
--- 2.4.19-rc1/Documentation/Configure.help	Sun Jun 30 03:21:56 2002
+++ 2.4.19-rc1-emux86-0.2/Documentation/Configure.help	Sun Jun 30 06:05:58 2002
@@ -3985,6 +3985,66 @@
   Select this for a Pentium Classic processor with the RDTSC (Read
   Time Stamp Counter) instruction for benchmarking.
 
+486 emulation
+CONFIG_CPU_EMU486
+  When used on a 386, Linux can emulate 3 instructions from the 486 set.
+  This allows user space programs compiled for 486 to run on a 386
+  without crashing with a SIGILL. As any emulation, performance will be
+  very low, but since these instruction are not often used, this might
+  not hurt. The emulated instructions are :
+     - bswap (does the same as htonl())
+     - cmpxchg (used in multi-threading, mutex locking)
+     - xadd (rarely used)
+
+  Note that this can also allow Step-A 486's to correctly run multi-thread
+  applications since cmpxchg has a wrong opcode on this early CPU.
+
+  Don't use this to enable multi-threading on an SMP machine, the lock
+  atomicity can't be guaranted !
+
+  Although it's highly preferable that you only execute programs targetted
+  for your CPU, it may happen that, consecutively to a hardware replacement,
+  or during rescue of a damaged system, you have to execute such programs
+  on an inadapted processor. In this case, this option will help you get
+  your programs working, even if they will be slower.
+
+  It is recommended that you say N here in any case, except for the
+  kernels that you will use on your rescue disks.
+  
+  This option should not be left on by default, because it means that
+  you execute a program not targetted for your CPU. You should recompile
+  your applications whenever possible.
+
+  If you are not sure, say N.
+
+Pentium-Pro CMOV emulation
+CONFIG_CPU_EMU686
+  Intel Pentium-Pro processor brought a new set of instructions borrowed
+  from RISC processors, which permit to write many simple conditionnal
+  blocks without a branch instruction, thus being faster. They are supported
+  on all PentiumII, PentiumIII, Pentium4 and Celerons to date. GCC generates
+  these instructions when "-march=i686" is specified. There is an ever
+  increasing number of programs compiled with this option, that will simply
+  crash on 386/486/Pentium/AmdK6 and others when trying to execute the
+  faulty instruction.
+
+  Although it's highly preferable that you only execute programs targetted
+  for your CPU, it may happen that, consecutively to a hardware replacement,
+  or during rescue of a damaged system, you have to execute such programs
+  on an inadapted processor. In this case, this option will help you keep
+  your programs working, even if some may be noticeably slower : an overhead
+  of 1us has been measured on a k6-2/450 (about 450 cycles).
+
+  It is recommended that you say N here in any case, except for the
+  kernels that you will use on your rescue disks. This emulation typically
+  increases a bzImage with 500 bytes.
+  
+  This option should not be left on by default, because it means that
+  you execute a program not targetted for your CPU. You should recompile
+  your applications whenever possible.
+
+  If you are not sure, say N.
+
 32-bit PDC
 CONFIG_PDC_NARROW
   Saying Y here will allow developers with a C180, C200, C240, C360,
diff -ur 2.4.19-rc1/arch/i386/config.in 2.4.19-rc1-emux86-0.2/arch/i386/config.in
--- 2.4.19-rc1/arch/i386/config.in	Sun Jun 30 03:22:07 2002
+++ 2.4.19-rc1-emux86-0.2/arch/i386/config.in	Sun Jun 30 03:22:38 2002
@@ -54,6 +54,8 @@
    define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
    define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
    define_bool CONFIG_X86_PPRO_FENCE y
+   bool '486 emulation' CONFIG_CPU_EMU486
+   dep_bool 'Pentium-Pro CMOV emulation' CONFIG_CPU_EMU686 $CONFIG_CPU_EMU486
 else
    define_bool CONFIG_X86_WP_WORKS_OK y
    define_bool CONFIG_X86_INVLPG y
@@ -63,6 +65,7 @@
    define_bool CONFIG_X86_POPAD_OK y
    define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
    define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
+   bool 'Pentium-Pro CMOV emulation' CONFIG_CPU_EMU686
 fi
 if [ "$CONFIG_M486" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
diff -ur 2.4.19-rc1/arch/i386/kernel/traps.c 2.4.19-rc1-emux86-0.2/arch/i386/kernel/traps.c
--- 2.4.19-rc1/arch/i386/kernel/traps.c	Sun Jun 30 03:22:15 2002
+++ 2.4.19-rc1-emux86-0.2/arch/i386/kernel/traps.c	Sun Jun 30 05:33:18 2002
@@ -85,6 +85,24 @@
 asmlinkage void spurious_interrupt_bug(void);
 asmlinkage void machine_check(void);
 
+#if defined(CONFIG_CPU_EMU486) || defined(CONFIG_CPU_EMU686)
+asmlinkage void do_general_protection(struct pt_regs * regs, long error_code);
+
+/* gives the address of any register member in a struct pt_regs */
+static const int reg_ofs[8] = {
+	(int)&((struct pt_regs *)0)->eax,
+	(int)&((struct pt_regs *)0)->ecx,
+	(int)&((struct pt_regs *)0)->edx,
+	(int)&((struct pt_regs *)0)->ebx,
+	(int)&((struct pt_regs *)0)->esp,
+	(int)&((struct pt_regs *)0)->ebp,
+	(int)&((struct pt_regs *)0)->esi,
+	(int)&((struct pt_regs *)0)->edi
+};
+
+#define REG_PTR(regs, reg) ((unsigned long *)(((void *)(regs)) + reg_ofs[reg]))
+#endif
+
 int kstack_depth_to_print = 24;
 
 
@@ -371,11 +389,514 @@
 	do_trap(trapnr, signr, str, 1, regs, error_code, &info); \
 }
 
+#if defined(CONFIG_CPU_EMU486) || defined(CONFIG_CPU_EMU686)
+/* This code can be used to allow old 386's to hopefully correctly execute some
+ * code which was originally compiled for a 486, and to allow CMOV-disabled
+ * processors to emulate CMOV instructions. In user space, only 3 instructions
+ * have been added between the 386 the 486 :
+ *    - BSWAP reg		performs exactly htonl())
+ *    - CMPXCHG reg/mem, reg	used for mutex locking
+ *    - XADD reg/mem, reg	not encountered yet.
+ *
+ * Warning: this will NEVER allow a kernel compiled for a 486 to boot on a 386,
+ * neither will it allow a CMOV-optimized kernel to run on a processor without
+ * CMOV ! It will only help to port programs, or save you on a rescue disk, but
+ * for performance's sake, it's far better to recompile.
+ *
+ * Tests patterns have been submitted to this code on a 386, and it now seems
+ * OK. If you think you've found a bug, please report it to
+ * Willy Tarreau <willy@meta-x.org>.
+ */
+
+/* [modrm_address] returns a pointer to a user-space location by decoding the
+ * mod/rm byte and the bytes at <from>, which point to the mod/reg/rm byte.
+ * This must only be called if modrm indicates memory and not register. The
+ * <from> parameter is updated when bytes are read.
+ */
+static void *modrm_address(struct pt_regs *regs, unsigned char **from,
+                           char w, char bit32, unsigned char modrm)
+{
+	unsigned long int offset=0;
+	unsigned char sib;
+
+	/* we'll behave differently in 16 and 32 bits mode */
+	if (bit32) {  /* 32-bits addressing mode (default) */
+		if ((modrm & 0xC7) == 0x05) { /* 32 bits offset and nothing more */
+			offset = **from + (((int)*(*from+1)) << 8) +
+				(((int)*(*from+2)) << 16) + (((int)*(*from+3)) << 24);
+			*from += 4;
+			return (void *)offset;
+		}
+		
+		if ((modrm & 0x07) != 0x04)
+			offset += *REG_PTR(regs, modrm & 0x07);
+		else {
+			/* SIB byte is present and must be used */
+			sib=*(*from)++;
+
+			/* index * scale */
+			if (((sib >> 3) & 0x07) != 0x04)
+				offset += *REG_PTR(regs, (sib >> 3) & 0x07) << (sib >> 6);
+
+			if (((sib & 0x07) == 5) && ((modrm & 0xC0) == 0)) {
+				/* base off32 + scaled index */
+				offset += **from + (((int)*(*from+1)) << 8) +
+					(((int)*(*from+2)) << 16) + (((int)*(*from+3)) << 24);
+				*from += 4;
+				return (void *)offset;
+			}
+			/* base */
+			offset += *REG_PTR(regs, sib & 0x07);
+		}
+	
+		if ((modrm & 0xC0) == 0x40) {  /* 8 bits signed offset */
+			offset += *(signed char *)((*from)++);
+		} else if ((modrm & 0xC0) == 0x80) { /* 32 bits unsigned offset */
+			offset += **from + (((int)*(*from+1)) << 8) +
+				(((int)*(*from+2)) << 16) + (((int)*(*from+3)) << 24);
+			*from += 4;
+		}
+		return (void *)offset;  /* return the 32 bits offset */
+	} else { /* 16-bits addressing mode */
+		/* handle special case now */
+		if ((modrm & 0xC7) == 0x06) { /* 16 bits offset */
+			offset = **from + (((int)*(*from+1)) << 8);
+			*from += 2;
+			return (void *)offset;
+		}
+
+		if ((modrm & 4) == 0)
+			offset += (modrm & 2) ? regs->ebp : regs->ebx;
+		if ((modrm & 7) < 6)
+			offset += (modrm & 1) ? regs->edi : regs->esi;
+		else if ((modrm & 7) == 6)  /* bp */
+			offset += regs->ebp;
+		else if ((modrm & 7) == 7)  /* bx */
+			offset += regs->ebx;
+
+		/* now, let's include 8/16 bits offset */
+		if ((modrm & 0xC0) == 0x40) {  /* 8 bits signed offset */
+			offset += *(signed char *)((*from)++);
+		} else if ((modrm & 0xC0) == 0x80) { /* 16 bits unsigned offset */
+			offset += **from + (((int)*(*from+1)) << 8);
+			*from += 2;
+		}
+		return (void *)(offset & 0xFFFF);
+	}
+}
+
+
+/*
+ * skip_modrm() computes the EIP value of next instruction from the
+ * pointer <from> which points to the first byte after the mod/rm byte.
+ * Its purpose is to implement a fast alternative to modrm_address()
+ * when offset value is not needed.
+ */
+static void *skip_modrm(unsigned char *from, char bit32, unsigned char modrm)
+{
+	if (bit32) { /* 32-bits addressing mode (default) */
+		if ((modrm & 0xC7) == 0x05)  /* 32 bits offset and nothing more */
+			return from + 4;
+	
+		if ((modrm & 0x07) == 0x04) {
+			if (((*from++ & 0x07) == 5) && ((modrm & 0xC0) == 0)) /* base+sib */
+				return from + 4;
+		}
+	}
+	else if ((modrm & 0xC7) == 0x06) /* 16 bits offset */
+		return from + 2;
+
+	/* now, let's include 8/16/32 bits offset */
+	if ((modrm & 0xC0) == 0x40)		/* 8 bits signed offset */
+		return from + 1;
+	else if ((modrm & 0xC0) == 0x80)	/* 16/32 bits unsigned offset */
+		return from + (2 << bit32);
+	else
+		return from;
+}
+
+
+/* [reg_address] returns a pointer to a register in the regs struct, depending
+ * on <w> (byte/word) and reg. Since the caller knows about <w>, it's
+ * responsible for understanding the result as a byte, word or dword pointer.
+ */
+static inline void *reg_address(struct pt_regs *regs, char w, unsigned char reg)
+{
+	if (w)
+		/* 16/32 bits mode */
+		return REG_PTR(regs, reg & 7);
+	else
+		/* 8 bits mode : al,cl,dl,bl,ah,ch,dh,bh */
+		return ((reg & 4) >> 2) + (unsigned char *)REG_PTR(regs, reg & 3);
+
+	/* this is set just to prevent the compiler from complaining */
+	return NULL;
+}
+
+/* [do_invalid_op] is called by exception 6 after an invalid opcode has been
+ * encountered. It will decode the prefixes and the instruction code, to try
+ * to emulate it, and will send a SIGILL or SIGSEGV to the process if not
+ * possible.
+ */
+asmlinkage void do_invalid_op(struct pt_regs * regs, long error_code)
+{
+	enum {
+		PREFIX_ES=1,
+		PREFIX_CS=2,
+		PREFIX_SS=4,
+		PREFIX_DS=8,
+		PREFIX_FS=16,
+		PREFIX_GS=32,
+		PREFIX_SEG=63,  /* any seg */
+		PREFIX_D32=64,
+		PREFIX_A32=128,
+		PREFIX_LOCK=256,
+		PREFIX_REPN=512,
+		PREFIX_REP=1024
+	};
+
+	unsigned int prefixes;
+	unsigned char *eip = (unsigned char *)regs->eip;
+	unsigned long int *src, *dst;
+
+	/* we'll first read all known opcode prefixes, and discard obviously
+	   invalid combinations.*/
+	prefixes=0;
+	while (1) {
+		if ((*eip & 0xfc) == 0x64) {
+			switch (*eip) {
+			case 0x66: /* Operand switches 16/32 bits */
+				if (prefixes & PREFIX_D32)
+					goto invalid_opcode;
+				prefixes |= PREFIX_D32;
+				eip++;
+				continue;
+			case 0x67: /* Address switches 16/32 bits */
+				if (prefixes & PREFIX_A32)
+					goto invalid_opcode;
+				prefixes |= PREFIX_A32;
+				eip++;
+				continue;
+			case 0x64: /* FS: */
+				if (prefixes & PREFIX_SEG)
+					goto invalid_opcode;
+				prefixes |= PREFIX_FS;
+				eip++;
+				continue;
+			case 0x65: /* GS: */
+				if (prefixes & PREFIX_SEG)
+					goto invalid_opcode;
+				prefixes |= PREFIX_GS;
+				eip++;
+				continue;
+			}
+		}
+		else if ((*eip & 0xfc) == 0xf0) {
+			switch (*eip) {
+			case 0xF0: /* lock */
+				if (prefixes & PREFIX_LOCK)
+					goto invalid_opcode;
+				prefixes |= PREFIX_LOCK;
+#ifdef CONFIG_SMP
+				/* if we're in SMP mode, a missing lock can lead to problems in
+				 * multi-threaded environment. We must send a warning. In UP,
+				 * however, this should have no effect.
+				 */
+				printk(KERN_WARNING "Warning ! LOCK prefix found at EIP=0x%08x in"
+				       "process %d(%s), has no effect before a software-emulated"
+				       "instruction\n", regs->eip, current->pid, current->comm);
+#endif
+				eip++;
+				continue;
+			case 0xF2: /* repne */
+				if (prefixes & (PREFIX_REPN | PREFIX_REP))
+					goto invalid_opcode;
+				prefixes |= PREFIX_REPN;
+				eip++;
+				continue;
+			case 0xF3: /* rep */
+				if (prefixes & (PREFIX_REP | PREFIX_REPN))
+					goto invalid_opcode;
+				prefixes |= PREFIX_REP;
+				eip++;
+				continue;
+			}
+		}
+		else if ((*eip & 0xe7) == 0x26) {
+			switch (*eip) {
+			case 0x26: /* ES: */
+				if (prefixes & PREFIX_SEG)
+					goto invalid_opcode;
+				prefixes |= PREFIX_ES;
+				eip++;
+				continue;
+			case 0x2E: /* CS: */
+				if (prefixes & PREFIX_SEG)
+					goto invalid_opcode;
+				prefixes |= PREFIX_CS;
+				eip++;
+				continue;
+			case 0x36: /* SS: */
+				if (prefixes & PREFIX_SEG)
+					goto invalid_opcode;
+				prefixes |= PREFIX_SS;
+				eip++;
+				continue;
+			case 0x3E: /* DS: */
+				if (prefixes & PREFIX_SEG)
+					goto invalid_opcode;
+				prefixes |= PREFIX_DS;
+				eip++;
+				continue;
+			}
+		}
+		/* if this opcode has not been processed, it's not a prefix. */
+		break;
+	}
+
+	/* now we know about all the prefixes */
+
+#if defined(CONFIG_CPU_EMU686)
+	/* here, we'll try to emulate the CMOV* instructions, which gcc blindly
+	 * generates when specifying -march=i686, even though the processor flags
+	 * must be checked against support for these instructions.
+	 */
+	if ((*eip == 0x0F) && ((*(eip+1) & 0xF0) == 0x40)) {  /* CMOV* */
+		unsigned char cond, ncond, reg, modrm;
+		unsigned long flags;
+
+		/* to optimize processing, we'll associate a flag mask to each opcode.
+		 * If the EFLAGS value ANDed with this mask is not null, then the cond
+		 * is met. One exception is CMOVL which is true if SF != OF. For this
+		 * purpose, we'll make a fake flag 'SFOF' (unused bit 3) which equals
+		 * SF^OF, so that CMOVL is true if SFOF != 0.
+		 */
+		static short unsigned cmov_flags[8] = {
+			0x0800, /* CMOVO	=> OF */
+			0x0001, /* CMOVB	=> CF */
+			0x0040, /* CMOVE	=> ZF */
+			0x0041, /* CMOVBE	=> CF | ZF */
+			0x0080, /* CMOVS	=> SF */
+			0x0004, /* CMOVP	=> PF */
+			0x0008, /* CMOVL	=> SF^OF */
+			0x0048, /* CMOVLE	=> SF^OF | ZF */
+		};
+
+#ifdef INVALID_OP_EVEN_IF_CPU_WOULD_ACCEPT
+		if (prefixes & (PREFIX_REP | PREFIX_REPN))
+			goto invalid_opcode;
+#endif
+
+		flags =	regs->eflags & 0x08C5; /* OF, SF, ZF, PF, CF */
+
+		/* SFOF (flags_3) <= OF(flags_11) ^ SF(flags_7) */
+		flags |= ((flags ^ (flags >> 4)) >> 4) & 0x8;
+
+		cond  = *(eip+1) & 0x0F;
+		ncond = cond & 1;	/* condition is negated */
+		cond >>= 1;
+		ncond ^= !!(flags & cmov_flags[cond]);
+		/* ncond is now true if the cond matches the opcode */
+
+		modrm = *(eip+2);
+		eip += 3; /* skips all the opcodes */
+
+		if (!ncond) {
+			/* condition is not valid, skip the instruction and do nothing */
+			regs->eip = (unsigned long)skip_modrm(eip, !(prefixes & PREFIX_A32), modrm);
+			return;
+		}
+
+		/* we'll have to do the work */
+		reg = (modrm >> 3) & 7;
+		modrm &= 0xC7;
+
+		/* condition is valid */
+		dst = reg_address(regs, 1, reg);
+		if ((modrm & 0xC0) == 0xC0) { /* register to register */
+			src = reg_address(regs, 1, modrm & 0x07);
+		}
+		else {
+			src = modrm_address(regs, &eip, 1, !(prefixes & PREFIX_A32), modrm);
+			/* we must verify that src is valid for this task */
+			if ((prefixes & (PREFIX_FS | PREFIX_GS)) ||
+			    verify_area(VERIFY_WRITE, (void *)src, ((prefixes & PREFIX_D32) ? 2 : 4))) {
+				do_general_protection(regs, error_code);
+				return;
+			}
+		}
+	
+		if (!(prefixes & PREFIX_D32)) /* 32 bits operands */
+			*(unsigned long*)dst = *(unsigned long*)src;
+		else
+			*(unsigned short*)dst = *(unsigned short*)src;
+
+		regs->eip = (unsigned long)eip;
+		return;
+	}
+#endif /* CONFIG_CPU_EMU686 */
+
+#if defined(CONFIG_CPU_EMU486)
+	/* we'll verify if this is a BSWAP opcode, main source of SIGILL on 386's */
+	if ((*eip == 0x0F) && ((*(eip+1) & 0xF8) == 0xC8)) {  /* BSWAP */
+		unsigned char w, reg, modrm;
+
+#ifdef INVALID_OP_EVEN_IF_CPU_WOULD_ACCEPT
+		if (prefixes & (PREFIX_REP | PREFIX_REPN))
+			goto invalid_opcode;
+#endif	
+
+		reg = *(eip+1) & 0x07;
+
+		src=reg_address(regs, 1, reg);
+
+		__asm__ __volatile__ (
+				      "xchgb %%al, %%ah\n\t"
+				      "roll $16, %%eax\n\t"
+				      "xchgb %%al, %%ah\n\t"
+				      : "=a" (*(unsigned long *)src)
+				      : "a" (*(unsigned long *)src));
+		regs->eip = (unsigned long)((char *)eip + 2);
+		return;
+	}
+
+	/* we'll also try to emulate the CMPXCHG instruction (used in mutex locks).
+	   This instruction is often locked, but it's not possible to put a lock
+	   here. Anyway, I don't believe that there are lots of multiprocessors
+	   386 out there ...
+	*/
+	if ((*eip == 0x0F) && ((*(eip+1) & 0xFE) == 0xB0)) {  /* CMPXCHG */
+		unsigned char w, reg, modrm;
+
+#ifdef INVALID_OP_EVEN_IF_CPU_WOULD_ACCEPT
+		if (prefixes & (PREFIX_REP | PREFIX_REPN))
+			goto invalid_opcode;
+#endif
+		w=*(eip+1) & 1;
+		modrm = *(eip+2);
+		reg = (modrm >> 3) & 7;
+		modrm &= 0xC7;
+		eip += 3; /* skips all the opcodes */
+
+		dst = reg_address(regs, w, reg);
+		if ((modrm & 0xC0) == 0xC0) /* register to register */
+			src = reg_address(regs, w, modrm & 0x07);
+		else {
+			src = modrm_address(regs, &eip, w, !(prefixes & PREFIX_A32), modrm);
+			/* we must verify that src is valid for this task */
+			if ((prefixes & (PREFIX_FS | PREFIX_GS)) ||
+			    verify_area(VERIFY_WRITE, (void *)src, (w?((prefixes & PREFIX_D32)?2:4):1))) {
+				do_general_protection(regs, error_code);
+				return;
+			}
+		}
+
+		if (!w) { /* 8 bits operands */
+			if ((unsigned char)regs->eax == *(unsigned char*)src) {
+				*(unsigned char*)src = *(unsigned char*)dst;
+				regs->eflags |= 0x40;  /* set Zero Flag */
+			}
+			else {
+				regs->eflags &= ~0x40;  /* clear Zero Flag */
+				*(unsigned char*)&(regs->eax) = *(unsigned char*)src;
+			}
+		}
+		else if (prefixes & PREFIX_D32) { /* 16 bits operands */
+			if ((unsigned short)regs->eax == *(unsigned short*)src) {
+				*(unsigned short*)src = *(unsigned short*)dst;
+				regs->eflags |= 0x40;  /* set Zero Flag */
+			}
+			else {
+				regs->eflags &= ~0x40;  /* clear Zero Flag */
+				*(unsigned short*)&regs->eax = *(unsigned short*)src;
+			}
+		}
+		else { /* 32 bits operands */
+			if ((unsigned long)regs->eax == *(unsigned long*)src) {
+				*(unsigned long*)src = *(unsigned long*)dst;
+				regs->eflags |= 0x40;  /* set Zero Flag */
+			}
+			else {
+				regs->eflags &= ~0x40;  /* clear Zero Flag */
+				regs->eax = *(unsigned long*)src;
+			}
+		}
+		regs->eip = (unsigned long)eip;
+		return;
+	}
+
+	/* we'll also try to emulate the XADD instruction (not very common) */
+	if ((*eip == 0x0F) && ((*(eip+1) & 0xFE) == 0xC0)) {  /* XADD */
+		unsigned char w, reg, modrm;
+		unsigned long op1, op2;
+
+#ifdef INVALID_OP_EVEN_IF_CPU_WOULD_ACCEPT
+		if (prefixes & (PREFIX_REP | PREFIX_REPN))
+			goto invalid_opcode;
+#endif
+		w = *(eip + 1) & 1;
+		modrm = *(eip + 2);
+		reg = (modrm >> 3) & 7;
+		modrm &= 0xC7;
+		eip += 3; /* skips all the opcodes */
+
+		dst = reg_address(regs, w, reg);
+		if ((modrm & 0xC0) == 0xC0) /* register to register */
+			src = reg_address(regs, w, modrm & 0x07);
+		else {
+			src = modrm_address(regs, &eip, w,! (prefixes & PREFIX_A32), modrm);
+			/* we must verify that src is valid for this task */
+			if ((prefixes & (PREFIX_FS | PREFIX_GS)) ||
+			    verify_area(VERIFY_WRITE, (void *)src, (w?((prefixes & PREFIX_D32)?2:4):1))) {
+				do_general_protection(regs, error_code);
+				return;
+			}
+		}
+
+		if (!w) { /* 8 bits operands */
+			op1=*(unsigned char*)src;
+			op2=*(unsigned char*)dst;
+			*(unsigned char*)src = op1 + op2;
+			*(unsigned char*)dst = op1;
+		}
+		else if (prefixes & PREFIX_D32) { /* 16 bits operands */
+			op1=*(unsigned short*)src;
+			op2=*(unsigned short*)dst;
+			*(unsigned short*)src = op1 + op2;
+			*(unsigned short*)dst = op1;
+		}
+		else { /* 32 bits operands */
+			op1=*(unsigned long*)src;
+			op2=*(unsigned long*)dst;
+			*(unsigned long*)src = op1 + op2;
+			*(unsigned long*)dst = op1;
+		}
+		regs->eip = (unsigned long)eip;
+		return;
+	}
+#endif /* CONFIG_CPU_EMU486 */
+	/* it's a case we can't handle. Unknown opcode or too many prefixes. */
+ invalid_opcode:
+#ifdef CONFIG_CPU_EMU486_DEBUG
+	printk(KERN_DEBUG "do_invalid_op() : invalid opcode detected @%p : %02x %02x ...\n", eip, eip[0], eip[1]);
+#endif
+	current->thread.error_code = error_code;
+	current->thread.trap_no = 6;
+	force_sig(SIGILL, current);
+	die_if_kernel("invalid operand",regs,error_code);
+}
+
+#endif  /* CONFIG_CPU_EMU486 || CONFIG_CPU_EMU686 */
+
 DO_VM86_ERROR_INFO( 0, SIGFPE,  "divide error", divide_error, FPE_INTDIV, regs->eip)
 DO_VM86_ERROR( 3, SIGTRAP, "int3", int3)
 DO_VM86_ERROR( 4, SIGSEGV, "overflow", overflow)
 DO_VM86_ERROR( 5, SIGSEGV, "bounds", bounds)
+
+#if !defined(CONFIG_CPU_EMU486) && !defined(CONFIG_CPU_EMU686)
 DO_ERROR_INFO( 6, SIGILL,  "invalid operand", invalid_op, ILL_ILLOPN, regs->eip)
+#endif
+
 DO_VM86_ERROR( 7, SIGSEGV, "device not available", device_not_available)
 DO_ERROR( 8, SIGSEGV, "double fault", double_fault)
 DO_ERROR( 9, SIGFPE,  "coprocessor segment overrun", coprocessor_segment_overrun)

--fdj2RfSjLxBAspz7--
