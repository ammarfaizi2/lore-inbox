Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267090AbTA0B0d>; Sun, 26 Jan 2003 20:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267094AbTA0B0d>; Sun, 26 Jan 2003 20:26:33 -0500
Received: from smtp1.Stanford.EDU ([171.64.14.23]:30608 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S267090AbTA0B0K>; Sun, 26 Jan 2003 20:26:10 -0500
From: "Yichen Xie" <yxie@cs.stanford.edu>
To: <linux-kernel@vger.kernel.org>
Cc: <mc@cs.stanford.edu>
Subject: [CHECKER] 87 potential array bounds error/buffer overruns in 2.5.53
Date: Sun, 26 Jan 2003 17:35:22 -0800
Message-ID: <000001c2c5a4$5c4465d0$09830c80@stanfordja31z2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Attached are 87 potential buffer overruns in 2.5.53. Most arise from
improper bounds checks, and some might be security holes where the array
index comes from an untrusted source (e.g. copy_from_user). In the bug
report, "len" refers to the length of the array or buffer being
accessed, and "off" refers to the offset/index that is being used to
access it. (off >= len) corresponds to a buffer overrun, while (off < 0)
signals an underrun.

As always, confirmations and comments will be appreciated.

Yichen

############################################################
# buffer specific errors
#
---------------------------------------------------------
[BUG] cmd array has size 2 (might be false positive, if cmd is used as a
buffer)
/home/yxie/linux-2.5.53/drivers/char/ip2/i2cmd.c:205:i2cmdUnixFlags:
ERROR:BUFFER:205:205:Array bounds error (off >= len) ((*pCM).cmd[2], len
= 2, off = 2, min(off-len) = 0) 
i2cmdUnixFlags(unsigned short iflag,unsigned short cflag,unsigned short
lflag)
{
	cmdSyntaxPtr pCM = (cmdSyntaxPtr) ct47;

	pCM->cmd[1] = (unsigned char)  iflag;

Error --->
	pCM->cmd[2] = (unsigned char) (iflag >> 8);
	pCM->cmd[3] = (unsigned char)  cflag;
	pCM->cmd[4] = (unsigned char) (cflag >> 8);
	pCM->cmd[5] = (unsigned char)  lflag;
---------------------------------------------------------
[BUG]
/home/yxie/linux-2.5.53/drivers/char/rio/riocmd.c:453:RIOCommandRup:
ERROR:BUFFER:453:453:Array bounds error (off >= len)
((*HostP).Mapping[Rup], len = 16, off = sym_16858822, min(off-len) = 0) 
			     HostP-p->RIOHosts, HostP->Name );
		rio_dprintk (RIO_DEBUG_CMD, "CONTROL information: Rup
number  0x%x\n", rup);

		if ( Rup >= (ushort)MAX_RUP ) {
			rio_dprintk (RIO_DEBUG_CMD, "CONTROL
information: This is the RUP for RTA ``%s''\n",

Error --->
				     HostP->Mapping[Rup].Name);
		} else
			rio_dprintk (RIO_DEBUG_CMD, "CONTROL
information: This is the RUP for link ``%c'' of host ``%s''\n", 
				     ('A' + Rup - MAX_RUP),
HostP->Name);
---------------------------------------------------------
[BUG] what if the for loop above ends with i = 0?
/home/yxie/linux-2.5.53/sound/oss/sb_card.c:890:sb_isapnp_probe:
ERROR:BUFFER:890:890:Array bounds error (off < 0) (sb_isapnp_list[i],
max(off) = -1) 
	}

	if(!first || !reverse)
		i = isapnpjump;
	first = 0;

Error --->
	while(sb_isapnp_list[i].card_vendor != 0) {
		static struct pci_bus *bus = NULL;

		while ((bus = isapnp_find_card(
---------------------------------------------------------
[BUG]
/home/yxie/linux-2.5.53/drivers/pcmcia/i82092.c:389:card_present:
ERROR:BUFFER:389:389:Array bounds error (off >= len) [RANGE]
(sockets[socketno], len = 4, off = sym_34899870, max(off-len) = 0) 
	unsigned int val;
	enter("card_present");
	
	if ((socketno<0) || (socketno > MAX_SOCKETS))
		return 0;

Error --->
	if (sockets[socketno].io_base == 0)
		return 0;

		
---------------------------------------------------------
[BUG] domain of first dimension of sis300_filter2 is 10, but temp is set
to 18 above
/home/yxie/linux-2.5.53/drivers/video/sis/init301.c:8267:SetOEMYFilter:
ERROR:BUFFER:8267:8267:Array bounds error (off >= len)
(SiS300_Filter2[(int)temp], len = 10, off = 18, min(off-len) = 8) 
	  if(temp1 & EnablePALN) temp = 18;
       }
  }
  if(SiS_VBType & VB_SIS301BLV302BLV) {
      for(i=0x35, j=0; i<=0x38; i++, j++) {

Error --->
       	SiS_SetReg1(Part2Port,i,SiS300_Filter2[temp][index][j]);
      }
      for(i=0x48; i<=0x4A; i++, j++) {
     	SiS_SetReg1(Part2Port,i,SiS300_Filter2[temp][index][j]);
---------------------------------------------------------
[BUG]
/home/yxie/linux-2.5.53/drivers/char/rio/rioboot.c:881:RIOBootComplete:
ERROR:BUFFER:881:881:Array bounds error (off >= len)
((*HostP).Mapping[Rup], len = 16, off = sym_13816603, min(off-len) = 0) 
		** chance to boot it.
		*/
		WWORD(HostP->LinkStrP[MyLink].WaitNoBoot, 30);
	    }
	    rio_dprintk (RIO_DEBUG_BOOT, "RTA %x not owned - suspend
booting down link %c on unit %x\n",

Error --->
	      RtaUniq, 'A' + MyLink, HostP->Mapping[Rup].RtaUniqueNum);
	    return TRUE;
	}

---------------------------------------------------------
[BUG]
/home/yxie/linux-2.5.53/drivers/message/fusion/mptbase.c:4939:procmpt_cr
eate: ERROR:BUFFER:4939:4939:Array bounds error (off >= len)
(mpt_ioc_proc_list[ii], len = 2, off = 2, min(off-len) = 0) 
				}
				ent->read_proc =
mpt_ioc_proc_list[ii].f;
				ent->data      = ioc;
			}
		} else {

Error --->
			printk(MYIOC_s_WARN_FMT "Could not create
/proc/mpt/%s subdir entry!\n",
					ioc->name,
mpt_ioc_proc_list[ii].name);
		}
		ioc = mpt_adapter_find_next(ioc);
---------------------------------------------------------
[BUG]
/home/yxie/linux-2.5.53/drivers/isdn/i4l/isdn_common.c:1709:isdn_ctrl_io
ctl: ERROR:BUFFER:1709:1709:Array bounds error (off >= len)
(iocpar.bname[j], len = 20, off = 20, min(off-len) = 0) 
					int j = 0;

					while (1) {
						if ((ret =
verify_area(VERIFY_READ, p, 1)))
							return ret;

Error --->
						get_user(bname[j], p++);
						switch (bname[j]) {
						case '\0':
							loop = 0;
---------------------------------------------------------
[BUG] need one more element in ZeroAddr
/home/yxie/linux-2.5.53/drivers/net/sk98lin/skxmac2.c:424:SkXmClrSrcChec
k: ERROR:BUFFER:424:424:Array bounds error (off >= len) (*pByte + 6, len
= 6, off = 6, min(off-len) = 0) 
SK_IOC	IoC,	/* IO context */
int		Port)	/* The XMAC to handle with belongs to this Port
(MAC_1 + n) */
{
	SK_U16	ZeroAddr[3] = {0x0000, 0x0000, 0x0000};


Error --->
	XM_OUTHASH(IoC, Port, XM_SRC_CHK, &ZeroAddr);
}	/* SkXmClrSrcCheck */


---------------------------------------------------------
[BUG]
/home/yxie/linux-2.5.53/drivers/block/DAC960.c:1746:DAC960_V2_ReadContro
llerConfiguration: ERROR:BUFFER:1746:1746:Array bounds error (off >=
len) [RANGE]
((*Controller).LogicalDriveInitiallyAccessible[(int)LogicalDeviceNumber]
, len = 32, off = sym_30754894, max(off-len) = 0) 
      PhysicalDevice.LogicalUnit = NewLogicalDeviceInfo->LogicalUnit;
      Controller->V2.LogicalDriveToVirtualDevice[LogicalDeviceNumber] =
	PhysicalDevice;
      if (NewLogicalDeviceInfo->LogicalDeviceState !=
	  DAC960_V2_LogicalDevice_Offline)

Error --->
	Controller->LogicalDriveInitiallyAccessible[LogicalDeviceNumber]
= true;
      LogicalDeviceInfo = (DAC960_V2_LogicalDeviceInfo_T *)
	kmalloc(sizeof(DAC960_V2_LogicalDeviceInfo_T), GFP_ATOMIC);
      if (LogicalDeviceInfo == NULL)
---------------------------------------------------------
[BUG]
/home/yxie/linux-2.5.53/drivers/isdn/hardware/eicon/diva.c:573:diva_xdi_
display_adapter_features: ERROR:BUFFER:573:573:Array bounds error (off
>= len) [RANGE] (IoAdapters[card], len = 32, off = (sym_39527244, 1, -1,
1), max(off-len) = 0) 
	dword features;
	if (!card || ((card - 1) > MAX_ADAPTER) || !IoAdapters[card -
1]) {
		return;
	}
	card--;

Error --->
	features = IoAdapters[card]->Properties.Features;

	DBG_LOG(("FEATURES FOR ADAPTER: %d", card + 1))
	DBG_LOG((" DI_FAX3          :  %s",
---------------------------------------------------------
[BUG] card_idx checked against MAX_UNITS above, but didn't bail out on
error
/home/yxie/linux-2.5.53/drivers/net/3c59x.c:1343:vortex_probe1:
ERROR:BUFFER:1343:1343:Array bounds error (off >= len)
(hw_checksums[card_idx], len = 8, off = sym_20419785, min(off-len) = 0) 
	dev->open = vortex_open;
	if (vp->full_bus_master_tx) {
		dev->hard_start_xmit = boomerang_start_xmit;
		/* Actually, it still should work with iommu. */
		dev->features |= NETIF_F_SG;

Error --->
		if (((hw_checksums[card_idx] == -1) && (vp->drv_flags &
HAS_HWCKSM)) ||
					(hw_checksums[card_idx] == 1)) {
				dev->features |= NETIF_F_IP_CSUM;
		}
---------------------------------------------------------
[BUG] "old" might get garbage on the stack
/home/yxie/linux-2.5.53/fs/devfs/base.c:1179:_devfs_make_parent_for_leaf
: ERROR:BUFFER:1179:1179:Dereferencing uninitialized pointer (*old)
evaluated in the following state 
	    de = _devfs_alloc_entry (name, next_pos, MODE_DIR);
	    devfs_get (de);
	    if ( !de || _devfs_append_entry (dir, de, FALSE, &old) )
	    {
		devfs_put (de);

Error --->
		if ( !old || !S_ISDIR (old->mode) )
		{
		    devfs_put (old);
		    devfs_put (dir);
---------------------------------------------------------
[BUG]
/home/yxie/linux-2.5.53/drivers/hotplug/ibmphp_pci.c:1630:ibmphp_unconfi
gure_card: ERROR:BUFFER:1630:1630:Array bounds error (off >= len)
((*cur_func).mem[count], len = 6, off = 6, min(off-len) = 0) 
					debug ("io[%d] exists \n",
count);
					if (the_end > 0)
						ibmphp_remove_resource
(cur_func->io[count]);
					cur_func->io[count] = NULL;
				}

Error --->
				if (cur_func->mem[count]) {
					debug ("mem[%d] exists \n",
count);
					if (the_end > 0)
						ibmphp_remove_resource
(cur_func->mem[count]);
---------------------------------------------------------
[BUG] what if i = 255?
/home/yxie/linux-2.5.53/drivers/net/tg3.c:5857:tg3_read_partno:
ERROR:BUFFER:5857:5857:Array bounds error (off >= len) [RANGE]
(vpd_data[i + 2], len = 256, off = (sym_8147517, 1, 2, 1), max(off-len)
= 1) 
	for (i = 0; i < 256; ) {
		unsigned char val = vpd_data[i];
		int block_end;

		if (val == 0x82 || val == 0x91) {

Error --->
			i = (i + 3 +
			     (vpd_data[i + 1] +
			      (vpd_data[i + 2] << 8)));
			continue;
---------------------------------------------------------
[BUG] should be >= TACH_SEST_LEN
/home/yxie/linux-2.5.53/drivers/scsi/cpqfcTSworker.c:557:cpqfcTS_WorkTas
k: ERROR:BUFFER:557:557:Array bounds error (off >= len) [RANGE]
((*(*fcChip).SEST).u[x_ID], len = 512, off = sym_18059005, max(off-len)
= 0) 
      // requested the abort.


	  
      // clear bit 31 (VALid), to invalidate & take control from TL

Error --->
      fcChip->SEST->u[ x_ID].IWE.Hdr_Len &= 0x7FFFFFFF;


      // examine and Tach's "Linked List" for IWEs that 
---------------------------------------------------------
[BUG]
/home/yxie/linux-2.5.53/drivers/scsi/aacraid/aachba.c:1166:delete_disk:
ERROR:BUFFER:1166:1166:Array bounds error (off >= len) [RANGE]
((*fsa_dev_ptr).valid[dd.cnum], len = 31, off = sym_14786346,
max(off-len) = 0) 
		return -EBUSY;
	else {
		/*
		 *	Mark the container as no longer being valid.
		 */

Error --->
		fsa_dev_ptr->valid[dd.cnum] = 0;
		fsa_dev_ptr->devname[dd.cnum][0] = '\0';
		return 0;
	}
---------------------------------------------------------
[BUG]
/home/yxie/linux-2.5.53/drivers/isdn/hardware/eicon/diva.c:569:diva_xdi_
display_adapter_features: ERROR:BUFFER:569:569:Array bounds error (off
>= len) [RANGE] (IoAdapters[card - 1], len = 32, off = (sym_39527244, 1,
-1, 1), max(off-len) = 0) 
}

void diva_xdi_display_adapter_features(int card)
{
	dword features;

Error --->
	if (!card || ((card - 1) > MAX_ADAPTER) || !IoAdapters[card -
1]) {
		return;
	}
	card--;
---------------------------------------------------------
[BUG]
/home/yxie/linux-2.5.53/drivers/block/DAC960.c:1742:DAC960_V2_ReadContro
llerConfiguration: ERROR:BUFFER:1742:1742:Array bounds error (off >=
len) [RANGE]
((*Controller).FW.V2.LogicalDriveToVirtualDevice[(int)LogicalDeviceNumbe
r], len = 32, off = sym_30754894, max(off-len) = 0) 
	      NewLogicalDeviceInfo->DeviceBlockSizeInBytes);
      PhysicalDevice.Controller = 0;
      PhysicalDevice.Channel = NewLogicalDeviceInfo->Channel;
      PhysicalDevice.TargetID = NewLogicalDeviceInfo->TargetID;
      PhysicalDevice.LogicalUnit = NewLogicalDeviceInfo->LogicalUnit;

Error --->
      Controller->V2.LogicalDriveToVirtualDevice[LogicalDeviceNumber] =
	PhysicalDevice;
      if (NewLogicalDeviceInfo->LogicalDeviceState !=
	  DAC960_V2_LogicalDevice_Offline)
---------------------------------------------------------
[BUG] i or count?
/home/yxie/linux-2.5.53/drivers/hotplug/ibmphp_pci.c:1624:ibmphp_unconfi
gure_card: ERROR:BUFFER:1624:1624:Array bounds error (off >= len)
((*cur_func).io[count], len = 6, off = 6, min(off-len) = 0) 
			} else {
				count = 6;
			}

			for (i = 0; i < count; i++) {

Error --->
				if (cur_func->io[count]) {
					debug ("io[%d] exists \n",
count);
					if (the_end > 0)
						ibmphp_remove_resource
(cur_func->io[count]);
---------------------------------------------------------
[BUG]
/home/yxie/linux-2.5.53/arch/i386/pci/numa.c:53:__pci_conf1_mq_write:
ERROR:BUFFER:53:53:Array bounds error (off >= len) [RANGE]
(mp_bus_id_to_local[bus], len = 32, off = sym_42073848, max(off-len) =
223) 
	if ((bus > 255) || (dev > 31) || (fn > 7) || (reg > 255)) 
		return -EINVAL;

	spin_lock_irqsave(&pci_config_lock, flags);


Error --->
	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8,
BUS2QUAD(bus));

	switch (len) {
	case 1:
---------------------------------------------------------
[BUG]
/home/yxie/linux-2.5.53/drivers/input/keyboard/sunkbd.c:271:sunkbd_conne
ct: ERROR:BUFFER:271:271:Array bounds error (off >= len) [RANGE]
((*sunkbd).keycode[i], len = 128, off = sym_44382539, max(off-len) =
126) 

	sprintf(sunkbd->name, "Sun Type %d keyboard", sunkbd->type);

	memcpy(sunkbd->keycode, sunkbd_keycode,
sizeof(sunkbd->keycode));
	for (i = 0; i < 255; i++)

Error --->
		set_bit(sunkbd->keycode[i], sunkbd->dev.keybit);
	clear_bit(0, sunkbd->dev.keybit);

	sprintf(sunkbd->name, "%s/input", serio->phys);
---------------------------------------------------------
[BUG] length of vendorId is 8
/home/yxie/linux-2.5.53/drivers/scsi/psi240i.c:334:Irq_Handler:
ERROR:BUFFER:334:334:Array bounds error (off >= len)
((*pinquiryData).VendorId[z], len = 8, off = 8, min(off-len) = 0) 
				pinquiryData->AdditionalLength = 35 - 4;

				// Fill in vendor identification fields.
				for ( z = 0;  z < 20;  z += 2 )
					{

Error --->
					pinquiryData->VendorId[z]
= ((UCHAR *)identifyData.ModelNumber)[z + 1];
					pinquiryData->VendorId[z + 1] =
((UCHAR *)identifyData.ModelNumber)[z];
					}

---------------------------------------------------------
[BUG] temp too big; len of the array is just 10
/home/yxie/linux-2.5.53/drivers/video/sis/init301.c:8274:SetOEMYFilter:
ERROR:BUFFER:8274:8274:Array bounds error (off >= len)
(SiS300_Filter1[(int)temp], len = 10, off = 18, min(off-len) = 8) 
      for(i=0x48; i<=0x4A; i++, j++) {
     	SiS_SetReg1(Part2Port,i,SiS300_Filter2[temp][index][j]);
      }
  } else {
      for(i=0x35, j=0; i<=0x38; i++, j++) {

Error --->
       	SiS_SetReg1(Part2Port,i,SiS300_Filter1[temp][index][j]);
      }
  }
}
---------------------------------------------------------
[BUG]
/home/yxie/linux-2.5.53/drivers/char/ip2/i2cmd.c:207:i2cmdUnixFlags:
ERROR:BUFFER:207:207:Array bounds error (off >= len) ((*pCM).cmd[4], len
= 2, off = 4, min(off-len) = 2) 
	cmdSyntaxPtr pCM = (cmdSyntaxPtr) ct47;

	pCM->cmd[1] = (unsigned char)  iflag;
	pCM->cmd[2] = (unsigned char) (iflag >> 8);
	pCM->cmd[3] = (unsigned char)  cflag;

Error --->
	pCM->cmd[4] = (unsigned char) (cflag >> 8);
	pCM->cmd[5] = (unsigned char)  lflag;
	pCM->cmd[6] = (unsigned char) (lflag >> 8);
	return pCM;
---------------------------------------------------------
[BUG]
/home/yxie/linux-2.5.53/drivers/scsi/aacraid/aachba.c:1141:force_delete_
disk: ERROR:BUFFER:1141:1141:Array bounds error (off >= len) [RANGE]
((*fsa_dev_ptr).valid[dd.cnum], len = 31, off = sym_14786353,
max(off-len) = 0) 
	 */
	fsa_dev_ptr->deleted[dd.cnum] = 1;
	/*
	 *	Mark the container as no longer valid
	 */

Error --->
	fsa_dev_ptr->valid[dd.cnum] = 0;
	return 0;
}

---------------------------------------------------------
[BUG] [SEC] off-by-one
/home/yxie/linux-2.5.53/drivers/char/riscom8.c:1093:rc_open:
ERROR:BUFFER:1093:1093:Array bounds error (off >= len) [RANGE]
(rc_board[board], len = 4, off = sym_14830233, max(off-len) = 0) 
	struct riscom_port * port;
	struct riscom_board * bp;
	unsigned long flags;
	
	board = RC_BOARD(minor(tty->device));

Error --->
	if (board > RC_NBOARD || !(rc_board[board].flags &
RC_BOARD_PRESENT))
		return -ENODEV;
	
	bp = &rc_board[board];
---------------------------------------------------------
[BUG] off-by-one
/home/yxie/linux-2.5.53/net/irda/qos.c:728:irlap_max_line_capacity:
ERROR:BUFFER:728:728:Array bounds error (off >= len) [RANGE]
(max_line_capacities[i][j], len = 4, off = sym_3973899, max(off-len) =
0) 
	j = value_index(max_turn_time, max_turn_times, 4);

	ASSERT(((i >=0) && (i <=10)), return 0;);
	ASSERT(((j >=0) && (j <=4)), return 0;);


Error --->
	line_capacity = max_line_capacities[i][j];

	IRDA_DEBUG(2, "%s(), line capacity=%d bytes\n", 
		   __FUNCTION__, line_capacity);
---------------------------------------------------------
[BUG] i = 128 j = 10, sizeof(start_code) = 138, not a multiple of 32
/home/yxie/linux-2.5.53/drivers/net/eexpress.c:1470:eexp_hw_init586:
ERROR:BUFFER:1470:1470:Array bounds error (off >= len) (start_code[i + j
/ 2], len = 69, off = 69, min(off-len) = 0) 

	for (i = 0; i < (sizeof(start_code)); i+=32) {
		int j;
		outw(i, ioaddr + SM_PTR);
		for (j = 0; j < 16; j+=2)

Error --->
			outw(start_code[(i+j)/2],
			     ioaddr+0x4000+j);
		for (j = 0; j < 16; j+=2)
			outw(start_code[(i+j+16)/2],
---------------------------------------------------------
[BUG] off-by-one
/home/yxie/linux-2.5.53/drivers/net/irda/smc-ircc.c:524:ircc_open:
ERROR:BUFFER:524:524:Array bounds error (off >= len) [RANGE]
(dev_self[(int)dev_count], len = 2, off = sym_31672470, max(off-len) =
0) 

	memset(self->rx_buff.head, 0, self->rx_buff.truesize);
	memset(self->tx_buff.head, 0, self->tx_buff.truesize);
   
	/* Need to store self somewhere */

Error --->
	dev_self[dev_count++] = self;

	/* Steal the network device from irport */
	self->netdev = irport->netdev;
---------------------------------------------------------
[BUG] off-by-one
/home/yxie/linux-2.5.53/net/core/rtnetlink.c:311:rtnetlink_rcv_msg:
ERROR:BUFFER:311:311:Array bounds error (off >= len) [RANGE]
(rtnetlink_links[family], len = 32, off = sym_38788183, max(off-len) =
0) 
	if (family > NPROTO) {
		*errp = -EAFNOSUPPORT;
		return -1;
	}


Error --->
	link_tab = rtnetlink_links[family];
	if (link_tab == NULL)
		link_tab = rtnetlink_links[PF_UNSPEC];
	link = &link_tab[type];
---------------------------------------------------------
[BUG] missing comma in definition of split_status_strings
/home/yxie/linux-2.5.53/drivers/scsi/aic7xxx/aic79xx_pci.c:808:ahd_pci_s
plit_intr: ERROR:BUFFER:808:808:Array bounds error (off >= len) [RANGE]
(split_status_strings[bit], len = 7, off = sym_42005934, max(off-len) =
0) 
		for (bit = 0; bit < 8; bit++) {

			if ((split_status[i] & (0x1 << bit)) != 0) {
				static const char *s;


Error --->
				s = split_status_strings[bit];
				printf(s, ahd_name(ahd),
				       split_status_source[i]);
			}
---------------------------------------------------------
[BUG] off-by-one
/home/yxie/linux-2.5.53/drivers/char/sx.c:1694:sx_fw_ioctl:
ERROR:BUFFER:1694:1694:Array bounds error (off >= len) [RANGE]
(boards[arg], len = 4, off = sym_36474475, max(off-len) = 0) 
	switch (cmd) {
	case SXIO_SET_BOARD:
		sx_dprintk (SX_DEBUG_FIRMWARE, "set board to %ld\n",
arg);
		if (arg > SX_NBOARDS) return -EIO;
		sx_dprintk (SX_DEBUG_FIRMWARE, "not out of range\n");

Error --->
		if (!(boards[arg].flags	& SX_BOARD_PRESENT)) return
-EIO;
		sx_dprintk (SX_DEBUG_FIRMWARE, ".. and present!\n");
		board = &boards[arg];
		break;
---------------------------------------------------------
[BUG] off-by-one
/home/yxie/linux-2.5.53/drivers/media/dvb/av7110/av7110.c:3253:StopHWFil
ter: ERROR:BUFFER:3253:3253:Array bounds error (off >= len) [RANGE]
((*av7110).handle2filter[(int)handle], len = 32, off = sym_16476028,
max(off-len) = 0) 
                       handle);
                dprintk("dvb: filter type = %d\n",  dvbdmxfilter->type);
                return 0;
        }


Error --->
        av7110->handle2filter[handle]=NULL;

        buf[0] = (COMTYPE_PID_FILTER << 8) + DelPIDFilter; 
        buf[1] = 1;	
---------------------------------------------------------
[BUG] might have forgotten to >>4
/home/yxie/linux-2.5.53/drivers/message/i2o/i2o_block.c:1518:i2ob_del_de
vice: ERROR:BUFFER:1518:1518:Array bounds error (off >= len)
(i2ob_media_change_flag[unit], len = 16, off = 16, min(off-len) = 0) 

	/* 
	 * Do we need this?
	 * The media didn't really change...the device is just gone
	 */

Error --->
	i2ob_media_change_flag[unit] = 1;

	i2ob_dev_count--;	
}
---------------------------------------------------------
[BUG] off-by-one
/home/yxie/linux-2.5.53/drivers/message/i2o/i2o_block.c:1256:i2ob_init_i
op: ERROR:BUFFER:1256:1256:Array bounds error (off >= len)
((*i2ob_queues[unit]).request_queue[i], len = 8, off = 8, min(off-len) =
0) 
		i2ob_queues[unit]->request_queue[i].next =
&i2ob_queues[unit]->request_queue[i+1];
		i2ob_queues[unit]->request_queue[i].num = i;
	}
	
	/* Queue is MAX_I2OB + 1... */

Error --->
	i2ob_queues[unit]->request_queue[i].next = NULL;
	i2ob_queues[unit]->i2ob_qhead =
&i2ob_queues[unit]->request_queue[0];
	atomic_set(&i2ob_queues[unit]->queue_depth, 0);

---------------------------------------------------------
[BUG] possible, but not sure
/home/yxie/linux-2.5.53/drivers/usb/host/ohci-hub.c:145:ohci_hub_descrip
tor: ERROR:BUFFER:145:145:Array bounds error (off >= len)
((*desc).DeviceRemovable[3], len = 3, off = 3, min(off-len) = 0) 
	/* two bitmaps:  ports removable, and usb 1.0 legacy
PortPwrCtrlMask */
	rh = roothub_b (ohci);
	desc->bitmap [0] = rh & RH_B_DR;
	if (ports > 7) {
		desc->bitmap [1] = (rh & RH_B_DR) >> 8;

Error --->
		desc->bitmap [2] = desc->bitmap [3] = 0xff;
	} else
		desc->bitmap [1] = 0xff;
}
---------------------------------------------------------
[BUG] data[15]?
/home/yxie/linux-2.5.53/drivers/message/i2o/i2o_block.c:733:i2ob_evt:
ERROR:BUFFER:733:733:Array bounds error (off >= len)
((*evt_local).data[16], len = 16, off = 16, min(off-len) = 0) 
			 */
			case I2O_EVT_IND_BSA_SCSI_SMART:
			{
				char buf[16];
				printk(KERN_INFO "I2O Block: %s received
a SCSI SMART Event\n",i2ob_dev[unit].i2odev->dev_name);

Error --->
				evt_local->data[16]='\0';
				sprintf(buf,"%s",&evt_local->data[0]);
				printk(KERN_INFO "      Disk
Serial#:%s\n",buf);
				printk(KERN_INFO "      ASC 0x%02x
\n",evt_local->ASC);
---------------------------------------------------------
[BUG] off-by-one
/home/yxie/linux-2.5.53/drivers/scsi/aacraid/aachba.c:1160:delete_disk:
ERROR:BUFFER:1160:1160:Array bounds error (off >= len) [RANGE]
((*fsa_dev_ptr).locked[dd.cnum], len = 31, off = sym_14786346,
max(off-len) = 0) 
	if (dd.cnum > MAXIMUM_NUM_CONTAINERS)
		return -EINVAL;
	/*
	 *	If the container is locked, it can not be deleted by the
API.
	 */

Error --->
	if (fsa_dev_ptr->locked[dd.cnum])
		return -EBUSY;
	else {
		/*
---------------------------------------------------------
[BUG]
/home/yxie/linux-2.5.53/drivers/hotplug/ibmphp_pci.c:1636:ibmphp_unconfi
gure_card: ERROR:BUFFER:1636:1636:Array bounds error (off >= len)
((*cur_func).pfmem[count], len = 6, off = 6, min(off-len) = 0) 
					debug ("mem[%d] exists \n",
count);
					if (the_end > 0)
						ibmphp_remove_resource
(cur_func->mem[count]);
					cur_func->mem[count] = NULL;
				}

Error --->
				if (cur_func->pfmem[count]) {
					debug ("pfmem[%d] exists \n",
count);
					if (the_end > 0)
						ibmphp_remove_resource
(cur_func->pfmem[count]);
---------------------------------------------------------
[BUG] off-by-one
/home/yxie/linux-2.5.53/drivers/block/DAC960.c:1751:DAC960_V2_ReadContro
llerConfiguration: ERROR:BUFFER:1751:1751:Array bounds error (off >=
len) [RANGE]
((*Controller).FW.V2.LogicalDeviceInformation[(int)LogicalDeviceNumber],
len = 32, off = sym_30754894, max(off-len) = 0) 
	Controller->LogicalDriveInitiallyAccessible[LogicalDeviceNumber]
= true;
      LogicalDeviceInfo = (DAC960_V2_LogicalDeviceInfo_T *)
	kmalloc(sizeof(DAC960_V2_LogicalDeviceInfo_T), GFP_ATOMIC);
      if (LogicalDeviceInfo == NULL)
	return DAC960_Failure(Controller, "LOGICAL DEVICE ALLOCATION");

Error --->
      Controller->V2.LogicalDeviceInformation[LogicalDeviceNumber] =
	LogicalDeviceInfo;
      memcpy(LogicalDeviceInfo, NewLogicalDeviceInfo,
	     sizeof(DAC960_V2_LogicalDeviceInfo_T));
---------------------------------------------------------
[BUG] off-by-one
/home/yxie/linux-2.5.53/drivers/char/specialix.c:2367:specialix_init:
ERROR:BUFFER:2367:2367:Array bounds error (off >= len) (sx_board[i], len
= 8, off = 8, min(off-len) = 0) 
	if (pci_present()) {
		struct pci_dev *pdev = NULL;

		i=0;
		while (i <= SX_NBOARD) {

Error --->
			if (sx_board[i].flags & SX_BOARD_PRESENT) {
				i++;
				continue;
			}
---------------------------------------------------------
[BUG] what if level < 0?
/home/yxie/linux-2.5.53/fs/xfs/xfs_bmap_btree.c:1364:xfs_bmbt_lshift:
ERROR:BUFFER:1364:1364:Array bounds error (off < 0)
((*cur).bc_ptrs[level], max(off) = -1) 
	}
	if ((error = xfs_bmbt_updkey(cur, rkp, level + 1))) {
		XFS_BMBT_TRACE_CURSOR(cur, ERROR);
		return error;
	}

Error --->
	cur->bc_ptrs[level]--;
	XFS_BMBT_TRACE_CURSOR(cur, EXIT);
	*stat = 1;
	return 0;
---------------------------------------------------------
[BUG] macro misuse
/home/yxie/linux-2.5.53/arch/i386/pci/numa.c:25:__pci_conf1_mq_read:
ERROR:BUFFER:25:25:Array bounds error (off >= len) [RANGE]
(mp_bus_id_to_local[bus], len = 32, off = sym_42073871, max(off-len) =
223) 
	if (!value || (bus > 255) || (dev > 31) || (fn > 7) || (reg >
255))
		return -EINVAL;

	spin_lock_irqsave(&pci_config_lock, flags);


Error --->
	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8,
BUS2QUAD(bus));

	switch (len) {
	case 1:
---------------------------------------------------------
[BUG] suspicious
/home/yxie/linux-2.5.53/drivers/char/ip2/i2cmd.c:261:i2cmdBaudDef:
ERROR:BUFFER:261:261:Array bounds error (off >= len) ((*pCM).cmd[2], len
= 2, off = 2, min(off-len) = 0) 
	case 2:
		pCM = (cmdSyntaxPtr) ct55;
		break;
	}
	pCM->cmd[1] = (unsigned char) rate;

Error --->
	pCM->cmd[2] = (unsigned char) (rate >> 8);
	return pCM;
}

---------------------------------------------------------
[BUG]
/home/yxie/linux-2.5.53/drivers/net/tokenring/3c359.c:753:xl_open_hw:
ERROR:BUFFER:753:753:Array bounds error (off >= len)
((*xl_priv).xl_laa[i], len = 6, off = sym_42195646, min(off-len) = 4) 
	 */

	if (xl_priv->xl_laa[0]) {  /* If using a LAA address */
		for (i=10;i<16;i++) { 
			writel( (MEM_BYTE_WRITE | 0xD0000 |
xl_priv->srb) + i, xl_mmio + MMIO_MAC_ACCESS_CMD) ; 

Error --->
			writeb(xl_priv->xl_laa[i],xl_mmio +
MMIO_MACDATA) ; 
		}
		memcpy(dev->dev_addr,xl_priv->xl_laa,dev->addr_len) ; 
	} else { /* Regular hardware address */ 
---------------------------------------------------------
[BUG]
/home/yxie/linux-2.5.53/drivers/media/video/bttv-cards.c:2094:hauppauge_
eeprom: ERROR:BUFFER:2094:2094:Array bounds error (off >= len)
(hauppauge_tuner[tuner], len = 51, off = sym_16089004, min(off-len) = 0)

                btv->tuner_type = hauppauge_tuner[tuner].id;
	if (radio)
		btv->has_radio = 1;
	
	if (bttv_verbose)

Error --->
		printk(KERN_INFO "bttv%d: Hauppauge eeprom: model=%d, "
		       "tuner=%s (%d), radio=%s\n",
		       btv->nr, model, hauppauge_tuner[tuner].name,
		       btv->tuner_type, radio ? "yes" : "no");
---------------------------------------------------------
[BUG] off-by-one
/home/yxie/linux-2.5.53/drivers/char/specialix.c:1459:sx_open:
ERROR:BUFFER:1459:1459:Array bounds error (off >= len) [RANGE]
(sx_board[board], len = 8, off = sym_29947032, max(off-len) = 0) 
	struct specialix_board * bp;
	unsigned long flags;
	
	board = SX_BOARD(minor(tty->device));


Error --->
	if (board > SX_NBOARD || !(sx_board[board].flags &
SX_BOARD_PRESENT))
		return -ENODEV;
	
	bp = &sx_board[board];
---------------------------------------------------------
[BUG] off-by-one
/home/yxie/linux-2.5.53/net/irda/qos.c:728:irlap_max_line_capacity:
ERROR:BUFFER:728:728:Array bounds error (off >= len) [RANGE]
(max_line_capacities[i], len = 10, off = sym_3973897, max(off-len) = 0) 
	j = value_index(max_turn_time, max_turn_times, 4);

	ASSERT(((i >=0) && (i <=10)), return 0;);
	ASSERT(((j >=0) && (j <=4)), return 0;);


Error --->
	line_capacity = max_line_capacities[i][j];

	IRDA_DEBUG(2, "%s(), line capacity=%d bytes\n", 
		   __FUNCTION__, line_capacity);
---------------------------------------------------------
[BUG] should panic after printk
/home/yxie/linux-2.5.53/drivers/scsi/qlogicfc.c:926:isp2x00_make_portdb:
ERROR:BUFFER:926:926:Array bounds error (off >= len)
((*hostdata).port_db[j], len = 256, off = 256, min(off-len) = 0) 
					break;
				}
			}
			if (j == QLOGICFC_MAX_ID + 1)
				printk("qlogicfc%d : Too many scsi
devices, no more room in port map.\n", hostdata->host_id);

Error --->
			if (!hostdata->port_db[j].wwn) {
				hostdata->port_db[j].loop_id =
temp[i].loop_id;
				hostdata->port_db[j].wwn = temp[i].wwn;
			}
---------------------------------------------------------
[BUG]
/home/yxie/linux-2.5.53/arch/i386/kernel/cpu/cpufreq/powernow-k6.c:202:p
owernow_k6_setpolicy: ERROR:BUFFER:202:202:Array bounds error (off >=
len) (clock_ratio[i], len = 8, off = 8, min(off-len) = 0) 
		break;
	default:
		return -EINVAL;
	}


Error --->
	if (clock_ratio[i] > max_multiplier)
		return -EINVAL;

	powernow_k6_set_state(j);
---------------------------------------------------------
[BUG] suspicious, since sizeof cmd is 2 (not 0 or 1, which is commonly
used for buffers)
/home/yxie/linux-2.5.53/drivers/char/ip2/i2cmd.c:209:i2cmdUnixFlags:
ERROR:BUFFER:209:209:Array bounds error (off >= len) ((*pCM).cmd[6], len
= 2, off = 6, min(off-len) = 4) 
	pCM->cmd[1] = (unsigned char)  iflag;
	pCM->cmd[2] = (unsigned char) (iflag >> 8);
	pCM->cmd[3] = (unsigned char)  cflag;
	pCM->cmd[4] = (unsigned char) (cflag >> 8);
	pCM->cmd[5] = (unsigned char)  lflag;

Error --->
	pCM->cmd[6] = (unsigned char) (lflag >> 8);
	return pCM;
}

---------------------------------------------------------
[BUG] off-by-one
/home/yxie/linux-2.5.53/drivers/net/wireless/orinoco.c:3063:orinoco_ioct
l_getrate: ERROR:BUFFER:3063:3063:Array bounds error (off >= len)
(bitrate_table[ratemode], len = 8, off = sym_45223018, min(off-len) = 1)

	ratemode = priv->bitratemode;

	if ( (ratemode < 0) || (ratemode > BITRATE_TABLE_SIZE) )
		BUG();


Error --->
	rrq->value = bitrate_table[ratemode].bitrate * 100000;
	rrq->fixed = ! bitrate_table[ratemode].automatic;
	rrq->disabled = 0;

---------------------------------------------------------
[BUG] sizeof(start_code) = 138
/home/yxie/linux-2.5.53/drivers/net/eexpress.c:1473:eexp_hw_init586:
ERROR:BUFFER:1473:1473:Array bounds error (off >= len) (start_code[i + j
+ 16 / 2], len = 69, off = 72, min(off-len) = 3) 
		outw(i, ioaddr + SM_PTR);
		for (j = 0; j < 16; j+=2)
			outw(start_code[(i+j)/2],
			     ioaddr+0x4000+j);
		for (j = 0; j < 16; j+=2)

Error --->
			outw(start_code[(i+j+16)/2],
			     ioaddr+0x8000+j);
	}

---------------------------------------------------------
[BUG] suspicious
/home/yxie/linux-2.5.53/drivers/video/sis/init.c:3956:SiS_GetPanelID:
ERROR:BUFFER:3956:3956:Array bounds error (off >= len)
(PanelTypeTable[(int)tempbx], len = 16, off = 24, min(off-len) = 8) 
      return 0;
    }
  }

  tempbx <<= 1;

Error --->
  tempbx = PanelTypeTable[tempbx];
  tempbx |= LCDSync;
  temp = tempbx & 0x00FF;
  SiS_SetReg1(SiS_P3d4,0x36,temp);
---------------------------------------------------------
[BUG] off-by-one
/home/yxie/linux-2.5.53/drivers/net/hamradio/scc.c:1769:scc_net_ioctl:
ERROR:BUFFER:1769:1769:Array bounds error (off >= len) [RANGE]
(Ivec[hwcfg.irq], len = 224, off = sym_47606686, max(off-len) = 0) 
			if (hwcfg.irq == 2) hwcfg.irq = 9;

			if (hwcfg.irq <0 || hwcfg.irq > NR_IRQS)
				return -EINVAL;
				

Error --->
			if (!Ivec[hwcfg.irq].used && hwcfg.irq)
			{
				if (request_irq(hwcfg.irq, scc_isr,
SA_INTERRUPT, "AX.25 SCC", NULL))
					printk(KERN_WARNING "z8530drv:
warning, cannot get IRQ %d\n", hwcfg.irq);
---------------------------------------------------------
[BUG] length of VendorId is only 8
/home/yxie/linux-2.5.53/drivers/scsi/psi240i.c:335:Irq_Handler:
ERROR:BUFFER:335:335:Array bounds error (off >= len)
((*pinquiryData).VendorId[z + 1], len = 8, off = 9, min(off-len) = 1) 

				// Fill in vendor identification fields.
				for ( z = 0;  z < 20;  z += 2 )
					{
					pinquiryData->VendorId[z]
= ((UCHAR *)identifyData.ModelNumber)[z + 1];

Error --->
					pinquiryData->VendorId[z + 1] =
((UCHAR *)identifyData.ModelNumber)[z];
					}

				// Initialize unused portion of product
id.
---------------------------------------------------------
[BUG]
/home/yxie/linux-2.5.53/sound/oss/dev_table.c:42:sound_install_audiodrv:
ERROR:BUFFER:42:42:Array bounds error (off >= len) [RANGE]
(sound_mem_blocks[sound_nblocks], len = 1024, off = (sym_612015, 1, 1,
1), max(off-len) = 0) 
	d = (struct audio_driver *) (sound_mem_blocks[sound_nblocks] =
vmalloc(sizeof(struct audio_driver)));

	if (sound_nblocks < 1024)
		sound_nblocks++;


Error --->
	op = (struct audio_operations *)
(sound_mem_blocks[sound_nblocks] = vmalloc(sizeof(struct
audio_operations)));

	if (sound_nblocks < 1024)
		sound_nblocks++;
---------------------------------------------------------
[BUG] off-by-one
/home/yxie/linux-2.5.53/drivers/scsi/aacraid/aachba.c:1107:query_disk:
ERROR:BUFFER:1107:1107:Array bounds error (off >= len) [RANGE]
((*fsa_dev_ptr).locked[qd.cnum], len = 31, off = sym_14786361,
max(off-len) = 0) 
		qd.lun = CONTAINER_TO_LUN(qd.cnum);
	}
	else return -EINVAL;

	qd.valid = fsa_dev_ptr->valid[qd.cnum];

Error --->
	qd.locked = fsa_dev_ptr->locked[qd.cnum];
	qd.deleted = fsa_dev_ptr->deleted[qd.cnum];

	if (fsa_dev_ptr->devname[qd.cnum][0] == '\0')
---------------------------------------------------------
[BUG] missing comma in rq_flags
/home/yxie/linux-2.5.53/drivers/block/ll_rw_blk.c:685:blk_dump_rq_flags:
ERROR:BUFFER:685:685:Array bounds error (off >= len) (rq_flags[bit], len
= 17, off = 17, min(off-len) = 0) 
	printk("%s: dev %s: flags = ", msg,
		rq->rq_disk ? rq->rq_disk->disk_name : "?");
	bit = 0;
	do {
		if (rq->flags & (1 << bit))

Error --->
			printk("%s ", rq_flags[bit]);
		bit++;
	} while (bit < __REQ_NR_BITS);

---------------------------------------------------------
[BUG] suspicious, but probably not bug
/home/yxie/linux-2.5.53/drivers/char/ip2/i2cmd.c:206:i2cmdUnixFlags:
ERROR:BUFFER:206:206:Array bounds error (off >= len) ((*pCM).cmd[3], len
= 2, off = 3, min(off-len) = 1) 
{
	cmdSyntaxPtr pCM = (cmdSyntaxPtr) ct47;

	pCM->cmd[1] = (unsigned char)  iflag;
	pCM->cmd[2] = (unsigned char) (iflag >> 8);

Error --->
	pCM->cmd[3] = (unsigned char)  cflag;
	pCM->cmd[4] = (unsigned char) (cflag >> 8);
	pCM->cmd[5] = (unsigned char)  lflag;
	pCM->cmd[6] = (unsigned char) (lflag >> 8);
---------------------------------------------------------
[BUG] [SEC]? off-by-one
/home/yxie/linux-2.5.53/net/bluetooth/af_bluetooth.c:99:bt_sock_create:
ERROR:BUFFER:99:99:Array bounds error (off >= len) [RANGE]
(bt_proto[proto], len = 5, off = sym_686294, max(off-len) = 0) 
{
	if (proto > BT_MAX_PROTO)
		return -EINVAL;

#if defined(CONFIG_KMOD)

Error --->
	if (!bt_proto[proto]) {
		char module_name[30];
		sprintf(module_name, "bt-proto-%d", proto);
		request_module(module_name);
---------------------------------------------------------
[BUG]
/home/yxie/linux-2.5.53/drivers/ide/ide-probe.c:1055:alloc_disks:
ERROR:BUFFER:1055:1055:Array bounds error (off < 0) [RANGE]
(disks[unit], min(off) = -1) 
	}
	return 0;
Enomem:
	printk(KERN_WARNING "(ide::init_gendisk) Out of memory\n");
	while (unit--)

Error --->
		put_disk(disks[unit]);
	return -ENOMEM;
}

---------------------------------------------------------
[BUG] maybe. (i == 255)
/home/yxie/linux-2.5.53/drivers/net/tg3.c:5857:tg3_read_partno:
ERROR:BUFFER:5857:5857:Array bounds error (off >= len) [RANGE]
(vpd_data[i + 1], len = 256, off = (sym_8147517, 1, 1, 1), max(off-len)
= 0) 
	for (i = 0; i < 256; ) {
		unsigned char val = vpd_data[i];
		int block_end;

		if (val == 0x82 || val == 0x91) {

Error --->
			i = (i + 3 +
			     (vpd_data[i + 1] +
			      (vpd_data[i + 2] << 8)));
			continue;
---------------------------------------------------------
[BUG] max = -1
/home/yxie/linux-2.5.53/drivers/media/video/msp3400.c:873:msp3400c_threa
d: ERROR:BUFFER:873:873:Array bounds error (off < 0)
(carrier_detect_main[max1], max(off) = -1) 
				val2 = val, max2 = this;
			dprintk("msp3400: carrier2 val: %5d / %s\n",
val,cd[this].name);
		}

		/* programm the msp3400 according to the results */

Error --->
		msp->main   = carrier_detect_main[max1].cdo;
		switch (max1) {
		case 1: /* 5.5 */
			if (max2 == 0) {
---------------------------------------------------------
[BUG] bar == 4? (from the loop above)
/home/yxie/linux-2.5.53/drivers/isdn/hardware/eicon/os_4bri.c:268:diva_4
bri_init_card: ERROR:BUFFER:268:268:Array bounds error (off >= len)
((*a).slave_adapters[bar], len = 3, off = (sym_17752159, 1, 1, 1),
min(off-len) = 1) 
	 */
	quadro_list =
	    (PADAPTER_LIST_ENTRY) diva_os_malloc(0,
sizeof(*quadro_list));
	if (!(a->slave_list = quadro_list)) {
		for (i = 0; i < (tasks - 1); i++) {

Error --->
			diva_os_free(0, a->slave_adapters[bar]);
			a->slave_adapters[bar] = 0;
		}
		diva_4bri_cleanup_adapter(a);
---------------------------------------------------------
[BUG] base = &buf[4]
/home/yxie/linux-2.5.53/drivers/cdrom/cdrom.c:1170:dvd_read_physical:
ERROR:BUFFER:1170:1170:Array bounds error (off >= len) (*base + 16, len
= 20, off = 20, min(off-len) = 0) 
	layer->track_density = base[3] & 0xf;
	layer->linear_density = base[3] >> 4;
	layer->start_sector = base[5] << 16 | base[6] << 8 | base[7];
	layer->end_sector = base[9] << 16 | base[10] << 8 | base[11];
	layer->end_sector_l0 = base[13] << 16 | base[14] << 8 |
base[15];

Error --->
	layer->bca = base[16] >> 7;

	return 0;
}
---------------------------------------------------------
[BUG] should be cloop >> 2 in the index
/home/yxie/linux-2.5.53/drivers/hotplug/cpqphp_pci.c:1194:cpqhp_configur
e_board: ERROR:BUFFER:1194:1194:Array bounds error (off >= len)
((*func).config_space[cloop], len = 32, off = 32, min(off-len) = 0) 
				pci_bus_read_config_dword (pci_bus,
devfn, cloop, &temp);

				if (temp != func->config_space[cloop >>
2]) {
					dbg("Config space compare
failure!!! offset = %x\n", cloop);
					dbg("bus = %x, device = %x,
function = %x\n", func->bus, func->device, func->function);

Error --->
					dbg("temp = %x, config space =
%x\n\n", temp, func->config_space[cloop]);
					return 1;
				}
			}
---------------------------------------------------------
[BUG]
/home/yxie/linux-2.5.53/drivers/media/radio/radio-terratec.c:147:tt_setf
req: ERROR:BUFFER:147:147:Array bounds error (off < 0) (buffer[i],
max(off) = -1) 
	{
		if (rest%temp  == rest)
			buffer[i] = 0;
		else 
		{

Error --->
			buffer[i] = 1; 
			rest = rest-temp;
		}
		i--;
---------------------------------------------------------
[BUG] off-by-one
/home/yxie/linux-2.5.53/drivers/scsi/aacraid/aachba.c:1137:force_delete_
disk: ERROR:BUFFER:1137:1137:Array bounds error (off >= len) [RANGE]
((*fsa_dev_ptr).deleted[dd.cnum], len = 31, off = sym_14786353,
max(off-len) = 0) 
	if (dd.cnum > MAXIMUM_NUM_CONTAINERS)
		return -EINVAL;
	/*
	 *	Mark this container as being deleted.
	 */

Error --->
	fsa_dev_ptr->deleted[dd.cnum] = 1;
	/*
	 *	Mark the container as no longer valid
	 */
---------------------------------------------------------
[BUG] divide by zero
/home/yxie/linux-2.5.53/drivers/char/ftape/lowlevel/ftape-read.c:608:fta
pe_decode_header_segment: ERROR:DIVZERO:608:608:ftape_segments_per_head
/ ftape_segments_per_cylinder
		      ft_tracks_per_tape,
		      ((ft_segments_per_track * ft_tracks_per_tape -1) /

		       ftape_segments_per_head ),
		      (ftape_segments_per_head / 
		       ftape_segments_per_cylinder - 1 ),

Error --->
		      (ftape_segments_per_cylinder *
FT_SECTORS_PER_SEGMENT));
		TRACE_EXIT -EIO;
	}
	ftape_extract_bad_sector_map(address);
---------------------------------------------------------
[BUG]
/home/yxie/linux-2.5.53/fs/cifs/cifssmb.c:233:CIFSSMBLogoff:
ERROR:BUFFER:233:233:Dereferencing uninitialized pointer (*pSMB)
evaluated in the following state 
	if (atomic_read(&ses->inUse) > 0) {
		up(&ses->sesSem);
		return -EBUSY;
	}
    if(ses->secMode & (SECMODE_SIGN_REQUIRED | SECMODE_SIGN_ENABLED))

Error --->
        pSMB->hdr.Flags2 |= SMBFLG2_SECURITY_SIGNATURE;
	rc = smb_init(SMB_COM_LOGOFF_ANDX, 2, 0 /* no tcon anymore */ ,
		      (void **) &pSMB, (void **) &smb_buffer_response);
	if (rc) {
---------------------------------------------------------
[BUG] off-by-one
/home/yxie/linux-2.5.53/drivers/scsi/aacraid/aachba.c:1108:query_disk:
ERROR:BUFFER:1108:1108:Array bounds error (off >= len) [RANGE]
((*fsa_dev_ptr).deleted[qd.cnum], len = 31, off = sym_14786361,
max(off-len) = 0) 
	}
	else return -EINVAL;

	qd.valid = fsa_dev_ptr->valid[qd.cnum];
	qd.locked = fsa_dev_ptr->locked[qd.cnum];

Error --->
	qd.deleted = fsa_dev_ptr->deleted[qd.cnum];

	if (fsa_dev_ptr->devname[qd.cnum][0] == '\0')
		qd.unmapped = 1;
---------------------------------------------------------
[BUG] check default branch above
/home/yxie/linux-2.5.53/drivers/video/sis/sis_main.c:398:sisfb_validate_
mode: ERROR:BUFFER:398:398:Array bounds error (off < 0)
(sisbios_mode[sisfb_mode_idx], max(off) = -1) 
		}
		break;
	}

	if(ivideo.chip < SIS_315H) {

Error --->
             if(sisbios_mode[sisfb_mode_idx].xres > 1920)
	         sisfb_mode_idx = -1;
	}
	/* TW: TODO: Validate modes available on either 300 or 310/325
series only */
---------------------------------------------------------
[BUG] minor (recommend inserting break in the true branch of the if
statement)
/home/yxie/linux-2.5.53/drivers/video/sis/init301.c:2053:SiS_SetCRT2FIFO
_310: ERROR:BUFFER:2053:2053:Array bounds error (off >= len) [RANGE]
(CombCode[(int)temp3 + 1], len = 16, off = (sym_11686423, 1, 3, 1),
max(off-len) = 0) 
  /* get DRAM latency */
  tempcl = (SiS_GetReg1(SiS_P3c4,0x17) >> 3) & 0x7;     /* SR17[5:3]
DRAM Queue depth */
  tempch = (SiS_GetReg1(SiS_P3c4,0x17) >> 6) & 0x3;     /* SR17[7:6]
DRAM Grant length */

  for (temp3 = 0; temp3 < 16; temp3 += 2) {

Error --->
    if ((CombCode[temp3] == tempcl) && (CombCode[temp3+1] == tempch)) {
      temp3 = CRT2ThLow[temp3 >> 1];
    }
  }
---------------------------------------------------------
[BUG] should check bus against 31
/home/yxie/linux-2.5.53/arch/i386/pci/numa.c:25:__pci_conf1_mq_read:
ERROR:BUFFER:25:25:Array bounds error (off >= len) [RANGE]
(mp_bus_id_to_node[bus], len = 32, off = sym_42073871, max(off-len) =
223) 
	if (!value || (bus > 255) || (dev > 31) || (fn > 7) || (reg >
255))
		return -EINVAL;

	spin_lock_irqsave(&pci_config_lock, flags);


Error --->
	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8,
BUS2QUAD(bus));

	switch (len) {
	case 1:
---------------------------------------------------------
[BUG] off-by-one
/home/yxie/linux-2.5.53/drivers/scsi/dpt_i2o.c:1482:adpt_i2o_parse_lct:
ERROR:BUFFER:1482:1482:Array bounds error (off >= len) [RANGE]
((*pHba).channel[(int)bus_no].device[(int)scsi_id], len = 128, off =
sym_37752142, max(off-len) = 0) 
					continue;
				}
				if(scsi_id > MAX_ID){
					continue;
				}

Error --->
				if(
pHba->channel[bus_no].device[scsi_id] == NULL){
					pDev =  kmalloc(sizeof(struct
adpt_device),GFP_KERNEL);
					if(pDev == NULL) {
						return -ENOMEM;
---------------------------------------------------------
[BUG] off-by-one
/home/yxie/linux-2.5.53/drivers/char/rio/rioroute.c:769:RIOIsolate:
ERROR:BUFFER:769:769:Array bounds error (off >= len) [RANGE]
((*HostP).Mapping[UnitId], len = 16, off = (sym_16102906, 1, -1, 1),
max(off-len) = 0) 
	UnitId--;		/* this trick relies on the Unit Id
being UNSIGNED! */

	if ( UnitId > MAX_RUP )		/* dontcha just lurv unsigned
maths! */
		return(0);


Error --->
	if ( HostP->Mapping[UnitId].Flags & BEEN_HERE )
		return(0);

	HostP->Mapping[UnitId].Flags |= BEEN_HERE;
---------------------------------------------------------
[BUG] off-by-one
/home/yxie/linux-2.5.53/drivers/block/cciss.c:348:cciss_open:
ERROR:BUFFER:348:348:Array bounds error (off >= len) [RANGE] (hba[ctlr],
len = 8, off = sym_24775581, max(off-len) = 0) 

#ifdef CCISS_DEBUG
	printk(KERN_DEBUG "cciss_open %x (%x:%x)\n", inode->i_rdev,
ctlr, dsk);
#endif /* CCISS_DEBUG */ 


Error --->
	if (ctlr > MAX_CTLR || hba[ctlr] == NULL)
		return -ENXIO;
	/*
	 * Root is allowed to open raw volume zero even if its not
configured
---------------------------------------------------------
[BUG] off-by-one
/home/yxie/linux-2.5.53/drivers/scsi/aacraid/aachba.c:1167:delete_disk:
ERROR:BUFFER:1167:1167:Array bounds error (off >= len) [RANGE]
((*fsa_dev_ptr).devname[dd.cnum], len = 31, off = sym_14786346,
max(off-len) = 0) 
	else {
		/*
		 *	Mark the container as no longer being valid.
		 */
		fsa_dev_ptr->valid[dd.cnum] = 0;

Error --->
		fsa_dev_ptr->devname[dd.cnum][0] = '\0';
		return 0;
	}
}
---------------------------------------------------------
[BUG]
/home/yxie/linux-2.5.53/drivers/net/sk98lin/skxmac2.c:424:SkXmClrSrcChec
k: ERROR:BUFFER:424:424:Array bounds error (off >= len) (*pByte + 7, len
= 6, off = 7, min(off-len) = 1) 
SK_IOC	IoC,	/* IO context */
int		Port)	/* The XMAC to handle with belongs to this Port
(MAC_1 + n) */
{
	SK_U16	ZeroAddr[3] = {0x0000, 0x0000, 0x0000};


Error --->
	XM_OUTHASH(IoC, Port, XM_SRC_CHK, &ZeroAddr);
}	/* SkXmClrSrcCheck */


---------------------------------------------------------
[BUG] divide by zero
/home/yxie/linux-2.5.53/drivers/char/ftape/lowlevel/ftape-read.c:608:fta
pe_decode_header_segment:
ERROR:DIVZERO:608:608:ftape_status.fti_segments_per_track *
ftape_status.fti_tracks_per_tape - 1 / (unsigned
int)ftape_segments_per_head
		      ft_tracks_per_tape,
		      ((ft_segments_per_track * ft_tracks_per_tape -1) /

		       ftape_segments_per_head ),
		      (ftape_segments_per_head / 
		       ftape_segments_per_cylinder - 1 ),

Error --->
		      (ftape_segments_per_cylinder *
FT_SECTORS_PER_SEGMENT));
		TRACE_EXIT -EIO;
	}
	ftape_extract_bad_sector_map(address);
---------------------------------------------------------
[BUG]
/home/yxie/linux-2.5.53/drivers/scsi/aacraid/aachba.c:1106:query_disk:
ERROR:BUFFER:1106:1106:Array bounds error (off >= len) [RANGE]
((*fsa_dev_ptr).valid[qd.cnum], len = 31, off = sym_14786361,
max(off-len) = 0) 
		qd.target = CONTAINER_TO_TARGET(qd.cnum);
		qd.lun = CONTAINER_TO_LUN(qd.cnum);
	}
	else return -EINVAL;


Error --->
	qd.valid = fsa_dev_ptr->valid[qd.cnum];
	qd.locked = fsa_dev_ptr->locked[qd.cnum];
	qd.deleted = fsa_dev_ptr->deleted[qd.cnum];

---------------------------------------------------------
[BUG] wrong bounds check
/home/yxie/linux-2.5.53/arch/i386/pci/numa.c:53:__pci_conf1_mq_write:
ERROR:BUFFER:53:53:Array bounds error (off >= len) [RANGE]
(mp_bus_id_to_node[bus], len = 32, off = sym_42073848, max(off-len) =
223) 
	if ((bus > 255) || (dev > 31) || (fn > 7) || (reg > 255)) 
		return -EINVAL;

	spin_lock_irqsave(&pci_config_lock, flags);


Error --->
	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8,
BUS2QUAD(bus));

	switch (len) {
	case 1:
---------------------------------------------------------
[BUG] check against the wrong bounds
/home/yxie/linux-2.5.53/drivers/message/i2o/i2o_core.c:3066:i2o_report_c
ommon_status: ERROR:BUFFER:3066:3066:Array bounds error (off >= len)
[RANGE] (REPLY_STATUS[(int)req_status], len = 12, off = sym_47995228,
max(off-len) = 116) 
	};

	if (req_status > I2O_REPLY_STATUS_PROGRESS_REPORT)
		printk("RequestStatus = %0#2x", req_status);
	else

Error --->
		printk("%s", REPLY_STATUS[req_status]);
}

/*
---------------------------------------------------------
[BUG] off-by-one
/home/yxie/linux-2.5.53/drivers/scsi/aacraid/aachba.c:1110:query_disk:
ERROR:BUFFER:1110:1110:Array bounds error (off >= len) [RANGE]
((*fsa_dev_ptr).devname[qd.cnum], len = 31, off = sym_14786361,
max(off-len) = 0) 

	qd.valid = fsa_dev_ptr->valid[qd.cnum];
	qd.locked = fsa_dev_ptr->locked[qd.cnum];
	qd.deleted = fsa_dev_ptr->deleted[qd.cnum];


Error --->
	if (fsa_dev_ptr->devname[qd.cnum][0] == '\0')
		qd.unmapped = 1;
	else
		qd.unmapped = 0;
---------------------------------------------------------
[BUG] length of ultra5 and ultra6 are not long enough
/home/yxie/linux-2.5.53/drivers/ide/pci/siimage.c:223:siimage_tune_chips
et: ERROR:BUFFER:223:223:Array bounds error (off >= len)
(ultra5[(int)speed - 64], len = 6, off = 6, min(off-len) = 0) 
		case XFER_UDMA_3:
		case XFER_UDMA_2:
		case XFER_UDMA_1:
		case XFER_UDMA_0:
			multi = dma[2];

Error --->
			ultra |= ((scsc) ? (ultra5[speed - XFER_UDMA_0])
:
					   (ultra6[speed -
XFER_UDMA_0]));
			mode |= ((unit) ? 0x30 : 0x03);
			config_siimage_chipset_for_pio(drive, 0);

# Summary for 
#  buffer-specific errors       = 87
#  /dev/null-specific errors = 0
#  Common errors 		      	  = 0
#  Total 				  = 87
# BUGs	|	File Name
9	|	/scsi/aachba.c
5	|	/char/i2cmd.c
4	|	/i386/numa.c
3	|	/message/i2o_block.c
3	|	/drivers/DAC960.c
3	|	/drivers/ibmphp_pci.c
3	|	/video/init301.c
2	|	/drivers/psi240i.c
2	|	/net/qos.c
2	|	/hardware/diva.c
2	|	/drivers/tg3.c
2	|	/ftape/ftape-read.c
2	|	/net/skxmac2.c
2	|	/drivers/eexpress.c
2	|	/drivers/specialix.c
1	|	/message/i2o_core.c
1	|	/net/orinoco.c
1	|	/drivers/cdrom.c
1	|	/fs/cifssmb.c
1	|	/net/smc-ircc.c
1	|	/net/scc.c
1	|	/media/bttv-cards.c
1	|	/ide/siimage.c
1	|	/drivers/cciss.c
1	|	/isdn/isdn_common.c
1	|	/net/rtnetlink.c
1	|	/drivers/i82092.c
1	|	/input/sunkbd.c
1	|	/hardware/os_4bri.c
1	|	/media/msp3400.c
1	|	/fs/xfs_bmap_btree.c
1	|	/sound/sb_card.c
1	|	/char/rioroute.c
1	|	/drivers/riscom8.c
1	|	/drivers/dpt_i2o.c
1	|	/net/af_bluetooth.c
1	|	/drivers/cpqphp_pci.c
1	|	/dvb/av7110.c
1	|	/message/mptbase.c
1	|	/sound/dev_table.c
1	|	/fs/base.c
1	|	/drivers/sx.c
1	|	/video/init.c
1	|	/drivers/cpqfcTSworker.c
1	|	/drivers/qlogicfc.c
1	|	/char/rioboot.c
1	|	/media/radio-terratec.c
1	|	/cpu/powernow-k6.c
1	|	/net/3c359.c
1	|	/usb/ohci-hub.c
1	|	/drivers/3c59x.c
1	|	/drivers/ll_rw_blk.c
1	|	/char/riocmd.c
1	|	/scsi/aic79xx_pci.c
1	|	/video/sis_main.c
1	|	/drivers/ide-probe.c

