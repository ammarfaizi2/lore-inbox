Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131395AbRCWUDV>; Fri, 23 Mar 2001 15:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131400AbRCWUDI>; Fri, 23 Mar 2001 15:03:08 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:46808 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S131395AbRCWUCM>; Fri, 23 Mar 2001 15:02:12 -0500
Date: Fri, 23 Mar 2001 11:57:31 -0800
From: David Brownell <david-b@pacbell.net>
Subject: PATCHES:  usb with CONFIG_SLAB_DEBUG (using new pci_pool API)
To: linux-usb-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Message-id: <189101c0b3d3$7f732da0$6800000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: multipart/mixed;
 boundary="----=_NextPart_000_188E_01C0B390.70A073C0"
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_188E_01C0B390.70A073C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

Here are updated patches getting usb-ohci and usb-uhci to
behave on an ac20 kernel with slab debugging enabled.
It uses the pci_pool API, discussed earlier.

- pcipool-0323.patch ... adds pci_pool apis to <linux/pci.h>;
    bugfixes vs what I sent to linux-usb-devel yesterday

- ohci-0323.patch ... basically what I sent yesterday

- uhci-0323.patch ... bugfixes vs what I sent yesterday;
    adds a fix for an unrelated oops (referencing an urb
    after the completion function freed it)

I don't know about any problems with these, but that doesn't
mean they're not lurking.  Converting usb-ohci to use the rest
of the pci dma mapping APIs is being done separately, and
I think Johannes has an update pending to "uhci.c".  The EHCI
host controller driver (latest) is also using "pci_pool".

Does anyone want particularly want to see further discussion
about the pci_pool API?  This version dropped the explicit
address mapping primitive that was contentious last time,
and nothing else appeared to be troublesome.  (Shouldn't be!)
This version does add another pci_pool_create() parameter,
as needed to handle a 4KB-crossing restriction for ehci.  That
verges on too many arguments, any more and I'd want them
wrapped into a (readonly) structure.

- Dave




------=_NextPart_000_188E_01C0B390.70A073C0
Content-Type: application/octet-stream;
	name="pcipool-0323.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pcipool-0323.patch"

--- include/linux/pci-orig.h	Wed Mar 14 12:40:44 2001=0A=
+++ include/linux/pci.h	Thu Mar 22 14:06:46 2001=0A=
@@ -553,6 +553,14 @@=0A=
 struct pci_driver *pci_dev_driver(const struct pci_dev *);=0A=
 const struct pci_device_id *pci_match_device(const struct pci_device_id =
*ids, const struct pci_dev *dev);=0A=
 =0A=
+/* kmem_cache style wrapper around pci_alloc_consistent() */=0A=
+struct pci_pool *pci_pool_create (const char *name, struct pci_dev *dev,=0A=
+		size_t size, size_t align, size_t allocation, int flags);=0A=
+void pci_pool_destroy (struct pci_pool *pool);=0A=
+=0A=
+void *pci_pool_alloc (struct pci_pool *pool, int flags, dma_addr_t =
*handle);=0A=
+void pci_pool_free (struct pci_pool *pool, void *vaddr, dma_addr_t =
addr);=0A=
+=0A=
 #endif /* CONFIG_PCI */=0A=
 =0A=
 /* Include architecture-dependent settings and functions */=0A=
--- drivers/pci/pci-orig.c	Wed Mar 14 12:40:27 2001=0A=
+++ drivers/pci/pci.c	Fri Mar 23 10:12:46 2001=0A=
@@ -1339,6 +1339,344 @@=0A=
 }=0A=
 #endif=0A=
 =0A=
+/*=0A=
+ * Pool allocator ... useful for many drivers.  This wraps the core=0A=
+ * pci_alloc_consistent allocator, so small blocks can easily be used=0A=
+ * by drivers for bus mastering controllers.  This should probably be=0A=
+ * sharing the guts of the slab allocator.=0A=
+ */=0A=
+=0A=
+struct pci_pool {	/* the pool */=0A=
+	struct list_head	page_list;=0A=
+	spinlock_t		lock;=0A=
+	size_t			blocks_per_page;=0A=
+	size_t			size;=0A=
+	int			flags;=0A=
+	struct pci_dev		*dev;=0A=
+	size_t			allocation;=0A=
+	char			name [32];=0A=
+	wait_queue_head_t	waitq;=0A=
+};=0A=
+=0A=
+struct pci_page {	/* cacheable header for 'allocation' bytes */=0A=
+	struct list_head	page_list;=0A=
+	void			*vaddr;=0A=
+	dma_addr_t		dma;=0A=
+	unsigned long		bitmap [0];=0A=
+};=0A=
+=0A=
+#define	POOL_TIMEOUT_JIFFIES	((100 /* msec */ * HZ) / 1000)=0A=
+#define	POOL_POISON_BYTE	0x97=0A=
+=0A=
+// #define CONFIG_PCIPOOL_DEBUG=0A=
+=0A=
+=0A=
+/**=0A=
+ * pci_pool_create - Creates a pool of pci consistent memory blocks, =
for dma.=0A=
+ * @name: name of pool, for diagnostics=0A=
+ * @pdev: pci device that will be doing the DMA=0A=
+ * @size: size of the blocks in this pool.=0A=
+ * @align: alignment requirement for blocks; must be a power of two=0A=
+ * @allocation: returned blocks won't cross this boundary (or zero)=0A=
+ * @flags: SLAB_* (or GFP_*) flags (not all are supported).=0A=
+ *=0A=
+ * Returns a pci allocation pool with the requested characteristics, or=0A=
+ * null if one can't be created.  Given one of these pools, =
pci_pool_alloc()=0A=
+ * may be used to allocate memory.  Such memory will all have =
"consistent"=0A=
+ * DMA mappings, accessible by the device and its driver without using=0A=
+ * cache flushing primitives.  The actual size of blocks allocated may =
be=0A=
+ * larger than requested because of alignment.=0A=
+ *=0A=
+ * If allocation is nonzero, objects returned from pci_pool_alloc() =
won't=0A=
+ * cross that size boundary.  This may be useful for devices which have=0A=
+ * addressing restrictions on individual DMA transfers, such as not =
crossing=0A=
+ * boundaries of 4KBytes.=0A=
+ */=0A=
+struct pci_pool *=0A=
+pci_pool_create (const char *name, struct pci_dev *pdev,=0A=
+	size_t size, size_t align, size_t allocation, int flags)=0A=
+{=0A=
+	struct pci_pool		*retval;=0A=
+=0A=
+	if (size =3D=3D 0)=0A=
+		return 0;=0A=
+	else if (size < align)=0A=
+		size =3D align;=0A=
+	else if ((size % align) !=3D 0) {=0A=
+		size +=3D align + 1;=0A=
+		size &=3D ~(align - 1);=0A=
+	}=0A=
+=0A=
+	if (allocation =3D=3D 0) {=0A=
+		if (PAGE_SIZE < size)=0A=
+			allocation =3D size;=0A=
+		else=0A=
+			allocation =3D PAGE_SIZE;=0A=
+		// FIXME: round up for less fragmentation=0A=
+	} else if (allocation < size)=0A=
+		return 0;=0A=
+=0A=
+	if (!(retval =3D kmalloc (sizeof *retval, flags)))=0A=
+		return retval;=0A=
+=0A=
+#ifdef	CONFIG_PCIPOOL_DEBUG=0A=
+	flags |=3D SLAB_POISON;=0A=
+#endif=0A=
+=0A=
+	strncpy (retval->name, name, sizeof retval->name);=0A=
+	retval->name [sizeof retval->name - 1] =3D 0;=0A=
+=0A=
+	retval->dev =3D pdev;=0A=
+	INIT_LIST_HEAD (&retval->page_list);=0A=
+	spin_lock_init (&retval->lock);=0A=
+	retval->size =3D size;=0A=
+	retval->flags =3D flags;=0A=
+	retval->allocation =3D allocation;=0A=
+	retval->blocks_per_page =3D allocation / size;=0A=
+	init_waitqueue_head (&retval->waitq);=0A=
+=0A=
+#ifdef CONFIG_PCIPOOL_DEBUG=0A=
+	printk (KERN_DEBUG "pcipool create %s/%s size %d, %d/page (%d =
alloc)\n",=0A=
+		pdev->slot_name, retval->name, size,=0A=
+		retval->blocks_per_page, allocation);=0A=
+#endif=0A=
+=0A=
+	return retval;=0A=
+}=0A=
+=0A=
+=0A=
+static struct pci_page *=0A=
+pool_alloc_page (struct pci_pool *pool, int mem_flags)=0A=
+{=0A=
+	struct pci_page	*page;=0A=
+	int		mapsize;=0A=
+=0A=
+	mapsize =3D pool->blocks_per_page;=0A=
+	mapsize =3D (mapsize + BITS_PER_LONG - 1) / BITS_PER_LONG;=0A=
+	mapsize *=3D sizeof (long);=0A=
+=0A=
+	page =3D (struct pci_page *) kmalloc (mapsize + sizeof *page, =
mem_flags);=0A=
+	if (!page)=0A=
+		return 0;=0A=
+	page->vaddr =3D pci_alloc_consistent (pool->dev,=0A=
+				pool->allocation, &page->dma);=0A=
+	if (page->vaddr) {=0A=
+		memset (page->bitmap, ~0, mapsize);	// bit set =3D=3D free=0A=
+		if (pool->flags & SLAB_POISON)=0A=
+			memset (page->vaddr, POOL_POISON_BYTE, pool->allocation);=0A=
+		list_add (&page->page_list, &pool->page_list);=0A=
+	}=0A=
+	return page;=0A=
+}=0A=
+=0A=
+=0A=
+static inline int=0A=
+is_page_busy (int blocks, unsigned long *bitmap)=0A=
+{=0A=
+	while (blocks > 0) {=0A=
+		if (*bitmap++ !=3D ~0)=0A=
+			return 1;=0A=
+		blocks -=3D BITS_PER_LONG;=0A=
+	}=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static void=0A=
+pool_free_page (struct pci_pool *pool, struct pci_page *page)=0A=
+{=0A=
+	dma_addr_t	dma =3D page->dma;=0A=
+=0A=
+#ifdef CONFIG_PCIPOOL_DEBUG=0A=
+	if (is_page_busy (pool->blocks_per_page, page->bitmap)) {=0A=
+		printk (KERN_ERR "pcipool %s/%s, free_page %p busy; leaked\n",=0A=
+			pool->dev->slot_name, pool->name, page->vaddr);=0A=
+		goto done;=0A=
+	}=0A=
+#endif=0A=
+=0A=
+	if (pool->flags & SLAB_POISON)=0A=
+		memset (page->vaddr, POOL_POISON_BYTE, pool->allocation);=0A=
+	pci_free_consistent (pool->dev, pool->allocation, page->vaddr, dma);=0A=
+done:=0A=
+	list_del (&page->page_list);=0A=
+	kfree (page);=0A=
+}=0A=
+=0A=
+=0A=
+/**=0A=
+ * pci_pool_destroy - destroys a pool of pci memory blocks.=0A=
+ * @pool: pci pool that will be destroyed=0A=
+ *=0A=
+ * Caller guarantees that no more memory from the pool is in use,=0A=
+ * and that nothing will try to use the pool after this call.=0A=
+ */=0A=
+void=0A=
+pci_pool_destroy (struct pci_pool *pool)=0A=
+{=0A=
+	unsigned long		flags;=0A=
+=0A=
+#ifdef CONFIG_PCIPOOL_DEBUG=0A=
+	printk (KERN_DEBUG "pcipool destroy %s/%s\n",=0A=
+		pool->dev->slot_name, pool->name);=0A=
+#endif=0A=
+=0A=
+	spin_lock_irqsave (&pool->lock, flags);=0A=
+	while (!list_empty (&pool->page_list)) {=0A=
+		struct pci_page		*page;=0A=
+		page =3D list_entry (pool->page_list.next,=0A=
+				struct pci_page, page_list);=0A=
+		pool_free_page (pool, page);=0A=
+	}=0A=
+	spin_unlock_irqrestore (&pool->lock, flags);=0A=
+	kfree (pool);=0A=
+}=0A=
+=0A=
+=0A=
+/**=0A=
+ * pci_pool_alloc - get a block of consistent memory=0A=
+ * @pool: pci pool that will produce the block=0A=
+ * @mem_flags: GFP_KERNEL or GFP_ATOMIC=0A=
+ * @handle: pointer to dma address of block=0A=
+ *=0A=
+ * This returns the kernel virtual address of a currently unused block,=0A=
+ * and reports its dma address through the handle.=0A=
+ */=0A=
+void *=0A=
+pci_pool_alloc (struct pci_pool *pool, int mem_flags, dma_addr_t =
*handle)=0A=
+{=0A=
+	unsigned long		flags;=0A=
+	struct list_head	*entry;=0A=
+	struct pci_page		*page;=0A=
+	int			map, block;=0A=
+	size_t			offset;=0A=
+	void			*retval;=0A=
+=0A=
+restart:=0A=
+	spin_lock_irqsave (&pool->lock, flags);=0A=
+	list_for_each (entry, &pool->page_list) {=0A=
+		int		i;=0A=
+		page =3D list_entry (entry, struct pci_page, page_list);=0A=
+		/* only cachable accesses here ... */=0A=
+		for (map =3D 0, i =3D 0;=0A=
+				i < pool->blocks_per_page;=0A=
+				i +=3D BITS_PER_LONG, map++) {=0A=
+			if (page->bitmap [map] =3D=3D 0)=0A=
+				continue;=0A=
+			block =3D ffs (page->bitmap [map]);=0A=
+			if ((i + block) <=3D pool->blocks_per_page) {=0A=
+				block--;=0A=
+				clear_bit (block, &page->bitmap [map]);=0A=
+				offset =3D (BITS_PER_LONG * map) + block;=0A=
+				offset *=3D pool->size;=0A=
+				goto ready;=0A=
+			}=0A=
+		}=0A=
+	}=0A=
+	if (!(page =3D pool_alloc_page (pool, mem_flags))) {=0A=
+		if (mem_flags =3D=3D GFP_KERNEL) {=0A=
+			DECLARE_WAITQUEUE (wait, current);=0A=
+=0A=
+			current->state =3D TASK_INTERRUPTIBLE;=0A=
+			add_wait_queue (&pool->waitq, &wait);=0A=
+			spin_unlock_irqrestore (&pool->lock, flags);=0A=
+=0A=
+			schedule_timeout (POOL_TIMEOUT_JIFFIES);=0A=
+=0A=
+			current->state =3D TASK_RUNNING;=0A=
+			remove_wait_queue (&pool->waitq, &wait);=0A=
+			goto restart;=0A=
+		}=0A=
+		retval =3D 0;=0A=
+		goto done;=0A=
+	}=0A=
+=0A=
+	clear_bit (0, &page->bitmap [0]);=0A=
+	offset =3D 0;=0A=
+ready:=0A=
+	retval =3D offset + page->vaddr;=0A=
+	*handle =3D offset + page->dma;=0A=
+done:=0A=
+	spin_unlock_irqrestore (&pool->lock, flags);=0A=
+	return retval;=0A=
+}=0A=
+=0A=
+=0A=
+static struct pci_page *=0A=
+pool_find_page (struct pci_pool *pool, dma_addr_t dma)=0A=
+{=0A=
+	unsigned long		flags;=0A=
+	struct list_head	*entry;=0A=
+	struct pci_page		*page;=0A=
+=0A=
+	spin_lock_irqsave (&pool->lock, flags);=0A=
+	list_for_each (entry, &pool->page_list) {=0A=
+		page =3D list_entry (entry, struct pci_page, page_list);=0A=
+		if (dma < page->dma)=0A=
+			continue;=0A=
+		if (dma < (page->dma + pool->allocation))=0A=
+			goto done;=0A=
+	}=0A=
+	page =3D 0;=0A=
+done:=0A=
+	spin_unlock_irqrestore (&pool->lock, flags);=0A=
+	return page;=0A=
+}=0A=
+=0A=
+=0A=
+/**=0A=
+ * pci_pool_free - put block back into pci pool=0A=
+ * @pool: the pci pool holding the block=0A=
+ * @vaddr: virtual address of block=0A=
+ * @dma: dma address of block=0A=
+ *=0A=
+ * Caller promises neither device nor driver will again touch this block=0A=
+ * unless it is first re-allocated.=0A=
+ */=0A=
+void=0A=
+pci_pool_free (struct pci_pool *pool, void *vaddr, dma_addr_t dma)=0A=
+{=0A=
+	struct pci_page		*page;=0A=
+	unsigned long		flags;=0A=
+	int			map, block;=0A=
+=0A=
+	if ((page =3D pool_find_page (pool, dma)) =3D=3D 0) {=0A=
+		printk (KERN_ERR "pci_pool_free %s/%s, %p/%x (bad dma)\n",=0A=
+			pool->dev->slot_name, pool->name, vaddr, dma);=0A=
+		return;=0A=
+	}=0A=
+#ifdef	CONFIG_PCIPOOL_DEBUG=0A=
+	if (((dma - page->dma) + (void *)page->vaddr) !=3D vaddr) {=0A=
+		printk (KERN_ERR "pci_pool_free %s/%s, %p (bad vaddr)/%x\n",=0A=
+			pool->dev->slot_name, pool->name, vaddr, dma);=0A=
+		return;=0A=
+	}=0A=
+#endif=0A=
+=0A=
+	block =3D dma - page->dma;=0A=
+	block /=3D pool->size;=0A=
+	map =3D block / BITS_PER_LONG;=0A=
+	block %=3D BITS_PER_LONG;=0A=
+=0A=
+#ifdef	CONFIG_PCIPOOL_DEBUG=0A=
+	if (page->bitmap [map] & (1 << block)) {=0A=
+		printk (KERN_ERR "pci_pool_free %s/%s, dma %x already free\n",=0A=
+			pool->dev->slot_name, pool->name, dma);=0A=
+		return;=0A=
+	}=0A=
+#endif=0A=
+	if (pool->flags & SLAB_POISON)=0A=
+		memset (vaddr, POOL_POISON_BYTE, pool->size);=0A=
+=0A=
+	spin_lock_irqsave (&pool->lock, flags);=0A=
+	set_bit (block, &page->bitmap [map]);=0A=
+	if (waitqueue_active (&pool->waitq))=0A=
+		wake_up (&pool->waitq);=0A=
+	else if (!is_page_busy (pool->blocks_per_page, page->bitmap))=0A=
+		pool_free_page (pool, page);=0A=
+	spin_unlock_irqrestore (&pool->lock, flags);=0A=
+}=0A=
+=0A=
+=0A=
 void __init pci_init(void)=0A=
 {=0A=
 	struct pci_dev *dev;=0A=
@@ -1420,4 +1758,11 @@=0A=
 =0A=
 EXPORT_SYMBOL(isa_dma_bridge_buggy);=0A=
 EXPORT_SYMBOL(pci_pci_problems);=0A=
+=0A=
+/* Pool allocator (layer over pci_alloc_consistent) */=0A=
+=0A=
+EXPORT_SYMBOL (pci_pool_create);=0A=
+EXPORT_SYMBOL (pci_pool_destroy);=0A=
+EXPORT_SYMBOL (pci_pool_alloc);=0A=
+EXPORT_SYMBOL (pci_pool_free);=0A=
 =0A=

------=_NextPart_000_188E_01C0B390.70A073C0
Content-Type: application/octet-stream;
	name="ohci-0323.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ohci-0323.patch"

--- drivers/usb/usb-ohci-orig.h	Wed Mar 14 12:40:36 2001=0A=
+++ drivers/usb/usb-ohci.h	Fri Mar 23 10:13:17 2001=0A=
@@ -39,7 +39,7 @@=0A=
 #define ED_URB_DEL  	0x08=0A=
 =0A=
 /* usb_ohci_ed */=0A=
-typedef struct ed {=0A=
+struct ed {=0A=
 	__u32 hwINFO;       =0A=
 	__u32 hwTailP;=0A=
 	__u32 hwHeadP;=0A=
@@ -53,9 +53,12 @@=0A=
 	__u8 state;=0A=
 	__u8 type; =0A=
 	__u16 last_iso;=0A=
-    struct ed * ed_rm_list;=0A=
-   =0A=
-} ed_t;=0A=
+	struct ed * ed_rm_list;=0A=
+=0A=
+	dma_addr_t dma;=0A=
+	__u32 unused[3];=0A=
+} __attribute((aligned(16)));=0A=
+typedef struct ed ed_t;=0A=
 =0A=
  =0A=
 /* TD info field */=0A=
@@ -96,19 +99,23 @@=0A=
 =0A=
 #define MAXPSW 1=0A=
 =0A=
-typedef struct td { =0A=
+struct td {=0A=
 	__u32 hwINFO;=0A=
   	__u32 hwCBP;		/* Current Buffer Pointer */=0A=
   	__u32 hwNextTD;		/* Next TD Pointer */=0A=
   	__u32 hwBE;		/* Memory Buffer End Pointer */=0A=
-  	__u16 hwPSW[MAXPSW];=0A=
 =0A=
+  	__u16 hwPSW[MAXPSW];=0A=
   	__u8 unused;=0A=
   	__u8 index;=0A=
   	struct ed * ed;=0A=
   	struct td * next_dl_td;=0A=
   	urb_t * urb;=0A=
-} td_t;=0A=
+=0A=
+	dma_addr_t td_dma;=0A=
+	__u32 unused2[3];=0A=
+} __attribute((aligned(16)));=0A=
+typedef struct td td_t;=0A=
 =0A=
 =0A=
 #define OHCI_ED_SKIP	(1 << 14)=0A=
@@ -121,7 +128,7 @@=0A=
  =0A=
 #define NUM_INTS 32	/* part of the OHCI standard */=0A=
 struct ohci_hcca {=0A=
-    __u32	int_table[NUM_INTS];	/* Interrupt ED table */=0A=
+	__u32	int_table[NUM_INTS];	/* Interrupt ED table */=0A=
 	__u16	frame_no;		/* current frame number */=0A=
 	__u16	pad1;			/* set to 0 on each frame_no change */=0A=
 	__u32	done_head;		/* info returned for an interrupt */=0A=
@@ -356,7 +363,7 @@=0A=
 	struct ohci_regs * regs;	/* OHCI controller's memory */=0A=
 	struct list_head ohci_hcd_list;	/* list of all ohci_hcd */=0A=
 =0A=
-	struct ohci * next; 		// chain of uhci device contexts=0A=
+	struct ohci * next; 		// chain of ohci device contexts=0A=
 	// struct list_head urb_list; 	// list of all pending urbs=0A=
 	// spinlock_t urb_list_lock; 	// lock to keep consistency =0A=
   =0A=
@@ -371,17 +378,18 @@=0A=
 	struct usb_device * dev[128];=0A=
 	struct virt_root_hub rh;=0A=
 =0A=
-	/* PCI device handle and settings */=0A=
+	/* PCI device handle, settings, ... */=0A=
 	struct pci_dev	*ohci_dev;=0A=
 	u8		pci_latency;=0A=
+	struct pci_pool	*td_cache;=0A=
+	struct pci_pool	*dev_cache;=0A=
 } ohci_t;=0A=
 =0A=
-=0A=
-#define NUM_TDS	0		/* num of preallocated transfer descriptors */=0A=
 #define NUM_EDS 32		/* num of preallocated endpoint descriptors */=0A=
 =0A=
 struct ohci_device {=0A=
 	ed_t 	ed[NUM_EDS];=0A=
+	dma_addr_t dma;=0A=
 	int ed_cnt;=0A=
 	wait_queue_head_t * wait;=0A=
 };=0A=
@@ -393,7 +401,7 @@=0A=
 /* endpoint */=0A=
 static int ep_link(ohci_t * ohci, ed_t * ed);=0A=
 static int ep_unlink(ohci_t * ohci, ed_t * ed);=0A=
-static ed_t * ep_add_ed(struct usb_device * usb_dev, unsigned int pipe, =
int interval, int load);=0A=
+static ed_t * ep_add_ed(struct usb_device * usb_dev, unsigned int pipe, =
int interval, int load, int mem_flags);=0A=
 static void ep_rm_ed(struct usb_device * usb_dev, ed_t * ed);=0A=
 /* td */=0A=
 static void td_fill(unsigned int info, void * data, int len, urb_t * =
urb, int index);=0A=
@@ -406,97 +414,91 @@=0A=
 =
/*-----------------------------------------------------------------------=
--*/=0A=
 =0A=
 #define ALLOC_FLAGS (in_interrupt () ? GFP_ATOMIC : GFP_KERNEL)=0A=
- =0A=
-#ifdef OHCI_MEM_SLAB=0A=
-#define	__alloc(t,c) kmem_cache_alloc(c,ALLOC_FLAGS)=0A=
-#define	__free(c,x) kmem_cache_free(c,x)=0A=
-static kmem_cache_t *td_cache, *ed_cache;=0A=
 =0A=
-/*=0A=
- * WARNING:  do NOT use this with "forced slab debug"; it won't respect=0A=
- * our hardware alignment requirement.=0A=
- */=0A=
-#ifndef OHCI_MEM_FLAGS=0A=
-#define	OHCI_MEM_FLAGS 0=0A=
+#ifdef DEBUG=0A=
+#	define OHCI_MEM_FLAGS	SLAB_POISON=0A=
+#else=0A=
+#	define OHCI_MEM_FLAGS	0=0A=
+#endif=0A=
+ =0A=
+#ifndef CONFIG_PCI=0A=
+#	error "usb-ohci currently requires PCI-based controllers"=0A=
+	/* to support non-PCI OHCIs, you need custom bus/mem/... glue */=0A=
 #endif=0A=
 =0A=
-static int ohci_mem_init (void)=0A=
+static int ohci_mem_init (struct ohci *ohci)=0A=
 {=0A=
-	/* redzoning (or forced debug!) breaks alignment */=0A=
-	int	flags =3D (OHCI_MEM_FLAGS) & ~SLAB_RED_ZONE;=0A=
-=0A=
-	/* TDs accessed by controllers and host */=0A=
-	td_cache =3D kmem_cache_create ("ohci_td", sizeof (struct td), 0,=0A=
-		flags | SLAB_HWCACHE_ALIGN, NULL, NULL);=0A=
-	if (!td_cache) {=0A=
-		dbg ("no TD cache?");=0A=
+	ohci->td_cache =3D pci_pool_create ("ohci_td", ohci->ohci_dev,=0A=
+		sizeof (struct td),=0A=
+		16 /* byte alignment */,=0A=
+		0 /* no page-crossing issues */,=0A=
+		GFP_KERNEL | OHCI_MEM_FLAGS);=0A=
+	if (!ohci->td_cache)=0A=
 		return -ENOMEM;=0A=
-	}=0A=
-=0A=
-	/* EDs are accessed by controllers and host;  dev part is host-only */=0A=
-	ed_cache =3D kmem_cache_create ("ohci_ed", sizeof (struct =
ohci_device), 0,=0A=
-		flags | SLAB_HWCACHE_ALIGN, NULL, NULL);=0A=
-	if (!ed_cache) {=0A=
-		dbg ("no ED cache?");=0A=
-		kmem_cache_destroy (td_cache);=0A=
-		td_cache =3D 0;=0A=
+	ohci->dev_cache =3D pci_pool_create ("ohci_dev", ohci->ohci_dev,=0A=
+		sizeof (struct ohci_device),=0A=
+		16 /* byte alignment */,=0A=
+		0 /* no page-crossing issues */,=0A=
+		GFP_KERNEL | OHCI_MEM_FLAGS);=0A=
+	if (!ohci->dev_cache)=0A=
 		return -ENOMEM;=0A=
-	}=0A=
-	dbg ("slab flags 0x%x", flags);=0A=
 	return 0;=0A=
 }=0A=
 =0A=
-static void ohci_mem_cleanup (void)=0A=
+static void ohci_mem_cleanup (struct ohci *ohci)=0A=
 {=0A=
-	if (ed_cache && kmem_cache_destroy (ed_cache))=0A=
-		err ("ed_cache remained");=0A=
-	ed_cache =3D 0;=0A=
-=0A=
-	if (td_cache && kmem_cache_destroy (td_cache))=0A=
-		err ("td_cache remained");=0A=
-	td_cache =3D 0;=0A=
+	if (ohci->td_cache) {=0A=
+		pci_pool_destroy (ohci->td_cache);=0A=
+		ohci->td_cache =3D 0;=0A=
+	}=0A=
+	if (ohci->dev_cache) {=0A=
+		pci_pool_destroy (ohci->dev_cache);=0A=
+		ohci->dev_cache =3D 0;=0A=
+	}=0A=
 }=0A=
 =0A=
-#else=0A=
-#define	__alloc(t,c) kmalloc(sizeof(t),ALLOC_FLAGS)=0A=
-#define	__free(dev,x) kfree(x)=0A=
-#define td_cache 0=0A=
-#define ed_cache 0=0A=
-=0A=
-static inline int ohci_mem_init (void) { return 0; }=0A=
-static inline void ohci_mem_cleanup (void) { return; }=0A=
-=0A=
-/* FIXME: pci_consistent version */=0A=
-=0A=
-#endif=0A=
-=0A=
-=0A=
 /* TDs ... */=0A=
 static inline struct td *=0A=
-td_alloc (struct ohci *hc)=0A=
+td_alloc (struct ohci *hc, int mem_flags)=0A=
 {=0A=
-	struct td *td =3D (struct td *) __alloc (struct td, td_cache);=0A=
+	dma_addr_t	dma;=0A=
+	struct td	*td;=0A=
+=0A=
+	td =3D pci_pool_alloc (hc->td_cache, mem_flags, &dma);=0A=
+	if (td)=0A=
+		td->td_dma =3D dma;=0A=
 	return td;=0A=
 }=0A=
 =0A=
 static inline void=0A=
 td_free (struct ohci *hc, struct td *td)=0A=
 {=0A=
-	__free (td_cache, td);=0A=
+	pci_pool_free (hc->td_cache, td, td->td_dma);=0A=
 }=0A=
 =0A=
 =0A=
 /* DEV + EDs ... only the EDs need to be consistent */=0A=
 static inline struct ohci_device *=0A=
-dev_alloc (struct ohci *hc)=0A=
+dev_alloc (struct ohci *hc, int mem_flags)=0A=
 {=0A=
-	struct ohci_device *dev =3D (struct ohci_device *)=0A=
-		__alloc (struct ohci_device, ed_cache);=0A=
+	dma_addr_t		dma;=0A=
+	struct ohci_device	*dev;=0A=
+	int			i, offset;=0A=
+=0A=
+	dev =3D pci_pool_alloc (hc->dev_cache, mem_flags, &dma);=0A=
+	if (dev) {=0A=
+		memset (dev, 0, sizeof (*dev));=0A=
+		dev->dma =3D dma;=0A=
+		offset =3D ((char *)&dev->ed) - ((char *)dev);=0A=
+		for (i =3D 0; i < NUM_EDS; i++, offset +=3D sizeof dev->ed [0])=0A=
+			dev->ed [i].dma =3D dma + offset;=0A=
+	}=0A=
 	return dev;=0A=
 }=0A=
 =0A=
 static inline void=0A=
-dev_free (struct ohci_device *dev)=0A=
+dev_free (struct ohci *hc, struct ohci_device *dev)=0A=
 {=0A=
-	__free (ed_cache, dev);=0A=
+	pci_pool_free (hc->dev_cache, dev, dev->dma);=0A=
 }=0A=
+=0A=
--- drivers/usb/usb-ohci-orig.c	Wed Mar 14 12:40:36 2001=0A=
+++ drivers/usb/usb-ohci.c	Wed Mar 21 17:33:06 2001=0A=
@@ -12,11 +12,12 @@=0A=
  * =0A=
  * History:=0A=
  * =0A=
+ * 2001/03/21 td and dev/ed allocation uses new pci_pool API (db)=0A=
  * 2001/03/07 hcca allocation uses pci_alloc_consistent (Steve =
Longerbeam)=0A=
  * 2000/09/26 fixed races in removing the private portion of the urb=0A=
  * 2000/09/07 disable bulk and control lists when unlinking the last=0A=
  *	endpoint descriptor in order to avoid unrecoverable errors on=0A=
- *	the Lucent chips.=0A=
+ *	the Lucent chips. (rwc@sgi)=0A=
  * 2000/08/29 use bandwidth claiming hooks (thanks Randy!), fix some=0A=
  *	urb unlink probs, indentation fixes=0A=
  * 2000/08/11 various oops fixes mostly affecting iso and cleanup from=0A=
@@ -65,8 +66,6 @@=0A=
 =0A=
 #define OHCI_USE_NPS		// force NoPowerSwitching mode=0A=
 // #define OHCI_VERBOSE_DEBUG	/* not always helpful */=0A=
-// #define OHCI_MEM_SLAB=0A=
-// #define OHCI_MEM_FLAGS	SLAB_POISON	/* no redzones; see mm/slab.c */=0A=
 =0A=
 #include "usb-ohci.h"=0A=
 =0A=
@@ -132,7 +131,7 @@=0A=
 			}=0A=
 		}=0A=
 =0A=
-		urb_free_priv ((struct ohci *)urb->dev->bus, urb_priv);=0A=
+		urb_free_priv ((struct ohci *)urb->dev->bus->hcpriv, urb_priv);=0A=
 		usb_dec_dev_use (urb->dev);=0A=
 		urb->dev =3D NULL;=0A=
 	}=0A=
@@ -460,6 +459,7 @@=0A=
 	int i, size =3D 0;=0A=
 	unsigned long flags;=0A=
 	int bustime =3D 0;=0A=
+	int mem_flags =3D ALLOC_FLAGS;=0A=
 	=0A=
 	if (!urb->dev || !urb->dev->bus)=0A=
 		return -ENODEV;=0A=
@@ -489,7 +489,7 @@=0A=
 	}=0A=
 =0A=
 	/* every endpoint has a ed, locate and fill it */=0A=
-	if (!(ed =3D ep_add_ed (urb->dev, pipe, urb->interval, 1))) {=0A=
+	if (!(ed =3D ep_add_ed (urb->dev, pipe, urb->interval, 1, mem_flags))) =
{=0A=
 		usb_dec_dev_use (urb->dev);	=0A=
 		return -ENOMEM;=0A=
 	}=0A=
@@ -534,8 +534,9 @@=0A=
 =0A=
 	/* allocate the TDs */=0A=
 	for (i =3D 0; i < size; i++) { =0A=
-		urb_priv->td[i] =3D td_alloc (ohci);=0A=
+		urb_priv->td[i] =3D td_alloc (ohci, mem_flags);=0A=
 		if (!urb_priv->td[i]) {=0A=
+			urb_priv->length =3D i;=0A=
 			urb_free_priv (ohci, urb_priv);=0A=
 			usb_dec_dev_use (urb->dev);	=0A=
 			return -ENOMEM;=0A=
@@ -687,18 +688,11 @@=0A=
 {=0A=
 	struct ohci_device * dev;=0A=
 =0A=
-	/* FIXME:  ED allocation with pci_consistent memory=0A=
-	 * must know the controller ... either pass it in here,=0A=
-	 * or decouple ED allocation from dev allocation.=0A=
-	 */=0A=
-	dev =3D dev_alloc (NULL);=0A=
+	dev =3D dev_alloc ((struct ohci *) usb_dev->bus->hcpriv, ALLOC_FLAGS);=0A=
 	if (!dev)=0A=
 		return -ENOMEM;=0A=
-		=0A=
-	memset (dev, 0, sizeof (*dev));=0A=
 =0A=
 	usb_dev->hcpriv =3D dev;=0A=
-=0A=
 	return 0;=0A=
 }=0A=
 =0A=
@@ -783,7 +777,7 @@=0A=
 	}=0A=
 =0A=
 	/* free device, and associated EDs */=0A=
-	dev_free (dev);=0A=
+	dev_free (ohci, dev);=0A=
 =0A=
 	return 0;=0A=
 }=0A=
@@ -877,9 +871,9 @@=0A=
 	case PIPE_CONTROL:=0A=
 		ed->hwNextED =3D 0;=0A=
 		if (ohci->ed_controltail =3D=3D NULL) {=0A=
-			writel (virt_to_bus (ed), &ohci->regs->ed_controlhead);=0A=
+			writel (ed->dma, &ohci->regs->ed_controlhead);=0A=
 		} else {=0A=
-			ohci->ed_controltail->hwNextED =3D cpu_to_le32 (virt_to_bus (ed));=0A=
+			ohci->ed_controltail->hwNextED =3D cpu_to_le32 (ed->dma);=0A=
 		}=0A=
 		ed->ed_prev =3D ohci->ed_controltail;=0A=
 		if (!ohci->ed_controltail && !ohci->ed_rm_list[0] &&=0A=
@@ -893,9 +887,9 @@=0A=
 	case PIPE_BULK:=0A=
 		ed->hwNextED =3D 0;=0A=
 		if (ohci->ed_bulktail =3D=3D NULL) {=0A=
-			writel (virt_to_bus (ed), &ohci->regs->ed_bulkhead);=0A=
+			writel (ed->dma, &ohci->regs->ed_bulkhead);=0A=
 		} else {=0A=
-			ohci->ed_bulktail->hwNextED =3D cpu_to_le32 (virt_to_bus (ed));=0A=
+			ohci->ed_bulktail->hwNextED =3D cpu_to_le32 (ed->dma);=0A=
 		}=0A=
 		ed->ed_prev =3D ohci->ed_bulktail;=0A=
 		if (!ohci->ed_bulktail && !ohci->ed_rm_list[0] &&=0A=
@@ -920,7 +914,7 @@=0A=
 				ed_p =3D &(((ed_t *) bus_to_virt (le32_to_cpup (ed_p)))->hwNextED)) =0A=
 					inter =3D ep_rev (6, ((ed_t *) bus_to_virt (le32_to_cpup =
(ed_p)))->int_interval);=0A=
 			ed->hwNextED =3D *ed_p; =0A=
-			*ed_p =3D cpu_to_le32 (virt_to_bus (ed));=0A=
+			*ed_p =3D cpu_to_le32 (ed->dma);=0A=
 		}=0A=
 #ifdef DEBUG=0A=
 		ep_print_int_eds (ohci, "LINK_INT");=0A=
@@ -931,7 +925,7 @@=0A=
 		ed->hwNextED =3D 0;=0A=
 		ed->int_interval =3D 1;=0A=
 		if (ohci->ed_isotail !=3D NULL) {=0A=
-			ohci->ed_isotail->hwNextED =3D cpu_to_le32 (virt_to_bus (ed));=0A=
+			ohci->ed_isotail->hwNextED =3D cpu_to_le32 (ed->dma);=0A=
 			ed->ed_prev =3D ohci->ed_isotail;=0A=
 		} else {=0A=
 			for ( i =3D 0; i < 32; i +=3D inter) {=0A=
@@ -940,7 +934,7 @@=0A=
 					*ed_p !=3D 0; =0A=
 					ed_p =3D &(((ed_t *) bus_to_virt (le32_to_cpup =
(ed_p)))->hwNextED)) =0A=
 						inter =3D ep_rev (6, ((ed_t *) bus_to_virt (le32_to_cpup =
(ed_p)))->int_interval);=0A=
-				*ed_p =3D cpu_to_le32 (virt_to_bus (ed));	=0A=
+				*ed_p =3D cpu_to_le32 (ed->dma);	=0A=
 			}	=0A=
 			ed->ed_prev =3D NULL;=0A=
 		}	=0A=
@@ -1066,7 +1060,13 @@=0A=
  * in all other cases the state is left unchanged=0A=
  * the ed info fields are setted anyway even though most of them should =
not change */=0A=
  =0A=
-static ed_t * ep_add_ed (struct usb_device * usb_dev, unsigned int =
pipe, int interval, int load)=0A=
+static ed_t * ep_add_ed (=0A=
+	struct usb_device * usb_dev,=0A=
+	unsigned int pipe,=0A=
+	int interval,=0A=
+	int load,=0A=
+	int mem_flags=0A=
+)=0A=
 {=0A=
    	ohci_t * ohci =3D usb_dev->bus->hcpriv;=0A=
 	td_t * td;=0A=
@@ -1089,13 +1089,13 @@=0A=
 	if (ed->state =3D=3D ED_NEW) {=0A=
 		ed->hwINFO =3D cpu_to_le32 (OHCI_ED_SKIP); /* skip ed */=0A=
   		/* dummy td; end of td list for ed */=0A=
-		td =3D td_alloc (ohci);=0A=
+		td =3D td_alloc (ohci, mem_flags);=0A=
   		if (!td) {=0A=
 			/* out of memory */=0A=
 			spin_unlock_irqrestore (&usb_ed_lock, flags);=0A=
 			return NULL;=0A=
 		}=0A=
-		ed->hwTailP =3D cpu_to_le32 (virt_to_bus (td));=0A=
+		ed->hwTailP =3D cpu_to_le32 (td->td_dma);=0A=
 		ed->hwHeadP =3D ed->hwTailP;	=0A=
 		ed->state =3D ED_UNLINK;=0A=
 		ed->type =3D usb_pipetype (pipe);=0A=
@@ -1164,7 +1164,7 @@=0A=
  * TD handling functions=0A=
  =
*------------------------------------------------------------------------=
-*/=0A=
 =0A=
-/* prepare a TD */=0A=
+/* enqueue next TD for this URB (OHCI spec 5.2.8.2) */=0A=
 =0A=
 static void td_fill (unsigned int info, void * data, int len, urb_t * =
urb, int index)=0A=
 {=0A=
@@ -1176,7 +1176,10 @@=0A=
 		return;=0A=
 	}=0A=
 	=0A=
+	/* use this td as the next dummy */=0A=
 	td_pt =3D urb_priv->td [index];=0A=
+	td_pt->hwNextTD =3D 0;=0A=
+=0A=
 	/* fill the old dummy TD */=0A=
 	td =3D urb_priv->td [index] =3D (td_t *)=0A=
 		bus_to_virt (le32_to_cpup (&urb_priv->ed->hwTailP) & 0xfffffff0);=0A=
@@ -1198,9 +1201,11 @@=0A=
 	td->hwBE =3D cpu_to_le32 ((!data || !len )=0A=
 		? 0=0A=
 		: virt_to_bus (data + len - 1));=0A=
-	td->hwNextTD =3D cpu_to_le32 (virt_to_bus (td_pt));=0A=
+	td->hwNextTD =3D cpu_to_le32 (td_pt->td_dma);=0A=
+=0A=
 	td->hwPSW [0] =3D cpu_to_le16 ((virt_to_bus (data) & 0x0FFF) | 0xE000);=0A=
-	td_pt->hwNextTD =3D 0;=0A=
+=0A=
+	/* append to queue */=0A=
 	td->ed->hwTailP =3D td->hwNextTD;=0A=
 }=0A=
 =0A=
@@ -1765,9 +1770,6 @@=0A=
 	wIndex        =3D le16_to_cpu (cmd->index);=0A=
 	wLength       =3D le16_to_cpu (cmd->length);=0A=
 =0A=
-	dbg ("rh_submit_urb, req =3D %d(%x) len=3D%d", bmRType_bReq,=0A=
-		bmRType_bReq, wLength);=0A=
-=0A=
 	switch (bmRType_bReq) {=0A=
 	/* Request Destination:=0A=
 	   without flags: Device, =0A=
@@ -2199,6 +2201,8 @@=0A=
 =0A=
 	list_del (&ohci->ohci_hcd_list);=0A=
 	INIT_LIST_HEAD (&ohci->ohci_hcd_list);=0A=
+=0A=
+	ohci_mem_cleanup (ohci);=0A=
     =0A=
 	/* unmap the IO address space */=0A=
 	iounmap (ohci->regs);=0A=
@@ -2221,6 +2225,7 @@=0A=
 	ohci_t * ohci;=0A=
 	u8 latency, limit;=0A=
 	char buf[8], *bufp =3D buf;=0A=
+	int ret;=0A=
 =0A=
 #ifndef __sparc__=0A=
 	sprintf(buf, "%d", irq);=0A=
@@ -2235,6 +2240,10 @@=0A=
 	if (!ohci) {=0A=
 		return -ENOMEM;=0A=
 	}=0A=
+	if ((ret =3D ohci_mem_init (ohci)) < 0) {=0A=
+		hc_release_ohci (ohci);=0A=
+		return ret;=0A=
+	}=0A=
 =0A=
 	/* bad pci latencies can contribute to overruns */ =0A=
 	pci_read_config_byte (dev, PCI_LATENCY_TIMER, &latency);=0A=
@@ -2566,11 +2575,7 @@=0A=
 {=0A=
 	int ret;=0A=
 =0A=
-	if ((ret =3D ohci_mem_init ()) < 0)=0A=
-		return ret;=0A=
-=0A=
 	if ((ret =3D pci_module_init (&ohci_pci_driver)) < 0) {=0A=
-		ohci_mem_cleanup ();=0A=
 		return ret;=0A=
 	}=0A=
 =0A=
@@ -2588,7 +2593,6 @@=0A=
 	pmu_unregister_sleep_notifier (&ohci_sleep_notifier);=0A=
 #endif  =0A=
 	pci_unregister_driver (&ohci_pci_driver);=0A=
-	ohci_mem_cleanup ();=0A=
 }=0A=
 =0A=
 module_init (ohci_hcd_init);=0A=

------=_NextPart_000_188E_01C0B390.70A073C0
Content-Type: application/octet-stream;
	name="uhci-0323.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="uhci-0323.patch"

--- drivers/usb/usb-uhci-orig.h	Mon May 15 12:05:15 2000=0A=
+++ drivers/usb/usb-uhci.h	Thu Mar 22 21:39:06 2001=0A=
@@ -212,7 +212,10 @@=0A=
 	struct list_head urb_unlinked;	// list of all unlinked  urbs=0A=
 	long timeout_check;=0A=
 	int timeout_urbs;=0A=
+#ifdef	CONFIG_PCI=0A=
 	struct pci_dev *uhci_pci;=0A=
+	struct pci_pool *desc_pool;=0A=
+#endif=0A=
 } uhci_t, *puhci_t;=0A=
 =0A=
 =0A=
--- drivers/usb/usb-uhci-orig.c	Wed Mar 14 12:40:36 2001=0A=
+++ drivers/usb/usb-uhci.c	Fri Mar 23 10:12:27 2001=0A=
@@ -7,7 +7,7 @@=0A=
  *               Roman Weissgaerber, weissg@vienna.at (virt root hub) =
(studio porter)=0A=
  * (c) 2000      Yggdrasil Computing, Inc. (port of new PCI interface =
support=0A=
  *               from usb-ohci.c by Adam Richter, adam@yggdrasil.com).=0A=
- * (C) 2000      David Brownell, david-b@pacbell.net (usb-ohci.c)=0A=
+ * (C) 2000-2001 David Brownell, david-b@pacbell.net (pci from =
usb-ohci.c, pci_pool)=0A=
  *          =0A=
  * HW-initalization based on material of=0A=
  *=0A=
@@ -44,7 +44,7 @@=0A=
 //#define ISO_SANITY_CHECK=0A=
 =0A=
 /* This enables debug printks */=0A=
-#define DEBUG=0A=
+#undef DEBUG=0A=
 =0A=
 /* This enables all symbols to be exported, to ease debugging oopses */=0A=
 //#define DEBUG_SYMBOLS=0A=
@@ -58,10 +58,6 @@=0A=
 #include "usb-uhci.h"=0A=
 #include "usb-uhci-debug.h"=0A=
 =0A=
-#undef DEBUG=0A=
-#undef dbg=0A=
-#define dbg(format, arg...) do {} while (0)=0A=
-#define DEBUG_SYMBOLS=0A=
 #ifdef DEBUG_SYMBOLS=0A=
 	#define _static=0A=
 	#ifndef EXPORT_SYMTAB=0A=
@@ -75,7 +71,6 @@=0A=
 #define async_dbg dbg //err=0A=
 =0A=
 #ifdef DEBUG_SLAB=0A=
-	static kmem_cache_t *uhci_desc_kmem;=0A=
 	static kmem_cache_t *urb_priv_kmem;=0A=
 #endif=0A=
 =0A=
@@ -226,10 +221,11 @@=0A=
 =0A=
 }=0A=
 /*-------------------------------------------------------------------*/=0A=
-_static int alloc_td (uhci_desc_t ** new, int flags)=0A=
+_static int alloc_td (uhci_t *s, uhci_desc_t ** new, int flags)=0A=
 {=0A=
-#ifdef DEBUG_SLAB=0A=
-	*new=3D kmem_cache_alloc(uhci_desc_kmem, SLAB_FLAG);=0A=
+#ifdef CONFIG_PCI=0A=
+	dma_addr_t	dma;=0A=
+	*new=3D pci_pool_alloc (s->desc_pool, SLAB_FLAG, &dma);=0A=
 #else=0A=
 	*new =3D (uhci_desc_t *) kmalloc (sizeof (uhci_desc_t), KMALLOC_FLAG);=0A=
 #endif=0A=
@@ -340,10 +336,10 @@=0A=
 }=0A=
 =0A=
 /*-------------------------------------------------------------------*/=0A=
-_static int delete_desc (uhci_desc_t *element)=0A=
+_static int delete_desc (uhci_t *s, uhci_desc_t *element)=0A=
 {=0A=
-#ifdef DEBUG_SLAB=0A=
-	kmem_cache_free(uhci_desc_kmem, element);=0A=
+#ifdef CONFIG_PCI=0A=
+	pci_pool_free(s->desc_pool, element, virt_to_bus (element));=0A=
 #else=0A=
 	kfree (element);=0A=
 #endif=0A=
@@ -351,10 +347,11 @@=0A=
 }=0A=
 /*-------------------------------------------------------------------*/=0A=
 // Allocates qh element=0A=
-_static int alloc_qh (uhci_desc_t ** new)=0A=
+_static int alloc_qh (uhci_t *s, uhci_desc_t ** new)=0A=
 {=0A=
-#ifdef DEBUG_SLAB=0A=
-	*new=3D kmem_cache_alloc(uhci_desc_kmem, SLAB_FLAG);=0A=
+#ifdef CONFIG_PCI=0A=
+	dma_addr_t	dma;=0A=
+	*new=3D pci_pool_alloc (s->desc_pool, SLAB_FLAG, &dma);=0A=
 #else=0A=
 	*new =3D (uhci_desc_t *) kmalloc (sizeof (uhci_desc_t), KMALLOC_FLAG);=0A=
 #endif	=0A=
@@ -439,15 +436,15 @@=0A=
 		td =3D list_entry (p, uhci_desc_t, vertical);=0A=
 		dbg("unlink td @ %p",td);=0A=
 		unlink_td (s, td, 0); // no physical unlink=0A=
-		delete_desc (td);=0A=
+		delete_desc (s, td);=0A=
 	}=0A=
 =0A=
-	delete_desc (qh);=0A=
+	delete_desc (s, qh);=0A=
 	=0A=
 	return 0;=0A=
 }=0A=
 /*-------------------------------------------------------------------*/=0A=
-_static void clean_td_chain (uhci_desc_t *td)=0A=
+_static void clean_td_chain (uhci_t *s, uhci_desc_t *td)=0A=
 {=0A=
 	struct list_head *p;=0A=
 	uhci_desc_t *td1;=0A=
@@ -457,10 +454,10 @@=0A=
 	=0A=
 	while ((p =3D td->horizontal.next) !=3D &td->horizontal) {=0A=
 		td1 =3D list_entry (p, uhci_desc_t, horizontal);=0A=
-		delete_desc (td1);=0A=
+		delete_desc (s, td1);=0A=
 	}=0A=
 	=0A=
-	delete_desc (td);=0A=
+	delete_desc (s, td);=0A=
 }=0A=
 =0A=
 /*-------------------------------------------------------------------*/=0A=
@@ -485,18 +482,18 @@=0A=
 	if (s->td32ms) {=0A=
 	=0A=
 		unlink_td(s,s->td32ms,1);=0A=
-		delete_desc(s->td32ms);=0A=
+		delete_desc(s, s->td32ms);=0A=
 	}=0A=
 =0A=
 	for (n =3D 0; n < 8; n++) {=0A=
 		td =3D s->int_chain[n];=0A=
-		clean_td_chain (td);=0A=
+		clean_td_chain (s, td);=0A=
 	}=0A=
 =0A=
 	if (s->iso_td) {=0A=
 		for (n =3D 0; n < 1024; n++) {=0A=
 			td =3D s->iso_td[n];=0A=
-			clean_td_chain (td);=0A=
+			clean_td_chain (s, td);=0A=
 		}=0A=
 		kfree (s->iso_td);=0A=
 	}=0A=
@@ -519,13 +516,13 @@=0A=
 	}=0A=
 	else {=0A=
 		if (s->ls_control_chain)=0A=
-			delete_desc (s->ls_control_chain);=0A=
+			delete_desc (s, s->ls_control_chain);=0A=
 		if (s->control_chain)=0A=
-			 delete_desc(s->control_chain);=0A=
+			 delete_desc(s, s->control_chain);=0A=
 		if (s->bulk_chain)=0A=
-			delete_desc (s->bulk_chain);=0A=
+			delete_desc (s, s->bulk_chain);=0A=
 		if (s->chain_end)=0A=
-			delete_desc (s->chain_end);=0A=
+			delete_desc (s, s->chain_end);=0A=
 	}=0A=
 	dbg("cleanup_skel finished");	=0A=
 }=0A=
@@ -560,7 +557,7 @@=0A=
 	dbg("allocating iso descs");=0A=
 	for (n =3D 0; n < 1024; n++) {=0A=
 	 	// allocate skeleton iso/irq-tds=0A=
-		ret =3D alloc_td (&td, 0);=0A=
+		ret =3D alloc_td (s, &td, 0);=0A=
 		if (ret)=0A=
 			goto init_skel_cleanup;=0A=
 		s->iso_td[n] =3D td;=0A=
@@ -568,14 +565,14 @@=0A=
 	}=0A=
 =0A=
 	dbg("allocating qh: chain_end");=0A=
-	ret =3D alloc_qh (&qh);=0A=
+	ret =3D alloc_qh (s, &qh);=0A=
 	=0A=
 	if (ret)=0A=
 		goto init_skel_cleanup;=0A=
 				=0A=
 	s->chain_end =3D qh;=0A=
 =0A=
-	ret =3D alloc_td (&td, 0);=0A=
+	ret =3D alloc_td (s, &td, 0);=0A=
 =0A=
 	if (ret)=0A=
 		goto init_skel_cleanup;=0A=
@@ -586,7 +583,7 @@=0A=
 	s->td1ms=3Dtd;=0A=
 =0A=
 	dbg("allocating qh: bulk_chain");=0A=
-	ret =3D alloc_qh (&qh);=0A=
+	ret =3D alloc_qh (s, &qh);=0A=
 	if (ret)=0A=
 		goto init_skel_cleanup;=0A=
 	=0A=
@@ -594,7 +591,7 @@=0A=
 	s->bulk_chain =3D qh;=0A=
 =0A=
 	dbg("allocating qh: control_chain");=0A=
-	ret =3D alloc_qh (&qh);=0A=
+	ret =3D alloc_qh (s, &qh);=0A=
 	if (ret)=0A=
 		goto init_skel_cleanup;=0A=
 	=0A=
@@ -607,7 +604,7 @@=0A=
 #endif=0A=
 =0A=
 	dbg("allocating qh: ls_control_chain");=0A=
-	ret =3D alloc_qh (&qh);=0A=
+	ret =3D alloc_qh (s, &qh);=0A=
 	if (ret)=0A=
 		goto init_skel_cleanup;=0A=
 	=0A=
@@ -622,7 +619,7 @@=0A=
 	for (n =3D 0; n < 8; n++) {=0A=
 		uhci_desc_t *td;=0A=
 =0A=
-		alloc_td (&td, 0);=0A=
+		alloc_td (s, &td, 0);=0A=
 		if (!td)=0A=
 			goto init_skel_cleanup;=0A=
 		s->int_chain[n] =3D td;=0A=
@@ -639,7 +636,7 @@=0A=
 	for (n =3D 0; n < 1024; n++) {=0A=
 		// link all iso-tds to the interrupt chains=0A=
 		int m, o;=0A=
-		dbg("framelist[%i]=3D%x",n,s->framelist[n]);=0A=
+		// dbg("framelist[%i]=3D%x",n,s->framelist[n]);=0A=
 		if ((n&127)=3D=3D127) =0A=
 			((uhci_desc_t*) s->iso_td[n])->hw.td.link =3D =
virt_to_bus(s->int_chain[0]);=0A=
 		else =0A=
@@ -648,7 +645,7 @@=0A=
 					((uhci_desc_t*) s->iso_td[n])->hw.td.link =3D virt_to_bus =
(s->int_chain[o]);=0A=
 	}=0A=
 =0A=
-	ret =3D alloc_td (&td, 0);=0A=
+	ret =3D alloc_td (s, &td, 0);=0A=
 =0A=
 	if (ret)=0A=
 		goto init_skel_cleanup;=0A=
@@ -689,12 +686,12 @@=0A=
 	}=0A=
 =0A=
 	dbg("uhci_submit_control start");=0A=
-	alloc_qh (&qh);		// alloc qh for this request=0A=
+	alloc_qh (s, &qh);		// alloc qh for this request=0A=
 =0A=
 	if (!qh)=0A=
 		return -ENOMEM;=0A=
 =0A=
-	alloc_td (&td, UHCI_PTR_DEPTH * depth_first);		// get td for setup =
stage=0A=
+	alloc_td (s, &td, UHCI_PTR_DEPTH * depth_first);		// get td for setup =
stage=0A=
 =0A=
 	if (!td) {=0A=
 		delete_qh (s, qh);=0A=
@@ -732,7 +729,7 @@=0A=
 	while (len > 0) {=0A=
 		int pktsze =3D len;=0A=
 =0A=
-		alloc_td (&td, UHCI_PTR_DEPTH * depth_first);=0A=
+		alloc_td (s, &td, UHCI_PTR_DEPTH * depth_first);=0A=
 		if (!td) {=0A=
 			delete_qh (s, qh);=0A=
 			return -ENOMEM;=0A=
@@ -764,7 +761,7 @@=0A=
 =0A=
 	destination |=3D 1 << TD_TOKEN_TOGGLE;	/* End in Data1 */=0A=
 =0A=
-	alloc_td (&td, UHCI_PTR_DEPTH);=0A=
+	alloc_td (s, &td, UHCI_PTR_DEPTH);=0A=
 	=0A=
 	if (!td) {=0A=
 		delete_qh (s, qh);=0A=
@@ -829,15 +826,15 @@=0A=
 	upriv =3D (urb_priv_t*)urb->hcpriv;=0A=
 =0A=
 	if (!bulk_urb) {=0A=
-		alloc_qh (&qh);		// get qh for this request=0A=
+		alloc_qh (s, &qh);		// get qh for this request=0A=
 		=0A=
 		if (!qh)=0A=
 			return -ENOMEM;=0A=
 =0A=
 		if (urb->transfer_flags & USB_QUEUE_BULK) {=0A=
-			alloc_qh(&nqh); // placeholder for clean unlink=0A=
+			alloc_qh(s, &nqh); // placeholder for clean unlink=0A=
 			if (!nqh) {=0A=
-				delete_desc (qh);=0A=
+				delete_desc (s, qh);=0A=
 				return -ENOMEM;=0A=
 			}=0A=
 			upriv->next_qh =3D nqh;=0A=
@@ -853,12 +850,12 @@=0A=
 	}=0A=
 =0A=
 	if (urb->transfer_flags & USB_QUEUE_BULK) {=0A=
-		alloc_qh (&bqh); // "bottom" QH,=0A=
+		alloc_qh (s, &bqh); // "bottom" QH,=0A=
 		=0A=
 		if (!bqh) {=0A=
 			if (!bulk_urb) { =0A=
-				delete_desc(qh);=0A=
-				delete_desc(nqh);=0A=
+				delete_desc(s, qh);=0A=
+				delete_desc(s, nqh);=0A=
 			}=0A=
 			return -ENOMEM;=0A=
 		}=0A=
@@ -882,7 +879,7 @@=0A=
 	do {					// TBD: Really allow zero-length packets?=0A=
 		int pktsze =3D len;=0A=
 =0A=
-		alloc_td (&td, UHCI_PTR_DEPTH * depth_first);=0A=
+		alloc_td (s, &td, UHCI_PTR_DEPTH * depth_first);=0A=
 =0A=
 		if (!td) {=0A=
 			delete_qh (s, qh);=0A=
@@ -962,9 +959,9 @@=0A=
 	uhci_desc_t *td;=0A=
 =0A=
 	while ((p =3D urb_priv->desc_list.next) !=3D &urb_priv->desc_list) {=0A=
-				td =3D list_entry (p, uhci_desc_t, desc_list);=0A=
-				list_del (p);=0A=
-				delete_desc (td);=0A=
+		td =3D list_entry (p, uhci_desc_t, desc_list);=0A=
+		list_del (p);=0A=
+		delete_desc (s, td);=0A=
 	}=0A=
 }=0A=
 /*-------------------------------------------------------------------*/=0A=
@@ -1449,7 +1446,7 @@=0A=
 	if (urb->transfer_buffer_length > usb_maxpacket (urb->dev, pipe, =
usb_pipeout (pipe)))=0A=
 		return -EINVAL;=0A=
 =0A=
-	ret =3D alloc_td (&td, UHCI_PTR_DEPTH);=0A=
+	ret =3D alloc_td (s, &td, UHCI_PTR_DEPTH);=0A=
 =0A=
 	if (ret)=0A=
 		return -ENOMEM;=0A=
@@ -1521,14 +1518,14 @@=0A=
 		}=0A=
 		else=0A=
 #endif=0A=
-		ret =3D alloc_td (&td, UHCI_PTR_DEPTH);=0A=
+		ret =3D alloc_td (s, &td, UHCI_PTR_DEPTH);=0A=
 =0A=
 		if (ret) {=0A=
 			int i;	// Cleanup allocated TDs=0A=
 =0A=
 			for (i =3D 0; i < n; n++)=0A=
 				if (tdm[i])=0A=
-					 delete_desc(tdm[i]);=0A=
+					 delete_desc(s, tdm[i]);=0A=
 			kfree (tdm);=0A=
 			goto err;=0A=
 		}=0A=
@@ -2511,7 +2508,7 @@=0A=
 =0A=
 		list_del (p);=0A=
 		p =3D p->next;=0A=
-		delete_desc (desc);=0A=
+		delete_desc (s, desc);=0A=
 	}=0A=
 	=0A=
 	dbg("process_iso: exit %i (%d), actual_len %i", i, =
ret,urb->actual_length);=0A=
@@ -2566,6 +2563,7 @@=0A=
 #else=0A=
 		kfree (urb->hcpriv);=0A=
 #endif=0A=
+		urb->hcpriv =3D 0;=0A=
 =0A=
 		if ((usb_pipetype (urb->pipe) !=3D PIPE_INTERRUPT)) {  // =
process_interrupt does completion on its own		=0A=
 			urb_t *next_urb =3D urb->next;=0A=
@@ -2625,19 +2623,22 @@=0A=
 =0A=
 			// Completion=0A=
 			if (urb->complete) {=0A=
+				int was_unlinked =3D (urb->status =3D=3D -ENOENT);=0A=
 				urb->dev =3D NULL;=0A=
 				spin_unlock(&s->urb_list_lock);=0A=
 				urb->complete ((struct urb *) urb);=0A=
 				// Re-submit the URB if ring-linked=0A=
-				if (is_ring && (urb->status !=3D -ENOENT) && !contains_killed) {=0A=
+				if (is_ring && !was_unlinked && !contains_killed) {=0A=
 					urb->dev=3Dusb_dev;=0A=
 					uhci_submit_urb (urb);=0A=
-				}=0A=
+				} else=0A=
+					urb =3D 0;=0A=
 				spin_lock(&s->urb_list_lock);=0A=
 			}=0A=
 			=0A=
 			usb_dec_dev_use (usb_dev);=0A=
-			spin_unlock(&urb->lock);		=0A=
+			if (urb)=0A=
+				spin_unlock(&urb->lock);		=0A=
 		}=0A=
 	}=0A=
 =0A=
@@ -2791,6 +2792,11 @@=0A=
 	free_irq (s->irq, s);=0A=
 	usb_free_bus (s->bus);=0A=
 	cleanup_skel (s);=0A=
+=0A=
+#ifdef CONFIG_PCI=0A=
+	pci_pool_destroy(s->desc_pool);=0A=
+#endif=0A=
+=0A=
 	kfree (s);=0A=
 }=0A=
 =0A=
@@ -2840,6 +2846,7 @@=0A=
 #endif=0A=
 	printk(KERN_INFO __FILE__ ": USB UHCI at I/O 0x%x, IRQ %s\n",=0A=
 		io_addr, bufp);=0A=
+	printk(KERN_INFO __FILE__ ": usb-%s, %s\n", dev->slot_name, dev->name);=0A=
 =0A=
 	s =3D kmalloc (sizeof (uhci_t), GFP_KERNEL);=0A=
 	if (!s)=0A=
@@ -2860,8 +2867,33 @@=0A=
 	s->timeout_check =3D 0;=0A=
 	s->uhci_pci=3Ddev;=0A=
 =0A=
+#ifdef CONFIG_PCI=0A=
+=0A=
+	s->desc_pool =3D pci_pool_create("uhci_desc", dev,=0A=
+		sizeof(uhci_desc_t),=0A=
+		16 /* byte alignment */,=0A=
+		0 /* no page-crossing issues */,=0A=
+		SLAB_KERNEL);=0A=
+	=0A=
+	if(!s->desc_pool) {=0A=
+		err("pci_pool_create for uhci_desc failed (out of memory)");=0A=
+		goto pci1;=0A=
+	}=0A=
+=0A=
+#endif	=0A=
+	info(VERSTR);=0A=
+=0A=
+#ifdef CONFIG_USB_UHCI_HIGH_BANDWIDTH=0A=
+	info("High bandwidth mode enabled");	=0A=
+#endif=0A=
+=0A=
 	bus =3D usb_alloc_bus (&uhci_device_operations);=0A=
 	if (!bus) {=0A=
+exit3:=0A=
+#ifdef CONFIG_PCI=0A=
+		pci_pool_destroy(s->desc_pool);=0A=
+pci1:=0A=
+#endif=0A=
 		kfree (s);=0A=
 		return -1;=0A=
 	}=0A=
@@ -2896,9 +2928,9 @@=0A=
 	s->rh.numports =3D s->maxports;=0A=
 	s->loop_usage=3D0;=0A=
 	if (init_skel (s)) {=0A=
+exit4:=0A=
 		usb_free_bus (bus);=0A=
-		kfree(s);=0A=
-		return -1;=0A=
+		goto exit3;=0A=
 	}=0A=
 =0A=
 	request_region (s->io_addr, io_size, MODNAME);=0A=
@@ -2913,8 +2945,7 @@=0A=
 		reset_hc (s);=0A=
 		release_region (s->io_addr, s->io_size);=0A=
 		cleanup_skel(s);=0A=
-		kfree(s);=0A=
-		return -1;=0A=
+		goto exit4;=0A=
 	}=0A=
 =0A=
 	/* Enable PIRQ */=0A=
@@ -2924,7 +2955,7 @@=0A=
 =0A=
 	if(uhci_start_usb (s) < 0) {=0A=
 		uhci_pci_remove(dev);=0A=
-		return -1;=0A=
+		return -ENODEV;=0A=
 	}=0A=
 =0A=
 	//chain new uhci device into global list=0A=
@@ -3001,53 +3032,27 @@=0A=
 {=0A=
 	int retval;=0A=
 =0A=
-#ifdef DEBUG_SLAB=0A=
-=0A=
-	uhci_desc_kmem =3D kmem_cache_create("uhci_desc", sizeof(uhci_desc_t), =
0, SLAB_HWCACHE_ALIGN, NULL, NULL);=0A=
-	=0A=
-	if(!uhci_desc_kmem) {=0A=
-		err("kmem_cache_create for uhci_desc failed (out of memory)");=0A=
-		return -ENOMEM;=0A=
-	}=0A=
-=0A=
-	urb_priv_kmem =3D kmem_cache_create("urb_priv", sizeof(urb_priv_t), 0, =
SLAB_HWCACHE_ALIGN, NULL, NULL);=0A=
-	=0A=
-	if(!urb_priv_kmem) {=0A=
-		err("kmem_cache_create for urb_priv_t failed (out of memory)");=0A=
-		kmem_cache_destroy(uhci_desc_kmem);=0A=
+#ifdef	DEBUG_SLAB=0A=
+	urb_priv_kmem =3D kmem_cache_create ("uhci_urb_priv",=0A=
+		sizeof (urb_priv_t), 0,=0A=
+		SLAB_HWCACHE_ALIGN, NULL, NULL);=0A=
+	if (!urb_priv_kmem)=0A=
 		return -ENOMEM;=0A=
-	}=0A=
-#endif	=0A=
-	info(VERSTR);=0A=
-=0A=
-#ifdef CONFIG_USB_UHCI_HIGH_BANDWIDTH=0A=
-	info("High bandwidth mode enabled");	=0A=
 #endif=0A=
-=0A=
 	retval =3D pci_module_init (&uhci_pci_driver);=0A=
-=0A=
-#ifdef DEBUG_SLAB=0A=
-	if (retval < 0 ) {=0A=
-		if (kmem_cache_destroy(urb_priv_kmem))=0A=
-			err("urb_priv_kmem remained");=0A=
-		if (kmem_cache_destroy(uhci_desc_kmem))=0A=
-			err("uhci_desc_kmem remained");=0A=
-	}=0A=
+#ifdef	DEBUG_SLAB=0A=
+	if (retval)=0A=
+		kmem_cache_destroy (urb_priv_kmem);=0A=
 #endif=0A=
-	=0A=
 	return retval;=0A=
 }=0A=
 =0A=
 static void __exit uhci_hcd_cleanup (void) =0A=
 {      =0A=
 	pci_unregister_driver (&uhci_pci_driver);=0A=
-	=0A=
-#ifdef DEBUG_SLAB=0A=
-	if(kmem_cache_destroy(uhci_desc_kmem))=0A=
-		err("uhci_desc_kmem remained");=0A=
-=0A=
-	if(kmem_cache_destroy(urb_priv_kmem))=0A=
-		err("urb_priv_kmem remained");=0A=
+#ifdef	DEBUG_SLAB=0A=
+	if (urb_priv_kmem && kmem_cache_destroy (urb_priv_kmem))=0A=
+		err ("urb_priv cache not empty");=0A=
 #endif=0A=
 }=0A=
 =0A=
--- drivers/usb/usb-uhci-debug-orig.h	Sat Jul  8 19:38:16 2000=0A=
+++ drivers/usb/usb-uhci-debug.h	Thu Mar 22 21:39:06 2001=0A=
@@ -23,7 +23,7 @@=0A=
 }=0A=
 #endif=0A=
 =0A=
-static void uhci_show_td (puhci_desc_t td)=0A=
+static void __attribute__((__unused__)) uhci_show_td (puhci_desc_t td)=0A=
 {=0A=
 	char *spid;=0A=
 	=0A=

------=_NextPart_000_188E_01C0B390.70A073C0--

