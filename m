Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316544AbSFJD5X>; Sun, 9 Jun 2002 23:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSFJD43>; Sun, 9 Jun 2002 23:56:29 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:22420 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S316531AbSFJDz6>;
	Sun, 9 Jun 2002 23:55:58 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200206100355.UAA17053@csl.Stanford.EDU>
Subject: [CHECKER] 24 memory leaks on error paths in 2.4.17
To: linux-kernel@vger.kernel.org
Date: Sun, 9 Jun 2002 20:55:58 -0700 (PDT)
Cc: mc@cs.Stanford.EDU
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This checker warns when you do not free allocated memory on failure paths.
Note: while we only include 24 errors, there were lots in general; let me
know if more are useful.

Dawson

# BUGs	|	File Name
4	|	/drivers/lvm.c
2	|	/mtd/cfi_cmdset_0002.c
2	|	/isdn/capi.c
2	|	/media/msp3400.c
2	|	/drivers/ixj.c
2	|	/drivers/cpqfcTSinit.c
1	|	/fs/rock.c
1	|	/drivers/ixj_pcmcia.c
1	|	/drivers/cs4232.c
1	|	/drivers/radeonfb.c
1	|	/2.4.17/socket.c
1	|	/net/vlanproc.c
1	|	/net/aironet4500_cs.c
1	|	/mtd/sharp.c
1	|	/isdn/avm_cs.c
1	|	/isdn/icn.c


############################################################
# 2.4.17 specific errors

#
---------------------------------------------------------
[BUG] good stat ranking.
/u2/engler/mc/oses/linux/2.4.17/drivers/video/radeonfb.c:788:radeonfb_pci_register: ERROR:INVERSE:688:788:UNREVERSED 'rinfo' on error path! set by 'kmalloc':688 [nbytes=2216] [rank=easy] [COUNTER=kmalloc:688] [ERROR] [fit=2] [fit_fn=1] [fn_ex=4] [fn_counter=1] [ex=4] [counter=1] [z = -1.53896752812773] [fn-z = -1.53896752812773]
	int i, j;
	char *bios_seg = NULL;

	RTRACE("radeonfb_pci_register BEGIN\n");

Start --->
	rinfo = kmalloc (sizeof (struct radeonfb_info), GFP_KERNEL);

	... DELETED 94 lines ...

		case PCI_DEVICE_ID_RADEON_LZ:
			strcpy(rinfo->name, "Radeon M6 LZ ");
			rinfo->hasCRTC2 = 1;
			break;
		default:
Error --->
			return -ENODEV;
	}

	/* framebuffer size */
---------------------------------------------------------
[BUG] good stat example.  2 others.
/u2/engler/mc/oses/linux/2.4.17/drivers/isdn/icn/icn.c:847:icn_loadboot: ERROR:INVERSE:820:847:UNREVERSED 'codebuf' on error path! set by 'kmalloc':820 [nbytes=1] [rank=easy] [COUNTER=kmalloc:820] [ERROR] [fit=4] [fit_fn=1] [fn_ex=3] [fn_counter=1] [ex=3] [counter=1] [z = -1.83532587096449] [fn-z = -1.83532587096449]
	unsigned long flags;

#ifdef BOOT_DEBUG
	printk(KERN_DEBUG "icn_loadboot called, buffaddr=%08lx\n", (ulong) buffer);
#endif
Start --->
	if (!(codebuf = kmalloc(ICN_CODE_STAGE1, GFP_KERNEL))) {

	... DELETED 21 lines ...

	}
	if (!dev.mvalid) {
		if (check_mem_region(dev.memaddr, 0x4000)) {
			printk(KERN_WARNING
			       "icn: memory at 0x%08lx in use.\n", dev.memaddr);
Error --->
			return -EBUSY;
		}
		request_mem_region(dev.memaddr, 0x4000, "icn-isdn (all cards)");
		dev.shmem = ioremap(dev.memaddr, 0x4000);
---------------------------------------------------------
[BUG]  no real examples though.
/u2/engler/mc/oses/linux/2.4.17/drivers/isdn/avmb1/avm_cs.c:184:avmcs_attach: ERROR:INVERSE:149:184:UNREVERSED 'link' on error path! set by 'kmalloc':149 [nbytes=144] [rank=easy] [COUNTER=kmalloc:149] [ERROR] [fit=6] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=2] [counter=1] [z = -2.25170500701057] [fn-z = -4.35889894354067]
    dev_link_t *link;
    local_info_t *local;
    int ret, i;
    
    /* Initialize the dev_link_t structure */
Start --->
    link = kmalloc(sizeof(struct dev_link_t), GFP_KERNEL);

	... DELETED 29 lines ...

    link->conf.Present = PRESENT_OPTION;

    /* Allocate space for private device-specific data */
    local = kmalloc(sizeof(local_info_t), GFP_KERNEL);
    if (!local)
Error --->
	return NULL;
    memset(local, 0, sizeof(local_info_t));
    link->priv = local;
    
---------------------------------------------------------
[BUG] not good stat: no other examples.
/u2/engler/mc/oses/linux/2.4.17/drivers/telephony/ixj_pcmcia.c:75:ixj_attach: ERROR:INVERSE:62:75:UNREVERSED 'link' on error path! set by 'kmalloc':62 [nbytes=144] [rank=easy] [COUNTER=kmalloc:62] [ERROR] [fit=8] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=2] [counter=1] [z = -2.25170500701057] [fn-z = -4.35889894354067]
	client_reg_t client_reg;
	dev_link_t *link;
	int ret;
	DEBUG(0, "ixj_attach()\n");
	/* Create new ixj device */
Start --->
	link = kmalloc(sizeof(struct dev_link_t), GFP_KERNEL);
	if (!link)
		return NULL;
	memset(link, 0, sizeof(struct dev_link_t));
	link->release.function = &ixj_cs_release;
	link->release.data = (u_long) link;
	link->io.Attributes1 = IO_DATA_PATH_WIDTH_8;
	link->io.Attributes2 = IO_DATA_PATH_WIDTH_8;
	link->io.IOAddrLines = 3;
	link->conf.Vcc = 50;
	link->conf.IntType = INT_MEMORY_AND_IO;
	link->priv = kmalloc(sizeof(struct ixj_info_t), GFP_KERNEL);
	if (!link->priv)
Error --->
		return NULL;
	memset(link->priv, 0, sizeof(struct ixj_info_t));
	/* Register with Card Services */
	link->next = dev_list;
---------------------------------------------------------
[BUG]  good stat: though should have a lower p0 value. (2 examples, ranked lower)
/u2/engler/mc/oses/linux/2.4.17/drivers/sound/cs4232.c:409:cs4232_isapnp_probe: ERROR:INVERSE:382:409:UNREVERSED 'isapnpcfg' on error path! set by 'kmalloc':382 [nbytes=68] [rank=easy] [COUNTER=kmalloc:382] [ERROR] [fit=9] [fit_fn=1] [fn_ex=2] [fn_counter=1] [ex=2] [counter=1] [z = -2.25170500701057] [fn-z = -2.25170500701057]
int cs4232_isapnp_probe(struct pci_dev *dev, const struct isapnp_device_id *id)
{
	int ret;
	struct address_info *isapnpcfg;

Start --->
	isapnpcfg=(struct address_info*)kmalloc(sizeof(*isapnpcfg),GFP_KERNEL);

	... DELETED 21 lines ...

	isapnpcfg->dma		= dev->dma_resource[0].start;
	isapnpcfg->dma2		= dev->dma_resource[1].start;
	isapnpcfg->io_base	= dev->resource[0].start;
	if (probe_cs4232(isapnpcfg,TRUE) == 0) {
		printk(KERN_ERR "cs4232: ISA PnP card found, but not detected?\n");
Error --->
		return -ENODEV;
	}
	attach_cs4232(isapnpcfg);
	pci_set_drvdata(dev,isapnpcfg);
---------------------------------------------------------
[BUG] pretty sure.  rank should not be easy since it's passed to FN (BROKE)
/u2/engler/mc/oses/linux/2.4.17/net/8021q/vlanproc.c:256:vlan_proc_read: ERROR:INVERSE:244:256:UNREVERSED 'page' on error path! set by 'kmalloc':244 [nbytes=1] [rank=easy] [COUNTER=kmalloc:244] [ERROR] [fit=10] [fit_fn=1] [fn_ex=1] [fn_counter=1] [ex=2] [counter=1] [z = -2.25170500701057] [fn-z = -2.91998558035372]

	dent = inode->u.generic_ip;
	if ((dent == NULL) || (dent->get_info == NULL))
		return 0;

Start --->
	page = kmalloc(VLAN_PROC_BUFSZ, GFP_KERNEL);
	VLAN_MEM_DBG("page malloc, addr: %p  size: %i\n",
		     page, VLAN_PROC_BUFSZ);

	if (page == NULL)
		return -ENOBUFS;

	pos = dent->get_info(page, dent->data, 0, 0);
	offs = file->f_pos;
	if (offs < pos) {
		len = min_t(int, pos - offs, count);
		if (copy_to_user(buf, (page + offs), len))
Error --->
			return -EFAULT;

		file->f_pos += len;
	} else {
---------------------------------------------------------
[BUG]  i think so.  hard to follow paths though (FPP?)
/u2/engler/mc/oses/linux/2.4.17/fs/isofs/rock.c:588:rock_ridge_symlink_readpage: ERROR:INVERSE:560:588:UNREVERSED 'buffer' on error path! set by 'kmalloc':560 [nbytes=0] [rank=easy] [COUNTER=kmalloc:560] [ERROR] [fit=11] [fit_fn=1] [fn_ex=2] [fn_counter=1] [ex=2] [counter=1] [z = -2.25170500701057] [fn-z = -2.25170500701057]
			CHECK_CE;
		default:
			break;
		}
	}
Start --->
	MAYBE_CONTINUE(repeat, inode);

	... DELETED 22 lines ...

	brelse(bh);
	unlock_kernel();
	SetPageError(page);
	kunmap(page);
	UnlockPage(page);
Error --->
	return -EIO;
}

struct address_space_operations isofs_symlink_aops = {
---------------------------------------------------------
[BUG] great stat example, since freed right above; p0 should be lower though.
/u2/engler/mc/oses/linux/2.4.17/drivers/net/pcmcia/aironet4500_cs.c:219:awc_attach: ERROR:INVERSE:179:219:UNREVERSED 'link' on error path! set by 'kmalloc':179 [nbytes=144] [rank=easy] [COUNTER=kmalloc:179] [ERROR] [fit=12] [fit_fn=1] [fn_ex=2] [fn_counter=1] [ex=2] [counter=1] [z = -2.25170500701057] [fn-z = -2.25170500701057]

	PC_DEBUG(0, "awc_attach()\n");
	flush_stale_links();

	/* Create the PC card device object. */
Start --->
	link = kmalloc(sizeof(struct dev_link_t), GFP_KERNEL);

	... DELETED 34 lines ...

		kfree(link);
		return NULL;
	};
	memset(dev,0,sizeof(struct net_device));
	dev->priv = kmalloc(sizeof(struct awc_private), GFP_KERNEL);
Error --->
	if (!dev->priv ) {printk(KERN_CRIT "out of mem on dev priv alloc \n"); return NULL;};
	memset(dev->priv,0,sizeof(struct awc_private));
	
//	link->dev->minor = dev->minor;
---------------------------------------------------------
[BUG]  really good stat example --- code below frees when "on" true,  showing
       that its a valid path (or the other guy is wrong).
/u2/engler/mc/oses/linux/2.4.17/net/socket.c:760:sock_fasync: ERROR:INVERSE:751:760:UNREVERSED 'fna' on error path! set by 'kmalloc':751 [nbytes=16] [rank=easy] [COUNTER=kmalloc:751] [ERROR] [fit=16] [fit_fn=1] [fn_ex=1] [fn_counter=1] [ex=1] [counter=1] [z = -2.91998558035372] [fn-z = -2.91998558035372]
	struct socket *sock;
	struct sock *sk;

	if (on)
	{
Start --->
		fna=(struct fasync_struct *)kmalloc(sizeof(struct fasync_struct), GFP_KERNEL);
		if(fna==NULL)
			return -ENOMEM;
	}


	sock = socki_lookup(filp->f_dentry->d_inode);
	
	if ((sk=sock->sk) == NULL)
Error --->
		return -EINVAL;

	lock_sock(sk);

---------------------------------------------------------
[BUG] stat is not so good here since the bug is easy, but no corrective
      action in function pushes error low.
/u2/engler/mc/oses/linux/2.4.17/drivers/mtd/chips/sharp.c:120:sharp_probe: ERROR:INVERSE:114:120:UNREVERSED 'mtd' on error path! set by 'kmalloc':114 [nbytes=124] [rank=easy] [COUNTER=kmalloc:114] [ERROR] [fit=19] [fit_fn=1] [fn_ex=1] [fn_counter=1] [ex=1] [counter=1] [z = -2.91998558035372] [fn-z = -2.91998558035372]
{
	struct mtd_info *mtd = NULL;
	struct sharp_info *sharp = NULL;
	int width;

Start --->
	mtd = kmalloc(sizeof(*mtd), GFP_KERNEL);
	if(!mtd)
		return NULL;

	sharp = kmalloc(sizeof(*sharp), GFP_KERNEL);
	if(!sharp)
Error --->
		return NULL;

	memset(mtd, 0, sizeof(*mtd));

---------------------------------------------------------
[BUG]  weird though: they sometimes free, sometimes not.
/u2/engler/mc/oses/linux/2.4.17/drivers/mtd/chips/cfi_cmdset_0002.c:177:cfi_amdstd_setup: ERROR:INVERSE:150:177:UNREVERSED 'mtd' on error path! set by 'kmalloc':150 [nbytes=124] [rank=easy] [COUNTER=kmalloc:150] [ERROR] [fit=24] [fit_fn=1] [fn_ex=1] [fn_counter=2] [ex=3] [counter=2] [z = -3.59092423229804] [fn-z = -4.90076972114066]
{
	struct cfi_private *cfi = map->fldrv_priv;
	struct mtd_info *mtd;
	unsigned long devsize = (1<<cfi->cfiq->DevSize) * cfi->interleave;

Start --->
	mtd = kmalloc(sizeof(*mtd), GFP_KERNEL);

	... DELETED 21 lines ...

		mtd->numeraseregions = cfi->cfiq->NumEraseRegions * cfi->numchips;
		mtd->eraseregions = kmalloc(sizeof(struct mtd_erase_region_info) * mtd->numeraseregions, GFP_KERNEL);
		if (!mtd->eraseregions) { 
			printk(KERN_WARNING "Failed to allocate memory for MTD erase region info\n");
			kfree(cfi->cmdset_priv);
Error --->
			return NULL;
		}
			
		for (i=0; i<cfi->cfiq->NumEraseRegions; i++) {
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/mtd/chips/cfi_cmdset_0002.c:200:cfi_amdstd_setup: ERROR:INVERSE:150:200:UNREVERSED 'mtd' on error path! set by 'kmalloc':150 [nbytes=124] [rank=easy] [COUNTER=kmalloc:150] [ERROR] [fit=24] [fit_fn=1] [fn_ex=1] [fn_counter=2] [ex=3] [counter=2] [z = -3.59092423229804] [fn-z = -4.90076972114066]
{
	struct cfi_private *cfi = map->fldrv_priv;
	struct mtd_info *mtd;
	unsigned long devsize = (1<<cfi->cfiq->DevSize) * cfi->interleave;

Start --->
	mtd = kmalloc(sizeof(*mtd), GFP_KERNEL);

	... DELETED 44 lines ...

		if (offset != devsize) {
			/* Argh */
			printk(KERN_WARNING "Sum of regions (%lx) != total size of set of interleaved chips (%lx)\n", offset, devsize);
			kfree(mtd->eraseregions);
			kfree(cfi->cmdset_priv);
Error --->
			return NULL;
		}
#if 0
		// debug
---------------------------------------------------------
[BUG] security --- has an example at the very end.
/u2/engler/mc/oses/linux/2.4.17/drivers/scsi/cpqfcTSinit.c:554:cpqfcTS_ioctl: ERROR:INVERSE:539:554:UNREVERSED 'buf' on error path! set by 'kmalloc':539 [nbytes=0] [rank=easy] [COUNTER=kmalloc:539] [ERROR] [fit=25] [fit_fn=1] [fn_ex=1] [fn_counter=2] [ex=2] [counter=2] [z = -4.12948320967011] [fn-z = -4.90076972114066]
	vendor_cmd = ioc.argp;  // i.e., CPQ specific command struct

	// If necessary, grab a kernel/DMA buffer
	if( vendor_cmd->len)
	{
Start --->
  	  buf = kmalloc( vendor_cmd->len, GFP_KERNEL);

	... DELETED 9 lines ...

        // Need data from user?
	// make sure caller's buffer is in kernel space.
	if( (vendor_cmd->rw_flag == VENDOR_WRITE_OPCODE) &&
	    vendor_cmd->len)
        if(  copy_from_user( buf, vendor_cmd->bufp, vendor_cmd->len))
Error --->
		return( -EFAULT);
	    
	// copy the CDB (if/when MAX_COMMAND_SIZE is 16, remove copy below)
        memcpy( &ScsiPassThruCmnd->cmnd[0], 
---------------------------------------------------------
[BUG]  beautiful example of how stat helps --- frees it right below!
/u2/engler/mc/oses/linux/2.4.17/drivers/scsi/cpqfcTSinit.c:630:cpqfcTS_ioctl: ERROR:INVERSE:539:630:UNREVERSED 'buf' on error path! set by 'kmalloc':539 [nbytes=0] [rank=easy] [COUNTER=kmalloc:539] [ERROR] [fit=25] [fit_fn=1] [fn_ex=1] [fn_counter=2] [ex=2] [counter=2] [z = -4.12948320967011] [fn-z = -4.90076972114066]
	vendor_cmd = ioc.argp;  // i.e., CPQ specific command struct

	// If necessary, grab a kernel/DMA buffer
	if( vendor_cmd->len)
	{
Start --->
  	  buf = kmalloc( vendor_cmd->len, GFP_KERNEL);

	... DELETED 85 lines ...


	// need to pass data back to user (space)?
	if( (vendor_cmd->rw_flag == VENDOR_READ_OPCODE) &&
	     vendor_cmd->len )
        if(  copy_to_user( vendor_cmd->bufp, buf, vendor_cmd->len))
Error --->
		return( -EFAULT);

        if( buf) 
	  kfree( buf);
---------------------------------------------------------
[BUG]  good stat example.
/u2/engler/mc/oses/linux/2.4.17/drivers/isdn/avmb1/capi.c:1194:capinc_raw_write: ERROR:INVERSE:1182:1194:UNREVERSED 'skb' on error path! set by 'alloc_skb':1182 [nbytes=168] [rank=easy] [COUNTER=alloc_skb:1182] [ERROR] [fit=26] [fit_fn=1] [fn_ex=2] [fn_counter=2] [ex=2] [counter=2] [z = -4.12948320967011] [fn-z = -4.12948320967011]
		return -ESPIPE;

	if (!mp || !mp->nccip)
		return -EINVAL;

Start --->
	skb = alloc_skb(CAPI_DATA_B3_REQ_LEN+count, GFP_USER);
	if (!skb)
		return -ENOMEM;

	skb_reserve(skb, CAPI_DATA_B3_REQ_LEN);
	if ((retval = copy_from_user(skb_put(skb, count), buf, count))) {
		kfree_skb(skb);
		return -EFAULT;
	}

	while (skb_queue_len(&mp->outqueue) > CAPINC_MAX_SENDQUEUE) {
		if (file->f_flags & O_NONBLOCK)
Error --->
			return -EAGAIN;
		interruptible_sleep_on(&mp->sendwait);
		if (mp->nccip == 0) {
			kfree_skb(skb);
---------------------------------------------------------
[BUG] another stat.
/u2/engler/mc/oses/linux/2.4.17/drivers/isdn/avmb1/capi.c:1201:capinc_raw_write: ERROR:INVERSE:1182:1201:UNREVERSED 'skb' on error path! set by 'alloc_skb':1182 [nbytes=168] [rank=easy] [COUNTER=alloc_skb:1182] [ERROR] [fit=26] [fit_fn=1] [fn_ex=2] [fn_counter=2] [ex=2] [counter=2] [z = -4.12948320967011] [fn-z = -4.12948320967011]
		return -ESPIPE;

	if (!mp || !mp->nccip)
		return -EINVAL;

Start --->
	skb = alloc_skb(CAPI_DATA_B3_REQ_LEN+count, GFP_USER);

	... DELETED 13 lines ...

		if (mp->nccip == 0) {
			kfree_skb(skb);
			return -EIO;
		}
		if (signal_pending(current))
Error --->
			return -ERESTARTNOHAND;
	}
	skb_queue_tail(&mp->outqueue, skb);
	mp->outbytes += skb->len;
---------------------------------------------------------
[BUG] security hole (not good for stat though)
/u2/engler/mc/oses/linux/2.4.17/drivers/telephony/ixj.c:5998:ixj_build_filter_cadence: ERROR:INVERSE:5987:5998:UNREVERSED 'lcp' on error path! set by 'kmalloc':5987 [nbytes=32] [rank=easy] [COUNTER=kmalloc:5987] [ERROR] [fit=29] [fit_fn=1] [fn_ex=1] [fn_counter=2] [ex=1] [counter=2] [z = -4.90076972114066] [fn-z = -4.90076972114066]
}

static int ixj_build_filter_cadence(IXJ *j, IXJ_FILTER_CADENCE * cp)
{
	IXJ_FILTER_CADENCE *lcp;
Start --->
	lcp = kmalloc(sizeof(IXJ_FILTER_CADENCE), GFP_KERNEL);
	if (lcp == NULL) {
		if(ixjdebug & 0x0001) {
			printk(KERN_INFO "Could not allocate memory for cadence\n");
		}
		return -ENOMEM;
        }
	if (copy_from_user(lcp, (char *) cp, sizeof(IXJ_FILTER_CADENCE))) {
		if(ixjdebug & 0x0001) {
			printk(KERN_INFO "Could not copy cadence to kernel\n");
		}
Error --->
		return -EFAULT;
	}
	if (lcp->filter > 5) {
		if(ixjdebug & 0x0001) {
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/telephony/ixj.c:6004:ixj_build_filter_cadence: ERROR:INVERSE:5987:6004:UNREVERSED 'lcp' on error path! set by 'kmalloc':5987 [nbytes=32] [rank=easy] [COUNTER=kmalloc:5987] [ERROR] [fit=29] [fit_fn=1] [fn_ex=1] [fn_counter=2] [ex=1] [counter=2] [z = -4.90076972114066] [fn-z = -4.90076972114066]
}

static int ixj_build_filter_cadence(IXJ *j, IXJ_FILTER_CADENCE * cp)
{
	IXJ_FILTER_CADENCE *lcp;
Start --->
	lcp = kmalloc(sizeof(IXJ_FILTER_CADENCE), GFP_KERNEL);

	... DELETED 11 lines ...

	}
	if (lcp->filter > 5) {
		if(ixjdebug & 0x0001) {
			printk(KERN_INFO "Cadence out of range\n");
		}
Error --->
		return -1;
	}
	j->cadence_f[lcp->filter].state = 0;
	j->cadence_f[lcp->filter].enable = lcp->enable;
---------------------------------------------------------
[BUG]  but should have been demoted.  good for stat [example above]
/u2/engler/mc/oses/linux/2.4.17/drivers/media/video/msp3400.c:1265:msp_attach: ERROR:INVERSE:1243:1265:UNREVERSED 'c' on error path! set by 'kmalloc':1243 [nbytes=60] [rank=easy] [COUNTER=kmalloc:1243] [ERROR] [fit=31] [fit_fn=1] [fn_ex=1] [fn_counter=2] [ex=1] [counter=2] [z = -4.90076972114066] [fn-z = -4.90076972114066]
        if (-1 == msp3400c_reset(&client_template)) {
                dprintk("msp3400: no chip found\n");
                return -1;
        }
	
Start --->
        if (NULL == (c = kmalloc(sizeof(struct i2c_client),GFP_KERNEL)))

	... DELETED 16 lines ...

	init_waitqueue_head(&msp->wq);

	if (-1 == msp3400c_reset(c)) {
		kfree(msp);
		dprintk("msp3400: no chip found\n");
Error --->
		return -1;
	}
    
	rev1 = msp3400c_read(c, I2C_MSP3400C_DFP, 0x1e);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/media/video/msp3400.c:1274:msp_attach: ERROR:INVERSE:1243:1274:UNREVERSED 'c' on error path! set by 'kmalloc':1243 [nbytes=60] [rank=easy] [COUNTER=kmalloc:1243] [ERROR] [fit=31] [fit_fn=1] [fn_ex=1] [fn_counter=2] [ex=1] [counter=2] [z = -4.90076972114066] [fn-z = -4.90076972114066]
        if (-1 == msp3400c_reset(&client_template)) {
                dprintk("msp3400: no chip found\n");
                return -1;
        }
	
Start --->
        if (NULL == (c = kmalloc(sizeof(struct i2c_client),GFP_KERNEL)))

	... DELETED 25 lines ...

	if (-1 != rev1)
		rev2 = msp3400c_read(c, I2C_MSP3400C_DFP, 0x1f);
	if ((-1 == rev1) || (0 == rev1 && 0 == rev2)) {
		kfree(msp);
		printk("msp3400: error while reading chip version\n");
Error --->
		return -1;
	}

#if 0
---------------------------------------------------------
[BUG] security hole; reasonable example for stat (final cleanup frees)
/u2/engler/mc/oses/linux/2.4.17/drivers/md/lvm.c:1529:lvm_do_vg_create: ERROR:INVERSE:1510:1529:UNREVERSED 'snap_lv_ptr' on error path! set by 'vmalloc':1510 [nbytes=4] [rank=easy] [COUNTER=vmalloc:1510] [ERROR] [fit=32] [fit_fn=1] [fn_ex=1] [fn_counter=4] [ex=1] [counter=4] [z = -7.69483764063865] [fn-z = -7.69483764063865]
			}
		}
	}

	size = vg_ptr->lv_max * sizeof(lv_t *);
Start --->
	if ((snap_lv_ptr = vmalloc ( size)) == NULL) {

	... DELETED 13 lines ...

		if ((lvp = vg_ptr->lv[l]) != NULL) {
			if (copy_from_user(&lv, lvp, sizeof(lv_t)) != 0) {
				P_IOCTL("ERROR: copying LV ptr %p (%d bytes)\n",
					lvp, sizeof(lv_t));
				lvm_do_vg_remove(minor);
Error --->
				return -EFAULT;
			}
			if ( lv.lv_access & LV_SNAPSHOT) {
				snap_lv_ptr[ls] = lvp;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/md/lvm.c:1541:lvm_do_vg_create: ERROR:INVERSE:1510:1541:UNREVERSED 'snap_lv_ptr' on error path! set by 'vmalloc':1510 [nbytes=4] [rank=easy] [COUNTER=vmalloc:1510] [ERROR] [fit=32] [fit_fn=1] [fn_ex=1] [fn_counter=4] [ex=1] [counter=4] [z = -7.69483764063865] [fn-z = -7.69483764063865]
			}
		}
	}

	size = vg_ptr->lv_max * sizeof(lv_t *);
Start --->
	if ((snap_lv_ptr = vmalloc ( size)) == NULL) {

	... DELETED 25 lines ...

			}
			vg_ptr->lv[l] = NULL;
			/* only create original logical volumes for now */
			if (lvm_do_lv_create(minor, lv.lv_name, &lv) != 0) {
				lvm_do_vg_remove(minor);
Error --->
				return -EFAULT;
			}
		}
	}
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/md/lvm.c:1552:lvm_do_vg_create: ERROR:INVERSE:1510:1552:UNREVERSED 'snap_lv_ptr' on error path! set by 'vmalloc':1510 [nbytes=4] [rank=easy] [COUNTER=vmalloc:1510] [ERROR] [fit=32] [fit_fn=1] [fn_ex=1] [fn_counter=4] [ex=1] [counter=4] [z = -7.69483764063865] [fn-z = -7.69483764063865]
			}
		}
	}

	size = vg_ptr->lv_max * sizeof(lv_t *);
Start --->
	if ((snap_lv_ptr = vmalloc ( size)) == NULL) {

	... DELETED 36 lines ...

	   in place during first path above */
	for (l = 0; l < ls; l++) {
		lv_t *lvp = snap_lv_ptr[l];
		if (copy_from_user(&lv, lvp, sizeof(lv_t)) != 0) {
			lvm_do_vg_remove(minor);
Error --->
			return -EFAULT;
		}
		if (lvm_do_lv_create(minor, lv.lv_name, &lv) != 0) {
			lvm_do_vg_remove(minor);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/md/lvm.c:1556:lvm_do_vg_create: ERROR:INVERSE:1510:1556:UNREVERSED 'snap_lv_ptr' on error path! set by 'vmalloc':1510 [nbytes=4] [rank=easy] [COUNTER=vmalloc:1510] [ERROR] [fit=32] [fit_fn=1] [fn_ex=1] [fn_counter=4] [ex=1] [counter=4] [z = -7.69483764063865] [fn-z = -7.69483764063865]
			}
		}
	}

	size = vg_ptr->lv_max * sizeof(lv_t *);
Start --->
	if ((snap_lv_ptr = vmalloc ( size)) == NULL) {

	... DELETED 40 lines ...

			lvm_do_vg_remove(minor);
			return -EFAULT;
		}
		if (lvm_do_lv_create(minor, lv.lv_name, &lv) != 0) {
			lvm_do_vg_remove(minor);
Error --->
			return -EFAULT;
		}
	}


