Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbTDYBMY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 21:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbTDYBMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 21:12:23 -0400
Received: from siaab2ab.compuserve.com ([149.174.40.130]:52205 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S262657AbTDYBMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 21:12:06 -0400
Date: Thu, 24 Apr 2003 21:20:10 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [ANNOUNCE] desc.c v0.60 -- print i386 CPU descriptor tables
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304242124_MC3-1-35EA-DE6D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 desc version 0.60, a program to dump i386 descriptor tables,
is enclosed. Changes include:

   o bug fixes
   o dumps some TSS fields
   o prints LDTs

 Partial output on Linux 2.5.68-ce2 (note that you can now find the
doublefault handler and lcall entry points): 
================================================================================
desc v0.60 -- dump i386 CPU descriptor tables

 GDT at c0306280, 32 entries:

GDT#012: base=00000000 limit=ffffffff	flags=c09b <P=1 DPL=0 32-bit Code>
GDT#013: base=00000000 limit=ffffffff	flags=c093 <P=1 DPL=0 RW Data>
GDT#014: base=00000000 limit=ffffffff	flags=c0fb <P=1 DPL=3 32-bit Code>
GDT#015: base=00000000 limit=ffffffff	flags=c0f3 <P=1 DPL=3 RW Data>
GDT#016: base=c0353800 limit=000eb	flags=008b <P=1 DPL=0 Busy TSS>

    TSS at c0353800, 236 bytes:

  CS:0000 <GDT#00,RPL0>  EIP:00000000  EFLAGS:00000000

GDT#017: base=c0307c70 limit=00027	flags=0082 <P=1 DPL=0 LDT>

    LDT at c0307c70, 5 entries:

   LDT#000 [0x00]: flags=ec <P,DPL3,call> sel=60 <GDT#12,RPL0> off=c0108b60
   LDT#004 [0x04]: flags=ec <P,DPL3,call> sel=60 <GDT#12,RPL0> off=c0108ba4

GDT#018: base=00000000 limit=00000fff	flags=c09a <P=1 DPL=0 32-bit Code>
GDT#019: base=00000000 limit=00000fff	flags=809a <P=1 DPL=0 16-bit Code>
GDT#020: base=00000000 limit=00000fff	flags=8092 <P=1 DPL=0 RW Data>
GDT#021: base=00000000 limit=00000fff	flags=8092 <P=1 DPL=0 RW Data>
GDT#022: base=00000000 limit=00000fff	flags=8092 <P=1 DPL=0 RW Data>
GDT#023: base=00000000 limit=00000	flags=409a <P=1 DPL=0 32-bit Code>
GDT#024: base=00000000 limit=00000	flags=009a <P=1 DPL=0 16-bit Code>
GDT#025: base=00000000 limit=00000	flags=4092 <P=1 DPL=0 RW Data>
GDT#031: base=c0355600 limit=000eb	flags=0089 <P=1 DPL=0 Available TSS>

    TSS at c0355600, 236 bytes:

  CS:0060 <GDT#12,RPL0>  EIP:c010f700  EFLAGS:00000082
================================================================================
#define PROG_NAME	"desc"
#define PROG_TITLE	"dump i386 CPU descriptor tables"
#define VERSION		"0.60"
#define AUTHOR		"Chuck Ebbert <76306.1226ompuserve.com>"
#define LICENSE		"Released under the GPL"

#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>

typedef struct { /* taken from Linux source */
	unsigned short	back_link,__blh;
	unsigned long	esp0;
	unsigned short	ss0,__ss0h;
	unsigned long	esp1;
	unsigned short	ss1,__ss1h;
	unsigned long	esp2;
	unsigned short	ss2,__ss2h;
	unsigned long	__cr3;
	unsigned long	eip;
	unsigned long	eflags;
	unsigned long	eax,ecx,edx,ebx;
	unsigned long	esp;
	unsigned long	ebp;
	unsigned long	esi;
	unsigned long	edi;
	unsigned short	es, __esh;
	unsigned short	cs, __csh;
	unsigned short	ss, __ssh;
	unsigned short	ds, __dsh;
	unsigned short	fs, __fsh;
	unsigned short	gs, __gsh;
	unsigned short	ldt, __ldth;
	unsigned short	trace, bitmap;
} __attribute__ ((packed)) tss_t;

typedef struct {
	unsigned short limit;
	unsigned int base;
} __attribute__ ((packed)) dtr_t;

typedef struct {
	unsigned short off1;
	unsigned short sel;
	unsigned char none,flags;
	unsigned short off2;
} __attribute__ ((packed)) idt_entry_t;

typedef struct {
	unsigned a,b;
} __attribute__ ((packed)) gdt_ldt_entry_t;

/* read/write from kmem */
#define BUILD_IO_FN(fn_name, fn_fn) \
	static int fn_name(int fd, int offset, void *buf, int size) { \
	if (lseek(fd, offset, 0) != offset) return 0; \
		if (fn_fn(fd, buf, size) != size) return 0; \
	return size; \
	}
BUILD_IO_FN(rkm, read)
BUILD_IO_FN(wkm, write)

int kmem;

void perr(char *err) { /* exit with err msg */
	perror(err), exit(1);
}
/* read/write wrapper with err handling */
#define xkm(f, p1, p2, p3, p4, msg) { \
	int _p4 = (p4); if ((f)((p1), (p2), (p3), _p4) != _p4) perr(msg); }
#define TEST_BIT(v,b) ( !!(v & (1 << b)) )

void dump_sys_desc(char *name, unsigned base, unsigned i) {
	unsigned sel, flags;
	idt_entry_t desc;

	xkm(rkm, kmem, base + 8*i, &desc, sizeof(desc), "rkm sys");
	sel = desc.sel, flags = desc.flags;
	printf("%s#%03d [0x%02x]: flags=%02x <%s,DPL%d,%s>"
	       " sel=%02x <%s#%02d,RPL%d> off=%08x\n",
	       name, i, i, flags, flags & 0x80 ? "P" : "NP",
	       (flags & 0x60) >> 5,
	       (flags & 0x1f) == 0x0e ? "intr" :
	       		(flags & 0x1f) == 0x0f ? "trap" :
	       		(flags & 0x1f) == 0x05 ? "task" :
	       		(flags & 0x1f) == 0x0c ? "call" : "????",
	       sel, sel & 4 ? "LDT" : "GDT", sel >> 3, sel & 3,
	       (unsigned)((desc.off2 << 16) | desc.off1));
}
void dump_gdt_ldt (char * name, unsigned base, unsigned num) {
	unsigned dbase, dlimit, a, b, t, i, f;
	gdt_ldt_entry_t desc;
	tss_t tss;

	printf("\n %s at %08x, %d entries:\n\n", name, base, num);
	for (i = 0; i < num; i++) {
		xkm(rkm, kmem, base + 8*i, &desc, sizeof(desc), "rkm gdtldt");
		a = desc.a, b = desc.b, f = (b & 0xf0ff00) >> 8, t = f & 0x1f;
		if (!a & !b)
			continue;
		if (t == 0x0c) { /* call gate */
			dump_sys_desc(name, base, i);
			continue;
		}
		dbase  = (b & 0xff000000) | ((b & 0xff) << 16) | (a >> 16);
		dlimit = (a & 0xffff) | (b & 0x0f0000);
		printf("%s#%03d: base=%08x limit=%05x%s"
		       "\tflags=%04x <P=%d DPL=%d %s>\n",
		       name, i, dbase, dlimit, TEST_BIT(b,23) ? "fff" : "",
		       f, TEST_BIT(b,15), (b & 0x6000) >> 13,
		       t == 0x0b ? "Busy TSS" :
		       			t == 0x09 ? "Available TSS" :
					t == 0x02 ? "LDT" :
					(f & 0x401c) == 0x4018 ? "32-bit Code" :
					(f & 0x401c) == 0x18 ? "16-bit Code" :
					(t & 0x1c) == 0x1c ? "Conforming code" :
					(t & 0x1e) == 0x10 ? "RO Data" :
					(t & 0x1e) == 0x12 ? "RW Data" :
					(t & 0x1c) == 0x14 ? "Exp-down data" :
					"Unknown");
		if (t == 0x02)
			dump_gdt_ldt("   LDT", dbase, dlimit + 1 >> 3);
		if ((t == 0x09) | (t == 0x0b)) {
			xkm(rkm, kmem, dbase, &tss, sizeof(tss), "rkm tss");
			printf("\n    TSS at %08x, %d bytes:\n\n",
			       dbase, dlimit + 1);
			printf("  CS:%04x <%s#%02d,RPL%d>"
			       "  EIP:%08x  EFLAGS:%08x\n\n",
			       tss.cs, tss.cs & 4 ? "LDT" : "GDT",
			       tss.cs >> 3, tss.cs & 3,
			       tss.eip, tss.eflags);
		}
	}
	printf("\n");
}
void dump_idt (unsigned base, unsigned num) {
	int i;
	
	printf(" IDT at %08x, %d entries:\n\n", base, num);
	for (i = 0; i < num; i++) {
		dump_sys_desc("IDT", base, i);
	}
}
main() {
	dtr_t gdtr, idtr;

	printf(PROG_NAME " v" VERSION " -- " PROG_TITLE "\n");

	kmem = open("/dev/kmem", O_RDONLY);
	if (kmem < 0) perr("open kmem");

	asm("sgdt %0" : "=m" (gdtr));
	dump_gdt_ldt("GDT", gdtr.base, gdtr.limit + 1 >> 3);
	
	asm("sidt %0" : "=m" (idtr));
	dump_idt(idtr.base, idtr.limit + 1 >> 3);

	close(kmem);
}


------
 Chuck
