Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUELVqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUELVqW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 17:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbUELVqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 17:46:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20675 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261867AbUELVl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 17:41:29 -0400
Date: Wed, 12 May 2004 17:41:14 -0400
From: Alan Cox <alan@redhat.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: PATCH: revised aacraid driver patch
Message-ID: <20040512214114.GA25665@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a problem with AMD64 iommu compatibility and now (with the 
block layer patch) passes the test sets on a dual opteron. 

Alan


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.6/drivers/scsi/aacraid/aacraid.h linux-2.6.6/drivers/scsi/aacraid/aacraid.h
--- linux.vanilla-2.6.6/drivers/scsi/aacraid/aacraid.h	2004-05-10 03:32:26.000000000 +0100
+++ linux-2.6.6/drivers/scsi/aacraid/aacraid.h	2004-05-11 20:20:48.000000000 +0100
@@ -1,18 +1,20 @@
-//#define dprintk(x) printk x
-#define dprintk(x)
+#if (!defined(dprintk))
+# define dprintk(x)
+#endif
 
 /*------------------------------------------------------------------------------
  *              D E F I N E S
  *----------------------------------------------------------------------------*/
+
 #define MAXIMUM_NUM_CONTAINERS	31
 #define MAXIMUM_NUM_ADAPTERS	8
 
-#define AAC_NUM_FIB	578
+#define AAC_NUM_FIB		578
 //#define AAC_NUM_IO_FIB	512
-#define AAC_NUM_IO_FIB	100
+#define AAC_NUM_IO_FIB		100
 
-#define AAC_MAX_TARGET (MAXIMUM_NUM_CONTAINERS+1)
-#define AAC_MAX_LUN	(8)
+#define AAC_MAX_TARGET 		(MAXIMUM_NUM_CONTAINERS+1)
+#define AAC_MAX_LUN		(8)
 
 #define AAC_MAX_HOSTPHYSMEMPAGES (0xfffff)
 
@@ -241,92 +243,6 @@
 };
 
 /*
- * Implement our own version of these so we have 64 bit compatability
- * The adapter uses these and can only handle 32 bit addresses
- */
-
-struct aac_list_head {
-	u32 next;
-	u32 prev;
-};
-
-#define AAC_INIT_LIST_HEAD(ptr) do { \
-	(ptr)->next = (u32)(ulong)(ptr); \
-	(ptr)->prev = (u32)(ulong)(ptr); \
-} while (0)
-/**
- * aac_list_empty - tests whether a list is empty
- * @head: the list to test.
- */
-static __inline__ int aac_list_empty(struct aac_list_head *head)
-{
-	return head->next == ((u32)(ulong)head);
-}
-
-/*
- * Insert a new entry between two known consecutive entries. 
- *
- * This is only for internal list manipulation where we know
- * the prev/next entries already!
- */
-static __inline__ void aac_list_add(struct aac_list_head * n,
-	struct aac_list_head * prev,
-	struct aac_list_head * next)
-{
-	next->prev = (u32)(ulong)n;
-	n->next = (u32)(ulong)next;
-	n->prev = (u32)(ulong)prev;
-	prev->next = (u32)(ulong)n;
-}
-
-/**
- * list_add_tail - add a new entry
- * @new: new entry to be added
- * @head: list head to add it before
- *
- * Insert a new entry before the specified head.
- * This is useful for implementing queues.
- */
-static __inline__ void aac_list_add_tail(struct aac_list_head *n, struct aac_list_head *head)
-{
-	aac_list_add(n, (struct aac_list_head*)(ulong)(head->prev), head);
-}
-
-/*
- * Delete a list entry by making the prev/next entries
- * point to each other.
- *
- * This is only for internal list manipulation where we know
- * the prev/next entries already!
- */
-static __inline__ void __aac_list_del(struct aac_list_head * p,
-				  struct aac_list_head * n)
-{
-	n->prev = (u32)(ulong)p;
-	p->next = (u32)(ulong)n;
-}
-
-/**
- * aac_list_del - deletes entry from list.
- * @entry: the element to delete from the list.
- * Note: list_empty on entry does not return true after this, the entry is in an undefined state.
- */
-static __inline__ void aac_list_del(struct aac_list_head *entry)
-{
-	__aac_list_del((struct aac_list_head*)(ulong)entry->prev,(struct aac_list_head*)(ulong) entry->next);
-	entry->next = entry->prev = 0;
-}
-
-/**
- * aac_list_entry - get the struct for this entry
- * @ptr:	the &struct list_head pointer.
- * @type:	the type of the struct this is embedded in.
- * @member:	the name of the list_struct within the struct.
- */
-#define aac_list_entry(ptr, type, member) \
-	((type *)((char *)(ptr)-(ulong)(&((type *)0)->member)))
-
-/*
  *	Assign type values to the FSA communication data structures
  */
 
@@ -339,11 +255,11 @@
 #define		FsaNormal	1
 #define		FsaHigh		2
 
-
 /*
  * Define the FIB. The FIB is the where all the requested data and
  * command information are put to the application on the FSA adapter.
  */
+
 struct aac_fibhdr {
 	u32 XferState;			// Current transfer state for this CCB
 	u16 Command;			// Routing information for the destination
@@ -359,13 +275,9 @@
 		    u32 _ReceiverTimeStart; 	// Timestamp for receipt of fib
 		    u32 _ReceiverTimeDone;	// Timestamp for completion of fib
 		} _s;
-		struct aac_list_head _FibLinks;	// Used to link Adapter Initiated Fibs on the host
-//		struct list_head _FibLinks;	// Used to link Adapter Initiated Fibs on the host
 	} _u;
 };
 
-#define FibLinks			_u._FibLinks
-
 #define FIB_DATA_SIZE_IN_BYTES (512 - sizeof(struct aac_fibhdr))
 
 
@@ -558,12 +470,11 @@
 	spinlock_t		lockdata;	/* Actual lock (used only on one side of the lock) */
 	unsigned long		SavedIrql;     	/* Previous IRQL when the spin lock is taken */
 	u32			padding;	/* Padding - FIXME - can remove I believe */
-	struct aac_list_head 	cmdq;	   	/* A queue of FIBs which need to be prcessed by the FS thread. This is */
-//	struct list_head 	cmdq;	   	/* A queue of FIBs which need to be prcessed by the FS thread. This is */
-                                		        /* only valid for command queues which receive entries from the adapter. */
-	struct list_head	pendingq;		/* A queue of outstanding fib's to the adapter. */
-	u32			numpending;		/* Number of entries on outstanding queue. */
-	struct aac_dev *	dev;			/* Back pointer to adapter structure */
+	struct list_head 	cmdq;	   	/* A queue of FIBs which need to be prcessed by the FS thread. This is */
+                                		/* only valid for command queues which receive entries from the adapter. */
+	struct list_head	pendingq;	/* A queue of outstanding fib's to the adapter. */
+	u32			numpending;	/* Number of entries on outstanding queue. */
+	struct aac_dev *	dev;		/* Back pointer to adapter structure */
 };
 
 /*
@@ -744,7 +655,7 @@
 	struct semaphore 	wait_sem;	// this is used to wait for the next fib to arrive.
 	int			wait;		// Set to true when thread is in WaitForSingleObject
 	unsigned long		count;		// total number of FIBs on FibList
-	struct aac_list_head	hw_fib_list;	// this holds hw_fibs which should be 32 bit addresses
+	struct list_head	fib_list;	// this holds fibs and their attachd hw_fibs
 };
 
 struct fsa_scsi_hba {
@@ -781,7 +692,11 @@
 	 *	Outstanding I/O queue.
 	 */
 	struct list_head	queue;
-
+	/*
+	 *	And for the internal issue/reply queues (we may be able
+	 *	to merge these two)
+	 */
+	struct list_head	fiblink;
 	void 			*data;
 	struct hw_fib		*hw_fib;		/* Actual shared object */
 	dma_addr_t		hw_fib_pa;		/* physical address of hw_fib*/
@@ -836,19 +751,19 @@
 /*
  * Supported Options
  */
-#define AAC_OPT_SNAPSHOT	cpu_to_le32(1)
-#define AAC_OPT_CLUSTERS	cpu_to_le32(1<<1)
-#define AAC_OPT_WRITE_CACHE	cpu_to_le32(1<<2)
-#define AAC_OPT_64BIT_DATA	cpu_to_le32(1<<3)
-#define AAC_OPT_HOST_TIME_FIB	cpu_to_le32(1<<4)
-#define AAC_OPT_RAID50		cpu_to_le32(1<<5)
-#define AAC_OPT_4GB_WINDOW	cpu_to_le32(1<<6)
-#define AAC_OPT_SCSI_UPGRADEABLE cpu_to_le32(1<<7)
-#define AAC_OPT_SOFT_ERR_REPORT	cpu_to_le32(1<<8)
-#define AAC_OPT_SUPPORTED_RECONDITION cpu_to_le32(1<<9)
-#define AAC_OPT_SGMAP_HOST64	cpu_to_le32(1<<10)
-#define AAC_OPT_ALARM		cpu_to_le32(1<<11)
-#define AAC_OPT_NONDASD		cpu_to_le32(1<<12)
+#define AAC_OPT_SNAPSHOT		cpu_to_le32(1)
+#define AAC_OPT_CLUSTERS		cpu_to_le32(1<<1)
+#define AAC_OPT_WRITE_CACHE		cpu_to_le32(1<<2)
+#define AAC_OPT_64BIT_DATA		cpu_to_le32(1<<3)
+#define AAC_OPT_HOST_TIME_FIB		cpu_to_le32(1<<4)
+#define AAC_OPT_RAID50			cpu_to_le32(1<<5)
+#define AAC_OPT_4GB_WINDOW		cpu_to_le32(1<<6)
+#define AAC_OPT_SCSI_UPGRADEABLE 	cpu_to_le32(1<<7)
+#define AAC_OPT_SOFT_ERR_REPORT		cpu_to_le32(1<<8)
+#define AAC_OPT_SUPPORTED_RECONDITION 	cpu_to_le32(1<<9)
+#define AAC_OPT_SGMAP_HOST64		cpu_to_le32(1<<10)
+#define AAC_OPT_ALARM			cpu_to_le32(1<<11)
+#define AAC_OPT_NONDASD			cpu_to_le32(1<<12)
 
 struct aac_dev
 {
@@ -862,11 +777,10 @@
 	 */	
 	dma_addr_t		hw_fib_pa;
 	struct hw_fib		*hw_fib_va;
-	ulong			fib_base_va;
+	struct hw_fib		*aif_base_va;
 	/*
 	 *	Fib Headers
 	 */
-// dmb	struct fib              fibs[AAC_NUM_FIB]; /* Doing it here takes up too much from the scsi pool*/
 	struct fib              *fibs;
 
 	struct fib		*free_fib;
@@ -887,7 +801,6 @@
 	unsigned long		fsrev;		/* Main driver's revision number */
 	
 	struct aac_init		*init;		/* Holds initialization info to communicate with adapter */
-//	void *			init_pa; 	/* Holds physical address of the init struct */
 	dma_addr_t		init_pa; 	/* Holds physical address of the init struct */
 	
 	struct pci_dev		*pdev;		/* Our PCI interface */
@@ -898,7 +811,7 @@
 
 	struct Scsi_Host	*scsi_host_ptr;
 	struct fsa_scsi_hba	fsa_dev;
-	int			thread_pid;
+	pid_t			thread_pid;
 	int			cardtype;
 	
 	/*
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.6/drivers/scsi/aacraid/aachba.c linux-2.6.6/drivers/scsi/aacraid/aachba.c
--- linux.vanilla-2.6.6/drivers/scsi/aacraid/aachba.c	2004-05-10 03:32:29.000000000 +0100
+++ linux-2.6.6/drivers/scsi/aacraid/aachba.c	2004-05-11 19:30:08.000000000 +0100
@@ -514,11 +514,12 @@
 		dev->nondasd_support = (nondasd!=0);
 	}
 	if(dev->nondasd_support != 0){
-		printk(KERN_INFO"%s%d: Non-DASD support enabled\n",dev->name, dev->id);
+		printk(KERN_INFO "%s%d: Non-DASD support enabled.\n",dev->name, dev->id);
 	}
 
 	dev->pae_support = 0;
 	if( (sizeof(dma_addr_t) > 4) && (dev->adapter_info.options & AAC_OPT_SGMAP_HOST64)){
+		printk(KERN_INFO "%s%d: 64bit support enabled.\n", dev->name, dev->id);
 		dev->pae_support = 1;
 	}
 
@@ -726,7 +727,10 @@
 	 *	Check that the command queued to the controller
 	 */
 	if (status == -EINPROGRESS) 
+	{
+		dprintk("read queued.\n");
 		return 0;
+	}
 		
 	printk(KERN_WARNING "aac_read: fib_send failed with status: %d.\n", status);
 	/*
@@ -832,7 +836,10 @@
 	 *	Check that the command queued to the controller
 	 */
 	if (status == -EINPROGRESS)
+	{
+		dprintk("write queued.\n");
 		return 0;
+	}
 
 	printk(KERN_WARNING "aac_write: fib_send failed with status: %d\n", status);
 	/*
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.6/drivers/scsi/aacraid/commctrl.c linux-2.6.6/drivers/scsi/aacraid/commctrl.c
--- linux.vanilla-2.6.6/drivers/scsi/aacraid/commctrl.c	2004-05-10 03:32:28.000000000 +0100
+++ linux-2.6.6/drivers/scsi/aacraid/commctrl.c	2004-05-11 19:22:22.000000000 +0100
@@ -148,7 +148,7 @@
 		 *	the list to 0.
 		 */
 		fibctx->count = 0;
-		AAC_INIT_LIST_HEAD(&fibctx->hw_fib_list);
+		INIT_LIST_HEAD(&fibctx->fib_list);
 		fibctx->jiffies = jiffies/HZ;
 		/*
 		 *	Now add this context onto the adapter's 
@@ -179,7 +179,7 @@
 {
 	struct fib_ioctl f;
 	struct aac_fib_context *fibctx, *aifcp;
-	struct hw_fib * hw_fib;
+	struct fib *fib;
 	int status;
 	struct list_head * entry;
 	int found;
@@ -222,25 +222,27 @@
 	 *	-EAGAIN
 	 */
 return_fib:
-	if (!aac_list_empty(&fibctx->hw_fib_list)) {
-		struct aac_list_head * entry;
+	if (!list_empty(&fibctx->fib_list)) {
+		struct list_head * entry;
 		/*
 		 *	Pull the next fib from the fibs
 		 */
-		entry = (struct aac_list_head*)(ulong)fibctx->hw_fib_list.next;
-		aac_list_del(entry);
+		entry = fibctx->fib_list.next;
+		list_del(entry);
 		
-		hw_fib = aac_list_entry(entry, struct hw_fib, header.FibLinks);
+		fib = list_entry(entry, struct fib, fiblink);
 		fibctx->count--;
 		spin_unlock_irqrestore(&dev->fib_lock, flags);
-		if (copy_to_user(f.fib, hw_fib, sizeof(struct hw_fib))) {
-			kfree(hw_fib);
+		if (copy_to_user(f.fib, fib->hw_fib, sizeof(struct hw_fib))) {
+			kfree(fib->hw_fib);
+			kfree(fib);
 			return -EFAULT;
 		}	
 		/*
 		 *	Free the space occupied by this copy of the fib.
 		 */
-		kfree(hw_fib);
+		kfree(fib->hw_fib);
+		kfree(fib);
 		status = 0;
 		fibctx->jiffies = jiffies/HZ;
 	} else {
@@ -262,24 +264,25 @@
 
 int aac_close_fib_context(struct aac_dev * dev, struct aac_fib_context * fibctx)
 {
-	struct hw_fib *hw_fib;
+	struct fib *fib;
 
 	/*
 	 *	First free any FIBs that have not been consumed.
 	 */
-	while (!aac_list_empty(&fibctx->hw_fib_list)) {
-		struct aac_list_head * entry;
+	while (!list_empty(&fibctx->fib_list)) {
+		struct list_head * entry;
 		/*
 		 *	Pull the next fib from the fibs
 		 */
-		entry = (struct aac_list_head*)(ulong)(fibctx->hw_fib_list.next);
-		aac_list_del(entry);
-		hw_fib = aac_list_entry(entry, struct hw_fib, header.FibLinks);
+		entry = fibctx->fib_list.next;
+		list_del(entry);
+		fib = list_entry(entry, struct fib, fiblink);
 		fibctx->count--;
 		/*
 		 *	Free the space occupied by this copy of the fib.
 		 */
-		kfree(hw_fib);
+		kfree(fib->hw_fib);
+		kfree(fib);
 	}
 	/*
 	 *	Remove the Context from the AdapterFibContext List
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.6/drivers/scsi/aacraid/comminit.c linux-2.6.6/drivers/scsi/aacraid/comminit.c
--- linux.vanilla-2.6.6/drivers/scsi/aacraid/comminit.c	2004-05-10 03:31:59.000000000 +0100
+++ linux-2.6.6/drivers/scsi/aacraid/comminit.c	2004-05-11 20:20:37.000000000 +0100
@@ -81,9 +81,9 @@
 	 *	Adapter Fibs are the first thing allocated so that they
 	 *	start page aligned
 	 */
-	dev->fib_base_va = (ulong)base;
+	dev->aif_base_va = (struct hw_fib *)base;
 	
-	init->AdapterFibsVirtualAddress = cpu_to_le32((u32)(ulong)phys);
+	init->AdapterFibsVirtualAddress = cpu_to_le32(0);
 	init->AdapterFibsPhysicalAddress = cpu_to_le32((u32)phys);
 	init->AdapterFibsSize = cpu_to_le32(fibsize);
 	init->AdapterFibAlign = cpu_to_le32(sizeof(struct hw_fib));
@@ -94,11 +94,19 @@
 	 * mapping system, but older Firmware did, and had *troubles* dealing
 	 * with the math overloading past 32 bits, thus we must limit this
 	 * field.
+	 *
+	 * This assumes the memory is mapped zero->n, which isnt
+	 * always true on real computers. It also has some slight problems
+	 * with the GART on x86-64. I've btw never tried DMA from PCI space
+	 * on this platform but don't be suprised if its problematic.
 	 */
+#ifndef CONFIG_GART_IOMMU
 	if ((num_physpages << (PAGE_SHIFT - 12)) <= AAC_MAX_HOSTPHYSMEMPAGES) {
 		init->HostPhysMemPages = 
 			cpu_to_le32(num_physpages << (PAGE_SHIFT-12));
-	} else {
+	} else 
+#endif	
+	{
 		init->HostPhysMemPages = cpu_to_le32(AAC_MAX_HOSTPHYSMEMPAGES);
 	}
 
@@ -140,7 +148,7 @@
 	q->dev = dev;
 	INIT_LIST_HEAD(&q->pendingq);
 	init_waitqueue_head(&q->cmdready);
-	AAC_INIT_LIST_HEAD(&q->cmdq);
+	INIT_LIST_HEAD(&q->cmdq);
 	init_waitqueue_head(&q->qfull);
 	spin_lock_init(&q->lockdata);
 	q->lock = &q->lockdata;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.6/drivers/scsi/aacraid/commsup.c linux-2.6.6/drivers/scsi/aacraid/commsup.c
--- linux.vanilla-2.6.6/drivers/scsi/aacraid/commsup.c	2004-05-10 03:32:54.000000000 +0100
+++ linux-2.6.6/drivers/scsi/aacraid/commsup.c	2004-05-11 19:22:22.000000000 +0100
@@ -133,13 +133,10 @@
 	unsigned long flags;
 	spin_lock_irqsave(&dev->fib_lock, flags);
 	fibptr = dev->free_fib;	
-	while(!fibptr){
-		spin_unlock_irqrestore(&dev->fib_lock, flags);
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
-		spin_lock_irqsave(&dev->fib_lock, flags);
-		fibptr = dev->free_fib;	
-	}
+	/* Cannot sleep here or you get hangs. Instead we did the
+	   maths at compile time. */
+	if(!fibptr)
+		BUG();
 	dev->free_fib = fibptr->next;
 	spin_unlock_irqrestore(&dev->fib_lock, flags);
 	/*
@@ -290,7 +287,7 @@
 	}
 }   
 
-/*Command thread: *
+/**
  *	aac_queue_get		-	get the next free QE
  *	@dev: Adapter
  *	@index: Returned index
@@ -450,8 +447,7 @@
 	 *	Map the fib into 32bits by using the fib number
 	 */
 
-//	hw_fib->header.SenderFibAddress = ((u32)(fibptr-dev->fibs)) << 1;
-	hw_fib->header.SenderFibAddress = cpu_to_le32((u32)(ulong)fibptr->hw_fib_pa);
+	hw_fib->header.SenderFibAddress = cpu_to_le32(((u32)(fibptr-dev->fibs)) << 1);
 	hw_fib->header.SenderData = (u32)(fibptr - dev->fibs);
 	/*
 	 *	Set FIB state to indicate where it came from and if we want a
@@ -492,7 +488,7 @@
 	dprintk((KERN_DEBUG "  Command =               %d.\n", hw_fib->header.Command));
 	dprintk((KERN_DEBUG "  XferState  =            %x.\n", hw_fib->header.XferState));
 	dprintk((KERN_DEBUG "  hw_fib va being sent=%p\n",fibptr->hw_fib));
-	dprintk((KERN_DEBUG "  hw_fib pa being sent=%xl\n",(ulong)fibptr->hw_fib_pa));
+	dprintk((KERN_DEBUG "  hw_fib pa being sent=%lx\n",(ulong)fibptr->hw_fib_pa));
 	dprintk((KERN_DEBUG "  fib being sent=%p\n",fibptr));
 	/*
 	 *	Fill in the Callback and CallbackContext if we are not
@@ -806,8 +802,8 @@
  
 int aac_command_thread(struct aac_dev * dev)
 {
-	struct hw_fib *hw_fib, *newfib;
-	struct fib fibptr; /* for error logging */
+	struct hw_fib *hw_fib, *hw_newfib;
+	struct fib *fib, *newfib;
 	struct aac_queue_block *queues = dev->queues;
 	struct aac_fib_context *fibctx;
 	unsigned long flags;
@@ -828,42 +824,44 @@
 	 *	Let the DPC know it has a place to send the AIF's to.
 	 */
 	dev->aif_thread = 1;
-	memset(&fibptr, 0, sizeof(struct fib));
 	add_wait_queue(&queues->queue[HostNormCmdQueue].cmdready, &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
 	while(1) 
 	{
 		spin_lock_irqsave(queues->queue[HostNormCmdQueue].lock, flags);
-		while(!aac_list_empty(&(queues->queue[HostNormCmdQueue].cmdq))) {
-			struct aac_list_head *entry;
+		while(!list_empty(&(queues->queue[HostNormCmdQueue].cmdq))) {
+			struct list_head *entry;
 			struct aac_aifcmd * aifcmd;
 
 			set_current_state(TASK_RUNNING);
 		
-			entry = (struct aac_list_head*)(ulong)(queues->queue[HostNormCmdQueue].cmdq.next);
-			dprintk(("aacraid: Command thread: removing fib from cmdq (%p)\n",entry));
-			aac_list_del(entry);
+			entry = queues->queue[HostNormCmdQueue].cmdq.next;
+			list_del(entry);
 			
 			spin_unlock_irqrestore(queues->queue[HostNormCmdQueue].lock, flags);
-			hw_fib = aac_list_entry(entry, struct hw_fib, header.FibLinks);
+			fib = list_entry(entry, struct fib, fiblink);
 			/*
 			 *	We will process the FIB here or pass it to a 
 			 *	worker thread that is TBD. We Really can't 
 			 *	do anything at this point since we don't have
 			 *	anything defined for this thread to do.
 			 */
-			memset(&fibptr, 0, sizeof(struct fib));
-			fibptr.type = FSAFS_NTC_FIB_CONTEXT;
-			fibptr.size = sizeof( struct fib );
-			fibptr.hw_fib = hw_fib;
-			fibptr.data = hw_fib->data;
-			fibptr.dev = dev;
+			hw_fib = fib->hw_fib;
+			memset(fib, 0, sizeof(struct fib));
+			fib->type = FSAFS_NTC_FIB_CONTEXT;
+			fib->size = sizeof( struct fib );
+			fib->hw_fib = hw_fib;
+			fib->data = hw_fib->data;
+			fib->dev = dev;
 			/*
 			 *	We only handle AifRequest fibs from the adapter.
 			 */
 			aifcmd = (struct aac_aifcmd *) hw_fib->data;
-			if (aifcmd->command == le16_to_cpu(AifCmdDriverNotify)) {
-				aac_handle_aif(dev, &fibptr);
+			if (aifcmd->command == cpu_to_le32(AifCmdDriverNotify)) {
+				/* Handle Driver Notify Events */
+				aac_handle_aif(dev, fib);
+				*(u32 *)hw_fib->data = cpu_to_le32(ST_OK);
+				fib_adapter_complete(fib, sizeof(u32));
 			} else {
 				struct list_head *entry;
 				/* The u32 here is important and intended. We are using
@@ -872,6 +870,10 @@
 				u32 time_now, time_last;
 				unsigned long flagv;
 				
+				/* Sniff events */
+				if (aifcmd->command == cpu_to_le32(AifCmdEventNotify))
+					aac_handle_aif(dev, fib);
+				
 				time_now = jiffies/HZ;
 
 				spin_lock_irqsave(&dev->fib_lock, flagv);
@@ -893,6 +895,11 @@
 					 */
 					if (fibctx->count > 20)
 					{
+						/*
+						 * It's *not* jiffies folks,
+						 * but jiffies / HZ so do not
+						 * panic ...
+						 */
 						time_last = fibctx->jiffies;
 						/*
 						 * Has it been > 2 minutes 
@@ -909,17 +916,20 @@
 					 * Warning: no sleep allowed while
 					 * holding spinlock
 					 */
-					newfib = kmalloc(sizeof(struct hw_fib), GFP_ATOMIC);
-					if (newfib) {
+					hw_newfib = kmalloc(sizeof(struct hw_fib), GFP_ATOMIC);
+					newfib = kmalloc(sizeof(struct fib), GFP_ATOMIC);
+					if (newfib && hw_newfib) {
 						/*
 						 * Make the copy of the FIB
 						 */
-						memcpy(newfib, hw_fib, sizeof(struct hw_fib));
+						memcpy(hw_newfib, hw_fib, sizeof(struct hw_fib));
+						memcpy(newfib, fib, sizeof(struct fib));
+						newfib->hw_fib = hw_newfib;
 						/*
 						 * Put the FIB onto the
 						 * fibctx's fibs
 						 */
-						aac_list_add_tail(&newfib->header.FibLinks, &fibctx->hw_fib_list);
+						list_add_tail(&newfib->fiblink, &fibctx->fib_list);
 						fibctx->count++;
 						/* 
 						 * Set the event to wake up the
@@ -928,6 +938,10 @@
 						up(&fibctx->wait_sem);
 					} else {
 						printk(KERN_WARNING "aifd: didn't allocate NewFib.\n");
+						if(newfib)
+							kfree(newfib);
+						if(hw_newfib)
+							kfree(hw_newfib);
 					}
 					entry = entry->next;
 				}
@@ -935,10 +949,11 @@
 				 *	Set the status of this FIB
 				 */
 				*(u32 *)hw_fib->data = cpu_to_le32(ST_OK);
-				fib_adapter_complete(&fibptr, sizeof(u32));
+				fib_adapter_complete(fib, sizeof(u32));
 				spin_unlock_irqrestore(&dev->fib_lock, flagv);
 			}
 			spin_lock_irqsave(queues->queue[HostNormCmdQueue].lock, flags);
+			kfree(fib);
 		}
 		/*
 		 *	There are no more AIF's
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.6/drivers/scsi/aacraid/dpcsup.c linux-2.6.6/drivers/scsi/aacraid/dpcsup.c
--- linux.vanilla-2.6.6/drivers/scsi/aacraid/dpcsup.c	2004-05-10 03:32:29.000000000 +0100
+++ linux-2.6.6/drivers/scsi/aacraid/dpcsup.c	2004-05-11 19:22:22.000000000 +0100
@@ -70,12 +70,12 @@
 	 */
 	while(aac_consumer_get(dev, q, &entry))
 	{
-		u32 fast ;
-		fast = (entry->addr & cpu_to_le32(0x01));
-		hwfib = (struct hw_fib *)((char *)dev->hw_fib_va + 
-				((entry->addr & ~0x01) - dev->hw_fib_pa));
-		fib = &dev->fibs[hwfib->header.SenderData];
-
+		int fast;
+		u32 index = le32_to_cpu(entry->addr);
+		fast = index & 0x01;
+		fib = &dev->fibs[index >> 1];
+		hwfib = fib->hw_fib;
+		
 		aac_consumer_free(dev, q, HostNormRespQueue);
 		/*
 		 *	Remove this fib from the Outstanding I/O queue.
@@ -169,29 +169,44 @@
 	 */
 	while(aac_consumer_get(dev, q, &entry))
 	{
+		struct fib fibctx;
 		struct hw_fib * hw_fib;
-		hw_fib = (struct hw_fib *)((char *)dev->hw_fib_va + 
-				((entry->addr & ~0x01) - dev->hw_fib_pa));
-
-		if (dev->aif_thread) {
-		        aac_list_add_tail(&hw_fib->header.FibLinks, &q->cmdq);
+		u32 index;
+		struct fib *fib = &fibctx;
+		
+		index = le32_to_cpu(entry->addr) / sizeof(struct hw_fib);
+		hw_fib = &dev->aif_base_va[index];
+		
+		/*
+		 *	Allocate a FIB at all costs. For non queued stuff
+		 *	we can just use the stack so we are happy. We need
+		 *	a fib object in order to manage the linked lists
+		 */
+		if (dev->aif_thread)
+			if((fib = kmalloc(sizeof(struct fib), GFP_ATOMIC)) == NULL)
+				fib = &fibctx;
+		
+		memset(fib, 0, sizeof(struct fib));
+		INIT_LIST_HEAD(&fib->fiblink);
+		fib->type = FSAFS_NTC_FIB_CONTEXT;
+		fib->size = sizeof(struct fib);
+		fib->hw_fib = hw_fib;
+		fib->data = hw_fib->data;
+		fib->dev = dev;
+		
+				
+		if (dev->aif_thread && fib != &fibctx) {
+		        list_add_tail(&fib->fiblink, &q->cmdq);
 	 	        aac_consumer_free(dev, q, HostNormCmdQueue);
 		        wake_up_interruptible(&q->cmdready);
 		} else {
-			struct fib fibctx;
 	 	        aac_consumer_free(dev, q, HostNormCmdQueue);
 			spin_unlock_irqrestore(q->lock, flags);
-			memset(&fibctx, 0, sizeof(struct fib));
-			fibctx.type = FSAFS_NTC_FIB_CONTEXT;
-			fibctx.size = sizeof(struct fib);
-			fibctx.hw_fib = hw_fib;
-			fibctx.data = hw_fib->data;
-			fibctx.dev = dev;
 			/*
 			 *	Set the status of this FIB
 			 */
 			*(u32 *)hw_fib->data = cpu_to_le32(ST_OK);
-			fib_adapter_complete(&fibctx, sizeof(u32));
+			fib_adapter_complete(fib, sizeof(u32));
 			spin_lock_irqsave(q->lock, flags);
 		}		
 	}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.6/drivers/scsi/aacraid/README linux-2.6.6/drivers/scsi/aacraid/README
--- linux.vanilla-2.6.6/drivers/scsi/aacraid/README	2004-05-10 03:32:00.000000000 +0100
+++ linux-2.6.6/drivers/scsi/aacraid/README	2004-05-10 21:20:16.000000000 +0100
@@ -38,15 +38,19 @@
 					(fixed 64bit and 64G memory model, changed confusing naming convention
 					 where fibs that go to the hardware are consistently called hw_fibs and
 					 not just fibs like the name of the driver tracking structure)
+Mark Salyzyn <Mark_Salyzyn@adaptec.com> Fixed panic issues and added some new product ids for upcoming hbas.
+
 Original Driver
 -------------------------
 Adaptec Unix OEM Product Group
 
 Mailing List
 -------------------------
-None currently. Also note this is very different to Brian's original driver
+linux-aacraid-devel@dell.com (Interested parties troll here)
+http://mbserver.adaptec.com/ (Currently more Community Support than Devel Support)
+Also note this is very different to Brian's original driver
 so don't expect him to support it.
-Adaptec does support this driver.  Contact either tech support or deanna bonds.
+Adaptec does support this driver.  Contact either tech support or Mark Salyzyn.
 
 Original by Brian Boerner February 2001
 Rewritten by Alan Cox, November 2001
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.6/drivers/scsi/aacraid/sa.c linux-2.6.6/drivers/scsi/aacraid/sa.c
--- linux.vanilla-2.6.6/drivers/scsi/aacraid/sa.c	2004-05-10 03:32:39.000000000 +0100
+++ linux-2.6.6/drivers/scsi/aacraid/sa.c	2004-05-11 19:22:22.000000000 +0100
@@ -419,6 +419,11 @@
 	 *	Start any kernel threads needed
 	 */
 	dev->thread_pid = kernel_thread((int (*)(void *))aac_command_thread, dev, 0);
+	if (dev->thread_pid < 0) {
+		printk(KERN_ERR "aacraid: Unable to create command thread.\n");
+		return -1;
+	}
+
 	/*
 	 *	Tell the adapter that all is configure, and it can start 
 	 *	accepting requests
