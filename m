Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbTECNVr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 09:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263308AbTECNVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 09:21:47 -0400
Received: from siaab2ab.compuserve.com ([149.174.40.130]:49556 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263295AbTECNVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 09:21:43 -0400
Date: Sat, 3 May 2003 09:30:42 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re:[PATCH][Experimental] Debugging i386 using hardware task
  switching
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305030933_MC3-1-3731-3730@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Here is some output from testing the TSS-based int3 handler.

  You need the usermode program at the end of this message to get this
output (I added the *'s at the right to match up with the comments
below.)  This dump was after running this program for a while, then
breaking out with ctrl+c:

        main () { for (;;) asm("int $3;"); }

  *1 - CS:EIP: last int3 was from usermode near the start of an ELF program
  *2 - SS:ESP: near the top of usermode stack
  *3 - EAX-EBP: whatever glibc puts here at start of a C program
  *4 - ECX: last two int3's on this CPU were 1012 clocks apart (incl. overhead)
  *5 - ESI: int3 has been invoked 675251 times since boot on this CPU
  *6 - LINK: last task to do int3 was kernel TSS


GDT entry #16: kernel TSS at c0353800, 236 bytes:

   CS:0073 <GDT#14,RPL3>   EIP:080483d5   eflags:00000292 <IF:1>        *1
  SS0:0068 <GDT#13,RPL0>  ESP0:c2766000
  SS1:0060 <GDT#12,RPL0>  ESP1:c0353a00
  SS2:0000 <GDT#00,RPL0>  ESP2:00000000
   SS:007b <GDT#15,RPL3>   ESP:bffffb68                                 *2
   DS:007b <GDT#15,RPL3>  ES:007b <GDT#15,RPL3>
   FS:0000 <GDT#00,RPL0>  GS:0000 <GDT#00,RPL0>
  EAX:00000001  EBX:4213030c  ECX:42130f08  EDX:bffffbdc                *3
  ESI:40013020  EDI:bffffbd4  EBP:bffffb68     BITMAP:8000
  LDT:0088 <GDT#17,RPL0>      CR3:02938000   LINK:0000 <GDT#00,RPL0>


GDT entry #30: debugger TSS at c0355800, 236 bytes:

   CS:0060 <GDT#12,RPL0>   EIP:c010f7e6   eflags:00000002 <IF:0>
  SS0:0068 <GDT#13,RPL0>  ESP0:c03ae420
  SS1:0000 <GDT#00,RPL0>  ESP1:00000000
  SS2:0000 <GDT#00,RPL0>  ESP2:00000000
   SS:0068 <GDT#13,RPL0>   ESP:c03ae420
   DS:007b <GDT#15,RPL3>  ES:007b <GDT#15,RPL3>
   FS:0000 <GDT#00,RPL0>  GS:0000 <GDT#00,RPL0>
  EAX:7a754010  EBX:c0306360  ECX:000003f4  EDX:000000ea                *4
  ESI:000a4db3  EDI:00000010  EBP:c03ad020     BITMAP:8000              *5
  LDT:0088 <GDT#17,RPL0>      CR3:00101000   LINK:0080 <GDT#16,RPL0>    *6



#define PROG_NAME       "tss"
#define PROG_TITLE      "dump i386 CPU kernel and debug TSS"
#define VERSION         "0.63"
/* v0.63: new program, derived from desc 0.63 */
#define AUTHOR          "Chuck Ebbert <76306.1226@compuserve.com>"
#define LICENSE         "Released under the GPL"

#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>

typedef struct { /* from Linux */
        unsigned short  back_link,__blh;
        unsigned long   esp0;
        unsigned short  ss0,__ss0h;
        unsigned long   esp1;
        unsigned short  ss1,__ss1h;
        unsigned long   esp2;
        unsigned short  ss2,__ss2h;
        unsigned long   __cr3;
        unsigned long   eip;
        unsigned long   eflags;
        unsigned long   eax,ecx,edx,ebx;
        unsigned long   esp;
        unsigned long   ebp;
        unsigned long   esi;
        unsigned long   edi;
        unsigned short  es, __esh;
        unsigned short  cs, __csh;
        unsigned short  ss, __ssh;
        unsigned short  ds, __dsh;
        unsigned short  fs, __fsh;
        unsigned short  gs, __gsh;
        unsigned short  ldt, __ldth;
        unsigned short  trace, bitmap;
} __attribute__ ((packed)) tss_t;

typedef struct {
        unsigned short limit;
        unsigned int base;
} __attribute__ ((packed)) dtr_t;

typedef struct {
        unsigned a,b;
} __attribute__ ((packed)) desc_t;

/* read/write from kmem */
#define BUILD_IO_FN(fn_name, fn_fn) \
        static int fn_name (int fd, int offset, void *buf, int size) { \
                if (lseek(fd, offset, 0) != offset) return 0; \
                if (fn_fn(fd, buf, size) != size) return 0; \
                return size; \
        }
BUILD_IO_FN(rkm, read)

#define perr(err) { perror(err), exit(1); }
/* read/write wrapper with err handling */
#define xkm(f, p1, p2, p3, p4, msg) { \
        int _p4 = (p4); if ((f)((p1), (p2), (p3), _p4) != _p4) perr(msg); }
#define TEST_BIT(v,b) ( !!((v) & (1 << (b))) )
#define nl printf("\n")

int kmem;

void dump_sel (char *nm, unsigned short s) {
        printf("%s:%04x <%s#%02d,RPL%d>",
               nm, s, (s & 4) ? "LDT" : "GDT", s >> 3, s & 3);
}
void dump_table (char * name, unsigned base, unsigned num) {
        unsigned cdt, db, dl, a, b, t, i, f;
        desc_t desc;
        tss_t tss;

        for (i = 16; i <= 30; i += 14) { /* just kernel and debug TSS */
                xkm(rkm, kmem, base + 8*i, &desc, sizeof(desc), "rkm gdtldt");
                a = desc.a, b = desc.b, f = (b & 0xf0ff00) >> 8, t = f & 0x1f;
                if ((t != 0x09) & (t != 0x0b)) continue; /* not a 32b TSS */

                dl = (a & 0xffff) | (b & 0x0f0000);
                db  = (b & 0xff000000) | ((b & 0xff) << 16) | (a >> 16);
                xkm(rkm, kmem, db, &tss, sizeof(tss), "rkm tss");
                printf("\nGDT entry #%d: %s TSS at %08x, %d bytes:\n\n",
                       i, (i == 16) ? "kernel" : "debugger", db, dl + 1);
                dump_sel("   CS", tss.cs);
                printf("   EIP:%08x   eflags:%08x <IF:%d>\n",
                       tss.eip, tss.eflags, TEST_BIT(tss.eflags,9));
                dump_sel("  SS0", tss.ss0);
                printf("  ESP0:%08x\n", tss.esp0);
                dump_sel("  SS1", tss.ss1);
                printf("  ESP1:%08x\n", tss.esp1);
                dump_sel("  SS2", tss.ss2);
                printf("  ESP2:%08x\n", tss.esp2);
                dump_sel("   SS", tss.ss);
                printf("   ESP:%08x\n", tss.esp);
                dump_sel("   DS", tss.ds);
                dump_sel("  ES", tss.es), nl;
                dump_sel("   FS", tss.fs);
                dump_sel("  GS", tss.gs), nl;
                printf("  EAX:%08x  EBX:%08x  ECX:%08x  EDX:%08x\n",
                       tss.eax, tss.ebx, tss.ecx, tss.edx);
                printf("  ESI:%08x  EDI:%08x  EBP:%08x"
                       "     BITMAP:%04x\n",
                       tss.esi, tss.edi, tss.ebp, tss.bitmap);
                dump_sel("  LDT", tss.ldt);
                printf("      CR3:%08x", tss.__cr3);
                dump_sel("   LINK", tss.back_link), nl, nl;
        }
        nl;
}
main() {
        dtr_t dtr;
        kmem = open("/dev/kmem", O_RDONLY);
        if (kmem < 0) perr("open /dev/kmem");
        asm("sgdt %0" : "=m" (dtr));
        dump_table("GDT", dtr.base, (dtr.limit + 1) >> 3);
        close(kmem);
}
------
 Chuck
