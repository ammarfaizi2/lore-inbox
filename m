Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263425AbUDPREp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 13:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263442AbUDPREp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 13:04:45 -0400
Received: from coverity.dreamhost.com ([66.33.192.105]:42710 "EHLO
	coverity.dreamhost.com") by vger.kernel.org with ESMTP
	id S263425AbUDPREV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 13:04:21 -0400
Subject: [CHECKER] Probable security holes in 2.6.5
From: Ken Ashcraft <ken@coverity.com>
To: linux-kernel@vger.kernel.org
Cc: mc@cs.stanford.edu
Content-Type: text/plain
Message-Id: <1082134916.19301.7.camel@dns.coverity.int>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 16 Apr 2004 10:01:57 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working at a company called Coverity where we are building an
industrial strength derivative of the MC Checker system created at Stanford. 
I've written a static analysis checker that looks for places where the
kernel gets a scalar from the user and then uses it without performing
bounds checks. For example, if a driver copies in an integer from the
user and then uses that integer as an array index or the length argument
to memcpy, the user can cause a buffer overflow.

The error reports below are sorted roughly by their severity.  The last
12 of the errors are fairly minor because they are either protected by a
capable() check or the scalar is only 8 bits.  I also consider it to be
a minor error to pass an unchecked value to kmalloc().  I realize that
kmalloc() will fail when asked for more than 128k, but it may not be
appropriate to allow the user to allocate that much memory.  All of
these minor errors will be marked by [MINOR] and/or [CAPABLE] tags in
the error report.

I'd appreciate your feedback so that I can improve the checker.

thanks,
Ken Ashcraft

#  Total 				  = 22
# BUGs	|	File Name
3	|	/drivers/message/fusion/mptctl.c
2	|	/net/bridge/netfilter/ebtables.c
2	|	/drivers/ide/ide-taskfile.c
2	|	/drivers/block/DAC960.c
1	|	/net/ipv4/netfilter/ip_tables.c
1	|	/drivers/scsi/3w-xxxx.c
1	|	/drivers/net/wan/sdla.c
1	|	/drivers/net/wan/lmc/lmc_main.c
1	|	/drivers/net/e1000/e1000_ethtool.c
1	|	/drivers/scsi/aacraid/commctrl.c
1	|	/drivers/md/dm-ioctl.c
1	|	/drivers/char/drm/i810_dma.c
1	|	/drivers/scsi/gdth.c
1	|	/kernel/module.c
1	|	/net/ipv4/netfilter/arp_tables.c
1	|	/drivers/char/applicom.c
1	|	/net/ipv6/netfilter/ip6_tables.c


---------------------------------------------------------
[BUG]
/home/kash/linux/linux-2.6.5/drivers/net/e1000/e1000_ethtool.c:1494:e1000_ethtool_ioctl: ERROR:TAINT: 1487:1494:Passing unbounded user value "(regs).len" as arg 2 to function "copy_to_user", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(lib,copy_to_user,user,trustingsink)]    [PATH=] 
	}
	case ETHTOOL_GREGS: {
		struct ethtool_regs regs = {ETHTOOL_GREGS};
		uint32_t regs_buff[E1000_REGS_LEN];

Start --->
		if(copy_from_user(&regs, addr, sizeof(regs)))
			return -EFAULT;
		e1000_ethtool_gregs(adapter, &regs, regs_buff);
		if(copy_to_user(addr, &regs, sizeof(regs)))
			return -EFAULT;

		addr += offsetof(struct ethtool_regs, data);
Error --->
		if(copy_to_user(addr, regs_buff, regs.len))
			return -EFAULT;

		return 0;
---------------------------------------------------------
[BUG] 
/home/kash/linux/linux-2.6.5/drivers/scsi/gdth.c:5068:ioc_general:
ERROR:TAINT: 5059:5068:Passing unbounded user value "((gen).data_len +
(gen).sense_len)" as arg 2 to function "copy_from_user", which uses it
unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)]
[SINK_MODEL=(lib,copy_from_user,user,trustingsink)]    [PATH=
"((gen).data_len + (gen).sense_len) != 0" on line 5064 is false =>
"(gen).ionode >= gdth_ctr_count" on line 5059 is false =>
"copy_from_user != 0" on line 5059 is false] 
#else
	Scsi_Cmnd scp;
	Scsi_Device sdev;
#endif
        
Start --->
        if (copy_from_user(&gen, (char *)arg,
sizeof(gdth_ioctl_general)) ||
            gen.ionode >= gdth_ctr_count)
            return -EFAULT;
        hanum = gen.ionode; 
        ha = HADATA(gdth_ctr_tab[hanum]);
        if (gen.data_len + gen.sense_len != 0) {
            if (!(buf = gdth_ioctl_alloc(hanum, gen.data_len +
gen.sense_len, 
                                         FALSE, &paddr)))
                return -EFAULT;
Error --->
            if (copy_from_user(buf, (char *)arg +
sizeof(gdth_ioctl_general),  
                               gen.data_len + gen.sense_len)) {
                gdth_ioctl_free(hanum, gen.data_len+gen.sense_len, buf,
paddr);
                return -EFAULT;
---------------------------------------------------------
[BUG]
/home/kash/linux/linux-2.6.5/drivers/char/drm/i810_dma.c:1276:i810_dma_mc: ERROR:TAINT: 1267:1276:Using user value "((mc).idx * 4)" without first performing bounds checks [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [PATH= "(*((*dev).lock).hw_lock).lock & -2147483648 == 0" on line 1271 is false => "copy_from_user != 0" on line 1267 is false]    
	u32 *hw_status = dev_priv->hw_status_page;
	drm_i810_sarea_t *sarea_priv = (drm_i810_sarea_t *)
		dev_priv->sarea_priv;
	drm_i810_mc_t mc;

Start --->
	if (copy_from_user(&mc, (drm_i810_mc_t *)arg, sizeof(mc)))
		return -EFAULT;


	if (!_DRM_LOCK_IS_HELD(dev->lock.hw_lock->lock)) {
		DRM_ERROR("i810_dma_mc called without lock held\n");
		return -EINVAL;
	}

Error --->
	i810_dma_dispatch_mc(dev, dma->buflist[mc.idx], mc.used,
		mc.last_render );

	atomic_add(mc.used, &dev->counts[_DRM_STAT_SECONDARY]);
---------------------------------------------------------
[BUG] overflow in SMP_ALIGN?
/home/kash/linux/linux-2.6.5/net/ipv6/netfilter/ip6_tables.c:1156:do_replace: ERROR:TAINT: 1144:1156:Passing unbounded user value "(tmp).size" as arg 2 to function "copy_from_user", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(lib,copy_from_user,user,trustingsink)]    [PATH=] 
	struct ip6t_replace tmp;
	struct ip6t_table *t;
	struct ip6t_table_info *newinfo, *oldinfo;
	struct ip6t_counters *counters;

Start --->
	if (copy_from_user(&tmp, user, sizeof(tmp)) != 0)
		return -EFAULT;

	/* Pedantry: prevent them from hitting BUG() in vmalloc.c --RR */
	if ((SMP_ALIGN(tmp.size) >> PAGE_SHIFT) + 2 > num_physpages)
		return -ENOMEM;

	newinfo = vmalloc(sizeof(struct ip6t_table_info)
			  + SMP_ALIGN(tmp.size) * NR_CPUS);
	if (!newinfo)
		return -ENOMEM;

Error --->
	if (copy_from_user(newinfo->entries, user + sizeof(tmp),
			   tmp.size) != 0) {
		ret = -EFAULT;
		goto free_newinfo;
---------------------------------------------------------
[BUG] overflow in SMP_ALIGN?
/home/kash/linux/linux-2.6.5/net/ipv4/netfilter/arp_tables.c:891:do_replace: ERROR:TAINT: 875:891:Passing unbounded user value "(tmp).size" as arg 2 to function "copy_from_user", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(lib,copy_from_user,user,trustingsink)]    [PATH=] 
	struct arpt_replace tmp;
	struct arpt_table *t;
	struct arpt_table_info *newinfo, *oldinfo;
	struct arpt_counters *counters;

Start --->
	if (copy_from_user(&tmp, user, sizeof(tmp)) != 0)

	... DELETED 10 lines ...

	newinfo = vmalloc(sizeof(struct arpt_table_info)
			  + SMP_ALIGN(tmp.size) * NR_CPUS);
	if (!newinfo)
		return -ENOMEM;

Error --->
	if (copy_from_user(newinfo->entries, user + sizeof(tmp),
			   tmp.size) != 0) {
		ret = -EFAULT;
		goto free_newinfo;
---------------------------------------------------------
[BUG] overflow in SMP_ALIGN?
/home/kash/linux/linux-2.6.5/net/ipv4/netfilter/ip_tables.c:1074:do_replace: ERROR:TAINT: 1058:1074:Passing unbounded user value "(tmp).size" as arg 2 to function "copy_from_user", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(lib,copy_from_user,user,trustingsink)]    [PATH=] 
	struct ipt_replace tmp;
	struct ipt_table *t;
	struct ipt_table_info *newinfo, *oldinfo;
	struct ipt_counters *counters;

Start --->
	if (copy_from_user(&tmp, user, sizeof(tmp)) != 0)

	... DELETED 10 lines ...

	newinfo = vmalloc(sizeof(struct ipt_table_info)
			  + SMP_ALIGN(tmp.size) * NR_CPUS);
	if (!newinfo)
		return -ENOMEM;

Error --->
	if (copy_from_user(newinfo->entries, user + sizeof(tmp),
			   tmp.size) != 0) {
		ret = -EFAULT;
		goto free_newinfo;
---------------------------------------------------------
[BUG]
/home/kash/linux/linux-2.6.5/kernel/module.c:1303:load_module:
ERROR:TAINT: 1283:1303:Using user value "((*hdr).e_shstrndx * 0)"
without first performing bounds checks
[SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [PATH=]    

	/* Suck in entire file: we'll want most of it. */
	/* vmalloc barfs on "unusual" numbers.  Check here */
	if (len > 64 * 1024 * 1024 || (hdr = vmalloc(len)) == NULL)
		return ERR_PTR(-ENOMEM);
Start --->
	if (copy_from_user(hdr, umod, len) != 0) {

	... DELETED 14 lines ...

	if (len < hdr->e_shoff + hdr->e_shnum * sizeof(Elf_Shdr))
		goto truncated;

	/* Convenience variables */
	sechdrs = (void *)hdr + hdr->e_shoff;
Error --->
	secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
	sechdrs[0].sh_addr = 0;

	/* And these should exist, but gcc whinges if we don't init them */
---------------------------------------------------------
[BUG] signed int and unchecked
/home/kash/linux/linux-2.6.5/drivers/message/fusion/mptctl.c:1313:mptctl_getiocinfo: ERROR:TAINT: 1229:1313:Using user value "port" without first performing bounds checks [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [PATH=]    
	else if (data_size == (sizeof(struct mpt_ioctl_iocinfo_rev0)+12))
		cim_rev = 0;	/* obsolete */
	else
		return -EFAULT;

Start --->
	if (copy_from_user(&karg, uarg, data_size)) {

	... DELETED 78 lines ...

	 */
	strncpy (karg.driverVersion, MPT_LINUX_PACKAGE_NAME,
MPT_IOCTL_VERSION_LENGTH);
	karg.driverVersion[MPT_IOCTL_VERSION_LENGTH-1]='\0';

	karg.busChangeEvent = 0;
Error --->
	karg.hostId = ioc->pfacts[port].PortSCSIID;
	karg.rsvd[0] = karg.rsvd[1] = 0;

	/* Copy the data from kernel memory to user memory
---------------------------------------------------------
[BUG] probably
/home/kash/linux/linux-2.6.5/drivers/message/fusion/mptctl.c:2704:mptctl_hp_targetinfo: ERROR:TAINT: 2597:2704:Using user value "((karg).hdr).id" without first performing bounds checks [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [PATH= "pg0_alloc != 0" on line 2626 is false => "(*(*ioc).sh).host_no != ((karg).hdr).host" on line 2619 is false => "(*ioc).sh == 0" on line 2616 is false => "((*ioc).spi_data).sdp0length == 0" on line 2616 is false => "(*ioc).chip_type <= 2345" on line 2613 is false => "ioc == 0" on line 2604 is false => "iocnum = mpt_verify_adapter < 0" on line 2604 is false => "copy_from_user != 0" on line 2597 is false]    
	CONFIGPARMS	 	cfg;
	ConfigPageHeader_t	hdr;
	int			tmp, np, rc = 0;

	dctlprintk((": mptctl_hp_targetinfo called.\n"));
Start --->
	if (copy_from_user(&karg, uarg, sizeof(hp_target_info_t))) {

	... DELETED 101 lines ...

			pci_free_consistent(ioc->pcidev, data_sz, (u8 *) pg3_alloc,
page_dma);
		}
	}
	hd = (MPT_SCSI_HOST *) ioc->sh->hostdata;
	if (hd != NULL)
Error --->
		karg.select_timeouts = hd->sel_timeout[karg.hdr.id];

	/* Copy the data from kernel memory to user memory
	 */
---------------------------------------------------------
[BUG]
/home/kash/linux/linux-2.6.5/drivers/scsi/3w-xxxx.c:780:tw_chrdev_ioctl:
ERROR:TAINT: 673:780:Passing unbounded user value "((1025 +
(*tw_ioctl).data_buffer_length) - 1)" as arg 2 to function
"copy_to_user", which uses it unsafely in model
[SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)]
[SINK_MODEL=(lib,copy_to_user,user,trustingsink)]    [PATH= "error != 0"
on line 674 is false] 
	}

	tw_ioctl = (TW_New_Ioctl *)cpu_addr;

	/* Now copy down the entire ioctl */
Start --->
	error = copy_from_user(tw_ioctl, (void *)arg, data_buffer_length +
sizeof(TW_New_Ioctl) - 1);

	... DELETED 101 lines ...

			retval = -ENOTTY;
			goto out2;
	}

	/* Now copy the response to userspace */
Error --->
	error = copy_to_user((void *)arg, tw_ioctl, sizeof(TW_New_Ioctl) +
tw_ioctl->data_buffer_length - 1);
	if (error == 0)
		retval = 0;
out2:
---------------------------------------------------------
[BUG] minor
/home/kash/linux/linux-2.6.5/drivers/net/wan/sdla.c:1206:sdla_xfer:
ERROR:TAINT: 1201:1206:Passing unbounded user value "(mem).len" as arg 0
to function "kmalloc", which uses it unsafely in model
[SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)]
[SINK_MODEL=(lib,kmalloc,user,trustingsink)]  [MINOR]  [PATH=] [Also
used at, line 1219 in argument 0 to function "kmalloc"]
static int sdla_xfer(struct net_device *dev, struct sdla_mem *info, int
read)
{
	struct sdla_mem mem;
	char	*temp;

Start --->
	if(copy_from_user(&mem, info, sizeof(mem)))
		return -EFAULT;
		
	if (read)
	{	
Error --->
		temp = kmalloc(mem.len, GFP_KERNEL);
		if (!temp)
			return(-ENOMEM);
		sdla_read(dev, mem.addr, temp, mem.len);
---------------------------------------------------------
[BUG]
/home/kash/linux/linux-2.6.5/drivers/scsi/aacraid/commctrl.c:419:aac_send_raw_srb: ERROR:TAINT: 413:419:Passing unbounded user value "fibsize" as arg 2 to function "copy_from_user", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(lib,copy_from_user,user,trustingsink)]  [MINOR] [CAPABILTY] [PATH=] 
	}
	fib_init(srbfib);

	srbcmd = (struct aac_srb*) fib_data(srbfib);

Start --->
	if(copy_from_user((void*)&fibsize,
(void*)&user_srb->count,sizeof(u32))){
		printk(KERN_DEBUG"aacraid: Could not copy data size from user\n"); 
		rcode = -EFAULT;
		goto cleanup;
	}

Error --->
	if(copy_from_user(srbcmd, user_srb,fibsize)){
		printk(KERN_DEBUG"aacraid: Could not copy srb from user\n"); 
		rcode = -EFAULT;
		goto cleanup;
---------------------------------------------------------
[BUG] minor
/home/kash/linux/linux-2.6.5/drivers/md/dm-ioctl.c:1180:copy_params:
ERROR:TAINT: 1174:1180:Passing unbounded user value "(tmp).data_size" as
arg 0 to function "vmalloc", which uses it unsafely in model
[SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)]
[SINK_MODEL=(lib,vmalloc,user,trustingsink)] [BOUNDS= Lower bound on
line 1177] [MINOR]  [PATH=] 

static int copy_params(struct dm_ioctl *user, struct dm_ioctl **param)
{
	struct dm_ioctl tmp, *dmi;

Start --->
	if (copy_from_user(&tmp, user, sizeof(tmp)))
		return -EFAULT;

	if (tmp.data_size < sizeof(tmp))
		return -EINVAL;

Error --->
	dmi = (struct dm_ioctl *) vmalloc(tmp.data_size);
	if (!dmi)
		return -ENOMEM;

---------------------------------------------------------
[BUG] suspicious
/home/kash/linux/linux-2.6.5/net/bridge/netfilter/ebtables.c:1235:update_counters: ERROR:TAINT: 1227:1235:Passing unbounded user value "((hlp).num_counters * 16)" as arg 0 to function "vmalloc", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(lib,vmalloc,user,trustingsink)]  [MINOR]  [PATH=] 
	int i, ret;
	struct ebt_counter *tmp;
	struct ebt_replace hlp;
	struct ebt_table *t;

Start --->
	if (copy_from_user(&hlp, user, sizeof(hlp)))
		return -EFAULT;

	if (len != sizeof(hlp) + hlp.num_counters * sizeof(struct ebt_counter))
		return -EINVAL;
	if (hlp.num_counters == 0)
		return -EINVAL;

Error --->
	if ( !(tmp = (struct ebt_counter *)
	   vmalloc(hlp.num_counters * sizeof(struct ebt_counter))) ){
		MEMPRINT("Update_counters && nomemory\n");
		return -ENOMEM;
---------------------------------------------------------
[BUG] minor
/home/kash/linux/linux-2.6.5/drivers/ide/ide-taskfile.c:1071:ide_taskfile_ioctl: ERROR:TAINT: 1061:1071:Passing unbounded user value "taskout" as arg 0 to function "kmalloc", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(lib,kmalloc,user,trustingsink)]  [MINOR]  [PATH=] 
//	printk("IDE Taskfile ...\n");

	req_task = kmalloc(tasksize, GFP_KERNEL);
	if (req_task == NULL) return -ENOMEM;
	memset(req_task, 0, tasksize);
Start --->
	if (copy_from_user(req_task, (void *) arg, tasksize)) {
		kfree(req_task);
		return -EFAULT;
	}

	taskout = (int) req_task->out_size;
	taskin  = (int) req_task->in_size;

	if (taskout) {
		int outtotal = tasksize;
Error --->
		outbuf = kmalloc(taskout, GFP_KERNEL);
		if (outbuf == NULL) {
			err = -ENOMEM;
			goto abort;
---------------------------------------------------------
[BUG] minor IndexCard is unsigned char
/home/kash/linux/linux-2.6.5/drivers/char/applicom.c:722:ac_ioctl:
ERROR:TAINT: 701:722:Using user value "IndexCard" without first
performing bounds checks
[SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [PATH= "cmd != 0"
on line 708 is false => "copy_from_user != 0" on line 701 is false] 
[MINOR]  [Also used at, line 798]

	adgl = kmalloc(sizeof(struct st_ram_io), GFP_KERNEL);
	if (!adgl)
		return -ENOMEM;

Start --->
	if (copy_from_user(adgl, (void *)arg,sizeof(struct st_ram_io))) {

	... DELETED 15 lines ...

	}

	switch (cmd) {
		
	case 0:
Error --->
		pmem = apbs[IndexCard].RamIO;
		for (i = 0; i < sizeof(struct st_ram_io); i++)
			((unsigned char *)adgl)[i]=readb(pmem++);
		if (copy_to_user((void *)arg, adgl, sizeof(struct st_ram_io)))
---------------------------------------------------------
[BUG] overflow in check
/home/kash/linux/linux-2.6.5/net/bridge/netfilter/ebtables.c:936:do_replace: ERROR:TAINT: 915:936:Passing unbounded user value "(tmp).entries_size" as arg 0 to function "vmalloc", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(lib,vmalloc,user,trustingsink)]  [MINOR]  [PATH= "countersize != 0" on line 933 is false => "newinfo == 0" on line 930 is false => "(tmp).entries_size == 0" on line 923 is false => "len != (80 + (tmp).entries_size)" on line 918 is false => "copy_from_user != 0" on line 915 is false] 
	struct ebt_table *t;
	struct ebt_counter *counterstmp = NULL;
	/* used to be able to unlock earlier */
	struct ebt_table_info *table;

Start --->
	if (copy_from_user(&tmp, user, sizeof(tmp)) != 0)

	... DELETED 15 lines ...

		return -ENOMEM;

	if (countersize)
		memset(newinfo->counters, 0, countersize);

Error --->
	newinfo->entries = (char *)vmalloc(tmp.entries_size);
	if (!newinfo->entries) {
		ret = -ENOMEM;
		goto free_newinfo;
---------------------------------------------------------
[BUG] minor
/home/kash/linux/linux-2.6.5/drivers/ide/ide-taskfile.c:1085:ide_taskfile_ioctl: ERROR:TAINT: 1061:1085:Passing unbounded user value "taskin" as arg 0 to function "kmalloc", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(lib,kmalloc,user,trustingsink)]  [MINOR]  [PATH=] 
//	printk("IDE Taskfile ...\n");

	req_task = kmalloc(tasksize, GFP_KERNEL);
	if (req_task == NULL) return -ENOMEM;
	memset(req_task, 0, tasksize);
Start --->
	if (copy_from_user(req_task, (void *) arg, tasksize)) {

	... DELETED 18 lines ...

		}
	}

	if (taskin) {
		int intotal = tasksize + taskout;
Error --->
		inbuf = kmalloc(taskin, GFP_KERNEL);
		if (inbuf == NULL) {
			err = -ENOMEM;
			goto abort;
---------------------------------------------------------
[BUG] minor
/home/kash/linux/linux-2.6.5/drivers/message/fusion/mptctl.c:1402:mptctl_gettargetinfo: ERROR:TAINT: 1360:1402:Passing unbounded user value "numBytes" as arg 0 to function "kmalloc", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(lib,kmalloc,user,trustingsink)]  [MINOR]  [PATH=] 
	int			maxWordsLeft;
	int			numBytes;
	u8			port, devType, bus_id;

	dctlprintk(("mptctl_gettargetinfo called.\n"));
Start --->
	if (copy_from_user(&karg, uarg, sizeof(struct mpt_ioctl_targetinfo))) {

	... DELETED 36 lines ...

	 * bits 31-24: reserved
	 *      23-16: LUN
	 *      15- 8: Bus Number
	 *       7- 0: Target ID
	 */
Error --->
	pmem = kmalloc(numBytes, GFP_KERNEL);
	if (pmem == NULL) {
		printk(KERN_ERR "%s::mptctl_gettargetinfo() @%d - no memory
available!\n",
				__FILE__, __LINE__);
---------------------------------------------------------
[BUG]
/home/kash/linux/linux-2.6.5/drivers/block/DAC960.c:6663:DAC960_gam_ioctl: ERROR:TAINT: 6609:6663:Using user value "(DCDB).TargetID" without first performing bounds checks [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [PATH=]  [MINOR] [CAPABILTY] 
	CommandOpcode = UserCommand.CommandMailbox.Common.CommandOpcode;
	DataTransferLength = UserCommand.DataTransferLength;
	if (CommandOpcode & 0x80) return -EINVAL;
	if (CommandOpcode == DAC960_V1_DCDB)
	  {
Start --->
	    if (copy_from_user(&DCDB, UserCommand.DCDB,

	... DELETED 48 lines ...

	if (CommandOpcode == DAC960_V1_DCDB)
	  {
	    spin_lock_irqsave(&Controller->queue_lock, flags);
	    while ((Command = DAC960_AllocateCommand(Controller)) == NULL)
	      DAC960_WaitForCommand(Controller);
Error --->
	    while (Controller->V1.DirectCommandActive[DCDB.Channel]
						     [DCDB.TargetID])
	      {
		spin_unlock_irq(&Controller->queue_lock);
---------------------------------------------------------
[BUG]
/home/kash/linux/linux-2.6.5/drivers/block/DAC960.c:6865:DAC960_gam_ioctl: ERROR:TAINT: 6752:6865:Passing unbounded user value "DataTransferLength" as arg 2 to function "copy_to_user", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(lib,copy_to_user,user,trustingsink)] [BOUNDS= Lower bound on line 6863] [MINOR] [CAPABILTY] [PATH=] 
	unsigned char *DataTransferBuffer = NULL;
	dma_addr_t DataTransferBufferDMA;
	unsigned char *RequestSenseBuffer = NULL;
	dma_addr_t RequestSenseBufferDMA;
	if (UserSpaceUserCommand == NULL) return -EINVAL;
Start --->
	if (copy_from_user(&UserCommand, UserSpaceUserCommand,

	... DELETED 107 lines ...

		ErrorCode = -EFAULT;
		goto Failure2;
	}
	if (DataTransferLength > 0)
	  {
Error --->
	    if (copy_to_user(UserCommand.DataTransferBuffer,
			     DataTransferBuffer, DataTransferLength)) {
		ErrorCode = -EFAULT;
		goto Failure2;
---------------------------------------------------------
[BUG] minor root only
/home/kash/linux/linux-2.6.5/drivers/net/wan/lmc/lmc_main.c:487:lmc_ioctl: ERROR:TAINT: 350:487:Passing unbounded user value "(xc).len" as arg 0 to function "kmalloc", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(lib,kmalloc,user,trustingsink)]  [MINOR] [CAPABILTY] [PATH=] 
            /*
             * Stop the xwitter whlie we restart the hardware
             */
            netif_stop_queue(dev);

Start --->
            if (copy_from_user(&xc, ifr->ifr_data, sizeof (struct
lmc_xilinx_control)))

	... DELETED 131 lines ...

                    if(xc.data == 0x0){
                            ret = -EINVAL;
                            break;
                    }

Error --->
                    data = kmalloc(xc.len, GFP_KERNEL);
                    if(data == 0x0){
                            printk(KERN_WARNING "%s: Failed to allocate
memory for copy\n", dev->name);
                            ret = -ENOMEM;



