Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264686AbSJPAMw>; Tue, 15 Oct 2002 20:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264689AbSJPAMv>; Tue, 15 Oct 2002 20:12:51 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:56409 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S264686AbSJPAMf>; Tue, 15 Oct 2002 20:12:35 -0400
Message-ID: <39B5C4829263D411AA93009027AE9EBB1EF28F24@fmsmsx35.fm.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: linux-kernel@vger.kernel.org
Subject: [patch 2.5.39] allow ia64 kernel to be virtually mapped from any 
	physical address
Date: Tue, 15 Oct 2002 17:18:20 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C274A9.88135AA0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C274A9.88135AA0
Content-Type: text/plain;
	charset="iso-8859-1"

LKML copy (posted to linux-ia64 list earlier today). All of
the changes are ia64 specific, except the changes to fix
fs/proc/kcore.c

The current ia64 kernel expects to be loaded at physical 68MB
(KERNEL_START in asm-ia64/system.h).  This is a problem for
machines that do not guarantee the presence of memory at that
address (e.g. ccNUMA platforms that configure memory based on
which nodes exist).

I bundled a solution to this in my earlier discontig patch (and
included other features like kernel text replication, which made
the patch far to large to be accepted).

This patch provides just the code needed to virtually map the
kernel to a fixed virtual address from whatever physical address
it happened to be loaded at (it is assumed that the bootloader
handled the issue of finding a suitably aligned piece of memory).

Almost all of the code is inside CONFIG_IA64_VMAP_KERNEL, there
are a few exceptions:

1) the "switch_mode" routine in head.S (which toggles between
running in virtual and physical mode) has been split into
separate "switch_mode_phys" and "switch_mode_virt" and the
callers changed to use the appropriate one.

2) There are new macros "__tpa()" and "__imva()" defined in
pgtable.h, versions are provided for the both the 'Y' and 'N'
state of CONFIG_IA64_VMAP_KERNEL, so that these may be used
freely in code without adding a zillion extra #ifdefs

3) fs/proc/kcore.c is currently broken (and has been for a long
time) because ia64 defines VMALLOC_START at a lower address that
PAGE_START. Try to access a vmalloc'd address to see the breakage.
This patch fixes that in changes *not* bracketed with
CONFIG_IA64_VMAP_KERNEL as well as providing the extra ELF Phdr
for the virtually mapped kernel inside the #ifdef.

4) I put the empty_zero_page changes inside #ifdef, but they
could be generic (avoids calling virt_to_page() a lot, which
may be a good thing).

-Tony



------_=_NextPart_000_01C274A9.88135AA0
Content-Type: application/octet-stream;
	name="config_ia64_vmap_kernel.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="config_ia64_vmap_kernel.diff"

diff -ru ../../REF/linux-2.5.39-ia64-020928/arch/ia64/Config.help =
aegl/arch/ia64/Config.help=0A=
--- ../../REF/linux-2.5.39-ia64-020928/arch/ia64/Config.help	Wed Oct  9 =
11:39:29 2002=0A=
+++ aegl/arch/ia64/Config.help	Mon Oct 14 10:23:04 2002=0A=
@@ -567,3 +567,9 @@=0A=
 =0A=
   Select "16MB" for a small granule size.=0A=
   Select "64MB" for a large granule size.  This is the current =
default.=0A=
+=0A=
+CONFIG_IA64_VMAP_KERNEL=0A=
+  If you say Y here, the kernel will be configured to map the =
kernel=0A=
+  to the top 4GB of the 64-bit virtual space.  This is needed for=0A=
+  certain ccNUMA machines that do not guarantee the presence of=0A=
+  memory at any particular physical address.=0A=
diff -ru ../../REF/linux-2.5.39-ia64-020928/arch/ia64/config.in =
aegl/arch/ia64/config.in=0A=
--- ../../REF/linux-2.5.39-ia64-020928/arch/ia64/config.in	Wed Oct  9 =
11:39:29 2002=0A=
+++ aegl/arch/ia64/config.in	Mon Oct  7 10:46:30 2002=0A=
@@ -71,6 +71,8 @@=0A=
 	define_bool CONFIG_IOSAPIC y=0A=
 fi=0A=
 =0A=
+bool 'Virtual mapped kernel' CONFIG_IA64_VMAP_KERNEL=0A=
+=0A=
 if [ "$CONFIG_IA64_SGI_SN1" =3D "y" -o "$CONFIG_IA64_SGI_SN2" =3D "y" =
]; then=0A=
 	define_bool CONFIG_IA64_SGI_SN y=0A=
 	bool '  Enable extra debugging code' CONFIG_IA64_SGI_SN_DEBUG=0A=
diff -ru ../../REF/linux-2.5.39-ia64-020928/arch/ia64/kernel/efi_stub.S =
aegl/arch/ia64/kernel/efi_stub.S=0A=
--- ../../REF/linux-2.5.39-ia64-020928/arch/ia64/kernel/efi_stub.S	Fri =
Sep 27 14:48:34 2002=0A=
+++ aegl/arch/ia64/kernel/efi_stub.S	Wed Oct  9 09:48:06 2002=0A=
@@ -62,7 +62,7 @@=0A=
 	mov b6=3Dr2=0A=
 	;;=0A=
 	andcm r16=3Dloc3,r16		// get psr with IT, DT, and RT bits cleared=0A=
-	br.call.sptk.many rp=3Dia64_switch_mode=0A=
+	br.call.sptk.many rp=3Dia64_switch_mode_phys=0A=
 .ret0:	mov out4=3Din5=0A=
 	mov out0=3Din1=0A=
 	mov out1=3Din2=0A=
@@ -73,7 +73,7 @@=0A=
 	br.call.sptk.many rp=3Db6		// call the EFI function=0A=
 .ret1:	mov ar.rsc=3D0			// put RSE in enforced lazy, LE mode=0A=
 	mov r16=3Dloc3=0A=
-	br.call.sptk.many rp=3Dia64_switch_mode // return to virtual mode=0A=
+	br.call.sptk.many rp=3Dia64_switch_mode_virt // return to virtual =
mode=0A=
 .ret2:	mov ar.rsc=3Dloc4			// restore RSE configuration=0A=
 	mov ar.pfs=3Dloc1=0A=
 	mov rp=3Dloc0=0A=
diff -ru ../../REF/linux-2.5.39-ia64-020928/arch/ia64/kernel/entry.S =
aegl/arch/ia64/kernel/entry.S=0A=
--- ../../REF/linux-2.5.39-ia64-020928/arch/ia64/kernel/entry.S	Fri Sep =
27 14:49:16 2002=0A=
+++ aegl/arch/ia64/kernel/entry.S	Wed Oct  9 16:23:58 2002=0A=
@@ -175,6 +175,14 @@=0A=
 	;;=0A=
 	st8 [r22]=3Dsp			// save kernel stack pointer of old task=0A=
 	shr.u r26=3Dr20,IA64_GRANULE_SHIFT=0A=
+#ifdef CONFIG_IA64_VMAP_KERNEL=0A=
+	adds r21=3DIA64_TASK_THREAD_KSP_OFFSET,in0=0A=
+	;;=0A=
+	/*=0A=
+	 * If we've already mapped this task's page, we can skip doing it =
again.=0A=
+	 */=0A=
+	cmp.eq p7,p6=3Dr26,r27=0A=
+#else=0A=
 	shr.u r17=3Dr20,KERNEL_TR_PAGE_SHIFT=0A=
 	;;=0A=
 	cmp.ne p6,p7=3DKERNEL_TR_PAGE_NUM,r17=0A=
@@ -184,6 +192,7 @@=0A=
 	 * If we've already mapped this task's page, we can skip doing it =
again.=0A=
 	 */=0A=
 (p6)	cmp.eq p7,p6=3Dr26,r27=0A=
+#endif=0A=
 (p6)	br.cond.dpnt .map=0A=
 	;;=0A=
 .done:=0A=
diff -ru ../../REF/linux-2.5.39-ia64-020928/arch/ia64/kernel/head.S =
aegl/arch/ia64/kernel/head.S=0A=
--- ../../REF/linux-2.5.39-ia64-020928/arch/ia64/kernel/head.S	Fri Sep =
27 14:50:22 2002=0A=
+++ aegl/arch/ia64/kernel/head.S	Thu Oct 10 10:47:22 2002=0A=
@@ -75,7 +75,16 @@=0A=
 	mov cr.itir=3Dr18=0A=
 	mov cr.ifa=3Dr17=0A=
 	mov r16=3DIA64_TR_KERNEL=0A=
+#ifdef	CONFIG_IA64_VMAP_KERNEL=0A=
+	mov r3=3Dip=0A=
+	movl r18=3DPAGE_KERNEL=0A=
+	;;=0A=
+	dep r2=3D0,r3,0,KERNEL_TR_PAGE_SHIFT=0A=
+	;;=0A=
+	or r18=3Dr2,r18=0A=
+#else=0A=
 	movl r18=3D((1 << KERNEL_TR_PAGE_SHIFT) | PAGE_KERNEL)=0A=
+#endif=0A=
 	;;=0A=
 	srlz.i=0A=
 	;;=0A=
@@ -144,15 +153,43 @@=0A=
 	cmp.eq isBP,isAP=3Dr0,r0=0A=
 #endif=0A=
 	;;=0A=
+#ifdef	CONFIG_IA64_VMAP_KERNEL=0A=
+	tpa r3=3Dr2		// r3 =3D=3D phys addr of task struct=0A=
+	// load mapping for stack (virtaddr in r2, physaddr in r3)=0A=
+	rsm psr.ic=0A=
+	movl r17=3DPAGE_KERNEL=0A=
+	;;=0A=
+	srlz.d=0A=
+	dep r18=3D0,r3,0,12=0A=
+	;;=0A=
+	or r18=3Dr17,r18=0A=
+	dep r2=3D-1,r3,61,3	// IMVA of task=0A=
+	;;=0A=
+	mov r17=3Drr[r2]=0A=
+	shr.u r16=3Dr3,IA64_GRANULE_SHIFT=0A=
+	;;=0A=
+	dep r17=3D0,r17,8,24=0A=
+	;;=0A=
+	mov cr.itir=3Dr17=0A=
+	mov cr.ifa=3Dr2=0A=
+=0A=
+	mov r19=3DIA64_TR_CURRENT_STACK=0A=
+	;;=0A=
+	itr.d dtr[r19]=3Dr18=0A=
+	;;=0A=
+	ssm psr.ic=0A=
+	srlz.d=0A=
+#else=0A=
 	extr r3=3Dr2,0,61		// r3 =3D=3D phys addr of task struct=0A=
 	mov r16=3DKERNEL_TR_PAGE_NUM=0A=
 	;;=0A=
+#endif=0A=
 =0A=
 	// load the "current" pointer (r13) and ar.k6 with the current =
task=0A=
 	mov r13=3Dr2=0A=
 	mov IA64_KR(CURRENT)=3Dr3		// Physical address=0A=
 =0A=
-	// initialize k4 to a safe value (64-128MB is mapped by TR_KERNEL)=0A=
+	// initialize k4 to granulized page number of stack=0A=
 	mov IA64_KR(CURRENT_STACK)=3Dr16=0A=
 	/*=0A=
 	 * Reserve space at the top of the stack for "struct pt_regs".  =
Kernel threads=0A=
@@ -668,14 +705,14 @@=0A=
 END(__ia64_init_fpu)=0A=
 =0A=
 /*=0A=
- * Switch execution mode from virtual to physical or vice versa.=0A=
+ * Switch execution mode from virtual to physical=0A=
  *=0A=
  * Inputs:=0A=
  *	r16 =3D new psr to establish=0A=
  *=0A=
  * Note: RSE must already be in enforced lazy mode=0A=
  */=0A=
-GLOBAL_ENTRY(ia64_switch_mode)=0A=
+GLOBAL_ENTRY(ia64_switch_mode_phys)=0A=
  {=0A=
 	alloc r2=3Dar.pfs,0,0,0,0=0A=
 	rsm psr.i | psr.ic		// disable interrupts and interrupt collection=0A=
@@ -685,35 +722,86 @@=0A=
  {=0A=
 	flushrs				// must be first insn in group=0A=
 	srlz.i=0A=
-	shr.u r19=3Dr15,61		// r19 <- top 3 bits of current IP=0A=
  }=0A=
 	;;=0A=
 	mov cr.ipsr=3Dr16			// set new PSR=0A=
-	add r3=3D1f-ia64_switch_mode,r15=0A=
-	xor r15=3D0x7,r19			// flip the region bits=0A=
+	add r3=3D1f-ia64_switch_mode_phys,r15=0A=
 =0A=
 	mov r17=3Dar.bsp=0A=
 	mov r14=3Drp			// get return address into a general register=0A=
+	;;=0A=
 =0A=
-	// switch RSE backing store:=0A=
+	// going to physical mode, use tpa to translate virt->phys=0A=
+	tpa r17=3Dr17=0A=
+	tpa r3=3Dr3=0A=
+	tpa sp=3Dsp=0A=
+	tpa r14=3Dr14=0A=
 	;;=0A=
-	dep r17=3Dr15,r17,61,3		// make ar.bsp physical or virtual=0A=
+=0A=
 	mov r18=3Dar.rnat			// save ar.rnat=0A=
-	;;=0A=
 	mov ar.bspstore=3Dr17		// this steps on ar.rnat=0A=
-	dep r3=3Dr15,r3,61,3		// make rfi return address physical or =
virtual=0A=
+	mov cr.iip=3Dr3=0A=
+	mov cr.ifs=3Dr0=0A=
+	;;=0A=
+	mov ar.rnat=3Dr18			// restore ar.rnat=0A=
+	rfi				// must be last insn in group=0A=
+	;;=0A=
+1:	mov rp=3Dr14=0A=
+	br.ret.sptk.many rp=0A=
+END(ia64_switch_mode_phys)=0A=
+=0A=
+/*=0A=
+ * Switch execution mode from physical to virtual=0A=
+ *=0A=
+ * Inputs:=0A=
+ *	r16 =3D new psr to establish=0A=
+ *=0A=
+ * Note: RSE must already be in enforced lazy mode=0A=
+ */=0A=
+GLOBAL_ENTRY(ia64_switch_mode_virt)=0A=
+ {=0A=
+	alloc r2=3Dar.pfs,0,0,0,0=0A=
+	rsm psr.i | psr.ic		// disable interrupts and interrupt collection=0A=
+	mov r15=3Dip=0A=
+ }=0A=
+	;;=0A=
+ {=0A=
+	flushrs				// must be first insn in group=0A=
+	srlz.i=0A=
+ }=0A=
+	;;=0A=
+	mov cr.ipsr=3Dr16			// set new PSR=0A=
+	add r3=3D1f-ia64_switch_mode_virt,r15=0A=
+=0A=
+	mov r17=3Dar.bsp=0A=
+	mov r14=3Drp			// get return address into a general register=0A=
+	;;=0A=
+=0A=
+	// going to virtual=0A=
+	//   - for code addresses, set upper bits of addr to KERNEL_START=0A=
+	//   - for stack addresses, set upper 3 bits to 0xe.... Dont change =
any of the=0A=
+	//     lower bits since we want it to stay identity mapped=0A=
+	movl r18=3DKERNEL_START=0A=
+	dep r3=3D0,r3,KERNEL_TR_PAGE_SHIFT,64-KERNEL_TR_PAGE_SHIFT=0A=
+	dep r14=3D0,r14,KERNEL_TR_PAGE_SHIFT,64-KERNEL_TR_PAGE_SHIFT=0A=
+	dep r17=3D-1,r17,61,3 =0A=
+	dep sp=3D-1,sp,61,3 =0A=
+	;;=0A=
+	or r3=3Dr3,r18=0A=
+	or r14=3Dr14,r18=0A=
 	;;=0A=
+=0A=
+	mov r18=3Dar.rnat			// save ar.rnat=0A=
+	mov ar.bspstore=3Dr17		// this steps on ar.rnat=0A=
 	mov cr.iip=3Dr3=0A=
 	mov cr.ifs=3Dr0=0A=
-	dep sp=3Dr15,sp,61,3		// make stack pointer physical or virtual=0A=
 	;;=0A=
 	mov ar.rnat=3Dr18			// restore ar.rnat=0A=
-	dep r14=3Dr15,r14,61,3		// make function return address physical or =
virtual=0A=
 	rfi				// must be last insn in group=0A=
 	;;=0A=
 1:	mov rp=3Dr14=0A=
 	br.ret.sptk.many rp=0A=
-END(ia64_switch_mode)=0A=
+END(ia64_switch_mode_virt)=0A=
 =0A=
 #ifdef CONFIG_IA64_BRL_EMU=0A=
 =0A=
diff -ru =
../../REF/linux-2.5.39-ia64-020928/arch/ia64/kernel/ia64_ksyms.c =
aegl/arch/ia64/kernel/ia64_ksyms.c=0A=
--- ../../REF/linux-2.5.39-ia64-020928/arch/ia64/kernel/ia64_ksyms.c	=
Fri Sep 27 14:49:53 2002=0A=
+++ aegl/arch/ia64/kernel/ia64_ksyms.c	Wed Oct  9 13:43:37 2002=0A=
@@ -143,3 +143,6 @@=0A=
 #endif=0A=
 EXPORT_SYMBOL(machvec_noop);=0A=
 =0A=
+#ifdef CONFIG_IA64_VMAP_KERNEL=0A=
+EXPORT_SYMBOL(zero_page_memmap_ptr);=0A=
+#endif=0A=
diff -ru ../../REF/linux-2.5.39-ia64-020928/arch/ia64/kernel/ivt.S =
aegl/arch/ia64/kernel/ivt.S=0A=
--- ../../REF/linux-2.5.39-ia64-020928/arch/ia64/kernel/ivt.S	Fri Sep =
27 14:49:08 2002=0A=
+++ aegl/arch/ia64/kernel/ivt.S	Wed Oct  9 10:17:58 2002=0A=
@@ -122,8 +122,18 @@=0A=
 	shr.u r18=3Dr22,PGDIR_SHIFT		// get bits 33-63 of the faulting =
address=0A=
 	;;=0A=
 (p7)	dep r17=3Dr17,r19,(PAGE_SHIFT-3),3	// put region number bits in =
place=0A=
+#ifdef CONFIG_IA64_VMAP_KERNEL=0A=
+	.global ia64_ivt_patch1=0A=
+ia64_ivt_patch1:=0A=
+{	.mlx // we patch this bundle to include physical address of =
swapper_pg_dir=0A=
+	srlz.d					// ensure "rsm psr.dt" has taken effect=0A=
+(p6)	movl r19=3Dswapper_pg_dir			// region 5 is rooted at =
swapper_pg_dir=0A=
+}=0A=
+	.pred.rel "mutex", p6, p7=0A=
+#else=0A=
 	srlz.d					// ensure "rsm psr.dt" has taken effect=0A=
 (p6)	movl r19=3D__pa(swapper_pg_dir)		// region 5 is rooted at =
swapper_pg_dir=0A=
+#endif=0A=
 (p6)	shr.u r21=3Dr21,PGDIR_SHIFT+PAGE_SHIFT=0A=
 (p7)	shr.u r21=3Dr21,PGDIR_SHIFT+PAGE_SHIFT-3=0A=
 	;;=0A=
@@ -415,8 +425,18 @@=0A=
 	shr.u r18=3Dr16,PGDIR_SHIFT		// get bits 33-63 of faulting address=0A=
 	;;=0A=
 (p7)	dep r17=3Dr17,r19,(PAGE_SHIFT-3),3	// put region number bits in =
place=0A=
+#ifdef CONFIG_IA64_VMAP_KERNEL=0A=
+	.global ia64_ivt_patch2=0A=
+ia64_ivt_patch2:=0A=
+{	.mlx // we patch this bundle to include physical address of =
swapper_pg_dir=0A=
+	srlz.d					// ensure "rsm psr.dt" has taken effect=0A=
+(p6)	movl r19=3Dswapper_pg_dir			// region 5 is rooted at =
swapper_pg_dir=0A=
+}=0A=
+#else=0A=
 	srlz.d=0A=
 (p6)	movl r19=3D__pa(swapper_pg_dir)		// region 5 is rooted at =
swapper_pg_dir=0A=
+#endif=0A=
+	.pred.rel "mutex", p6, p7=0A=
 (p6)	shr.u r21=3Dr21,PGDIR_SHIFT+PAGE_SHIFT=0A=
 (p7)	shr.u r21=3Dr21,PGDIR_SHIFT+PAGE_SHIFT-3=0A=
 	;;=0A=
diff -ru ../../REF/linux-2.5.39-ia64-020928/arch/ia64/kernel/mca.c =
aegl/arch/ia64/kernel/mca.c=0A=
--- ../../REF/linux-2.5.39-ia64-020928/arch/ia64/kernel/mca.c	Wed Oct  =
9 11:39:29 2002=0A=
+++ aegl/arch/ia64/kernel/mca.c	Wed Oct  9 10:26:19 2002=0A=
@@ -434,17 +434,17 @@=0A=
 =0A=
 	IA64_MCA_DEBUG("ia64_mca_init: registered mca rendezvous spinloop and =
wakeup mech.\n");=0A=
 =0A=
-	ia64_mc_info.imi_mca_handler        =3D __pa(mca_hldlr_ptr->fp);=0A=
+	ia64_mc_info.imi_mca_handler        =3D __tpa(mca_hldlr_ptr->fp);=0A=
 	/*=0A=
 	 * XXX - disable SAL checksum by setting size to 0; should be=0A=
-	 *	__pa(ia64_os_mca_dispatch_end) - __pa(ia64_os_mca_dispatch);=0A=
+	 *	__tpa(ia64_os_mca_dispatch_end) - __tpa(ia64_os_mca_dispatch);=0A=
 	 */=0A=
 	ia64_mc_info.imi_mca_handler_size	=3D 0;=0A=
 =0A=
 	/* Register the os mca handler with SAL */=0A=
 	if ((rc =3D ia64_sal_set_vectors(SAL_VECTOR_OS_MCA,=0A=
 				       ia64_mc_info.imi_mca_handler,=0A=
-				       mca_hldlr_ptr->gp,=0A=
+				       __tpa(mca_hldlr_ptr->gp),=0A=
 				       ia64_mc_info.imi_mca_handler_size,=0A=
 				       0, 0, 0)))=0A=
 	{=0A=
@@ -454,15 +454,15 @@=0A=
 	}=0A=
 =0A=
 	IA64_MCA_DEBUG("ia64_mca_init: registered os mca handler with SAL at =
0x%lx, gp =3D 0x%lx\n",=0A=
-		       ia64_mc_info.imi_mca_handler, mca_hldlr_ptr->gp);=0A=
+		       ia64_mc_info.imi_mca_handler, __tpa(mca_hldlr_ptr->gp));=0A=
 =0A=
 	/*=0A=
 	 * XXX - disable SAL checksum by setting size to 0, should be=0A=
 	 * IA64_INIT_HANDLER_SIZE=0A=
 	 */=0A=
-	ia64_mc_info.imi_monarch_init_handler		=3D __pa(mon_init_ptr->fp);=0A=
+	ia64_mc_info.imi_monarch_init_handler		=3D =
__tpa(mon_init_ptr->fp);=0A=
 	ia64_mc_info.imi_monarch_init_handler_size	=3D 0;=0A=
-	ia64_mc_info.imi_slave_init_handler		=3D __pa(slave_init_ptr->fp);=0A=
+	ia64_mc_info.imi_slave_init_handler		=3D =
__tpa(slave_init_ptr->fp);=0A=
 	ia64_mc_info.imi_slave_init_handler_size	=3D 0;=0A=
 =0A=
 	IA64_MCA_DEBUG("ia64_mca_init: os init handler at %lx\n",=0A=
@@ -471,10 +471,10 @@=0A=
 	/* Register the os init handler with SAL */=0A=
 	if ((rc =3D ia64_sal_set_vectors(SAL_VECTOR_OS_INIT,=0A=
 				       ia64_mc_info.imi_monarch_init_handler,=0A=
-				       __pa(ia64_get_gp()),=0A=
+				       __tpa(ia64_get_gp()),=0A=
 				       ia64_mc_info.imi_monarch_init_handler_size,=0A=
 				       ia64_mc_info.imi_slave_init_handler,=0A=
-				       __pa(ia64_get_gp()),=0A=
+				       __tpa(ia64_get_gp()),=0A=
 				       ia64_mc_info.imi_slave_init_handler_size)))=0A=
 	{=0A=
 		printk("ia64_mca_init: Failed to register m/s init handlers with =
SAL. rc =3D %ld\n",=0A=
diff -ru ../../REF/linux-2.5.39-ia64-020928/arch/ia64/kernel/pal.S =
aegl/arch/ia64/kernel/pal.S=0A=
--- ../../REF/linux-2.5.39-ia64-020928/arch/ia64/kernel/pal.S	Fri Sep =
27 14:50:57 2002=0A=
+++ aegl/arch/ia64/kernel/pal.S	Wed Oct  9 10:38:14 2002=0A=
@@ -164,7 +164,11 @@=0A=
 	;; =0A=
 	mov loc4=3Dar.rsc			// save RSE configuration=0A=
 	dep.z loc2=3Dloc2,0,61		// convert pal entry point to physical=0A=
+#ifdef CONFIG_IA64_VMAP_KERNEL=0A=
+	tpa r8=3Dr8			// convert rp to physical=0A=
+#else=0A=
 	dep.z r8=3Dr8,0,61		// convert rp to physical=0A=
+#endif=0A=
 	;;=0A=
 	mov b7 =3D loc2			// install target to branch reg=0A=
 	mov ar.rsc=3D0			// put RSE in enforced lazy, LE mode=0A=
@@ -174,13 +178,13 @@=0A=
 	or loc3=3Dloc3,r17		// add in psr the bits to set=0A=
 	;;=0A=
 	andcm r16=3Dloc3,r16		// removes bits to clear from psr=0A=
-	br.call.sptk.many rp=3Dia64_switch_mode=0A=
+	br.call.sptk.many rp=3Dia64_switch_mode_phys=0A=
 .ret1:	mov rp =3D r8			// install return address (physical)=0A=
 	br.cond.sptk.many b7=0A=
 1:=0A=
 	mov ar.rsc=3D0			// put RSE in enforced lazy, LE mode=0A=
 	mov r16=3Dloc3			// r16=3D original psr=0A=
-	br.call.sptk.many rp=3Dia64_switch_mode // return to virtual mode=0A=
+	br.call.sptk.many rp=3Dia64_switch_mode_virt // return to virtual =
mode=0A=
 .ret2:=0A=
 	mov psr.l =3D loc3		// restore init PSR=0A=
 =0A=
@@ -228,13 +232,13 @@=0A=
 	mov b7 =3D loc2			// install target to branch reg=0A=
 	;;=0A=
 	andcm r16=3Dloc3,r16		// removes bits to clear from psr=0A=
-	br.call.sptk.many rp=3Dia64_switch_mode=0A=
+	br.call.sptk.many rp=3Dia64_switch_mode_phys=0A=
 .ret6:=0A=
 	br.call.sptk.many rp=3Db7		// now make the call=0A=
 .ret7:=0A=
 	mov ar.rsc=3D0			// put RSE in enforced lazy, LE mode=0A=
 	mov r16=3Dloc3			// r16=3D original psr=0A=
-	br.call.sptk.many rp=3Dia64_switch_mode	// return to virtual mode=0A=
+	br.call.sptk.many rp=3Dia64_switch_mode_virt	// return to virtual =
mode=0A=
 =0A=
 .ret8:	mov psr.l  =3D loc3		// restore init PSR=0A=
 	mov ar.pfs =3D loc1=0A=
diff -ru ../../REF/linux-2.5.39-ia64-020928/arch/ia64/kernel/setup.c =
aegl/arch/ia64/kernel/setup.c=0A=
--- ../../REF/linux-2.5.39-ia64-020928/arch/ia64/kernel/setup.c	Fri Sep =
27 14:49:06 2002=0A=
+++ aegl/arch/ia64/kernel/setup.c	Tue Oct 15 13:58:00 2002=0A=
@@ -231,8 +231,8 @@=0A=
 				+ strlen(__va(ia64_boot_param->command_line)) + 1);=0A=
 	n++;=0A=
 =0A=
-	rsvd_region[n].start =3D KERNEL_START;=0A=
-	rsvd_region[n].end   =3D KERNEL_END;=0A=
+	rsvd_region[n].start =3D __imva(KERNEL_START);=0A=
+	rsvd_region[n].end   =3D __imva(KERNEL_END);=0A=
 	n++;=0A=
 =0A=
 #ifdef CONFIG_BLK_DEV_INITRD=0A=
@@ -282,6 +282,51 @@=0A=
 #endif=0A=
 }=0A=
 =0A=
+#ifdef CONFIG_IA64_VMAP_KERNEL=0A=
+/*=0A=
+ * There are two places in the performance critical path of=0A=
+ * the exception handling code where we need to know the physical=0A=
+ * address of the swapper_pg_dir structure.  This routine=0A=
+ * patches the "movl" instructions to load the value needed.=0A=
+ */=0A=
+static void __init=0A=
+patch_ivt_with_phys_swapper_pg_dir(void)=0A=
+{=0A=
+	extern char ia64_ivt_patch1[], ia64_ivt_patch2[];=0A=
+	unsigned long spd =3D __tpa(swapper_pg_dir);=0A=
+	unsigned long *p;=0A=
+=0A=
+	p =3D (unsigned long *)__imva(ia64_ivt_patch1);=0A=
+=0A=
+	*p =3D (*p & 0x3fffffffffffUL) |=0A=
+		((spd & 0x000000ffffc00000UL)<<24);=0A=
+	p++;=0A=
+	*p =3D (*p & 0xf000080fff800000UL) |=0A=
+		((spd & 0x8000000000000000UL) >> 4)  |=0A=
+		((spd & 0x7fffff0000000000UL) >> 40) |=0A=
+		((spd & 0x00000000001f0000UL) << 29) |=0A=
+		((spd & 0x0000000000200000UL) << 23) |=0A=
+		((spd & 0x000000000000ff80UL) << 43) |=0A=
+		((spd & 0x000000000000007fUL) << 36);=0A=
+=0A=
+	p =3D (unsigned long *)__imva(ia64_ivt_patch2);=0A=
+=0A=
+	*p =3D (*p & 0x3fffffffffffUL) |=0A=
+		((spd & 0x000000ffffc00000UL)<<24);=0A=
+	p++;=0A=
+	*p =3D (*p & 0xf000080fff800000UL) |=0A=
+		((spd & 0x8000000000000000UL) >> 4)  |=0A=
+		((spd & 0x7fffff0000000000UL) >> 40) |=0A=
+		((spd & 0x00000000001f0000UL) << 29) |=0A=
+		((spd & 0x0000000000200000UL) << 23) |=0A=
+		((spd & 0x000000000000ff80UL) << 43) |=0A=
+		((spd & 0x000000000000007fUL) << 36);=0A=
+}=0A=
+#define PATCH_IVT() patch_ivt_with_phys_swapper_pg_dir()=0A=
+#else=0A=
+#define PATCH_IVT()=0A=
+#endif=0A=
+=0A=
 void __init=0A=
 setup_arch (char **cmdline_p)=0A=
 {=0A=
@@ -290,6 +335,8 @@=0A=
 =0A=
 	unw_init();=0A=
 =0A=
+	PATCH_IVT();=0A=
+=0A=
 	*cmdline_p =3D __va(ia64_boot_param->command_line);=0A=
 	strncpy(saved_command_line, *cmdline_p, =
sizeof(saved_command_line));=0A=
 	saved_command_line[COMMAND_LINE_SIZE-1] =3D '\0';		/* for safety =
*/=0A=
diff -ru ../../REF/linux-2.5.39-ia64-020928/arch/ia64/kernel/smpboot.c =
aegl/arch/ia64/kernel/smpboot.c=0A=
--- ../../REF/linux-2.5.39-ia64-020928/arch/ia64/kernel/smpboot.c	Fri =
Sep 27 14:49:16 2002=0A=
+++ aegl/arch/ia64/kernel/smpboot.c	Wed Oct  9 10:58:39 2002=0A=
@@ -522,7 +522,7 @@=0A=
 	/* Tell SAL where to drop the AP's.  */=0A=
 	ap_startup =3D (struct fptr *) start_ap;=0A=
 	sal_ret =3D ia64_sal_set_vectors(SAL_VECTOR_OS_BOOT_RENDEZ,=0A=
-				       __pa(ap_startup->fp), __pa(ap_startup->gp), 0, 0, 0, 0);=0A=
+				       __tpa(ap_startup->fp), __tpa(ap_startup->gp), 0, 0, 0, =
0);=0A=
 	if (sal_ret < 0)=0A=
 		printk("SMP: Can't set SAL AP Boot Rendezvous: %s\n", =
ia64_sal_strerror(sal_ret));=0A=
 }=0A=
diff -ru ../../REF/linux-2.5.39-ia64-020928/arch/ia64/mm/init.c =
aegl/arch/ia64/mm/init.c=0A=
--- ../../REF/linux-2.5.39-ia64-020928/arch/ia64/mm/init.c	Wed Oct  9 =
11:39:29 2002=0A=
+++ aegl/arch/ia64/mm/init.c	Tue Oct 15 13:59:05 2002=0A=
@@ -39,6 +39,10 @@=0A=
 =0A=
 static int pgt_cache_water[2] =3D { 25, 50 };=0A=
 =0A=
+#ifdef CONFIG_IA64_VMAP_KERNEL=0A=
+struct page *zero_page_memmap_ptr;		/* map entry for zero page */=0A=
+#endif=0A=
+=0A=
 void=0A=
 check_pgt_cache (void)=0A=
 {=0A=
@@ -104,14 +108,16 @@=0A=
 void=0A=
 free_initmem (void)=0A=
 {=0A=
-	unsigned long addr;=0A=
+	unsigned long addr, eaddr;=0A=
 =0A=
-	addr =3D (unsigned long) &__init_begin;=0A=
-	for (; addr < (unsigned long) &__init_end; addr +=3D PAGE_SIZE) {=0A=
+	addr =3D (unsigned long)__imva(&__init_begin);=0A=
+	eaddr =3D (unsigned long)__imva(&__init_end);=0A=
+	while (addr < eaddr) {=0A=
 		ClearPageReserved(virt_to_page(addr));=0A=
 		set_page_count(virt_to_page(addr), 1);=0A=
 		free_page(addr);=0A=
 		++totalram_pages;=0A=
+		addr +=3D PAGE_SIZE;=0A=
 	}=0A=
 	printk(KERN_INFO "Freeing unused kernel memory: %ldkB freed\n",=0A=
 	       (&__init_end - &__init_begin) >> 10);=0A=
@@ -286,7 +292,7 @@=0A=
 	ia64_srlz_d();=0A=
 =0A=
 	ia64_itr(0x2, IA64_TR_PERCPU_DATA, PERCPU_ADDR,=0A=
-		 pte_val(pfn_pte(__pa(my_cpu_data) >> PAGE_SHIFT, PAGE_KERNEL)), =
PAGE_SHIFT);=0A=
+		 pte_val(pfn_pte(__tpa(my_cpu_data) >> PAGE_SHIFT, PAGE_KERNEL)), =
PAGE_SHIFT);=0A=
 =0A=
 	ia64_set_psr(psr);=0A=
 	ia64_srlz_i();=0A=
@@ -364,6 +370,9 @@=0A=
 		zones_size[ZONE_NORMAL] =3D max_low_pfn - max_dma;=0A=
 	}=0A=
 	free_area_init(zones_size);=0A=
+#ifdef CONFIG_IA64_VMAP_KERNEL=0A=
+	zero_page_memmap_ptr =3D virt_to_page(__imva(empty_zero_page));=0A=
+#endif=0A=
 }=0A=
 =0A=
 static int=0A=
@@ -442,7 +451,7 @@=0A=
 		pgt_cache_water[1] =3D num_pgt_pages;=0A=
 =0A=
 	/* install the gate page in the global page table: */=0A=
-	put_gate_page(virt_to_page(__start_gate_section), GATE_ADDR);=0A=
+	put_gate_page(virt_to_page(__imva(__start_gate_section)), =
GATE_ADDR);=0A=
 =0A=
 #ifdef CONFIG_IA32_SUPPORT=0A=
 	ia32_gdt_init();=0A=
diff -ru ../../REF/linux-2.5.39-ia64-020928/arch/ia64/vmlinux.lds.S =
aegl/arch/ia64/vmlinux.lds.S=0A=
--- ../../REF/linux-2.5.39-ia64-020928/arch/ia64/vmlinux.lds.S	Wed Oct  =
9 11:39:29 2002=0A=
+++ aegl/arch/ia64/vmlinux.lds.S	Mon Oct  7 17:12:16 2002=0A=
@@ -3,6 +3,12 @@=0A=
 #include <asm/cache.h>=0A=
 #include <asm/ptrace.h>=0A=
 #include <asm/system.h>=0A=
+#ifdef CONFIG_IA64_VMAP_KERNEL=0A=
+#include <asm/pgtable.h>=0A=
+#define	BASE_KVADDR	KERNEL_START + KERNEL_TR_PAGE_SIZE=0A=
+#else=0A=
+#define	BASE_KVADDR	PAGE_OFFSET=0A=
+#endif=0A=
 =0A=
 OUTPUT_FORMAT("elf64-ia64-little")=0A=
 OUTPUT_ARCH(ia64)=0A=
@@ -20,21 +26,21 @@=0A=
 	}=0A=
 =0A=
   v =3D PAGE_OFFSET;	/* this symbol is here to make debugging =
easier... */=0A=
-  phys_start =3D _start - PAGE_OFFSET;=0A=
+  phys_start =3D _start - BASE_KVADDR;=0A=
 =0A=
   . =3D KERNEL_START;=0A=
 =0A=
   _text =3D .;=0A=
   _stext =3D .;=0A=
-  .text : AT(ADDR(.text) - PAGE_OFFSET)=0A=
+  .text : AT(ADDR(.text) - BASE_KVADDR)=0A=
     {=0A=
 	*(.text.ivt)=0A=
 	*(.text)=0A=
     }=0A=
-  .text2 : AT(ADDR(.text2) - PAGE_OFFSET)=0A=
+  .text2 : AT(ADDR(.text2) - BASE_KVADDR)=0A=
 	{ *(.text2) }=0A=
 #ifdef CONFIG_SMP=0A=
-  .text.lock : AT(ADDR(.text.lock) - PAGE_OFFSET)=0A=
+  .text.lock : AT(ADDR(.text.lock) - BASE_KVADDR)=0A=
 	{ *(.text.lock) }=0A=
 #endif=0A=
   _etext =3D .;=0A=
@@ -47,7 +53,7 @@=0A=
   /* Exception table */=0A=
   . =3D ALIGN(16);=0A=
   __start___ex_table =3D .;=0A=
-  __ex_table : AT(ADDR(__ex_table) - PAGE_OFFSET)=0A=
+  __ex_table : AT(ADDR(__ex_table) - BASE_KVADDR)=0A=
 	{ *(__ex_table) }=0A=
   __stop___ex_table =3D .;=0A=
 =0A=
@@ -55,48 +61,48 @@=0A=
   /* Machine Vector */=0A=
   . =3D ALIGN(16);=0A=
   machvec_start =3D .;=0A=
-  .machvec : AT(ADDR(.machvec) - PAGE_OFFSET)=0A=
+  .machvec : AT(ADDR(.machvec) - BASE_KVADDR)=0A=
 	{ *(.machvec) }=0A=
   machvec_end =3D .;=0A=
 #endif=0A=
 =0A=
   __start___ksymtab =3D .;	/* Kernel symbol table */=0A=
-  __ksymtab : AT(ADDR(__ksymtab) - PAGE_OFFSET)=0A=
+  __ksymtab : AT(ADDR(__ksymtab) - BASE_KVADDR)=0A=
 	{ *(__ksymtab) }=0A=
   __stop___ksymtab =3D .;=0A=
 =0A=
   /* Unwind info & table: */=0A=
   . =3D ALIGN(8);=0A=
-  .IA_64.unwind_info : AT(ADDR(.IA_64.unwind_info) - PAGE_OFFSET)=0A=
+  .IA_64.unwind_info : AT(ADDR(.IA_64.unwind_info) - BASE_KVADDR)=0A=
 	{ *(.IA_64.unwind_info*) }=0A=
   ia64_unw_start =3D .;=0A=
-  .IA_64.unwind : AT(ADDR(.IA_64.unwind) - PAGE_OFFSET)=0A=
+  .IA_64.unwind : AT(ADDR(.IA_64.unwind) - BASE_KVADDR)=0A=
 	{ *(.IA_64.unwind*) }=0A=
   ia64_unw_end =3D .;=0A=
 =0A=
-  .rodata : AT(ADDR(.rodata) - PAGE_OFFSET)=0A=
+  .rodata : AT(ADDR(.rodata) - BASE_KVADDR)=0A=
 	{ *(.rodata) *(.rodata.*) }=0A=
-  .kstrtab : AT(ADDR(.kstrtab) - PAGE_OFFSET)=0A=
+  .kstrtab : AT(ADDR(.kstrtab) - BASE_KVADDR)=0A=
 	{ *(.kstrtab) }=0A=
-  .opd : AT(ADDR(.opd) - PAGE_OFFSET)=0A=
+  .opd : AT(ADDR(.opd) - BASE_KVADDR)=0A=
 	{ *(.opd) }=0A=
 =0A=
   /* Initialization code and data: */=0A=
 =0A=
   . =3D ALIGN(PAGE_SIZE);=0A=
   __init_begin =3D .;=0A=
-  .text.init : AT(ADDR(.text.init) - PAGE_OFFSET)=0A=
+  .text.init : AT(ADDR(.text.init) - BASE_KVADDR)=0A=
 	{ *(.text.init) }=0A=
 =0A=
-  .data.init : AT(ADDR(.data.init) - PAGE_OFFSET)=0A=
+  .data.init : AT(ADDR(.data.init) - BASE_KVADDR)=0A=
 	{ *(.data.init) }=0A=
    . =3D ALIGN(16);=0A=
   __setup_start =3D .;=0A=
-  .setup.init : AT(ADDR(.setup.init) - PAGE_OFFSET)=0A=
+  .setup.init : AT(ADDR(.setup.init) - BASE_KVADDR)=0A=
         { *(.setup.init) }=0A=
   __setup_end =3D .;=0A=
   __initcall_start =3D .;=0A=
-  .initcall.init : AT(ADDR(.initcall.init) - PAGE_OFFSET)=0A=
+  .initcall.init : AT(ADDR(.initcall.init) - BASE_KVADDR)=0A=
 	{=0A=
 		*(.initcall1.init)=0A=
 		*(.initcall2.init)=0A=
@@ -111,10 +117,10 @@=0A=
   __init_end =3D .;=0A=
 =0A=
   /* The initial task and kernel stack */=0A=
-  .data.init_task : AT(ADDR(.data.init_task) - PAGE_OFFSET)=0A=
+  .data.init_task : AT(ADDR(.data.init_task) - BASE_KVADDR)=0A=
 	{ *(.data.init_task) }=0A=
 =0A=
-  .data.page_aligned : AT(ADDR(.data.page_aligned) - PAGE_OFFSET)=0A=
+  .data.page_aligned : AT(ADDR(.data.page_aligned) - BASE_KVADDR)=0A=
         { *(__special_page_section)=0A=
 	  __start_gate_section =3D .;=0A=
 	  *(.text.gate)=0A=
@@ -122,17 +128,17 @@=0A=
 	}=0A=
 =0A=
   . =3D ALIGN(SMP_CACHE_BYTES);=0A=
-  .data.cacheline_aligned : AT(ADDR(.data.cacheline_aligned) - =
PAGE_OFFSET)=0A=
+  .data.cacheline_aligned : AT(ADDR(.data.cacheline_aligned) - =
BASE_KVADDR)=0A=
         { *(.data.cacheline_aligned) }=0A=
 =0A=
   /* Kernel symbol names for modules: */=0A=
-  .kstrtab : AT(ADDR(.kstrtab) - PAGE_OFFSET)=0A=
+  .kstrtab : AT(ADDR(.kstrtab) - BASE_KVADDR)=0A=
 	{ *(.kstrtab) }=0A=
 =0A=
   /* Per-cpu data: */=0A=
   . =3D ALIGN(PAGE_SIZE);=0A=
   __phys_per_cpu_start =3D .;=0A=
-  .data.percpu PERCPU_ADDR : AT(__phys_per_cpu_start - PAGE_OFFSET)=0A=
+  .data.percpu PERCPU_ADDR : AT(__phys_per_cpu_start - BASE_KVADDR)=0A=
 	{=0A=
 		__per_cpu_start =3D .;=0A=
 		*(.data.percpu)=0A=
@@ -140,28 +146,28 @@=0A=
 	}=0A=
   . =3D __phys_per_cpu_start + 4096;	/* ensure percpu fits into =
smallest page size (4KB) */=0A=
 =0A=
-  .data : AT(ADDR(.data) - PAGE_OFFSET)=0A=
+  .data : AT(ADDR(.data) - BASE_KVADDR)=0A=
 	{ *(.data) *(.gnu.linkonce.d*) CONSTRUCTORS }=0A=
 =0A=
   . =3D ALIGN(16);=0A=
   __gp =3D . + 0x200000;	/* gp must be 16-byte aligned for exc. table =
*/=0A=
 =0A=
-  .got : AT(ADDR(.got) - PAGE_OFFSET)=0A=
+  .got : AT(ADDR(.got) - BASE_KVADDR)=0A=
 	{ *(.got.plt) *(.got) }=0A=
   /* We want the small data sections together, so single-instruction =
offsets=0A=
      can access them all, and initialized data all before =
uninitialized, so=0A=
      we can shorten the on-disk segment size.  */=0A=
-  .sdata : AT(ADDR(.sdata) - PAGE_OFFSET)=0A=
+  .sdata : AT(ADDR(.sdata) - BASE_KVADDR)=0A=
 	{ *(.sdata) }=0A=
   _edata  =3D  .;=0A=
   _bss =3D .;=0A=
-  .sbss : AT(ADDR(.sbss) - PAGE_OFFSET)=0A=
+  .sbss : AT(ADDR(.sbss) - BASE_KVADDR)=0A=
 	{ *(.sbss) *(.scommon) }=0A=
-  .bss : AT(ADDR(.bss) - PAGE_OFFSET)=0A=
+  .bss : AT(ADDR(.bss) - BASE_KVADDR)=0A=
 	{ *(.bss) *(COMMON) }=0A=
 =0A=
   /* XXX Must this come last to avoid shifting other symbols?  =
--davidm */=0A=
-  __kallsyms : AT(ADDR(__kallsyms) - PAGE_OFFSET)=0A=
+  __kallsyms : AT(ADDR(__kallsyms) - BASE_KVADDR)=0A=
 	{=0A=
 	  __start___kallsyms =3D .;	/* All kernel symbols */=0A=
 	  *(__kallsyms)=0A=
diff -ru ../../REF/linux-2.5.39-ia64-020928/fs/proc/kcore.c =
aegl/fs/proc/kcore.c=0A=
--- ../../REF/linux-2.5.39-ia64-020928/fs/proc/kcore.c	Fri Sep 27 =
14:48:35 2002=0A=
+++ aegl/fs/proc/kcore.c	Tue Oct 15 13:03:44 2002=0A=
@@ -99,6 +99,12 @@=0A=
 }=0A=
 #else /* CONFIG_KCORE_AOUT */=0A=
 =0A=
+#if VMALLOC_START < PAGE_OFFSET=0A=
+#define	KCORE_BASE	VMALLOC_START=0A=
+#else=0A=
+#define	KCORE_BASE	PAGE_OFFSET=0A=
+#endif=0A=
+=0A=
 #define roundup(x, y)  ((((x)+((y)-1))/(y))*(y))=0A=
 =0A=
 /* An ELF note in memory */=0A=
@@ -111,6 +117,12 @@=0A=
 };=0A=
 =0A=
 extern char saved_command_line[];=0A=
+#ifdef CONFIG_IA64_VMAP_KERNEL=0A=
+extern char _stext[], _end[];=0A=
+#define NPHDR	3=0A=
+#else=0A=
+#define NPHDR	2=0A=
+#endif=0A=
 =0A=
 static size_t get_kcore_size(int *num_vma, size_t *elf_buflen)=0A=
 {=0A=
@@ -118,7 +130,11 @@=0A=
 	struct vm_struct *m;=0A=
 =0A=
 	*num_vma =3D 0;=0A=
-	size =3D ((size_t)high_memory - PAGE_OFFSET + PAGE_SIZE);=0A=
+	size =3D ((size_t)high_memory - KCORE_BASE + PAGE_SIZE);=0A=
+#ifdef CONFIG_IA64_VMAP_KERNEL=0A=
+	if ((size_t)_end > KCORE_BASE + size)=0A=
+		size =3D (size_t)_end - KCORE_BASE;=0A=
+#endif=0A=
 	if (!vmlist) {=0A=
 		*elf_buflen =3D PAGE_SIZE;=0A=
 		return (size);=0A=
@@ -126,15 +142,15 @@=0A=
 =0A=
 	for (m=3Dvmlist; m; m=3Dm->next) {=0A=
 		try =3D (size_t)m->addr + m->size;=0A=
-		if (try > size)=0A=
-			size =3D try;=0A=
+		if (try > KCORE_BASE + size)=0A=
+			size =3D try - KCORE_BASE;=0A=
 		*num_vma =3D *num_vma + 1;=0A=
 	}=0A=
 	*elf_buflen =3D	sizeof(struct elfhdr) + =0A=
-			(*num_vma + 2)*sizeof(struct elf_phdr) + =0A=
+			(*num_vma + NPHDR)*sizeof(struct elf_phdr) + =0A=
 			3 * sizeof(struct memelfnote);=0A=
 	*elf_buflen =3D PAGE_ALIGN(*elf_buflen);=0A=
-	return (size - PAGE_OFFSET + *elf_buflen);=0A=
+	return size + *elf_buflen;=0A=
 }=0A=
 =0A=
 =0A=
@@ -237,12 +253,26 @@=0A=
 	offset +=3D sizeof(struct elf_phdr);=0A=
 	phdr->p_type	=3D PT_LOAD;=0A=
 	phdr->p_flags	=3D PF_R|PF_W|PF_X;=0A=
-	phdr->p_offset	=3D dataoff;=0A=
+	phdr->p_offset	=3D PAGE_OFFSET - KCORE_BASE + dataoff;=0A=
 	phdr->p_vaddr	=3D PAGE_OFFSET;=0A=
 	phdr->p_paddr	=3D __pa(PAGE_OFFSET);=0A=
 	phdr->p_filesz	=3D phdr->p_memsz =3D ((unsigned long)high_memory - =
PAGE_OFFSET);=0A=
 	phdr->p_align	=3D PAGE_SIZE;=0A=
 =0A=
+#ifdef CONFIG_IA64_VMAP_KERNEL=0A=
+	/* setup ELF PT_LOAD program header for kernel */=0A=
+	phdr =3D (struct elf_phdr *) bufp;=0A=
+	bufp +=3D sizeof(struct elf_phdr);=0A=
+	offset +=3D sizeof(struct elf_phdr);=0A=
+	phdr->p_type	=3D PT_LOAD;=0A=
+	phdr->p_flags	=3D PF_R|PF_W|PF_X;=0A=
+	phdr->p_offset	=3D (unsigned long)_stext - KCORE_BASE + dataoff;=0A=
+	phdr->p_vaddr	=3D (unsigned long)_stext;=0A=
+	phdr->p_paddr	=3D __tpa(_stext);=0A=
+	phdr->p_filesz	=3D phdr->p_memsz =3D _end - _stext;=0A=
+	phdr->p_align	=3D PAGE_SIZE;=0A=
+#endif=0A=
+=0A=
 	/* setup ELF PT_LOAD program header for every vmalloc'd area */=0A=
 	for (m=3Dvmlist; m; m=3Dm->next) {=0A=
 		if (m->flags & VM_IOREMAP) /* don't dump ioremap'd stuff! (TA) */=0A=
@@ -254,7 +284,7 @@=0A=
 =0A=
 		phdr->p_type	=3D PT_LOAD;=0A=
 		phdr->p_flags	=3D PF_R|PF_W|PF_X;=0A=
-		phdr->p_offset	=3D (size_t)m->addr - PAGE_OFFSET + dataoff;=0A=
+		phdr->p_offset	=3D (size_t)m->addr - KCORE_BASE + dataoff;=0A=
 		phdr->p_vaddr	=3D (size_t)m->addr;=0A=
 		phdr->p_paddr	=3D __pa(m->addr);=0A=
 		phdr->p_filesz	=3D phdr->p_memsz	=3D m->size;=0A=
@@ -385,9 +415,9 @@=0A=
 	/*=0A=
 	 * Fill the remainder of the buffer from kernel VM space.=0A=
 	 * We said in the ELF header that the data which starts=0A=
-	 * at 'elf_buflen' is virtual address PAGE_OFFSET. --rmk=0A=
+	 * at 'elf_buflen' is virtual address KCORE_BASE. --rmk=0A=
 	 */=0A=
-	start =3D PAGE_OFFSET + (*fpos - elf_buflen);=0A=
+	start =3D KCORE_BASE + (*fpos - elf_buflen);=0A=
 	if ((tsz =3D (PAGE_SIZE - (start & ~PAGE_MASK))) > buflen)=0A=
 		tsz =3D buflen;=0A=
 		=0A=
@@ -446,6 +476,17 @@=0A=
 				if (clear_user(buffer, tsz))=0A=
 					return -EFAULT;=0A=
 			}=0A=
+#ifdef CONFIG_IA64_VMAP_KERNEL=0A=
+		} else if ((start > (unsigned long)_stext) && (start < =0A=
+						(unsigned long)_end)) {=0A=
+			if (kern_addr_valid(start)) {=0A=
+				if (copy_to_user(buffer, (char *)start, tsz))=0A=
+					return -EFAULT;=0A=
+			} else {=0A=
+				if (clear_user(buffer, tsz))=0A=
+					return -EFAULT;=0A=
+			}=0A=
+#endif=0A=
 		} else {=0A=
 			if (clear_user(buffer, tsz))=0A=
 				return -EFAULT;=0A=
diff -ru ../../REF/linux-2.5.39-ia64-020928/include/asm-ia64/page.h =
aegl/include/asm-ia64/page.h=0A=
--- ../../REF/linux-2.5.39-ia64-020928/include/asm-ia64/page.h	Fri Sep =
27 14:49:06 2002=0A=
+++ aegl/include/asm-ia64/page.h	Tue Oct  8 17:49:48 2002=0A=
@@ -106,6 +106,13 @@=0A=
  */=0A=
 #define __pa(x)		({ia64_va _v; _v.l =3D (long) (x); _v.f.reg =3D 0; =
_v.l;})=0A=
 #define __va(x)		({ia64_va _v; _v.l =3D (long) (x); _v.f.reg =3D -1; =
_v.p;})=0A=
+#ifdef CONFIG_IA64_VMAP_KERNEL=0A=
+#define __tpa(x)	({ia64_va _v; asm("tpa %0=3D%1" : "=3Dr"(_v.l) : =
"r"(x)); _v.l;})=0A=
+#define __imva(x)	((long)__va(__tpa(x)))=0A=
+#else=0A=
+#define __tpa(x)	__pa(x)=0A=
+#define __imva(x)	(x)=0A=
+#endif=0A=
 =0A=
 #define REGION_NUMBER(x)	({ia64_va _v; _v.l =3D (long) (x); =
_v.f.reg;})=0A=
 #define REGION_OFFSET(x)	({ia64_va _v; _v.l =3D (long) (x); =
_v.f.off;})=0A=
diff -ru ../../REF/linux-2.5.39-ia64-020928/include/asm-ia64/pgtable.h =
aegl/include/asm-ia64/pgtable.h=0A=
--- ../../REF/linux-2.5.39-ia64-020928/include/asm-ia64/pgtable.h	Fri =
Sep 27 14:49:40 2002=0A=
+++ aegl/include/asm-ia64/pgtable.h	Wed Oct  9 13:53:42 2002=0A=
@@ -415,7 +415,12 @@=0A=
  * for zero-mapped memory areas etc..=0A=
  */=0A=
 extern unsigned long empty_zero_page[PAGE_SIZE/sizeof(unsigned =
long)];=0A=
+#ifdef CONFIG_IA64_VMAP_KERNEL=0A=
+extern struct page *zero_page_memmap_ptr;=0A=
+#define ZERO_PAGE(vaddr) (zero_page_memmap_ptr)=0A=
+#else=0A=
 #define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))=0A=
+#endif=0A=
 =0A=
 /* We provide our own get_unmapped_area to cope with VA holes for =
userland */=0A=
 #define HAVE_ARCH_UNMAPPED_AREA=0A=
@@ -440,7 +445,9 @@=0A=
  */=0A=
 #define KERNEL_TR_PAGE_SHIFT	_PAGE_SIZE_64M=0A=
 #define KERNEL_TR_PAGE_SIZE	(1 << KERNEL_TR_PAGE_SHIFT)=0A=
+#ifndef CONFIG_IA64_VMAP_KERNEL=0A=
 #define KERNEL_TR_PAGE_NUM	((KERNEL_START - PAGE_OFFSET) / =
KERNEL_TR_PAGE_SIZE)=0A=
+#endif=0A=
 =0A=
 /*=0A=
  * No page table caches to initialise=0A=
diff -ru ../../REF/linux-2.5.39-ia64-020928/include/asm-ia64/system.h =
aegl/include/asm-ia64/system.h=0A=
--- ../../REF/linux-2.5.39-ia64-020928/include/asm-ia64/system.h	Fri =
Sep 27 14:49:49 2002=0A=
+++ aegl/include/asm-ia64/system.h	Mon Oct  7 10:59:03 2002=0A=
@@ -18,7 +18,11 @@=0A=
 #include <asm/page.h>=0A=
 #include <asm/pal.h>=0A=
 =0A=
+#ifdef	CONFIG_IA64_VMAP_KERNEL=0A=
+#define KERNEL_START		(0xffffffff00000000)=0A=
+#else=0A=
 #define KERNEL_START		(PAGE_OFFSET + 68*1024*1024)=0A=
+#endif=0A=
 =0A=
 #define GATE_ADDR		(0xa000000000000000 + PAGE_SIZE)=0A=
 #define PERCPU_ADDR		(0xa000000000000000 + 2*PAGE_SIZE)=0A=

------_=_NextPart_000_01C274A9.88135AA0--
