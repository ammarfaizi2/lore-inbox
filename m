Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263355AbTDCL5U>; Thu, 3 Apr 2003 06:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263356AbTDCL5U>; Thu, 3 Apr 2003 06:57:20 -0500
Received: from siaag1ab.compuserve.com ([149.174.40.4]:14061 "EHLO
	siaag1ab.compuserve.com") by vger.kernel.org with ESMTP
	id <S263355AbTDCL5S>; Thu, 3 Apr 2003 06:57:18 -0500
Date: Thu, 3 Apr 2003 07:05:39 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: How to fix the ptrace flaw without rebooting
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304030708_MC3-1-32C2-5A8A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


#define PROG_MSG "pt_fix.c -- disable linux ptrace system call"
#define VERSION  "0.50"
/*
	Author: Chuck Ebbert
	Adapted from: Phrack Inc., Volume 0x0b, Issue 0x3a, Phile #0x07
	Directions: Run this program as root on an x86 machine.
		It will disable the ptrace system call, thus
		fixing the Linux 'ptrace flaw'.  (It will also
		break strace, debugging tools and User Mode Linux.)
	WARNING: Your computer may crash or do other strange things
		if you run this program as root.  No warranty.
	Tested on:
		PPro Uni XT-PIC  2.2.19    pgcc-1.1.3   (sig #2)
		PPro SMP IO-APIC 2.5.66    gcc-2.96-110 (#1)
		PPro SMP IO_APIC 2.4.20aa1 gcc-2.96-110 (#1)   
		PII  Uni IO-APIC 2.5.66    gcc-2.96-110 (#1)
		K7   Uni APIC    2.4.20aa1 gcc-2.96-110 (#1)
*/
#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>

struct {
        unsigned short limit;
        unsigned int base;
} __attribute__ ((packed)) idtr;

struct {
        unsigned short off1;
        unsigned short sel;
        unsigned char none,flags;
        unsigned short off2;
} __attribute__ ((packed)) desc;

/* read from kmem */
static int rkm(int fd, int offset, void *buf, int size) {
        if (lseek(fd, offset, 0) != offset) return 0;
        if (read(fd, buf, size) != size) return 0;
        return size;
}
/* write to kmem */
static int wkm(int fd, int offset, void *buf, int size) {
        if (lseek(fd, offset, 0) != offset) return 0;
        if (write(fd, buf, size) != size) return 0;
        return size;
}
void perr(char *err) { /* exit with err msg */
	perror(err), exit(1);
}
/* read/write wrapper with err handling */
#define xkm(f, p1, p2, p3, p4, msg) ({ \
	int _p4 = (p4); if ((f)((p1), (p2), (p3), _p4) != _p4) perr(msg); })

#define IRQ_VECTOR 80	/* syscall interrupt */
#define CALLNR 26 	/* ptrace syscall */

/* valid old code signatures */
/* 1 */ unsigned char v1code[1] = { 0x55 /* push ebp */ };
/* 2 */ unsigned char v2code[4] = {
		0x83,0xec,0x10 /* sub esp,10 */, 0x55 /* push ebp */ };
/* new code for syscall */
unsigned char ncode[4] = { 0x31,0xc0 /* xor eax,eax */,
		0x48 /* dec eax */, 0xc3 /* ret */ };
unsigned char ocode[16];   /* buffer for old ptrace code */
unsigned char sc_asm[100]; /* holds first 100 bytes of IRQ handler code */

main() {
        unsigned sys_call_off, sct, fn;
	int kmem, i, found = 0;
        unsigned char *p;

	printf(PROG_MSG ", version " VERSION "\n");
        asm("sidt %0" : "=m" (idtr));
        printf("idt is at %08x\n", idtr.base);

        kmem = open("/dev/kmem", O_RDWR);
        if (kmem < 0) perr("open kmem");

        /* read-in desc for int vector */
        xkm(rkm, kmem, idtr.base+8*0x80, &desc, sizeof(desc), "rkm desc");
        sys_call_off = (desc.off2 << 16) | desc.off1;
        printf("idt entry %d: flags=%02hhx sel=%04x off=%08x\n",
	       IRQ_VECTOR, desc.flags, desc.sel, sys_call_off);

        /* we have syscall routine address now, look for syscall table
           dispatch (indirect call) */
        xkm(rkm, kmem, sys_call_off, sc_asm, sizeof(sc_asm), "rkm sc_asm");
        p = (char *)memmem(sc_asm, sizeof(sc_asm), "\xff\x14\x85", 3);
        sct = *(unsigned *)(p + 3); /* will fault if p is bad */
	printf("sys_call_table is at %08x\n", sct);

	xkm(rkm, kmem, sct+4*CALLNR, &fn, sizeof(fn), "rkm fn");
	printf("entry %d points to %08x\n", CALLNR, fn);

	xkm(rkm, kmem, fn, ocode, sizeof(ocode), "rkm ocode");
	printf("code:");
	for (i = 0; i < sizeof(ocode); i++) printf(" %02hhx", ocode[i]);
	printf("\n");

	if (!memcmp(ocode, v1code, sizeof(v1code))) found = 1;
	if (!memcmp(ocode, v2code, sizeof(v2code))) found = 2;
	if (!found) {
		printf(!memcmp(ocode, ncode, sizeof(ncode)) ?
				"Already installed.\n" :
				"Code mismatch, aborting.\n");
		exit(1);
	}
	printf("Valid entry code signature #%d found.\n", found);

	xkm(wkm, kmem, fn, ncode, sizeof(ncode), "wkm ncode");
	printf("Kernel patch succeeded.\n"
	       "NOTE: patch will only work until next reboot.\n");
        close(kmem);
	exit(0);
}

