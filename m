Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263113AbTCLJPM>; Wed, 12 Mar 2003 04:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263116AbTCLJPL>; Wed, 12 Mar 2003 04:15:11 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:40597 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S263113AbTCLJPG>;
	Wed, 12 Mar 2003 04:15:06 -0500
Date: Wed, 12 Mar 2003 10:25:37 +0100
To: Andrew Morton <akpm@digeo.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] fix big initramfs (was: [PATCH] gen_init_cpio fixes for 2.5.64)
Message-ID: <20030312092536.GB22432@h55p111.delphi.afb.lu.se>
References: <20030305060817.GC26458@kroah.com> <20030308004249.GA23071@kroah.com> <20030308004340.GB23071@kroah.com> <20030308143745.GB7234@h55p111.delphi.afb.lu.se> <20030309060452.GA28835@kroah.com> <20030312082203.GA22432@h55p111.delphi.afb.lu.se> <20030312004801.527dfdf1.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312004801.527dfdf1.akpm@digeo.com>
User-Agent: Mutt/1.5.3i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *18t2UT-0006zS-00*b7KuLVT1GTc* (0x63.nu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 12:48:01AM -0800, Andrew Morton wrote:
> > Patch below makes the call to page_writeback_init() explicit in
> > start_kernel, just before populate_rootfs().
> > 
> 
> Fair enough.

Sending to Linus too then.

> > +extern void page_writeback_init(void);
> 
> But please don't put declarations of external functions into .c.  It is
> always the wrong thing to do, even though others have done it...
> 
> writeback.h is a fine place for this declaration.

Allright, I did that first, but then I saw the other declarations, and
wanted to follow the style. Revised patch below.

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1102, 2003-03-12 10:01:46+01:00, andersg@0x63.nu
  Explicitly call page_writeback_init because it must be called before populate_
  rootfs()


 include/linux/writeback.h |    1 +
 init/main.c               |    3 +++
 mm/page-writeback.c       |    4 +---
 3 files changed, 5 insertions(+), 3 deletions(-)


diff -Nru a/include/linux/writeback.h b/include/linux/writeback.h
--- a/include/linux/writeback.h	Wed Mar 12 10:09:13 2003
+++ b/include/linux/writeback.h	Wed Mar 12 10:09:13 2003
@@ -79,6 +79,7 @@
 extern int dirty_expire_centisecs;
 
 
+void page_writeback_init(void);
 void balance_dirty_pages(struct address_space *mapping);
 void balance_dirty_pages_ratelimited(struct address_space *mapping);
 int pdflush_operation(void (*fn)(unsigned long), unsigned long arg0);
diff -Nru a/init/main.c b/init/main.c
--- a/init/main.c	Wed Mar 12 10:09:13 2003
+++ b/init/main.c	Wed Mar 12 10:09:13 2003
@@ -35,6 +35,7 @@
 #include <linux/profile.h>
 #include <linux/rcupdate.h>
 #include <linux/moduleparam.h>
+#include <linux/writeback.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -429,6 +430,8 @@
 	vfs_caches_init(num_physpages);
 	radix_tree_init();
 	signals_init();
+	/* rootfs populating might need page-writeback */
+	page_writeback_init();
 	populate_rootfs();
 #ifdef CONFIG_PROC_FS
 	proc_root_init();
diff -Nru a/mm/page-writeback.c b/mm/page-writeback.c
--- a/mm/page-writeback.c	Wed Mar 12 10:09:13 2003
+++ b/mm/page-writeback.c	Wed Mar 12 10:09:13 2003
@@ -369,7 +369,7 @@
  * dirty memory thresholds: allowing too much dirty highmem pins an excessive
  * number of buffer_heads.
  */
-static int __init page_writeback_init(void)
+void __init page_writeback_init(void)
 {
 	long buffer_pages = nr_free_buffer_pages();
 	long correction;
@@ -392,9 +392,7 @@
 	add_timer(&wb_timer);
 	set_ratelimit();
 	register_cpu_notifier(&ratelimit_nb);
-	return 0;
 }
-module_init(page_writeback_init);
 
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {

===================================================================


This BitKeeper patch contains the following changesets:
1.1102
## Wrapped with gzip_uu ##


begin 664 bkpatch18281
M'XL(`#GY;CX``]566V_:,!A]QK_"4E]Z$8D_VW$2-BJVMMJJ35K5J4_3A$QB
M("(7E`NE4W[\G`1H!Z%=45\*"8X3^]/Q\3DG'.&[3*6]CHQ]E683=(2_)EG>
MZY"E8$9<Z/YMDNB^Z<M<FKY:F#.5QBHT1S,S4K,9TB-N9.Y-\4+/[W7`8)L[
M^<-<]3JW5U_NOG^Z1:C?QQ=3&4_43Y7C?A_E2;J0H9\-9#X-D]C(4QEGD<JE
MX251N1E:4D*H_EI@,V*)$@3A=NF!#R`Y*)]0[@B.Y&P>#?Q@HI+=Z8PPH/ID
M($HF;,M%EQ@,`$(Q8:8^@&(@/0(]+L[T+R%XQ<=@Q0,^8[A+T&?\MJ`OD(>O
MEO,P\((\?,">#$,\EQ,UO$^#7(VD-QL&<9#CD?)DD2FL+Z,BJ_KU6.7KJW&2
M*CQ/YD4H<S74!5.]8>/L^`1]PXQS8:&;1]Y1]Y4?A(@DZ!S7]/X)YM4R#5F4
M46160+L;H(;7K)FS>MD6*RW;97;)QB/@MBVH(UQ_S.4VL_LJ-7OF$F!N*9@+
M;2""V`L+7YEA$!=+\['`=!L*H0"TM,;"&7'N@:.8E&-K!\JS]9X"HL+FC@;T
MO!JJK3,C&<1K;AH]N+H`MVPB2N7H.]SQI3-V?7VV`/JGPE,(EN,*4IMJ+^K*
M9&],V9;-?JT)^/U"8:!@:?`.\)(RF[#:@)1LVX^Y^^P'[]%^C4Q^X&YZ7Q_:
M3C?[M^L`;UX[@`$MDL!OPWU</3CY4(NDQ65M\CC8UON%L=_?6LF,4LY+K8R5
M)"SG59)@[TX2391M2:*%H@/$<,EL31JZ;II:%,,&[%YMZ#FNI0?KQM9-DR:;
MR'GY)?WJA$-1XDU5.$@R/S22=-*2<(2#`,99R5W!::T*E_^_*M[E>[H)\YV@
MV%!S2#2P:D>/5FF#/^[$S3FZY@PP11WS=(5E#2^()S@*)M,<QTHUT?*H37QJ
@HDZ;HJJD6?_UTYOLS;(BZEN>[9.1#>@OWSU4;VD*````
`
end
