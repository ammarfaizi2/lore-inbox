Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263086AbTCLILe>; Wed, 12 Mar 2003 03:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263087AbTCLILe>; Wed, 12 Mar 2003 03:11:34 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:57492 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S263086AbTCLILb>;
	Wed, 12 Mar 2003 03:11:31 -0500
Date: Wed, 12 Mar 2003 09:22:03 +0100
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix big initramfs (was: [PATCH] gen_init_cpio fixes for 2.5.64)
Message-ID: <20030312082203.GA22432@h55p111.delphi.afb.lu.se>
References: <20030305060817.GC26458@kroah.com> <20030308004249.GA23071@kroah.com> <20030308004340.GB23071@kroah.com> <20030308143745.GB7234@h55p111.delphi.afb.lu.se> <20030309060452.GA28835@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309060452.GA28835@kroah.com>
User-Agent: Mutt/1.5.3i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *18t1Ux-0006ZB-00*LzGyQM4fXXQ* (0x63.nu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 10:04:52PM -0800, Greg KH wrote:
> On Sat, Mar 08, 2003 at 03:37:45PM +0100, Anders Gustafsson wrote:
> > On Fri, Mar 07, 2003 at 04:43:40PM -0800, Greg KH wrote:
> > > 
> > > ChangeSet 1.1124, 2003/03/07 16:39:06-08:00, greg@kroah.com
> > > 
> > > gen_init_cpio: Add the ability to add files to the cpio image.
> > 
> > Have you been able to boot the kernel with a cpio-archive that contains
> > files larger than a few k? The kernel crashes on me when writing to the file
> > in ramfs.
> 
> I have not tried that, no.
> 
> > It crashes i the third or forth flush_window or so..
> 
> What does the oops show?

The oops shows a crash in balance_dirty_pages. Or rather get_dirty_limits(),
and in get_dirty_limits() we have:

    unmapped_ratio = 100 - (ps->nr_mapped * 100) / total_pages;
    
total_pages is initialized in page_writeback_init(), which is a init-call,
called far later than populate_rootfs(). So, BOOM, division by zero.

Patch below makes the call to page_writeback_init() explicit in
start_kernel, just before populate_rootfs().

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1102, 2003-03-12 09:14:47+01:00, andersg@0x63.nu
  Explicitly call page_writeback_init because it must be called before populate_rootfs()


 init/main.c         |    3 +++
 mm/page-writeback.c |    4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)


diff -Nru a/init/main.c b/init/main.c
--- a/init/main.c	Wed Mar 12 09:16:57 2003
+++ b/init/main.c	Wed Mar 12 09:16:57 2003
@@ -70,6 +70,7 @@
 extern void pte_chain_init(void);
 extern void radix_tree_init(void);
 extern void free_initmem(void);
+extern void page_writeback_init(void);
 extern void populate_rootfs(void);
 extern void driver_init(void);
 
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
--- a/mm/page-writeback.c	Wed Mar 12 09:16:57 2003
+++ b/mm/page-writeback.c	Wed Mar 12 09:16:57 2003
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


begin 664 bkpatch17604
M'XL(`/GL;CX``]656V^;,!B&K^-?\4F]Z4$!&QMSF#)E:ZNMVJ15F7HU39$#
M#D$<!4Z:3OSX&6C2-DV[M>I-P<@'[$^OW^\!'\!5+2M_(/)05G6$#N!K42M_
M@-><&OE2]R=%H?MF*)0P0[DR$UGE,C5GB9G))$%ZQJ50P0)6>KT_(`;=CJB;
M4OJ#R?F7J^^?)@B-1G"Z$'DD?TH%HQ%21;42:5B/A5JD16ZH2N1U)I4P@B)K
MME,;"V-+WS9Q*+9Y0SAF3A.0D!#!B`RQQ5S.D$C*;!S&D2P>+Z>8$DL_E/"&
M<L?VT!D0@Q!L`::F+D0W/)\PGSDGF/@8PZT?XUL?X,2"(4:?X6U%GZ(`SM=E
M&@>Q2F\@$&D*I8CD]+J*E9R)()G&>:Q@)@.QK"7H9K:LVWXW5X:Z-2\J"651
M+E.AY+32V9K7AT?H&U#;)AQ=WIF.AB^\$,("HX_0>?LG+ML]&F+99)G9JAQN
M51I!OV%&NSW;M+$=CSH-G<\(<QQNN=P+YTSLVOI4I#YA+L'$:3CU2"OB>>=;
MF\Q,Q/E&2N^]1[V&V0[FC73U"'-#X<Z]4#^/I.Q$>"`!Z^QU`._1VZ+\9@;M
M8/QKL^G?SSB%/4PMB[%&*\:T0]MV'X*-??(DV`2&]'V!W1/Q`X;5=5<TJ)?[
M,O,*WL^H8P%!%WVU*N(0IKW2/>H/V_='>HUGZ\FZ<G354G(/I7__Z%Y,+LJ*
M8"'3<5&'J5%4T1YR,2.<4$8;YG%F=4AX[/^1H._N7]=_H3M(W//E%2A<=`C(
MM=+G'70D/(G`!W3!*`$+#<QCZ%5M5,9Y!%D<+13D4O8A[A"%8Q,-]D75$;>G
7J,YUD-3+;,0QGU&.!?H+R/-63[0'````
`
end
