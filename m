Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTD3OWt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 10:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbTD3OWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 10:22:49 -0400
Received: from siaab2ab.compuserve.com ([149.174.40.130]:24132 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S261840AbTD3OWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 10:22:45 -0400
Date: Wed, 30 Apr 2003 10:32:30 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: desc.c v0.62
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: me <76306.1226@compuserve.com>
Message-ID: <200304301034_MC3-1-36B6-7E58@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#define PROG_NAME       "desc"
#define PROG_TITLE      "dump i386 CPU descriptor tables"
#define VERSION         "0.62"
/* v0.62 : almost all TSS fields, all Pentium segtypes */
#define AUTHOR          "Chuck Ebbert <76306.1226@compuserve.com>"
#define COPYRIGHT       "Copyright (c) 2003 Chuck Ebbert"
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
        unsigned short off1;
        unsigned short sel;
        unsigned char none,flags;
        unsigned short off2;
} __attribute__ ((packed)) gate_desc_t;

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
BUILD_IO_FN(wkm, write)

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
        gate_desc_t *gate = (gate_desc_t *)&desc; /* FIXME */
        tss_t tss;

        printf(" %s at %08x, %d entries:\n\n", name, base, num);
        for (i = 0; i < num; i++) {
                xkm(rkm, kmem, base + 8*i, &desc, sizeof(desc), "rkm gdtldt");
                a = desc.a, b = desc.b, f = (b & 0xf0ff00) >> 8, t = f & 0x1f;
                if (!a & !b) continue; /* empty */
                if ((t & 0x04) == 0x04) { /* gate */  
                        f = gate->flags, t = f & 0x1f;
                        printf("%s#%3d: ", name, i);
                        dump_sel("sel", gate->sel);
                        printf(" off:%08x flags:%02x <%s,DPL%d,%s Gate>\n",
                               (unsigned)((gate->off2 << 16) | gate->off1),
                               f, TEST_BIT(f,7) ? "P" : "N", (f & 0x60) >> 5,
                               (t == 0x05) ? "Task" :
                                                (t == 0x0c) ? "32b,Call" :
                                                (t == 0x0e) ? "32b,Intr" :
                                                (t == 0x0f) ? "32b,Trap" :
                                                (t == 0x04) ? "16b,Call" :
                                                (t == 0x06) ? "16b,Intr" :
                                                (t == 0x07) ? "16b,Trap" :
                                                "Unknown");
                        continue;
                }
                cdt = f & 0x401e; /* code/data type, base, limit */
                dl = (a & 0xffff) | (b & 0x0f0000);
                db  = (b & 0xff000000) | ((b & 0xff) << 16) | (a >> 16);
                printf("%s#%3d: base:%08x limit:%05x%s"
                       "  flags:%04x <%s,DPL%d,%s>\n",
                       name, i, db, dl, TEST_BIT(b,23) ? "fff" : "   ",
                       f, TEST_BIT(b,15) ? "P" : "N", (b & 0x6000) >> 13,
                       (t == 0x01) ? "16b,Avail TSS" :
                                        (t == 0x02) ? "LDT" :
                                        (t == 0x03) ? "16b,Busy TSS" :
                                        (t == 0x09) ? "32b,Avail TSS" :
                                        (t == 0x0b) ? "32b,Busy TSS" :
                                        (cdt == 0x0010) ? "16b,RO Data" :
                                        (cdt == 0x0012) ? "16b,RW Data" :
                                        (cdt == 0x0014) ? "16b,RO Expd Data" :
                                        (cdt == 0x0016) ? "16b,RW Expd Data" :
                                        (cdt == 0x0018) ? "16b,XO Code" :
                                        (cdt == 0x001a) ? "16b,RX Code" :
                                        (cdt == 0x001c) ? "16b,XO Conf Code" :
                                        (cdt == 0x001e) ? "16b,RX Conf Code" :
                                        (cdt == 0x4010) ? "32b,RO Data" :
                                        (cdt == 0x4012) ? "32b,RW Data" :
                                        (cdt == 0x4014) ? "32b,RO Expd Data" :
                                        (cdt == 0x4016) ? "32b,RW Expd Data" :
                                        (cdt == 0x4018) ? "32b,XO Code" :
                                        (cdt == 0x401a) ? "32b,RX Code" :
                                        (cdt == 0x401c) ? "32b,XO Conf Code" :
                                        (cdt == 0x401e) ? "32b,RX Conf Code" :
                                        "Unknown");
                if (t == 0x02)
                        nl, dump_table("   LDT", db, (dl + 1) >> 3);
                if ((t == 0x09) | (t == 0x0b)) {
                        xkm(rkm, kmem, db, &tss, sizeof(tss), "rkm tss");
                        printf("\n    TSS at %08x, %d bytes:\n\n", db, dl + 1);
                        dump_sel("   CS", tss.cs);
                        printf("   EIP:%08x   eflags:%08x\n",
                               tss.eip, tss.eflags);
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
                        printf("  ESI:%08x  EDI:%08x  EBP:%08x\n",
                               tss.esi, tss.edi, tss.ebp);
                        dump_sel("  LDT", tss.ldt);
                        printf("      CR3:%08x\n\n", tss.__cr3);
                }
        }
        nl;
}
main() {
        dtr_t dtr;

        printf(PROG_NAME " v" VERSION " -- " PROG_TITLE "\n\n");
        kmem = open("/dev/kmem", O_RDONLY);
        if (kmem < 0) perr("open /dev/kmem");

        asm("sgdt %0" : "=m" (dtr));
        dump_table("GDT", dtr.base, (dtr.limit + 1) >> 3);
        asm("sidt %0" : "=m" (dtr));
        dump_table("IDT", dtr.base, (dtr.limit + 1) >> 3);

        close(kmem);
}
------
 Chuck
