Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265439AbUANKxw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 05:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265461AbUANKxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 05:53:52 -0500
Received: from nikam.ms.mff.cuni.cz ([195.113.18.106]:8915 "EHLO
	nikam.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265439AbUANKxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 05:53:42 -0500
Date: Wed, 14 Jan 2004 11:53:41 +0100
From: Jan Hubicka <jh@suse.cz>
To: Andi Kleen <ak@colin2.muc.de>
Cc: Jakub Jelinek <jakub@redhat.com>, Andi Kleen <ak@muc.de>, akpm@osdl.org,
       jh@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix compilation on gcc 3.4
Message-ID: <20040114105341.GB26326@kam.mff.cuni.cz>
References: <20040114083700.GA1820@averell> <20040114084721.GP31589@devserv.devel.redhat.com> <20040114085825.GA10916@colin2.muc.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <20040114085825.GA10916@colin2.muc.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> On Wed, Jan 14, 2004 at 03:47:22AM -0500, Jakub Jelinek wrote:
> > On Wed, Jan 14, 2004 at 09:37:00AM +0100, Andi Kleen wrote:
> > > 
> > > The upcomming gcc 3.4 has a new inlining algorithm which sometimes
> > > fails to inline some "dumb" inlines in the kernel. This sometimes leads
> > > to undefined symbols while linking.
> > 
> > It fails to inline routines with always_inline attribute?
> > That sounds like a gcc bug.  always_inline should mean inline always,
> > and issue error if for some reason it is impossible.
> 
> The problem is that there are some functions that are declared
> inline in header files, but there is no body available. When they are
> called this ends with an hard error in gcc. I started with fixing
> them but eventually gave up because there were so many of them.
> 
> In addition you get tons of ugly warnings.

Yes, this is not really bug, but the simple fact that if compler never
see the function body, it can not inline it.  Old compilers accepted
this by mystake, as always_inline is supposed to cause hard error each
time function failes to be inlined.

I made testing with equivalent of Andi's patch and with my last fixes to
GCC code size estimate, there are 50 calls in the whole kernel where GCC
concludes that inlining is not good idea.  I plan to investigate these
too, but there is simple --param knob you may want to use if you really
think these are sane.

For a record, I made patch that fixes all the cases for my default
configuration.  You may consider it applying together with Andi's patch,
so -Winline output does not contain unnecesary complains.

I am also attaching the list of warnings I get during build.  The
parameter inlie-unit-growth is specifying the maximal growth (in
percent) number of instruction can increase within single source file by
inlining.  As Kernel does a lot of inlining and has small sources,
perhaps adjusting up from 50% makes sense.  Perhaps I will do this
default in GCC too.

Honza

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=kernelpa

Hi,
GCC 3.4 is now outputting error message when function marked always_inline
can't be inlined for wathever reason.  This include the case of function
body not being present in current compilation unit at all.  With current
always_inline hack in kernel, it is necessary to provide body to function
marked as inlined (otherwise the mark is ignored).
The patch removes such inline keywords that are ignored by older compilers
anyway.

Honza

diff -urp ./fs/ntfs.old/ntfs.h ./fs/ntfs/ntfs.h
--- ./fs/ntfs.old/ntfs.h	2004-01-13 00:57:33.000000000 +0100
+++ ./fs/ntfs/ntfs.h	2004-01-13 00:58:04.000000000 +0100
@@ -183,7 +183,7 @@ extern void post_write_mst_fixup(NTFS_RE
 /* From fs/ntfs/time.c */
 extern inline s64 utc2ntfs(const time_t time);
 extern inline s64 get_current_ntfs_time(void);
-extern inline time_t ntfs2utc(const s64 time);
+extern time_t ntfs2utc(const s64 time);
 
 /* From fs/ntfs/unistr.c */
 extern BOOL ntfs_are_names_equal(const uchar_t *s1, size_t s1_len,
diff -urp ./arch/i386.old/kernel/setup.c ./arch/i386/kernel/setup.c
--- ./arch/i386.old/kernel/setup.c	2004-01-13 15:58:40.000000000 +0100
+++ ./arch/i386/kernel/setup.c	2004-01-13 15:59:29.000000000 +0100
@@ -52,7 +52,7 @@
 
 int disable_pse __initdata = 0;
 
-static inline char * __init machine_specific_memory_setup(void);
+static char * __init machine_specific_memory_setup(void);
 
 /*
  * Machine setup..
diff -urp ./kernel.old/fork.c ./kernel/fork.c
--- ./kernel.old/fork.c	2004-01-13 00:51:45.000000000 +0100
+++ ./kernel/fork.c	2004-01-13 00:51:54.000000000 +0100
@@ -417,7 +417,7 @@ struct mm_struct * mm_alloc(void)
  * is dropped: either by a lazy thread or by
  * mmput. Free the page directory and the mm.
  */
-inline void __mmdrop(struct mm_struct *mm)
+void __mmdrop(struct mm_struct *mm)
 {
 	BUG_ON(mm == &init_mm);
 	mm_free_pgd(mm);
diff -urp ./include.old/asm/apic.h ./include/asm/apic.h
--- ./include.old/asm/apic.h	2004-01-13 00:38:37.000000000 +0100
+++ ./include/asm/apic.h	2004-01-13 00:39:10.000000000 +0100
@@ -85,7 +85,7 @@ extern void disable_lapic_nmi_watchdog(v
 extern void enable_lapic_nmi_watchdog(void);
 extern void disable_timer_nmi_watchdog(void);
 extern void enable_timer_nmi_watchdog(void);
-extern inline void nmi_watchdog_tick (struct pt_regs * regs);
+extern void nmi_watchdog_tick (struct pt_regs * regs);
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
Only in ./include/asm-i386: .string.h.swp
diff -urp ./include.old/asm-i386/apic.h ./include/asm-i386/apic.h
--- ./include.old/asm-i386/apic.h	2004-01-13 00:38:37.000000000 +0100
+++ ./include/asm-i386/apic.h	2004-01-13 00:39:10.000000000 +0100
@@ -85,7 +85,7 @@ extern void disable_lapic_nmi_watchdog(v
 extern void enable_lapic_nmi_watchdog(void);
 extern void disable_timer_nmi_watchdog(void);
 extern void enable_timer_nmi_watchdog(void);
-extern inline void nmi_watchdog_tick (struct pt_regs * regs);
+extern void nmi_watchdog_tick (struct pt_regs * regs);
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
Only in ./include/linux: .reiserfs_fs.h.swp
diff -urp ./include.old/linux/bio.h ./include/linux/bio.h
--- ./include.old/linux/bio.h	2004-01-13 00:38:36.000000000 +0100
+++ ./include/linux/bio.h	2004-01-13 02:35:21.000000000 +0100
@@ -231,13 +231,13 @@ extern void bio_put(struct bio *);
 
 extern void bio_endio(struct bio *, unsigned int, int);
 struct request_queue;
-extern inline int bio_phys_segments(struct request_queue *, struct bio *);
-extern inline int bio_hw_segments(struct request_queue *, struct bio *);
+extern int bio_phys_segments(struct request_queue *, struct bio *);
+extern int bio_hw_segments(struct request_queue *, struct bio *);
 
-extern inline void __bio_clone(struct bio *, struct bio *);
+extern void __bio_clone(struct bio *, struct bio *);
 extern struct bio *bio_clone(struct bio *, int);
 
-extern inline void bio_init(struct bio *);
+extern void bio_init(struct bio *);
 
 extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);
 extern int bio_get_nr_vecs(struct block_device *);
diff -urp ./include.old/linux/compile.h ./include/linux/compile.h
--- ./include.old/linux/compile.h	2004-01-13 00:38:36.000000000 +0100
+++ ./include/linux/compile.h	2004-01-13 19:04:06.000000000 +0100
@@ -1,7 +1,7 @@
-/* This file is auto generated, version 0 */
+/* This file is auto generated, version 4 */
 #define UTS_MACHINE "i386"
-#define UTS_VERSION "#0 Tue Jan 13 00:36:03 CET 2004"
-#define LINUX_COMPILE_TIME "00:36:03"
+#define UTS_VERSION "#4 Tue Jan 13 19:04:06 CET 2004"
+#define LINUX_COMPILE_TIME "19:04:06"
 #define LINUX_COMPILE_BY "root"
 #define LINUX_COMPILE_HOST "ibm"
 #define LINUX_COMPILE_DOMAIN "home.cz"
diff -urp ./include.old/linux/efi.h ./include/linux/efi.h
--- ./include.old/linux/efi.h	2004-01-13 00:38:36.000000000 +0100
+++ ./include/linux/efi.h	2004-01-13 00:39:55.000000000 +0100
@@ -297,8 +297,8 @@ extern u64 efi_mem_attributes (unsigned 
 extern void efi_initialize_iomem_resources(struct resource *code_resource,
 					struct resource *data_resource);
 extern efi_status_t phys_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc);
-extern unsigned long inline __init efi_get_time(void);
-extern int inline __init efi_set_rtc_mmss(unsigned long nowtime);
+extern unsigned long __init efi_get_time(void);
+extern int __init efi_set_rtc_mmss(unsigned long nowtime);
 extern struct efi_memory_map memmap;
 
 #ifdef CONFIG_EFI
diff -urp ./include.old/linux/elevator.h ./include/linux/elevator.h
--- ./include.old/linux/elevator.h	2004-01-13 00:38:36.000000000 +0100
+++ ./include/linux/elevator.h	2004-01-13 02:38:19.000000000 +0100
@@ -96,9 +96,9 @@ extern elevator_t iosched_as;
 
 extern int elevator_init(request_queue_t *, elevator_t *);
 extern void elevator_exit(request_queue_t *);
-extern inline int elv_rq_merge_ok(struct request *, struct bio *);
-extern inline int elv_try_merge(struct request *, struct bio *);
-extern inline int elv_try_last_merge(request_queue_t *, struct bio *);
+extern int elv_rq_merge_ok(struct request *, struct bio *);
+extern int elv_try_merge(struct request *, struct bio *);
+extern int elv_try_last_merge(request_queue_t *, struct bio *);
 
 /*
  * Return values from elevator merger
diff -urp ./include.old/linux/ide.h ./include/linux/ide.h
--- ./include.old/linux/ide.h	2004-01-13 00:38:36.000000000 +0100
+++ ./include/linux/ide.h	2004-01-13 03:02:22.000000000 +0100
@@ -1417,12 +1417,12 @@ typedef struct pkt_task_s {
 	void			*special;
 } pkt_task_t;
 
-extern inline u32 ide_read_24(ide_drive_t *);
+extern u32 ide_read_24(ide_drive_t *);
 
-extern inline void SELECT_DRIVE(ide_drive_t *);
-extern inline void SELECT_INTERRUPT(ide_drive_t *);
-extern inline void SELECT_MASK(ide_drive_t *, int);
-extern inline void QUIRK_LIST(ide_drive_t *);
+extern void SELECT_DRIVE(ide_drive_t *);
+extern void SELECT_INTERRUPT(ide_drive_t *);
+extern void SELECT_MASK(ide_drive_t *, int);
+extern void QUIRK_LIST(ide_drive_t *);
 
 extern void ata_input_data(ide_drive_t *, void *, u32);
 extern void ata_output_data(ide_drive_t *, void *, u32);
diff -urp ./include.old/linux/reiserfs_fs.h ./include/linux/reiserfs_fs.h
--- ./include.old/linux/reiserfs_fs.h	2004-01-13 00:38:37.000000000 +0100
+++ ./include/linux/reiserfs_fs.h	2004-01-13 01:07:58.000000000 +0100
@@ -1780,26 +1780,26 @@ int reiserfs_convert_objectid_map_v1(str
 
 /* stree.c */
 int B_IS_IN_TREE(const struct buffer_head *);
-extern inline void copy_short_key (void * to, const void * from);
-extern inline void copy_item_head(struct item_head * p_v_to, 
+extern void copy_short_key (void * to, const void * from);
+extern void copy_item_head(struct item_head * p_v_to, 
 								  const struct item_head * p_v_from);
 
 // first key is in cpu form, second - le
-extern inline int comp_keys (const struct key * le_key, 
+extern int comp_keys (const struct key * le_key, 
+		      const struct cpu_key * cpu_key);
+extern int  comp_short_keys (const struct key * le_key, 
 			     const struct cpu_key * cpu_key);
-extern inline int  comp_short_keys (const struct key * le_key, 
-				    const struct cpu_key * cpu_key);
-extern inline void le_key2cpu_key (struct cpu_key * to, const struct key * from);
+extern void le_key2cpu_key (struct cpu_key * to, const struct key * from);
 
 // both are cpu keys
-extern inline int comp_cpu_keys (const struct cpu_key *, const struct cpu_key *);
-extern inline int comp_short_cpu_keys (const struct cpu_key *, 
+extern int comp_cpu_keys (const struct cpu_key *, const struct cpu_key *);
+extern int comp_short_cpu_keys (const struct cpu_key *, 
 				       const struct cpu_key *);
 extern inline void cpu_key2cpu_key (struct cpu_key *, const struct cpu_key *);
 
 // both are in le form
-extern inline int comp_le_keys (const struct key *, const struct key *);
-extern inline int comp_short_le_keys (const struct key *, const struct key *);
+extern int comp_le_keys (const struct key *, const struct key *);
+extern int comp_short_le_keys (const struct key *, const struct key *);
 
 //
 // get key version from on disk key - kludge
@@ -1834,7 +1834,7 @@ int search_by_key (struct super_block *,
 int search_for_position_by_key (struct super_block * p_s_sb, 
 								const struct cpu_key * p_s_cpu_key, 
 								struct path * p_s_search_path);
-extern inline void decrement_bcount (struct buffer_head * p_s_bh);
+extern void decrement_bcount (struct buffer_head * p_s_bh);
 void decrement_counters_in_path (struct path * p_s_search_path);
 void pathrelse (struct path * p_s_search_path);
 int reiserfs_check_path(struct path *p) ;
@@ -1916,7 +1916,7 @@ void sd_attrs_to_i_attrs( __u16 sd_attrs
 void i_attrs_to_sd_attrs( struct inode *inode, __u16 *sd_attrs );
 
 /* namei.c */
-inline void set_de_name_and_namelen (struct reiserfs_dir_entry * de);
+void set_de_name_and_namelen (struct reiserfs_dir_entry * de);
 int search_by_entry_key (struct super_block * sb, const struct cpu_key * key, 
 			 struct path * path, 
 			 struct reiserfs_dir_entry * de);
@@ -2037,8 +2037,8 @@ int balance_internal (struct tree_balanc
                       struct buffer_head **);
 
 /* do_balance.c */
-inline void do_balance_mark_leaf_dirty (struct tree_balance * tb, 
-					struct buffer_head * bh, int flag);
+void do_balance_mark_leaf_dirty (struct tree_balance * tb, 
+				 struct buffer_head * bh, int flag);
 #define do_balance_mark_internal_dirty do_balance_mark_leaf_dirty
 #define do_balance_mark_sb_dirty do_balance_mark_leaf_dirty
 
diff -urp ./include.old/linux/sched.h ./include/linux/sched.h
--- ./include.old/linux/sched.h	2004-01-13 00:38:36.000000000 +0100
+++ ./include/linux/sched.h	2004-01-13 00:50:45.000000000 +0100
@@ -669,7 +669,7 @@ static inline int capable(int cap)
 extern struct mm_struct * mm_alloc(void);
 
 /* mmdrop drops the mm and the page tables */
-extern inline void FASTCALL(__mmdrop(struct mm_struct *));
+extern void FASTCALL(__mmdrop(struct mm_struct *));
 static inline void mmdrop(struct mm_struct * mm)
 {
 	if (atomic_dec_and_test(&mm->mm_count))
diff -urp ./include.old/net/tcp.h ./include/net/tcp.h
--- ./include.old/net/tcp.h	2004-01-13 00:38:36.000000000 +0100
+++ ./include/net/tcp.h	2004-01-13 15:37:24.000000000 +0100
@@ -738,7 +738,7 @@ DECLARE_SNMP_STAT(struct tcp_mib, tcp_st
 #define TCP_ADD_STATS_BH(field, val)	SNMP_ADD_STATS_BH(tcp_statistics, field, val)
 #define TCP_ADD_STATS_USER(field, val)	SNMP_ADD_STATS_USER(tcp_statistics, field, val)
 
-extern inline void		tcp_put_port(struct sock *sk);
+extern void			tcp_put_port(struct sock *sk);
 extern void			tcp_inherit_port(struct sock *sk, struct sock *child);
 
 extern void			tcp_v4_err(struct sk_buff *skb, u32);

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=oo

fs/lockd/xdr.c:48: warning: inlining failed in call to 'nlm_decode_cookie': --param inline-unit-growth limit reached
fs/lockd/xdr.c:48: warning: inlining failed in call to 'nlm_decode_cookie': --param inline-unit-growth limit reached
fs/lockd/xdr.c:48: warning: inlining failed in call to 'nlm_decode_cookie': --param inline-unit-growth limit reached
fs/lockd/xdr.c:48: warning: inlining failed in call to 'nlm_decode_cookie': --param inline-unit-growth limit reached
fs/lockd/xdr.c:48: warning: inlining failed in call to 'nlm_decode_cookie': --param inline-unit-growth limit reached
fs/lockd/xdr.c:48: warning: inlining failed in call to 'nlm_decode_cookie': --param inline-unit-growth limit reached
fs/lockd/xdr.c:48: warning: inlining failed in call to 'nlm_decode_cookie': --param inline-unit-growth limit reached
fs/lockd/xdr.c:48: warning: inlining failed in call to 'nlm_decode_cookie': --param inline-unit-growth limit reached
fs/nfsd/nfsxdr.c:139: warning: inlining failed in call to 'encode_fattr': --param max-inline-insns-single limit reached
fs/nfsd/nfsxdr.c:139: warning: inlining failed in call to 'encode_fattr': --param max-inline-insns-single limit reached
fs/nfsd/nfsxdr.c:139: warning: inlining failed in call to 'encode_fattr': --param max-inline-insns-single limit reached
include/linux/slab.h:78: warning: inlining failed in call to 'kmalloc': --param inline-unit-growth limit reached
include/linux/slab.h:78: warning: inlining failed in call to 'kmalloc': --param inline-unit-growth limit reached
include/linux/slab.h:78: warning: inlining failed in call to 'kmalloc': --param inline-unit-growth limit reached
include/linux/slab.h:78: warning: inlining failed in call to 'kmalloc': --param inline-unit-growth limit reached
include/linux/slab.h:78: warning: inlining failed in call to 'kmalloc': --param inline-unit-growth limit reached
include/linux/slab.h:78: warning: inlining failed in call to 'kmalloc': --param inline-unit-growth limit reached
include/linux/slab.h:78: warning: inlining failed in call to 'kmalloc': --param inline-unit-growth limit reached
include/linux/slab.h:78: warning: inlining failed in call to 'kmalloc': --param inline-unit-growth limit reached
include/linux/slab.h:78: warning: inlining failed in call to 'kmalloc': --param inline-unit-growth limit reached
include/linux/slab.h:78: warning: inlining failed in call to 'kmalloc': --param inline-unit-growth limit reached
include/linux/slab.h:78: warning: inlining failed in call to 'kmalloc': --param inline-unit-growth limit reached
include/linux/slab.h:78: warning: inlining failed in call to 'kmalloc': --param inline-unit-growth limit reached
include/asm/string.h:216: warning: inlining failed in call to '__constant_memcpy': --param inline-unit-growth limit reached
include/asm/string.h:216: warning: inlining failed in call to '__constant_memcpy': --param inline-unit-growth limit reached
include/asm/string.h:216: warning: inlining failed in call to '__constant_memcpy': --param inline-unit-growth limit reached
include/asm/string.h:216: warning: inlining failed in call to '__constant_memcpy': --param inline-unit-growth limit reached
include/linux/slab.h:78: warning: inlining failed in call to 'kmalloc': --param inline-unit-growth limit reached
include/linux/slab.h:78: warning: inlining failed in call to 'kmalloc': --param inline-unit-growth limit reached
include/linux/slab.h:78: warning: inlining failed in call to 'kmalloc': --param inline-unit-growth limit reached
include/linux/slab.h:78: warning: inlining failed in call to 'kmalloc': --param inline-unit-growth limit reached
include/asm/uaccess.h:497: warning: inlining failed in call to 'copy_from_user': --param inline-unit-growth limit reached
include/asm/uaccess.h:497: warning: inlining failed in call to 'copy_from_user': --param inline-unit-growth limit reached
include/asm/uaccess.h:497: warning: inlining failed in call to 'copy_from_user': --param inline-unit-growth limit reached
include/linux/slab.h:78: warning: inlining failed in call to 'kmalloc': --param inline-unit-growth limit reached
include/asm/uaccess.h:497: warning: inlining failed in call to 'copy_from_user': --param inline-unit-growth limit reached
include/asm/uaccess.h:497: warning: inlining failed in call to 'copy_from_user': --param inline-unit-growth limit reached
include/asm/uaccess.h:497: warning: inlining failed in call to 'copy_from_user': --param inline-unit-growth limit reached
include/linux/slab.h:78: warning: inlining failed in call to 'kmalloc': --param inline-unit-growth limit reached
include/asm/uaccess.h:497: warning: inlining failed in call to 'copy_from_user': --param inline-unit-growth limit reached
include/asm/uaccess.h:497: warning: inlining failed in call to 'copy_from_user': --param inline-unit-growth limit reached
include/linux/slab.h:78: warning: inlining failed in call to 'kmalloc': --param inline-unit-growth limit reached
include/asm/uaccess.h:497: warning: inlining failed in call to 'copy_from_user': --param inline-unit-growth limit reached
include/asm/uaccess.h:497: warning: inlining failed in call to 'copy_from_user': --param inline-unit-growth limit reached
include/asm/uaccess.h:497: warning: inlining failed in call to 'copy_from_user': --param inline-unit-growth limit reached
include/asm/uaccess.h:497: warning: inlining failed in call to 'copy_from_user': --param inline-unit-growth limit reached
include/asm/uaccess.h:497: warning: inlining failed in call to 'copy_from_user': --param inline-unit-growth limit reached
include/asm/uaccess.h:497: warning: inlining failed in call to 'copy_from_user': --param inline-unit-growth limit reached
include/asm/uaccess.h:497: warning: inlining failed in call to 'copy_from_user': --param inline-unit-growth limit reached
include/asm/uaccess.h:497: warning: inlining failed in call to 'copy_from_user': --param inline-unit-growth limit reached
include/asm/uaccess.h:497: warning: inlining failed in call to 'copy_from_user': --param inline-unit-growth limit reached
include/linux/slab.h:78: warning: inlining failed in call to 'kmalloc': --param inline-unit-growth limit reached
include/asm/uaccess.h:497: warning: inlining failed in call to 'copy_from_user': --param inline-unit-growth limit reached
include/linux/slab.h:78: warning: inlining failed in call to 'kmalloc': --param inline-unit-growth limit reached
include/asm/uaccess.h:497: warning: inlining failed in call to 'copy_from_user': --param inline-unit-growth limit reached
include/asm/uaccess.h:497: warning: inlining failed in call to 'copy_from_user': --param inline-unit-growth limit reached
include/linux/slab.h:78: warning: inlining failed in call to 'kmalloc': --param inline-unit-growth limit reached

--x+6KMIRAuhnl3hBn--
