Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290047AbSBOQ0l>; Fri, 15 Feb 2002 11:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290012AbSBOQ01>; Fri, 15 Feb 2002 11:26:27 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:23813 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S290009AbSBOQ0F>; Fri, 15 Feb 2002 11:26:05 -0500
Date: Fri, 15 Feb 2002 17:25:47 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] meye driver update
Message-ID: <20020215162547.GC21807@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (+ BK changeset) converts the meye driver to the
new DMA API.

Linus, please apply, this patch is necessary for the driver
to be used in 2.5. Once the v4l2 patches get in, I'll submit
a larger update.

Marcelo, please put this on the queue for the next -pre1, this
patch has some minor improvements over the old one.

Stelian.

ChangeSet@1.332, 2002-02-15 16:35:31+01:00, stelian@popies.net
  Convert to the new DMA API and allocate separate DMA pages instead of one big buffer.

diff -Nru a/drivers/media/video/meye.c b/drivers/media/video/meye.c
--- a/drivers/media/video/meye.c	Fri Feb 15 16:36:44 2002
+++ b/drivers/media/video/meye.c	Fri Feb 15 16:36:44 2002
@@ -142,25 +142,6 @@
 	return ret;
 }
 
-static inline unsigned long uvirt_to_bus(unsigned long adr) {
-        unsigned long kva, ret;
-
-        kva = uvirt_to_kva(pgd_offset(current->mm, adr), adr);
-	ret = virt_to_bus((void *)kva);
-        MDEBUG(printk("uv2b(%lx-->%lx)\n", adr, ret));
-        return ret;
-}
-
-static inline unsigned long kvirt_to_bus(unsigned long adr) {
-        unsigned long va, kva, ret;
-
-        va = VMALLOC_VMADDR(adr);
-        kva = uvirt_to_kva(pgd_offset_k(va), va);
-	ret = virt_to_bus((void *)kva);
-        MDEBUG(printk("kv2b(%lx-->%lx)\n", adr, ret));
-        return ret;
-}
-
 /* Here we want the physical address of the memory.
  * This is used when initializing the contents of the
  * area and marking the pages as reserved.
@@ -209,31 +190,64 @@
 }
 
 /* return a page table pointing to N pages of locked memory */
-static void *ptable_alloc(int npages, u32 *pt_addr) {
+static int ptable_alloc(void) {
+	u32 *pt;
 	int i;
-	void *vmem;
-	u32 *ptable;
-	unsigned long adr;
-
-	vmem = rvmalloc((npages + 1) * PAGE_SIZE);
-	if (!vmem)
-		return NULL;
-
-        adr = (unsigned long)vmem;
-	ptable = (u32 *)(vmem + npages * PAGE_SIZE);
-	for (i = 0; i < npages; i++) {
-		ptable[i] = (u32) kvirt_to_bus(adr);
-		adr += PAGE_SIZE;
+
+	memset(meye.mchip_ptable, 0, sizeof(meye.mchip_ptable));
+
+	meye.mchip_ptable[MCHIP_NB_PAGES] = pci_alloc_consistent(meye.mchip_dev, 
+								 PAGE_SIZE, 
+								 &meye.mchip_dmahandle);
+	if (!meye.mchip_ptable[MCHIP_NB_PAGES])
+		return -1;
+
+	pt = (u32 *)meye.mchip_ptable[MCHIP_NB_PAGES];
+	for (i = 0; i < MCHIP_NB_PAGES; i++) {
+		meye.mchip_ptable[i] = pci_alloc_consistent(meye.mchip_dev, 
+							    PAGE_SIZE,
+							    pt);
+		if (!meye.mchip_ptable[i])
+			return -1;
+		pt++;
 	}
+	return 0;
+}
+
+static void ptable_free(void) {
+	u32 *pt;
+	int i;
 
-	*pt_addr = (u32) kvirt_to_bus(adr);
-	return vmem;
+	pt = (u32 *)meye.mchip_ptable[MCHIP_NB_PAGES];
+	for (i = 0; i < MCHIP_NB_PAGES; i++)
+		if (meye.mchip_ptable[i])
+			pci_free_consistent(meye.mchip_dev, 
+					    PAGE_SIZE, 
+					    meye.mchip_ptable[i], *pt);
+
+	if (meye.mchip_ptable[MCHIP_NB_PAGES])
+		pci_free_consistent(meye.mchip_dev, 
+				    PAGE_SIZE, 
+				    meye.mchip_ptable[MCHIP_NB_PAGES], 
+				    meye.mchip_dmahandle);
+
+	memset(meye.mchip_ptable, 0, sizeof(meye.mchip_ptable));
+	meye.mchip_dmahandle = 0;
 }
 
-static void ptable_free(void *vmem, int npages) {
-	rvfree(vmem, (npages + 1) * PAGE_SIZE);
+/* copy data from ptable into buf */
+static void ptable_copy(u8 *buf, int start, int size, int pt_pages) {
+	int i;
+	
+	for (i = 0; i < (size / PAGE_SIZE) * PAGE_SIZE; i += PAGE_SIZE) {
+		memcpy(buf + i, meye.mchip_ptable[start++], PAGE_SIZE);
+		if (start >= pt_pages)
+			start = 0;
+	}
+	memcpy(buf + i, meye.mchip_ptable[start], size % PAGE_SIZE);
 }
 
+
 /****************************************************************************/
 /* JPEG tables at different qualities to load into the VRJ chip             */
 /****************************************************************************/
@@ -587,29 +601,23 @@
 
 /* setup for DMA transfers - also zeros the framebuffer */
 static int mchip_dma_alloc(void) {
-	if (!meye.mchip_fbuffer) {
-		meye.mchip_fbuffer = ptable_alloc(MCHIP_NB_PAGES, 
-				                  &meye.mchip_ptaddr);
-		if (!meye.mchip_fbuffer)
+	if (!meye.mchip_dmahandle)
+		if (ptable_alloc())
 			return -1;
-	}
 	return 0;
 }
 
 /* frees the DMA buffer */
 static void mchip_dma_free(void) {
-	if (meye.mchip_fbuffer) {
-		ptable_free(meye.mchip_fbuffer, MCHIP_NB_PAGES);
-		meye.mchip_fbuffer = 0;
-		meye.mchip_ptaddr = 0;
-	}
+	if (meye.mchip_dmahandle)
+		ptable_free();
 }
 
 /* sets the DMA parameters into the chip */
 static void mchip_dma_setup(void) {
 	int i;
 
-	mchip_set(MCHIP_MM_PT_ADDR, meye.mchip_ptaddr);
+	mchip_set(MCHIP_MM_PT_ADDR, meye.mchip_dmahandle);
 	for (i = 0; i < 4; i++)
 		mchip_set(MCHIP_MM_FIR(i), 0);
 	meye.mchip_fnum = 0;
@@ -658,59 +666,40 @@
 	meye.mchip_fnum %= 4;
 }
 
-
 /* read one frame from the framebuffer assuming it was captured using
    a uncompressed transfer */
-static void  mchip_cont_read_frame(u32 v, u8 *buf, int size) {
+static void mchip_cont_read_frame(u32 v, u8 *buf, int size) {
 	int pt_id;
-	int avail;
 
 	pt_id = (v >> 17) & 0x3FF;
-	avail = MCHIP_NB_PAGES - pt_id;
 
-	if (size > avail*PAGE_SIZE) {
-		memcpy(buf, meye.mchip_fbuffer + pt_id * PAGE_SIZE, 
-		       avail * PAGE_SIZE);
-		memcpy(buf +avail * PAGE_SIZE, meye.mchip_fbuffer,
-		       size - avail * PAGE_SIZE);
-	}
-	else
-		memcpy(buf, meye.mchip_fbuffer + pt_id * PAGE_SIZE, size);
+	ptable_copy(buf, pt_id, size, MCHIP_NB_PAGES);
+
 }
 
 /* read a compressed frame from the framebuffer */
 static int mchip_comp_read_frame(u32 v, u8 *buf, int size) {
 	int pt_start, pt_end, trailer;
-	int fsize, fsize2;
+	int fsize;
 	int i;
 
 	pt_start = (v >> 19) & 0xFF;
 	pt_end = (v >> 11) & 0xFF;
 	trailer = (v >> 1) & 0x3FF;
 
-	if (pt_end < pt_start) {
-		fsize = (MCHIP_NB_PAGES_MJPEG - pt_start) * PAGE_SIZE;
-		fsize2 = pt_end * PAGE_SIZE + trailer * 4;
-		if (fsize + fsize2 > size) {
-			printk(KERN_WARNING "meye: oversized compressed frame %d %d\n", 
-			       fsize, fsize2);
-			return -1;
-		} else {
-			memcpy(buf, meye.mchip_fbuffer + pt_start * PAGE_SIZE, 
-			       fsize);
-			memcpy(buf + fsize, meye.mchip_fbuffer, fsize2); 
-			fsize += fsize2;
-		}
-	} else {
+	if (pt_end < pt_start)
+		fsize = (MCHIP_NB_PAGES_MJPEG - pt_start) * PAGE_SIZE +
+			pt_end * PAGE_SIZE + trailer * 4;
+	else
 		fsize = (pt_end - pt_start) * PAGE_SIZE + trailer * 4;
-		if (fsize > size) {
-			printk(KERN_WARNING "meye: oversized compressed frame %d\n", 
-			       fsize);
-			return -1;
-		} else
-			memcpy(buf, meye.mchip_fbuffer + pt_start * PAGE_SIZE, 
-			       fsize);
+
+	if (fsize > size) {
+		printk(KERN_WARNING "meye: oversized compressed frame %d\n", 
+		       fsize);
+		return -1;
 	}
+
+	ptable_copy(buf, pt_start, fsize, MCHIP_NB_PAGES_MJPEG);
 
 
 #ifdef MEYE_JPEG_CORRECTION
diff -Nru a/drivers/media/video/meye.h b/drivers/media/video/meye.h
--- a/drivers/media/video/meye.h	Fri Feb 15 16:36:44 2002
+++ b/drivers/media/video/meye.h	Fri Feb 15 16:36:44 2002
@@ -29,7 +29,7 @@
 #define _MEYE_PRIV_H_
 
 #define MEYE_DRIVER_MAJORVERSION	1
-#define MEYE_DRIVER_MINORVERSION	1
+#define MEYE_DRIVER_MINORVERSION	2
 
 /****************************************************************************/
 /* Motion JPEG chip registers                                               */
@@ -292,8 +292,8 @@
 	u8 mchip_fnum;			/* current mchip frame number */
 
 	unsigned char *mchip_mmregs;	/* mchip: memory mapped registers */
-	unsigned char *mchip_fbuffer;	/* mchip: framebuffer */
-	u32 mchip_ptaddr;		/* mchip: pointer to framebuffer */
+	u8 *mchip_ptable[MCHIP_NB_PAGES+1];/* mchip: ptable + ptable toc */
+	dma_addr_t mchip_dmahandle;	/* mchip: dma handle to ptable toc */
 
 	unsigned char *grab_fbuffer;	/* capture framebuffer */
 					/* list of buffers */


================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch3256
M'XL(``TK;3P``]58:7/;-A#]3/R*;3+M2-8%\-019>*8&D=-Y6CDIIVVR7`H
M$HPX$8\A*:=IE?_>!2A9DDV?:3Z$UI@TN+MX>/MV`?DIO,UYUE?R@B]#-R9/
MX562%WTE3=*0Y^V8%S@T2Q(<ZBR2B'>*,`Z352?/O,[\8V<9QJN_6VK;(&@V
M=0MO`1<\R_L*:VN7(\7GE/>5V>CT[2_',T*&0SA9N/$'?LX+&`Y)D607[M+/
M7[C%8IG$[2)SXSSBA=OVDFA]:;I6*57QQV"61@USS4RJ6VN/^8RY.N,^5?6N
MJ9.+,$M>1!BJG>:K-O=7UR(P365H3-=:MZ<:Q`;$JJE`U0Y^F`',[&M&7V,-
MROJ4PH:9%SM&H*%"BY*7\/\B/R$>G"0Q\E=@9"@6'&+^">S),1Q/Q^#&/KC+
M9>*Y!8><IVXF'L3;U/W`<PAC1.KZD`20Q!SFX0>8KX*`9VWR&C1+,W0RW1%/
M6@^\"*$N)<]Q,DQI]8+]+!3)[T3<#]W.1>CS!)\_\[:W8Z#'J,;6NLH,?6T8
MKNNYNN6KZMRCK(+INT,R@QF:1I%4G?:L1^);7,>G6<;:UX+`ZJE=CVO!W`R,
M!P%<7`6H8@JH5/_-BQ+E\.T(_KK0)J5,TWIKW>J:5%:->5@S6I^:M]2,Q:#5
M5;^KJBDU]09:V2?YP2J8WI*]1]24S70DKT=LE:G`R%C<5)(7;A%ZB*V`M'#G
M2^[()=0NDM"OP[]$66&_.DJ+@?#3@6GHJ)K`+/*.*!&/<E[4)*3(6X2I4\9H
M`FU"'O[#D^#ZRWI]4/I>&?]K<O)J/'7.7CK3X]/1^7L80NJ%)1S'2^(\1/KB
M@]E\?M$$HFPN$'[.^?C/T?[@3_OVD8LI]Q'#@"AA`+4?[D11QT@9+U99#"TF
M@:>XDT!-TE*_TQWG"9(,:B'ZT`&$\`P.+7"LT9!$5S`2/I@$P&M'P_YH6HA%
MW[3J4"YT?Z4*+K31&(AT6V"2[2LZ(%^0A8ULA$JVN@DRSBMDHPAIA4(^:@_U
M-E8U"LSX-C1NUG?C\@25`N;=3![RN#=8%;LI5EJJNGKZ"DW=&TH5DFH@5V:I
MMMTO@:^I8*4JILP.9EK3RDQCOZ"D<P1>DGX&WRU<"+(DV@A&])Q$=$`XZE3I
M23C55ETX0I.F;%!HE!6;1X36W'0M1[97J;J-UI3K<JD)#^CLJ*S#T>X/8=,8
M[K\L"S+R$(.`V("P64&Y1-1H(-<[UVV5R7?P?+A#*/)1CDJ>E"_DOE.\+Y,!
M/Q[,@PQC)\8TVD:/@D[&1D\0?ZW&=SG?0#OH]/6Z\,>M@=@FGHP,,C:IL0US
M4Y3]FD<DMEGN*>5-*1V$L$I-3B;.]%?GV+9GS9NT:)LFDQ!,70:2MWU5E"Y8
M+863X2Z*4[L1E_T#*^50)LB42"#&,LN0/7G#4T$7(UM=L;A]D4E/S%+H-S?"
M.BPE62JVV2V1R9M46B",!?0>0D?Z+:IC%C8,.QR/`\]$6)E!09JT%UWO,+PS
M^7DZ.H76SG9?FM"0G:N,=S`.>)H)ESS#41W5Q)<Y)[9%3;`0"B;"V#:D<M[G
ME\1@N`SQ?ZR]'LW.G-^/9V?CLU-X(C+3AT2<.-#0QZJ-THSG.3Y*LN%'_UW\
M1+85*"\96`I^;^/`N84*WU5SO*GAH(KGD@B,=^O)=?'8D^L]C]Y?'UO'(Z1J
M&)9:?N%[T-%5@Y;V71U<R^\:]SVX+AYS<-5D;Y&_G_H\"!'#9/3'R+%GX]]&
M,V<R/GLSPX?S\9LS!3E7>X;<?GJF*'31&F[9)AOL_0!W*&G1W^Y,C>U#D7AB
M=U*P4SFN[V=.`5=:UT#9>>,@;#9"9/DPQ.5_*+P%]S[FJVB(:9L'ON63_P"_
'M#-V&!$`````
`
end

-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
