Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262288AbREXVIC>; Thu, 24 May 2001 17:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262296AbREXVHx>; Thu, 24 May 2001 17:07:53 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:3293 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S262288AbREXVHk>;
	Thu, 24 May 2001 17:07:40 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200105242107.OAA29730@csl.Stanford.EDU>
Subject: [CHECKER] error path memory leaks in 2.4.4 and 2.4.4-ac8
To: linux-kernel@vger.kernel.org
Date: Thu, 24 May 2001 14:07:35 -0700 (PDT)
Cc: mc@cs.Stanford.EDU
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This checker warns when you do not free allocated memory on failure paths.
The error messages with "type=SECURITY" were emitted when the error path
was triggered by a failed copy_*_user or eqvuivalent --- bad people can
easily use these to make the kernel lose memory.

	Summary for 
		2.4.4ac8-specific errors       	= 5
		2.4.4-specific errors 		= 1
		Common errors 		        = 17
		Total 			  	= 23

Note: this is a very small subset of these errors --- I was a bit lazy
about inspecting these logs.

Dawson

# BUGs	|	File Name
4	|	drivers/scsi/scsi_ioctl.c
3	|	fs/freevxfs/vxfs_super.c
2	|	drivers/telephony/ixj.c
1	|	drivers/net/wan/lmc/lmc_main.c
1	|	drivers/acpi/driver.c
1	|	drivers/scsi/aic7xxx/aic7xxx_linux_pci.c
1	|	net/irda/irlan/irlan_common.c
1	|	drivers/isdn/isdn_ppp.c
1	|	fs/jffs/jffs_fm.c
1	|	drivers/mtd/mtdchar.c
1	|	drivers/block/cciss.c
1	|	net/wanrouter/wanproc.c
1	|	drivers/isdn/avmb1/capi.c
1	|	net/wanrouter/wanmain.c
1	|	fs/cmsfs/cmsfsvfs.c
1	|	drivers/net/pcmcia/aironet4500_cs.c
1	|	drivers/media/video/zr36120.c

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

	- bugs are sorted roughly by severity and ease-of-diagnosis.
	  The highest ranked bugs are "SECURITY" which (in most of the
	  examples) are primarily denial-of-service vulnerabilities
	  where the user could trigger the bug when they canted to.
	  Ease-of-diagnosis is currently crude: we rank LOCAL errors
	  over GLOBAL (GLOBAL require looking at call chains) and then
	  distance between error source and manifestation as the next
	  (closer is better)

	- these errors are a subset of the ones we found --- we typically
	  did not inspect many of the global errors, since there were so
	  many local ones.  If you'd like to see uninspected files, let
	  me know.


############################################################
# 2.4.4ac8 specific errors
#
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/block/cciss.c:613:cciss_ioctl: ERROR:INVERSE:605:613: UNREVERSED 'buff' on error path! set by 'kmalloc':605 [nbytes=1] [rank=easy] [type=SECURITY]
		/* Check kmalloc limits */
		if(iocommand.buf_size > 128000)
			return -EINVAL;
		if(iocommand.buf_size > 0)
		{
Start --->
			buff =  kmalloc(iocommand.buf_size, GFP_KERNEL);
			if( buff == NULL) 
				return -EFAULT;
		}
		if (iocommand.Request.Type.Direction == XFER_WRITE)
		{
			/* Copy the data into the buffer we created */ 
			if (copy_from_user(buff, iocommand.buf, iocommand.buf_size))
Error --->
				return -EFAULT;
		}
		if ((c = cmd_alloc(h , 0)) == NULL)
		{
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/freevxfs/vxfs_super.c:171:vxfs_read_super: ERROR:INVERSE:159:171: UNREVERSED 'infp' on error path! set by 'kmalloc':159 [nbytes=36] [rank=easy]
	struct vxfs_sb		*rsbp;
	struct buffer_head	*bp;
	u_long			bsize;
	kdev_t			dev = sbp->s_dev;

Start --->
	infp = kmalloc(sizeof(struct vxfs_sb_info), GFP_KERNEL);
	if (!infp) {
		printk(KERN_WARNING "vxfs: unable to allocate incore superblock\n");
		return NULL;
	}
	memset(infp, 0, sizeof(struct vxfs_sb_info));

	bsize = vxfs_validate_bsize(dev);

	bp = bread(dev, 1, bsize);
	if (!bp) {
		printk(KERN_WARNING "vxfs: unable to read disk superblock\n");
Error --->
		return NULL;
	}

	rsbp = (struct vxfs_sb *)bp->b_data;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/freevxfs/vxfs_super.c:177:vxfs_read_super: ERROR:INVERSE:159:177: UNREVERSED 'infp' on error path! set by 'kmalloc':159 [nbytes=36] [rank=easy]
	struct vxfs_sb		*rsbp;
	struct buffer_head	*bp;
	u_long			bsize;
	kdev_t			dev = sbp->s_dev;

Start --->
	infp = kmalloc(sizeof(struct vxfs_sb_info), GFP_KERNEL);

	... DELETED 12 lines ...

	}

	rsbp = (struct vxfs_sb *)bp->b_data;
	if (rsbp->vs_magic != VXFS_SUPER_MAGIC) {
		printk(KERN_NOTICE "vxfs: WRONG superblock magic\n");
Error --->
		return NULL;
	}

	if (rsbp->vs_version < 2 || rsbp->vs_version > 4) {
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/freevxfs/vxfs_super.c:182:vxfs_read_super: ERROR:INVERSE:159:182: UNREVERSED 'infp' on error path! set by 'kmalloc':159 [nbytes=36] [rank=easy]
	struct vxfs_sb		*rsbp;
	struct buffer_head	*bp;
	u_long			bsize;
	kdev_t			dev = sbp->s_dev;

Start --->
	infp = kmalloc(sizeof(struct vxfs_sb_info), GFP_KERNEL);

	... DELETED 17 lines ...

		return NULL;
	}

	if (rsbp->vs_version < 2 || rsbp->vs_version > 4) {
		printk(KERN_NOTICE "vxfs: unsupported VxFS version (%d)\n", rsbp->vs_version);
Error --->
		return NULL;
	}

#ifdef DIAGNOSTIC
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/cmsfs/cmsfsvfs.c:729:cmsfs_lookup: ERROR:INVERSE:665:729: UNREVERSED 'cmsinode' on error path! set by 'kmalloc':665 [nbytes=124] [rank=easy]
		BUG();
	if (di->cmssuper->cmsrooti == NULL)
		BUG();

	/*  gimme another CMS inode structure  */
Start --->
	cmsinode = kmalloc(sizeof(struct cms_inode), GFP_KERNEL);

	... DELETED 58 lines ...


	buff = (void *)get_free_page(GFP_KERNEL);
	if(buff == NULL)
	{
		printk(KERN_WARNING "cmsfs_lookup: out of memory.\n");
Error --->
		return NULL;
	}
			
	/*  find the file  */


############################################################
# 2.4.4 specific errors

#
---------------------------------------------------------
[UNINSPECTED] Count mismatch:
# capi.c:capinc_raw_write:INVERSE:UNREVERSED 'skb' on error path! set by 'alloc_skb'
1 occurrence(s) in inspected file.
2 occurrence(s) in run file.
>>>>>>>>
# [BUG]
<<<<<<<<
/u2/engler/mc/oses/linux/2.4.4/drivers/isdn/avmb1/capi.c:1437:capinc_raw_write: ERROR:INVERSE:1425:1437: UNREVERSED 'skb' on error path! set by 'alloc_skb':1425 [nbytes=168] [rank=hard]
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
		return retval;
	}

	while (skb_queue_len(&mp->outqueue) > CAPINC_MAX_SENDQUEUE) {
		if (file->f_flags & O_NONBLOCK)
Error --->
			return -EAGAIN;
		interruptible_sleep_on(&mp->sendwait);
		if (mp->nccip == 0) {
			kfree_skb(skb);


############################################################
# errors common to both

#
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/telephony/ixj.c:4482:ixj_build_filter_cadence: ERROR:INVERSE:4478:4482: UNREVERSED 'lcp' on error path! set by 'kmalloc':4478 [nbytes=32] [rank=easy] [type=SECURITY]

static int ixj_build_filter_cadence(IXJ *j, IXJ_FILTER_CADENCE * cp)
{
	IXJ_FILTER_CADENCE *lcp;

Start --->
	lcp = kmalloc(sizeof(IXJ_FILTER_CADENCE), GFP_KERNEL);
	if (lcp == NULL)
		return -ENOMEM;
	if (copy_from_user(lcp, (char *) cp, sizeof(IXJ_FILTER_CADENCE)))
Error --->
		return -EFAULT;
	if (lcp->filter >= 4)
		return -1;
	j->cadence_f[lcp->filter].state = 0;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/media/video/zr36120.c:1202:zoran_ioctl: ERROR:INVERSE:1198:1202: UNREVERSED 'vcp' on error path! set by 'vmalloc':1198 [nbytes=20] [rank=easy] [type=SECURITY]
			return -EDOM;   /* Too many! */

		/*
		 *      Do any clips.
		 */
Start --->
		vcp = vmalloc(sizeof(struct video_clip)*(vw.clipcount+4));
		if (vcp==NULL)
			return -ENOMEM;
		if (vw.clipcount && copy_from_user(vcp,vw.clips,sizeof(struct video_clip)*vw.clipcount))
Error --->
			return -EFAULT;

		on = ztv->running;
		if (on)
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/mtd/mtdchar.c:314:mtd_ioctl: ERROR:INVERSE:309:314: UNREVERSED 'databuf' on error path! set by 'kmalloc':309 [nbytes=0] [rank=easy] [type=SECURITY]
			ret = verify_area(VERIFY_READ, (char *)buf.ptr, buf.length);

		if (ret)
			return ret;

Start --->
		databuf = kmalloc(buf.length, GFP_KERNEL);
		if (!databuf)
			return -ENOMEM;
		
		if (copy_from_user(databuf, buf.ptr, buf.length))
Error --->
			return -EFAULT;

		ret = (mtd->write_oob)(mtd, buf.start, buf.length, &retlen, databuf);

---------------------------------------------------------
[BUG] hidden in macro.
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/wan/lmc/lmc_main.c:510:lmc_ioctl: ERROR:INVERSE:503:510: UNREVERSED 'data' on error path! set by 'kmalloc':503 [nbytes=1] [rank=easy] [type=SECURITY]
                    if(xc.data == 0x0){
                            ret = -EINVAL;
                            break;
                    }

Start --->
                    data = kmalloc(xc.len, GFP_KERNEL);
                    if(data == 0x0){
                            printk(KERN_WARNING "%s: Failed to allocate memory for copy\n", dev->name);
                            ret = -ENOMEM;
                            break;
                    }
                    
Error --->
                    LMC_COPY_FROM_USER(data, xc.data, xc.len);

                    printk("%s: Starting load of data Len: %d at 0x%p == 0x%p\n", dev->name, xc.len, xc.data, data);

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/scsi_ioctl.c:259:scsi_ioctl_send_command: ERROR:INVERSE:233:259: UNREVERSED 'buf' on error path! set by 'scsi_malloc':233 [nbytes=1] [rank=easy] [type=SECURITY]
	needed = buf_needed = (inlen > outlen ? inlen : outlen);
	if (buf_needed) {
		buf_needed = (buf_needed + 511) & ~511;
		if (buf_needed > MAX_BUF)
			buf_needed = MAX_BUF;
Start --->
		buf = (char *) scsi_malloc(buf_needed);

	... DELETED 20 lines ...

	 * Obtain the command from the user's address space.
	 */
	cmdlen = COMMAND_SIZE(opcode);

	if (verify_area(VERIFY_READ, cmd_in, cmdlen + inlen))
Error --->
		return -EFAULT;

	__copy_from_user(cmd, cmd_in, cmdlen);

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/acpi/driver.c:190:acpi_do_table: ERROR:INVERSE:172:190: UNREVERSED 'pointer' on error path! set by 'kmalloc':172 [nbytes=0] [rank=med] [type=SECURITY]
	if (acpi_get_table(table_type, 1, &buf) != AE_BUFFER_OVERFLOW) {
		*len = 0;
		return 0;
	}

Start --->
	buf.pointer = kmalloc(buf.length, GFP_KERNEL);

	... DELETED 12 lines ...

		data = buf.pointer + file->f_pos;
		size = buf.length - file->f_pos;
		if (size > *len)
			size = *len;
		if (copy_to_user(buffer, data, size))
Error --->
			return -EFAULT;
	}

	kfree(buf.pointer);
---------------------------------------------------------
[BUG] security hole
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/isdn/isdn_ppp.c:788:isdn_ppp_write: ERROR:INVERSE:781:788: UNREVERSED 'skb' on error path! set by 'alloc_skb':781 [nbytes=168] [rank=hard] [type=SECURITY]
			 * we need to reserve enought space in front of
			 * sk_buff. old call to dev_alloc_skb only reserved
			 * 16 bytes, now we are looking what the driver want
			 */
			hl = dev->drv[lp->isdn_device]->interface->hl_hdrlen;
Start --->
			skb = alloc_skb(hl+count, GFP_ATOMIC);
			if (!skb) {
				printk(KERN_WARNING "isdn_ppp_write: out of memory!\n");
				return count;
			}
			skb_reserve(skb, hl);
			if (copy_from_user(skb_put(skb, count), buf, count))
Error --->
				return -EFAULT;
			if (is->debug & 0x40) {
				printk(KERN_DEBUG "ppp xmit: len %d\n", (int) skb->len);
				isdn_ppp_frame_log("xmit", skb->data, skb->len, 32,is->unit,lp->ppp_slot);
---------------------------------------------------------
[BUG] frees it below.
/u2/engler/mc/oses/linux/2.4.4-ac8/net/wanrouter/wanproc.c:271:router_proc_read: ERROR:INVERSE:262:271: UNREVERSED 'page' on error path! set by 'kmalloc':262 [nbytes=1] [rank=hard] [type=SECURITY]
			
		dent = inode->u.generic_ip;
		if ((dent == NULL) || (dent->get_info == NULL))
			return 0;
			
Start --->
		page = kmalloc(PROC_BUFSZ, GFP_KERNEL);
		if (page == NULL)
			return -ENOBUFS;
			
		pos = dent->get_info(page, dent->data, 0, 0);
		offs = file->f_pos;
		if (offs < pos) {
			len = min(pos - offs, count);
			if(copy_to_user(buf, (page + offs), len))
Error --->
				return -EFAULT;
			file->f_pos += len;
		}
		else
---------------------------------------------------------
[BUG]  looks like they are supposed to release the request.
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/scsi_ioctl.c:324:scsi_ioctl_send_command: ERROR:INVERSE:304:324: UNREVERSED 'SRpnt' on error path! set by 'scsi_allocate_request':304 [nbytes=216] [rank=hard] [type=SECURITY]
	}

#ifndef DEBUG_NO_CMD


Start --->
	SRpnt = scsi_allocate_request(dev);

	... DELETED 14 lines ...

		sb_len = (sb_len > OMAX_SB_LEN) ? OMAX_SB_LEN : sb_len;
		if (copy_to_user(cmd_in, SRpnt->sr_sense_buffer, sb_len))
			return -EFAULT;
	} else
		if (copy_to_user(cmd_in, buf, outlen))
Error --->
			return -EFAULT;

	result = SRpnt->sr_result;

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/scsi_ioctl.c:321:scsi_ioctl_send_command: ERROR:INVERSE:233:321: UNREVERSED 'buf' on error path! set by 'scsi_malloc':233 [nbytes=1] [rank=hard] [type=SECURITY]
	needed = buf_needed = (inlen > outlen ? inlen : outlen);
	if (buf_needed) {
		buf_needed = (buf_needed + 511) & ~511;
		if (buf_needed > MAX_BUF)
			buf_needed = MAX_BUF;
Start --->
		buf = (char *) scsi_malloc(buf_needed);

	... DELETED 82 lines ...

	if (SRpnt->sr_result) {
		int sb_len = sizeof(SRpnt->sr_sense_buffer);

		sb_len = (sb_len > OMAX_SB_LEN) ? OMAX_SB_LEN : sb_len;
		if (copy_to_user(cmd_in, SRpnt->sr_sense_buffer, sb_len))
Error --->
			return -EFAULT;
	} else
		if (copy_to_user(cmd_in, buf, outlen))
			return -EFAULT;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/net/irda/irlan/irlan_common.c:227:irlan_open: ERROR:INVERSE:216:227: UNREVERSED 'self' on error path! set by 'kmalloc':216 [nbytes=976] [rank=easy]
	IRDA_DEBUG(2, __FUNCTION__ "()\n");

	/* 
	 *  Initialize the irlan structure. 
	 */
Start --->
	self = kmalloc(sizeof(struct irlan_cb), GFP_ATOMIC);
	if (self == NULL)
		return NULL;
	
	memset(self, 0, sizeof(struct irlan_cb));

	/*
	 *  Initialize local device structure
	 */
	self->magic = IRLAN_MAGIC;

Error --->
	ASSERT(irlan != NULL, return NULL;);
	
	sprintf(self->dev.name, "%s", "unknown");

---------------------------------------------------------
[BUG] security hole
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/telephony/ixj.c:4484:ixj_build_filter_cadence: ERROR:INVERSE:4478:4484: UNREVERSED 'lcp' on error path! set by 'kmalloc':4478 [nbytes=32] [rank=easy]

static int ixj_build_filter_cadence(IXJ *j, IXJ_FILTER_CADENCE * cp)
{
	IXJ_FILTER_CADENCE *lcp;

Start --->
	lcp = kmalloc(sizeof(IXJ_FILTER_CADENCE), GFP_KERNEL);
	if (lcp == NULL)
		return -ENOMEM;
	if (copy_from_user(lcp, (char *) cp, sizeof(IXJ_FILTER_CADENCE)))
		return -EFAULT;
	if (lcp->filter >= 4)
Error --->
		return -1;
	j->cadence_f[lcp->filter].state = 0;
	j->cadence_f[lcp->filter].enable = lcp->enable;
	j->filter_en[lcp->filter] = j->cadence_f[lcp->filter].en_filter = lcp->en_filter;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/aic7xxx/aic7xxx_linux_pci.c:118:ahc_linux_pci_dev_probe: ERROR:INVERSE:112:118: UNREVERSED 'name' on error path! set by 'kmalloc':112 [nbytes=1] [rank=easy]
	 */
	sprintf(buf, "ahc_pci:%d:%d:%d",
		ahc_get_pci_bus(pci),
		ahc_get_pci_slot(pci),
		ahc_get_pci_function(pci));
Start --->
	name = malloc(strlen(buf) + 1, M_DEVBUF, M_NOWAIT);
	if (name == NULL)
		return (-ENOMEM);
	strcpy(name, buf);
	ahc = ahc_alloc(NULL, name);
	if (ahc == NULL)
Error --->
		return (-ENOMEM);
#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
	if (pci_enable_device(pdev)) {
		ahc_free(ahc);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/net/wanrouter/wanmain.c:803:device_new_if: ERROR:INVERSE:794:803: UNREVERSED 'pppdev' on error path! set by 'kmalloc':794 [nbytes=84] [rank=easy]

	
#ifdef CONFIG_WANPIPE_MULTPPP
	if (conf.config_id == WANCONFIG_MPPP){

Start --->
		pppdev = kmalloc(sizeof(struct ppp_device), GFP_KERNEL);
		if (pppdev == NULL){
			return -ENOBUFS;
		}
		memset(pppdev, 0, sizeof(struct ppp_device));

	      #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,16)
		pppdev->dev = kmalloc(sizeof(netdevice_t), GFP_KERNEL);
		if (pppdev->dev == NULL){
Error --->
			return -ENOBUFS;
		}
		memset(pppdev->dev, 0, sizeof(netdevice_t));
	      #endif
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/jffs/jffs_fm.c:50:jffs_build_begin: ERROR:INVERSE:39:50: UNREVERSED 'fmc' on error path! set by 'kmalloc':39 [nbytes=76] [rank=easy]
	struct jffs_fmcontrol *fmc;
	struct mtd_info *mtd;
	
	D3(printk("jffs_build_begin()\n"));
	fmc = (struct jffs_fmcontrol *)kmalloc(sizeof(struct jffs_fmcontrol),
Start --->
					       GFP_KERNEL);
	if (!fmc) {
		D(printk("jffs_build_begin(): Allocation of "
			 "struct jffs_fmcontrol failed!\n"));
		return (struct jffs_fmcontrol *)0;
	}
	DJM(no_jffs_fmcontrol++);

	mtd = get_mtd_device(NULL, MINOR(dev));

	if (!mtd)
Error --->
		return NULL;
	
	/* Retrieve the size of the flash memory.  */
	fmc->flash_start = 0;
---------------------------------------------------------
[BUG]  they free it at exit point.
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/scsi_ioctl.c:307:scsi_ioctl_send_command: ERROR:INVERSE:233:307: UNREVERSED 'buf' on error path! set by 'scsi_malloc':233 [nbytes=1] [rank=easy]
	needed = buf_needed = (inlen > outlen ? inlen : outlen);
	if (buf_needed) {
		buf_needed = (buf_needed + 511) & ~511;
		if (buf_needed > MAX_BUF)
			buf_needed = MAX_BUF;
Start --->
		buf = (char *) scsi_malloc(buf_needed);

	... DELETED 68 lines ...



	SRpnt = scsi_allocate_request(dev);
        if( SRpnt == NULL )
        {
Error --->
                return -EINTR;
        }

	SRpnt->sr_data_direction = data_direction;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/pcmcia/aironet4500_cs.c:265:awc_attach: ERROR:INVERSE:209:265: UNREVERSED 'dev' on error path! set by 'kmalloc':209 [nbytes=376] [rank=med]
	link->conf.ConfigIndex = 1;
	link->conf.Present = PRESENT_OPTION;

	/* Create the network device object. */

Start --->
	dev = kmalloc(sizeof(struct net_device ), GFP_KERNEL);

	... DELETED 50 lines ...

	client_reg.event_callback_args.client_data = link;
	ret = CardServices(RegisterClient, &link->handle, &client_reg);
	if (ret != 0) {
		cs_error(link->handle, RegisterClient, ret);
		awc_detach(link);
Error --->
		return NULL;
	}

	return link;

