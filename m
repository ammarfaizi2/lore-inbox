Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264101AbUFKRb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264101AbUFKRb7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 13:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264211AbUFKRb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 13:31:59 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:20647 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S264101AbUFKRbn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 13:31:43 -0400
Date: Fri, 11 Jun 2004 19:31:48 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: improve memory detection logic.
Message-ID: <20040611173148.GA3279@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: improve memory detection logic.

From: Guillaume Morin <guillaume@morinfr.org>

This patch improves the memory detection logic. It detects any
amount of holes in the memory layout up to MEMORY_CHUNK blocks
of available memory.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/head.S   |  126 ++++++++++++++++++++++++++++++++++++++-----
 arch/s390/kernel/head64.S |  134 +++++++++++++++++++++++++++++++++++++---------
 arch/s390/kernel/setup.c  |    4 +
 arch/s390/mm/extmem.c     |   24 ++++----
 include/asm-s390/setup.h  |    1 
 5 files changed, 238 insertions(+), 51 deletions(-)

diff -urN linux-2.6/arch/s390/kernel/head.S linux-2.6-s390/arch/s390/kernel/head.S
--- linux-2.6/arch/s390/kernel/head.S	Mon May 10 04:32:26 2004
+++ linux-2.6-s390/arch/s390/kernel/head.S	Fri Jun 11 19:09:49 2004
@@ -478,9 +478,80 @@
         mvcle %r2,%r4,0                 # clear mem
         jo    .-4                       # branch back, if not finish
 
+	l     %r2,.Lrcp-.LPG1(%r13)	# Read SCP forced command word
+.Lservicecall:
+	stosm .Lpmask-.LPG1(%r13),0x01	# authorize ext interrupts
+
+	stctl %r0, %r0,.Lcr-.LPG1(%r13)	# get cr0
+	la    %r1,0x200			# set bit 22
+	o     %r1,.Lcr-.LPG1(%r13)	# or old cr0 with r1
+	st    %r1,.Lcr-.LPG1(%r13)
+	lctl  %r0, %r0,.Lcr-.LPG1(%r13)	# load modified cr0
+
+	mvc   __LC_EXT_NEW_PSW(8),.Lpcext-.LPG1(%r13) # set postcall psw
+	la    %r1, .Lsclph-.LPG1(%r13)
+	a     %r1,__LC_EXT_NEW_PSW+4	# set handler
+	st    %r1,__LC_EXT_NEW_PSW+4
+
+	la    %r4,_pstart-.LPG1(%r13)	# %r4 is our index for sccb stuff
+	la    %r1, .Lsccb-PARMAREA(%r4)	# our sccb
+	.insn rre,0xb2200000,%r2,%r1	# service call
+	ipm   %r1
+	srl   %r1,28			# get cc code
+	xr    %r3, %r3
+	chi   %r1,3
+	be    .Lfchunk-.LPG1(%r13)	# leave
+	chi   %r1,2
+	be    .Lservicecall-.LPG1(%r13)
+	lpsw  .Lwaitsclp-.LPG1(%r13)
+.Lsclph:
+	lh    %r1,.Lsccbr-PARMAREA(%r4)
+	chi   %r1,0x10			# 0x0010 is the sucess code
+	je    .Lprocsccb		# let's process the sccb
+	chi   %r1,0x1f0
+	bne   .Lfchunk-.LPG1(%r13)	# unhandled error code
+	c     %r2, .Lrcp-.LPG1(%r13)	# Did we try Read SCP forced
+	bne   .Lfchunk-.LPG1(%r13)	# if no, give up
+	l     %r2, .Lrcp2-.LPG1(%r13)	# try with Read SCP
+	b     .Lservicecall-.LPG1(%r13)
+.Lprocsccb:
+	lh    %r1,.Lscpincr1-PARMAREA(%r4) # use this one if != 0
+	chi   %r1,0x00
+	jne   .Lscnd
+	l     %r1,.Lscpincr2-PARMAREA(%r4) # otherwise use this one
+.Lscnd:
+	xr    %r3,%r3			# same logic
+	ic    %r3,.Lscpa1-PARMAREA(%r4)
+	chi   %r3,0x00
+	jne   .Lcompmem
+	l     %r3,.Lscpa2-PARMAREA(%r13)
+.Lcompmem:
+	mr    %r2,%r1			# mem in MB on 128-bit
+	l     %r1,.Lonemb-.LPG1(%r13)
+	mr    %r2,%r1			# mem size in bytes in %r3
+	b     .Lfchunk-.LPG1(%r13)
+
+.Lpmask:
+	.byte 0
+.align 8
+.Lpcext:.long  0x00080000,0x80000000
+.Lcr:
+	.long 0x00			# place holder for cr0
+.Lwaitsclp:
+	.long 0x020A0000
+	.long .Lsclph
+.Lrcp:
+	.int 0x00120001			# Read SCP forced code
+.Lrcp2:
+	.int 0x00020001			# Read SCP code
+.Lonemb:
+	.int 0x100000
+.Lfchunk:
+
 #
 # find memory chunks.
 #
+	lr    %r9,%r3			 # end of mem
 	mvc   __LC_PGM_NEW_PSW(8),.Lpcmem-.LPG1(%r13)
 	la    %r1,1                      # test in increments of 128KB
 	sll   %r1,17
@@ -488,38 +559,46 @@
 	slr   %r4,%r4                    # set start of chunk to zero
 	slr   %r5,%r5                    # set end of chunk to zero
 	slr   %r6,%r6			 # set access code to zero
+	la    %r10, MEMORY_CHUNKS	 # number of chunks
 .Lloop:
 	tprot 0(%r5),0			 # test protection of first byte
 	ipm   %r7
 	srl   %r7,28
 	clr   %r6,%r7			 # compare cc with last access code
 	be    .Lsame-.LPG1(%r13)
-	clr   %r4,%r5			 # chunk size > 0?
-	be    .Lsize0-.LPG1(%r13)
-	st    %r4,0(%r3)		 # store start address of chunk
-	lr    %r0,%r5
-	slr   %r0,%r4
-	st    %r0,4(%r3)		 # store size of chunk
-	st    %r6,8(%r3)		 # store type of chunk
-	la    %r3,12(%r3)
-	lr    %r4,%r5			 # set start to end
-.Lsize0:
-	lr    %r6,%r7			 # set access code to last cc
+	b     .Lchkmem-.LPG1(%r13)
 .Lsame:
 	ar    %r5,%r1			 # add 128KB to end of chunk
 	bno   .Lloop-.LPG1(%r13)	 # r1 < 0x80000000 -> loop
 .Lchkmem:				 # > 2GB or tprot got a program check
 	clr   %r4,%r5			 # chunk size > 0?
-	be    .Ldonemem-.LPG1(%r13)
+	be    .Lchkloop-.LPG1(%r13)
 	st    %r4,0(%r3)		 # store start address of chunk
 	lr    %r0,%r5
 	slr   %r0,%r4
 	st    %r0,4(%r3)		 # store size of chunk
 	st    %r6,8(%r3)		 # store type of chunk
+	la    %r3,12(%r3)
+	l     %r4,.Lmemsize-.LPG1(%r13)	 # address of variable memory_size
+	st    %r5,0(%r4)		 # store last end to memory size
+	ahi   %r10,-1			 # update chunk number
+.Lchkloop:
+	lr    %r6,%r7			 # set access code to last cc
+	# we got an exception or we're starting a new
+	# chunk , we must check if we should
+	# still try to find valid memory (if we detected
+	# the amount of available storage), and if we
+	# have chunks left
+	xr    %r0,%r0
+	clr   %r0,%r9			 # did we detect memory?
+	je    .Ldonemem			 # if not, leave
+	chi   %r10,0			 # do we have chunks left?
+	je    .Ldonemem
+	alr   %r5,%r1			 # add 128KB to end of chunk
+	lr    %r4,%r5			 # potential new chunk
+	clr    %r5,%r9			 # should we go on?
+	jl     .Lloop
 .Ldonemem:		
-        l     %r1,.Lmemsize-.LPG1(%r13)  # address of variable memory_size
-	st    %r5,0(%r1)                 # store last end to memory size
-	
         l      %r12,.Lmflags-.LPG1(%r13) # get address of machine_flags
 #
 # find out if we are running under VM
@@ -631,6 +710,23 @@
     	.byte  "root=/dev/ram0 ro"
         .byte  0
 	.org   0x11000
+.Lsccb:
+	.hword 0x1000			# length, one page
+	.byte 0x00,0x00,0x00
+	.byte 0x80			# variable response bit set
+.Lsccbr:
+	.hword 0x00			# response code
+.Lscpincr1:
+	.hword 0x00
+.Lscpa1:
+	.byte 0x00
+	.fill 89,1,0
+.Lscpa2:
+	.int 0x00
+.Lscpincr2:
+	.quad 0x00
+	.fill 3984,1,0
+	.org 0x12000
 	.global _pend
 _pend:	
 
diff -urN linux-2.6/arch/s390/kernel/head64.S linux-2.6-s390/arch/s390/kernel/head64.S
--- linux-2.6/arch/s390/kernel/head64.S	Mon May 10 04:32:27 2004
+++ linux-2.6-s390/arch/s390/kernel/head64.S	Fri Jun 11 19:09:49 2004
@@ -480,12 +480,81 @@
         mvcle %r2,%r4,0                 # clear mem
         jo    .-4                       # branch back, if not finish
 
+	l     %r2,.Lrcp-.LPG1(%r13)	# Read SCP forced command word
+.Lservicecall:
+	stosm .Lpmask-.LPG1(%r13),0x01	# authorize ext interrupts
+
+	stctg %r0,%r0,.Lcr-.LPG1(%r13)	# get cr0
+	la    %r1,0x200			# set bit 22
+	og    %r1,.Lcr-.LPG1(%r13)	# or old cr0 with r1
+	stg   %r1,.Lcr-.LPG1(%r13)
+	lctlg %r0,%r0,.Lcr-.LPG1(%r13)	# load modified cr0
+
+	mvc   __LC_EXT_NEW_PSW(8),.Lpcmsk-.LPG1(%r13) # set postcall psw
+	larl  %r1,.Lsclph
+	stg   %r1,__LC_EXT_NEW_PSW+8	# set handler
+
+	larl  %r4,_pstart		# %r4 is our index for sccb stuff
+	la    %r1,.Lsccb-PARMAREA(%r4)	# our sccb
+	.insn rre,0xb2200000,%r2,%r1	# service call
+	ipm   %r1
+	srl   %r1,28			# get cc code
+	xr    %r3,%r3
+	chi   %r1,3
+	be    .Lfchunk-.LPG1(%r13)	# leave
+	chi   %r1,2
+	be    .Lservicecall-.LPG1(%r13)
+	lpsw  .Lwaitsclp-.LPG1(%r13)
+.Lsclph:
+	lh    %r1,.Lsccbr-PARMAREA(%r4)
+	chi   %r1,0x10			# 0x0010 is the sucess code
+	je    .Lprocsccb		# let's process the sccb
+	chi   %r1,0x1f0
+	bne   .Lfchunk-.LPG1(%r13)	# unhandled error code
+	c     %r2,.Lrcp-.LPG1(%r13)	# Did we try Read SCP forced
+	bne   .Lfchunk-.LPG1(%r13)	# if no, give up
+	l     %r2,.Lrcp2-.LPG1(%r13)	# try with Read SCP
+	b     .Lservicecall-.LPG1(%r13)
+.Lprocsccb:
+	lh    %r1,.Lscpincr1-PARMAREA(%r4) # use this one if != 0
+	chi   %r1,0x00
+	jne   .Lscnd
+	lg    %r1,.Lscpincr2-PARMAREA(%r4) # otherwise use this one
+.Lscnd:
+	xr    %r3,%r3			# same logic
+	ic    %r3,.Lscpa1-PARMAREA(%r4)
+	chi   %r3,0x00
+	jne   .Lcompmem
+	l     %r3,.Lscpa2-PARMAREA(%r13)
+.Lcompmem:
+	mlgr  %r2,%r1			# mem in MB on 128-bit
+	l     %r1,.Lonemb-.LPG1(%r13)
+	mlgr  %r2,%r1			# mem size in bytes in %r3
+	b     .Lfchunk-.LPG1(%r13)
+
+.Lpmask:
+	.byte 0
+	.align 8
+.Lcr:
+	.quad 0x00  # place holder for cr0
+.Lwaitsclp:
+	.long 0x020A0000
+	.quad .Lsclph
+.Lrcp:
+	.int 0x00120001 # Read SCP forced code
+.Lrcp2:
+	.int 0x00020001 # Read SCP code
+.Lonemb:
+	.int 0x100000
+
+.Lfchunk:
 					 # set program check new psw mask
 	mvc   __LC_PGM_NEW_PSW(8),.Lpcmsk-.LPG1(%r13)
 
 #
 # find memory chunks.
 #
+	lgr   %r9,%r3			 # end of mem
 	larl  %r1,.Lchkmem               # set program check address
 	stg   %r1,__LC_PGM_NEW_PSW+8
 	la    %r1,1                      # test in increments of 128KB
@@ -494,51 +563,51 @@
 	slgr  %r4,%r4                    # set start of chunk to zero
 	slgr  %r5,%r5                    # set end of chunk to zero
 	slr  %r6,%r6			 # set access code to zero
+	la    %r10,MEMORY_CHUNKS	 # number of chunks
 .Lloop:
 	tprot 0(%r5),0			 # test protection of first byte
 	ipm   %r7
 	srl   %r7,28
 	clr   %r6,%r7			 # compare cc with last access code
 	je    .Lsame
-	clgr  %r4,%r5			 # chunk size > 0?
-	je    .Lsize0
-	stg   %r4,0(%r3)		 # store start address of chunk
-	lgr   %r0,%r5
-	slgr  %r0,%r4
-	stg   %r0,8(%r3)		 # store size of chunk
-	st    %r6,20(%r3)		 # store type of chunk
-	la    %r3,24(%r3)
-	lgr   %r4,%r5			 # set start to end
-	larl  %r8,memory_size
-	stg   %r5,0(%r8)                 # store memory size
-.Lsize0:
-	lr    %r6,%r7			 # set access code to last cc
+	j     .Lchkmem
 .Lsame:
 	algr  %r5,%r1			 # add 128KB to end of chunk
-	brc   12,.Lloop
+					 # no need to check here,
+	brc   12,.Lloop			 # this is the same chunk
 .Lchkmem:				 # > 16EB or tprot got a program check
 	clgr  %r4,%r5			 # chunk size > 0?
-	je    .Ldonemem
+	je    .Lchkloop
 	stg   %r4,0(%r3)		 # store start address of chunk
 	lgr   %r0,%r5
 	slgr  %r0,%r4
 	stg   %r0,8(%r3)		 # store size of chunk
 	st    %r6,20(%r3)		 # store type of chunk
 	la    %r3,24(%r3)
-	lgr   %r4,%r5
 	larl  %r8,memory_size
 	stg   %r5,0(%r8)                 # store memory size
-#
-# Running native the HSA is located at 2GB and we will get an
-# addressing exception trying to access it. We have to restart
-# the scan at 2GB to find out if the machine has more than 2GB.
-#
+	ahi   %r10,-1			 # update chunk number
+.Lchkloop:
+	lr    %r6,%r7			 # set access code to last cc
+	# we got an exception or we're starting a new
+	# chunk , we must check if we should
+	# still try to find valid memory (if we detected
+	# the amount of available storage), and if we
+	# have chunks left
 	lghi  %r4,1
 	sllg  %r4,%r4,31
 	clgr  %r5,%r4
-	jhe   .Ldonemem
-	lgr   %r5,%r4
-	j     .Lloop
+	je    .Lhsaskip
+	xr    %r0, %r0
+	clgr  %r0, %r9			 # did we detect memory?
+	je    .Ldonemem			 # if not, leave
+	chi   %r10, 0			 # do we have chunks left?
+	je    .Ldonemem
+.Lhsaskip:
+	algr  %r5,%r1			 # add 128KB to end of chunk
+	lgr   %r4,%r5			 # potential new chunk
+	clgr  %r5,%r9			 # should we go on?
+	jl    .Lloop
 .Ldonemem:		
 
 	larl  %r12,machine_flags
@@ -640,6 +709,23 @@
     	.byte  "root=/dev/ram0 ro"
         .byte  0
 	.org   0x11000
+.Lsccb:
+	.hword 0x1000			# length, one page
+	.byte 0x00,0x00,0x00
+	.byte 0x80			# variable response bit set
+.Lsccbr:
+	.hword 0x00			# response code
+.Lscpincr1:
+	.hword 0x00
+.Lscpa1:
+	.byte 0x00
+	.fill 89,1,0
+.Lscpa2:
+	.int 0x00
+.Lscpincr2:
+	.quad 0x00
+	.fill 3984,1,0
+	.org 0x12000
 	.global _pend
 _pend:	
 
diff -urN linux-2.6/arch/s390/kernel/setup.c linux-2.6-s390/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	Mon May 10 04:32:00 2004
+++ linux-2.6-s390/arch/s390/kernel/setup.c	Fri Jun 11 19:09:49 2004
@@ -53,7 +53,9 @@
 unsigned int console_irq = -1;
 unsigned long memory_size = 0;
 unsigned long machine_flags = 0;
-struct { unsigned long addr, size, type; } memory_chunk[16] = { { 0 } };
+struct {
+	unsigned long addr, size, type;
+} memory_chunk[MEMORY_CHUNKS] = { { 0 } };
 #define CHUNK_READ_WRITE 0
 #define CHUNK_READ_ONLY 1
 int cpus_initialized = 0;
diff -urN linux-2.6/arch/s390/mm/extmem.c linux-2.6-s390/arch/s390/mm/extmem.c
--- linux-2.6/arch/s390/mm/extmem.c	Mon May 10 04:32:54 2004
+++ linux-2.6-s390/arch/s390/mm/extmem.c	Fri Jun 11 19:09:49 2004
@@ -55,7 +55,9 @@
 
 static spinlock_t dcss_lock = SPIN_LOCK_UNLOCKED;
 static struct list_head dcss_list = LIST_HEAD_INIT(dcss_list);
-extern struct {unsigned long addr, size, type;} memory_chunk[16];
+extern struct {
+	unsigned long addr, size, type;
+} memory_chunk[MEMORY_CHUNKS];
 
 /*
  * Create the 8 bytes, ebcdic VM segment name from
@@ -258,16 +260,16 @@
                    shared segment */
                 dcss_diag_query(dcss_name, &rwattr, &shattr, &segstart, &segend);
 		/* does segment collide with main memory? */
-		for (i=0; i<16; i++) {
-					if (memory_chunk[i].type != 0)
-						continue;
-					if (memory_chunk[i].addr > segend)
-						continue;
-					if (memory_chunk[i].addr + memory_chunk[i].size <= segstart)
-						continue;
-					spin_unlock(&dcss_lock);
-				        return -ENOENT;
-				}
+		for (i=0; i < MEMORY_CHUNKS; i++) {
+			if (memory_chunk[i].type != 0)
+				continue;
+			if (memory_chunk[i].addr > segend)
+				continue;
+			if (memory_chunk[i].addr + memory_chunk[i].size <= segstart)
+				continue;
+			spin_unlock(&dcss_lock);
+			return -ENOENT;
+		}
 		/* or does it collide with other (loaded) segments? */
         	list_for_each(l, &dcss_list) {
                 	tmp = list_entry(l, struct dcss_segment, list);
diff -urN linux-2.6/include/asm-s390/setup.h linux-2.6-s390/include/asm-s390/setup.h
--- linux-2.6/include/asm-s390/setup.h	Mon May 10 04:33:19 2004
+++ linux-2.6-s390/include/asm-s390/setup.h	Fri Jun 11 19:09:49 2004
@@ -12,6 +12,7 @@
 #define COMMAND_LINE_SIZE 	896
 #define RAMDISK_ORIGIN		0x800000
 #define RAMDISK_SIZE		0x800000
+#define MEMORY_CHUNKS		16	/* max 0x7fff */
 
 #ifndef __ASSEMBLY__
 
