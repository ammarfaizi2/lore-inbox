Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263648AbTEJE16 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 00:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263650AbTEJE15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 00:27:57 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:33998 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263648AbTEJE1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 00:27:44 -0400
Date: Sat, 10 May 2003 00:40:12 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-usb-devel@lists.sourceforge.net
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Patch for usb-ohci in 2.4 needs review & testing
Message-ID: <20030510004012.A26322@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, All:

The attached patch appears to fix a bug which was really making
my life difficult: dd if=/dev/scd0 produces corrupted ISOs when
reading off a USB CD-ROM on a box with no less than 2 P4 CPUs,
HyperThreading and ServerWorks chipset. However, I'm not
completely sure that I didn't break something.

If someone will be so kind to review and test, here are some
notes to keep in mind:

 - Review with looking at the code, not just the patch, because if
   I miss a place to change, it won't be apparent from the patch.
   The lock coverage expands, so it is important not to encroach
   on a call which can sleep.

 - Test with CONFIG_DEBUG_SPINLOCK if you fancy it, it's interesting.
   If the thing locks up, an NMI oopser trace would be helpul
   (nmi_watchdog=1).

 - Test with something other than a storage, in particular WEBCAMS,
   because they use isochronous transfers, which do completes from
   under a lock now.
 
 - The whole idea of checking jiffy-sized timeouts from an interrupt
   is revolting, but I am wary of unknown here, so I didn't kill it.
   If anyone knows how that abomination came to life, I'll be glad
   to know too.

 - Frode's one-shot interrupt fixes are stuck to the tail of it,
   because they conflict. It should not be a problem, except when
   you run -ac, which partially incorporates Frode's fixes already,
   and this patch produces one rejected segment. It is easy to merge.

Thanks in advance,
-- Pete

diff -urN -X dontdiff linux-2.4.21-rc1/drivers/usb/host/usb-ohci.c linux-2.4.21-rc1-nip/drivers/usb/host/usb-ohci.c
--- linux-2.4.21-rc1/drivers/usb/host/usb-ohci.c	2003-04-24 10:52:56.000000000 -0700
+++ linux-2.4.21-rc1-nip/drivers/usb/host/usb-ohci.c	2003-05-09 16:02:59.000000000 -0700
@@ -104,10 +104,6 @@
 
 #define OHCI_UNLINK_TIMEOUT	(HZ / 10)
 
-static LIST_HEAD (ohci_hcd_list);
-static spinlock_t usb_ed_lock = SPIN_LOCK_UNLOCKED;
-
-
 /*-------------------------------------------------------------------------*/
 
 /* AMD-756 (D2 rev) reports corrupt register contents in some cases.
@@ -134,6 +130,53 @@
 /*-------------------------------------------------------------------------*
  * URB support functions 
  *-------------------------------------------------------------------------*/ 
+
+static void ohci_complete_add(struct ohci *ohci, struct urb *urb)
+{
+
+	if (urb->hcpriv != NULL) {
+		printk("completing with non-null priv!\n");
+		return;
+	}
+
+	if (ohci->complete_tail == NULL) {
+		ohci->complete_head = urb;
+		ohci->complete_tail = urb;
+	} else {
+		ohci->complete_head->hcpriv = urb;
+		ohci->complete_tail = urb;
+	}
+}
+
+static inline struct urb *ohci_complete_get(struct ohci *ohci)
+{
+	struct urb *urb;
+
+	if ((urb = ohci->complete_head) == NULL)
+		return NULL;
+	if (urb == ohci->complete_tail) {
+		ohci->complete_tail = NULL;
+		ohci->complete_head = NULL;
+	} else {
+		ohci->complete_head = urb->hcpriv;
+	}
+	urb->hcpriv = NULL;
+	return urb;
+}
+
+static inline void ohci_complete(struct ohci *ohci)
+{
+	struct urb *urb;
+
+	spin_lock(&ohci->ohci_lock);
+	while ((urb = ohci_complete_get(ohci)) != NULL) {
+		spin_unlock(&ohci->ohci_lock);
+		if (urb->complete)
+			(*urb->complete)(urb);
+		spin_lock(&ohci->ohci_lock);
+	}
+	spin_unlock(&ohci->ohci_lock);
+}
  
 /* free HCD-private data associated with this URB */
 
@@ -214,15 +257,6 @@
 	}
 }
 
-static void urb_rm_priv (struct urb * urb)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave (&usb_ed_lock, flags);
-	urb_rm_priv_locked (urb);
-	spin_unlock_irqrestore (&usb_ed_lock, flags);
-}
-
 /*-------------------------------------------------------------------------*/
  
 #ifdef DEBUG
@@ -466,7 +500,6 @@
 {
 	urb_priv_t * urb_priv = urb->hcpriv;
 	struct urb * urbt;
-	unsigned long flags;
 	int i;
 	
 	if (!urb_priv)
@@ -474,7 +507,7 @@
 
 	/* just to be sure */
 	if (!urb->complete) {
-		urb_rm_priv (urb);
+		urb_rm_priv_locked (urb);
 		return -1;
 	}
 	
@@ -490,12 +523,17 @@
 				usb_pipeout (urb->pipe)
 					? PCI_DMA_TODEVICE
 					: PCI_DMA_FROMDEVICE);
-			urb->complete (urb);
+			if (urb->interval) {
+				urb->complete (urb);
 
-			/* implicitly requeued */
-  			urb->actual_length = 0;
-			urb->status = -EINPROGRESS;
-			td_submit_urb (urb);
+				/* implicitly requeued */
+				urb->actual_length = 0;
+				urb->status = -EINPROGRESS;
+				td_submit_urb (urb);
+			} else {
+				urb_rm_priv_locked(urb);
+				ohci_complete_add(hc, urb);
+			}
   			break;
   			
 		case PIPE_ISOCHRONOUS:
@@ -508,7 +546,6 @@
 						? PCI_DMA_TODEVICE
 						: PCI_DMA_FROMDEVICE);
 				urb->complete (urb);
-				spin_lock_irqsave (&usb_ed_lock, flags);
 				urb->actual_length = 0;
   				urb->status = USB_ST_URB_PENDING;
   				urb->start_frame = urb_priv->ed->last_iso + 1;
@@ -519,18 +556,17 @@
   					}
   					td_submit_urb (urb);
   				}
-  				spin_unlock_irqrestore (&usb_ed_lock, flags);
-  				
+
   			} else { /* unlink URB, call complete */
-				urb_rm_priv (urb);
-				urb->complete (urb); 	
+				urb_rm_priv_locked (urb);
+				ohci_complete_add(hc, urb);
 			}		
 			break;
   				
 		case PIPE_BULK:
 		case PIPE_CONTROL: /* unlink URB, call complete */
-			urb_rm_priv (urb);
-			urb->complete (urb);	
+			urb_rm_priv_locked (urb);
+			ohci_complete_add(hc, urb);
 			break;
 	}
 	return 0;
@@ -567,20 +603,24 @@
 #ifdef DEBUG
 	urb_print (urb, "SUB", usb_pipein (pipe));
 #endif
-	
+
 	/* handle a request to the virtual root hub */
 	if (usb_pipedevice (pipe) == ohci->rh.devnum) 
 		return rh_submit_urb (urb);
-	
+
+	spin_lock_irqsave(&ohci->ohci_lock, flags);
+
 	/* when controller's hung, permit only roothub cleanup attempts
 	 * such as powering down ports */
 	if (ohci->disabled) {
+		spin_unlock_irqrestore(&ohci->ohci_lock, flags);
 		usb_dec_dev_use (urb->dev);	
 		return -ESHUTDOWN;
 	}
 
 	/* every endpoint has a ed, locate and fill it */
 	if (!(ed = ep_add_ed (urb->dev, pipe, urb->interval, 1, mem_flags))) {
+		spin_unlock_irqrestore(&ohci->ohci_lock, flags);
 		usb_dec_dev_use (urb->dev);	
 		return -ENOMEM;
 	}
@@ -602,6 +642,7 @@
 		case PIPE_ISOCHRONOUS: /* number of packets from URB */
 			size = urb->number_of_packets;
 			if (size <= 0) {
+				spin_unlock_irqrestore(&ohci->ohci_lock, flags);
 				usb_dec_dev_use (urb->dev);	
 				return -EINVAL;
 			}
@@ -621,8 +662,9 @@
 
 	/* allocate the private part of the URB */
 	urb_priv = kmalloc (sizeof (urb_priv_t) + size * sizeof (td_t *), 
-							in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
+							GFP_ATOMIC);
 	if (!urb_priv) {
+		spin_unlock_irqrestore(&ohci->ohci_lock, flags);
 		usb_dec_dev_use (urb->dev);	
 		return -ENOMEM;
 	}
@@ -633,13 +675,12 @@
 	urb_priv->ed = ed;	
 
 	/* allocate the TDs (updating hash chains) */
-	spin_lock_irqsave (&usb_ed_lock, flags);
 	for (i = 0; i < size; i++) { 
 		urb_priv->td[i] = td_alloc (ohci, SLAB_ATOMIC);
 		if (!urb_priv->td[i]) {
 			urb_priv->length = i;
 			urb_free_priv (ohci, urb_priv);
-			spin_unlock_irqrestore (&usb_ed_lock, flags);
+			spin_unlock_irqrestore(&ohci->ohci_lock, flags);
 			usb_dec_dev_use (urb->dev);	
 			return -ENOMEM;
 		}
@@ -647,7 +688,7 @@
 
 	if (ed->state == ED_NEW || (ed->state & ED_DEL)) {
 		urb_free_priv (ohci, urb_priv);
-		spin_unlock_irqrestore (&usb_ed_lock, flags);
+		spin_unlock_irqrestore(&ohci->ohci_lock, flags);
 		usb_dec_dev_use (urb->dev);	
 		return -EINVAL;
 	}
@@ -669,7 +710,7 @@
 			}
 			if (bustime < 0) {
 				urb_free_priv (ohci, urb_priv);
-				spin_unlock_irqrestore (&usb_ed_lock, flags);
+				spin_unlock_irqrestore(&ohci->ohci_lock, flags);
 				usb_dec_dev_use (urb->dev);	
 				return bustime;
 			}
@@ -712,7 +753,7 @@
 	}
 #endif
 
-	spin_unlock_irqrestore (&usb_ed_lock, flags);
+	spin_unlock_irqrestore(&ohci->ohci_lock, flags);
 
 	return 0;	
 }
@@ -743,6 +784,7 @@
 	if (usb_pipedevice (urb->pipe) == ohci->rh.devnum)
 		return rh_unlink_urb (urb);
 
+	spin_lock_irqsave(&ohci->ohci_lock, flags);
 	if (urb->hcpriv && (urb->status == USB_ST_URB_PENDING)) { 
 		if (!ohci->disabled) {
 			urb_priv_t  * urb_priv;
@@ -752,6 +794,7 @@
 			 */
 			if (!(urb->transfer_flags & USB_ASYNC_UNLINK)
 					&& in_interrupt ()) {
+				spin_unlock_irqrestore(&ohci->ohci_lock, flags);
 				err ("bug in call from %p; use async!",
 					__builtin_return_address(0));
 				return -EWOULDBLOCK;
@@ -760,11 +803,10 @@
 			/* flag the urb and its TDs for deletion in some
 			 * upcoming SF interrupt delete list processing
 			 */
-			spin_lock_irqsave (&usb_ed_lock, flags);
 			urb_priv = urb->hcpriv;
 
 			if (!urb_priv || (urb_priv->state == URB_DEL)) {
-				spin_unlock_irqrestore (&usb_ed_lock, flags);
+				spin_unlock_irqrestore(&ohci->ohci_lock, flags);
 				return 0;
 			}
 				
@@ -779,7 +821,7 @@
 
 				add_wait_queue (&unlink_wakeup, &wait);
 				urb_priv->wait = &unlink_wakeup;
-				spin_unlock_irqrestore (&usb_ed_lock, flags);
+				spin_unlock_irqrestore(&ohci->ohci_lock, flags);
 
 				/* wait until all TDs are deleted */
 				set_current_state(TASK_UNINTERRUPTIBLE);
@@ -796,11 +838,12 @@
 			} else {
 				/* usb_dec_dev_use done in dl_del_list() */
 				urb->status = -EINPROGRESS;
-				spin_unlock_irqrestore (&usb_ed_lock, flags);
+				spin_unlock_irqrestore(&ohci->ohci_lock, flags);
 				return -EINPROGRESS;
 			}
 		} else {
-			urb_rm_priv (urb);
+			urb_rm_priv_locked (urb);
+			spin_unlock_irqrestore(&ohci->ohci_lock, flags);
 			if (urb->transfer_flags & USB_ASYNC_UNLINK) {
 				urb->status = -ECONNRESET;
 				if (urb->complete)
@@ -850,7 +893,7 @@
 		 * (freeing all the TDs, unlinking EDs) but we need
 		 * to defend against bugs that prevent that.
 		 */
-		spin_lock_irqsave (&usb_ed_lock, flags);	
+		spin_lock_irqsave(&ohci->ohci_lock, flags);	
 		for(i = 0; i < NUM_EDS; i++) {
   			ed = &(dev->ed[i]);
   			if (ed->state != ED_NEW) {
@@ -865,7 +908,7 @@
   				cnt++;
   			}
   		}
-  		spin_unlock_irqrestore (&usb_ed_lock, flags);
+  		spin_unlock_irqrestore(&ohci->ohci_lock, flags);
   		
 		/* if the controller is running, tds for those unlinked
 		 * urbs get freed by dl_del_list at the next SF interrupt
@@ -1199,17 +1242,12 @@
 	td_t * td;
 	ed_t * ed_ret;
 	volatile ed_t * ed; 
-	unsigned long flags;
- 	
- 	
-	spin_lock_irqsave (&usb_ed_lock, flags);
 
 	ed = ed_ret = &(usb_to_ohci (usb_dev)->ed[(usb_pipeendpoint (pipe) << 1) | 
 			(usb_pipecontrol (pipe)? 0: usb_pipeout (pipe))]);
 
 	if ((ed->state & ED_DEL) || (ed->state & ED_URB_DEL)) {
 		/* pending delete request */
-		spin_unlock_irqrestore (&usb_ed_lock, flags);
 		return NULL;
 	}
 	
@@ -1222,7 +1260,6 @@
 			/* out of memory */
 		        if (td)
 		            td_free(ohci, td);
-			spin_unlock_irqrestore (&usb_ed_lock, flags);
 			return NULL;
 		}
 		ed->hwTailP = cpu_to_le32 (td->td_dma);
@@ -1245,8 +1282,7 @@
   		ed->int_period = interval;
   		ed->int_load = load;
   	}
-  	
-	spin_unlock_irqrestore (&usb_ed_lock, flags);
+
 	return ed_ret; 
 }
 
@@ -1505,7 +1541,7 @@
 
 /* handle an urb that is being unlinked */
 
-static void dl_del_urb (struct urb * urb)
+static void dl_del_urb (struct ohci *ohci, struct urb * urb)
 {
 	wait_queue_head_t * wait_head = ((urb_priv_t *)(urb->hcpriv))->wait;
 
@@ -1513,8 +1549,7 @@
 
 	if (urb->transfer_flags & USB_ASYNC_UNLINK) {
 		urb->status = -ECONNRESET;
-		if (urb->complete)
-			urb->complete (urb);
+		ohci_complete_add(ohci, urb);
 	} else {
 		urb->status = -ENOENT;
 		if (urb->complete)
@@ -1537,10 +1572,7 @@
 	td_t * td_rev = NULL;
 	td_t * td_list = NULL;
   	urb_priv_t * urb_priv = NULL;
-  	unsigned long flags;
-  	
-  	spin_lock_irqsave (&usb_ed_lock, flags);
-  	
+
 	td_list_hc = le32_to_cpup (&ohci->hcca->done_head) & 0xfffffff0;
 	ohci->hcca->done_head = 0;
 	
@@ -1566,7 +1598,6 @@
 		td_rev = td_list;
 		td_list_hc = le32_to_cpup (&td_list->hwNextTD) & 0xfffffff0;	
 	}	
-	spin_unlock_irqrestore (&usb_ed_lock, flags);
 	return td_list;
 }
 
@@ -1578,7 +1609,6 @@
  
 static void dl_del_list (ohci_t  * ohci, unsigned int frame)
 {
-	unsigned long flags;
 	ed_t * ed;
 	__u32 edINFO;
 	__u32 tdINFO;
@@ -1586,8 +1616,6 @@
 	__u32 * td_p;
 	int ctrl = 0, bulk = 0;
 
-	spin_lock_irqsave (&usb_ed_lock, flags);
-
 	for (ed = ohci->ed_rm_list[frame]; ed != NULL; ed = ed->ed_rm_list) {
 
 		tdTailP = dma_to_td (ohci, le32_to_cpup (&ed->hwTailP) & 0xfffffff0);
@@ -1608,7 +1636,7 @@
 
 				/* URB is done; clean up */
 				if (++(urb_priv->td_cnt) == urb_priv->length)
-					dl_del_urb (urb);
+					dl_del_urb (ohci, urb);
 			} else {
 				td_p = &td->hwNextTD;
 			}
@@ -1665,7 +1693,6 @@
 	}
 
    	ohci->ed_rm_list[frame] = NULL;
-   	spin_unlock_irqrestore (&usb_ed_lock, flags);
 }
 
 
@@ -1682,9 +1709,7 @@
 	struct urb * urb;
 	urb_priv_t * urb_priv;
  	__u32 tdINFO, edHeadP, edTailP;
- 	
- 	unsigned long flags;
- 	
+ 
   	while (td_list) {
    		td_list_next = td_list->next_dl_td;
    		
@@ -1713,13 +1738,10 @@
   				urb->status = cc_to_error[cc];
   				sohci_return_urb (ohci, urb);
   			} else {
-				spin_lock_irqsave (&usb_ed_lock, flags);
-  				dl_del_urb (urb);
-				spin_unlock_irqrestore (&usb_ed_lock, flags);
+  				dl_del_urb (ohci, urb);
 			}
   		}
   		
-  		spin_lock_irqsave (&usb_ed_lock, flags);
   		if (ed->state != ED_NEW) { 
   			edHeadP = le32_to_cpup (&ed->hwHeadP) & 0xfffffff0;
   			edTailP = le32_to_cpup (&ed->hwTailP);
@@ -1728,7 +1750,6 @@
      			if ((edHeadP == edTailP) && (ed->state == ED_OPER)) 
      				ep_unlink (ohci, ed);
      		}	
-     		spin_unlock_irqrestore (&usb_ed_lock, flags);
      	
     		td_list = td_list_next;
   	}  
@@ -1919,7 +1940,8 @@
 	int leni = urb->transfer_buffer_length;
 	int len = 0;
 	int status = TD_CC_NOERROR;
-	
+	unsigned long flags;
+
 	__u32 datab[4];
 	__u8  * data_buf = (__u8 *) datab;
 	
@@ -1928,13 +1950,16 @@
 	__u16 wIndex;
 	__u16 wLength;
 
+	spin_lock_irqsave(&ohci->ohci_lock, flags);
+
 	if (usb_pipeint(pipe)) {
 		ohci->rh.urb =  urb;
 		ohci->rh.send = 1;
 		ohci->rh.interval = urb->interval;
 		rh_init_int_timer(urb);
 		urb->status = cc_to_error [TD_CC_NOERROR];
-		
+
+		spin_unlock_irqrestore(&ohci->ohci_lock, flags);
 		return 0;
 	}
 
@@ -2106,6 +2131,7 @@
 #endif
 
 	urb->hcpriv = NULL;
+	spin_unlock_irqrestore(&ohci->ohci_lock, flags);
 	usb_dec_dev_use (usb_dev);
 	urb->dev = NULL;
 	if (urb->complete)
@@ -2118,13 +2144,16 @@
 static int rh_unlink_urb (struct urb * urb)
 {
 	ohci_t * ohci = urb->dev->bus->hcpriv;
+	unsigned int flags;
  
+	spin_lock_irqsave(&ohci->ohci_lock, flags);
 	if (ohci->rh.urb == urb) {
 		ohci->rh.send = 0;
 		del_timer (&ohci->rh.rh_int_timer);
 		ohci->rh.urb = NULL;
 
 		urb->hcpriv = NULL;
+		spin_unlock_irqrestore(&ohci->ohci_lock, flags);
 		usb_dec_dev_use(urb->dev);
 		urb->dev = NULL;
 		if (urb->transfer_flags & USB_ASYNC_UNLINK) {
@@ -2133,6 +2162,8 @@
 				urb->complete (urb);
 		} else
 			urb->status = -ENOENT;
+	} else {
+		spin_unlock_irqrestore(&ohci->ohci_lock, flags);
 	}
 	return 0;
 }
@@ -2276,7 +2307,7 @@
 
 static void check_timeouts (struct ohci *ohci)
 {
-	spin_lock (&usb_ed_lock);
+	spin_lock (&ohci->ohci_lock);
 	while (!list_empty (&ohci->timeout_list)) {
 		struct urb	*urb;
 
@@ -2289,15 +2320,15 @@
 			continue;
 
 		urb->transfer_flags |= USB_TIMEOUT_KILLED | USB_ASYNC_UNLINK;
-		spin_unlock (&usb_ed_lock);
+		spin_unlock (&ohci->ohci_lock);
 
 		// outside the interrupt handler (in a timer...)
 		// this reference would race interrupts
 		sohci_unlink_urb (urb);
 
-		spin_lock (&usb_ed_lock);
+		spin_lock (&ohci->ohci_lock);
 	}
-	spin_unlock (&usb_ed_lock);
+	spin_unlock (&ohci->ohci_lock);
 }
 
 
@@ -2311,6 +2342,8 @@
 	struct ohci_regs * regs = ohci->regs;
  	int ints; 
 
+	spin_lock (&ohci->ohci_lock);
+
 	/* avoid (slow) readl if only WDH happened */
 	if ((ohci->hcca->done_head != 0)
 			&& !(le32_to_cpup (&ohci->hcca->done_head) & 0x01)) {
@@ -2319,11 +2352,13 @@
 	/* cardbus/... hardware gone before remove() */
 	} else if ((ints = readl (&regs->intrstatus)) == ~(u32)0) {
 		ohci->disabled++;
+		spin_unlock (&ohci->ohci_lock);
 		err ("%s device removed!", ohci->ohci_dev->slot_name);
 		return;
 
 	/* interrupt for some other device? */
 	} else if ((ints &= readl (&regs->intrenable)) == 0) {
+		spin_unlock (&ohci->ohci_lock);
 		return;
 	} 
 
@@ -2374,6 +2409,13 @@
 		}
 	}
 
+	/*
+	 * Finally, we are done with trashing about our hardware lists
+	 * and other CPUs are allowed in. The festive flipping of the lock
+	 * ensues as we struggle with the check_timeouts disaster.
+	 */
+	spin_unlock (&ohci->ohci_lock);
+
 	if (!list_empty (&ohci->timeout_list)) {
 		check_timeouts (ohci);
 // FIXME:  enable SF as needed in a timer;
@@ -2386,6 +2428,8 @@
 	writel (ints, &regs->intrstatus);
 	writel (OHCI_INTR_MIE, &regs->intrenable);	
 	(void)readl (&regs->intrdisable); /* PCI posting flush */
+
+	ohci_complete(ohci);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -2418,10 +2462,8 @@
 	ohci->ohci_dev = dev;
 	pci_set_drvdata(dev, ohci);
  
-	INIT_LIST_HEAD (&ohci->ohci_hcd_list);
-	list_add (&ohci->ohci_hcd_list, &ohci_hcd_list);
-
 	INIT_LIST_HEAD (&ohci->timeout_list);
+	spin_lock_init(&ohci->ohci_lock);
 
 	ohci->bus = usb_alloc_bus (&sohci_device_operations);
 	if (!ohci->bus) {
@@ -2465,9 +2507,6 @@
 		usb_free_bus (ohci->bus);
 	}
 
-	list_del (&ohci->ohci_hcd_list);
-	INIT_LIST_HEAD (&ohci->ohci_hcd_list);
-
 	ohci_mem_cleanup (ohci);
     
 	/* unmap the IO address space */
@@ -2713,12 +2752,12 @@
 	ohci->sleeping = 1;
 
 	/* First stop processing */
-  	spin_lock_irqsave (&usb_ed_lock, flags);
+  	spin_lock_irqsave (&ohci->ohci_lock, flags);
 	ohci->hc_control &= ~(OHCI_CTRL_PLE|OHCI_CTRL_CLE|OHCI_CTRL_BLE|OHCI_CTRL_IE);
 	writel (ohci->hc_control, &ohci->regs->control);
 	writel (OHCI_INTR_SF, &ohci->regs->intrstatus);
 	(void) readl (&ohci->regs->intrstatus);
-  	spin_unlock_irqrestore (&usb_ed_lock, flags);
+  	spin_unlock_irqrestore (&ohci->ohci_lock, flags);
 
 	/* Wait a frame or two */
 	mdelay(1);
@@ -2844,7 +2883,7 @@
 		mdelay (3);
 
 		/* Then re-enable operations */
-		spin_lock_irqsave (&usb_ed_lock, flags);
+		spin_lock_irqsave (&ohci->ohci_lock, flags);
 		ohci->disabled = 0;
 		ohci->sleeping = 0;
 		ohci->hc_control = OHCI_CONTROL_INIT | OHCI_USB_OPER;
@@ -2860,7 +2899,6 @@
 		/* Check for a pending done list */
 		writel (OHCI_INTR_WDH, &ohci->regs->intrdisable);	
 		(void) readl (&ohci->regs->intrdisable);
-		spin_unlock_irqrestore (&usb_ed_lock, flags);
 #ifdef CONFIG_PMAC_PBOOK
 		if (_machine == _MACH_Pmac)
 			enable_irq (ohci->irq);
@@ -2870,6 +2908,7 @@
 		writel (OHCI_INTR_WDH, &ohci->regs->intrenable); 
 		writel (OHCI_BLF, &ohci->regs->cmdstatus); /* start bulk list */
 		writel (OHCI_CLF, &ohci->regs->cmdstatus); /* start Control list */
+		spin_unlock_irqrestore (&ohci->ohci_lock, flags);
 		break;
 
 	default:
diff -urN -X dontdiff linux-2.4.21-rc1/drivers/usb/host/usb-ohci.h linux-2.4.21-rc1-nip/drivers/usb/host/usb-ohci.h
--- linux-2.4.21-rc1/drivers/usb/host/usb-ohci.h	2003-04-24 11:43:35.000000000 -0700
+++ linux-2.4.21-rc1-nip/drivers/usb/host/usb-ohci.h	2003-05-09 13:47:25.000000000 -0700
@@ -384,12 +384,12 @@
 #define OHCI_QUIRK_SUCKYIO	0x02		/* NSC superio */
 
 	struct ohci_regs * regs;	/* OHCI controller's memory */
-	struct list_head ohci_hcd_list;	/* list of all ohci_hcd */
 
 	struct list_head timeout_list;
 	// struct list_head urb_list; 	// list of all pending urbs
-	// spinlock_t urb_list_lock; 	// lock to keep consistency 
-  
+	spinlock_t ohci_lock;           /* Covers all fields up & down */
+	struct urb *complete_head, *complete_tail;
+
 	int ohci_int_load[32];		/* load of the 32 Interrupt Chains (for load balancing)*/
 	ed_t * ed_rm_list[2];     /* lists of all endpoints to be removed */
 	ed_t * ed_bulktail;       /* last endpoint of bulk list */
diff -urN -X dontdiff linux-2.4.21-rc1/drivers/usb/host/usb-uhci.c linux-2.4.21-rc1-nip/drivers/usb/host/usb-uhci.c
--- linux-2.4.21-rc1/drivers/usb/host/usb-uhci.c	2003-04-24 10:52:56.000000000 -0700
+++ linux-2.4.21-rc1-nip/drivers/usb/host/usb-uhci.c	2003-04-29 12:43:28.000000000 -0700
@@ -2430,9 +2430,9 @@
 
 _static int process_interrupt (uhci_t *s, struct urb *urb)
 {
-	int i, ret = -EINPROGRESS;
+	int ret = -EINPROGRESS;
 	urb_priv_t *urb_priv = urb->hcpriv;
-	struct list_head *p = urb_priv->desc_list.next;
+	struct list_head *p;
 	uhci_desc_t *desc = list_entry (urb_priv->desc_list.prev, uhci_desc_t, desc_list);
 
 	int actual_length;
@@ -2440,8 +2440,8 @@
 
 	//dbg("urb contains interrupt request");
 
-	for (i = 0; p != &urb_priv->desc_list; p = p->next, i++)	// Maybe we allow more than one TD later ;-)
-	{
+	// Maybe we allow more than one TD later ;-)
+	while ((p = urb_priv->desc_list.next) != &urb_priv->desc_list) {
 		desc = list_entry (p, uhci_desc_t, desc_list);
 
 		if (is_td_active(desc)) {
