Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264181AbTCXMZF>; Mon, 24 Mar 2003 07:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264182AbTCXMZF>; Mon, 24 Mar 2003 07:25:05 -0500
Received: from elaine24.Stanford.EDU ([171.64.15.99]:3243 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S264181AbTCXMY6>; Mon, 24 Mar 2003 07:24:58 -0500
Date: Mon, 24 Mar 2003 04:35:55 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: linux-kernel@vger.kernel.org
cc: mc@cs.stanford.edu
Subject: [CHECKER] 8 potential calling blocking kmalloc(GFP_KERNEL) with
 locks held errors
In-Reply-To: <Pine.GSO.4.44.0303231622570.25008-100000@elaine24.Stanford.EDU>
Message-ID: <Pine.GSO.4.44.0303240430290.23814-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Enclosed are 8 potential deadlock errors. The checker warns when it sees a
call to kmalloc(*, GFP_KERNEL) with locks held. Any comments will be
greatly appereciated.

-Junfeng

[BUG]
/home/junfeng/linux-2.5.63/drivers/atm/iphase.c:3221:ia_init_one:
ERROR:BLOCK:3220:3221:calling blocking fn ia_start with lock
&(*iadev).misc_lock held [ia_start calling rx_init calling kmalloc][START:
&(*iadev).misc_lock, unknown->locked,
/home/junfeng/linux-2.5.63/drivers/atm/iphase.c, ia_init_one, 3220]

	ia_dev[iadev_count] = iadev;
	_ia_dev[iadev_count] = dev;
	iadev_count++;
	spin_lock_init(&iadev->misc_lock);
	/* First fixes first. I don't want to think about this now. */
Start --->
	spin_lock_irqsave(&iadev->misc_lock, flags);
Error --->
	if (ia_init(dev) || ia_start(dev)) {
		IF_INIT(printk("IA register failed!\n");)
		iadev_count--;
		ia_dev[iadev_count] = NULL;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/drivers/ieee1394/sbp2.c:684:sbp2util_create_command_orb_pool:
ERROR:BLOCK:682:684:calling blocking fn kmalloc with lock
&(*scsi_id).sbp2_command_orb_lock held [kmalloc][START:
&(*scsi_id).sbp2_command_orb_lock, unknown->locked,
/home/junfeng/linux-2.5.63/drivers/ieee1394/sbp2.c,
sbp2util_create_command_orb_pool, 682]

	unsigned long flags, orbs;
	struct sbp2_command_info *command;

	orbs = sbp2_serialize_io ? 2 : SBP2_MAX_COMMAND_ORBS;

Start --->
	spin_lock_irqsave(&scsi_id->sbp2_command_orb_lock, flags);
	for (i = 0; i < orbs; i++) {
Error --->
		command = (struct sbp2_command_info *)
		    kmalloc(sizeof(struct sbp2_command_info), GFP_KERNEL);
		if (!command) {

spin_unlock_irqrestore(&scsi_id->sbp2_command_orb_lock, flags);
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/drivers/scsi/dpt_i2o.c:1705:adpt_i2o_passthru:
ERROR:BLOCK:1699:1705:calling blocking fn adpt_i2o_post_wait with lock
(*(*pHba).host).host_lock held [adpt_i2o_post_wait calling kmalloc][START:
(*(*pHba).host).host_lock, unknown->locked,
/home/junfeng/linux-2.5.63/drivers/scsi/dpt_i2o.c, adpt_i2o_passthru,
1699]

			sg[i].addr_bus = (u32)virt_to_bus((void*)p);
		}
	}

	do {
Start --->
		spin_lock_irqsave(pHba->host->host_lock, flags);
		// This state stops any new commands from enterring the
		// controller while processing the ioctl
//		pHba->state |= DPTI_STATE_IOCTL;
//		We can't set this now - The scsi subsystem sets
host_blocked and
//		the queue empties and stops.  We need a way to restart the
queue
Error --->
		rcode = adpt_i2o_post_wait(pHba, msg, size, FOREVER);
//		pHba->state &= ~DPTI_STATE_IOCTL;
		spin_unlock_irqrestore(pHba->host->host_lock, flags);
	} while(rcode == -ETIMEDOUT);
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/drivers/ieee1394/ohci1394.c:994:ohci_devctl:
ERROR:BLOCK:982:994:calling blocking fn alloc_dma_rcv_ctx with lock
&(*ohci).IR_channel_lock held [alloc_dma_rcv_ctx calling kmalloc][START:
&(*ohci).IR_channel_lock, unknown->locked,
/home/junfeng/linux-2.5.63/drivers/ieee1394/ohci1394.c, ohci_devctl, 982]

			return -EFAULT;
		}

		mask = (u64)0x1<<arg;

Start --->
                spin_lock_irqsave(&ohci->IR_channel_lock, flags);

		if (ohci->ISO_channel_usage & mask) {
			PRINT(KERN_ERR, ohci->id,
			      "%s: IS0 listen channel %d is already used",
			      __FUNCTION__, arg);
			spin_unlock_irqrestore(&ohci->IR_channel_lock,
flags);
			return -EFAULT;
		}

		/* activate the legacy IR context */
		if(ohci->ir_legacy_context.ohci == NULL) {
Error --->
			if(alloc_dma_rcv_ctx(ohci,
&ohci->ir_legacy_context,
					     DMA_CTX_ISO, 0, IR_NUM_DESC,
					     IR_BUF_SIZE,
IR_SPLIT_BUF_SIZE,
					     OHCI1394_IsoRcvContextBase) <
0) {
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/drivers/isdn/i4l/isdn_common.c:933:register_isdn:
ERROR:BLOCK:918:933:calling blocking fn isdn_add_channels with lock
&drivers_lock held [isdn_add_channels calling kmalloc][START:
&drivers_lock, unknown->locked,
/home/junfeng/linux-2.5.63/drivers/isdn/i4l/isdn_common.c, register_isdn,
918]

	drv->fi.state = ST_DRV_NULL;
	drv->fi.debug = 1;
	drv->fi.userdata = drv;
	drv->fi.printdebug = drv_debug;

Start --->
	spin_lock_irqsave(&drivers_lock, flags);

	... DELETED 9 lines ...


	if (__isdn_drv_lookup(iif->id) >= 0)
		goto fail_unlock;

	strcpy(drv->id, iif->id);
Error --->
	if (isdn_add_channels(drv, iif->channels))
		goto fail_unlock;

	drv->di = drvidx;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/drivers/net/wan/comx-hw-munich.c:1458:MUNICH_open:
ERROR:BLOCK:1438:1458:calling blocking fn kmalloc with lock &mister_lock
held [kmalloc][START: &mister_lock, unknown->locked,
/home/junfeng/linux-2.5.63/drivers/net/wan/comx-hw-munich.c, MUNICH_open,
1438]

	printk("MUNICH_open: no %s board with boardnum = %d\n",
	       ch->hardware->name, hw->boardnum);
	return -ENODEV;
    }

Start --->
    spin_lock_irqsave(&mister_lock, flags);

	... DELETED 14 lines ...

	    board->histogram[i] = 0;

	board->lineup = 0;

	/* Allocate CCB: */
Error --->
        board->ccb = kmalloc(sizeof(munich_ccb_t), GFP_KERNEL);
	if (board->ccb == NULL)
	{
	    spin_unlock_irqrestore(&mister_lock, flags);
---------------------------------------------------------
[BUG] interesting things to check: calling kmalloc with GFP_KERNEL and
then with GFP_ATOMIC.
/home/junfeng/linux-2.5.63/net/rose/rose_route.c:112:rose_add_node:
ERROR:BLOCK:64:112:calling blocking fn kmalloc with lock
&rose_neigh_list_lock held [kmalloc][START: &rose_neigh_list_lock,
unknown->locked, /home/junfeng/linux-2.5.63/net/rose/rose_route.c,
rose_add_node, 64]

	struct rose_node  *rose_node, *rose_tmpn, *rose_tmpp;
	struct rose_neigh *rose_neigh;
	int i, res = 0;

	spin_lock_bh(&rose_node_list_lock);
Start --->
	spin_lock_bh(&rose_neigh_list_lock);

	... DELETED 42 lines ...


		init_timer(&rose_neigh->ftimer);
		init_timer(&rose_neigh->t0timer);

		if (rose_route->ndigis != 0) {
Error --->
			if ((rose_neigh->digipeat =
kmalloc(sizeof(ax25_digi), GFP_KERNEL)) == NULL) {
				kfree(rose_neigh);
				res = -ENOMEM;
				goto out;
---------------------------------------------------------
[BUG] such a huge ioctl function ...
/home/junfeng/linux-2.5.63/drivers/net/wan/lmc/lmc_main.c:500:lmc_ioctl:
ERROR:BLOCK:160:500:calling blocking fn kmalloc with lock &(*sc).lmc_lock
held [kmalloc][START: &(*sc).lmc_lock, unknown->locked,
/home/junfeng/linux-2.5.63/drivers/net/wan/lmc/lmc_main.c, lmc_ioctl, 160]


    /*
     * Most functions mess with the structure
     * Disable interrupts while we do the polling
     */
Start --->
    spin_lock_irqsave(&sc->lmc_lock, flags);

	... DELETED 334 lines ...

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




