Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318153AbSGWSC3>; Tue, 23 Jul 2002 14:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318147AbSGWSC3>; Tue, 23 Jul 2002 14:02:29 -0400
Received: from [195.223.140.120] ([195.223.140.120]:14624 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318153AbSGWSC1>; Tue, 23 Jul 2002 14:02:27 -0400
Date: Tue, 23 Jul 2002 19:47:12 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel McNeil <daniel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc2aa1 i_size atomic access
Message-ID: <20020723174712.GB1117@dualathlon.random>
References: <1026949132.20314.0.camel@joe2.pdx.osdl.net> <1026951041.2412.38.camel@IBM-C> <20020718103511.GG994@dualathlon.random> <1027037361.2424.73.camel@IBM-C> <20020719112305.A15517@oldwotan.suse.de> <1027119396.2629.16.camel@IBM-C> <20020723170807.GW1116@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020723170807.GW1116@dualathlon.random>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 07:08:07PM +0200, Andrea Arcangeli wrote:
> So while merging it I rewrote it this way (I also change the type of the

here it is the final full patch:

diff -urNp race/fs/inode.c race-fix/fs/inode.c
--- race/fs/inode.c	Tue Jul 23 18:46:47 2002
+++ race-fix/fs/inode.c	Tue Jul 23 19:13:02 2002
@@ -111,6 +111,7 @@ static void init_once(void * foo, kmem_c
 		sema_init(&inode->i_sem, 1);
 		sema_init(&inode->i_zombie, 1);
 		spin_lock_init(&inode->i_data.i_shared_lock);
+		i_size_ordered_init(inode);
 	}
 }
 
diff -urNp race/include/asm-i386/system.h race-fix/include/asm-i386/system.h
--- race/include/asm-i386/system.h	Tue Jul 23 18:46:44 2002
+++ race-fix/include/asm-i386/system.h	Tue Jul 23 18:47:10 2002
@@ -143,6 +143,8 @@ struct __xchg_dummy { unsigned long a[10
 #define __xg(x) ((struct __xchg_dummy *)(x))
 
 
+#ifdef CONFIG_X86_CMPXCHG
+#define __ARCH_HAS_GET_SET_64BIT 1
 /*
  * The semantics of XCHGCMP8B are a bit strange, this is why
  * there is a loop and the loading of %%eax and %%edx has to
@@ -167,7 +169,7 @@ static inline void __set_64bit (unsigned
 		"lock cmpxchg8b (%0)\n\t"
 		"jnz 1b"
 		: /* no outputs */
-		:	"D"(ptr),
+		:	"r"(ptr),
 			"b"(low),
 			"c"(high)
 		:	"ax","dx","memory");
@@ -197,6 +199,32 @@ static inline void __set_64bit_var (unsi
  __set_64bit(ptr, (unsigned int)(value), (unsigned int)((value)>>32ULL) ) : \
  __set_64bit(ptr, ll_low(value), ll_high(value)) )
 
+
+/*
+ * The memory clobber is needed in the read side only if
+ * there is an unsafe writer before the get_64bit, which should
+ * never be the case, but just to be safe.
+ */
+static inline unsigned long long get_64bit(unsigned long long * ptr)
+{
+        unsigned long low, high;
+
+        __asm__ __volatile__ (
+                "\n1:\t"
+                "movl (%2), %%eax\n\t"
+                "movl 4(%2), %%edx\n\t"
+                "movl %%eax, %%ebx\n\t"
+                "movl %%edx, %%ecx\n\t"
+                "lock cmpxchg8b (%2)\n\t"
+                "jnz 1b"
+                : "=&b" (low), "=&c" (high)
+                : "r" (ptr)
+                : "ax","dx","memory");
+
+        return low | ((unsigned long long) high << 32);
+}
+#endif /* CONFIG_X86_CMPXCHG */
+
 /*
  * Note: no "lock" prefix even on SMP: xchg always implies lock anyway
  * Note 2: xchg has side effect, so that attribute volatile is necessary,
diff -urNp race/include/linux/fs.h race-fix/include/linux/fs.h
--- race/include/linux/fs.h	Tue Jul 23 18:46:48 2002
+++ race-fix/include/linux/fs.h	Tue Jul 23 19:13:51 2002
@@ -449,6 +449,13 @@ struct block_device {
 	struct list_head	bd_inodes;
 };
 
+#if BITS_PER_LONG==32 && defined(CONFIG_SMP) && !defined(__ARCH_HAS_GET_SET_64BIT)
+#define __NEED_I_SIZE_ORDERED
+#define i_size_ordered_init(inode) do { (inode)->i_size_version1 = (inode)->i_size_version2 = 0; } while (0)
+#else
+#define i_size_ordered_init(inode) do { } while (0)
+#endif
+
 struct inode {
 	struct list_head	i_hash;
 	struct list_head	i_list;
@@ -534,8 +541,65 @@ struct inode {
 		struct xfs_inode_info		xfs_i;
 		void				*generic_ip;
 	} u;
+#ifdef __NEED_I_SIZE_ORDERED
+	volatile int		i_size_version1;
+	volatile int		i_size_version2;
+#endif
 };
 
+/*
+ * NOTE: in a 32bit arch with a preemptable kernel and
+ * an UP compile the i_size_read/write must be atomic
+ * with respect to the local cpu (unlike with preempt disabled),
+ * but they don't need to be atomic with respect to other cpus like in
+ * true SMP (so they need either to either locally disable irq around
+ * the read or for example on x86 they can be still implemented as a
+ * cmpxchg8b without the need of the lock prefix). For SMP compiles
+ * and 64bit archs it makes no difference if preempt is enabled or not.
+ */
+static inline loff_t i_size_read(struct inode * inode)
+{
+#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+#ifdef __ARCH_HAS_GET_SET_64BIT
+	return (loff_t) get_64bit((unsigned long long *) &inode->i_size);
+#else
+	loff_t i_size;
+	int v1, v2;
+
+	/* Retry if i_size was possibly modified while sampling. */
+	do {
+		v1 = inode->i_size_version1;
+		rmb();
+		i_size = inode->i_size;
+		rmb();
+		v2 = inode->i_size_version2;
+	} while (v1 != v2);
+
+	return i_size;
+#endif
+#elif BITS_PER_LONG==64 || !defined(CONFIG_SMP)
+	return inode->i_size;
+#endif
+}
+
+static inline void i_size_write(struct inode * inode, loff_t i_size)
+{
+#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+#ifdef __ARCH_HAS_GET_SET_64BIT
+	set_64bit((unsigned long long *) &inode->i_size, (unsigned long long) i_size);
+#else
+	inode->i_size_version2++;
+	wmb();
+	inode->i_size = i_size;
+	wmb();
+	inode->i_size_version1++;
+	wmb(); /* make it visible ASAP */
+#endif
+#elif BITS_PER_LONG==64 || !defined(CONFIG_SMP)
+	inode->i_size = i_size;
+#endif
+}
+
 static inline void inode_add_bytes(struct inode *inode, loff_t bytes)
 {
 	inode->i_blocks += bytes >> 9;

Andrea
