Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131554AbRCQGSa>; Sat, 17 Mar 2001 01:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131557AbRCQGSU>; Sat, 17 Mar 2001 01:18:20 -0500
Received: from elaine23.Stanford.EDU ([171.64.15.98]:40355 "EHLO
	elaine23.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S131554AbRCQGSR>; Sat, 17 Mar 2001 01:18:17 -0500
Date: Fri, 16 Mar 2001 22:17:30 -0800
From: Seth Andrew Hallem <shallem@Stanford.EDU>
To: linux-kernel@vger.kernel.org
Subject: Potential free/use-after-free bugs
Message-ID: <20010316221730.B17586@elaine23.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am another student of Dawson Engler's working on the meta-level
compilation project.  I have just finished processing the results of a
checker which looks for double frees and use-after-frees.  I think we have
found 12-14 bugs.  I also have some questions regarding skbs.  Our checker
found a lot of instances where the skb is freed, then its length field is
accessed.  I have included an example location below.  Is this a bug or
not?  It appears that the length field is not cleared as the skbs are
referenced counted and the state clearing leaves the length alone.  I am
unsure as to whether this is a bug, bad practice, or just fine, though.
Any help would be appreciated.  Thanks.

Seth Hallem

==========================================================================
[BUG] Returns a freed pointer.  Probably bad but I'm not sure.
/home/shallem/oses/linux/2.4.1/fs/proc/generic.c:438:proc_symlink:
ERROR:FREE:430:438: WARN: Use-after-free of "ent"! set by 'kfree':430

Start --->
		kfree(ent);
		goto out;
	}
	
out:
Error --->
	return ent;
}


[BUG] Potential double or more free.
/home/shallem/oses/linux/2.4.1/drivers/usb/serial/belkin_sa.c:236:belkin_sa_shutdown:
ERROR:FREE:237:236: Use-after-free of 'private'! set by 'kfree':237

		}
		/* My special items, the standard routines free my urbs */
		if (serial->port->private)
Error --->
Start --->
			kfree(serial->port->private);
	}

[BUG] Copy paste of above potential bug.
/home/shallem/oses/linux/2.4.1/drivers/usb/serial/mct_u232.c:277:mct_u232_shutdown:
ERROR:FREE:278:277: Use-after-free of 'private'! set by 'kfree':278

[BUG]
/home/shallem/oses/linux/2.4.1/drivers/sound/sound_core.c:178:sound_insert_unit:
ERROR:FREE:171:178: Use-after-free of 's'! set by 'kfree':171

	if(r<0)
Start --->
		kfree(s);
	if (r == low)
		sprintf (name_buf, "%s", name);
	else
		sprintf (name_buf, "%s%d", name, (r - low) / SOUND_STEP);
	s->de = devfs_register (devfs_handle, name_buf,
				DEVFS_FL_NONE, SOUND_MAJOR, s->unit_minor,
Error --->
				S_IFCHR | mode, fops, NULL);
	return r;


[BUG] Might be okay, but probably not a good idea.  Seems to put scb on
the free list, then derefs it in the call to ips_send_cmd.  Okay if this
is not interruptible?
/home/shallem/oses/linux/2.4.1/drivers/scsi/ips.c:2839:ips_next:
ERROR:FREE:2818:2839: WARN: Use-after-free of "scb"! set by
'ips_freescb':2818
Start --->
         ips_freescb(ha, scb);
         break;
      case IPS_SUCCESS_IMM:
         if (scb->scsi_cmd) {

	... DELETED lines ...

         IPS_QUEUE_LOCK(&ha->copp_waitlist);
         continue;
      }

Error --->
      ret = ips_send_cmd(ha, scb);

      if (ret == IPS_SUCCESS) {

[BUG] same as above.
/home/shallem/oses/linux/2.4.1/drivers/scsi/ips.c:2839:ips_next:
ERROR:FREE:2827:2839: WARN: Use-after-free of "scb"! set by
'ips_freescb':2827

[BUG] lapbeth_prev is dereferenced on the next iteration through the loop.
/home/shallem/oses/linux/2.4.1/drivers/net/wan/lapbether.c:116:lapbeth_check_devices:
ERROR:FREE:113:116: WARN: Use-after-free of "lapbeth"! set by 'kfree':113

Start --->
			kfree(lapbeth);
		}

Error --->
		lapbeth_prev = lapbeth;
	}	

[BUG] bpq is freed, assigned to another variable (bpq_prev), then
dereferenced on the next time through the loop.  Analogous to above case
with lapbeth_prev.
/home/shallem/oses/linux/2.4.1/drivers/net/hamradio/bpqether.c:196:bpq_check_devices:
ERROR:FREE:193:196: WARN: Use-after-free of "bpq"! set by 'kfree':193

[BUG] Derefs dev on next iteration unless dev is set to NULL.
/home/shallem/oses/linux/2.4.1/drivers/net/sundance.c:1233:sundance_remove1:
ERROR:FREE:1243:1233: Use-after-free of 'dev'! set by 'kfree':1243
	
Error --->
	while (dev) {
		struct netdev_private *np = (void *)(dev->priv);
		unregister_netdev(dev);
#ifdef USE_IO_OPS
		release_region(dev->base_addr, 
pci_id_tbl[np->chip_id].io_size);
#else
		release_mem_region(pci_resource_start(pdev, 1),
				   pci_id_tbl[np->chip_id].io_size);
		iounmap((char *)(dev->base_addr));
#endif
Start --->
		kfree(dev);
	}

[BUG]
/home/shallem/oses/linux/2.4.1/drivers/net/rcpci45.c:1265:RC_allocate_and_post_buffers:
ERROR:FREE:1264:1265: Use-after-free of 'p'! set by 'kfree':1264

Start --->
    kfree(p);
Error --->
    return(p[0]);                /* return the number of posted buffers */
}

[BUG]
/home/shallem/oses/linux/2.4.1/drivers/net/irda/nsc-ircc.c:319:nsc_ircc_open:
ERROR:FREE:318:319: Use-after-free of 'self'! set by 'kfree':318

Start --->
		kfree(self);
Error --->
		kfree(self->rx_buff.head);
		return -ENOMEM;

[BUG] The use of p is fine, but the derefs of p right after that probably
are not.  This is not as serious because it is in a print statement in an
error case.
/home/shallem/oses/linux/2.4.1/drivers/char/rio/rio_linux.c:1038:rio_init_datastructures:
ERROR:FREE:1035:1038: WARN: Use-after-free of "p"! set by 'kfree':1035

 free3:kfree (p->RIOPortp);
 free2:kfree (p->RIOHosts);
Start --->
 free1:kfree (p);
 free0:
  rio_dprintk (RIO_DEBUG_INIT, "Not enough memory! %p %p %p %p %p\n", 
Error --->
               p, p->RIOHosts, p->RIOPortp, rio_termios, rio_termios);
  return -ENOMEM;

[BUG] See code following next error.
/home/shallem/oses/linux/2.4.1/drivers/block/cciss.c:668:cciss_ioctl:
ERROR:FREE:664:668: Use-after-free of 'buff'! set by 'kfree':664

[BUG] Potential double free of c.
/home/shallem/oses/linux/2.4.1/drivers/block/cciss.c:667:cciss_ioctl:
ERROR:FREE:663:667: WARN: Use-after-free of "c"! set by 'cmd_free':663

          {
            cmd_free(NULL, c);
Start --->
            kfree(buff);
          }
      }
		cmd_free(NULL, c);
Error --->
    if (buff != NULL)
      kfree(buff);


[QUESTION] It appears that the len field is not cleared out by
dev_kfree_skb_any.  Is this true in general of the skb freeing functions?
It appears that the data field is also not cleared (except potentially by
the destructor function?).  Are there any other fields which are okay to 
use?
Also is it always bad to double free an skb, or is there some idiomatic
way to determine the current reference count on the skb?  Thanks for the
help.
/home/shallem/oses/linux/2.4.1/drivers/atm/iphase.c:1323:rx_dle_intr:
ERROR:FREE:1321:1323: Use-after-free of 'skb'! set by
'dev_kfree_skb_any':1321

          {
             atomic_inc(&vcc->stats->rx_err);
Start --->
             dev_kfree_skb_any(skb);
#if LINUX_VERSION_CODE >= 0x20312
Error --->
             atm_return(vcc, atm_guess_pdu2truesize(skb->len));
