Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266995AbRGMWy2>; Fri, 13 Jul 2001 18:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267000AbRGMWyT>; Fri, 13 Jul 2001 18:54:19 -0400
Received: from myth2.Stanford.EDU ([171.64.15.15]:20643 "EHLO
	myth2.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S266995AbRGMWyJ>; Fri, 13 Jul 2001 18:54:09 -0400
Date: Fri, 13 Jul 2001 15:54:05 -0700 (PDT)
From: Evan Parker <nave@stanford.edu>
To: <linux-kernel@vger.kernel.org>
cc: <mc@cs.stanford.edu>
Subject: [CHECKER] free errors for 2.4.6 and 2.4.6ac2
Message-ID: <Pine.GSO.4.31.0107131551270.15960-100000@myth2.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enclosed are 10 bugs where code uses memory that has already been
freed.  4 of the bugs have to do with one function, usb_free_dev, which
decrements the number of references to the arg passed to it and kfrees the
arg once the number of references to it reaches 0.  Because it does
reference counting, I wasn't sure if a kfree would occur every time,
but it definitely seems like it could cause use-after-free problems, so
check it out.

# Summary for free-check
#  2.4.6-specific errors       = 3
#  2.4.6ac2-specific errors = 3
#  Common errors 		      	  = 4
#  Total 				  = 10
# BUGs	|	File Name
3	|	/home/eparker/tmp/linux/2.4.6/drivers/atm/iphase.c/
1	|	/home/eparker/tmp/linux/2.4.6-ac2/drivers/usb/usbnet.c/
1	|	/home/eparker/tmp/linux/2.4.6-ac2/drivers/usb/CDCEther.c/
1	|	/home/eparker/tmp/linux/2.4.6/drivers/usb/uhci.c/
1	|	/home/eparker/tmp/linux/2.4.6/drivers/isdn/isdn_common.c/
1	|	/home/eparker/tmp/linux/2.4.6/drivers/usb/usb-ohci.c/
1	|	/home/eparker/tmp/linux/2.4.6/drivers/usb/hub.c/
1	|	/home/eparker/tmp/linux/2.4.6-ac2/drivers/net/irda/ali-ircc.c/


############################################################
# 2.4.6 specific errors
#
---------------------------------------------------------
[BUG] (submitted before, evidently not fixed yet)
/home/eparker/tmp/linux/2.4.6/drivers/atm/iphase.c:1326:rx_dle_intr: ERROR:FREE:1324:1326: Use-after-free of 'skb'!  set by 'dev_kfree_skb_any':1324 [nbytes = 168]  [distance=2]
          }
          ia_vcc = INPH_IA_VCC(vcc);
          if (ia_vcc == NULL)
          {
             atomic_inc(&vcc->stats->rx_err);
Start --->
             dev_kfree_skb_any(skb);
#if LINUX_VERSION_CODE >= 0x20312
Error --->
             atm_return(vcc, atm_guess_pdu2truesize(skb->len));
#else
             atm_return(vcc, atm_pdu2truesize(skb->len));
#endif
---------------------------------------------------------
[BUG] (submitted before, evidently not fixed yet)
/home/eparker/tmp/linux/2.4.6/drivers/atm/iphase.c:1342:rx_dle_intr: ERROR:FREE:1340:1342: Use-after-free of 'skb'!  set by 'dev_kfree_skb_any':1340 [nbytes = 168]  [distance=13]
          length =  swap(trailer->length);
          if ((length > iadev->rx_buf_sz) || (length >
                              (skb->len - sizeof(struct cpcs_trailer))))
          {
             atomic_inc(&vcc->stats->rx_err);
Start --->
             dev_kfree_skb_any(skb);
             IF_ERR(printk("rx_dle_intr: Bad  AAL5 trailer %d (skb len %d)",
Error --->
                                                            length, skb->len);)
#if LINUX_VERSION_CODE >= 0x20312
             atm_return(vcc, atm_guess_pdu2truesize(skb->len));
#else
---------------------------------------------------------
[BUG] (submitted before, evidently not fixed yet)
/home/eparker/tmp/linux/2.4.6/drivers/atm/iphase.c:1344:rx_dle_intr: ERROR:FREE:1340:1344: Use-after-free of 'skb'!  set by 'dev_kfree_skb_any':1340 [nbytes = 168]  [distance=13]
          length =  swap(trailer->length);
          if ((length > iadev->rx_buf_sz) || (length >
                              (skb->len - sizeof(struct cpcs_trailer))))
          {
             atomic_inc(&vcc->stats->rx_err);
Start --->
             dev_kfree_skb_any(skb);
             IF_ERR(printk("rx_dle_intr: Bad  AAL5 trailer %d (skb len %d)",
                                                            length, skb->len);)
#if LINUX_VERSION_CODE >= 0x20312
Error --->
             atm_return(vcc, atm_guess_pdu2truesize(skb->len));
#else
             atm_return(vcc, atm_pdu2truesize(skb->len));
#endif


############################################################
# 2.4.6ac2_free_inspected specific errors

#
---------------------------------------------------------
[BUG] obvious
/home/eparker/tmp/linux/2.4.6-ac2/drivers/net/irda/ali-ircc.c:335:ali_ircc_open: ERROR:FREE:334:335: Use-after-free of 'self'!  set by 'kfree':334 [distance=2]
	memset(self->rx_buff.head, 0, self->rx_buff.truesize);

	self->tx_buff.head = (__u8 *) kmalloc(self->tx_buff.truesize,
					      GFP_KERNEL|GFP_DMA);
	if (self->tx_buff.head == NULL) {
Start --->
		kfree(self);
Error --->
		kfree(self->rx_buff.head);
		return -ENOMEM;
	}
	memset(self->tx_buff.head, 0, self->tx_buff.truesize);
---------------------------------------------------------
[BUG] usb_dec_dev_use is defined as usb_free_dev, which calls kfree on usb
/home/eparker/tmp/linux/2.4.6-ac2/drivers/usb/CDCEther.c:1226:CDCEther_disconnect: ERROR:FREE:1222:1226: Use-after-free of 'usb'!  set by 'usb_free_dev':1222 [nbytes = 300]  [distance=2]

	// For sanity checks
	ether_dev->net = NULL;

	// I ask again, does this do anything???
Start --->
	usb_dec_dev_use( usb );

	// We are done with this interface
	usb_driver_release_interface( &CDCEther_driver,
Error --->
	                              &(usb->config[ether_dev->configuration_num].interface[ether_dev->comm_interface]) );

	// We are done with this interface too
	usb_driver_release_interface( &CDCEther_driver,
---------------------------------------------------------
[BUG] usb_free_urb called twice on urb (usb_free_urb is just a wrapper for
kfree)

/home/eparker/tmp/linux/2.4.6-ac2/drivers/usb/usbnet.c:1241:usbnet_start_xmit: ERROR:FREE:1196:1241: WARN: Use-after-free of 'urb'!  set by 'usb_free_urb':1196 [nbytes = 88]  [distance=7]
	} else if ((length % EP_SIZE (dev)) == 0) {
			if (skb_shared (skb)) {
				struct sk_buff *skb2;
				skb2 = skb_unshare (skb, flags);
				if (!skb2) {
Start --->
					usb_free_urb (urb);
					dbg ("can't unshare skb");
					goto drop;

	... DELETED 39 lines ...

drop:
		retval = NET_XMIT_DROP;
		dev->stats.tx_dropped++;
		dev_kfree_skb_any (skb);
Error --->
		usb_free_urb (urb);
#ifdef	VERBOSE
	} else {


############################################################
# errors common to both

#
---------------------------------------------------------
[BUG] double free: usb_new_device calls usb_free_dev on an error path and
returns 1; this code then catches that error and calls usb_free_dev again
(usb_free_dev is a reference counter that calls kfree once the number of
references reaches 0)
/home/eparker/tmp/linux/2.4.6/drivers/usb/hub.c:620:usb_hub_port_connect_change: ERROR:FREE:620:620: WARN: Use-after-free of 'dev'! [path=usb_new_device(0):2210->usb_free_dev(0):957->$kfree(0)$] set by 'usb_new_device':620 [nbytes = 292]  [distance=12]
		} else
			info("USB new device connect on bus%d, assigned device number %d",
				dev->bus->busnum, dev->devnum);

		/* Run it through the hoops (find a driver, etc) */

Start --->
		if (!usb_new_device(dev))
			goto done;

		/* Free the configuration if there was an error */
Error --->
		usb_free_dev(dev);
---------------------------------------------------------
[BUG] double free: usb_new_device calls usb_free_dev on an error path and
returns 1; this code then catches that error and calls usb_free_dev again
(usb_free_dev is a reference counter that calls kfree once the number of
references reaches 0)
/home/eparker/tmp/linux/2.4.6/drivers/usb/usb-ohci.c:2191:hc_start: ERROR:FREE:2190:2191: WARN: Use-after-free of 'usb_dev'! [path=usb_new_device(0):2210->usb_free_dev(0):957->$kfree(0)$] set by 'usb_new_device':2190 [nbytes = 292]  [distance=12]
	}

	dev = usb_to_ohci (usb_dev);
	ohci->bus->root_hub = usb_dev;
	usb_connect (usb_dev);
Start --->
	if (usb_new_device (usb_dev) != 0) {
Error --->
		usb_free_dev (usb_dev);
		ohci->disabled = 1;
		return -ENODEV;
	}
---------------------------------------------------------
[BUG] double free: usb_new_device calls usb_free_dev on an error path and
returns 1; this code then catches that error and calls usb_free_dev again
(usb_free_dev is a reference counter that calls kfree once the number of
references reaches 0)
/home/eparker/tmp/linux/2.4.6/drivers/usb/uhci.c:2491:uhci_start_root_hub: ERROR:FREE:2490:2491: WARN: Use-after-free of 'dev'! [path=usb_new_device(0):2210->usb_free_dev(0):957->$kfree(0)$] set by 'usb_new_device':2490 [distance=12]

static int uhci_start_root_hub(struct uhci *uhci)
{
	usb_connect(uhci->rh.dev);

Start --->
	if (usb_new_device(uhci->rh.dev) != 0) {
Error --->
		usb_free_dev(uhci->rh.dev);

		return -1;
	}
---------------------------------------------------------
[BUG] double free (then again, dev_kfree_skb does referece counting--maybe
not a bug?)
/home/eparker/tmp/linux/2.4.6/drivers/isdn/isdn_common.c:1978:isdn_writebuf_skb_stub: ERROR:FREE:1960:1978: Use-after-free of 'skb'!  set by 'kfree_skb':1960 [nbytes = 168]  [distance=36]
			skb_tmp = skb_realloc_headroom(skb, hl);
			printk(KERN_DEBUG "isdn_writebuf_skb_stub: reallocating headroom%s\n", skb_tmp ? "" : " failed");
			if (!skb_tmp) return -ENOMEM; /* 0 better? */
			ret = dev->drv[drvidx]->interface->writebuf_skb(drvidx, chan, ack, skb_tmp);
			if( ret > 0 ){
Start --->
				dev_kfree_skb(skb);

	... DELETED 12 lines ...

			atomic_dec(&dev->v110use[idx]);
			/* For V.110 return unencoded data length */
			ret = v110_ret;
			/* if the complete frame was send we free the skb;
			   if not upper function will requeue the skb */
Error --->
			if (ret == skb->len)
				dev_kfree_skb(skb);
		}
	} else








--------------------------------------------------------------------
Evan Parker
eparker@cs.stanford.edu
home: (650) 497-4928
cell: (650) 207-3646
--------------------------------------------------------------------

