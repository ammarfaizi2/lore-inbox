Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261741AbRE3SSz>; Wed, 30 May 2001 14:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261782AbRE3SSg>; Wed, 30 May 2001 14:18:36 -0400
Received: from ns01.vbnet.com.br ([200.230.208.6]:45498 "EHLO
	iron.vbnet.com.br") by vger.kernel.org with ESMTP
	id <S261741AbRE3SSZ>; Wed, 30 May 2001 14:18:25 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carlos E Gorges <carlos@techlinux.com.br>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 245-ac4
Date: Wed, 30 May 2001 15:18:16 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01053015181600.08588@shark.techlinux>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch remove some NULL parameters tests in kfree-like functions and add this directly in function.

- dev_kfree_skb_irq == dev_kfree_skb == kfree_skb 
- kfree already handle null parameters :
void kfree (const void *objp)
{
        kmem_cache_t *c;
        unsigned long flags;
 
>>       if (!objp)
>>               return;
 
       local_irq_save(flags);
        CHECK_PAGE(virt_to_page(objp));
        c = GET_PAGE_CACHE(virt_to_page(objp));
        __kmem_cache_free(c, (void*)objp);
        local_irq_restore(flags);
}


diff -ur --exclude=*~ --exclude=*.rej linux-245ac/arch/i386/kernel/mtrr.c linux-245ac-carlos/arch/i386/kernel/mtrr.c
--- linux-245ac/arch/i386/kernel/mtrr.c	Thu May 24 18:14:08 2001
+++ linux-245ac-carlos/arch/i386/kernel/mtrr.c	Wed May 30 13:25:13 2001
@@ -966,7 +966,7 @@
 /*  Free resources associated with a struct mtrr_state  */
 static void __init finalize_mtrr_state(struct mtrr_state *state)
 {
-    if (state->var_ranges) kfree (state->var_ranges);
+    kfree (state->var_ranges);
 }   /*  End Function finalize_mtrr_state  */
 
 
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/arch/ia64/kernel/efivars.c linux-245ac-carlos/arch/ia64/kernel/efivars.c
--- linux-245ac/arch/ia64/kernel/efivars.c	Thu Apr  5 15:51:47 2001
+++ linux-245ac-carlos/arch/ia64/kernel/efivars.c	Wed May 30 13:25:29 2001
@@ -163,8 +163,8 @@
 	efivar_entry_t *new_efivar = kmalloc(sizeof(efivar_entry_t),
 					     GFP_KERNEL);
 	if (!short_name || !new_efivar)  {
-		if (short_name)        kfree(short_name);
-		if (new_efivar)        kfree(new_efivar);
+		kfree(short_name);
+		kfree(new_efivar);
 		return 1;
 	}
 	memset(short_name, 0, short_name_size+1);
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/arch/sparc64/kernel/ioctl32.c linux-245ac-carlos/arch/sparc64/kernel/ioctl32.c
--- linux-245ac/arch/sparc64/kernel/ioctl32.c	Wed May 30 14:03:46 2001
+++ linux-245ac-carlos/arch/sparc64/kernel/ioctl32.c	Wed May 30 13:27:53 2001
@@ -1024,10 +1024,10 @@
 	if (err)
 		err = -EFAULT;
 
-out:	if (cmap.red) kfree(cmap.red);
-	if (cmap.green) kfree(cmap.green);
-	if (cmap.blue) kfree(cmap.blue);
-	if (cmap.transp) kfree(cmap.transp);
+out:	kfree(cmap.red);
+	kfree(cmap.green);
+	kfree(cmap.blue);
+	kfree(cmap.transp);
 	return err;
 }
 
@@ -1356,7 +1356,7 @@
 	if (err)
 		err = -EFAULT;
 
-out:	if (karg) kfree(karg);
+out:	kfree(karg);
 	return err;
 }
 
@@ -2222,6 +2222,7 @@
 
 static void put_lv_t(lv_t *l)
 {
+	if(!l) return;
 	if (l->lv_current_pe) vfree(l->lv_current_pe);
 	if (l->lv_block_exception) vfree(l->lv_block_exception);
 	kfree(l);
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/arch/um/fs/hostfs/hostfs_kern.c linux-245ac-carlos/arch/um/fs/hostfs/hostfs_kern.c
--- linux-245ac/arch/um/fs/hostfs/hostfs_kern.c	Wed May 30 04:19:34 2001
+++ linux-245ac-carlos/arch/um/fs/hostfs/hostfs_kern.c	Wed May 30 13:24:24 2001
@@ -110,7 +110,7 @@
 
 void hostfs_delete_inode(struct inode *ino)
 {
-	if(ino->u.generic_ip) kfree(ino->u.generic_ip);
+	kfree(ino->u.generic_ip);
 	ino->u.generic_ip = NULL;
 	clear_inode(ino);
 }
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/arch/um/kernel/process_kern.c linux-245ac-carlos/arch/um/kernel/process_kern.c
--- linux-245ac/arch/um/kernel/process_kern.c	Wed May 30 04:19:34 2001
+++ linux-245ac-carlos/arch/um/kernel/process_kern.c	Wed May 30 13:24:49 2001
@@ -584,7 +584,7 @@
 
 	if(t == NULL) task = current;
 	else task = t;
-	if(task->thread.altstack != NULL) kfree(task->thread.altstack);
+	kfree(task->thread.altstack);
 	n = PAGE_SIZE - (sp & ~PAGE_MASK);
 	stack = kmalloc(n, GFP_KERNEL);
 	if(stack == NULL) panic("save_altstack : kmalloc failed");
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/drivers/atm/ambassador.c linux-245ac-carlos/drivers/atm/ambassador.c
--- linux-245ac/drivers/atm/ambassador.c	Wed May 30 04:19:34 2001
+++ linux-245ac-carlos/drivers/atm/ambassador.c	Wed May 30 13:36:53 2001
@@ -458,6 +458,7 @@
 /********** free an skb (as per ATM device driver documentation) **********/
 
 static inline void amb_kfree_skb (struct sk_buff * skb) {
+  if(!skb) return;
   if (ATM_SKB(skb)->vcc->pop) {
     ATM_SKB(skb)->vcc->pop (ATM_SKB(skb)->vcc, skb);
   } else {
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/drivers/atm/eni.c linux-245ac-carlos/drivers/atm/eni.c
--- linux-245ac/drivers/atm/eni.c	Wed May 16 13:22:50 2001
+++ linux-245ac-carlos/drivers/atm/eni.c	Wed May 30 13:58:15 2001
@@ -487,7 +487,7 @@
 	if (paddr)
 		pci_unmap_single(eni_dev->pci_dev,paddr,skb->len,
 		    PCI_DMA_FROMDEVICE);
-	if (skb) dev_kfree_skb_irq(skb);
+	dev_kfree_skb_irq(skb);
 	return -1;
 }
 
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/drivers/atm/zatm.c linux-245ac-carlos/drivers/atm/zatm.c
--- linux-245ac/drivers/atm/zatm.c	Wed May 30 04:19:34 2001
+++ linux-245ac-carlos/drivers/atm/zatm.c	Wed May 30 13:41:26 2001
@@ -1100,7 +1100,7 @@
 		zatm_dev->tx_bw += vcc->qos.txtp.min_pcr;
 		dealloc_shaper(vcc->dev,zatm_vcc->shaper);
 	}
-	if (zatm_vcc->ring) kfree(zatm_vcc->ring);
+	kfree(zatm_vcc->ring);
 }
 
 
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/drivers/fc4/fc.c linux-245ac-carlos/drivers/fc4/fc.c
--- linux-245ac/drivers/fc4/fc.c	Fri Feb  9 14:30:23 2001
+++ linux-245ac-carlos/drivers/fc4/fc.c	Wed May 30 13:41:53 2001
@@ -559,8 +559,8 @@
 	l->logi = kmalloc (count * 3 * sizeof(logi), GFP_KERNEL);
 	l->fcmds = kmalloc (count * sizeof(fcp_cmnd), GFP_KERNEL);
 	if (!l->logi || !l->fcmds) {
-		if (l->logi) kfree (l->logi);
-		if (l->fcmds) kfree (l->fcmds);
+		kfree (l->logi);
+		kfree (l->fcmds);
 		kfree (l);
 		printk ("FC: Cannot allocate DMA memory for initialization\n");
 		return -ENOMEM;
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/drivers/ieee1394/ohci1394.c linux-245ac-carlos/drivers/ieee1394/ohci1394.c
--- linux-245ac/drivers/ieee1394/ohci1394.c	Fri Mar  2 21:38:38 2001
+++ linux-245ac-carlos/drivers/ieee1394/ohci1394.c	Wed May 30 13:49:28 2001
@@ -1612,7 +1612,7 @@
 		kfree((*d)->prg_cpu);
 		kfree((*d)->prg_bus);
 	}
-	if ((*d)->spb) kfree((*d)->spb);
+	kfree((*d)->spb);
 	
 	kfree(*d);
 	*d = NULL;
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/drivers/ieee1394/video1394.c linux-245ac-carlos/drivers/ieee1394/video1394.c
--- linux-245ac/drivers/ieee1394/video1394.c	Wed May 30 04:19:37 2001
+++ linux-245ac-carlos/drivers/ieee1394/video1394.c	Wed May 30 13:50:21 2001
@@ -277,13 +277,13 @@
 
 	if ((*d)->ir_prg) {
 		for (i=0;i<(*d)->num_desc;i++) 
-			if ((*d)->ir_prg[i]) kfree((*d)->ir_prg[i]);
+			kfree((*d)->ir_prg[i]);
 		kfree((*d)->ir_prg);
 	}
 
 	if ((*d)->it_prg) {
 		for (i=0;i<(*d)->num_desc;i++) 
-			if ((*d)->it_prg[i]) kfree((*d)->it_prg[i]);
+			kfree((*d)->it_prg[i]);
 		kfree((*d)->it_prg);
 	}
 
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/drivers/isdn/avmb1/capi.c linux-245ac-carlos/drivers/isdn/avmb1/capi.c
--- linux-245ac/drivers/isdn/avmb1/capi.c	Sat May 19 20:54:14 2001
+++ linux-245ac-carlos/drivers/isdn/avmb1/capi.c	Wed May 30 13:46:46 2001
@@ -262,7 +262,7 @@
 	while (*pp) {
 		if (*pp == mp) {
 			*pp = (*pp)->next;
-			if (mp->ttyskb) kfree_skb(mp->ttyskb);
+			kfree_skb(mp->ttyskb);
 			mp->ttyskb = 0;
 			while ((skb = skb_dequeue(&mp->recvqueue)) != 0)
 				kfree_skb(skb);
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/drivers/net/defxx.c linux-245ac-carlos/drivers/net/defxx.c
--- linux-245ac/drivers/net/defxx.c	Fri Apr 20 14:54:23 2001
+++ linux-245ac-carlos/drivers/net/defxx.c	Wed May 30 13:43:45 2001
@@ -3339,7 +3339,7 @@
 
 	unregister_netdev(dev);
 	release_region(dev->base_addr,  pdev ? PFI_K_CSR_IO_LEN : PI_ESIC_K_CSR_IO_LEN );
-	if (bp->kmalloced) kfree(bp->kmalloced);
+	kfree(bp->kmalloced);
 	kfree(dev);
 }
 
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/drivers/net/strip.c linux-245ac-carlos/drivers/net/strip.c
--- linux-245ac/drivers/net/strip.c	Sun Feb  4 13:05:30 2001
+++ linux-245ac-carlos/drivers/net/strip.c	Wed May 30 13:45:37 2001
@@ -945,9 +945,9 @@
         strip_info->mtu     = dev->mtu;
         return(1);
     }
-    if (r) kfree(r);
-    if (s) kfree(s);
-    if (t) kfree(t);
+    kfree(r);
+    kfree(s);
+    kfree(t);
     return(0);
 }
 
@@ -1020,9 +1020,9 @@
     printk(KERN_NOTICE "%s: strip MTU changed fom %d to %d.\n",
         strip_info->dev.name, old_mtu, strip_info->mtu);
 
-    if (orbuff) kfree(orbuff);
-    if (osbuff) kfree(osbuff);
-    if (otbuff) kfree(otbuff);
+    kfree(orbuff);
+    kfree(osbuff);
+    kfree(otbuff);
 }
 
 static void strip_unlock(struct strip *strip_info)
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/drivers/net/wan/comx-hw-comx.c linux-245ac-carlos/drivers/net/wan/comx-hw-comx.c
--- linux-245ac/drivers/net/wan/comx-hw-comx.c	Tue May 22 13:23:16 2001
+++ linux-245ac-carlos/drivers/net/wan/comx-hw-comx.c	Wed May 30 13:43:32 2001
@@ -1079,9 +1079,7 @@
 		    && hw->firmware->len < count + file->f_pos) {
 			memcpy(tmp, hw->firmware->data, hw->firmware->len);
 		}
-		if (hw->firmware->data) {
-			kfree(hw->firmware->data);
-		}
+		kfree(hw->firmware->data);
 		copy_from_user(tmp + file->f_pos, buffer, count);
 		hw->firmware->len = entry->size = file->f_pos + count;
 		hw->firmware->data = tmp;
@@ -1367,7 +1365,7 @@
 	struct comx_privdata *hw = ch->HW_privdata;
 
 	if (hw->firmware) {
-		if (hw->firmware->data) kfree(hw->firmware->data);
+		kfree(hw->firmware->data);
 		kfree(hw->firmware);
 	} if (ch->twin) {
 		struct comx_channel *twin_ch = ch->twin->priv;
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/drivers/net/wan/comx.c linux-245ac-carlos/drivers/net/wan/comx.c
--- linux-245ac/drivers/net/wan/comx.c	Tue May 22 13:23:16 2001
+++ linux-245ac-carlos/drivers/net/wan/comx.c	Wed May 30 13:42:31 2001
@@ -644,7 +644,7 @@
 			unsigned long flags;
 
 			save_flags(flags); cli();
-			if (ch->debug_area) kfree(ch->debug_area);
+			kfree(ch->debug_area);
 			if ((ch->debug_area = kmalloc(ch->debug_size = i, 
 				GFP_KERNEL)) == NULL) {
 				ret = -ENOMEM;
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/drivers/s390/char/tape.c linux-245ac-carlos/drivers/s390/char/tape.c
--- linux-245ac/drivers/s390/char/tape.c	Wed Apr 11 22:02:28 2001
+++ linux-245ac-carlos/drivers/s390/char/tape.c	Wed May 30 13:47:29 2001
@@ -766,8 +766,8 @@
                 debug_int_event (tape_debug_area,6,temp->devinfo.irq);
 #endif /* TAPE_DEBUG */
 		free_irq (temp->devinfo.irq, &(temp->devstat));
-                if (temp->discdata) kfree (temp->discdata);
-                if (temp->kernbuf) kfree (temp->kernbuf);
+                kfree (temp->discdata);
+                kfree (temp->kernbuf);
                 if (temp->cqr) tape_free_request(temp->cqr);
 #ifdef CONFIG_DEVFS_FS
                 for (frontend=first_frontend;frontend!=NULL;frontend=frontend->next)
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/drivers/scsi/eata.c linux-245ac-carlos/drivers/scsi/eata.c
--- linux-245ac/drivers/scsi/eata.c	Sat May 19 20:43:06 2001
+++ linux-245ac-carlos/drivers/scsi/eata.c	Wed May 30 13:48:14 2001
@@ -2059,7 +2059,7 @@
    }
 
    for (i = 0; i < sh[j]->can_queue; i++)
-      if ((&HD(j)->cp[i])->sglist) kfree((&HD(j)->cp[i])->sglist);
+      kfree((&HD(j)->cp[i])->sglist);
 
    free_irq(sh[j]->irq, &sha[j]);
 
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/drivers/scsi/ide-scsi.c linux-245ac-carlos/drivers/scsi/ide-scsi.c
--- linux-245ac/drivers/scsi/ide-scsi.c	Fri Feb  9 14:30:23 2001
+++ linux-245ac-carlos/drivers/scsi/ide-scsi.c	Wed May 30 13:47:53 2001
@@ -790,8 +790,8 @@
 	spin_lock_irq(&io_request_lock);
 	return 0;
 abort:
-	if (pc) kfree (pc);
-	if (rq) kfree (rq);
+	kfree (pc);
+	kfree (rq);
 	cmd->result = DID_ERROR << 16;
 	done(cmd);
 	return 0;
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/drivers/scsi/u14-34f.c linux-245ac-carlos/drivers/scsi/u14-34f.c
--- linux-245ac/drivers/scsi/u14-34f.c	Sat May 19 20:43:06 2001
+++ linux-245ac-carlos/drivers/scsi/u14-34f.c	Wed May 30 13:48:36 2001
@@ -1745,7 +1745,7 @@
    }
 
    for (i = 0; i < sh[j]->can_queue; i++)
-      if ((&HD(j)->cp[i])->sglist) kfree((&HD(j)->cp[i])->sglist);
+      kfree((&HD(j)->cp[i])->sglist);
 
    free_irq(sh[j]->irq, &sha[j]);
 
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/drivers/sound/maestro.c linux-245ac-carlos/drivers/sound/maestro.c
--- linux-245ac/drivers/sound/maestro.c	Wed May 30 04:19:41 2001
+++ linux-245ac-carlos/drivers/sound/maestro.c	Wed May 30 13:49:09 2001
@@ -2349,7 +2349,7 @@
 	}
 
 rec_return_free:
-	if(combbuf) kfree(combbuf);
+	kfree(combbuf);
 	return ret;
 }
 
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/drivers/usb/hid-core.c linux-245ac-carlos/drivers/usb/hid-core.c
--- linux-245ac/drivers/usb/hid-core.c	Wed May 30 04:19:42 2001
+++ linux-245ac-carlos/drivers/usb/hid-core.c	Wed May 30 13:46:16 2001
@@ -529,7 +529,7 @@
 		}
 	}
 
-	if (device->rdesc) kfree(device->rdesc);
+	kfree(device->rdesc);
 }
 
 /*
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/fs/devfs/base.c linux-245ac-carlos/fs/devfs/base.c
--- linux-245ac/fs/devfs/base.c	Wed May 30 04:19:43 2001
+++ linux-245ac-carlos/fs/devfs/base.c	Wed May 30 13:53:03 2001
@@ -1395,7 +1395,7 @@
     if ( S_ISLNK (de->mode) )
     {
 	de->registered = FALSE;
-	if (de->u.symlink.linkname != NULL) kfree (de->u.symlink.linkname);
+	kfree (de->u.symlink.linkname);
 	de->u.symlink.linkname = NULL;
 	return;
     }
@@ -1518,7 +1518,7 @@
 	kfree (de);
 	return -ENOMEM;
     }
-    if (de->u.symlink.linkname != NULL) kfree (de->u.symlink.linkname);
+    kfree (de->u.symlink.linkname);
     de->u.symlink.linkname = newname;
     memcpy (de->u.symlink.linkname, link, linklength);
     de->u.symlink.linkname[linklength] = '\0';
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/fs/hpfs/dnode.c linux-245ac-carlos/fs/hpfs/dnode.c
--- linux-245ac/fs/hpfs/dnode.c	Tue Sep  5 17:07:29 2000
+++ linux-245ac-carlos/fs/hpfs/dnode.c	Wed May 30 13:51:38 2001
@@ -236,12 +236,12 @@
 	go_up:
 	if (namelen >= 256) {
 		hpfs_error(i->i_sb, "hpfs_add_to_dnode: namelen == %d", namelen);
-		if (nd) kfree(nd);
+		kfree(nd);
 		kfree(nname);
 		return 1;
 	}
 	if (!(d = hpfs_map_dnode(i->i_sb, dno, &qbh))) {
-		if (nd) kfree(nd);
+		kfree(nd);
 		kfree(nname);
 		return 1;
 	}
@@ -249,7 +249,7 @@
 	if (i->i_sb->s_hpfs_chk)
 		if (hpfs_stop_cycles(i->i_sb, dno, &c1, &c2, "hpfs_add_to_dnode")) {
 			hpfs_brelse4(&qbh);
-			if (nd) kfree(nd);
+			kfree(nd);
 			kfree(nname);
 			return 1;
 		}
@@ -262,7 +262,7 @@
 		for_all_poss(i, hpfs_pos_subst, 5, t + 1);
 		hpfs_mark_4buffers_dirty(&qbh);
 		hpfs_brelse4(&qbh);
-		if (nd) kfree(nd);
+		kfree(nd);
 		kfree(nname);
 		return 0;
 	}
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/fs/hpfs/super.c linux-245ac-carlos/fs/hpfs/super.c
--- linux-245ac/fs/hpfs/super.c	Wed Apr 18 02:16:39 2001
+++ linux-245ac-carlos/fs/hpfs/super.c	Wed May 30 13:52:26 2001
@@ -74,7 +74,7 @@
 		} else if (s->s_flags & MS_RDONLY) printk("; going on - but anything won't be destroyed because it's read-only\n");
 		else printk("; corrupted filesystem mounted read/write - your computer will explode within 20 seconds ... but you wanted it so!\n");
 	} else printk("\n");
-	if (buf) kfree(buf);
+	kfree(buf);
 	s->s_hpfs_was_error = 1;
 }
 
@@ -100,8 +100,8 @@
 
 void hpfs_put_super(struct super_block *s)
 {
-	if (s->s_hpfs_cp_table) kfree(s->s_hpfs_cp_table);
-	if (s->s_hpfs_bmp_dir) kfree(s->s_hpfs_bmp_dir);
+	kfree(s->s_hpfs_cp_table);
+	kfree(s->s_hpfs_bmp_dir);
 	unmark_dirty(s);
 }
 
@@ -551,8 +551,8 @@
 bail2:	brelse(bh0);
 bail1:
 bail0:
-	if (s->s_hpfs_bmp_dir) kfree(s->s_hpfs_bmp_dir);
-	if (s->s_hpfs_cp_table) kfree(s->s_hpfs_cp_table);
+	kfree(s->s_hpfs_bmp_dir);
+	kfree(s->s_hpfs_cp_table);
 	return NULL;
 }
 
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/fs/isofs/rock.c linux-245ac-carlos/fs/isofs/rock.c
--- linux-245ac/fs/isofs/rock.c	Wed May 30 04:19:44 2001
+++ linux-245ac-carlos/fs/isofs/rock.c	Wed May 30 13:53:42 2001
@@ -60,7 +60,7 @@
 }                                     
 
 #define MAYBE_CONTINUE(LABEL,DEV) \
-  {if (buffer) kfree(buffer); \
+  { kfree(buffer); \
   if (cont_extent){ \
     int block, offset, offset1; \
     struct buffer_head * pbh; \
@@ -213,7 +213,7 @@
 	retnamlen += rr->len - 5;
 	break;
       case SIG('R','E'):
-	if (buffer) kfree(buffer);
+	kfree(buffer);
 	return -1;
       default:
 	break;
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/fs/jffs2/gc.c linux-245ac-carlos/fs/jffs2/gc.c
--- linux-245ac/fs/jffs2/gc.c	Wed May 30 04:19:44 2001
+++ linux-245ac-carlos/fs/jffs2/gc.c	Wed May 30 13:53:17 2001
@@ -649,7 +649,7 @@
 			f->metadata = NULL;
 		}
 	}
-	if (comprbuf) kfree(comprbuf);
+	kfree(comprbuf);
 
 	kunmap(pg);
 	/* XXX: Does the page get freed automatically? */
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/fs/ufs/super.c linux-245ac-carlos/fs/ufs/super.c
--- linux-245ac/fs/ufs/super.c	Wed May 16 13:31:27 2001
+++ linux-245ac-carlos/fs/ufs/super.c	Wed May 30 13:51:01 2001
@@ -382,13 +382,13 @@
 	return 1;
 
 failed:
-	if (base) kfree (base);
+	kfree (base);
 	if (sb->u.ufs_sb.s_ucg) {
 		for (i = 0; i < uspi->s_ncg; i++)
 			if (sb->u.ufs_sb.s_ucg[i]) brelse (sb->u.ufs_sb.s_ucg[i]);
 		kfree (sb->u.ufs_sb.s_ucg);
 		for (i = 0; i < UFS_MAX_GROUP_LOADED; i++)
-			if (sb->u.ufs_sb.s_ucpi[i]) kfree (sb->u.ufs_sb.s_ucpi[i]);
+			kfree (sb->u.ufs_sb.s_ucpi[i]);
 	}
 	UFSD(("EXIT (FAILED)\n"))
 	return 0;
@@ -823,7 +823,7 @@
 
 failed:
 	if (ubh) ubh_brelse_uspi (uspi);
-	if (uspi) kfree (uspi);
+	kfree (uspi);
 	UFSD(("EXIT (FAILED)\n"))
 	return(NULL);
 }
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/include/linux/skbuff.h linux-245ac-carlos/include/linux/skbuff.h
--- linux-245ac/include/linux/skbuff.h	Fri May 25 21:01:43 2001
+++ linux-245ac-carlos/include/linux/skbuff.h	Wed May 30 13:40:19 2001
@@ -286,6 +286,7 @@
  
 static inline void kfree_skb(struct sk_buff *skb)
 {
+	if(!skb) return;
 	if (atomic_read(&skb->users) == 1 || atomic_dec_and_test(&skb->users))
 		__kfree_skb(skb);
 }
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/net/ax25/af_ax25.c linux-245ac-carlos/net/ax25/af_ax25.c
--- linux-245ac/net/ax25/af_ax25.c	Thu Apr 12 15:11:39 2001
+++ linux-245ac-carlos/net/ax25/af_ax25.c	Wed May 30 13:55:31 2001
@@ -1207,7 +1207,7 @@
 	}
 
 	if (sk->type == SOCK_SEQPACKET && ax25_find_cb(&sk->protinfo.ax25->source_addr, &fsa->fsa_ax25.sax25_call, digi, sk->protinfo.ax25->ax25_dev->dev) != NULL) {
-		if (digi != NULL) kfree(digi);
+		kfree(digi);
 		return -EADDRINUSE;			/* Already such a connection */
 	}
 
diff -ur --exclude=*~ --exclude=*.rej linux-245ac/net/core/skbuff.c linux-245ac-carlos/net/core/skbuff.c
--- linux-245ac/net/core/skbuff.c	Thu Apr 12 15:11:39 2001
+++ linux-245ac-carlos/net/core/skbuff.c	Wed May 30 13:34:21 2001
@@ -295,6 +295,7 @@
  */
 void kfree_skbmem(struct sk_buff *skb)
 {
+	if(!skb) return;
 	skb_release_data(skb);
 	skb_head_to_pool(skb);
 }
--

	 _________________________
	 Carlos E Gorges          
	 (carlos@techlinux.com.br)
	 Tech informática LTDA
	 Brazil                   
	 _________________________

