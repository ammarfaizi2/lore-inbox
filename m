Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTD0U7x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 16:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbTD0U7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 16:59:52 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:63888 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S261773AbTD0U7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 16:59:45 -0400
Date: Sun, 27 Apr 2003 17:09:04 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: desc.c version 0.61 -- dump i386 CPU descriptor tables
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304271711_MC3-1-3647-1A89@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


#define PROG_NAME	"desc"
#define PROG_TITLE	"dump i386 CPU descriptor tables"
#define VERSION		"0.61"
/* v0.61 : code cleanup, add more TSS fields */
#define AUTHOR		"Chuck Ebbert [76306.1226@compuserve.com]"
#define LICENSE		"Released under the GPL"

#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>

typedef struct { /* from Linux */
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
#define TEST_BIT(v,b) ( !!((v) & (1 << (b))) )

void dump_sel(unsigned short s) {
	printf("%04x <%s#%02d,RPL%d>",
	       s, (s & 4) ? "LDT" : "GDT", s >> 3, s & 3);
}
void dump_sys_desc(char *name, unsigned base, unsigned i) {
	unsigned s, f;
	idt_entry_t desc;

	xkm(rkm, kmem, base + 8*i, &desc, sizeof(desc), "rkm sys");
	s = desc.sel, f = desc.flags;
	printf("%s#%3d [0x%02x]: flags:%02x <%s,DPL%d,%s>",
	       name, i, i, f, f & 0x80 ? "P" : "NP", (f & 0x60) >> 5,
	       (f & 0x1f) == 0x0e ? "intr" :
	       		(f & 0x1f) == 0x0f ? "trap" :
	       		(f & 0x1f) == 0x05 ? "task" :
	       		(f & 0x1f) == 0x0c ? "call" : "????");
	printf(" sel:"), dump_sel(s);
	printf(" off:%08x\n", (unsigned)((desc.off2 << 16) | desc.off1));
}
void dump_gdt_ldt (char * name, unsigned base, unsigned num) {
	unsigned dbase, dlimit, a, b, t, i, f;
	gdt_ldt_entry_t desc;
	tss_t tss;

	printf("\n %s at %08x, %d entries:\n\n", name, base, num);
	for (i = 0; i < num; i++) {
		xkm(rkm, kmem, base + 8*i, &desc, sizeof(desc), "rkm gdtldt");
		a = desc.a, b = desc.b, f = (b & 0xf0ff00) >> 8, t = f & 0x1f;
		if (!a & !b) /* empty */
			continue;
		if ((t == 0x0c) | (t == 0x05)) { /* task/call gate */
			dump_sys_desc(name, base, i);
			continue;
		}
		dbase  = (b & 0xff000000) | ((b & 0xff) << 16) | (a >> 16);
		dlimit = (a & 0xffff) | (b & 0x0f0000);
		printf("%s#%3d: base:%08x limit:%05x%s"
		       "  flags:%04x <P:%d DPL:%d %s>\n",
		       name, i, dbase, dlimit, TEST_BIT(b,23) ? "fff" : "   ",
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
			printf("   CS:"), dump_sel(tss.cs);
			printf("   EIP:%08x   eflags:%08x\n",
			       tss.eip, tss.eflags);
			printf("  SS0:"), dump_sel(tss.ss0);
			printf("  ESP0:%08x\n", tss.esp0);
			printf("   SS:"), dump_sel(tss.ss);
			printf("   ESP:%08x\n", tss.esp);
			printf("   DS:"), dump_sel(tss.ds);
			printf("  ES:"), dump_sel(tss.es), printf("\n");
			printf("   FS:"), dump_sel(tss.fs);
			printf("  GS:"), dump_sel(tss.gs), printf("\n");
			printf("  LDT:"), dump_sel(tss.ldt);
			printf("   CR3:%08x\n\n", tss.__cr3);
		}
	}
	printf("\n");
}
void dump_idt (unsigned base, unsigned num) {
	int i;
	
	printf(" IDT at %08x, %d entries:\n\n", base, num);
	for (i = 0; i < num; i++)
		dump_sys_desc("IDT", base, i);
}
main() {
	dtr_t gdtr, idtr;

	printf(PROG_NAME " v" VERSION " -- " PROG_TITLE "\n");
	kmem = open("/dev/kmem", O_RDONLY);
	if (kmem < 0) perr("open /dev/kmem");

	asm("sgdt %0" : "=m" (gdtr));
	dump_gdt_ldt("GDT", gdtr.base, (gdtr.limit + 1) >> 3);
	asm("sidt %0" : "=m" (idtr));
	dump_idt(idtr.base, (idtr.limit + 1) >> 3);

	close(kmem);
}

-------
 Chuck
