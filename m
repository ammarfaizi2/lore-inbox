Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965228AbWIRBkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965228AbWIRBkA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 21:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965221AbWIRBi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 21:38:56 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:65018 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965222AbWIRBi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 21:38:29 -0400
Message-Id: <20060918013216.744931000@klappe.arndb.de>
References: <20060918012740.407846000@klappe.arndb.de>
In-Reply-To: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
Date: Mon, 18 Sep 2006 03:27:43 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 3/8] hide kernel-only parts of some installed headers
Content-Disposition: inline; filename=checkheader-__KERNEL__.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These header files all need additional parts hidden
inside if #ifdef __KERNEL__ so they become usable in
user space.

The most common reason is that they refer to a CONFIG_*
symbol. Since the contents of the header inside of
that #ifdef were undefined to start with, these parts
can usually be left out of the installed portion.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Index: linux-cg/include/asm-i386/setup.h
===================================================================
--- linux-cg.orig/include/asm-i386/setup.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/asm-i386/setup.h	2006-09-18 03:21:53.000000000 +0200
@@ -67,6 +67,7 @@
  */
 #define LOWMEMSIZE()	(0x9f000)
 
+#ifdef __KERNEL__
 struct e820entry;
 
 char * __init machine_specific_memory_setup(void);
@@ -75,6 +76,7 @@
 int __init sanitize_e820_map(struct e820entry * biosmap, char * pnr_map);
 void __init add_memory_region(unsigned long long start,
 			      unsigned long long size, int type);
+#endif
 
 #endif /* __ASSEMBLY__ */
 
Index: linux-cg/include/linux/coda_psdev.h
===================================================================
--- linux-cg.orig/include/linux/coda_psdev.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/coda_psdev.h	2006-09-18 03:21:53.000000000 +0200
@@ -6,6 +6,7 @@
 
 #define CODA_SUPER_MAGIC	0x73757245
 
+#ifdef __KERNEL__
 struct kstatfs;
 
 struct coda_sb_info
@@ -72,7 +73,6 @@
 int venus_fsync(struct super_block *sb, struct CodaFid *fid);
 int venus_statfs(struct dentry *dentry, struct kstatfs *sfs);
 
-
 /* messages between coda filesystem in kernel and Venus */
 extern int coda_hard;
 extern unsigned long coda_timeout;
@@ -88,16 +88,16 @@
 	unsigned long       uc_posttime;
 };
 
-#define REQ_ASYNC  0x1
-#define REQ_READ   0x2
-#define REQ_WRITE  0x4
-#define REQ_ABORT  0x8
-
-
 /*
  * Statistics
  */
 
 extern struct venus_comm coda_comms[];
+#endif
+
+#define REQ_ASYNC  0x1
+#define REQ_READ   0x2
+#define REQ_WRITE  0x4
+#define REQ_ABORT  0x8
 
 #endif
Index: linux-cg/include/linux/dm-ioctl.h
===================================================================
--- linux-cg.orig/include/linux/dm-ioctl.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/dm-ioctl.h	2006-09-18 03:21:53.000000000 +0200
@@ -231,6 +231,7 @@
 	DM_DEV_SET_GEOMETRY_CMD
 };
 
+#ifdef __KERNEL__
 /*
  * The dm_ioctl struct passed into the ioctl is just the header
  * on a larger chunk of memory.  On x86-64 and other
@@ -260,6 +261,7 @@
 #define DM_TARGET_MSG_32    _IOWR(DM_IOCTL, DM_TARGET_MSG_CMD, ioctl_struct)
 #define DM_DEV_SET_GEOMETRY_32	_IOWR(DM_IOCTL, DM_DEV_SET_GEOMETRY_CMD, ioctl_struct)
 #endif
+#endif
 
 #define DM_IOCTL 0xfd
 
Index: linux-cg/include/linux/futex.h
===================================================================
--- linux-cg.orig/include/linux/futex.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/futex.h	2006-09-18 03:21:53.000000000 +0200
@@ -93,6 +93,7 @@
  */
 #define ROBUST_LIST_LIMIT	2048
 
+#ifdef __KERNEL__
 long do_futex(u32 __user *uaddr, int op, u32 val, unsigned long timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
 
@@ -110,6 +111,7 @@
 {
 }
 #endif
+#endif
 
 #define FUTEX_OP_SET		0	/* *(int *)UADDR2 = OPARG; */
 #define FUTEX_OP_ADD		1	/* *(int *)UADDR2 += OPARG; */
Index: linux-cg/include/linux/ipv6.h
===================================================================
--- linux-cg.orig/include/linux/ipv6.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/ipv6.h	2006-09-18 03:21:53.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IPV6_H
 #define _IPV6_H
 
+/* @headercheck: -include linux/types.h @ */
+
 #include <linux/in6.h>
 #include <asm/byteorder.h>
 
@@ -121,6 +123,7 @@
 	struct	in6_addr	daddr;
 };
 
+#ifdef __KERNEL__
 /*
  * This structure contains configuration options per IPv6 link.
  */
@@ -155,6 +158,7 @@
 #endif
 	void		*sysctl;
 };
+#endif
 
 /* index values for the variables in ipv6_devconf */
 enum {
Index: linux-cg/include/linux/isdn_divertif.h
===================================================================
--- linux-cg.orig/include/linux/isdn_divertif.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/isdn_divertif.h	2006-09-18 03:21:53.000000000 +0200
@@ -24,6 +24,7 @@
 #define DIVERT_REL_ERR  0x04  /* module not registered */
 #define DIVERT_REG_NAME isdn_register_divert
 
+#ifdef __KERNEL__
 /***************************************************************/
 /* structure exchanging data between isdn hl and divert module */
 /***************************************************************/ 
@@ -40,3 +41,4 @@
 /* function register */
 /*********************/
 extern int DIVERT_REG_NAME(isdn_divert_if *);
+#endif
Index: linux-cg/include/linux/ppp-comp.h
===================================================================
--- linux-cg.orig/include/linux/ppp-comp.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/ppp-comp.h	2006-09-18 03:21:53.000000000 +0200
@@ -42,6 +42,7 @@
 #ifndef _NET_PPP_COMP_H
 #define _NET_PPP_COMP_H
 
+#ifdef __KERNEL__
 struct module;
 
 /*
@@ -115,6 +116,9 @@
 	unsigned int comp_extra;
 };
 
+extern int ppp_register_compressor(struct compressor *);
+extern void ppp_unregister_compressor(struct compressor *);
+
 /*
  * The return value from decompress routine is the length of the
  * decompressed packet if successful, otherwise DECOMP_ERROR
@@ -130,6 +134,8 @@
 #define DECOMP_ERROR		-1	/* error detected before decomp. */
 #define DECOMP_FATALERROR	-2	/* error detected after decomp. */
 
+#endif /* __KERNEL__ */
+
 /*
  * CCP codes.
  */
@@ -208,9 +214,4 @@
 #define CI_PREDICTOR_2		2	/* config option for Predictor-2 */
 #define CILEN_PREDICTOR_2	2	/* length of its config option */
 
-#ifdef __KERNEL__
-extern int ppp_register_compressor(struct compressor *);
-extern void ppp_unregister_compressor(struct compressor *);
-#endif /* __KERNEL__ */
-
 #endif /* _NET_PPP_COMP_H */
Index: linux-cg/include/linux/sound.h
===================================================================
--- linux-cg.orig/include/linux/sound.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/sound.h	2006-09-18 03:21:53.000000000 +0200
@@ -25,6 +25,7 @@
 #define SND_DEV_AMIDI		13	/* Like /dev/midi (obsolete) */
 #define SND_DEV_ADMMIDI		14	/* Like /dev/dmmidi (onsolete) */
 
+#ifdef __KERNEL__
 /*
  *	Sound core interface functions
  */
@@ -42,3 +43,4 @@
 extern void unregister_sound_midi(int unit);
 extern void unregister_sound_dsp(int unit);
 extern void unregister_sound_synth(int unit);
+#endif
Index: linux-cg/include/linux/xattr.h
===================================================================
--- linux-cg.orig/include/linux/xattr.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/xattr.h	2006-09-18 03:21:53.000000000 +0200
@@ -29,7 +29,7 @@
 #define XATTR_USER_PREFIX "user."
 #define XATTR_USER_PREFIX_LEN (sizeof (XATTR_USER_PREFIX) - 1)
 
-
+#ifdef __KERNEL__
 struct xattr_handler {
 	char *prefix;
 	size_t (*list)(struct inode *inode, char *list, size_t list_size,
@@ -48,5 +48,6 @@
 ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size);
 int generic_setxattr(struct dentry *dentry, const char *name, const void *value, size_t size, int flags);
 int generic_removexattr(struct dentry *dentry, const char *name);
+#endif
 
 #endif	/* _LINUX_XATTR_H */
Index: linux-cg/include/linux/netdevice.h
===================================================================
--- linux-cg.orig/include/linux/netdevice.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/netdevice.h	2006-09-18 03:21:53.000000000 +0200
@@ -69,10 +69,6 @@
 
 #define net_xmit_errno(e)	((e) != NET_XMIT_CN ? -ENOBUFS : 0)
 
-#endif
-
-#define MAX_ADDR_LEN	32		/* Largest hardware address length */
-
 /* Driver transmit return codes */
 #define NETDEV_TX_OK 0		/* driver took care of packet */
 #define NETDEV_TX_BUSY 1	/* driver tx path was busy*/
@@ -100,6 +96,10 @@
 #define MAX_HEADER (LL_MAX_HEADER + 48)
 #endif
 
+#endif
+
+#define MAX_ADDR_LEN	32		/* Largest hardware address length */
+
 /*
  *	Network device statistics. Akin to the 2.0 ether stats but
  *	with byte counters.
Index: linux-cg/include/linux/quota.h
===================================================================
--- linux-cg.orig/include/linux/quota.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/quota.h	2006-09-18 03:21:53.000000000 +0200
@@ -41,11 +41,6 @@
 #define __DQUOT_VERSION__	"dquot_6.5.1"
 #define __DQUOT_NUM_VERSION__	6*10000+5*100+1
 
-typedef __kernel_uid32_t qid_t; /* Type in which we store ids in memory */
-typedef __u64 qsize_t;          /* Type in which we store sizes */
-
-extern spinlock_t dq_data_lock;
-
 /* Size of blocks in which are counted size limits */
 #define QUOTABLOCK_BITS 10
 #define QUOTABLOCK_SIZE (1 << QUOTABLOCK_BITS)
@@ -138,6 +133,11 @@
 #include <linux/dqblk_v1.h>
 #include <linux/dqblk_v2.h>
 
+typedef __kernel_uid32_t qid_t; /* Type in which we store ids in memory */
+typedef __u64 qsize_t;          /* Type in which we store sizes */
+
+extern spinlock_t dq_data_lock;
+
 /* Maximal numbers of writes for quota operation (insert/delete/update)
  * (over VFS all formats) */
 #define DQUOT_INIT_ALLOC max(V1_INIT_ALLOC, V2_INIT_ALLOC)
Index: linux-cg/include/asm-generic/atomic.h
===================================================================
--- linux-cg.orig/include/asm-generic/atomic.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/asm-generic/atomic.h	2006-09-18 03:21:53.000000000 +0200
@@ -18,7 +18,7 @@
  * macros of a platform may have.
  */
 
-#if BITS_PER_LONG == 64
+#ifdef ATOMIC64_INIT /* assume this is only defined on 64 bit architectures */
 
 typedef atomic64_t atomic_long_t;
 
Index: linux-cg/include/asm-i386/byteorder.h
===================================================================
--- linux-cg.orig/include/asm-i386/byteorder.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/asm-i386/byteorder.h	2006-09-18 03:21:53.000000000 +0200
@@ -8,11 +8,14 @@
 
 /* For avoiding bswap on i386 */
 #ifdef __KERNEL__
+#ifdef CONFIG_X86_BSWAP
+#define __X86_BSWAP
+#endif
 #endif
 
 static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 x)
 {
-#ifdef CONFIG_X86_BSWAP
+#ifdef __X86_BSWAP
 	__asm__("bswap %0" : "=r" (x) : "0" (x));
 #else
 	__asm__("xchgb %b0,%h0\n\t"	/* swap lower bytes	*/
@@ -31,7 +34,7 @@
 		__u64 u;
 	} v;
 	v.u = val;
-#ifdef CONFIG_X86_BSWAP
+#ifdef __X86_BSWAP
 	asm("bswapl %0 ; bswapl %1 ; xchgl %0,%1" 
 	    : "=r" (v.s.a), "=r" (v.s.b) 
 	    : "0" (v.s.a), "1" (v.s.b)); 
Index: linux-cg/include/asm-i386/vm86.h
===================================================================
--- linux-cg.orig/include/asm-i386/vm86.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/asm-i386/vm86.h	2006-09-18 03:21:53.000000000 +0200
@@ -16,11 +16,15 @@
 #define IF_MASK		0x00000200
 #define IOPL_MASK	0x00003000
 #define NT_MASK		0x00004000
+#ifdef __KERNEL__
 #ifdef CONFIG_VM86
 #define VM_MASK		0x00020000
 #else
 #define VM_MASK		0 /* ignored */
-#endif
+#endif /* CONFIG_VM86 */
+#else
+#define VM_MASK		0x00020000
+#endif /* __KERNEL__ */
 #define AC_MASK		0x00040000
 #define VIF_MASK	0x00080000	/* virtual interrupt flag */
 #define VIP_MASK	0x00100000	/* virtual interrupt pending */
Index: linux-cg/include/linux/Kbuild
===================================================================
--- linux-cg.orig/include/linux/Kbuild	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/Kbuild	2006-09-18 03:21:53.000000000 +0200
@@ -8,10 +8,10 @@
 	atmppp.h atmsap.h atmsvc.h atm_zatm.h auto_fs4.h auxvec.h	\
 	awe_voice.h ax25.h b1lli.h baycom.h bfs_fs.h blkpg.h		\
 	bpqether.h cdk.h chio.h coda_psdev.h coff.h comstats.h		\
-	consolemap.h cycx_cfm.h dm-ioctl.h dn.h dqblk_v1.h		\
-	dqblk_v2.h dqblk_xfs.h efs_fs_sb.h elf-fdpic.h elf.h elf-em.h	\
+	consolemap.h cycx_cfm.h dn.h dqblk_v1.h				\
+	dqblk_v2.h dqblk_xfs.h efs_fs_sb.h elf.h elf-em.h		\
 	fadvise.h fd.h fdreg.h ftape-header-segment.h ftape-vendors.h	\
-	fuse.h futex.h genetlink.h gen_stats.h gigaset_dev.h hdsmart.h	\
+	fuse.h genetlink.h gen_stats.h gigaset_dev.h hdsmart.h		\
 	hpfs_fs.h hysdn_if.h i2c-dev.h i8k.h icmp.h			\
 	if_arcnet.h if_arp.h if_bonding.h if_cablemodem.h if_fc.h	\
 	if_fddi.h if.h if_hippi.h if_infiniband.h if_packet.h		\
@@ -34,15 +34,15 @@
 	atmarp.h atmdev.h atm.h atm_tcp.h audit.h auto_fs.h binfmts.h	\
 	capability.h capi.h cciss_ioctl.h cdrom.h cm4000_cs.h		\
 	cn_proc.h coda.h connector.h cramfs_fs.h cuda.h cyclades.h	\
-	dccp.h dirent.h divert.h elfcore.h errno.h errqueue.h		\
-	ethtool.h eventpoll.h ext2_fs.h ext3_fs.h fb.h fcntl.h		\
-	filter.h flat.h fs.h ftape.h gameport.h generic_serial.h	\
-	genhd.h hayesesp.h hdlcdrv.h hdlc.h hdreg.h hiddev.h hpet.h	\
-	i2c.h i2o-dev.h icmpv6.h if_bridge.h if_ec.h			\
+	dccp.h dirent.h divert.h dm-ioctl.h elf-fdpic.h elfcore.h	\
+	errno.h	errqueue.h ethtool.h eventpoll.h ext2_fs.h ext3_fs.h	\
+	fb.h fcntl.h filter.h flat.h fs.h ftape.h futex.h gameport.h	\
+	generic_serial.h genhd.h hayesesp.h hdlcdrv.h hdlc.h hdreg.h	\
+	hiddev.h hpet.h	i2c.h i2o-dev.h icmpv6.h if_bridge.h if_ec.h	\
 	if_eql.h if_ether.h if_frad.h if_ltalk.h if_pppox.h		\
 	if_shaper.h if_tr.h if_tun.h if_vlan.h if_wanpipe.h igmp.h	\
 	inet_diag.h in.h inotify.h input.h ipc.h ipmi.h ipv6.h		\
-	ipv6_route.h isdn.h isdnif.h isdn_ppp.h isicom.h jbd.h		\
+	ipv6_route.h isdn.h isdnif.h isdn_ppp.h isicom.h		\
 	joystick.h kdev_t.h kd.h kernelcapi.h kernel.h keyboard.h	\
 	llc.h loop.h lp.h mempolicy.h mii.h mman.h mroute.h msdos_fs.h	\
 	msg.h nbd.h ncp_fs.h ncp.h ncp_mount.h netdevice.h		\
Index: linux-cg/include/linux/acct.h
===================================================================
--- linux-cg.orig/include/linux/acct.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/acct.h	2006-09-18 03:21:53.000000000 +0200
@@ -59,7 +59,7 @@
 	comp_t		ac_majflt;		/* Major Pagefaults */
 	comp_t		ac_swaps;		/* Number of Swaps */
 /* m68k had no padding here. */
-#if !defined(CONFIG_M68K) || !defined(__KERNEL__)
+#if !defined(__mc68000__) || !defined(__KERNEL__)
 	__u16		ac_ahz;			/* AHZ */
 #endif
 	__u32		ac_exitcode;		/* Exitcode */
Index: linux-cg/include/linux/coda.h
===================================================================
--- linux-cg.orig/include/linux/coda.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/coda.h	2006-09-18 03:21:53.000000000 +0200
@@ -59,6 +59,20 @@
 #ifndef _CODA_HEADER_
 #define _CODA_HEADER_
 
+#if 0
+#define CODA_KERNEL_VERSION 0 /* don't care about kernel version number */
+#define CODA_KERNEL_VERSION 1 /* The old venus 4.6 compatible interface */
+#define CODA_KERNEL_VERSION 2 /* venus_lookup got an extra parameter */
+#endif
+#ifdef __KERNEL__
+#ifdef CONFIG_CODA_FS_OLD_API
+#define CODA_KERNEL_VERSION 2 /* venus_lookup got an extra parameter */
+#endif
+#endif
+
+#ifndef CODA_KERNEL_VERSION
+#define CODA_KERNEL_VERSION 3 /* 128-bit file identifiers */
+#endif
 
 /* Catch new _KERNEL defn for NetBSD and DJGPP/__CYGWIN32__ */
 #if defined(__NetBSD__) || \
@@ -199,7 +213,7 @@
 typedef u_int32_t vgid_t;
 #endif /*_VUID_T_ */
 
-#ifdef CONFIG_CODA_FS_OLD_API
+#if CODA_KERNEL_VERSION == 2
 struct CodaFid {
 	u_int32_t opaque[3];
 };
@@ -219,7 +233,7 @@
     vgid_t cr_groupid, cr_egid, cr_sgid, cr_fsgid; /* same for groups */
 };
 
-#else /* not defined(CONFIG_CODA_FS_OLD_API) */
+#else /* not CODA_KERNEL_VERSION == 2 */
 
 struct CodaFid {
 	u_int32_t opaque[4];
@@ -313,23 +327,13 @@
 
 #define CIOC_KERNEL_VERSION _IOWR('c', 10, size_t)
 
-#if 0
-#define CODA_KERNEL_VERSION 0 /* don't care about kernel version number */
-#define CODA_KERNEL_VERSION 1 /* The old venus 4.6 compatible interface */
-#endif
-#ifdef CONFIG_CODA_FS_OLD_API
-#define CODA_KERNEL_VERSION 2 /* venus_lookup got an extra parameter */
-#else
-#define CODA_KERNEL_VERSION 3 /* 128-bit file identifiers */
-#endif
-
 /*
  *        Venus <-> Coda  RPC arguments
  */
 struct coda_in_hdr {
     u_int32_t opcode;
     u_int32_t unique;	    /* Keep multiple outstanding msgs distinct */
-#ifdef CONFIG_CODA_FS_OLD_API
+#if CODA_KERNEL_VERSION == 2
     u_int16_t pid;	    /* Common to all */
     u_int16_t pgid;	    /* Common to all */
     u_int16_t sid;          /* Common to all */
@@ -613,7 +617,7 @@
 /* CODA_PURGEUSER is a venus->kernel call */
 struct coda_purgeuser_out {
     struct coda_out_hdr oh;
-#ifdef CONFIG_CODA_FS_OLD_API
+#if CODA_KERNEL_VERSION == 2
     struct coda_cred cred;
 #else
     vuid_t uid;
Index: linux-cg/include/linux/elf-fdpic.h
===================================================================
--- linux-cg.orig/include/linux/elf-fdpic.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/elf-fdpic.h	2006-09-18 03:21:53.000000000 +0200
@@ -58,11 +58,13 @@
 #define ELF_FDPIC_FLAG_PRESENT		0x80000000	/* T if this object is present */
 };
 
+#ifdef __KERNEL__
 #ifdef CONFIG_MMU
 extern void elf_fdpic_arch_lay_out_mm(struct elf_fdpic_params *exec_params,
 				      struct elf_fdpic_params *interp_params,
 				      unsigned long *start_stack,
 				      unsigned long *start_brk);
 #endif
+#endif
 
 #endif /* _LINUX_ELF_FDPIC_H */
Index: linux-cg/include/linux/elfcore.h
===================================================================
--- linux-cg.orig/include/linux/elfcore.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/elfcore.h	2006-09-18 03:21:53.000000000 +0200
@@ -17,10 +17,14 @@
 #include <asm/elf.h>
 
 #ifndef __KERNEL__
+#if !defined(__s390__)
 typedef elf_greg_t greg_t;
+#endif
 typedef elf_gregset_t gregset_t;
 typedef elf_fpregset_t fpregset_t;
+#if defined(__i386__) || defined(__ia64__)
 typedef elf_fpxregset_t fpxregset_t;
+#endif
 #define NGREG ELF_NGREG
 #endif
 
@@ -60,6 +64,7 @@
 	long	pr_instr;		/* Current instruction */
 #endif
 	elf_gregset_t pr_reg;	/* GP registers */
+#ifdef __KERNEL__
 #ifdef CONFIG_BINFMT_ELF_FDPIC
 	/* When using FDPIC, the loadmap addresses need to be communicated
 	 * to GDB in order for GDB to do the necessary relocations.  The
@@ -70,6 +75,7 @@
 	unsigned long pr_exec_fdpic_loadmap;
 	unsigned long pr_interp_fdpic_loadmap;
 #endif
+#endif
 	int pr_fpvalid;		/* True if math co-processor being used.  */
 };
 
Index: linux-cg/include/linux/ext3_fs.h
===================================================================
--- linux-cg.orig/include/linux/ext3_fs.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/ext3_fs.h	2006-09-18 03:21:53.000000000 +0200
@@ -228,12 +228,11 @@
 #define EXT3_IOC_GROUP_ADD		_IOW('f', 8,struct ext3_new_group_input)
 #define	EXT3_IOC_GETVERSION_OLD		_IOR('v', 1, long)
 #define	EXT3_IOC_SETVERSION_OLD		_IOW('v', 2, long)
-#ifdef CONFIG_JBD_DEBUG
 #define EXT3_IOC_WAIT_FOR_READONLY	_IOR('f', 99, long)
-#endif
 #define EXT3_IOC_GETRSVSZ		_IOR('f', 5, long)
 #define EXT3_IOC_SETRSVSZ		_IOW('f', 6, long)
 
+#ifdef __KERNEL__
 /*
  *  Mount options
  */
@@ -247,6 +246,7 @@
 	char *s_qf_names[MAXQUOTAS];
 #endif
 };
+#endif
 
 /*
  * Structure of an inode on the disk
@@ -652,6 +652,7 @@
  * (c) Daniel Phillips, 2001
  */
 
+#ifdef __KERNEL__
 #ifdef CONFIG_EXT3_INDEX
   #define is_dx(dir) (EXT3_HAS_COMPAT_FEATURE(dir->i_sb, \
 					      EXT3_FEATURE_COMPAT_DIR_INDEX) && \
@@ -670,8 +671,6 @@
 #define DX_HASH_HALF_MD4	1
 #define DX_HASH_TEA		2
 
-#ifdef __KERNEL__
-
 /* hash info structure used by the directory hash */
 struct dx_hash_info
 {
Index: linux-cg/include/linux/fb.h
===================================================================
--- linux-cg.orig/include/linux/fb.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/fb.h	2006-09-18 03:21:53.000000000 +0200
@@ -366,14 +366,14 @@
 	struct fb_image	image;	/* Cursor image */
 };
 
+#ifdef __KERNEL__
+
 #ifdef CONFIG_FB_BACKLIGHT
 /* Settings for the generic backlight code */
 #define FB_BACKLIGHT_LEVELS	128
 #define FB_BACKLIGHT_MAX	0xFF
 #endif
 
-#ifdef __KERNEL__
-
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/device.h>
Index: linux-cg/include/linux/flat.h
===================================================================
--- linux-cg.orig/include/linux/flat.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/flat.h	2006-09-18 03:21:53.000000000 +0200
@@ -12,9 +12,6 @@
 
 #ifdef __KERNEL__
 #include <asm/flat.h>
-#endif
-
-#define	FLAT_VERSION			0x00000004L
 
 #ifdef CONFIG_BINFMT_SHARED_FLAT
 #define	MAX_SHARED_LIBS			(4)
@@ -22,6 +19,10 @@
 #define	MAX_SHARED_LIBS			(1)
 #endif
 
+#endif /* __KERNEL__ */
+
+#define	FLAT_VERSION			0x00000004L
+
 /*
  * To make everything easier to port and manage cross platform
  * development,  all fields are in network byte order.
Index: linux-cg/include/linux/fs.h
===================================================================
--- linux-cg.orig/include/linux/fs.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/fs.h	2006-09-18 03:21:53.000000000 +0200
@@ -31,6 +31,7 @@
 #define SEEK_CUR	1	/* seek relative to current file position */
 #define SEEK_END	2	/* seek relative to end of file */
 
+#ifdef __KERNEL__
 /* And dynamically-tunable limits and defaults: */
 struct files_stat_struct {
 	int nr_files;		/* read only */
@@ -52,6 +53,7 @@
 #ifdef CONFIG_DNOTIFY
 extern int dir_notify_enable;
 #endif
+#endif
 
 #define NR_FILE  8192	/* this can well be larger on a larger system */
 
Index: linux-cg/include/linux/genhd.h
===================================================================
--- linux-cg.orig/include/linux/genhd.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/genhd.h	2006-09-18 03:21:53.000000000 +0200
@@ -52,9 +52,8 @@
 	unsigned int nr_sects;		/* nr of sectors in partition */
 } __attribute__((packed));
 
-#endif
+#else /* __KERNEL__ */
 
-#ifdef __KERNEL__
 #include <linux/major.h>
 #include <linux/device.h>
 #include <linux/smp.h>
@@ -247,8 +246,6 @@
 	disk->capacity = size;
 }
 
-#endif  /*  __KERNEL__  */
-
 #ifdef CONFIG_SOLARIS_X86_PARTITION
 
 #define SOLARIS_X86_NUMSLICE	8
@@ -392,8 +389,6 @@
 #   define MINIX_NR_SUBPARTITIONS  4
 #endif /* CONFIG_MINIX_SUBPARTITION */
 
-#ifdef __KERNEL__
-
 char *disk_name (struct gendisk *hd, int part, char *buf);
 
 extern int rescan_partitions(struct gendisk *disk, struct block_device *bdev);
@@ -417,6 +412,6 @@
 	return bdget(MKDEV(disk->major, disk->first_minor) + index);
 }
 
-#endif
+#endif /* __KERNEL__ */
 
 #endif
Index: linux-cg/include/linux/if_frad.h
===================================================================
--- linux-cg.orig/include/linux/if_frad.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/if_frad.h	2006-09-18 03:21:53.000000000 +0200
@@ -26,8 +26,6 @@
 
 #include <linux/if.h>
 
-#if defined(CONFIG_DLCI) || defined(CONFIG_DLCI_MODULE)
-
 /* Structures and constants associated with the DLCI device driver */
 
 struct dlci_add
@@ -190,11 +188,6 @@
    int               buffer;		/* current buffer for S508 firmware */
 };
 
-#endif /* __KERNEL__ */
-
-#endif /* CONFIG_DLCI || CONFIG_DLCI_MODULE */
-
-#ifdef __KERNEL__
 extern void dlci_ioctl_set(int (*hook)(unsigned int, void __user *));
 #endif
 
Index: linux-cg/include/linux/isdn.h
===================================================================
--- linux-cg.orig/include/linux/isdn.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/isdn.h	2006-09-18 03:21:53.000000000 +0200
@@ -16,6 +16,7 @@
 
 #include <linux/ioctl.h>
 
+#ifdef __KERNEL__
 #ifdef CONFIG_COBALT_MICRO_SERVER
 /* Save memory */
 #define ISDN_MAX_DRIVERS    2
@@ -24,6 +25,7 @@
 #define ISDN_MAX_DRIVERS    32
 #define ISDN_MAX_CHANNELS   64
 #endif
+#endif
 
 /* New ioctl-codes */
 #define IIOCNETAIF  _IO('I',1)
Index: linux-cg/include/linux/nfsd/stats.h
===================================================================
--- linux-cg.orig/include/linux/nfsd/stats.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/nfsd/stats.h	2006-09-18 03:21:53.000000000 +0200
@@ -29,10 +29,11 @@
 	unsigned int	ra_size;	/* size of ra cache */
 	unsigned int	ra_depth[11];	/* number of times ra entry was found that deep
 					 * in the cache (10percentiles). [10] = not found */
+#ifdef __KERNEL__
 #ifdef CONFIG_NFSD_V4
 	unsigned int	nfs4_opcount[LAST_NFS4_OP + 1];	/* count of individual nfsv4 operations */
 #endif
-
+#endif
 };
 
 /* thread usage wraps very million seconds (approx one fortnight) */
Index: linux-cg/include/linux/nfsd/syscall.h
===================================================================
--- linux-cg.orig/include/linux/nfsd/syscall.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/nfsd/syscall.h	2006-09-18 03:21:53.000000000 +0200
@@ -45,6 +45,7 @@
 #define NFSCTL_VERUNSET(_cltbits, _v) ((_cltbits) &= ~(1 << (_v)))
 #define NFSCTL_VERISSET(_cltbits, _v) ((_cltbits) & (1 << (_v)))
 
+#ifdef __KERNEL__
 #if defined(CONFIG_NFSD_V4)
 #define	NFSCTL_VERALL	(0x1c /* 0b011100 */)
 #elif defined(CONFIG_NFSD_V3)
@@ -52,6 +53,7 @@
 #else
 #define	NFSCTL_VERALL	(0x04 /* 0b000100 */)
 #endif
+#endif
 
 /* SVC */
 struct nfsctl_svc {
Index: linux-cg/include/linux/pktcdvd.h
===================================================================
--- linux-cg.orig/include/linux/pktcdvd.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/pktcdvd.h	2006-09-18 03:21:53.000000000 +0200
@@ -29,17 +29,6 @@
 #define PACKET_WAIT_TIME	(HZ * 5 / 1000)
 
 /*
- * use drive write caching -- we need deferred error handling to be
- * able to sucessfully recover with this option (drive will return good
- * status as soon as the cdb is validated).
- */
-#if defined(CONFIG_CDROM_PKTCDVD_WCACHE)
-#define USE_WCACHING		1
-#else
-#define USE_WCACHING		0
-#endif
-
-/*
  * No user-servicable parts beyond this point ->
  */
 
@@ -112,6 +101,17 @@
 #include <linux/completion.h>
 #include <linux/cdrom.h>
 
+/*
+ * use drive write caching -- we need deferred error handling to be
+ * able to sucessfully recover with this option (drive will return good
+ * status as soon as the cdb is validated).
+ */
+#if defined(CONFIG_CDROM_PKTCDVD_WCACHE)
+#define USE_WCACHING		1
+#else
+#define USE_WCACHING		0
+#endif
+
 struct packet_settings
 {
 	__u32			size;		/* packet size in (512 byte) sectors */
Index: linux-cg/include/linux/reiserfs_fs.h
===================================================================
--- linux-cg.orig/include/linux/reiserfs_fs.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/reiserfs_fs.h	2006-09-18 03:21:53.000000000 +0200
@@ -11,8 +11,8 @@
 #ifndef _LINUX_REISER_FS_H
 #define _LINUX_REISER_FS_H
 
-#include <linux/types.h>
 #ifdef __KERNEL__
+#include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/sched.h>
@@ -24,7 +24,6 @@
 #include <linux/buffer_head.h>
 #include <linux/reiserfs_fs_i.h>
 #include <linux/reiserfs_fs_sb.h>
-#endif
 
 /*
  *  include/linux/reiser_fs.h
@@ -1532,7 +1531,6 @@
 /*                    FUNCTION DECLARATIONS                                */
 /***************************************************************************/
 
-/*#ifdef __KERNEL__*/
 #define get_journal_desc_magic(bh) (bh->b_data + bh->b_size - 12)
 
 #define journal_trans_half(blocksize) \
@@ -2169,6 +2167,16 @@
 /* prototypes from ioctl.c */
 int reiserfs_ioctl(struct inode *inode, struct file *filp,
 		   unsigned int cmd, unsigned long arg);
+/* Locking primitives */
+/* Right now we are still falling back to (un)lock_kernel, but eventually that
+   would evolve into real per-fs locks */
+#define reiserfs_write_lock( sb ) lock_kernel()
+#define reiserfs_write_unlock( sb ) unlock_kernel()
+
+/* xattr stuff */
+#define REISERFS_XATTR_DIR_SEM(s) (REISERFS_SB(s)->xattr_dir_sem)
+
+#endif
 
 /* ioctl's command */
 #define REISERFS_IOC_UNPACK		_IOW(0xCD,1,long)
@@ -2179,13 +2187,4 @@
 #define REISERFS_IOC_GETVERSION		EXT2_IOC_GETVERSION
 #define REISERFS_IOC_SETVERSION		EXT2_IOC_SETVERSION
 
-/* Locking primitives */
-/* Right now we are still falling back to (un)lock_kernel, but eventually that
-   would evolve into real per-fs locks */
-#define reiserfs_write_lock( sb ) lock_kernel()
-#define reiserfs_write_unlock( sb ) unlock_kernel()
-
-/* xattr stuff */
-#define REISERFS_XATTR_DIR_SEM(s) (REISERFS_SB(s)->xattr_dir_sem)
-
 #endif				/* _LINUX_REISER_FS_H */
Index: linux-cg/include/linux/socket.h
===================================================================
--- linux-cg.orig/include/linux/socket.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/socket.h	2006-09-18 03:21:53.000000000 +0200
@@ -24,11 +24,13 @@
 #include <linux/types.h>		/* pid_t			*/
 #include <linux/compiler.h>		/* __user			*/
 
+#ifdef __KERNEL__
 extern int sysctl_somaxconn;
 #ifdef CONFIG_PROC_FS
 struct seq_file;
 extern void socket_seq_show(struct seq_file *seq);
 #endif
+#endif
 
 typedef unsigned short	sa_family_t;
 
@@ -249,13 +251,6 @@
 
 #define MSG_EOF         MSG_FIN
 
-#if defined(CONFIG_COMPAT)
-#define MSG_CMSG_COMPAT	0x80000000	/* This message needs 32 bit fixups */
-#else
-#define MSG_CMSG_COMPAT	0		/* We never have 32 bit fixups */
-#endif
-
-
 /* Setsockoptions(2) level. Thanks to BSD these must match IPPROTO_xxx */
 #define SOL_IP		0
 /* #define SOL_ICMP	1	No-no-no! Due to Linux :-) we cannot use SOL_ICMP=1 */
@@ -286,6 +281,13 @@
 #define IPX_TYPE	1
 
 #ifdef __KERNEL__
+
+#if defined(CONFIG_COMPAT)
+#define MSG_CMSG_COMPAT	0x80000000	/* This message needs 32 bit fixups */
+#else
+#define MSG_CMSG_COMPAT	0		/* We never have 32 bit fixups */
+#endif
+
 extern int memcpy_fromiovec(unsigned char *kdata, struct iovec *iov, int len);
 extern int memcpy_fromiovecend(unsigned char *kdata, struct iovec *iov, 
 				int offset, int len);
Index: linux-cg/include/linux/videodev.h
===================================================================
--- linux-cg.orig/include/linux/videodev.h	2006-09-18 03:21:47.000000000 +0200
+++ linux-cg/include/linux/videodev.h	2006-09-18 03:21:53.000000000 +0200
@@ -14,7 +14,19 @@
 
 #include <linux/videodev2.h>
 
-#if defined(CONFIG_VIDEO_V4L1_COMPAT) || !defined (__KERNEL__)
+/*
+ * A little hack to shut up 'make headers_check',
+ * don't reference CONFIG_* outside of __KERNEL__.
+ */
+#ifdef __KERNEL__
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
+#define __VIDEO_V4L1_COMPAT
+#endif
+#else
+#define __VIDEO_V4L1_COMPAT
+#endif
+
+#ifdef __VIDEO_V4L1_COMPAT
 
 struct video_capability
 {
@@ -336,7 +348,7 @@
 #define VID_HARDWARE_SN9C102	38
 #define VID_HARDWARE_ARV	39
 
-#endif /* CONFIG_VIDEO_V4L1_COMPAT */
+#endif /* __VIDEO_V4L1_COMPAT */
 
 #endif /* __LINUX_VIDEODEV_H */
 

--

