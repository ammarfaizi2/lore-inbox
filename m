Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262084AbRE2VuK>; Tue, 29 May 2001 17:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262087AbRE2VuD>; Tue, 29 May 2001 17:50:03 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:29157 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S262084AbRE2Vty>;
	Tue, 29 May 2001 17:49:54 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200105292149.OAA29781@csl.Stanford.EDU>
Subject: [CHECKER] 84 bugs in 2.4.4/2.4.4-ac8 where NULL pointers are deref'd
To: linux-kernel@vger.kernel.org
Date: Tue, 29 May 2001 14:49:50 -0700 (PDT)
Cc: mc@cs.Stanford.EDU
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

enclosed are 84 potential errors where code
	(1) checks if a pointer is null
	(2) dereferences it anyway.

For example the code:
	Start --> if (!(result = iget(dir->i_sb, ino))) {
                	hpfs_unlock_iget(dir->i_sb);
	Error ---> 	hpfs_error(result->i_sb,"hpfs_lookup: can't get inode");

Checks that "result" is null, and then dereferences it to emit an error message.

In most cases either (1) the check is unnecessary (the pointer cannot
be null) or (2) there is a real error.  The errors are typically fairly
clear, though I'm sure there's still some false positives of errors
prevented because of data dependencies.

The sort-of breakdown is:
  	2.4.4-specific errors       = 1
  	2.4.4ac8-specific errors    = 36
  	Common errors 	            = 47
  	Total 		            = 84
This is a little bogus since I think all the ac8 errors are also in
2.4.4 --- I used a worse checker on 2.4.4 and haven't rerun the results.

One of the most amusing patterns was a profligate cut&paste of the
following loop:

	Start ---> while (*handleptr && (*handleptr != handle))
                	handleptr = &((*handleptr)->dnext);
	Error ---> *handleptr = (*handleptr)->dnext;

Where either the check of *handleptr is redundant, or the raw dereference
after the loop is wrong.

The loop appeared in a lot of different places, though the variables
were renamed:

	Start ---> while (*listptr && (*listptr != list))
                	listptr = &((*listptr)->next);
	Error ---> *listptr = (*listptr)->next;


	Start ---> while (*devptr && (*devptr != dev))
                	devptr = &((*devptr)->next);
	Error ---> *devptr = (*devptr)->next;

Anyway, if you notice any broken output, please let me know.

Dawson
-------------------------------------------------------------------------
# BUGs	|	File Name
5	|	fs/hpfs/super.c
4	|	drivers/input/input.c
3	|	drivers/net/aironet4500_core.c
3	|	drivers/atm/iphase.c
2	|	drivers/char/epca.c
2	|	fs/ext2/dir.c
2	|	drivers/scsi/in2000.c
2	|	drivers/char/joystick/serio.c
2	|	fs/ufs/dir.c
2	|	fs/ufs/super.c
2	|	drivers/net/hamradio/soundmodem/sm.c
2	|	drivers/video/matrox/matroxfb_base.c
2	|	drivers/char/joystick/gameport.c
2	|	drivers/net/wan/comx.c
1	|	drivers/net/wan/sdla_chdlc.c
1	|	net/decnet/dn_route.c
1	|	net/ipv4/ip_input.c
1	|	drivers/char/ip2main.c
1	|	drivers/ide/pdc202xx.c
1	|	drivers/ide/aec62xx.c
1	|	drivers/media/video/bttv-driver.c
1	|	net/irda/irqueue.c
1	|	drivers/ide/hpt34x.c
1	|	drivers/ide/hpt366.c
1	|	drivers/input/evdev.c
1	|	drivers/isdn/hysdn/hysdn_net.c
1	|	drivers/ide/alim15x3.c
1	|	drivers/ide/sis5513.c
1	|	drivers/scsi/aha152x.c
1	|	net/ipv4/devinet.c
1	|	drivers/block/nbd.c
1	|	drivers/ide/cmd64x.c
1	|	net/ipv4/ip_output.c
1	|	drivers/md/lvm-snap.c
1	|	net/ipv4/ip_options.c
1	|	drivers/ide/amd7409.c
1	|	drivers/char/stallion.c
1	|	drivers/net/cs89x0.c
1	|	net/ipv4/fib_frontend.c
1	|	drivers/net/wan/sdlamain.c
1	|	fs/nfs/dir.c
1	|	net/econet/af_econet.c
1	|	drivers/input/joydev.c
1	|	drivers/ide/osb4.c
1	|	drivers/message/fusion/mptscsih.c
1	|	drivers/net/wan/comx-hw-comx.c
1	|	drivers/scsi/AM53C974.c
1	|	drivers/net/pcmcia/xirc2ps_cs.c
1	|	drivers/video/fbcon-mfb.c
1	|	drivers/acpi/interpreter/amresolv.c
1	|	drivers/input/mousedev.c
1	|	fs/ntfs/inode.c
1	|	drivers/scsi/pcmcia/../aha152x.c
1	|	drivers/scsi/g_NCR5380.c
1	|	drivers/net/pcmcia/xircom_cb.c
1	|	drivers/scsi/megaraid.c
1	|	drivers/scsi/aic7xxx/aic7xxx_linux.c
1	|	net/core/neighbour.c
1	|	drivers/video/fbcon-hga.c
1	|	fs/hpfs/dir.c
1	|	drivers/scsi/aic7xxx/aic7xxx.c
1	|	net/decnet/dn_dev.c
1	|	drivers/ide/piix.c

############################################################
# 2.4.4 specific errors
#
---------------------------------------------------------
[BUG] [GEM]
/u2/engler/mc/oses/linux/2.4.4/drivers/acpi/interpreter/amresolv.c:72:acpi_aml_get_field_unit_value: ERROR:INTERNAL_NULL:68:72: [type=set] (set at line 68) Dereferencing NULL ptr "field_desc" illegally! [val=400]
	u32                     mask;
	u8                      *location = NULL;
	u8                      locked = FALSE;


Start --->
	if (!field_desc) {
		status = AE_AML_NO_OPERAND;
	}

Error --->
	if (!(field_desc->common.flags & AOPOBJ_DATA_VALID)) {
		status = acpi_ds_get_field_unit_arguments (field_desc);
		if (ACPI_FAILURE (status)) {
			return (status);


############################################################
# 2.4.4ac8 specific errors

#
---------------------------------------------------------
[BUG] [GEM] another blow up because of error printouts
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/hpfs/dir.c:215:hpfs_lookup: ERROR:INTERNAL_NULL:213:215: [type=set] (set at line 213) Dereferencing NULL ptr "result" illegally!
	/*
	 * Go find or make an inode.
	 */

	hpfs_lock_iget(dir->i_sb, de->directory || (de->ea_size && dir->i_sb->s_hpfs_eas) ? 1 : 2);
Start --->
	if (!(result = iget(dir->i_sb, ino))) {
		hpfs_unlock_iget(dir->i_sb);
Error --->
		hpfs_error(result->i_sb, "hpfs_lookup: can't get inode");
		goto bail1;
	}
	if (!de->directory) result->i_hpfs_parent_dir = dir->i_ino;
---------------------------------------------------------
[BUG]  this guy has had a lot of these.
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/atm/iphase.c:1313:rx_dle_intr: ERROR:INTERNAL_NULL:1311:1313: [type=set] (set at line 1311) Dereferencing NULL ptr "vcc" illegally!
          struct cpcs_trailer *trailer;
          u_short length;
          struct ia_vcc *ia_vcc;
          /* no VCC related housekeeping done as yet. lets see */  
          vcc = ATM_SKB(skb)->vcc;
Start --->
	  if (!vcc) {
	      printk("IA: null vcc\n");  
Error --->
              atomic_inc(&vcc->stats->rx_err);
              dev_kfree_skb_any(skb);
              goto INCR_DLE;
          }
---------------------------------------------------------
[BUG]  looks bad.
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/ufs/super.c:271:ufs_parse_options: ERROR:INTERNAL_NULL:267:271: [type=null] (set at line 267) WARN: Passing NULL pointer "value" as arg 0 to function strcmp
		
	for (this_char = strtok (options, ",");
	     this_char != NULL;
	     this_char = strtok (NULL, ",")) {
	     
Start --->
		if ((value = strchr (this_char, '=')) != NULL)
			*value++ = 0;
		if (!strcmp (this_char, "ufstype")) {
			ufs_clear_opt (*mount_options, UFSTYPE);
Error --->
			if (!strcmp (value, "old"))
				ufs_set_opt (*mount_options, UFSTYPE_OLD);
			else if (!strcmp (value, "sun"))
				ufs_set_opt (*mount_options, UFSTYPE_SUN);
---------------------------------------------------------
[BUG] check then dereference anyway.
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/megaraid.c:863:mega_cmd_done: ERROR:INTERNAL_NULL:858:863: [type=set] (set at line 858) Dereferencing NULL ptr "pScb" illegally!
	int islogical;
	Scsi_Cmnd *SCpnt;
	mega_passthru *pthru;
	mega_mailbox *mbox;

Start --->
	if (pScb == NULL) {
		TRACE (("NULL pScb in mega_cmd_done!"));
		printk(KERN_CRIT "NULL pScb in mega_cmd_done!");
	}

Error --->
	SCpnt = pScb->SCpnt;

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
	pthru = pScb->pthru;
---------------------------------------------------------
[BUG]  check, then dereference anyway.
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/isdn/hysdn/hysdn_net.c:310:hysdn_net_create: ERROR:INTERNAL_NULL:305:310: [type=null] (set at line 305) WARN: Passing NULL pointer "dev" as arg 0 to function __memset_generic
	if(!card) {
		printk(KERN_WARNING "No card-pt in hysdn_net_create!\n");
		return (-ENOMEM);
	}
	hysdn_net_release(card);	/* release an existing net device */
Start --->
	if ((dev = kmalloc(sizeof(struct net_local), GFP_KERNEL)) == NULL) {
		printk(KERN_WARNING "HYSDN: unable to allocate mem\n");
		if (card->debug_flags & LOG_NET_INIT)
			return (-ENOMEM);
	}
Error --->
	memset(dev, 0, sizeof(struct net_local));	/* clean the structure */

	spin_lock_init(&((struct net_local *) dev)->lock);

---------------------------------------------------------
[BUG] check then deref anyway.
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/char/epca.c:2193:post_fep_init: ERROR:INTERNAL_NULL:2188:2193: [type=null] (set at line 2188) WARN: Passing NULL pointer "tmp_buf" as arg 0 to function __constant_c_memset
		ch->callout_termios = pc_callout.init_termios;
		ch->normal_termios = pc_driver.init_termios;
		init_waitqueue_head(&ch->open_wait);
		init_waitqueue_head(&ch->close_wait);
		ch->tmp_buf = kmalloc(ch->txbufsize,GFP_KERNEL);
Start --->
		if (!(ch->tmp_buf))
		{
			printk(KERN_ERR "POST FEP INIT : kmalloc failed for port 0x%x\n",i);

		}
Error --->
		memset((void *)ch->tmp_buf,0,ch->txbufsize);
	} /* End for each port */

	printk(KERN_INFO 
---------------------------------------------------------
[BUG] check then deref
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/media/video/bttv-driver.c:899:make_clip_tab: ERROR:INTERNAL_NULL:891:899: [type=null] (set at line 891) WARN: Passing NULL pointer "clipmap" as arg 0 to function __constant_memcpy

	if (bttv_debug)
		printk("bttv%d: clip: ro=%08lx re=%08lx\n",
		       btv->nr,virt_to_bus(ro), virt_to_bus(re));

Start --->
	if ((clipmap=vmalloc(VIDEO_CLIPMAP_SIZE))==NULL) {
		/* can't clip, don't generate any risc code */
		*(ro++)=cpu_to_le32(BT848_RISC_JUMP);
		*(ro++)=cpu_to_le32(btv->bus_vbi_even);
		*(re++)=cpu_to_le32(BT848_RISC_JUMP);
		*(re++)=cpu_to_le32(btv->bus_vbi_odd);
	}
	if (ncr < 0) {	/* bitmap was pased */
Error --->
		memcpy(clipmap, (unsigned char *)cr, VIDEO_CLIPMAP_SIZE);
	} else {	/* convert rectangular clips to a bitmap */
		memset(clipmap, 0, VIDEO_CLIPMAP_SIZE); /* clear map */
		for (i=0; i<ncr; i++)
---------------------------------------------------------
[BUG]  seems like it.  it's not guarded.  or is there some weird dependence?
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/ext2/dir.c:61:ext2_check_dir_entry: ERROR:INTERNAL_NULL:53:61: [type=set] (set at line 53) Dereferencing NULL ptr "dir" illegally!
	else if (le16_to_cpu(de->rec_len) < EXT2_DIR_REC_LEN(de->name_len))
		error_msg = "rec_len is too small for name_len";
	else if (dir && ((char *) de - bh->b_data) + le16_to_cpu(de->rec_len) >
		 dir->i_sb->s_blocksize)
		error_msg = "directory entry across blocks";
Start --->
	else if (dir && le32_to_cpu(de->inode) > le32_to_cpu(dir->i_sb->u.ext2_sb.s_es->s_inodes_count))
		error_msg = "inode out of bounds";

	if (error_msg != NULL)
		ext2_error (dir->i_sb, function, "bad entry in directory #%lu: %s - "
			    "offset=%lu, inode=%lu, rec_len=%d, name_len=%d",
			    dir->i_ino, error_msg, offset,
			    (unsigned long) le32_to_cpu(de->inode),
Error --->
			    le16_to_cpu(de->rec_len), de->name_len);
	return error_msg == NULL ? 1 : 0;
}

---------------------------------------------------------
[BUG] seems identical to the ext2 one.
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/ufs/dir.c:178:ufs_check_dir_entry: ERROR:INTERNAL_NULL:170:178: [type=set] (set at line 170) Dereferencing NULL ptr "dir" illegally!
	else if (SWAB16(de->d_reclen) < UFS_DIR_REC_LEN(ufs_get_de_namlen(de)))
		error_msg = "reclen is too small for namlen";
	else if (dir && ((char *) de - bh->b_data) + SWAB16(de->d_reclen) >
		 dir->i_sb->s_blocksize)
		error_msg = "directory entry across blocks";
Start --->
	else if (dir && SWAB32(de->d_ino) > (sb->u.ufs_sb.s_uspi->s_ipg * sb->u.ufs_sb.s_uspi->s_ncg))
		error_msg = "inode out of bounds";

	if (error_msg != NULL)
		ufs_error (sb, function, "bad entry in directory #%lu, size %Lu: %s - "
			    "offset=%lu, inode=%lu, reclen=%d, namlen=%d",
			    dir->i_ino, dir->i_size, error_msg, offset,
			    (unsigned long) SWAB32(de->d_ino),
Error --->
			    SWAB16(de->d_reclen), ufs_get_de_namlen(de));
	
	return (error_msg == NULL ? 1 : 0);
}
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/ufs/dir.c:178:ufs_check_dir_entry: ERROR:INTERNAL_NULL:168:178: [type=set] (set at line 168) Dereferencing NULL ptr "dir" illegally!
	else if (SWAB16(de->d_reclen) % 4 != 0)
		error_msg = "reclen % 4 != 0";
	else if (SWAB16(de->d_reclen) < UFS_DIR_REC_LEN(ufs_get_de_namlen(de)))
		error_msg = "reclen is too small for namlen";
	else if (dir && ((char *) de - bh->b_data) + SWAB16(de->d_reclen) >
Start --->
		 dir->i_sb->s_blocksize)
		error_msg = "directory entry across blocks";
	else if (dir && SWAB32(de->d_ino) > (sb->u.ufs_sb.s_uspi->s_ipg * sb->u.ufs_sb.s_uspi->s_ncg))
		error_msg = "inode out of bounds";

	if (error_msg != NULL)
		ufs_error (sb, function, "bad entry in directory #%lu, size %Lu: %s - "
			    "offset=%lu, inode=%lu, reclen=%d, namlen=%d",
			    dir->i_ino, dir->i_size, error_msg, offset,
			    (unsigned long) SWAB32(de->d_ino),
Error --->
			    SWAB16(de->d_reclen), ufs_get_de_namlen(de));
	
	return (error_msg == NULL ? 1 : 0);
}
---------------------------------------------------------
[BUG] unless dependency...
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/ext2/dir.c:61:ext2_check_dir_entry: ERROR:INTERNAL_NULL:51:61: [type=set] (set at line 51) Dereferencing NULL ptr "dir" illegally!
	else if (le16_to_cpu(de->rec_len) % 4 != 0)
		error_msg = "rec_len % 4 != 0";
	else if (le16_to_cpu(de->rec_len) < EXT2_DIR_REC_LEN(de->name_len))
		error_msg = "rec_len is too small for name_len";
	else if (dir && ((char *) de - bh->b_data) + le16_to_cpu(de->rec_len) >
Start --->
		 dir->i_sb->s_blocksize)
		error_msg = "directory entry across blocks";
	else if (dir && le32_to_cpu(de->inode) > le32_to_cpu(dir->i_sb->u.ext2_sb.s_es->s_inodes_count))
		error_msg = "inode out of bounds";

	if (error_msg != NULL)
		ext2_error (dir->i_sb, function, "bad entry in directory #%lu: %s - "
			    "offset=%lu, inode=%lu, rec_len=%d, name_len=%d",
			    dir->i_ino, error_msg, offset,
			    (unsigned long) le32_to_cpu(de->inode),
Error --->
			    le16_to_cpu(de->rec_len), de->name_len);
	return error_msg == NULL ? 1 : 0;
}

---------------------------------------------------------
[BUG] broke broke
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/pcmcia/xircom_cb.c:309:xircom_remove: ERROR:INTERNAL_NULL:297:309: [type=set] (set at line 297) Dereferencing NULL ptr "dev" illegally!
static void __devexit xircom_remove(struct pci_dev *pdev)
{
	struct net_device *dev = pdev->driver_data;
	struct xircom_private *card;
	enter("xircom_remove");
Start --->
	if (dev!=NULL) {
		card=dev->priv;
		if (card!=NULL) {	
			if (card->rx_buffer!=NULL)
				pci_free_consistent(pdev,8192,card->rx_buffer,card->rx_dma_handle);
			card->rx_buffer = NULL;
			if (card->tx_buffer!=NULL)
				pci_free_consistent(pdev,8192,card->tx_buffer,card->tx_dma_handle);
			card->tx_buffer = NULL;			
		}
		kfree(card);
	}
Error --->
	release_region(dev->base_addr, 128);
	unregister_netdev(dev);
	kfree(dev);
	leave("xircom_remove");
---------------------------------------------------------
[BUG]  checks, and will then just blow up.
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/char/ip2main.c:1774:ip2_close: ERROR:INTERNAL_NULL:1762:1774: [type=set] (set at line 1762) Dereferencing NULL ptr "tty" illegally!
	i2InputFlush( pCh );

	/* disable DSS reporting */
	i2QueueCommands(PTYPE_INLINE, pCh, 100, 4,
				CMD_DCD_NREP, CMD_CTS_NREP, CMD_DSR_NREP, CMD_RI_NREP);
Start --->
	if ( !tty || (tty->termios->c_cflag & HUPCL) ) {
		i2QueueCommands(PTYPE_INLINE, pCh, 100, 2, CMD_RTSDN, CMD_DTRDN);
		pCh->dataSetOut &= ~(I2_DTR | I2_RTS);
		i2QueueCommands( PTYPE_INLINE, pCh, 100, 1, CMD_PAUSE(25));
	}

	serviceOutgoingFifo ( pCh->pMyBord );

	if ( tty->driver.flush_buffer ) 
		tty->driver.flush_buffer(tty);
	if ( tty->ldisc.flush_buffer )  
		tty->ldisc.flush_buffer(tty);
Error --->
	tty->closing = 0;
	
	pCh->pTTY = NULL;

---------------------------------------------------------
[BUG] will print, then seg fault.
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/nfs/dir.c:792:nfs_sillyrename: ERROR:INTERNAL_NULL:780:792: [type=set] (set at line 780) Dereferencing NULL ptr "d_inode" illegally!
	if (atomic_read(&dentry->d_count) == 1)
		goto out;  /* No need to silly rename. */


#ifdef NFS_PARANOIA
Start --->
if (!dentry->d_inode)
printk("NFS: silly-renaming %s/%s, negative dentry??\n",
dentry->d_parent->d_name.name, dentry->d_name.name);
#endif
	/*
	 * We don't allow a dentry to be silly-renamed twice.
	 */
	error = -EBUSY;
	if (dentry->d_flags & DCACHE_NFSFS_RENAMED)
		goto out;

	sprintf(silly, ".nfs%*.*lx",
Error --->
		i_inosize, i_inosize, dentry->d_inode->i_ino);

	sdentry = NULL;
	do {
---------------------------------------------------------
[BUG]  sends sk raw to a bunch of other routines.  doesn't seem good.
/u2/engler/mc/oses/linux/2.4.4-ac8/net/ipv4/ip_output.c:520:ip_build_xmit_slow: ERROR:INTERNAL_NULL:502:520: [type=set] (set at line 502) Dereferencing NULL ptr "sk" illegally!

	/*
	 *	Begin outputting the bytes.
	 */

Start --->
	id = (sk ? sk->protinfo.af_inet.id++ : 0);

	... DELETED 12 lines ...


		/*
		 *	Fill in the control structures
		 */

Error --->
		skb->priority = sk->priority;
		skb->dst = dst_clone(&rt->u.dst);
		skb_reserve(skb, hh_len);

---------------------------------------------------------
[BUG] contradiction: check then use anyway.
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/message/fusion/mptscsih.c:1963:copy_sense_data: ERROR:INTERNAL_NULL:1938:1963: [type=set] (set at line 1938) Dereferencing NULL ptr "sc" illegally!
	MPT_SCSI_DEV	*mpt_sdev = NULL;
	u32		 sense_count = le32_to_cpu(pScsiReply->SenseCount);
	char		 devFoo[32];
	IO_Info_t	 thisIo;

Start --->
	if (sc && sc->device)

	... DELETED 19 lines ...


	thisIo.cdbPtr = sc->cmnd;
	thisIo.sensePtr = sc->sense_buffer;
	thisIo.SCSIStatus = pScsiReply->SCSIStatus;
	thisIo.DoDisplay = 1;
Error --->
	sprintf(devFoo, "ioc%d,scsi%d:%d", hd->ioc->id, sc->target, sc->lun);
	thisIo.DevIDStr = devFoo;
/* fubar */
	thisIo.dataPtr = NULL;
---------------------------------------------------------
[BUG] value can be null.
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/ufs/super.c:294:ufs_parse_options: ERROR:INTERNAL_NULL:267:294: [type=null] (set at line 267) WARN: Passing NULL pointer "value" as arg 0 to function strcmp
		
	for (this_char = strtok (options, ",");
	     this_char != NULL;
	     this_char = strtok (NULL, ",")) {
	     
Start --->
		if ((value = strchr (this_char, '=')) != NULL)

	... DELETED 21 lines ...

				return 0;
			}
		}
		else if (!strcmp (this_char, "onerror")) {
			ufs_clear_opt (*mount_options, ONERROR);
Error --->
			if (!strcmp (value, "panic"))
				ufs_set_opt (*mount_options, ONERROR_PANIC);
			else if (!strcmp (value, "lock"))
				ufs_set_opt (*mount_options, ONERROR_LOCK);
---------------------------------------------------------
[BUG]  contradiction
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/pcmcia/xirc2ps_cs.c:1568:do_start_xmit: ERROR:INTERNAL_NULL:1537:1568: [type=set] (set at line 1537) Dereferencing NULL ptr "skb" illegally!
{
    local_info_t *lp = dev->priv;
    ioaddr_t ioaddr = dev->base_addr;
    int okay;
    unsigned freespace;
Start --->
    unsigned pktlen = skb? skb->len : 0;

	... DELETED 25 lines ...

    if (!okay) { /* not enough space */
	return 1;  /* upper layer may decide to requeue this packet */
    }
    /* send the packet */
    PutWord(XIRCREG_EDP, (u_short)pktlen);
Error --->
    outsw(ioaddr+XIRCREG_EDP, skb->data, pktlen>>1);
    if (pktlen & 1)
	PutByte(XIRCREG_EDP, skb->data[pktlen-1]);

---------------------------------------------------------
[BUG] contradiction
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/AM53C974.c:1384:AM53C974_intr_disconnect: ERROR:INTERNAL_NULL:1353:1384: [type=set] (set at line 1353) Dereferencing NULL ptr "cmd" illegally!
			goto EXIT_FINISHED;
		}		/* !cmd->device->disconnect */
	}			/* if (hostdata->disconnecting) */
	/* no disconnect message received; unexpected disconnection */
	cmd = (Scsi_Cmnd *) hostdata->connected;
Start --->
	if (cmd) {

	... DELETED 25 lines ...

	hostdata->sel_cmd = NULL;
	hostdata->connected = NULL;
	hostdata->selecting = 0;
	hostdata->disconnecting = 0;
	hostdata->dma_busy = 0;
Error --->
	hostdata->busy[cmd->target] &= ~(1 << cmd->lun);
	AM53C974_write_8(CMDREG, CMDREG_CFIFO);
	DEB(printk("disconnect; issue_queue: 0x%lx, disconnected_queue: 0x%lx\n",
		   (long) hostdata->issue_queue, (long) hostdata->disconnected_queue));
---------------------------------------------------------
[BUG] does a FAIL, which goes to error_out, which kills the kernel because of
      doing statistics.
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/block/nbd.c:348:do_nbd_request: ERROR:INTERNAL_NULL:317:348: [type=set] (set at line 317) Dereferencing NULL ptr "req" illegally!
	struct nbd_device *lo;

	while (!QUEUE_EMPTY) {
		req = CURRENT;
#ifdef PARANOIA
Start --->
		if (!req)

	... DELETED 25 lines ...


		spin_lock_irq(&io_request_lock);
		continue;

	      error_out:
Error --->
		req->errors++;
		blkdev_dequeue_request(req);
		spin_unlock(&io_request_lock);
		nbd_end_request(req);
---------------------------------------------------------
[BUG] guard contradiction 
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/ide/sis5513.c:519:config_drive_xfer_rate: ERROR:INTERNAL_NULL:486:519: [type=set] (set at line 486) Dereferencing NULL ptr "id" illegally!
static int config_drive_xfer_rate (ide_drive_t *drive)
{
	struct hd_driveid *id		= drive->id;
	ide_dma_action_t dma_func	= ide_dma_off_quietly;

Start --->
	if (id && (id->capability & 1) && HWIF(drive)->autodma) {

	... DELETED 27 lines ...

			if (dma_func != ide_dma_on)
				goto no_dma_set;
		} else {
			goto fast_ata_pio;
		}
Error --->
	} else if ((id->capability & 8) || (id->field_valid & 2)) {
fast_ata_pio:
		dma_func = ide_dma_off_quietly;
no_dma_set:
---------------------------------------------------------
[BUG]  hard to follow but seems like it.
/u2/engler/mc/oses/linux/2.4.4-ac8/net/ipv4/fib_frontend.c:272:fib_validate_source: ERROR:INTERNAL_NULL:239:272: [type=set] (set at line 239) Dereferencing NULL ptr "itag" illegally!
	if (fib_lookup(&key, &res))
		goto last_resort;
	if (res.type != RTN_UNICAST)
		goto e_inval_res;
	*spec_dst = FIB_RES_PREFSRC(res);
Start --->
	if (itag)

	... DELETED 27 lines ...


last_resort:
	if (rpf)
		goto e_inval;
	*spec_dst = inet_select_addr(dev, 0, RT_SCOPE_UNIVERSE);
Error --->
	*itag = 0;
	return 0;

e_inval_res:
---------------------------------------------------------
[BUG] guard contradiction
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/ide/hpt366.c:582:config_drive_xfer_rate: ERROR:INTERNAL_NULL:548:582: [type=set] (set at line 548) Dereferencing NULL ptr "id" illegally!
static int config_drive_xfer_rate (ide_drive_t *drive)
{
	struct hd_driveid *id = drive->id;
	ide_dma_action_t dma_func = ide_dma_on;

Start --->
	if (id && (id->capability & 1) && HWIF(drive)->autodma) {

	... DELETED 28 lines ...

			if (dma_func != ide_dma_on)
				goto no_dma_set;
		} else {
			goto fast_ata_pio;
		}
Error --->
	} else if ((id->capability & 8) || (id->field_valid & 2)) {
fast_ata_pio:
		dma_func = ide_dma_off_quietly;
no_dma_set:
---------------------------------------------------------
[BUG] guard contracition
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/ide/aec62xx.c:483:config_drive_xfer_rate: ERROR:INTERNAL_NULL:448:483: [type=set] (set at line 448) Dereferencing NULL ptr "id" illegally!
static int config_drive_xfer_rate (ide_drive_t *drive)
{
	struct hd_driveid *id = drive->id;
	ide_dma_action_t dma_func = ide_dma_on;

Start --->
	if (id && (id->capability & 1) && HWIF(drive)->autodma) {

	... DELETED 29 lines ...

			if (dma_func != ide_dma_on)
				goto no_dma_set;
		} else {
			goto fast_ata_pio;
		}
Error --->
	} else if ((id->capability & 8) || (id->field_valid & 2)) {
fast_ata_pio:
		dma_func = ide_dma_off_quietly;
no_dma_set:
---------------------------------------------------------
[BUG]  seems to blow up with malformed input.
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/hpfs/super.c:215:parse_opts: ERROR:INTERNAL_NULL:180:215: [type=null] (set at line 180) WARN: Passing NULL pointer "rhs" as arg 0 to function strcmp
		return 1;

	/*printk("Parsing opts: '%s'\n",opts);*/

	for (p = strtok(opts, ","); p != 0; p = strtok(0, ",")) {
Start --->
		if ((rhs = strchr(p, '=')) != 0)

	... DELETED 29 lines ...

			*timeshift = simple_strtoul(rhs, &rhs, 0) * m;
			if (*rhs)
				return 0;
		}
		else if (!strcmp(p, "case")) {
Error --->
			if (!strcmp(rhs, "lower"))
				*lowercase = 1;
			else if (!strcmp(rhs, "asis"))
				*lowercase = 0;
---------------------------------------------------------
[BUG] cut & paste
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/ide/alim15x3.c:483:ali15x3_config_drive_for_dma: ERROR:INTERNAL_NULL:448:483: [type=set] (set at line 448) Dereferencing NULL ptr "id" illegally!
	byte can_ultra_dma		= ali15x3_can_ultra(drive);

	if ((m5229_revision<=0x20) && (drive->media!=ide_disk))
		return hwif->dmaproc(ide_dma_off_quietly, drive);

Start --->
	if ((id != NULL) && ((id->capability & 1) != 0) && hwif->autodma) {

	... DELETED 29 lines ...

			if (dma_func != ide_dma_on)
				goto no_dma_set;
		} else {
			goto fast_ata_pio;
		}
Error --->
	} else if ((id->capability & 8) || (id->field_valid & 2)) {
fast_ata_pio:
		dma_func = ide_dma_off_quietly;
no_dma_set:
---------------------------------------------------------
[BUG] cut & paste
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/ide/osb4.c:371:config_drive_xfer_rate: ERROR:INTERNAL_NULL:336:371: [type=set] (set at line 336) Dereferencing NULL ptr "id" illegally!
static int config_drive_xfer_rate (ide_drive_t *drive)
{
	struct hd_driveid *id = drive->id;
	ide_dma_action_t dma_func = ide_dma_on;

Start --->
	if (id && (id->capability & 1) && HWIF(drive)->autodma) {

	... DELETED 29 lines ...

			if (dma_func != ide_dma_on)
				goto no_dma_set;
		} else {
			goto fast_ata_pio;
		}
Error --->
	} else if ((id->capability & 8) || (id->field_valid & 2)) {
fast_ata_pio:
		dma_func = ide_dma_off_quietly;
no_dma_set:
---------------------------------------------------------
[BUG] guard contradiction
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/ide/pdc202xx.c:688:config_drive_xfer_rate: ERROR:INTERNAL_NULL:653:688: [type=set] (set at line 653) Dereferencing NULL ptr "id" illegally!
{
	struct hd_driveid *id = drive->id;
	ide_hwif_t *hwif = HWIF(drive);
	ide_dma_action_t dma_func = ide_dma_off_quietly;

Start --->
	if (id && (id->capability & 1) && hwif->autodma) {

	... DELETED 29 lines ...

			if (dma_func != ide_dma_on)
				goto no_dma_set;
		} else {
			goto fast_ata_pio;
		}
Error --->
	} else if ((id->capability & 8) || (id->field_valid & 2)) {
fast_ata_pio:
		dma_func = ide_dma_off_quietly;
no_dma_set:
---------------------------------------------------------
[BUG] guard contradiction
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/ide/hpt34x.c:293:config_drive_xfer_rate: ERROR:INTERNAL_NULL:258:293: [type=set] (set at line 258) Dereferencing NULL ptr "id" illegally!
static int config_drive_xfer_rate (ide_drive_t *drive)
{
	struct hd_driveid *id = drive->id;
	ide_dma_action_t dma_func = ide_dma_on;

Start --->
	if (id && (id->capability & 1) && HWIF(drive)->autodma) {

	... DELETED 29 lines ...

			if (dma_func != ide_dma_on)
				goto no_dma_set;
		} else {
			goto fast_ata_pio;
		}
Error --->
	} else if ((id->capability & 8) || (id->field_valid & 2)) {
fast_ata_pio:
		dma_func = ide_dma_off_quietly;
no_dma_set:
---------------------------------------------------------
[BUG] guard contradiction
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/ide/cmd64x.c:580:cmd64x_config_drive_for_dma: ERROR:INTERNAL_NULL:545:580: [type=set] (set at line 545) Dereferencing NULL ptr "id" illegally!
		default:
			return hwif->dmaproc(ide_dma_off, drive);
	}

	if ((id != NULL) && ((id->capability & 1) != 0) &&
Start --->
	    hwif->autodma && (drive->media == ide_disk)) {

	... DELETED 29 lines ...

			if (dma_func != ide_dma_on)
				goto no_dma_set;
		} else {
			goto fast_ata_pio;
		}
Error --->
	} else if ((id->capability & 8) || (id->field_valid & 2)) {
fast_ata_pio:
		dma_func = ide_dma_off_quietly;
no_dma_set:
---------------------------------------------------------
[BUG] cut & paste
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/ide/piix.c:447:config_drive_xfer_rate: ERROR:INTERNAL_NULL:412:447: [type=set] (set at line 412) Dereferencing NULL ptr "id" illegally!
static int config_drive_xfer_rate (ide_drive_t *drive)
{
	struct hd_driveid *id = drive->id;
	ide_dma_action_t dma_func = ide_dma_on;

Start --->
	if (id && (id->capability & 1) && HWIF(drive)->autodma) {

	... DELETED 29 lines ...

			if (dma_func != ide_dma_on)
				goto no_dma_set;
		} else {
			goto fast_ata_pio;
		}
Error --->
	} else if ((id->capability & 8) || (id->field_valid & 2)) {
fast_ata_pio:
		dma_func = ide_dma_off_quietly;
no_dma_set:
---------------------------------------------------------
[BUG] I *think* it can be reached.
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/aic7xxx/aic7xxx.c:1802:ahc_set_syncrate: ERROR:INTERNAL_NULL:1765:1802: [type=set] (set at line 1765) Dereferencing NULL ptr "syncrate" illegally!
			/*
			 * Ensure Ultra mode is set properly for
			 * this target.
			 */
			tstate->ultraenb &= ~devinfo->target_mask;
Start --->
			if (syncrate != NULL) {

	... DELETED 31 lines ...

			if (offset != 0) {
				printf("%s: target %d synchronous at %sMHz%s, "
				       "offset = 0x%x\n", ahc_name(ahc),
				       devinfo->target, syncrate->rate,
				       (ppr_options & MSG_EXT_PPR_DT_REQ)
Error --->
				       ? " DT" : "", offset);
			} else {
				printf("%s: target %d using "
				       "asynchronous transfers\n",
---------------------------------------------------------
[BUG] seems like its going to blow up with malformed input.  funny comment
 	about this replicated bug:
/*
 * A tiny parser for option strings, stolen from dosfs.
 *
 * Stolen again from read-only hpfs.
 */
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/hpfs/super.c:223:parse_opts: ERROR:INTERNAL_NULL:180:223: [type=null] (set at line 180) WARN: Passing NULL pointer "rhs" as arg 0 to function strcmp
		return 1;

	/*printk("Parsing opts: '%s'\n",opts);*/

	for (p = strtok(opts, ","); p != 0; p = strtok(0, ",")) {
Start --->
		if ((rhs = strchr(p, '=')) != 0)

	... DELETED 37 lines ...

				*lowercase = 0;
			else
				return 0;
		}
		else if (!strcmp(p, "conv")) {
Error --->
			if (!strcmp(rhs, "binary"))
				*conv = CONV_BINARY;
			else if (!strcmp(rhs, "text"))
				*conv = CONV_TEXT;
---------------------------------------------------------
[BUG] again the option one.
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/hpfs/super.c:233:parse_opts: ERROR:INTERNAL_NULL:180:233: [type=null] (set at line 180) WARN: Passing NULL pointer "rhs" as arg 0 to function strcmp
		return 1;

	/*printk("Parsing opts: '%s'\n",opts);*/

	for (p = strtok(opts, ","); p != 0; p = strtok(0, ",")) {
Start --->
		if ((rhs = strchr(p, '=')) != 0)

	... DELETED 47 lines ...

				*conv = CONV_AUTO;
			else
				return 0;
		}
		else if (!strcmp(p, "check")) {
Error --->
			if (!strcmp(rhs, "none"))
				*chk = 0;
			else if (!strcmp(rhs, "normal"))
				*chk = 1;
---------------------------------------------------------
[BUG] again, blow up on malformed input.
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/hpfs/super.c:243:parse_opts: ERROR:INTERNAL_NULL:180:243: [type=null] (set at line 180) WARN: Passing NULL pointer "rhs" as arg 0 to function strcmp
		return 1;

	/*printk("Parsing opts: '%s'\n",opts);*/

	for (p = strtok(opts, ","); p != 0; p = strtok(0, ",")) {
Start --->
		if ((rhs = strchr(p, '=')) != 0)

	... DELETED 57 lines ...

				*chk = 2;
			else
				return 0;
		}
		else if (!strcmp(p, "errors")) {
Error --->
			if (!strcmp(rhs, "continue"))
				*errs = 0;
			else if (!strcmp(rhs, "remount-ro"))
				*errs = 1;
---------------------------------------------------------
[BUG] again
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/hpfs/super.c:263:parse_opts: ERROR:INTERNAL_NULL:180:263: [type=null] (set at line 180) WARN: Passing NULL pointer "rhs" as arg 0 to function strcmp
		return 1;

	/*printk("Parsing opts: '%s'\n",opts);*/

	for (p = strtok(opts, ","); p != 0; p = strtok(0, ",")) {
Start --->
		if ((rhs = strchr(p, '=')) != 0)

	... DELETED 77 lines ...

				*eas = 2;
			else
				return 0;
		}
		else if (!strcmp(p, "chkdsk")) {
Error --->
			if (!strcmp(rhs, "no"))
				*chkdsk = 0;
			else if (!strcmp(rhs, "errors"))
				*chkdsk = 1;


############################################################
# errors common to both

#
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4/drivers/char/joystick/serio.c:82:serio_unregister_port: ERROR:INTERNAL_NULL:81:82: [type=set] (set at line 81) Dereferencing NULL ptr "(null)" illegally! [val=100]

void serio_unregister_port(struct serio *serio)
{
        struct serio **serioptr = &serio_list;

Start --->
        while (*serioptr && (*serioptr != serio)) serioptr = &((*serioptr)->next);
Error --->
        *serioptr = (*serioptr)->next;

	if (serio->dev && serio->dev->disconnect)
		serio->dev->disconnect(serio);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4/drivers/net/wan/comx.c:177:comx_debug_skb: ERROR:INTERNAL_NULL:176:177: [type=set] (set at line 176) Dereferencing NULL ptr "skb" illegally! [val=100]
int comx_debug_skb(struct net_device *dev, struct sk_buff *skb, char *msg)
{
	struct comx_channel *ch = dev->priv;

	if (!ch->debug_area) return 0;
Start --->
	if (!skb) comx_debug(dev, "%s: %s NULL skb\n\n", dev->name, msg);
Error --->
	if (!skb->len) comx_debug(dev, "%s: %s empty skb\n\n", dev->name, msg);

	return comx_debug_bytes(dev, skb->data, skb->len, msg);
}
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4/drivers/char/joystick/gameport.c:138:gameport_unregister_port: ERROR:INTERNAL_NULL:137:138: [type=set] (set at line 137) Dereferencing NULL ptr "(null)" illegally! [val=100]

void gameport_unregister_port(struct gameport *gameport)
{
        struct gameport **gameportptr = &gameport_list;

Start --->
        while (*gameportptr && (*gameportptr != gameport)) gameportptr = &((*gameportptr)->next);
Error --->
        *gameportptr = (*gameportptr)->next;

	if (gameport->dev && gameport->dev->disconnect)
		gameport->dev->disconnect(gameport);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4/drivers/scsi/aha152x.c:936:swintr: ERROR:INTERNAL_NULL:935:936: [type=set] (set at line 935) Dereferencing NULL ptr "shpnt" illegally! [val=100]

static void swintr(int irqno, void *dev_id, struct pt_regs *regs)
{
	struct Scsi_Host *shpnt = aha152x_host[irqno - IRQ_MIN];

Start --->
	if (!shpnt)
Error --->
        	printk(KERN_ERR "aha152x%d: catched software interrupt for unknown controller.\n", HOSTNO);

	HOSTDATA(shpnt)->swint++;

---------------------------------------------------------
[BUG] [GEM] #define HOSTNO                  ((shpnt)->host_no)
/u2/engler/mc/oses/linux/2.4.4/drivers/scsi/pcmcia/../aha152x.c:936:swintr: ERROR:INTERNAL_NULL:935:936: [type=set] (set at line 935) Dereferencing NULL ptr "shpnt" illegally! [val=100]

static void swintr(int irqno, void *dev_id, struct pt_regs *regs)
{
	struct Scsi_Host *shpnt = aha152x_host[irqno - IRQ_MIN];

Start --->
	if (!shpnt)
Error --->
        	printk(KERN_ERR "aha152x%d: catched software interrupt for unknown controller.\n", HOSTNO);

	HOSTDATA(shpnt)->swint++;

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4/drivers/char/joystick/serio.c:110:serio_unregister_device: ERROR:INTERNAL_NULL:109:110: [type=set] (set at line 109) Dereferencing NULL ptr "(null)" illegally! [val=100]
void serio_unregister_device(struct serio_dev *dev)
{
        struct serio_dev **devptr = &serio_dev;
	struct serio *serio = serio_list;

Start --->
        while (*devptr && (*devptr != dev)) devptr = &((*devptr)->next);
Error --->
        *devptr = (*devptr)->next;

	while (serio) {
		if (serio->dev == dev && dev->disconnect)
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4/drivers/char/joystick/gameport.c:166:gameport_unregister_device: ERROR:INTERNAL_NULL:165:166: [type=set] (set at line 165) Dereferencing NULL ptr "(null)" illegally! [val=100]
void gameport_unregister_device(struct gameport_dev *dev)
{
        struct gameport_dev **devptr = &gameport_dev;
	struct gameport *gameport = gameport_list;

Start --->
        while (*devptr && (*devptr != dev)) devptr = &((*devptr)->next);
Error --->
        *devptr = (*devptr)->next;

	while (gameport) {
		if (gameport->dev == dev && dev->disconnect)
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4/drivers/input/joydev.c:173:joydev_release: ERROR:INTERNAL_NULL:171:173: [type=set] (set at line 171) Dereferencing NULL ptr "(null)" illegally! [val=200]

	lock_kernel();
	listptr = &list->joydev->list;
	joydev_fasync(-1, file, 0);

Start --->
	while (*listptr && (*listptr != list))
		listptr = &((*listptr)->next);
Error --->
	*listptr = (*listptr)->next;

	if (!--list->joydev->open) {
		if (list->joydev->exist) {
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4/drivers/input/mousedev.c:177:mousedev_release: ERROR:INTERNAL_NULL:175:177: [type=set] (set at line 175) Dereferencing NULL ptr "(null)" illegally! [val=200]

	lock_kernel();
	listptr = &list->mousedev->list;
	mousedev_fasync(-1, file, 0);

Start --->
	while (*listptr && (*listptr != list))
		listptr = &((*listptr)->next);
Error --->
	*listptr = (*listptr)->next;

	if (!--list->mousedev->open) {
		if (list->mousedev->minor == MOUSEDEV_MIX) {
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4/drivers/input/evdev.c:103:evdev_release: ERROR:INTERNAL_NULL:101:103: [type=set] (set at line 101) Dereferencing NULL ptr "(null)" illegally! [val=200]

	lock_kernel();
	listptr = &list->evdev->list;
	evdev_fasync(-1, file, 0);

Start --->
	while (*listptr && (*listptr != list))
		listptr = &((*listptr)->next);
Error --->
	*listptr = (*listptr)->next;

	if (!--list->evdev->open) {
		if (list->evdev->exist) {
---------------------------------------------------------
[BUG]  one of these lines is confused.
/u2/engler/mc/oses/linux/2.4.4/drivers/net/cs89x0.c:264:cs89x0_probe: ERROR:INTERNAL_NULL:262:264: [type=set] (set at line 262) Dereferencing NULL ptr "dev" illegally! [val=200]
   */

int __init cs89x0_probe(struct net_device *dev)
{
	int i;
Start --->
	int base_addr = dev ? dev->base_addr : 0;

Error --->
	SET_MODULE_OWNER(dev);

	if (net_debug)
		printk("cs89x0:cs89x0_probe(0x%x)\n", base_addr);
---------------------------------------------------------
[BUG] an infelicitious combination of macros --- actually touches info.
/u2/engler/mc/oses/linux/2.4.4/drivers/video/matrox/matroxfb_base.c:780:matroxfb_set_var: ERROR:INTERNAL_NULL:778:780: [type=set] (set at line 778) Dereferencing NULL ptr "info" illegally! [val=200]
	/* conp, fb_info, vrows, cursor_x, cursor_y, fgcol, bgcol */
	/* next_plane, fontdata, _font*, userfont */
	initMatrox(PMINFO display);	/* dispsw */
	/* dispsw, scrollmode, yscroll */
	/* fgshift, bgshift, charmask */
Start --->
	if (chgvar && info && info->changevar)
		info->changevar(con);
Error --->
	if (con == ACCESS_FBINFO(currcon)) {
		unsigned int pos;

		ACCESS_FBINFO(curr.cmap_len) = cmap_len;
---------------------------------------------------------
[BUG] [GEM]
/u2/engler/mc/oses/linux/2.4.4/drivers/net/wan/sdla_chdlc.c:3948:wanpipe_tty_open: ERROR:INTERNAL_NULL:3946:3948: [type=set] (set at line 3946) Dereferencing NULL ptr "card" illegally! [val=200]
			return -ENODEV;
	}

	card = (sdla_t*)tty->driver_data;

Start --->
	if (!card){
		lock_adapter_irq(&card->wandev.lock,&smp_flags);	
Error --->
		card->tty=NULL;
		unlock_adapter_irq(&card->wandev.lock,&smp_flags);
		return -ENODEV;
	}
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4/drivers/input/input.c:291:input_unregister_device: ERROR:INTERNAL_NULL:289:291: [type=set] (set at line 289) Dereferencing NULL ptr "(null)" illegally! [val=200]

/*
 * Remove the device.
 */

Start --->
	while (*devptr && (*devptr != dev))
		devptr = &((*devptr)->next);
Error --->
	*devptr = (*devptr)->next;

	input_number--;

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4/drivers/input/input.c:212:input_unlink_handle: ERROR:INTERNAL_NULL:210:212: [type=set] (set at line 210) Dereferencing NULL ptr "(null)" illegally! [val=200]
static void input_unlink_handle(struct input_handle *handle)
{
	struct input_handle **handleptr;

	handleptr = &handle->dev->handle;
Start --->
	while (*handleptr && (*handleptr != handle))
		handleptr = &((*handleptr)->dnext);
Error --->
	*handleptr = (*handleptr)->dnext;

	handleptr = &handle->handler->handle;
	while (*handleptr && (*handleptr != handle))
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4/drivers/input/input.c:217:input_unlink_handle: ERROR:INTERNAL_NULL:215:217: [type=set] (set at line 215) Dereferencing NULL ptr "(null)" illegally! [val=200]
	while (*handleptr && (*handleptr != handle))
		handleptr = &((*handleptr)->dnext);
	*handleptr = (*handleptr)->dnext;

	handleptr = &handle->handler->handle;
Start --->
	while (*handleptr && (*handleptr != handle))
		handleptr = &((*handleptr)->hnext);
Error --->
	*handleptr = (*handleptr)->hnext;
}

void input_register_device(struct input_dev *dev)
---------------------------------------------------------
[BUG] contradiction
/u2/engler/mc/oses/linux/2.4.4/drivers/video/matrox/matroxfb_base.c:1969:matroxfb_register_device: ERROR:INTERNAL_NULL:1972:1969: [type=set] (set at line 1972) Dereferencing NULL ptr "drv" illegally! [val=300]

static void matroxfb_register_device(struct matrox_fb_info* minfo) {
	struct matroxfb_driver* drv;
	int i = 0;
	list_add(&ACCESS_FBINFO(next_fb), &matroxfb_list);
Error --->
	for (drv = matroxfb_driver_l(matroxfb_driver_list.next);
	     drv != matroxfb_driver_l(&matroxfb_driver_list);
	     drv = matroxfb_driver_l(drv->node.next)) {
Start --->
		if (drv && drv->probe) {
			void *p = drv->probe(minfo);
			if (p) {
				minfo->drivers_data[i] = p;
---------------------------------------------------------
[BUG] looks like
/u2/engler/mc/oses/linux/2.4.4/drivers/atm/iphase.c:677:ia_tx_poll: ERROR:INTERNAL_NULL:680:677: [type=set] (set at line 680) Dereferencing NULL ptr "vcc" illegally! [val=300]
       }

       skb1 = skb_dequeue(&iavcc->txing_skb);
       while (skb1 && (skb1 != skb)) {
          if (!(IA_SKB_STATE(skb1) & IA_TX_DONE)) {
Error --->
             printk("IA_tx_intr: Vci %d lost pkt!!!\n", vcc->vci);
          }
          IF_ERR(printk("Release the SKB not match\n");)
Start --->
          if (vcc && (vcc->pop) && (skb1->len != 0))
          {
             vcc->pop(vcc, skb1);
             IF_EVENT(printk("Tansmit Done - skb 0x%lx return\n",
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4/drivers/input/input.c:353:input_unregister_handler: ERROR:INTERNAL_NULL:350:353: [type=set] (set at line 350) Dereferencing NULL ptr "(null)" illegally! [val=300]

/*
 * Remove it.
 */

Start --->
	while (*handlerptr && (*handlerptr != handler))
		handlerptr = &((*handlerptr)->next);

Error --->
	*handlerptr = (*handlerptr)->next;

/*
 * Remove minors.
---------------------------------------------------------
[BUG] contra
/u2/engler/mc/oses/linux/2.4.4/drivers/net/wan/comx.c:920:comx_lookup: ERROR:INTERNAL_NULL:924:920: [type=set] (set at line 924) Dereferencing NULL ptr "de" illegally! [val=400]
{
	struct proc_dir_entry *de;
	struct inode *inode = NULL;

	if ((de = (struct proc_dir_entry *) dir->u.generic_ip) != NULL) {
Error --->
		for (de = de->subdir ; de ; de = de->next) {
			if ((de && de->low_ino) && 
			    (de->namelen == dentry->d_name.len) &&
			    (memcmp(dentry->d_name.name, de->name, 
Start --->
			    de->namelen) == 0))	{
			 	if ((inode = proc_get_inode(dir->i_sb, 
			 	    de->low_ino, de)) == NULL) { 
			 		printk(KERN_ERR "COMX: lookup error\n"); 
---------------------------------------------------------
[BUG] might be impossible if it's already on the list.
/u2/engler/mc/oses/linux/2.4.4/drivers/md/lvm-snap.c:60:lvm_pv_get_number: ERROR:INTERNAL_NULL:56:60: [type=set] (set at line 56) Dereferencing NULL ptr "vg" illegally! [val=400]
{
	uint p;

	for ( p = 0; p < vg->pv_max; p++)
	{
Start --->
		if ( vg->pv[p] == NULL) continue;
		if ( vg->pv[p]->pv_dev == rdev) break;
	}

Error --->
	return vg->pv[p]->pv_number;
}


---------------------------------------------------------
[BUG]  [GEM] looks like they deleted the else ;-)
/u2/engler/mc/oses/linux/2.4.4/net/irda/irqueue.c:742:dequeue_general: ERROR:INTERNAL_NULL:738:742: [type=set] (set at line 738) Dereferencing NULL ptr "(null)" illegally! [val=400]
	/*
	 * Set return value
	 */
	ret =  *queue;
		
Start --->
	if ( *queue == NULL ) {
		/*
		 * Queue was empty.
		 */
Error --->
	} if ( (*queue)->q_next == *queue ) {
		/* 
		 *  Queue only contained a single element. It will now be
		 *  empty.  
---------------------------------------------------------
[BUG] contradiction
/u2/engler/mc/oses/linux/2.4.4/drivers/net/wan/comx-hw-comx.c:1073:comxhw_write_proc: ERROR:INTERNAL_NULL:1069:1073: [type=set] (set at line 1069) Dereferencing NULL ptr "firmware" illegally! [val=400]
			return -ENOMEM;
		}
		
		/* Ha nem 0 a fpos, akkor meglevo file-t irunk. Gyenge trukk. */
		if (hw->firmware && hw->firmware->len && file->f_pos 
Start --->
		    && hw->firmware->len < count + file->f_pos) {
			memcpy(tmp, hw->firmware->data, hw->firmware->len);
		}
		if (hw->firmware->data) {
Error --->
			kfree(hw->firmware->data);
		}
		copy_from_user(tmp + file->f_pos, buffer, count);
		hw->firmware->len = entry->size = file->f_pos + count;
---------------------------------------------------------
[BUG] contradiction
/u2/engler/mc/oses/linux/2.4.4/drivers/scsi/aic7xxx/aic7xxx_linux.c:1853:ahc_send_async: ERROR:INTERNAL_NULL:1849:1853: [type=set] (set at line 1849) Dereferencing NULL ptr "targ" illegally! [val=400]
		targ = ahc->platform_data->targets[target_offset];
		if (targ != NULL
		 && tinfo->current.period == targ->last_tinfo.period
		 && tinfo->current.width == targ->last_tinfo.width
		 && tinfo->current.offset == targ->last_tinfo.offset
Start --->
		 && tinfo->current.ppr_options == targ->last_tinfo.ppr_options)
			if (bootverbose == 0)
				break;

Error --->
		targ->last_tinfo.period = tinfo->current.period;
		targ->last_tinfo.width = tinfo->current.width;
		targ->last_tinfo.offset = tinfo->current.offset;
		targ->last_tinfo.ppr_options = tinfo->current.ppr_options;
---------------------------------------------------------
[BUG]  does a printk, then segfaults.
/u2/engler/mc/oses/linux/2.4.4/fs/ntfs/inode.c:307:ntfs_init_inode: ERROR:INTERNAL_NULL:303:307: [type=set] (set at line 303) Dereferencing NULL ptr "vol" illegally! [val=400]
{
	char *buf;
	int error;

	ntfs_debug(DEBUG_FILE1, "Initializing inode %x\n", inum);
Start --->
	if (!vol)
		ntfs_error("NO VOLUME!\n");
	ino->i_number = inum;
	ino->vol = vol;
Error --->
	ino->attr = buf = ntfs_malloc(vol->mft_recordsize);
	if (!buf)
		return -ENOMEM;
	error = ntfs_read_mft_record(vol, inum, ino->attr);
---------------------------------------------------------
[BUG] contradiction
/u2/engler/mc/oses/linux/2.4.4/drivers/video/fbcon-mfb.c:162:fbcon_mfb_clear_margins: ERROR:INTERNAL_NULL:158:162: [type=set] (set at line 158) Dereferencing NULL ptr "conp" illegally! [val=400]
void fbcon_mfb_clear_margins(struct vc_data *conp, struct display *p,
			     int bottom_only)
{
    u8 *dest;
    int height, bottom;
Start --->
    int inverse = conp ? attr_reverse(p,conp->vc_video_erase_char) : 0;

    /* XXX Need to handle right margin? */

Error --->
    height = p->var.yres - conp->vc_rows * fontheight(p);
    if (!height)
	return;
    bottom = conp->vc_rows + p->yscroll;
---------------------------------------------------------
[BUG] inverted test?
/u2/engler/mc/oses/linux/2.4.4/drivers/char/epca.c:2323:doevent: ERROR:INTERNAL_NULL:2319:2323: [type=set] (set at line 2319) Dereferencing NULL ptr "ch" illegally! [val=400]
		mstat = eventbuf[2];
		lstat = eventbuf[3];

		ch = chan0 + channel;

Start --->
		if ((unsigned)channel >= bd->numports || !ch) 
		{ 
			if (channel >= bd->numports)
				ch = chan0;
Error --->
			bc = ch->brdchan;
			goto next;
		}

---------------------------------------------------------
[BUG] inverted test
/u2/engler/mc/oses/linux/2.4.4/drivers/net/hamradio/soundmodem/sm.c:502:sm_ioctl: ERROR:INTERNAL_NULL:497:502: [type=set] (set at line 497) Dereferencing NULL ptr "mode_tx" illegally! [val=500]
		cp = hi->data.modename;
		if (sm->hwdrv && sm->hwdrv->hw_name)
			cp += sprintf(cp, "%s:", sm->hwdrv->hw_name);
		else
			cp += sprintf(cp, "<unspec>:");
Start --->
		if (sm->mode_tx && sm->mode_tx->name)
			cp += sprintf(cp, "%s", sm->mode_tx->name);
		else
			cp += sprintf(cp, "<unspec>");
		if (!sm->mode_rx || !sm->mode_rx ||
Error --->
		    strcmp(sm->mode_rx->name, sm->mode_tx->name)) {
			if (sm->mode_rx && sm->mode_rx->name)
				cp += sprintf(cp, ",%s", sm->mode_rx->name);
			else
---------------------------------------------------------
[BUG] contradiction
/u2/engler/mc/oses/linux/2.4.4/net/ipv4/ip_options.c:257:ip_options_compile: ERROR:INTERNAL_NULL:252:257: [type=set] (set at line 252) Dereferencing NULL ptr "skb" illegally! [val=500]
	int l;
	unsigned char * iph;
	unsigned char * optptr;
	int optlen;
	unsigned char * pp_ptr = NULL;
Start --->
	struct rtable *rt = skb ? (struct rtable*)skb->dst : NULL;

	if (!opt) {
		opt = &(IPCB(skb)->opt);
		memset(opt, 0, sizeof(struct ip_options));
Error --->
		iph = skb->nh.raw;
		opt->optlen = ((struct iphdr *)iph)->ihl*4 - sizeof(struct iphdr);
		optptr = iph + sizeof(struct iphdr);
		opt->is_data = 0;
---------------------------------------------------------
[BUG] cut and paste contradiction
/u2/engler/mc/oses/linux/2.4.4/drivers/net/aironet4500_core.c:1817:awc_802_11_after_tx_packet_to_card_write: ERROR:INTERNAL_NULL:1812:1817: [type=set] (set at line 1812) Dereferencing NULL ptr "tx_buff" illegally! [val=500]
					 struct awc_fid * tx_buff){


	AWC_ENTRY_EXIT_DEBUG("awc_802_11_after_tx_packet_to_card_write");

Start --->
	if (!tx_buff){
		DEBUG(1,"%s no damn tx_buff in awc_802_11_after_tx_packet_to_card_write \n",dev->name);
	};

	if(tx_buff->skb){
Error --->
		dev_kfree_skb(tx_buff->skb);
		tx_buff->skb = NULL;
	}

---------------------------------------------------------
[BUG] debug msg, then segfault.
/u2/engler/mc/oses/linux/2.4.4/drivers/net/aironet4500_core.c:398:awc_bap_setup: ERROR:INTERNAL_NULL:393:398: [type=set] (set at line 393) Dereferencing NULL ptr "bap" illegally! [val=500]
	udelay(bap_sleep);
	
	if (cmd->priv->ejected)
		return -1;
          
Start --->
     if (!cmd->bap || !(cmd->lock_state & (AWC_BAP_SEMALOCKED |AWC_BAP_LOCKED)))
     	DEBUG(1,"no bap or bap not locked cmd %d !!", cmd->command);

	if (bap_setup_spinlock)
		my_spin_lock_irqsave(&cmd->priv->bap_setup_spinlock,cmd->priv->bap_setup_spinlock_flags);	  
Error --->
	  status = AWC_IN(cmd->bap->offset);
	  
	  if (status & ~0x2000 ){
	  	WAIT61x3;
---------------------------------------------------------
[BUG] [GEM] hilarious
/u2/engler/mc/oses/linux/2.4.4/drivers/net/wan/sdlamain.c:394:setup: ERROR:INTERNAL_NULL:389:394: [type=set] (set at line 389) Dereferencing NULL ptr "wandev" illegally! [val=500]
	sdla_t* card;
	int err = 0;
	int irq=0;

	/* Sanity checks */
Start --->
	if ((wandev == NULL) || (wandev->private == NULL) || (conf == NULL)){
		printk(KERN_INFO 
		      "%s: Failed Sdlamain Setup wandev %u, card %u, conf %u !\n",
		      wandev->name,
		      (unsigned int)wandev,(unsigned int)wandev->private,
Error --->
		      (unsigned int)conf); 
		return -EFAULT;
	}

---------------------------------------------------------
[BUG] contradiction
/u2/engler/mc/oses/linux/2.4.4/net/core/neighbour.c:317:neigh_create: ERROR:INTERNAL_NULL:312:317: [type=set] (set at line 312) Dereferencing NULL ptr "parms" illegally! [val=500]
		return ERR_PTR(error);
	}

	/* Device specific setup. */
	if (n->parms && n->parms->neigh_setup &&
Start --->
	    (error = n->parms->neigh_setup(n)) < 0) {
		neigh_release(n);
		return ERR_PTR(error);
	}

Error --->
	n->confirmed = jiffies - (n->parms->base_reachable_time<<1);

	hash_val = tbl->hash(pkey, dev);

---------------------------------------------------------
[BUG] contradiction
/u2/engler/mc/oses/linux/2.4.4/drivers/net/hamradio/soundmodem/sm.c:425:sm_close: ERROR:INTERNAL_NULL:420:425: [type=set] (set at line 420) Dereferencing NULL ptr "hwdrv" illegally! [val=500]
		return -EINVAL;
	}
	sm = (struct sm_state *)dev->priv;


Start --->
	if (sm->hwdrv && sm->hwdrv->close)
		err = sm->hwdrv && sm->hwdrv->close(dev, sm);
	sm_output_close(sm);
	MOD_DEC_USE_COUNT;
	printk(KERN_INFO "%s: close %s at iobase 0x%lx irq %u dma %u\n",
Error --->
	       sm_drvname, sm->hwdrv->hw_name, dev->base_addr, dev->irq, dev->dma);
	return err;
}

---------------------------------------------------------
[BUG]  contradiction
/u2/engler/mc/oses/linux/2.4.4/drivers/net/aironet4500_core.c:1844:awc_802_11_after_failed_tx_packet_to_card_write: ERROR:INTERNAL_NULL:1839:1844: [type=set] (set at line 1839) Dereferencing NULL ptr "tx_buff" illegally! [val=500]
        struct awc_private * priv = (struct awc_private *)dev->priv;


	AWC_ENTRY_EXIT_DEBUG("awc_802_11_after_failed_tx_packet_to_card_write");

Start --->
	if (!tx_buff){
		DEBUG(1,"%s no damn tx_buff in awc_802_11_after_failed_tx_packet_to_card_write \n",dev->name);
	};

	if(tx_buff->skb){
Error --->
		dev_kfree_skb(tx_buff->skb);
		tx_buff->skb = NULL;
		tx_buff->busy =0;
		printk(KERN_ERR "%s packet to card write failed \n",dev->name);
---------------------------------------------------------
[BUG] contradicts
/u2/engler/mc/oses/linux/2.4.4/drivers/video/fbcon-hga.c:198:fbcon_hga_clear_margins: ERROR:INTERNAL_NULL:192:198: [type=set] (set at line 192) Dereferencing NULL ptr "conp" illegally! [val=600]
void fbcon_hga_clear_margins(struct vc_data *conp, struct display *p,
			     int bottom_only)
{
	u8 *dest;
	u_int height, y;
Start --->
	int inverse = conp ? attr_reverse(p,conp->vc_video_erase_char) : 0;

	DPRINTK("fbcon_hga_clear_margins: enter\n");

	/* No need to handle right margin. */

Error --->
	y = conp->vc_rows * fontheight(p);
	for (height = p->var.yres - y; height-- > 0; y++) {
		DPRINTK("fbcon_hga_clear_margins: y:%d, height:%d\n", y, height);
		dest = rowaddr(p, y);
---------------------------------------------------------
[BUG] contradicts
/u2/engler/mc/oses/linux/2.4.4/net/ipv4/ip_input.c:325:ip_rcv_finish: ERROR:INTERNAL_NULL:319:325: [type=set] (set at line 319) Dereferencing NULL ptr "dst" illegally! [val=600]

	/*
	 *	Initialise the virtual path cache for the packet. It describes
	 *	how the packet travels inside Linux networking.
	 */ 
Start --->
	if (skb->dst == NULL) {
		if (ip_route_input(skb, iph->daddr, iph->saddr, iph->tos, dev))
			goto drop; 
	}

#ifdef CONFIG_NET_CLS_ROUTE
Error --->
	if (skb->dst->tclassid) {
		struct ip_rt_acct *st = ip_rt_acct + 256*smp_processor_id();
		u32 idx = skb->dst->tclassid;
		st[idx&0xFF].o_packets++;
---------------------------------------------------------
[BUG] contradicts.
/u2/engler/mc/oses/linux/2.4.4/net/ipv4/devinet.c:544:devinet_ioctl: ERROR:INTERNAL_NULL:537:544: [type=set] (set at line 537) Dereferencing NULL ptr "ifa" illegally! [val=700]
		for (ifap=&in_dev->ifa_list; (ifa=*ifap) != NULL; ifap=&ifa->ifa_next)
			if (strcmp(ifr.ifr_name, ifa->ifa_label) == 0)
				break;
	}

Start --->
	if (ifa == NULL && cmd != SIOCSIFADDR && cmd != SIOCSIFFLAGS) {
		ret = -EADDRNOTAVAIL;
		goto done;
	}

	switch(cmd) {
		case SIOCGIFADDR:	/* Get interface address */
Error --->
			sin->sin_addr.s_addr = ifa->ifa_local;
			goto rarok;

		case SIOCGIFBRDADDR:	/* Get the broadcast address */
---------------------------------------------------------
[BUG] should be ||?
/u2/engler/mc/oses/linux/2.4.4/net/decnet/dn_dev.c:500:dn_dev_ioctl: ERROR:INTERNAL_NULL:493:500: [type=set] (set at line 493) Dereferencing NULL ptr "ifa" illegally! [val=700]
		for (ifap = &dn_db->ifa_list; (ifa=*ifap) != NULL; ifap = &ifa->ifa_next)
			if (strcmp(ifr->ifr_name, ifa->ifa_label) == 0)
				break;
	}

Start --->
	if (ifa == NULL && cmd != SIOCSIFADDR) {
		ret = -EADDRNOTAVAIL;
		goto done;
	}

	switch(cmd) {
		case SIOCGIFADDR:
Error --->
			*((dn_address *)sdn->sdn_nodeaddr) = ifa->ifa_local;
			goto rarok;

		case SIOCSIFADDR:
---------------------------------------------------------
[BUG] contradicts
/u2/engler/mc/oses/linux/2.4.4/net/decnet/dn_route.c:808:dn_route_output_slow: ERROR:INTERNAL_NULL:798:808: [type=set] (set at line 798) Dereferencing NULL ptr "neigh" illegally! [val=1000]
	
	rt->key.saddr  = src;
	rt->rt_saddr   = src;
	rt->key.daddr  = dst;
	rt->rt_daddr   = dst;
Start --->
	rt->key.oif    = neigh ? neigh->dev->ifindex : -1;
	rt->key.iif    = 0;
	rt->key.fwmark = 0;

	rt->u.dst.neighbour = neigh;
	rt->u.dst.dev = neigh ? neigh->dev : NULL;
	rt->u.dst.lastuse = jiffies;
	rt->u.dst.output = dn_output;
	rt->u.dst.input  = dn_rt_bug;

Error --->
	if (dn_dev_islocal(neigh->dev, rt->rt_daddr))
		rt->u.dst.input = dn_nsp_rx;

	hash = dn_hash(rt->key.saddr, rt->key.daddr);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4/drivers/char/stallion.c:1035:stl_open: ERROR:INTERNAL_NULL:1024:1035: [type=set] (set at line 1024) Dereferencing NULL ptr "brdp" illegally! [val=1100]
	brdp = stl_brds[brdnr];
	if (brdp == (stlbrd_t *) NULL)
		return(-ENODEV);
	minordev = MINOR2PORT(minordev);
	for (portnr = -1, panelnr = 0; (panelnr < STL_MAXPANELS); panelnr++) {
Start --->
		if (brdp->panels[panelnr] == (stlpanel_t *) NULL)
			break;
		if (minordev < brdp->panels[panelnr]->nrports) {
			portnr = minordev;
			break;
		}
		minordev -= brdp->panels[panelnr]->nrports;
	}
	if (portnr < 0)
		return(-ENODEV);

Error --->
	portp = brdp->panels[panelnr]->ports[portnr];
	if (portp == (stlport_t *) NULL)
		return(-ENODEV);

---------------------------------------------------------
[BUG]  very contradictory code.
/u2/engler/mc/oses/linux/2.4.4/drivers/atm/iphase.c:691:ia_tx_poll: ERROR:INTERNAL_NULL:680:691: [type=set] (set at line 680) Dereferencing NULL ptr "vcc" illegally! [val=1100]
       while (skb1 && (skb1 != skb)) {
          if (!(IA_SKB_STATE(skb1) & IA_TX_DONE)) {
             printk("IA_tx_intr: Vci %d lost pkt!!!\n", vcc->vci);
          }
          IF_ERR(printk("Release the SKB not match\n");)
Start --->
          if (vcc && (vcc->pop) && (skb1->len != 0))
          {
             vcc->pop(vcc, skb1);
             IF_EVENT(printk("Tansmit Done - skb 0x%lx return\n",
                                                          (long)skb1);)
          }
          else 
             dev_kfree_skb_any(skb1);
          skb1 = skb_dequeue(&iavcc->txing_skb);
       }                                                        
       if (!skb1) {
Error --->
          IF_EVENT(printk("IA: Vci %d - skb not found requed\n",vcc->vci);)
          ia_enque_head_rtn_q (&iadev->tx_return_q, rtne);
          break;
       }
---------------------------------------------------------
[BUG] just falls through
/u2/engler/mc/oses/linux/2.4.4/drivers/scsi/g_NCR5380.c:404:generic_NCR5380_detect: ERROR:INTERNAL_NULL:393:404: [type=set] (set at line 393) Dereferencing NULL ptr "instance" illegally! [val=1100]
		continue;
	request_mem_region(overrides[current_override].NCR5380_map_name,
					NCR5380_region_size, "ncr5380");
#endif
	instance = scsi_register (tpnt, sizeof(struct NCR5380_hostdata));
Start --->
	if(instance == NULL)
	{
#ifdef CONFIG_SCSI_G_NCR5380_PORT
		release_region(overrides[current_override].NCR5380_map_name,
	                                        NCR5380_region_size);
#else
		release_mem_region(overrides[current_override].NCR5380_map_name,
	                                  	NCR5380_region_size);
#endif
	}
	
Error --->
	instance->NCR5380_instance_name = overrides[current_override].NCR5380_map_name;

	NCR5380_init(instance, flags);

---------------------------------------------------------
[BUG] major contradiction.
/u2/engler/mc/oses/linux/2.4.4/drivers/ide/amd7409.c:370:config_drive_xfer_rate: ERROR:INTERNAL_NULL:333:370: [type=set] (set at line 333) Dereferencing NULL ptr "id" illegally! [val=3700]
static int config_drive_xfer_rate (ide_drive_t *drive)
{
	struct hd_driveid *id = drive->id;
	ide_dma_action_t dma_func = ide_dma_on;

Start --->
	if (id && (id->capability & 1) && HWIF(drive)->autodma) {

	... DELETED 31 lines ...

			if (dma_func != ide_dma_on)
				goto no_dma_set;
		} else {
			goto fast_ata_pio;
		}
Error --->
	} else if ((id->capability & 8) || (id->field_valid & 2)) {
fast_ata_pio:
		dma_func = ide_dma_off_quietly;
no_dma_set:
---------------------------------------------------------
[BUG]  seems like it, unless there is a weird DP going on.
/u2/engler/mc/oses/linux/2.4.4/net/econet/af_econet.c:310:econet_sendmsg: ERROR:INTERNAL_NULL:268:310: [type=set] (set at line 268) Dereferencing NULL ptr "saddr" illegally! [val=4200]

	/*
	 *	Get and verify the address. 
	 */
	 
Start --->
	if (saddr == NULL) {

	... DELETED 36 lines ...

		skb_reserve(skb, (dev->hard_header_len+15)&~15);
		skb->nh.raw = skb->data;
		
		eb = (struct ec_cb *)&skb->cb;
		
Error --->
		eb->cookie = saddr->cookie;
		eb->sec = *saddr;
		eb->sent = ec_tx_done;

---------------------------------------------------------
[BUG] ditto
/u2/engler/mc/oses/linux/2.4.4/drivers/scsi/in2000.c:1349:in2000_intr: ERROR:INTERNAL_NULL:1009:1349: [type=set] (set at line 1009) Dereferencing NULL ptr "cmd" illegally! [val=34000]

   cmd = (Scsi_Cmnd *)hostdata->connected;   /* assume we're connected */
   sr = read_3393(hostdata,WD_SCSI_STATUS);  /* clear the interrupt */
   phs = read_3393(hostdata,WD_COMMAND_PHASE);

Start --->
   if (!cmd && (sr != CSR_RESEL_AM && sr != CSR_TIMEOUT && sr != CSR_SELECT)) {

	... DELETED 334 lines ...

 */

         write_3393(hostdata,WD_SOURCE_ID, SRCID_ER);
         if (phs == 0x60) {
DB(DB_INTR,printk("SX-DONE-%ld",cmd->pid))
Error --->
            cmd->SCp.Message = COMMAND_COMPLETE;
            lun = read_3393(hostdata,WD_TARGET_LUN);
DB(DB_INTR,printk(":%d.%d",cmd->SCp.Status,lun))
            hostdata->connected = NULL;
---------------------------------------------------------
[BUG]  seems like a bug --- they do check cmd against null, implying it can
       be, but then deref on a bunch of paths after.  should this be ||?
/u2/engler/mc/oses/linux/2.4.4/drivers/scsi/in2000.c:1370:in2000_intr: ERROR:INTERNAL_NULL:1009:1370: [type=set] (set at line 1009) Dereferencing NULL ptr "cmd" illegally! [val=36100]

   cmd = (Scsi_Cmnd *)hostdata->connected;   /* assume we're connected */
   sr = read_3393(hostdata,WD_SCSI_STATUS);  /* clear the interrupt */
   phs = read_3393(hostdata,WD_COMMAND_PHASE);

Start --->
   if (!cmd && (sr != CSR_RESEL_AM && sr != CSR_TIMEOUT && sr != CSR_SELECT)) {

	... DELETED 355 lines ...

 */

            in2000_execute(instance);
            }
         else {
Error --->
            printk("%02x:%02x:%02x-%ld: Unknown SEL_XFER_DONE phase!!---",asr,sr,phs,cmd->pid);
            }
         break;

