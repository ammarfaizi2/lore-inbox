Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbUC1HCp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 02:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbUC1HCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 02:02:44 -0500
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:6095 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S262088AbUC1HCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 02:02:17 -0500
Message-Id: <5.2.1.1.2.20040327225419.01930cc8@kash.pobox.stanford.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sat, 27 Mar 2004 23:02:16 -0800
To: linux-kernel@vger.kernel.org
From: Ken Ashcraft <kash@stanford.edu>
Subject: [CHECKER] 33 missing null checks
Cc: mc@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm from the Stanford Metacompilation research group where we use static 
analysis to find bugs.  I'm trying a new technique, so I would appreciate 
feedback on these error reports.

I found these errors by comparing implementations of the same 
interface.  If functions are assigned to the same function pointer (same 
field of some struct), I assume that the functions are called from the same 
context.  Therefore, they should treat their incoming parameters 
similarly.  In this case, before dereferencing pointers, the functions 
should either check the pointers for null or not check the pointers for 
null.  Any contradiction is an error.

There are 33 reports below.  Each report contains first a reference to an 
EXAMPLE or a place where the parameter is checked.  That reference is 
followed by a COUNTER(example) or a place where the parameter is not 
checked.  After that is a code snippet from the counter example.  The type 
of the function pointer (struct foo.bar) can be found in the COUNTER field: 
[COUNTER=struct foo.bar-param_num].

Unfortunately, many of these errors had only one EXAMPLE and one 
COUNTER.  It may be that some of the null checks are spurious.  You can see 
the number of EXAMPLEs for a report in the [ex=i] field of the COUNTER line.

Thanks for any feedback,
Ken Ashcraft

#  Total 				  = 33
# BUGs	|	File Name
6	|	/pci/cpqphp_core.c
2	|	/pci/cpci_hotplug_core.c
2	|	/drivers/rocket.c
1	|	/net/protocol.c
1	|	/usb/scsiglue.c
1	|	/net/rose_route.c
1	|	/net/af_packet.c
1	|	/pci/ibmphp_core.c
1	|	/drivers/toshiba_acpi.c
1	|	/usb/kl5kusb105.c
1	|	/pnp/core.c
1	|	/media/cpia_usb.c
1	|	/drivers/csr.c
1	|	/acpi/utcopy.c
1	|	/linux-2.6.3/params.c
1	|	/pci/fakephp.c
1	|	/cpu/p4-clockmod.c
1	|	/drivers/wd7000.c
1	|	/fs/file.c
1	|	/usb/mct_u232.c
1	|	/net/lapbether.c
1	|	/acpi/dswload.c
1	|	/usb/digi_acceleport.c
1	|	/drivers/ips.c
1	|	/ipv4/ipt_MASQUERADE.c
1	|	/acpi/dswexec.c


---------------------------------------------------------
[BUG] if net/socket.c:sys_bind is the only caller, null check is unnecessary
/home/kash/interface/linux-2.6.3/net/bluetooth/l2cap.c:399:l2cap_sock_bind: 
NOTE:DEREF: Checking arg addr [EXAMPLE=struct proto_ops.bind-1]
/home/kash/interface/linux-2.6.3/net/packet/af_packet.c:887:packet_bind_spkt: 
ERROR:DEREF: Not checking arg uaddr [COUNTER=struct proto_ops.bind-1] 
[fit=2] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=3] [counter=1] [z = 
-1.83532587096449] [fn-z = -4.35889894354067]
	 *	Check legality
	 */
	
	if(addr_len!=sizeof(struct sockaddr))
		return -EINVAL;

Error --->
	strlcpy(name,uaddr->sa_data,sizeof(name));

	dev = dev_get_by_name(name);
	if (dev) {
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/kernel/module.c:856:set_obsolete: 
NOTE:DEREF: Checking arg val [EXAMPLE=struct kernel_param.set-0]
/home/kash/interface/linux-2.6.3/kernel/params.c:326:param_set_copystring: 
ERROR:DEREF: Not checking arg val [COUNTER=struct kernel_param.set-0] 
[fit=1] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=3] [counter=1] [z = 
-1.83532587096449] [fn-z = -4.35889894354067]

int param_set_copystring(const char *val, struct kernel_param *kp)
{
	struct kparam_string *kps = kp->arg;


Error --->
	if (strlen(val)+1 > kps->maxlen) {
		printk(KERN_ERR "%s: string doesn't fit in %u chars.\n",
		       kp->name, kps->maxlen-1);
		return -ENOSPC;
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/net/ipv4/netfilter/ipt_LOG.c:341:ipt_log_target: 
NOTE:DEREF: Checking arg out [EXAMPLE=struct ipt_target.target-2]
/home/kash/interface/linux-2.6.3/net/ipv4/netfilter/ipt_MASQUERADE.c:128:masquerade_target: 
ERROR:DEREF: Not checking arg out [COUNTER=struct ipt_target.target-2] 
[fit=3] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=2] [counter=1] [z = 
-2.25170500701057] [fn-z = -4.35889894354067]
	newsrc = rt->rt_src;
	DEBUGP("newsrc = %u.%u.%u.%u\n", NIPQUAD(newsrc));
	ip_rt_put(rt);

	WRITE_LOCK(&masq_lock);

Error --->
	ct->nat.masq_index = out->ifindex;
	WRITE_UNLOCK(&masq_lock);

	/* Transfer from original range. */
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/pci/hotplug/ibmphp_core.c:338:get_adapter_present: 
NOTE:DEREF: Checking arg value [EXAMPLE=struct 
hotplug_slot_ops.get_adapter_status-1]
/home/kash/interface/linux-2.6.3/drivers/pci/hotplug/cpqphp_core.c:797:get_adapter_status: 
ERROR:DEREF: Not checking arg value [COUNTER=struct 
hotplug_slot_ops.get_adapter_status-1] [fit=7] [fit_fn=1] [fn_ex=0] 
[fn_counter=1] [ex=1] [counter=1] [z = -2.91998558035372] [fn-z = 
-4.35889894354067]

	ctrl = slot->ctrl;
	if (ctrl == NULL)
		return -ENODEV;
	

Error --->
	*value = get_presence_status (ctrl, slot);

	return 0;
}
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/pci/hotplug/ibmphp_ebda.c:760:release_slot: 
NOTE:DEREF: Checking arg hotplug_slot [EXAMPLE=struct hotplug_slot.release-0]
/home/kash/interface/linux-2.6.3/drivers/pci/hotplug/fakephp.c:81:dummy_release: 
ERROR:DEREF: Not checking arg slot [COUNTER=struct hotplug_slot.release-0] 
[fit=10] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=1] [counter=1] [z = 
-2.91998558035372] [fn-z = -4.35889894354067]
	.disable_slot		= disable_slot,
};

static void dummy_release(struct hotplug_slot *slot)
{

Error --->
	struct dummy_slot *dslot = slot->private;

	list_del(&dslot->node);
	kfree(dslot->slot->info);
---------------------------------------------------------
[BUG] example is: 
/home/kash/interface/linux-2.6.3/drivers/pnp/isapnp/core.c:1062:isapnp_disable_resources
/home/kash/interface/linux-2.6.3/drivers/pnp/isapnp/core.c:1062:isapnp_disable_resources: 
NOTE:DEREF: Checking arg dev [EXAMPLE=struct pnp_protocol.disable-0]
/home/kash/interface/linux-2.6.3/drivers/pnp/pnpbios/core.c:293:pnpbios_disable_resources: 
ERROR:DEREF: Not checking arg dev [COUNTER=struct pnp_protocol.disable-0] 
[fit=17] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=1] [counter=1] [z = 
-2.91998558035372] [fn-z = -4.35889894354067]
}

static int pnpbios_disable_resources(struct pnp_dev *dev)
{
	struct pnp_bios_node * node;

Error --->
	u8 nodenum = dev->number;
	int ret;

	/* just in case */
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/pci/hotplug/fakephp.c:177:disable_slot: 
NOTE:DEREF: Checking arg slot [EXAMPLE=struct hotplug_slot_ops.disable_slot-0]
/home/kash/interface/linux-2.6.3/drivers/pci/hotplug/ibmphp_core.c:1151:ibmphp_disable_slot: 
ERROR:DEREF: Not checking arg hotplug_slot [COUNTER=struct 
hotplug_slot_ops.disable_slot-0] [fit=11] [fit_fn=1] [fn_ex=0] 
[fn_counter=1] [ex=1] [counter=1] [z = -2.91998558035372] [fn-z = 
-4.35889894354067]
* OUTPUT: SUCCESS 0 ; FAILURE: UNCONFIGURE , VALIDATE         *
           DISABLE POWER ,                                    *
**************************************************************/
int ibmphp_disable_slot (struct hotplug_slot *hotplug_slot)
{

Error --->
	struct slot *slot = hotplug_slot->private;
	int rc;
	
	ibmphp_lock_operations();
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/pci/hotplug/ibmphp_core.c:369:get_max_bus_speed: 
NOTE:DEREF: Checking arg value [EXAMPLE=struct 
hotplug_slot_ops.get_max_bus_speed-1]
/home/kash/interface/linux-2.6.3/drivers/pci/hotplug/cpqphp_core.c:816:get_max_bus_speed: 
ERROR:DEREF: Not checking arg value [COUNTER=struct 
hotplug_slot_ops.get_max_bus_speed-1] [fit=25] [fit_fn=1] [fn_ex=0] 
[fn_counter=1] [ex=1] [counter=1] [z = -2.91998558035372] [fn-z = 
-4.35889894354067]

	ctrl = slot->ctrl;
	if (ctrl == NULL)
		return -ENODEV;
	

Error --->
	*value = ctrl->speed_capability;

	return 0;
}
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/char/vt.c:2392:con_stop: 
NOTE:DEREF: Checking arg tty [EXAMPLE=struct tty_operations.stop-0]
/home/kash/interface/linux-2.6.3/drivers/char/rocket.c:1525:rp_stop: 
ERROR:DEREF: Not checking arg tty [COUNTER=struct tty_operations.stop-0] 
[fit=15] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=1] [counter=1] [z = 
-2.91998558035372] [fn-z = -4.35889894354067]
  * They enable or disable transmitter interrupts, as necessary.
  * ------------------------------------------------------------
  */
static void rp_stop(struct tty_struct *tty)
{

Error --->
	struct r_port *info = (struct r_port *) tty->driver_data;

#ifdef ROCKET_DEBUG_FLOW
	printk(KERN_INFO "stop %s: %d %d....\n", tty->name,
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/net/wan/x25_asy.c:394:x25_asy_data_transmit: 
NOTE:DEREF: Checking arg skb [EXAMPLE=struct 
lapb_register_struct.data_transmit-1]
/home/kash/interface/linux-2.6.3/drivers/net/wan/lapbether.c:206:lapbeth_data_transmit: 
ERROR:DEREF: Not checking arg skb [COUNTER=struct 
lapb_register_struct.data_transmit-1] [fit=16] [fit_fn=1] [fn_ex=0] 
[fn_counter=1] [ex=1] [counter=1] [z = -2.91998558035372] [fn-z = 
-4.35889894354067]
static void lapbeth_data_transmit(void *token, struct sk_buff *skb)
{
	struct lapbethdev *lapbeth = (struct lapbethdev *)token;
	unsigned char *ptr;
	struct net_device *dev;

Error --->
	int size = skb->len;

	skb->protocol = htons(ETH_P_X25);

---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/acpi/utilities/utcopy.c:738:acpi_ut_copy_ielement_to_ielement: 
NOTE:DEREF: Checking arg source_object [EXAMPLE=acpi_ut_walk_package_tree-1]
/home/kash/interface/linux-2.6.3/drivers/acpi/utilities/utcopy.c:238:acpi_ut_copy_ielement_to_eelement: 
ERROR:DEREF: Not checking arg source_object 
[COUNTER=acpi_ut_walk_package_tree-1] [fit=22] [fit_fn=1] [fn_ex=0] 
[fn_counter=1] [ex=1] [counter=1] [z = -2.91998558035372] [fn-z = 
-4.35889894354067]

		/*
		 * Build the package object
		 */
		target_object->type             = ACPI_TYPE_PACKAGE;

Error --->
		target_object->package.count    = source_object->package.count;
		target_object->package.elements = ACPI_CAST_PTR (union acpi_object, 
info->free_space);

		/*
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/net/netrom/nr_route.c:773:nr_route_frame: 
NOTE:DEREF: Checking arg ax25 [EXAMPLE=ax25_protocol_register-1]
/home/kash/interface/linux-2.6.3/net/rose/rose_route.c:871:rose_route_frame: 
ERROR:DEREF: Not checking arg ax25 [COUNTER=ax25_protocol_register-1] 
[fit=13] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=1] [counter=1] [z = 
-2.91998558035372] [fn-z = -4.35889894354067]
	spin_lock_bh(&rose_neigh_list_lock);
	spin_lock_bh(&rose_route_list_lock);

	rose_neigh = rose_neigh_list;
	while (rose_neigh != NULL) {

Error --->
		if (ax25cmp(&ax25->dest_addr, &rose_neigh->callsign) == 0 &&
		    ax25->ax25_dev->dev == rose_neigh->dev)
			break;
		rose_neigh = rose_neigh->next;
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/fs/reiserfs/inode.c:2279:reiserfs_commit_write: 
NOTE:DEREF: Checking arg f [EXAMPLE=struct 
address_space_operations.commit_write-0]
/home/kash/interface/linux-2.6.3/fs/cifs/file.c:737:cifs_commit_write: 
ERROR:DEREF: Not checking arg file [COUNTER=struct 
address_space_operations.commit_write-0] [fit=20] [fit_fn=1] [fn_ex=0] 
[fn_counter=1] [ex=1] [counter=1] [z = -2.91998558035372] [fn-z = 
-4.35889894354067]

	xid = GetXid();

	if (position > inode->i_size){
		inode->i_size = position;

Error --->
		if (file->private_data == NULL) {
			rc = -EBADF;
		} else {
			cifs_sb = CIFS_SB(inode->i_sb);
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c:386:cpufreq_gx_target: 
NOTE:DEREF: Checking arg policy [EXAMPLE=struct cpufreq_driver.target-0]
/home/kash/interface/linux-2.6.3/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:168:cpufreq_p4_target: 
ERROR:DEREF: Not checking arg policy [COUNTER=struct 
cpufreq_driver.target-0] [fit=23] [fit_fn=1] [fn_ex=0] [fn_counter=1] 
[ex=1] [counter=1] [z = -2.91998558035372] [fn-z = -4.35889894354067]
	unsigned int    newstate = DC_RESV;

	if (cpufreq_frequency_table_target(policy, &p4clockmod_table[0], 
target_freq, relation, &newstate))
		return -EINVAL;


Error --->
	cpufreq_p4_setdc(policy->cpu, p4clockmod_table[newstate].index);

	return 0;
}
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/ieee1394/sbp2.c:2407:sbp2_handle_status_write: 
NOTE:DEREF: Checking arg host [EXAMPLE=struct hpsb_address_ops.write-0]
/home/kash/interface/linux-2.6.3/drivers/ieee1394/csr.c:413:write_regs: 
ERROR:DEREF: Not checking arg host [COUNTER=struct 
hpsb_address_ops.write-0] [fit=9] [fit_fn=1] [fn_ex=0] [fn_counter=1] 
[ex=1] [counter=1] [z = -2.91998558035372] [fn-z = -4.35889894354067]
         case CSR_STATE_SET:
                 printk("doh, someone wants to mess with state set\n");
                 out;

         case CSR_NODE_IDS:

Error --->
                 host->csr.node_ids &= NODE_MASK << 16;
                 host->csr.node_ids |= be32_to_cpu(*(data++)) & (BUS_MASK 
<< 16);
                 host->node_id = host->csr.node_ids >> 16;
                 host->driver->devctl(host, SET_BUS_ID, host->node_id >> 6);
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/net/sctp/ipv6.c:267:sctp_v6_get_saddr: 
NOTE:DEREF: Checking arg asoc [EXAMPLE=struct sctp_af.get_saddr-0]
/home/kash/interface/linux-2.6.3/net/sctp/protocol.c:533:sctp_v4_get_saddr: 
ERROR:DEREF: Not checking arg asoc [COUNTER=struct sctp_af.get_saddr-0] 
[fit=19] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=1] [counter=1] [z = 
-2.91998558035372] [fn-z = -4.35889894354067]
{
	struct rtable *rt = (struct rtable *)dst;

	if (rt) {
		saddr->v4.sin_family = AF_INET;

Error --->
		saddr->v4.sin_port = asoc->base.bind_addr.port;
		saddr->v4.sin_addr.s_addr = rt->rt_src;
	}
}
---------------------------------------------------------
[BUG] if these really are equivalent...
/home/kash/interface/linux-2.6.3/drivers/acpi/debug.c:75:acpi_system_write_debug: 
NOTE:DEREF: Checking arg data [EXAMPLE=struct proc_dir_entry.write_proc-3]
/home/kash/interface/linux-2.6.3/drivers/acpi/toshiba_acpi.c:275:dispatch_write: 
ERROR:DEREF: Not checking arg item [COUNTER=struct 
proc_dir_entry.write_proc-3] [fit=18] [fit_fn=1] [fn_ex=0] [fn_counter=1] 
[ex=1] [counter=1] [z = -2.91998558035372] [fn-z = -4.35889894354067]

static int
dispatch_write(struct file* file, const char* buffer, unsigned long count,
	ProcItem* item)
{

Error --->
	return item->write_func(buffer, count);
}

static char*
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/pci/hotplug/ibmphp_core.c:409:get_cur_bus_speed: 
NOTE:DEREF: Checking arg value [EXAMPLE=struct 
hotplug_slot_ops.get_cur_bus_speed-1]
/home/kash/interface/linux-2.6.3/drivers/pci/hotplug/cpqphp_core.c:835:get_cur_bus_speed: 
ERROR:DEREF: Not checking arg value [COUNTER=struct 
hotplug_slot_ops.get_cur_bus_speed-1] [fit=21] [fit_fn=1] [fn_ex=0] 
[fn_counter=1] [ex=1] [counter=1] [z = -2.91998558035372] [fn-z = 
-4.35889894354067]

	ctrl = slot->ctrl;
	if (ctrl == NULL)
		return -ENODEV;
	

Error --->
	*value = ctrl->speed;

	return 0;
}
---------------------------------------------------------
[BUG] not sure...maybe more than one use of callback?
/home/kash/interface/linux-2.6.3/drivers/scsi/ips.c:3392:ipsintr_done: 
NOTE:DEREF: Checking arg scb [EXAMPLE=struct ips_scb.callback-1]
/home/kash/interface/linux-2.6.3/drivers/scsi/ips.c:3371:ipsintr_blocking: 
ERROR:DEREF: Not checking arg scb [COUNTER=struct ips_scb.callback-1] 
[fit=24] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=1] [counter=1] [z = 
-2.91998558035372] [fn-z = -4.35889894354067]
ipsintr_blocking(ips_ha_t * ha, ips_scb_t * scb)
{
	METHOD_TRACE("ipsintr_blocking", 2);

	ips_freescb(ha, scb);

Error --->
	if ((ha->waitflag == TRUE) && (ha->cmd_in_progress == scb->cdb[0])) {
		ha->waitflag = FALSE;

		return;
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/media/video/cpia_pp.c:522:cpia_pp_streamRead: 
NOTE:DEREF: Checking arg buffer [EXAMPLE=struct cpia_camera_ops.streamRead-1]
/home/kash/interface/linux-2.6.3/drivers/media/video/cpia_usb.c:412:cpia_usb_streamRead: 
ERROR:DEREF: Not checking arg frame [COUNTER=struct 
cpia_camera_ops.streamRead-1] [fit=5] [fit_fn=1] [fn_ex=0] [fn_counter=1] 
[ex=1] [counter=1] [z = -2.91998558035372] [fn-z = -4.35889894354067]
	if (mybuff->status != FRAME_READY || mybuff->length < 4) {
		DBG("Something went wrong!\n");
		return -1;
	}


Error --->
	memcpy(frame, mybuff->data, mybuff->length);
	mybuff->status = FRAME_EMPTY;

/*   DBG("read done, %d bytes, Header: %x/%x, Footer: %x%x%x%x\n",  */
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/char/vt.c:2407:con_start: 
NOTE:DEREF: Checking arg tty [EXAMPLE=struct tty_operations.start-0]
/home/kash/interface/linux-2.6.3/drivers/char/rocket.c:1541:rp_start: 
ERROR:DEREF: Not checking arg tty [COUNTER=struct tty_operations.start-0] 
[fit=6] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=1] [counter=1] [z = 
-2.91998558035372] [fn-z = -4.35889894354067]
		sDisTransmit(&info->channel);
}

static void rp_start(struct tty_struct *tty)
{

Error --->
	struct r_port *info = (struct r_port *) tty->driver_data;

#ifdef ROCKET_DEBUG_FLOW
	printk(KERN_INFO "start %s: %d %d....\n", tty->name,
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/pci/hotplug/ibmphp_core.c:290:get_latch_status: 
NOTE:DEREF: Checking arg value [EXAMPLE=struct 
hotplug_slot_ops.get_latch_status-1]
/home/kash/interface/linux-2.6.3/drivers/pci/hotplug/cpqphp_core.c:778:get_latch_status: 
ERROR:DEREF: Not checking arg value [COUNTER=struct 
hotplug_slot_ops.get_latch_status-1] [fit=4] [fit_fn=1] [fn_ex=0] 
[fn_counter=1] [ex=1] [counter=1] [z = -2.91998558035372] [fn-z = 
-4.35889894354067]

	ctrl = slot->ctrl;
	if (ctrl == NULL)
		return -ENODEV;
	

Error --->
	*value = cpq_get_latch_status (ctrl, slot);

	return 0;
}
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/message/fusion/mptscsih.c:2331:mptscsih_proc_info: 
NOTE:DEREF: Checking arg start [EXAMPLE=struct scsi_host_template.proc_info-2]
/home/kash/interface/linux-2.6.3/drivers/usb/storage/scsiglue.c:298:proc_info: 
ERROR:DEREF: Not checking arg start [COUNTER=struct 
scsi_host_template.proc_info-2] [fit=26] [fit_fn=2] [fn_ex=0] 
[fn_counter=1] [ex=3] [counter=2] [z = -3.59092423229804] [fn-z = 
-4.35889894354067]
	}

	/*
	 * Calculate start of next buffer, and return value.
	 */

Error --->
	*start = buffer + offset;

	if ((pos - buffer) < offset)
		return (0);
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/message/fusion/mptscsih.c:2331:mptscsih_proc_info: 
NOTE:DEREF: Checking arg start [EXAMPLE=struct scsi_host_template.proc_info-2]
/home/kash/interface/linux-2.6.3/drivers/scsi/wd7000.c:1414:wd7000_proc_info: 
ERROR:DEREF: Not checking arg start [COUNTER=struct 
scsi_host_template.proc_info-2] [fit=26] [fit_fn=1] [fn_ex=0] 
[fn_counter=1] [ex=3] [counter=2] [z = -3.59092423229804] [fn-z = 
-4.35889894354067]
	spin_unlock_irqrestore(host->host_lock, flags);

	/*
	 * Calculate start of next buffer, and return value.
	 */

Error --->
	*start = buffer + offset;

	if ((pos - buffer) < offset)
		return (0);
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/usb/serial/belkin_sa.c:389:belkin_sa_set_termios: 
NOTE:DEREF: Checking arg old_termios [EXAMPLE=struct 
usb_serial_device_type.set_termios-1]
/home/kash/interface/linux-2.6.3/drivers/usb/serial/digi_acceleport.c:1003:digi_set_termios: 
ERROR:DEREF: Not checking arg old_termios [COUNTER=struct 
usb_serial_device_type.set_termios-1] [fit=28] [fit_fn=3] [fn_ex=0] 
[fn_counter=1] [ex=5] [counter=3] [z = -4.21775694939982] [fn-z = 
-4.35889894354067]
{

	struct digi_port *priv = usb_get_serial_port_data(port);
	unsigned int iflag = port->tty->termios->c_iflag;
	unsigned int cflag = port->tty->termios->c_cflag;

Error --->
	unsigned int old_iflag = old_termios->c_iflag;
	unsigned int old_cflag = old_termios->c_cflag;
	unsigned char buf[32];
	unsigned int modem_signals;
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/usb/serial/belkin_sa.c:389:belkin_sa_set_termios: 
NOTE:DEREF: Checking arg old_termios [EXAMPLE=struct 
usb_serial_device_type.set_termios-1]
/home/kash/interface/linux-2.6.3/drivers/usb/serial/mct_u232.c:701:mct_u232_set_termios: 
ERROR:DEREF: Not checking arg old_termios [COUNTER=struct 
usb_serial_device_type.set_termios-1] [fit=28] [fit_fn=1] [fn_ex=0] 
[fn_counter=1] [ex=5] [counter=3] [z = -4.21775694939982] [fn-z = 
-4.35889894354067]
{
	struct usb_serial *serial = port->serial;
	struct mct_u232_private *priv = usb_get_serial_port_data(port);
	unsigned int iflag = port->tty->termios->c_iflag;
	unsigned int cflag = port->tty->termios->c_cflag;

Error --->
	unsigned int old_cflag = old_termios->c_cflag;
	unsigned long flags;
	unsigned int control_state, new_state;
	unsigned char last_lcr;
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/usb/serial/belkin_sa.c:389:belkin_sa_set_termios: 
NOTE:DEREF: Checking arg old_termios [EXAMPLE=struct 
usb_serial_device_type.set_termios-1]
/home/kash/interface/linux-2.6.3/drivers/usb/serial/kl5kusb105.c:735:klsi_105_set_termios: 
ERROR:DEREF: Not checking arg old_termios [COUNTER=struct 
usb_serial_device_type.set_termios-1] [fit=28] [fit_fn=2] [fn_ex=0] 
[fn_counter=1] [ex=5] [counter=3] [z = -4.21775694939982] [fn-z = 
-4.35889894354067]
				  struct termios *old_termios)
{
	struct usb_serial *serial = port->serial;
	struct klsi_105_private *priv = usb_get_serial_port_data(port);
	unsigned int iflag = port->tty->termios->c_iflag;

Error --->
	unsigned int old_iflag = old_termios->c_iflag;
	unsigned int cflag = port->tty->termios->c_cflag;
	unsigned int old_cflag = old_termios->c_cflag;
	struct klsi_105_port_settings cfg;
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/pci/hotplug/ibmphp_core.c:265:get_attention_status: 
NOTE:DEREF: Checking arg value [EXAMPLE=struct 
hotplug_slot_ops.get_attention_status-1]
/home/kash/interface/linux-2.6.3/drivers/pci/hotplug/cpci_hotplug_core.c:238:get_attention_status: 
ERROR:DEREF: Not checking arg value [COUNTER=struct 
hotplug_slot_ops.get_attention_status-1] [fit=31] [fit_fn=2] [fn_ex=0] 
[fn_counter=1] [ex=1] [counter=2] [z = -4.90076972114066] [fn-z = 
-4.35889894354067]
{
	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);

	if(slot == NULL)
		return -ENODEV;

Error --->
	*value = cpci_get_attention_status(slot);
	return 0;
}

---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/pci/hotplug/ibmphp_core.c:265:get_attention_status: 
NOTE:DEREF: Checking arg value [EXAMPLE=struct 
hotplug_slot_ops.get_attention_status-1]
/home/kash/interface/linux-2.6.3/drivers/pci/hotplug/cpqphp_core.c:760:get_attention_status: 
ERROR:DEREF: Not checking arg value [COUNTER=struct 
hotplug_slot_ops.get_attention_status-1] [fit=31] [fit_fn=1] [fn_ex=0] 
[fn_counter=1] [ex=1] [counter=2] [z = -4.90076972114066] [fn-z = 
-4.35889894354067]

	ctrl = slot->ctrl;
	if (ctrl == NULL)
		return -ENODEV;
	

Error --->
	*value = cpq_get_attention_status(ctrl, slot);
	return 0;
}

---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/pci/hotplug/ibmphp_core.c:314:get_power_status: 
NOTE:DEREF: Checking arg value [EXAMPLE=struct 
hotplug_slot_ops.get_power_status-1]
/home/kash/interface/linux-2.6.3/drivers/pci/hotplug/cpci_hotplug_core.c:227:get_power_status: 
ERROR:DEREF: Not checking arg value [COUNTER=struct 
hotplug_slot_ops.get_power_status-1] [fit=29] [fit_fn=1] [fn_ex=0] 
[fn_counter=1] [ex=1] [counter=2] [z = -4.90076972114066] [fn-z = 
-4.35889894354067]
{
	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);

	if(slot == NULL)
		return -ENODEV;

Error --->
	*value = cpci_get_power_status(slot);
	return 0;
}

---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/acpi/dispatcher/dswload.c:637:acpi_ds_load2_begin_op: 
NOTE:DEREF: Checking arg out_op [EXAMPLE=struct 
acpi_walk_state.descending_callback-1]
/home/kash/interface/linux-2.6.3/drivers/acpi/dispatcher/dswexec.c:220:acpi_ds_exec_begin_op: 
ERROR:DEREF: Not checking arg out_op [COUNTER=struct 
acpi_walk_state.descending_callback-1] [fit=30] [fit_fn=1] [fn_ex=0] 
[fn_counter=1] [ex=1] [counter=2] [z = -4.90076972114066] [fn-z = 
-4.35889894354067]
		status = acpi_ds_load2_begin_op (walk_state, out_op);
		if (ACPI_FAILURE (status)) {
			return_ACPI_STATUS (status);
		}


Error --->
		op = *out_op;
		walk_state->op = op;
		walk_state->opcode = op->common.aml_opcode;
		walk_state->op_info = acpi_ps_get_opcode_info (op->common.aml_opcode);
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/pci/hotplug/ibmphp_core.c:314:get_power_status: 
NOTE:DEREF: Checking arg value [EXAMPLE=struct 
hotplug_slot_ops.get_power_status-1]
/home/kash/interface/linux-2.6.3/drivers/pci/hotplug/cpqphp_core.c:742:get_power_status: 
ERROR:DEREF: Not checking arg value [COUNTER=struct 
hotplug_slot_ops.get_power_status-1] [fit=29] [fit_fn=2] [fn_ex=0] 
[fn_counter=1] [ex=1] [counter=2] [z = -4.90076972114066] [fn-z = 
-4.35889894354067]

	ctrl = slot->ctrl;
	if (ctrl == NULL)
		return -ENODEV;
	

Error --->
	*value = get_slot_enabled(ctrl, slot);
	return 0;
}

---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/acpi/dispatcher/dswload.c:637:acpi_ds_load2_begin_op: 
NOTE:DEREF: Checking arg out_op [EXAMPLE=struct 
acpi_walk_state.descending_callback-1]
/home/kash/interface/linux-2.6.3/drivers/acpi/dispatcher/dswload.c:151:acpi_ds_load1_begin_op: 
ERROR:DEREF: Not checking arg out_op [COUNTER=struct 
acpi_walk_state.descending_callback-1] [fit=30] [fit_fn=2] [fn_ex=0] 
[fn_counter=1] [ex=1] [counter=2] [z = -4.90076972114066] [fn-z = 
-4.35889894354067]
				acpi_os_printf ("\n\n***EXECUTABLE OPCODE %s***\n\n", 
walk_state->op_info->name);
				*out_op = op;
				return (AE_CTRL_SKIP);
			}
#endif

Error --->
			*out_op = op;
			return (AE_OK);
		}


