Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262447AbSJ1M7Q>; Mon, 28 Oct 2002 07:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbSJ1M7Q>; Mon, 28 Oct 2002 07:59:16 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:24077 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S262447AbSJ1M7N>; Mon, 28 Oct 2002 07:59:13 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15805.13847.945978.673664@laputa.namesys.com>
Date: Mon, 28 Oct 2002 16:05:27 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH,RFC] faster kmalloc lookup
In-Reply-To: <3DBBEA2F.6000404@colorfullife.com>
References: <3DBAEB64.1090109@colorfullife.com>
	<1035671412.13032.125.camel@irongate.swansea.linux.org.uk>
	<3DBBBB30.20409@colorfullife.com>
	<3DBBEA2F.6000404@colorfullife.com>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Windows: there's got to be a better way.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul writes:
 > I've run my slab microbenchmark over the 3 versions:
 > - current
 > - generic_fls
 > - i386 asm optimized fls
 > 
 > The test reports the fastest time for 100 kmalloc calls in a tight loop 
 > (Duron 700). Loop/test overhead substracted.
 > 
 > 32-byte alloc:
 > current:        41 ticks
 > generic_fls: 56 ticks
 > bsrl:            54 ticks
 > 
 > 4096 byte alloc: 84 ticks
 > generic_fls: 53 ticks
 > bsrl:        54 ticks
 > 
 > 40 ticks difference for -current between 4096 and 32 bytes - ~4 cycles 
 > for each loop.
 > bit scan is 10 ticks slower for 32 byte allocs, 30 ticks faster for 4096 
 > byte allocs.
 > 
 > No difference between generic_fls and bsrl - the branch predictor can 
 > easily predict all branches in generic_fls for constant kmalloc calls.
 > 

Most kmalloc calls get constant size argument (usually
sizeof(something)). So, if switch() is used in stead of loop (and
kmalloc made inline), compiler would be able to optimize away
cache_sizes[] selection completely. Attached (ugly) patch does this.

 > --

Nikita.
===== include/linux/slab.h 1.13 vs edited =====
--- 1.13/include/linux/slab.h	Thu Sep 26 04:41:05 2002
+++ edited/include/linux/slab.h	Mon Oct 28 15:55:35 2002
@@ -58,8 +58,91 @@
 extern void kmem_cache_free(kmem_cache_t *, void *);
 extern unsigned int kmem_cache_size(kmem_cache_t *);
 
-extern void *kmalloc(size_t, int);
 extern void kfree(const void *);
+extern void * __kmalloc (int i, size_t size, int flags);
+
+/**
+ * kmalloc - allocate memory
+ * @size: how many bytes of memory are required.
+ * @flags: the type of memory to allocate.
+ *
+ * kmalloc is the normal method of allocating memory
+ * in the kernel.
+ *
+ * The @flags argument may be one of:
+ *
+ * %GFP_USER - Allocate memory on behalf of user.  May sleep.
+ *
+ * %GFP_KERNEL - Allocate normal kernel ram.  May sleep.
+ *
+ * %GFP_ATOMIC - Allocation will not sleep.  Use inside interrupt handlers.
+ *
+ * Additionally, the %GFP_DMA flag may be set to indicate the memory
+ * must be suitable for DMA.  This can mean different things on different
+ * platforms.  For example, on i386, it means that the memory must come
+ * from the first 16MB.
+ */
+static inline void * kmalloc (size_t size, int flags)
+{
+	int i;
+
+	switch(size) {
+#if PAGE_SIZE == 4096
+	case 0 ... 32:
+		i = 0;
+		break;
+	case 33 ... 64:
+#else
+	case 0 ... 64:
+#endif
+		i = 1;
+		break;
+	case 65 ... 96:
+		i = 2;
+		break;
+	case 97 ... 128:
+		i = 3;
+		break;
+	case 129 ... 192:
+		i = 4;
+		break;
+	case 193 ... 256:
+		i = 5;
+		break;
+	case 257 ... 512:
+		i = 6;
+		break;
+	case 513 ... 1024:
+		i = 7;
+		break;
+	case 1025 ... 2048:
+		i = 8;
+		break;
+	case 2049 ... 4096:
+		i = 9;
+		break;
+	case 4097 ... 8192:
+		i = 10;
+		break;
+	case 8193 ... 16384:
+		i = 11;
+		break;
+	case 16385 ... 32768:
+		i = 12;
+		break;
+	case 32769 ... 65536:
+		i = 13;
+		break;
+	case 65537 ... 131072:
+		i = 14;
+		break;
+	default:
+		return NULL;
+	}
+
+	return __kmalloc(i, size, flags);
+}
+
 
 extern int FASTCALL(kmem_cache_reap(int));
 
===== mm/slab.c 1.33 vs edited =====
--- 1.33/mm/slab.c	Sat Sep 28 18:23:50 2002
+++ edited/mm/slab.c	Mon Oct 28 16:01:24 2002
@@ -1573,40 +1573,6 @@
 }
 
 /**
- * kmalloc - allocate memory
- * @size: how many bytes of memory are required.
- * @flags: the type of memory to allocate.
- *
- * kmalloc is the normal method of allocating memory
- * in the kernel.
- *
- * The @flags argument may be one of:
- *
- * %GFP_USER - Allocate memory on behalf of user.  May sleep.
- *
- * %GFP_KERNEL - Allocate normal kernel ram.  May sleep.
- *
- * %GFP_ATOMIC - Allocation will not sleep.  Use inside interrupt handlers.
- *
- * Additionally, the %GFP_DMA flag may be set to indicate the memory
- * must be suitable for DMA.  This can mean different things on different
- * platforms.  For example, on i386, it means that the memory must come
- * from the first 16MB.
- */
-void * kmalloc (size_t size, int flags)
-{
-	cache_sizes_t *csizep = cache_sizes;
-
-	for (; csizep->cs_size; csizep++) {
-		if (size > csizep->cs_size)
-			continue;
-		return __kmem_cache_alloc(flags & GFP_DMA ?
-			 csizep->cs_dmacachep : csizep->cs_cachep, flags);
-	}
-	return NULL;
-}
-
-/**
  * kmem_cache_free - Deallocate an object
  * @cachep: The cache the allocation was from.
  * @objp: The previously allocated object.
@@ -1626,6 +1592,19 @@
 	local_irq_save(flags);
 	__kmem_cache_free(cachep, objp);
 	local_irq_restore(flags);
+}
+
+void * __kmalloc (int i, size_t size, int flags)
+{
+	cache_sizes_t *csizep;
+
+#if PAGE_SIZE == 4096
+	csizep = &cache_sizes[i];
+#else
+	csizep = &cache_sizes[i - 1];
+#endif
+	return kmem_cache_alloc(flags & GFP_DMA ?
+				csizep->cs_dmacachep : csizep->cs_cachep, flags);
 }
 
 /**
