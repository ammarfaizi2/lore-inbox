Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317938AbSGKXLp>; Thu, 11 Jul 2002 19:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317939AbSGKXLo>; Thu, 11 Jul 2002 19:11:44 -0400
Received: from p50886A23.dip.t-dialin.net ([80.136.106.35]:13188 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317938AbSGKXLc>; Thu, 11 Jul 2002 19:11:32 -0400
Date: Thu, 11 Jul 2002 17:14:09 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Dawson Engler <engler@csl.Stanford.EDU>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <mc@cs.Stanford.EDU>
Subject: Re: [CHECKER] 56 potential lock/unlock bugs in 2.5.8
In-Reply-To: <200207112135.OAA03801@csl.Stanford.EDU>
Message-ID: <Pine.LNX.4.44.0207111711530.26269-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the whole set.

A copy can be found at 
<URL:http://luckynet.dynu.com/~thunder/patches/checker.patch>
The ones I didn't handle can be found at 
<URL:http://luckynet.dynu.com/~thunder/patches/checker.text>

Index: mm/shmem.c
===================================================================
RCS file: /var/cvs/thunder-2.5/mm/shmem.c,v
retrieving revision 1.3
diff -p -u -r1.3 shmem.c
--- mm/shmem.c  6 Jul 2002 18:17:44 -0000       1.3
+++ mm/shmem.c  11 Jul 2002 21:47:22 -0000
@@ -607,6 +607,7 @@ repeat:
                if (error < 0) {
                        unlock_page(page);
                        page_cache_release(page);
+                       spin_unlock (&info->lock);
                        return ERR_PTR(error);
                }
Index: drivers/mtd/chips/cfi_cmdset_0001.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/mtd/chips/cfi_cmdset_0001.c,v
retrieving revision 1.1.1.1
diff -p -u -r1.1.1.1 cfi_cmdset_0001.c
--- drivers/mtd/chips/cfi_cmdset_0001.c 21 Jun 2002 22:17:29 -0000
1.1.1.1
+++ drivers/mtd/chips/cfi_cmdset_0001.c 11 Jul 2002 21:52:35 -0000
@@ -779,6 +779,7 @@ static inline int do_write_buffer(struct
                        map->write32 (map, *((__u32*)buf)++, adr+z);
                } else {
                        DISABLE_VPP(map);
+                       spin_unlock_bh(chip->mutex);
                        return -EINVAL;
                }
        }
Index: drivers/usb/class/printer.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/usb/class/printer.c,v
retrieving revision 1.2
diff -p -u -r1.2 printer.c
--- drivers/usb/class/printer.c	6 Jul 2002 18:17:14 -0000	1.2
+++ drivers/usb/class/printer.c	11 Jul 2002 21:56:49 -0000
@@ -654,8 +654,12 @@ static ssize_t usblp_write(struct file *
 		usblp->writeurb->transfer_buffer_length = (count - writecount) < USBLP_BUF_SIZE ?
 							  (count - writecount) : USBLP_BUF_SIZE;
 
-		if (copy_from_user(usblp->writeurb->transfer_buffer, buffer + writecount,
-				usblp->writeurb->transfer_buffer_length)) return -EFAULT;
+		if (copy_from_user(usblp->writeurb->transfer_buffer,
+				   buffer + writecount,
+				   usblp->writeurb->transfer_buffer_length)) {
+			up (&usblp->sem);
+			return -EFAULT;
+		}
 
 		usblp->writeurb->dev = usblp->dev;
 		usblp->wcomplete = 0;
Index: sound/core/pcm_lib.c
===================================================================
RCS file: /var/cvs/thunder-2.5/sound/core/pcm_lib.c,v
retrieving revision 1.1.1.1
diff -p -u -r1.1.1.1 pcm_lib.c
--- sound/core/pcm_lib.c	20 Jun 2002 22:53:51 -0000	1.1.1.1
+++ sound/core/pcm_lib.c	11 Jul 2002 22:00:26 -0000
@@ -1883,7 +1883,7 @@ static snd_pcm_sframes_t snd_pcm_lib_wri
 			frames = cont;
 		if (frames == 0 && runtime->status->state == SNDRV_PCM_STATE_PAUSED) {
 			err = -EPIPE;
-			goto _end;
+			goto _end_unlock;
 		}
 		snd_assert(frames != 0,
 			   spin_unlock_irq(&runtime->lock);
Index: fs/jfs/jfs_imap.c
===================================================================
RCS file: /var/cvs/thunder-2.5/fs/jfs/jfs_imap.c,v
retrieving revision 1.1.1.1
diff -p -u -r1.1.1.1 jfs_imap.c
--- fs/jfs/jfs_imap.c	20 Jun 2002 22:53:46 -0000	1.1.1.1
+++ fs/jfs/jfs_imap.c	11 Jul 2002 22:03:17 -0000
@@ -1453,6 +1453,7 @@ int diAlloc(struct inode *pip, boolean_t
 	iagno = INOTOIAG(inum);
 	if ((rc = diIAGRead(imap, iagno, &mp))) {
 		IREAD_UNLOCK(ipimap);
+		AG_UNLOCK(imap, agno);
 		return (rc);
 	}
 	iagp = (iag_t *) mp->data;
Index: drivers/net/tokenring/smctr.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/net/tokenring/smctr.c,v
retrieving revision 1.1.1.1
diff -p -u -r1.1.1.1 smctr.c
--- drivers/net/tokenring/smctr.c	19 Jun 2002 02:11:55 -0000	1.1.1.1
+++ drivers/net/tokenring/smctr.c	11 Jul 2002 22:11:01 -0000
@@ -4582,6 +4582,7 @@ static int smctr_rx_frame(struct net_dev
                         break;
         }
 
+	sti();
         return (err);
 }
 
Index: fs/hpfs/dir.c
===================================================================
RCS file: /var/cvs/thunder-2.5/fs/hpfs/dir.c,v
retrieving revision 1.1.1.1
diff -p -u -r1.1.1.1 dir.c
--- fs/hpfs/dir.c	19 Jun 2002 02:11:50 -0000	1.1.1.1
+++ fs/hpfs/dir.c	11 Jul 2002 22:12:53 -0000
@@ -211,7 +211,9 @@ struct dentry *hpfs_lookup(struct inode 
 
 	lock_kernel();
 	if ((err = hpfs_chk_name((char *)name, &len))) {
-		if (err == -ENAMETOOLONG) return ERR_PTR(-ENAMETOOLONG);
+		if (err == -ENAMETOOLONG) {
+			return ERR_PTR(-ENAMETOOLONG);
+		}
 		goto end_add;
 	}
 
Index: sound/pci/rme9652/rme9652.c
===================================================================
RCS file: /var/cvs/thunder-2.5/sound/pci/rme9652/rme9652.c,v
retrieving revision 1.1.1.1
diff -p -u -r1.1.1.1 rme9652.c
--- sound/pci/rme9652/rme9652.c	20 Jun 2002 22:53:51 -0000	1.1.1.1
+++ sound/pci/rme9652/rme9652.c	11 Jul 2002 22:15:24 -0000
@@ -523,6 +523,7 @@ static int rme9652_set_rate(rme9652_t *r
 		rate = RME9652_DS | RME9652_freq;
 		break;
 	default:
+		spin_unlock_irq(&rme9652->lock);
 		return -EINVAL;
 	}
 
Index: drivers/message/i2o/i2o_core.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/message/i2o/i2o_core.c,v
retrieving revision 1.1.1.1
diff -p -u -r1.1.1.1 i2o_core.c
--- drivers/message/i2o/i2o_core.c	19 Jun 2002 02:11:56 -0000	1.1.1.1
+++ drivers/message/i2o/i2o_core.c	11 Jul 2002 22:22:10 -0000
@@ -726,6 +726,7 @@ int i2o_claim_device(struct i2o_device *
 			   I2O_CLAIM_PRIMARY))
 	{
 		d->owner = NULL;
+		up(&i2o_configuration_lock);
 		return -EBUSY;
 	}
 	up(&i2o_configuration_lock);
Index: sound/pci/es1968.c
===================================================================
RCS file: /var/cvs/thunder-2.5/sound/pci/es1968.c,v
retrieving revision 1.1.1.1
diff -p -u -r1.1.1.1 es1968.c
--- sound/pci/es1968.c	20 Jun 2002 22:53:55 -0000	1.1.1.1
+++ sound/pci/es1968.c	11 Jul 2002 22:24:04 -0000
@@ -1446,8 +1446,10 @@ static esm_memory_t *snd_es1968_new_memo
 __found:
 	if (buf->size > size) {
 		esm_memory_t *chunk = kmalloc(sizeof(*chunk), GFP_KERNEL);
-		if (chunk == NULL)
+		if (chunk == NULL) {
+			up(&chip->memory_mutex);
 			return NULL;
+		}
 		chunk->size = buf->size - size;
 		chunk->buf = buf->buf + size;
 		chunk->addr = buf->addr + size;
Index: sound/oss/es1371.c
===================================================================
RCS file: /var/cvs/thunder-2.5/sound/oss/es1371.c,v
retrieving revision 1.1.1.1
diff -p -u -r1.1.1.1 es1371.c
--- sound/oss/es1371.c	19 Jun 2002 02:11:49 -0000	1.1.1.1
+++ sound/oss/es1371.c	11 Jul 2002 22:32:23 -0000
@@ -1345,7 +1345,7 @@ static ssize_t es1371_read(struct file *
 		return -EFAULT;
 	down(&s->sem);
 	if (!s->dma_adc.ready && (ret = prog_dmabuf_adc(s)))
-		goto out2;
+		goto out;
 	
 	add_wait_queue(&s->dma_adc.wait, &wait);
 	while (count > 0) {
@@ -1423,8 +1423,10 @@ static ssize_t es1371_write(struct file 
 	if (!access_ok(VERIFY_READ, buffer, count))
 		return -EFAULT;
 	down(&s->sem);	
-	if (!s->dma_dac2.ready && (ret = prog_dmabuf_dac2(s)))
+	if (!s->dma_dac2.ready && (ret = prog_dmabuf_dac2(s))) {
+		up(&s->sem);
 		goto out3;
+	}
 	ret = 0;
 	add_wait_queue(&s->dma_dac2.wait, &wait);
 	while (count > 0) {
Index: net/irda/ircomm/ircomm_core.c
===================================================================
RCS file: /var/cvs/thunder-2.5/net/irda/ircomm/ircomm_core.c,v
retrieving revision 1.1.1.1
diff -p -u -r1.1.1.1 ircomm_core.c
--- net/irda/ircomm/ircomm_core.c	20 Jun 2002 22:53:41 -0000	1.1.1.1
+++ net/irda/ircomm/ircomm_core.c	11 Jul 2002 22:34:37 -0000
@@ -536,6 +536,7 @@ int ircomm_proc_read(char *buf, char **s
 		self = (struct ircomm_cb *) hashbin_get_next(ircomm);
  	} 
 	restore_flags(flags);
+	sti();
 
 	return len;
 }
Index: fs/affs/namei.c
===================================================================
RCS file: /var/cvs/thunder-2.5/fs/affs/namei.c,v
retrieving revision 1.1.1.1
diff -p -u -r1.1.1.1 namei.c
--- fs/affs/namei.c	19 Jun 2002 02:11:51 -0000	1.1.1.1
+++ fs/affs/namei.c	11 Jul 2002 22:36:41 -0000
@@ -345,10 +345,14 @@ affs_rmdir(struct inode *dir, struct den
 	lock_kernel();
 
 	/* WTF??? */
+	res = -ENOENT;
+
 	if (!dentry->d_inode)
-		return -ENOENT;
+		goto out_unlock;
 
 	res = affs_remove_header(dentry);
+
+ out_unlock:
 	unlock_kernel();
 	return res;
 }
Index: fs/intermezzo/file.c
===================================================================
RCS file: /var/cvs/thunder-2.5/fs/intermezzo/file.c,v
retrieving revision 1.2
diff -p -u -r1.2 file.c
--- fs/intermezzo/file.c	23 Jun 2002 01:17:59 -0000	1.2
+++ fs/intermezzo/file.c	11 Jul 2002 22:38:24 -0000
@@ -299,12 +299,13 @@ static void presto_apply_write_policy(st
                          if ( presto_get_permit(file->f_dentry->d_inode) < 0 ) {
                                  EXIT;
                                  /* we must be disconnected, not to worry */
-                                return; 
+				 unlock_kernel();
+				 return;
                          }
                          error = presto_journal_close
                                 (&rec, fset, file, file->f_dentry, &new_file_ver);
                          presto_put_permit(file->f_dentry->d_inode);
-                        unlock_kernel();
+			 unlock_kernel();
                          if ( error ) {
                                  printk("presto_close: cannot journal close\n");
                                  /* XXX these errors are really bad */
Index: fs/intermezzo/vfs.c
===================================================================
RCS file: /var/cvs/thunder-2.5/fs/intermezzo/vfs.c,v
retrieving revision 1.2
diff -p -u -r1.2 vfs.c
--- fs/intermezzo/vfs.c	23 Jun 2002 01:18:00 -0000	1.2
+++ fs/intermezzo/vfs.c	11 Jul 2002 22:41:42 -0000
@@ -1948,6 +1948,7 @@ again:  /* look the named file or a pare
         error = presto_walk(tmp, &nd);
         if ( error && error != -ENOENT ) {
                 EXIT;
+		unlock_kernel();
                 return error;
         } 
         if (error == -ENOENT)
@@ -2049,6 +2050,7 @@ int lento_close(unsigned int fd, struct 
                 error = filp_close(filp, files);
         } else {
                 EXIT;
+		unlock_kernel();
                 return error;
         }
 
Index: drivers/ieee1394/dv1394.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/ieee1394/dv1394.c,v
retrieving revision 1.2
diff -p -u -r1.2 dv1394.c
--- drivers/ieee1394/dv1394.c	22 Jun 2002 01:13:34 -0000	1.2
+++ drivers/ieee1394/dv1394.c	11 Jul 2002 22:46:09 -0000
@@ -2627,6 +2627,7 @@ dv1394_devfs_find( char *name)
 			}
 		}
 	}
+	spin_unlock(&dv1394_devfs_lock);
 	return NULL;
 }
 
Index: sound/pci/ali5451/ali5451.c
===================================================================
RCS file: /var/cvs/thunder-2.5/sound/pci/ali5451/ali5451.c,v
retrieving revision 1.1.1.1
diff -p -u -r1.1.1.1 ali5451.c
--- sound/pci/ali5451/ali5451.c	19 Jun 2002 02:11:58 -0000	1.1.1.1
+++ sound/pci/ali5451/ali5451.c	11 Jul 2002 22:49:43 -0000
@@ -1440,8 +1440,10 @@ static int snd_ali_capture_prepare(snd_p
 
 		unsigned int rate;
 		
-		if (codec->revision != ALI_5451_V02)
+		if (codec->revision != ALI_5451_V02) {
+			spin_lock_irqsave(&codec->reg_lock, flags);
 			return -1;
+		}
 		rate = snd_ali_get_spdif_in_rate(codec);
 		if (rate == 0) {
 			snd_printk("ali_capture_preapre: spdif rate detect err!\n");
Index: drivers/media/video/cpia_pp.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/media/video/cpia_pp.c,v
retrieving revision 1.1.1.1
diff -p -u -r1.1.1.1 cpia_pp.c
--- drivers/media/video/cpia_pp.c	21 Jun 2002 02:28:37 -0000	1.1.1.1
+++ drivers/media/video/cpia_pp.c	11 Jul 2002 22:51:26 -0000
@@ -616,6 +616,7 @@ static void cpia_pp_detach (struct parpo
 			break;
 		}
 	}
+	spin_unlock( &cam_list_lock_pp );
 }
 
 static void cpia_pp_attach (struct parport *port)
Index: drivers/usb/media/usbvideo.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/usb/media/usbvideo.c,v
retrieving revision 1.1.1.1
diff -p -u -r1.1.1.1 usbvideo.c
--- drivers/usb/media/usbvideo.c	19 Jun 2002 02:11:55 -0000	1.1.1.1
+++ drivers/usb/media/usbvideo.c	11 Jul 2002 22:54:54 -0000
@@ -1096,6 +1096,7 @@ uvd_t *usbvideo_AllocateDevice(usbvideo_
 		if (uvd->sbuf[i].urb == NULL) {
 			err("usb_alloc_urb(%d.) failed.", FRAMES_PER_DESC);
 			uvd->uvd_used = 0;
+			up(&uvd->lock);
 			uvd = NULL;
 			goto allocate_done;
 		}
@@ -1112,8 +1113,8 @@ uvd_t *usbvideo_AllocateDevice(usbvideo_
 	 * The client is free to overwrite those because we
 	 * return control to the client's probe function right now.
 	 */
-allocate_done:
 	up (&uvd->lock);
+ allocate_done:
 	usbvideo_ClientDecModCount(uvd);
 	return uvd;
 }
Index: drivers/i2c/i2c-core.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/i2c/i2c-core.c,v
retrieving revision 1.1.1.1
diff -p -u -r1.1.1.1 i2c-core.c
--- drivers/i2c/i2c-core.c	21 Jun 2002 22:17:01 -0000	1.1.1.1
+++ drivers/i2c/i2c-core.c	11 Jul 2002 23:01:13 -0000
@@ -231,6 +231,7 @@ int i2c_del_adapter(struct i2c_adapter *
 				printk(KERN_WARNING "i2c-core.o: can't detach adapter %s "
 				       "while detaching driver %s: driver not "
 				       "detached!",adap->name,drivers[j]->name);
+				ADAP_UNLOCK();
 				goto ERROR1;	
 			}
 	DRV_UNLOCK();
@@ -364,6 +365,7 @@ int i2c_del_driver(struct i2c_driver *dr
 				       "not unloaded!",driver->name,
 				       adap->name);
 				ADAP_UNLOCK();
+				DRV_UNLOCK();
 				return res;
 			}
 		} else {
@@ -388,6 +390,7 @@ int i2c_del_driver(struct i2c_driver *dr
 						       client->addr,
 						       adap->name);
 						ADAP_UNLOCK();
+						DRV_UNLOCK();
 						return res;
 					}
 				}
Index: drivers/net/irda/ali-ircc.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/net/irda/ali-ircc.c,v
retrieving revision 1.1.1.1
diff -p -u -r1.1.1.1 ali-ircc.c
--- drivers/net/irda/ali-ircc.c	20 Jun 2002 22:53:50 -0000	1.1.1.1
+++ drivers/net/irda/ali-ircc.c	11 Jul 2002 23:03:07 -0000
@@ -2027,11 +2027,11 @@ static int ali_ircc_net_ioctl(struct net
 	ASSERT(self != NULL, return -1;);
 
 	IRDA_DEBUG(2, __FUNCTION__ "(), %s, (cmd=0x%X)\n", dev->name, cmd);
-	
+
 	/* Disable interrupts & save flags */
 	save_flags(flags);
-	cli();	
-	
+	cli();
+
 	switch (cmd) {
 	case SIOCSBANDWIDTH: /* Set bandwidth */
 		IRDA_DEBUG(1, __FUNCTION__ "(), SIOCSBANDWIDTH\n");
@@ -2040,8 +2040,10 @@ static int ali_ircc_net_ioctl(struct net
 		 * speed, so we still must allow for speed change within
 		 * interrupt context.
 		 */
-		if (!in_interrupt() && !capable(CAP_NET_ADMIN))
+		if (!in_interrupt() && !capable(CAP_NET_ADMIN)) {
+			sti();
 			return -EPERM;
+		}
 		
 		ali_ircc_change_speed(self, irq->ifr_baudrate);		
 		break;
Index: drivers/char/rio/riointr.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/char/rio/riointr.c,v
retrieving revision 1.1.1.1
diff -p -u -r1.1.1.1 riointr.c
--- drivers/char/rio/riointr.c	19 Jun 2002 02:11:44 -0000	1.1.1.1
+++ drivers/char/rio/riointr.c	11 Jul 2002 23:04:53 -0000
@@ -155,8 +155,8 @@ struct rio_info *	p;
 			RIOServiceHost(p, HostP, 'p' );
 			rio_spin_lock( &HostP->HostLock); 
 			HostP->InIntr = 0;
-			rio_spin_unlock (&HostP->HostLock);
 		}
+		rio_spin_unlock (&HostP->HostLock);
 	}
 	rio_spin_unlock (&p->RIOIntrSem); 
 }
Index: drivers/usb/media/pwc-if.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/usb/media/pwc-if.c,v
retrieving revision 1.1.1.1
diff -p -u -r1.1.1.1 pwc-if.c
--- drivers/usb/media/pwc-if.c	19 Jun 2002 02:11:57 -0000	1.1.1.1
+++ drivers/usb/media/pwc-if.c	11 Jul 2002 23:07:01 -0000
@@ -1756,19 +1756,23 @@ static void usb_pwc_disconnect(struct us
 	pdev = (struct pwc_device *)ptr;
 	if (pdev == NULL) {
 		Err("pwc_disconnect() Called without private pointer.\n");
+		unlock_kernel();
 		return;
 	}
 	if (pdev->udev == NULL) {
 		Err("pwc_disconnect() already called for %p\n", pdev);
+		unlock_kernel();
 		return;
 	}
 	if (pdev->udev != udev) {
 		Err("pwc_disconnect() Woops: pointer mismatch udev/pdev.\n");
+		unlock_kernel();
 		return;
 	}
 #ifdef PWC_MAGIC	
 	if (pdev->magic != PWC_MAGIC) {
 		Err("pwc_disconnect() Magic number failed. Consult your scrolls and try again.\n");
+		unlock_kernel();
 		return;
 	}
 #endif	
							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

