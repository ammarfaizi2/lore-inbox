Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318602AbSIFOFW>; Fri, 6 Sep 2002 10:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318626AbSIFOFW>; Fri, 6 Sep 2002 10:05:22 -0400
Received: from ida.rowland.org ([192.131.102.52]:1796 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id <S318602AbSIFOFP>;
	Fri, 6 Sep 2002 10:05:15 -0400
Date: Fri, 6 Sep 2002 10:09:51 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: <stern@ida.rowland.org>
To: Phil Stracchino <alaric@babcom.com>
cc: <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>,
       <usb-storage@one-eyed-alien.net>
Subject: Re: [linux-usb-devel] Feiya 5-in-1 Card Reader
In-Reply-To: <20020905150026.GA4676@babylon5.babcom.com>
Message-ID: <Pine.LNX.4.33L2.0209061000410.642-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2002, Phil Stracchino wrote:

> On Thu, Sep 05, 2002 at 10:41:48AM +0200, Andries.Brouwer@cwi.nl wrote:
> > > Speaking of sddr09 devices (of which I possess one), what's the current
> > > state of support for the sddr09?  Last I knew, at the time when I finally
> > > got mine working, the sddr09 was only supported read-only
> >
> > For me it works read-write and out-of-the-box on a vanilla kernel.
> > (I added this stuff a few months ago. Found in 2.5 (which I use).
> > Am not quite sure about 2.4.)
>
>
> Hmm.  So if I was to grab 2.5.${LATEST} and try porting the sddr09
> driver back to 2.4.${CURRENT} ....
>
> Thanks for the pointer.

You might like to use the patch below, which I prepared a few weeks ago.
It is a backport for the (more-or-less) current 2.5.x usb-storage module
that should work under 2.4.x.  My copy of the 2.5 source is not exactly
synched with ${LATEST}, so you may have to massage the patch a little bit
to make it apply properly.  (Also, you have to apply the patch from within
the linux/drivers/usb directory rather than at the top level; sorry about
that.)

Alan Stern


diff -u storage-2.5/Makefile storage/Makefile
--- storage-2.5/Makefile	Fri Sep  6 09:38:52 2002
+++ storage/Makefile	Fri Sep  6 09:52:03 2002
@@ -5,8 +5,11 @@
 # Rewritten to use lists instead of if-statements.
 #

+O_TARGET	:= storage.o
 EXTRA_CFLAGS	:= -I../../scsi/

+list-multi	:= usb-storage.o
+
 obj-$(CONFIG_USB_STORAGE)	+= usb-storage.o

 usb-storage-obj-$(CONFIG_USB_STORAGE_DEBUG)	+= debug.o
@@ -20,6 +23,9 @@
 usb-storage-obj-$(CONFIG_USB_STORAGE_JUMPSHOT)	+= jumpshot.o raw_bulk.o

 usb-storage-objs :=	scsiglue.o protocol.o transport.o usb.o \
-			initializers.o $(usb-storage-obj-y)
+			initializers.o $(sort $(usb-storage-obj-y))

 include $(TOPDIR)/Rules.make
+
+usb-storage.o: $(usb-storage-objs)
+	$(LD) -r -o $@ $(usb-storage-objs)
diff -u storage-2.5/debug.c storage/debug.c
--- storage-2.5/debug.c	Fri Sep  6 09:38:52 2002
+++ storage/debug.c	Fri Sep  6 09:53:08 2002
@@ -189,7 +189,7 @@
 	US_DEBUGP("Buffer has %d scatterlists.\n", cmd->use_sg );
 	for ( i=0; i<cmd->use_sg; i++ )
 	{
-		char *adr = page_address(sg[i].page) + sg[i].offset;
+		char *adr = sg_address(sg[i]);

 		US_DEBUGP("Length of scatterlist %d is %d.\n",i,sg[i].length);
 		US_DEBUGP("%02x %02x %02x %02x %02x %02x %02x %02x\n"
diff -u storage-2.5/debug.h storage/debug.h
--- storage-2.5/debug.h	Fri Sep  6 09:38:52 2002
+++ storage/debug.h	Fri Sep  6 09:53:08 2002
@@ -48,7 +48,7 @@
 #include <linux/kernel.h>
 #include <linux/blk.h>
 #include <linux/cdrom.h>
-#include "scsi.h"
+#include "usb.h"

 #define USB_STORAGE "usb-storage: "

diff -u storage-2.5/freecom.c storage/freecom.c
--- storage-2.5/freecom.c	Fri Sep  6 09:38:52 2002
+++ storage/freecom.c	Fri Sep  6 09:53:08 2002
@@ -144,11 +144,11 @@
 			if (transfer_amount - total_transferred >=
 					sg[i].length) {
 				result = usb_stor_transfer_partial(us,
-						page_address(sg[i].page) + sg[i].offset, sg[i].length);
+						sg_address(sg[i]), sg[i].length);
 				total_transferred += sg[i].length;
 			} else {
 				result = usb_stor_transfer_partial(us,
-						page_address(sg[i].page) + sg[i].offset,
+						sg_address(sg[i]),
 						transfer_amount - total_transferred);
 				total_transferred += transfer_amount - total_transferred;
 			}
diff -u storage-2.5/isd200.c storage/isd200.c
--- storage-2.5/isd200.c	Fri Sep  6 09:38:52 2002
+++ storage/isd200.c	Fri Sep  6 09:53:08 2002
@@ -49,7 +49,7 @@
 #include "scsiglue.h"
 #include "isd200.h"

-#include <linux/jiffies.h>
+#include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/hdreg.h>
@@ -501,13 +501,13 @@
                             sg[i].length) {
                                 result = isd200_transfer_partial(us,
                                                                  srb->sc_data_direction,
-                                                                 page_address(sg[i].page) + sg[i].offset,
+                                                                 sg_address(sg[i]),
                                                                  sg[i].length);
                                 total_transferred += sg[i].length;
                         } else
                                 result = isd200_transfer_partial(us,
                                                                  srb->sc_data_direction,
-                                                                 page_address(sg[i].page) + sg[i].offset,
+                                                                 sg_address(sg[i]),
                                                                  transfer_amount - total_transferred);

                         /* if we get an error, end the loop here */
@@ -1271,7 +1271,7 @@
 				/* ATA Command Identify successful */
 				int i;
 				__u16 *src, *dest;
-				ata_fix_driveid(&info->drive);
+				ide_fix_driveid(&info->drive);

 				US_DEBUGP("   Identify Data Structure:\n");
 				US_DEBUGP("      config = 0x%x\n", info->drive.config);
@@ -1409,10 +1409,10 @@
 				/* transfer the lesser of the next buffer or the
 				 * remaining data */
 				if (len - total >= sg[i].length) {
-					memcpy(page_address(sg[i].page) + sg[i].offset, src + total, sg[i].length);
+					memcpy(sg_address(sg[i]), src + total, sg[i].length);
 					total += sg[i].length;
 				} else {
-					memcpy(page_address(sg[i].page) + sg[i].offset, src + total, len - total);
+					memcpy(sg_address(sg[i]), src + total, len - total);
 					total = len;
 				}
 			}
diff -u storage-2.5/protocol.c storage/protocol.c
--- storage-2.5/protocol.c	Fri Sep  6 09:38:52 2002
+++ storage/protocol.c	Fri Sep  6 09:54:21 2002
@@ -65,7 +65,7 @@
 		struct scatterlist *sg;

 		sg = (struct scatterlist *) srb->request_buffer;
-		return (void *) page_address(sg[0].page) + sg[0].offset;
+		return (void *) sg_address(sg[0]);
 	} else
 		return (void *) srb->request_buffer;
 }
diff -u storage-2.5/raw_bulk.c storage/raw_bulk.c
--- storage-2.5/raw_bulk.c	Fri Sep  6 09:38:52 2002
+++ storage/raw_bulk.c	Fri Sep  6 09:53:08 2002
@@ -191,7 +191,7 @@
 			unsigned char *buf;
 			unsigned int length;

-			buf = page_address(sg[i].page) + sg[i].offset;
+			buf = sg_address(sg[i]);
 			length = len-transferred;
 			if (length > sg[i].length)
 				length = sg[i].length;
@@ -261,7 +261,7 @@
 		unsigned char *ptr;
 		unsigned int length, room;

-		ptr = page_address(sg[i].page) + sg[i].offset + *offset;
+		ptr = sg_address(sg[i]) + *offset;

 		room = sg[i].length - *offset;
 		length = len - transferred;
@@ -310,7 +310,7 @@
 		unsigned char *ptr;
 		unsigned int length, room;

-		ptr = page_address(sg[i].page) + sg[i].offset + *offset;
+		ptr = sg_address(sg[i]) + *offset;

 		room = sg[i].length - *offset;
 		length = buflen - transferred;
diff -u storage-2.5/scsiglue.c storage/scsiglue.c
--- storage-2.5/scsiglue.c	Fri Sep  6 09:38:52 2002
+++ storage/scsiglue.c	Fri Sep  6 09:53:08 2002
@@ -117,7 +117,6 @@
 	 * notification that it has exited.
 	 */
 	US_DEBUGP("-- sending exit command to thread\n");
-	BUG_ON(atomic_read(&us->sm_state) != US_STATE_IDLE);
 	us->srb = NULL;
 	up(&(us->sema));
 	wait_for_completion(&(us->notify));
@@ -147,7 +146,6 @@
 	srb->host_scribble = (unsigned char *)us;

 	/* enqueue the command */
-	BUG_ON(atomic_read(&us->sm_state) != US_STATE_IDLE || us->srb != NULL);
 	srb->scsi_done = done;
 	us->srb = srb;

@@ -188,7 +186,6 @@
 	int result;

 	US_DEBUGP("device_reset() called\n" );
-	BUG_ON(atomic_read(&us->sm_state) != US_STATE_IDLE);

 	/* set the state and release the lock */
 	atomic_set(&us->sm_state, US_STATE_RESETTING);
@@ -562,8 +559,8 @@

 	  /* copy one byte */
 	  {
-		char *src = page_address(sg[sb].page) + sg[sb].offset + si;
-		char *dst = page_address(sg[db].page) + sg[db].offset + di;
+		char *src = sg_address(sg[sb]) + si;
+		char *dst = sg_address(sg[db]) + di;

 		 *dst = *src;
 	  }
@@ -604,7 +601,7 @@
 	      break;
 	    }

-	  *(char*)(page_address(sg[db].page) + sg[db].offset) = 0;
+	  *(char*)(sg_address(sg[db])) = 0;

 	  /* get next destination */
 	  if ( sg[db].length-1 == di )
@@ -755,8 +752,8 @@

 	  /* copy one byte */
 	  {
-		char *src = page_address(sg[sb].page) + sg[sb].offset + si;
-		char *dst = page_address(sg[db].page) + sg[db].offset + di;
+		char *src = sg_address(sg[sb]) + si;
+		char *dst = sg_address(sg[db]) + di;

 		 *dst = *src;
 	  }
@@ -797,7 +794,7 @@
 	    }

 	 {
-		 char *dst = page_address(sg[db].page) + sg[db].offset + di;
+		 char *dst = sg_address(sg[db]) + di;

 		 *dst = tempBuffer[element-USB_STOR_SCSI_SENSE_HDRSZ];
 	 }
@@ -851,17 +848,14 @@
 		  if ( element < USB_STOR_SCSI_SENSE_HDRSZ )
 		    {
 		      /* fill in the pointers for both header types */
-		      the6->array[element] = page_address(sg[i].page) +
-			      			sg[i].offset + j;
-		      the10->array[element] = page_address(sg[i].page) +
-						sg[i].offset + j;
+		      the6->array[element] = sg_address(sg[i]) + j;
+		      the10->array[element] = sg_address(sg[i]) + j;

 		    }
 		  else if ( element < USB_STOR_SCSI_SENSE_10_HDRSZ )
 		    {
 		      /* only the longer headers still cares now */
-		      the10->array[element] = page_address(sg[i].page) +
-						sg[i].offset + j;
+		      the10->array[element] = sg_address(sg[i]) + j;

 		    }
 		  /* increase element counter */
diff -u storage-2.5/sddr09.c storage/sddr09.c
--- storage-2.5/sddr09.c	Fri Sep  6 09:38:52 2002
+++ storage/sddr09.c	Fri Sep  6 09:53:08 2002
@@ -1091,25 +1091,23 @@
 		return 0;

 	for (i=0; i<alloc_blocks; i++) {
-		if (i<alloc_blocks-1) {
-			char *vaddr = kmalloc(1 << 17, GFP_NOIO);
-			sg[i].page = virt_to_page(vaddr);
-			sg[i].offset = ((unsigned long)vaddr & ~PAGE_MASK);
-			sg[i].length = (1<<17);
-		} else {
-			char *vaddr = kmalloc(alloc_len, GFP_NOIO);
-			sg[i].page = virt_to_page(vaddr);
-			sg[i].offset = ((unsigned long)vaddr & ~PAGE_MASK);
-			sg[i].length = alloc_len;
-		}
-		alloc_len -= sg[i].length;
+		int alloc_req = (i < alloc_blocks-1 ? 1 << 17 : alloc_len);
+		char *vaddr = kmalloc(alloc_req, GFP_NOIO);
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,3)
+		sg[i].page = virt_to_page(vaddr);
+		sg[i].offset = ((unsigned long)vaddr & ~PAGE_MASK);
+#else
+		sg[i].address = vaddr;
+#endif
+		sg[i].length = alloc_req;
+		alloc_len -= alloc_req;
 	}

 	for (i=0; i<alloc_blocks; i++)
 		if (sg[i].page == NULL) {
 			for (i=0; i<alloc_blocks; i++)
 				if (sg[i].page != NULL)
-					kfree(page_address(sg[i].page) + sg[i].offset);
+					kfree(sg_address(sg[i]));
 			kfree(sg);
 			return 0;
 		}
@@ -1120,7 +1118,7 @@
 				     (unsigned char *)sg, alloc_blocks);
 	if (result != USB_STOR_TRANSPORT_GOOD) {
 		for (i=0; i<alloc_blocks; i++)
-			kfree(page_address(sg[i].page) + sg[i].offset);
+			kfree(sg_address(sg[i]));
 		kfree(sg);
 		return -1;
 	}
@@ -1136,7 +1134,7 @@
 		info->lba_to_pba = NULL;
 		info->pba_to_lba = NULL;
 		for (i=0; i<alloc_blocks; i++)
-			kfree(page_address(sg[i].page) + sg[i].offset);
+			kfree(sg_address(sg[i]));
 		kfree(sg);
 		return 0;
 	}
@@ -1144,7 +1142,7 @@
 	for (i = 0; i < numblocks; i++)
 		info->lba_to_pba[i] = info->pba_to_lba[i] = UNDEF;

-	ptr = page_address(sg[0].page)+sg[0].offset;
+	ptr = sg_address(sg[0]);

 	/*
 	 * Define lba-pba translation table
@@ -1153,8 +1151,7 @@
 	// scatterlist block i*64/128k = i*(2^6)*(2^-17) = i*(2^-11)

 	for (i=0; i<numblocks; i++) {
-		ptr = page_address(sg[i>>11].page) +
-			sg[i>>11].offset + ((i&0x7ff)<<6);
+		ptr = sg_address(sg[i>>11]) + ((i&0x7ff)<<6);

 		if (i == 0 || i == 1) {
 			info->pba_to_lba[i] = UNUSABLE;
@@ -1264,7 +1261,7 @@
 	US_DEBUGP("Found %d LBA's\n", lbact);

 	for (i=0; i<alloc_blocks; i++)
-		kfree(page_address(sg[i].page) + sg[i].offset);
+		kfree(sg_address(sg[i]));
 	kfree(sg);
 	return 0;
 }
diff -u storage-2.5/transport.c storage/transport.c
--- storage-2.5/transport.c	Fri Sep  6 09:39:38 2002
+++ storage/transport.c	Fri Sep  6 09:53:08 2002
@@ -348,7 +348,6 @@
 	 * violates this invariant is a bug.  In the hopes of removing
 	 * all the complex logic above, let's find them and eliminate them.
 	 */
-	BUG_ON(len != srb->request_bufflen);

 	return len;
 }
@@ -423,7 +422,7 @@

 	/* lock and submit the URB */
 	down(&(us->current_urb_sem));
-	status = usb_submit_urb(us->current_urb, GFP_NOIO);
+	status = usb_submit_urb(us->current_urb);
 	if (status) {
 		/* something went wrong */
 		up(&(us->current_urb_sem));
@@ -458,11 +457,11 @@
 	int status;

 	/* fill in the devrequest structure */
-	us->dr->bRequestType = requesttype;
-	us->dr->bRequest = request;
-	us->dr->wValue = cpu_to_le16(value);
-	us->dr->wIndex = cpu_to_le16(index);
-	us->dr->wLength = cpu_to_le16(size);
+	us->dr->requesttype = requesttype;
+	us->dr->request = request;
+	us->dr->value = cpu_to_le16(value);
+	us->dr->index = cpu_to_le16(index);
+	us->dr->length = cpu_to_le16(size);

 	/* fill and submit the URB */
 	FILL_CONTROL_URB(us->current_urb, us->pusb_dev, pipe,
@@ -632,11 +631,11 @@
 			if (transfer_amount - total_transferred >=
 					sg[i].length) {
 				result = usb_stor_transfer_partial(us,
-						page_address(sg[i].page) + sg[i].offset, sg[i].length);
+						sg_address(sg[i]), sg[i].length);
 				total_transferred += sg[i].length;
 			} else
 				result = usb_stor_transfer_partial(us,
-						page_address(sg[i].page) + sg[i].offset,
+						sg_address(sg[i]),
 						transfer_amount - total_transferred);

 			/* if we get an error, end the loop here */
@@ -848,14 +847,12 @@
  * This must be called with scsi_lock(us->srb->host) held */
 void usb_stor_abort_transport(struct us_data *us)
 {
-	int state = atomic_read(&us->sm_state);

 	US_DEBUGP("usb_stor_abort_transport called\n");

 	/* Normally the current state is RUNNING.  If the control thread
 	 * hasn't even started processing this command, the state will be
 	 * IDLE.  Anything else is a bug. */
-	BUG_ON((state != US_STATE_RUNNING && state != US_STATE_IDLE));

 	/* set state to abort and release the lock */
 	atomic_set(&us->sm_state, US_STATE_ABORTING);
@@ -879,6 +876,9 @@
 		US_DEBUGP("-- simulating missing IRQ\n");
 		usb_stor_CBI_irq(us->irq_urb);
 	}
+
+	/* Wait for the aborted command to finish */
+	wait_for_completion(&us->notify);

 	/* Reacquire the lock */
 	scsi_lock(us->srb->host);
diff -u storage-2.5/usb.c storage/usb.c
--- storage-2.5/usb.c	Fri Sep  6 09:38:52 2002
+++ storage/usb.c	Fri Sep  6 09:53:08 2002
@@ -283,13 +283,13 @@
 	if (us->srb->use_sg) {
 		sg = (struct scatterlist *)us->srb->request_buffer;
 		for (i=0; i<us->srb->use_sg; i++)
-			memset(page_address(sg[i].page) + sg[i].offset, 0, sg[i].length);
+			memset(sg_address(sg[i]), 0, sg[i].length);
 		for (i=0, transferred=0;
 				i<us->srb->use_sg && transferred < len;
 				i++) {
 			amt = sg[i].length > len-transferred ?
 					len-transferred : sg[i].length;
-			memcpy(page_address(sg[i].page) + sg[i].offset, data+transferred, amt);
+			memcpy(sg_address(sg[i]), data+transferred, amt);
 			transferred -= amt;
 		}
 	} else {
@@ -314,9 +314,8 @@
 	/* avoid getting signals */
 	spin_lock_irq(&current->sigmask_lock);
 	flush_signals(current);
-	current->flags |= PF_IOTHREAD;
 	sigfillset(&current->blocked);
-	recalc_sigpending();
+	recalc_sigpending(current);
 	spin_unlock_irq(&current->sigmask_lock);

 	/* set our name for identification purposes */
@@ -513,7 +512,7 @@
 	return 0;
 }

-/* Set up the URB, the usb_ctrlrequest, and the IRQ pipe and handler.
+/* Set up the URB, the devrequest, and the IRQ pipe and handler.
  * ss->dev_semaphore must already be locked.
  * Note that this function assumes that all the data in the us_data
  * strucuture is current.  This includes the ep_int field, which gives us
@@ -526,9 +525,9 @@
 	int maxp;
 	int result;

-	/* allocate the usb_ctrlrequest for control packets */
-	US_DEBUGP("Allocating usb_ctrlrequest\n");
-	ss->dr = kmalloc(sizeof(struct usb_ctrlrequest), GFP_NOIO);
+	/* allocate the devrequest for control packets */
+	US_DEBUGP("Allocating devrequest\n");
+	ss->dr = kmalloc(sizeof(devrequest), GFP_NOIO);
 	if (!ss->dr) {
 		US_DEBUGP("allocation failed\n");
 		return 1;
@@ -536,7 +535,7 @@

 	/* allocate the URB we're going to use */
 	US_DEBUGP("Allocating URB\n");
-	ss->current_urb = usb_alloc_urb(0, GFP_KERNEL);
+	ss->current_urb = usb_alloc_urb(0);
 	if (!ss->current_urb) {
 		US_DEBUGP("allocation failed\n");
 		return 2;
@@ -550,7 +549,7 @@
 		down(&(ss->irq_urb_sem));

 		/* allocate the URB */
-		ss->irq_urb = usb_alloc_urb(0, GFP_KERNEL);
+		ss->irq_urb = usb_alloc_urb(0);
 		if (!ss->irq_urb) {
 			up(&(ss->irq_urb_sem));
 			US_DEBUGP("couldn't allocate interrupt URB");
@@ -569,7 +568,7 @@
 			maxp, usb_stor_CBI_irq, ss, ss->ep_int->bInterval);

 		/* submit the URB for processing */
-		result = usb_submit_urb(ss->irq_urb, GFP_KERNEL);
+		result = usb_submit_urb(ss->irq_urb);
 		US_DEBUGP("usb_submit_urb() returns %d\n", result);
 		if (result) {
 			up(&(ss->irq_urb_sem));
@@ -584,7 +583,7 @@
 	return 0;	/* success */
 }

-/* Deallocate the URB, the usb_ctrlrequest, and the IRQ pipe.
+/* Deallocate the URB, the devrequest, and the IRQ pipe.
  * ss->dev_semaphore must already be locked.
  */
 static void usb_stor_deallocate_urbs(struct us_data *ss)
@@ -611,7 +610,7 @@
 		ss->current_urb = NULL;
 	}

-	/* free the usb_ctrlrequest buffer */
+	/* free the devrequest buffer */
 	if (ss->dr) {
 		kfree(ss->dr);
 		ss->dr = NULL;
@@ -619,7 +618,7 @@

 	/* mark the device as gone */
 	ss->flags &= ~ US_FL_DEV_ATTACHED;
-	usb_put_dev(ss->pusb_dev);
+	usb_dec_dev_use(ss->pusb_dev);
 	ss->pusb_dev = NULL;
 }

@@ -742,7 +741,7 @@
 	}

 	/* At this point, we've decided to try to use the device */
-	usb_get_dev(dev);
+	usb_inc_dev_use(dev);

 	/* clear the GUID and fetch the strings */
 	GUID_CLEAR(guid);
@@ -798,7 +797,7 @@
 			USB_ENDPOINT_NUMBER_MASK;
 		ss->ep_int = ep_int;

-		/* allocate the URB, the usb_ctrlrequest, and the IRQ URB */
+		/* allocate the URB, the devrequest, and the IRQ URB */
 		if (usb_stor_allocate_urbs(ss))
 			goto BadDevice;

@@ -816,7 +815,7 @@
 		if ((ss = (struct us_data *)kmalloc(sizeof(struct us_data),
 						    GFP_KERNEL)) == NULL) {
 			printk(KERN_WARNING USB_STORAGE "Out of memory\n");
-			usb_put_dev(dev);
+			usb_dec_dev_use(dev);
 			return NULL;
 		}
 		memset(ss, 0, sizeof(struct us_data));
@@ -1018,7 +1017,7 @@
 		}
 		US_DEBUGP("Protocol: %s\n", ss->protocol_name);

-		/* allocate the URB, the usb_ctrlrequest, and the IRQ URB */
+		/* allocate the URB, the devrequest, and the IRQ URB */
 		if (usb_stor_allocate_urbs(ss))
 			goto BadDevice;

@@ -1063,7 +1062,7 @@

 		/* now register	 - our detect function will be called */
 		ss->htmplt.module = THIS_MODULE;
-		result = scsi_register_host(&(ss->htmplt));
+		result = scsi_register_module(MODULE_SCSI_HA, &(ss->htmplt));
 		if (result) {
 			printk(KERN_WARNING USB_STORAGE
 				"Unable to register the scsi host\n");
@@ -1167,7 +1166,7 @@
 	 */
 	for (next = us_list; next; next = next->next) {
 		US_DEBUGP("-- calling scsi_unregister_host()\n");
-		scsi_unregister_host(&(next->htmplt));
+		scsi_unregister_module(MODULE_SCSI_HA, &(next->htmplt));
 	}

 	/* While there are still structures, free them.  Note that we are
diff -u storage-2.5/usb.h storage/usb.h
--- storage-2.5/usb.h	Fri Sep  6 09:38:52 2002
+++ storage/usb.h	Fri Sep  6 09:53:08 2002
@@ -179,7 +179,7 @@
 	/* control and bulk communications data */
 	struct semaphore	current_urb_sem; /* protect current_urb  */
 	struct urb		*current_urb;	 /* non-int USB requests */
-	struct usb_ctrlrequest	*dr;		 /* control requests	 */
+	devrequest		*dr;		 /* control requests	 */

 	/* the semaphore for sleeping the control thread */
 	struct semaphore	sema;		 /* to sleep thread on   */
@@ -208,12 +208,12 @@
 #define scsi_unlock(host)	spin_unlock_irq(host->host_lock)
 #define scsi_lock(host)		spin_lock_irq(host->host_lock)

-#define sg_address(psg)		(page_address((psg)->page) + (psg)->offset)
+#define sg_address(sg)		(page_address((sg).page) + (sg).offset)
 #else
 #define scsi_unlock(host)	spin_unlock_irq(&io_request_lock)
 #define scsi_lock(host)		spin_lock_irq(&io_request_lock)

-#define sg_address(psg)		((psg)->address)
+#define sg_address(sg)		((sg).address)
 #endif

 #endif


