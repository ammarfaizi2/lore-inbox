Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277875AbRJORF2>; Mon, 15 Oct 2001 13:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277859AbRJORFT>; Mon, 15 Oct 2001 13:05:19 -0400
Received: from aprilia.amazon.com ([209.191.164.156]:31384 "HELO
	aprilia.amazon.com") by vger.kernel.org with SMTP
	id <S277823AbRJORFC>; Mon, 15 Oct 2001 13:05:02 -0400
From: "Monty Vanderbilt" <mvb@amazon.com>
To: "Gian-Yan Xu" <kids@linux.ee.tku.edu.tw>, <linux-kernel@vger.kernel.org>
Subject: RE: ptrace bug
Date: Mon, 15 Oct 2001 10:04:07 -0700
Message-ID: <ALEMKFGKCDJNAGAJHLLLOEEFCEAA.mvb@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.21.0110160805440.12289-100000@linux.ee.tku.edu.tw>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think the problem is what you identified.
arch/i386/kernel/ptrace.c:getreg() takes the extra FS,GS offsets into
account and performs special handling for them. I suspect this is because
they are not stable per-thread registers and not saved into the register
structure on an interrupt or system call.

ptrace.c:getreg() ...
	switch (regno >> 2) {
		case FS:
			retval = child->thread.fs;
			break;
		case GS:
			retval = child->thread.gs;
			break;
		case DS:
		case ES:
		case SS:
		case CS:
			retval = 0xffff;
			/* fall through */
		default:
			if (regno > GS*4)				// *** Adusts for missing FS,GS fields *** //
				regno -= 2*4;
			regno = regno - sizeof(struct pt_regs);
			retval &= get_stack_long(child, regno);
	}

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Gian-Yan Xu
Sent: Monday, October 15, 2001 5:12 PM
To: linux-kernel@vger.kernel.org
Subject: ptrace bug



Today I try to get register's value via ptrace(PTRACE_GETREGS, ...),
but only EBX, ECX, EDX, ESI, EDI, EBP, EAX registers are correct.
I notice that file /usr/src/linux/include/asm/ptrace.h:

#define FS 9
#define GS 10

but in the declare of struct pt_regs:

struct pt_regs {
        long ebx;
        long ecx;
        long edx;
        long esi;
        long edi;
        long ebp;
        long eax;
        int  xds;
        int  xes;
        long orig_eax;
        long eip;
        int  xcs;
        long eflags;
        long esp;
        int  xss;
};

There is no xfs/xgs member in that struct, and the #define FRAME_SIZE 17
is not match the number of member in the pt_regs struct.


In addition, in the ptrace.c:

   case PTRACE_GETREGS: { /* Get all gp regs from the child. */
   if (!access_ok(VERIFY_WRITE, (unsigned *)data,
FRAME_SIZE*sizeo(long))) {
                        ret = -EIO;
                        break;
   }
   for ( i = 0; i < FRAME_SIZE*sizeof(long); i += sizeof(long) ) {
              __put_user(getreg(child, i),(unsigned long *) data);
             data += sizeof(long);
   }
   ret = 0;

FRAME_SIZE*sizeof(long) is larger than sizeof(struct pt_regs),
the ptrace() will overwrite the data of parent process!

To fix the bug, try this patch:

--- ptrace.h.orig       Mon Oct 15 21:00:48 2001
+++ ptrace.h    Mon Oct 15 21:05:56 2001
@@ -33,6 +33,8 @@
        long eax;
        int  xds;
        int  xes;
+       int  xfs;
+       int  xgs;
        long orig_eax;
        long eip;
        int  xcs;



--
Best regards,
Gian-Yain Xu. (kids@linux.ee.tku.edu.tw)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

