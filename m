Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262281AbREXVEU>; Thu, 24 May 2001 17:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262283AbREXVEL>; Thu, 24 May 2001 17:04:11 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:65500 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S262281AbREXVEF>;
	Thu, 24 May 2001 17:04:05 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200105242104.OAA29654@csl.Stanford.EDU>
Subject: [CHECKER] free bugs in 2.4.4 and 2.4.4-ac8
To: linux-kernel@vger.kernel.org
Date: Thu, 24 May 2001 14:04:02 -0700 (PDT)
Cc: mc@cs.Stanford.EDU
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Enclosed are 24 bugs where code uses memory that has been freed.  The
good thing about these bugs is that they are easy to fix.  (Note: About
5 of these have had patches submitted, so this list is a bit out of
date.)

Summary 
  2.4.4ac8-specific errors       	= 4
  2.4.4-specific errors 		= 5
  Common errors 		        = 15
  Total 			        = 24

Dawson

# BUGs	|	File Name
3	|	drivers/char/rio/rio_linux.c
3	|	drivers/atm/iphase.c
2	|	drivers/usb/dc2xx.c
2	|	drivers/block/cciss.c
1	|	drivers/char/drm/gamma_dma.c
1	|	fs/proc/generic.c
1	|	drivers/isdn/isdn_ppp.c
1	|	net/ax25/ax25_ip.c
1	|	drivers/net/wan/lapbether.c
1	|	drivers/usb/serial/io_edgeport.c
1	|	net/netrom/nr_dev.c
1	|	drivers/i2o/i2o_pci.c
1	|	drivers/sound/cs4281/cs4281m.c
1	|	drivers/net/hamradio/bpqether.c
1	|	net/ipv6/udp.c
1	|	net/wanrouter/wanmain.c
1	|	drivers/net/irda/nsc-ircc.c
1	|	drivers/sound/cs46xx.c

----------------------------------------------------------------------

Boilerplate disclaimer:
        - this is part of a one-time large batch of errors.  In the future,
          we'll send out incremental bug reports along with a pointer to
          the bug database on our website.

        - as always, bugs may not be errors --- we have inspected the
          error logs to counter this.

        - bugs may be missing in one distribution versus the other because
          we did not compile that file (or failed to fully compile it).
          It can be worthwhile to cross check important bugs to make sure
          they've been killed.

        - sorted roughly by severity and ease-of-diagnosis.  The highest
          ranked bugs are "SECURITY" which (in most of the examples) 
          are primarily denial-of-service vulnerabilities where the user
          could trigger the bug when they canted to.  Ease-of-diagnosis
          is currently crude: we rank LOCAL errors over GLOBAL (GLOBAL
          require looking at call chains) and then distance between
          error source and manifestation as the next (closer is better)

	- if a version if one of the version has no errors specific to it,
	  this can just be because we did not inspect all the error reports.
	  These are typically from checkers that required some inter-function
	  inspection.  If you are interested in these errors, send us mail,,
	  and we can send you the unispected file.

############################################################
# 2.4.4ac8 specific errors
#
---------------------------------------------------------
[BUG] [fixed in 2.4.4]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/block/cciss.c:686:cciss_ioctl: ERROR:FREE:682:686: WARN: Use-after-free of "c"! set by 'cmd_free':682 [type=SECURITY]
                {
                        /* Copy the data out of the buffer we created */
                        if (copy_to_user(iocommand.buf, buff, iocommand.buf_size))
			{
                        	kfree(buff);
Start --->
				cmd_free(h, c, 0);
			}
                }
                kfree(buff);
Error --->
		cmd_free(h, c, 0);
                return(0);
	} 

---------------------------------------------------------
[BUG] [fixed in 2.4.4]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/block/cciss.c:685:cciss_ioctl: ERROR:FREE:681:685: WARN: Use-after-free of "buff"! set by 'kfree':681 [type=SECURITY]
		if (iocommand.Request.Type.Direction == XFER_READ)
                {
                        /* Copy the data out of the buffer we created */
                        if (copy_to_user(iocommand.buf, buff, iocommand.buf_size))
			{
Start --->
                        	kfree(buff);
				cmd_free(h, c, 0);
			}
                }
Error --->
                kfree(buff);
		cmd_free(h, c, 0);
                return(0);
	} 
---------------------------------------------------------
[BUG] Looks pretty bad
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/usb/dc2xx.c:473:camera_disconnect: ERROR:FREE:466:473: WARN: Use-after-free of "camera"! set by 'kfree':466
	/* If camera's not opened, we can clean up right away.
	 * Else apps see a disconnect on next I/O; the release cleans.
	 */
	if (!camera->buf) {
		minor_data [subminor] = NULL;
Start --->
		kfree (camera);
	} else
		camera->dev = NULL;

	info ("USB Camera #%d disconnected", subminor);
	usb_dec_dev_use (dev);

Error --->
	up (&camera->sem);
	up (&state_table_mutex);
}

---------------------------------------------------------
[BUG]  seems possible --- or is some precondition guarenteed?
/u2/engler/mc/oses/linux/2.4.4-ac8/net/ipv6/udp.c:438:udpv6_recvmsg: ERROR:FREE:453:438: WARN: Use-after-free of "skb"! set by 'kfree_skb':453
		}
  	}
	err = copied;

out_free:
Error --->
	skb_free_datagram(sk, skb);

	... DELETED 9 lines ...

			__skb_unlink(skb, &sk->receive_queue);
			clear = 1;
		}
		spin_unlock_irq(&sk->receive_queue.lock);
		if (clear)
Start --->
			kfree_skb(skb);
	}

	/* Error for blocking case is chosen to masquerade


############################################################
# 2.4.4 specific errors

#
---------------------------------------------------------
[BUG] [fixed in ac8]
/u2/engler/mc/oses/linux/2.4.4/drivers/net/irda/nsc-ircc.c:319:nsc_ircc_open: ERROR:FREE:318:319: WARN: Use-after-free of "self"! set by 'kfree':318
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
[BUG] BAD
/u2/engler/mc/oses/linux/2.4.4/drivers/sound/cs46xx.c:5324:cs46xx_remove: ERROR:FREE:5322:5324: WARN: Use-after-free of "card"! set by 'kfree':5322
			kfree (card->ac97_codec[i]);
		}
	unregister_sound_dsp(card->dev_audio);
        if(card->dev_midi)
                unregister_sound_midi(card->dev_midi);
Start --->
	kfree(card);
	PCI_SET_DRIVER_DATA(pci_dev,NULL);
Error --->
	list_del(&card->list);

	CS_DBGOUT(CS_INIT | CS_FUNCTION, 2, printk(KERN_INFO
		 "cs46xx: cs46xx_remove()-: remove successful\n"));
---------------------------------------------------------
[BUG]  [BAD] Seems like a really really bad double free.
/u2/engler/mc/oses/linux/2.4.4/drivers/i2o/i2o_pci.c:231:i2o_pci_install: ERROR:FREE:229:231: WARN: Use-after-free of "c"! set by 'i2o_delete_controller':229
				c->name, dev->irq);
			c->bus.pci.irq = -1;
#ifdef MODULE
			core->delete(c);
#else
Start --->
			i2o_delete_controller(c);
#endif /* MODULE */	
Error --->
			kfree(c);
			iounmap(mem);
			return -EBUSY;
		}
---------------------------------------------------------
[BUG] [BAD] Returns a freed pointer -- very very bad.
/u2/engler/mc/oses/linux/2.4.4/fs/proc/generic.c:438:proc_symlink: ERROR:FREE:430:438: WARN: Use-after-free of "ent"! set by 'kfree':430
	ent->namelen = len;
	ent->nlink = 1;
	ent->mode = S_IFLNK|S_IRUGO|S_IWUGO|S_IXUGO;
	ent->data = kmalloc((ent->size=strlen(dest))+1, GFP_KERNEL);
	if (!ent->data) {
Start --->
		kfree(ent);
		goto out;
	}
	strcpy((char*)ent->data,dest);

	proc_register(parent, ent);
	
out:
Error --->
	return ent;
}

struct proc_dir_entry *proc_mknod(const char *name, mode_t mode,


############################################################
# errors common to both

#
---------------------------------------------------------
[BUG]  [GEM]  horrible horrible bug.
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/isdn/isdn_ppp.c:822:isdn_ppp_init: ERROR:FREE:822:822: WARN: Use-after-free of "ippp_table"! set by 'kfree':822
	for (i = 0; i < ISDN_MAX_CHANNELS; i++) {
		if (!(ippp_table[i] = (struct ippp_struct *)
		      kmalloc(sizeof(struct ippp_struct), GFP_KERNEL))) {
			printk(KERN_WARNING "isdn_ppp_init: Could not alloc ippp_table\n");
			for (j = 0; j < i; j++)

Error --->
				kfree(ippp_table[i]);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/atm/iphase.c:1323:rx_dle_intr: ERROR:FREE:1321:1323: WARN: Use-after-free of "skb"! set by 'dev_kfree_skb_any':1321
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
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/atm/iphase.c:1339:rx_dle_intr: ERROR:FREE:1337:1339: WARN: Use-after-free of "skb"! set by 'dev_kfree_skb_any':1337
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
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/sound/cs4281/cs4281m.c:4468:cs4281_remove: ERROR:FREE:4466:4468: WARN: Use-after-free of "s"! set by 'kfree':4466
	unregister_sound_dsp(s->dev_audio);
	unregister_sound_mixer(s->dev_mixer);
	unregister_sound_midi(s->dev_midi);
	iounmap(s->pBA1);
	iounmap(s->pBA0);
Start --->
	kfree(s);
	pci_set_drvdata(pci_dev,NULL);
Error --->
	list_del(&s->list);
	CS_DBGOUT(CS_INIT | CS_FUNCTION, 2, printk(KERN_INFO
		 "cs4281: cs4281_remove()-: remove successful\n"));
}
---------------------------------------------------------
[BUG] Again assumes kfree sets memory to NULL.
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/wan/lapbether.c:116:lapbeth_check_devices: ERROR:FREE:113:116: WARN: Use-after-free of "lapbeth"! set by 'kfree':113
			if (&lapbeth->axdev == dev)
				result = 1;

			unregister_netdev(&lapbeth->axdev);
			dev_put(lapbeth->ethdev);
Start --->
			kfree(lapbeth);
		}

Error --->
		lapbeth_prev = lapbeth;
	}

	restore_flags(flags);
---------------------------------------------------------
[BUG] bpq is freed, assigned to another variable (bpq_prev), then
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/hamradio/bpqether.c:196:bpq_check_devices: ERROR:FREE:193:196: WARN: Use-after-free of "bpq"! set by 'kfree':193
			/* We should be locked, call 
			 * unregister_netdevice directly 
			 */

			unregister_netdevice(&bpq->axdev);
Start --->
			kfree(bpq);
		}

Error --->
		bpq_prev = bpq;
	}

	restore_flags(flags);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/net/wanrouter/wanmain.c:617:device_setup: ERROR:FREE:614:617: WARN: Use-after-free of "conf"! set by 'kfree':614
	        return -EINVAL; 
	}

	if (conf->data_size && conf->data){
		if(conf->data_size > 128000 || conf->data_size < 0) {
Start --->
			kfree(conf);
			printk(KERN_INFO 
			    "%s: ERROR, Invalid firmware data size %i !\n",
Error --->
					wandev->name, conf->data_size);
		        return -EINVAL;;
		}

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/atm/iphase.c:1341:rx_dle_intr: ERROR:FREE:1337:1341: WARN: Use-after-free of "skb"! set by 'dev_kfree_skb_any':1337
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
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/net/netrom/nr_dev.c:122:nr_rebuild_header: ERROR:FREE:117:122: WARN: Use-after-free of "skbn"! set by 'kfree_skb':117
		skb_set_owner_w(skbn, skb->sk);

	kfree_skb(skb);

	if (!nr_route_frame(skbn, NULL)) {
Start --->
		kfree_skb(skbn);
		stats->tx_errors++;
	}

	stats->tx_packets++;
Error --->
	stats->tx_bytes += skbn->len;

	return 1;
}
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/net/ax25/ax25_ip.c:163:ax25_rebuild_header: ERROR:FREE:157:163: WARN: Use-after-free of "skb"! set by 'kfree_skb':157
			}

			if (skb->sk != NULL)
				skb_set_owner_w(ourskb, skb->sk);

Start --->
			kfree_skb(skb);

			src_c = *src;
			dst_c = *dst;

			skb_pull(ourskb, AX25_HEADER_LEN - 1);	/* Keep PID */
Error --->
			skb->nh.raw = skb->data;

			ax25_send_frame(ourskb, ax25_dev->values[AX25_VALUES_PACLEN], &src_c, 
&dst_c, route->digipeat, dev);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/usb/serial/io_edgeport.c:944:edge_bulk_out_cmd_callback: ERROR:FREE:937:944: WARN: Use-after-free of "urb"! set by 'usb_free_urb':937
		kfree(urb->transfer_buffer);
	}

	// Free the command urb
	usb_unlink_urb (urb);
Start --->
	usb_free_urb   (urb);

	if (port_paranoia_check (edge_port->port, __FUNCTION__)) {
		return;
	}

	if (status) {
Error --->
		dbg(__FUNCTION__" - nonzero write bulk status received: %d", urb->status);
		return;
	}

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/char/drm/gamma_dma.c:573:gamma_dma_send_buffers: ERROR:FREE:561:573: WARN: Use-after-free of "last_buf"! set by 'drm_free_buffer':561
		DRM_DEBUG("%d running\n", current->pid);
		remove_wait_queue(&last_buf->dma_wait, &entry);
		if (!retcode
		    || (last_buf->list==DRM_LIST_PEND && !last_buf->pending)) {
			if (!waitqueue_active(&last_buf->dma_wait)) {
Start --->
				drm_free_buffer(dev, last_buf);
			}
		}
		if (retcode) {
			DRM_ERROR("ctx%d w%d p%d c%d i%d l%d %d/%d\n",
				  d->context,
				  last_buf->waiting,
				  last_buf->pending,
				  DRM_WAITCOUNT(dev, d->context),
				  last_buf->idx,
				  last_buf->list,
				  last_buf->pid,
Error --->
				  current->pid);
		}
	}
	return retcode;

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/usb/dc2xx.c:332:camera_release: ERROR:FREE:330:332: WARN: Use-after-free of "camera"! set by 'kfree':330
	subminor = camera->subminor;

	/* If camera was unplugged with open file ... */
	if (!camera->dev) {
		minor_data [subminor] = NULL;
Start --->
		kfree (camera);
	}
Error --->
	up (&camera->sem);
	up (&state_table_mutex);

	dbg ("close #%d", subminor); 
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/char/rio/rio_linux.c:1036:rio_init_datastructures: ERROR:FREE:1031:1036: WARN: Use-after-free of "RIOHosts"! set by 'kfree':1031
        kfree (p->RIOPortp[i]);
/*free5: */
       kfree (rio_termios_locked); 
 free4:kfree (rio_termios);
 free3:kfree (p->RIOPortp);
Start --->
 free2:kfree (p->RIOHosts);
 free1:kfree (p);
 free0:
  if (p) {
	rio_dprintk (RIO_DEBUG_INIT, "Not enough memory! %p %p %p %p %p\n", 
Error --->
        	       p, p->RIOHosts, p->RIOPortp, rio_termios, rio_termios);
  }
  return -ENOMEM;
}
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/char/rio/rio_linux.c:1036:rio_init_datastructures: ERROR:FREE:1030:1036: WARN: Use-after-free of "RIOPortp"! set by 'kfree':1030
 free6:for (i--;i>=0;i--)
        kfree (p->RIOPortp[i]);
/*free5: */
       kfree (rio_termios_locked); 
 free4:kfree (rio_termios);
Start --->
 free3:kfree (p->RIOPortp);
 free2:kfree (p->RIOHosts);
 free1:kfree (p);
 free0:
  if (p) {
	rio_dprintk (RIO_DEBUG_INIT, "Not enough memory! %p %p %p %p %p\n", 
Error --->
        	       p, p->RIOHosts, p->RIOPortp, rio_termios, rio_termios);
  }
  return -ENOMEM;
}

