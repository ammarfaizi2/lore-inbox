Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbTIPEgo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 00:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbTIPEgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 00:36:44 -0400
Received: from smtp5.Stanford.EDU ([171.67.16.30]:20710 "EHLO
	smtp5.Stanford.EDU") by vger.kernel.org with ESMTP id S261787AbTIPEf7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 00:35:59 -0400
Date: Mon, 15 Sep 2003 21:35:46 -0700 (PDT)
Message-Id: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
From: David Yu Chen <dychen@stanford.edu>
To: linux-kernel@vger.kernel.org
Subject: [CHECKER] 32 Memory Leaks on Error Paths
CC: mc@cs.stanford.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I'm with the Stanford Meta-level Compilation research group, and I
have a set of memory leaks on error paths for the 2.6.0-test5 kernel.
(I also have error reports for 2.4.18 and a couple other kernels if
anyone is interested).

There may be one or more "GOTO -->" markers showing the different
paths of execution that can occur between where the memory is
allocated and where the function returns.

My checker identifies error paths with a learning algorithm on
features surrounding goto and return statements.  I'd greatly
appreciate any comments or confirmation on these bugs.

Thanks!

---
David Yu Chen
http://www.stanford.edu/~dychen/

---------------------------------------------------------

Count = 32
# | File
1 | drivers/char/vt_ioctl.c
1 | drivers/media/video/bttv-risc.c
2 | drivers/mtd/chips/cfi_cmdset_0020.c
1 | drivers/mtd/mtdblock.c
1 | drivers/net/irda/ali-ircc.c
1 | drivers/net/irda/nsc-ircc.c
2 | drivers/pci/hotplug/ibmphp_ebda.c
1 | drivers/scsi/NCR_Q720.c
1 | drivers/scsi/scsi_debug.c
1 | drivers/telephony/ixj_pcmcia.c
2 | drivers/usb/class/usb-midi.c
1 | drivers/usb/input/hiddev.c
1 | fs/afs/cell.c
2 | fs/jffs2/scan.c
1 | fs/nfsd/nfsctl.c
2 | net/ipv4/igmp.c
1 | net/irda/irlmp.c
1 | net/sunrpc/auth_gss/gss_mech_switch.c
1 | net/sunrpc/auth_gss/gss_pseudoflavors.c
1 | security/selinux/selinuxfs.c
1 | security/selinux/ss/mls.c
4 | security/selinux/ss/policydb.c
1 | sound/oss/emu10k1/midi.c
1 | sound/oss/ymfpci.c

---------------------------------------------------------

[FILE:  2.6.0-test5/drivers/char/vt_ioctl.c]
[FUNC:  do_kdsk_ioctl]
[LINES: 133-150]
[VAR:   key_map]
 128:
 129:			if (keymap_count >= MAX_NR_OF_USER_KEYMAPS &&
 130:			    !capable(CAP_SYS_RESOURCE))
 131:				return -EPERM;
 132:
START -->
 133:			key_map = (ushort *) kmalloc(sizeof(plain_map),
 134:						     GFP_KERNEL);
 135:			if (!key_map)
 136:				return -ENOMEM;
 137:			key_maps[s] = key_map;
 138:			key_map[0] = U(K_ALLOCATED);
        ... DELETED 6 lines ...
 145:			break;	/* nothing to do */
 146:		/*
 147:		 * Attention Key.
 148:		 */
 149:		if (((ov == K_SAK) || (v == K_SAK)) && !capable(CAP_SYS_ADMIN))
END -->
 150:			return -EPERM;
 151:		key_map[i] = U(v);
 152:		if (!s && (KTYP(ov) == KT_SHIFT || KTYP(v) == KT_SHIFT))
 153:			compute_shiftstate();
 154:		break;
 155:	}
---------------------------------------------------------

[FILE:  2.6.0-test5/drivers/media/video/bttv-risc.c]
[FUNC:  bttv_risc_overlay]
[LINES: 214-223]
[VAR:   skips]
 209:	struct btcx_skiplist *skips;
 210:	u32 *rp,ri,ra;
 211:	u32 addr;
 212:
 213:	/* skip list for window clipping */
START -->
 214:	if (NULL == (skips = kmalloc(sizeof(*skips) * ov->nclips,GFP_KERNEL)))
 215:		return -ENOMEM;
 216:	
 217:	/* estimate risc mem: worst case is (clip+1) * lines instructions
 218:	   + sync + jump (all 2 dwords) */
 219:	instructions  = (ov->nclips + 1) *
 220:		((skip_even || skip_odd) ? ov->w.height>>1 :  ov->w.height);
 221:	instructions += 2;
 222:	if ((rc = btcx_riscmem_alloc(btv->dev,risc,instructions*8)) < 0)
END -->
 223:		return rc;
 224:
 225:	/* sync instruction */
 226:	rp = risc->cpu;
 227:	*(rp++) = cpu_to_le32(BT848_RISC_SYNC|BT848_FIFO_STATUS_FM1);
 228:	*(rp++) = cpu_to_le32(0);
---------------------------------------------------------

[FILE:  2.6.0-test5/drivers/mtd/chips/cfi_cmdset_0020.c]
[FUNC:  cfi_staa_setup]
[LINES: 191-211]
[VAR:   mtd]
 186:	struct mtd_info *mtd;
 187:	unsigned long offset = 0;
 188:	int i,j;
 189:	unsigned long devsize = (1<<cfi->cfiq->DevSize) * cfi->interleave;
 190:
START -->
 191:	mtd = kmalloc(sizeof(*mtd), GFP_KERNEL);
 192:	//printk(KERN_DEBUG "number of CFI chips: %d\n", cfi->numchips);
 193:
 194:	if (!mtd) {
 195:		printk(KERN_ERR "Failed to allocate memory for MTD device\n");
 196:		kfree(cfi->cmdset_priv);
        ... DELETED 9 lines ...
 206:	mtd->eraseregions = kmalloc(sizeof(struct mtd_erase_region_info) 
 207:			* mtd->numeraseregions, GFP_KERNEL);
 208:	if (!mtd->eraseregions) { 
 209:		printk(KERN_ERR "Failed to allocate memory for MTD erase region info\n");
 210:		kfree(cfi->cmdset_priv);
END -->
 211:		return NULL;
 212:	}
 213:	
 214:	for (i=0; i<cfi->cfiq->NumEraseRegions; i++) {
 215:		unsigned long ernum, ersize;
 216:		ersize = ((cfi->cfiq->EraseRegionInfo[i] >> 8) & ~0xff) * cfi->interleave;
---------------------------------------------------------

[FILE:  2.6.0-test5/drivers/mtd/chips/cfi_cmdset_0020.c]
[FUNC:  cfi_staa_setup]
[LINES: 191-235]
[VAR:   mtd]
 186:	struct mtd_info *mtd;
 187:	unsigned long offset = 0;
 188:	int i,j;
 189:	unsigned long devsize = (1<<cfi->cfiq->DevSize) * cfi->interleave;
 190:
START -->
 191:	mtd = kmalloc(sizeof(*mtd), GFP_KERNEL);
 192:	//printk(KERN_DEBUG "number of CFI chips: %d\n", cfi->numchips);
 193:
 194:	if (!mtd) {
 195:		printk(KERN_ERR "Failed to allocate memory for MTD device\n");
 196:		kfree(cfi->cmdset_priv);
        ... DELETED 33 lines ...
 230:		if (offset != devsize) {
 231:			/* Argh */
 232:			printk(KERN_WARNING "Sum of regions (%lx) != total size of set of interleaved chips (%lx)\n", offset, devsize);
 233:			kfree(mtd->eraseregions);
 234:			kfree(cfi->cmdset_priv);
END -->
 235:			return NULL;
 236:		}
 237:
 238:		for (i=0; i<mtd->numeraseregions;i++){
 239:			printk(KERN_DEBUG "%d: offset=0x%x,size=0x%x,blocks=%d\n",
 240:			       i,mtd->eraseregions[i].offset,
---------------------------------------------------------

looks like checking for mtdblks instead of mtdblk
[FILE:  2.6.0-test5/drivers/mtd/mtdblock.c]
[FUNC:  mtdblock_open]
[LINES: 277-279]
[VAR:   mtdblk]
 272:		mtdblks[dev]->count++;
 273:		return 0;
 274:	}
 275:	
 276:	/* OK, it's not open. Create cache info for it */
START -->
 277:	mtdblk = kmalloc(sizeof(struct mtdblk_dev), GFP_KERNEL);
 278:	if (!mtdblks)
END -->
 279:		return -ENOMEM;
 280:
 281:	memset(mtdblk, 0, sizeof(*mtdblk));
 282:	mtdblk->count = 1;
 283:	mtdblk->mtd = mtd;
 284:
---------------------------------------------------------

[FILE:  2.6.0-test5/drivers/net/irda/ali-ircc.c]
[FUNC:  ali_ircc_open]
[LINES: 259-337]
[VAR:   self]
 254:	/* Set FIR FIFO and DMA Threshold */
 255:	if ((ali_ircc_setup(info)) == -1)
 256:		return -1;
 257:		
 258:	/* Allocate new instance of the driver */
START -->
 259:	self = kmalloc(sizeof(struct ali_ircc_cb), GFP_KERNEL);
 260:	if (self == NULL) 
 261:	{
 262:		ERROR("%s(), can't allocate memory for control block!\n", __FUNCTION__);
 263:		return -ENOMEM;
 264:	}
        ... DELETED 67 lines ...
 332:	self->tx_fifo.len = self->tx_fifo.ptr = self->tx_fifo.free = 0;
 333:	self->tx_fifo.tail = self->tx_buff.head;
 334:
 335:	if (!(dev = dev_alloc("irda%d", &err))) {
 336:		ERROR("%s(), dev_alloc() failed!\n", __FUNCTION__);
END -->
 337:		return -ENOMEM;
 338:	}
 339:
 340:	dev->priv = (void *) self;
 341:	self->netdev = dev;
 342:	
---------------------------------------------------------

[FILE:  2.6.0-test5/drivers/net/irda/nsc-ircc.c]
[FUNC:  nsc_ircc_open]
[LINES: 265-341]
[VAR:   self]
 260:		return -1;
 261:
 262:	MESSAGE("%s, driver loaded (Dag Brattli)\n", driver_name);
 263:
 264:	/* Allocate new instance of the driver */
START -->
 265:	self = kmalloc(sizeof(struct nsc_ircc_cb), GFP_KERNEL);
 266:	if (self == NULL) {
 267:		ERROR("%s(), can't allocate memory for "
 268:		       "control block!\n", __FUNCTION__);
 269:		return -ENOMEM;
 270:	}
        ... DELETED 65 lines ...
 336:	self->tx_fifo.len = self->tx_fifo.ptr = self->tx_fifo.free = 0;
 337:	self->tx_fifo.tail = self->tx_buff.head;
 338:
 339:	if (!(dev = dev_alloc("irda%d", &err))) {
 340:		ERROR("%s(), dev_alloc() failed!\n", __FUNCTION__);
END -->
 341:		return -ENOMEM;
 342:	}
 343:
 344:	dev->priv = (void *) self;
 345:	self->netdev = dev;
 346:
---------------------------------------------------------

[FILE:  2.6.0-test5/drivers/pci/hotplug/ibmphp_ebda.c]
[FUNC:  ebda_rsrc_controller]
[LINES: 857-1064]
[VAR:   bus_info_ptr1]
 852:
 853:			// create bus_info lined list --- if only one slot per bus: slot_min = slot_max 
 854:
 855:			bus_info_ptr2 = ibmphp_find_same_bus_num (slot_ptr->slot_bus_num);
 856:			if (!bus_info_ptr2) {
START -->
 857:				bus_info_ptr1 = (struct bus_info *) kmalloc (sizeof (struct bus_info), GFP_KERNEL);
 858:				if (!bus_info_ptr1) {
 859:					rc = -ENOMEM;
 860:					goto error_no_hp_slot;
 861:				}
 862:				memset (bus_info_ptr1, 0, sizeof (struct bus_info));
        ... DELETED 79 lines ...
 942:				hpc_ptr->irq = readb (io_mem + addr + 5);
 943:				addr += 6;
 944:				break;
 945:			default:
 946:				rc = -ENODEV;
GOTO -->
 947:				goto error_no_hp_slot;
 948:		}
 949:
 950:		//reorganize chassis' linked list
 951:		combine_wpg_for_chassis ();
 952:		combine_wpg_for_expansion ();
        ... DELETED 106 lines ...
1059:	kfree (hp_slot_ptr);
1060:error_no_hp_slot:
1061:	free_ebda_hpc (hpc_ptr);
1062:error_no_hpc:
1063:	iounmap (io_mem);
END -->
1064:	return rc;
1065:}
1066:
1067:/* 
1068: * map info (bus, devfun, start addr, end addr..) of i/o, memory,
1069: * pfm from the physical addr to a list of resource.
---------------------------------------------------------

[FILE:  2.6.0-test5/drivers/pci/hotplug/ibmphp_ebda.c]
[FUNC:  ebda_rsrc_controller]
[LINES: 981-1064]
[VAR:   tmp_slot]
 976:			if (!hp_slot_ptr->name) {
 977:				rc = -ENOMEM;
 978:				goto error_no_hp_name;
 979:			}
 980:
START -->
 981:			tmp_slot = kmalloc(sizeof(*tmp_slot), GFP_KERNEL);
 982:			if (!tmp_slot) {
 983:				rc = -ENOMEM;
 984:				goto error_no_slot;
 985:			}
 986:			memset(tmp_slot, 0, sizeof(*tmp_slot));
        ... DELETED 17 lines ...
1004:			tmp_slot->bus = hpc_ptr->slots[index].slot_bus_num;
1005:
1006:			bus_info_ptr1 = ibmphp_find_same_bus_num (hpc_ptr->slots[index].slot_bus_num);
1007:			if (!bus_info_ptr1) {
1008:				rc = -ENODEV;
GOTO -->
1009:				goto error;
1010:			}
1011:			tmp_slot->bus_on = bus_info_ptr1;
1012:			bus_info_ptr1 = NULL;
1013:			tmp_slot->ctrl = hpc_ptr;
1014:
        ... DELETED 44 lines ...
1059:	kfree (hp_slot_ptr);
1060:error_no_hp_slot:
1061:	free_ebda_hpc (hpc_ptr);
1062:error_no_hpc:
1063:	iounmap (io_mem);
END -->
1064:	return rc;
1065:}
1066:
1067:/* 
1068: * map info (bus, devfun, start addr, end addr..) of i/o, memory,
1069: * pfm from the physical addr to a list of resource.
---------------------------------------------------------

[FILE:  2.6.0-test5/drivers/scsi/NCR_Q720.c]
[FUNC:  NCR_Q720_probe]
[LINES: 153-182]
[VAR:   p]
 148:	__u8 pos2, pos4, asr2, asr9, asr10;
 149:	__u16 io_base;
 150:	__u32 base_addr, mem_size;
 151:	__u32 mem_base;
 152:
START -->
 153:	p = kmalloc(sizeof(*p), GFP_KERNEL);
 154:	if (!p)
 155:		return -ENOMEM;
 156:
 157:	memset(p, 0, sizeof(*p));
 158:	pos2 = mca_device_read_pos(mca_dev, 2);
        ... DELETED 18 lines ...
 177:
 178:	/* sanity check I/O mapping */
 179:	i = inb(io_base) | (inb(io_base+1)<<8);
 180:	if(i != NCR_Q720_MCA_ID) {
 181:		printk(KERN_ERR "NCR_Q720, adapter failed to I/O map registers correctly at 0x%x(0x%x)\n", io_base, i);
END -->
 182:		return -ENODEV;
 183:	}
 184:
 185:	/* Phase II, find the ram base and memory map the board register */
 186:	pos4 = inb(io_base + 4);
 187:	/* enable streaming data */
---------------------------------------------------------

Leaks memory if kmalloc fails between 0 .. devs_per_host
[FILE:  2.6.0-test5/drivers/scsi/scsi_debug.c]
[FUNC:  sdebug_add_adapter]
[LINES: 1612-1652]
[VAR:   sdbg_devinfo]
1607:        memset(sdbg_host, 0, sizeof(*sdbg_host));
1608:        INIT_LIST_HEAD(&sdbg_host->dev_info_list);
1609:
1610:	devs_per_host = scsi_debug_num_tgts * scsi_debug_max_luns;
1611:        for (k = 0; k < devs_per_host; k++) {
START -->
1612:                sdbg_devinfo = kmalloc(sizeof(*sdbg_devinfo),GFP_KERNEL);
1613:                if (NULL == sdbg_devinfo) {
1614:                        printk(KERN_ERR "%s: out of memory at line %d\n",
1615:                               __FUNCTION__, __LINE__);
1616:                        error = -ENOMEM;
GOTO -->
1617:			goto clean1;
        ... DELETED 29 lines ...
1647:		kfree(sdbg_devinfo);
1648:	}
1649:
1650:clean1:
1651:	kfree(sdbg_host);
END -->
1652:        return error;
1653:}
1654:
1655:static void sdebug_remove_adapter()
1656:{
1657:        struct sdebug_host_info * sdbg_host = NULL;
---------------------------------------------------------

[FILE:  2.6.0-test5/drivers/telephony/ixj_pcmcia.c]
[FUNC:  ixj_attach]
[LINES: 53-64]
[VAR:   link]
  48:	client_reg_t client_reg;
  49:	dev_link_t *link;
  50:	int ret;
  51:	DEBUG(0, "ixj_attach()\n");
  52:	/* Create new ixj device */
START -->
  53:	link = kmalloc(sizeof(struct dev_link_t), GFP_KERNEL);
  54:	if (!link)
  55:		return NULL;
  56:	memset(link, 0, sizeof(struct dev_link_t));
  57:	link->io.Attributes1 = IO_DATA_PATH_WIDTH_8;
  58:	link->io.Attributes2 = IO_DATA_PATH_WIDTH_8;
  59:	link->io.IOAddrLines = 3;
  60:	link->conf.Vcc = 50;
  61:	link->conf.IntType = INT_MEMORY_AND_IO;
  62:	link->priv = kmalloc(sizeof(struct ixj_info_t), GFP_KERNEL);
  63:	if (!link->priv)
END -->
  64:		return NULL;
  65:	memset(link->priv, 0, sizeof(struct ixj_info_t));
  66:	/* Register with Card Services */
  67:	link->next = dev_list;
  68:	dev_list = link;
  69:	client_reg.dev_info = &dev_info;
---------------------------------------------------------

Leaks if devices == 0 ?  Error_end only frees mdevs if (devices > 0), 
but for mdevs=kmalloc(0), the slab allocator may still actually return memory
[FILE:  2.6.0-test5/drivers/usb/class/usb-midi.c]
[FUNC:  alloc_usb_midi_device]
[LINES: 1621-1772]
[VAR:   mdevs]
1616:	devices = inDevs > outDevs ? inDevs : outDevs;
1617:	devices = maxdevices > devices ? devices : maxdevices;
1618:
1619:	/* obtain space for device name (iProduct) if not known. */
1620:	if ( ! u->deviceName ) {
START -->
1621:		mdevs = (struct usb_mididev **)
1622:			kmalloc(sizeof(struct usb_mididevs *)*devices
1623:				+ sizeof(char) * 256, GFP_KERNEL);
1624:	} else {
1625:		mdevs = (struct usb_mididev **)
1626:			kmalloc(sizeof(struct usb_mididevs *)*devices, GFP_KERNEL);
        ... DELETED 83 lines ...
1710:		}
1711:		mout = mouts[outEndpoint];
1712:
1713:		mdevs[i] = allocMidiDev( s, min, mout, inCableId, outCableId );
1714:		if ( mdevs[i] == NULL )
GOTO -->
1715:			goto error_end;
1716:
1717:	}
1718:
1719:	/* Success! */
1720:	for ( i=0 ; i<devices ; i++ ) {
        ... DELETED 46 lines ...
1767:		if ( mouts[i] != NULL ) {
1768:			remove_midi_out_endpoint( mouts[i] );
1769:		}
1770:	}
1771:
END -->
1772:	return -ENOMEM;
1773:}
1774:
1775:/* ------------------------------------------------------------------------- */
1776:
1777:/** Attempt to scan YAMAHA's device descriptor and detect correct values of
---------------------------------------------------------

[FILE:  2.6.0-test5/drivers/usb/class/usb-midi.c]
[FUNC:  alloc_usb_midi_device]
[LINES: 1625-1772]
[VAR:   mdevs]
1620:	if ( ! u->deviceName ) {
1621:		mdevs = (struct usb_mididev **)
1622:			kmalloc(sizeof(struct usb_mididevs *)*devices
1623:				+ sizeof(char) * 256, GFP_KERNEL);
1624:	} else {
START -->
1625:		mdevs = (struct usb_mididev **)
1626:			kmalloc(sizeof(struct usb_mididevs *)*devices, GFP_KERNEL);
1627:	}
1628:
1629:	if ( !mdevs ) {
1630:		/* devices = 0; */
        ... DELETED 79 lines ...
1710:		}
1711:		mout = mouts[outEndpoint];
1712:
1713:		mdevs[i] = allocMidiDev( s, min, mout, inCableId, outCableId );
1714:		if ( mdevs[i] == NULL )
GOTO -->
1715:			goto error_end;
1716:
1717:	}
1718:
1719:	/* Success! */
1720:	for ( i=0 ; i<devices ; i++ ) {
        ... DELETED 46 lines ...
1767:		if ( mouts[i] != NULL ) {
1768:			remove_midi_out_endpoint( mouts[i] );
1769:		}
1770:	}
1771:
END -->
1772:	return -ENOMEM;
1773:}
1774:
1775:/* ------------------------------------------------------------------------- */
1776:
1777:/** Attempt to scan YAMAHA's device descriptor and detect correct values of
---------------------------------------------------------

[FILE:  2.6.0-test5/drivers/usb/input/hiddev.c]
[FUNC:  hiddev_connect]
[LINES: 723-730]
[VAR:   hiddev]
 718:			break;
 719:
 720:	if (i == hid->maxcollection && (hid->quirks & HID_QUIRK_HIDDEV) == 0)
 721:		return -1;
 722:
START -->
 723: 	if (!(hiddev = kmalloc(sizeof(struct hiddev), GFP_KERNEL)))
 724:		return -1;
 725:	memset(hiddev, 0, sizeof(struct hiddev));
 726:
 727: 	retval = usb_register_dev(&hiddev->intf, &hiddev_class);
 728:	if (retval) {
 729:		err("Not able to get a minor for this device.");
END -->
 730:		return -1;
 731:	}
 732:
 733:	init_waitqueue_head(&hiddev->wait);
 734:
 735: 	hiddev->minor = hiddev->intf.minor;
---------------------------------------------------------

[FILE:  2.6.0-test5/fs/afs/cell.c]
[FUNC:  afs_cell_create]
[LINES: 58-129]
[VAR:   cell]
  53:	if (!name) BUG(); /* TODO: want to look up "this cell" in the cache */
  54:
  55:	down_write(&afs_cells_sem);
  56:
  57:	/* allocate and initialise a cell record */
START -->
  58:	cell = kmalloc(sizeof(afs_cell_t) + strlen(name) + 1,GFP_KERNEL);
  59:	if (!cell) {
  60:		_leave(" = -ENOMEM");
  61:		return -ENOMEM;
  62:	}
  63:
        ... DELETED 25 lines ...
  89:
  90:		if (sscanf(vllist,"%u.%u.%u.%u",&a,&b,&c,&d)!=4)
  91:			goto badaddr;
  92:
  93:		if (a>255 || b>255 || c>255 || d>255)
GOTO -->
  94:			goto badaddr;
  95:
  96:		cell->vl_addrs[cell->vl_naddrs++].s_addr =
  97:			htonl((a<<24)|(b<<16)|(c<<8)|d);
  98:
  99:		if (cell->vl_naddrs>=16)
        ... DELETED 24 lines ...
 124: badaddr:
 125:	printk("kAFS: bad VL server IP address: '%s'\n",vllist);
 126: error:
 127:	up_write(&afs_cells_sem);
 128:	kfree(afs_cell_root);
END -->
 129:	return ret;
 130:} /* end afs_cell_create() */
 131:
 132:/*****************************************************************************/
 133:/*
 134: * initialise the cell database from module parameters
---------------------------------------------------------

[FILE:  2.6.0-test5/fs/jffs2/scan.c]
[FUNC:  jffs2_scan_medium]
[LINES: 98-109]
[VAR:   flashbuf]
  93:			buf_size = c->sector_size;
  94:		else
  95:			buf_size = PAGE_SIZE;
  96:
  97:		D1(printk(KERN_DEBUG "Allocating readbuf of %d bytes\n", buf_size));
START -->
  98:		flashbuf = kmalloc(buf_size, GFP_KERNEL);
  99:		if (!flashbuf)
 100:			return -ENOMEM;
 101:	}
 102:
 103:	for (i=0; i<c->nr_blocks; i++) {
 104:		struct jffs2_eraseblock *jeb = &c->blocks[i];
 105:
 106:		ret = jffs2_scan_eraseblock(c, jeb, buf_size?flashbuf:(flashbuf+jeb->offset), buf_size);
 107:
 108:		if (ret < 0)
END -->
 109:			return ret;
 110:
 111:		ACCT_PARANOIA_CHECK(jeb);
 112:
 113:		/* Now decide which list to put it on */
 114:		switch(ret) {
---------------------------------------------------------

[FILE:  2.6.0-test5/fs/jffs2/scan.c]
[FUNC:  jffs2_scan_medium]
[LINES: 98-233]
[VAR:   flashbuf]
  93:			buf_size = c->sector_size;
  94:		else
  95:			buf_size = PAGE_SIZE;
  96:
  97:		D1(printk(KERN_DEBUG "Allocating readbuf of %d bytes\n", buf_size));
START -->
  98:		flashbuf = kmalloc(buf_size, GFP_KERNEL);
  99:		if (!flashbuf)
 100:			return -ENOMEM;
 101:	}
 102:
 103:	for (i=0; i<c->nr_blocks; i++) {
        ... DELETED 124 lines ...
 228:	}
 229:	if (c->nr_erasing_blocks) {
 230:		if ( !c->used_size && ((empty_blocks+bad_blocks)!= c->nr_blocks || bad_blocks == c->nr_blocks) ) {
 231:			printk(KERN_NOTICE "Cowardly refusing to erase blocks on filesystem with no valid JFFS2 nodes\n");
 232:			printk(KERN_NOTICE "empty_blocks %d, bad_blocks %d, c->nr_blocks %d\n",empty_blocks,bad_blocks,c->nr_blocks);
END -->
 233:			return -EIO;
 234:		}
 235:		jffs2_erase_pending_trigger(c);
 236:	}
 237:	if (buf_size)
 238:		kfree(flashbuf);
---------------------------------------------------------

[FILE:  2.6.0-test5/fs/nfsd/nfsctl.c]
[FUNC:  TA_write]
[LINES: 105-120]
[VAR:   ar]
 100:	if (file->private_data) 
 101:		return -EINVAL; /* only one write allowed per open */
 102:	if (size > PAGE_SIZE - sizeof(struct argresp))
 103:		return -EFBIG;
 104:
START -->
 105:	ar = kmalloc(PAGE_SIZE, GFP_KERNEL);
 106:	if (!ar)
 107:		return -ENOMEM;
 108:	ar->size = 0;
 109:	down(&file->f_dentry->d_inode->i_sem);
 110:	if (file->private_data)
        ... DELETED 4 lines ...
 115:	if (rv) {
 116:		kfree(ar);
 117:		return rv;
 118:	}
 119:	if (copy_from_user(ar->data, buf, size))
END -->
 120:		return -EFAULT;
 121:	
 122:	rv =  write_op[ino](file, ar->data, size);
 123:	if (rv>0) {
 124:		ar->size = rv;
 125:		rv = size;
---------------------------------------------------------

[FILE:  2.6.0-test5/net/ipv4/igmp.c]
[FUNC:  igmpv3_newpack]
[LINES: 274-284]
[VAR:   skb]
 269:	struct sk_buff *skb;
 270:	struct rtable *rt;
 271:	struct iphdr *pip;
 272:	struct igmpv3_report *pig;
 273:
START -->
 274:	skb = alloc_skb(size + dev->hard_header_len + 15, GFP_ATOMIC);
 275:	if (skb == NULL)
 276:		return 0;
 277:
 278:	{
 279:		struct flowi fl = { .oif = dev->ifindex,
 280:				    .nl_u = { .ip4_u = {
 281:				    .daddr = IGMPV3_ALL_MCR } },
 282:				    .proto = IPPROTO_IGMP };
 283:		if (ip_route_output_key(&rt, &fl))
END -->
 284:			return 0;
 285:	}
 286:	if (rt->rt_src == 0) {
 287:		ip_rt_put(rt);
 288:		return 0;
 289:	}
---------------------------------------------------------

[FILE:  2.6.0-test5/net/ipv4/igmp.c]
[FUNC:  igmpv3_newpack]
[LINES: 274-288]
[VAR:   skb]
 269:	struct sk_buff *skb;
 270:	struct rtable *rt;
 271:	struct iphdr *pip;
 272:	struct igmpv3_report *pig;
 273:
START -->
 274:	skb = alloc_skb(size + dev->hard_header_len + 15, GFP_ATOMIC);
 275:	if (skb == NULL)
 276:		return 0;
 277:
 278:	{
 279:		struct flowi fl = { .oif = dev->ifindex,
        ... DELETED 3 lines ...
 283:		if (ip_route_output_key(&rt, &fl))
 284:			return 0;
 285:	}
 286:	if (rt->rt_src == 0) {
 287:		ip_rt_put(rt);
END -->
 288:		return 0;
 289:	}
 290:
 291:	skb->dst = &rt->u.dst;
 292:	skb->dev = dev;
 293:
---------------------------------------------------------

[FILE:  2.6.0-test5/net/irda/irlmp.c]
[FUNC:  irlmp_open_lsap]
[LINES: 161-183]
[VAR:   self]
 156:			return NULL;
 157:	} else if (irlmp_slsap_inuse(slsap_sel))
 158:		return NULL;
 159:
 160:	/* Allocate new instance of a LSAP connection */
START -->
 161:	self = kmalloc(sizeof(struct lsap_cb), GFP_ATOMIC);
 162:	if (self == NULL) {
 163:		ERROR("%s: can't allocate memory", __FUNCTION__);
 164:		return NULL;
 165:	}
 166:	memset(self, 0, sizeof(struct lsap_cb));
        ... DELETED 11 lines ...
 178:		self->dlsap_sel = LSAP_ANY;
 179:	/* self->connected = FALSE; -> already NULL via memset() */
 180:
 181:	init_timer(&self->watchdog_timer);
 182:
END -->
 183:	ASSERT(notify->instance != NULL, return NULL;);
 184:	self->notify = *notify;
 185:
 186:	self->lsap_state = LSAP_DISCONNECTED;
 187:
 188:	/* Insert into queue of unconnected LSAPs */
---------------------------------------------------------

[FILE:  2.6.0-test5/net/sunrpc/auth_gss/gss_mech_switch.c]
[FUNC:  gss_mech_register]
[LINES: 67-74]
[VAR:   gm]
  62:int
  63:gss_mech_register(struct xdr_netobj * mech_type, struct gss_api_ops * ops)
  64:{
  65:	struct gss_api_mech *gm;
  66:
START -->
  67:	if (!(gm = kmalloc(sizeof(*gm), GFP_KERNEL))) {
  68:		printk("Failed to allocate memory in gss_mech_register");
  69:		return -1;
  70:	}
  71:	gm->gm_oid.len = mech_type->len;
  72:	if (!(gm->gm_oid.data = kmalloc(mech_type->len, GFP_KERNEL))) {
  73:		printk("Failed to allocate memory in gss_mech_register");
END -->
  74:		return -1;
  75:	}
  76:	memcpy(gm->gm_oid.data, mech_type->data, mech_type->len);
  77:	/* We're counting the reference in the registered_mechs list: */
  78:	atomic_set(&gm->gm_count, 1);
  79:	gm->gm_ops = ops;
---------------------------------------------------------

[FILE:  2.6.0-test5/net/sunrpc/auth_gss/gss_pseudoflavors.c]
[FUNC:  gss_register_triple]
[LINES: 74-97]
[VAR:   triple]
  69:gss_register_triple(u32 pseudoflavor, struct gss_api_mech *mech,
  70:			  u32 qop, u32 service)
  71:{
  72:	struct sup_sec_triple *triple;
  73:
START -->
  74:	if (!(triple = kmalloc(sizeof(*triple), GFP_KERNEL))) {
  75:		printk("Alloc failed in gss_register_triple");
  76:		goto err;
  77:	}
  78:	triple->pseudoflavor = pseudoflavor;
  79:	triple->mech = gss_mech_get_by_OID(&mech->gm_oid);
        ... DELETED 1 lines ...
  81:	triple->service = service;
  82:
  83:	spin_lock(&registered_triples_lock);
  84:	if (do_lookup_triple_by_pseudoflavor(pseudoflavor)) {
  85:		printk("Registered pseudoflavor %d again\n", pseudoflavor);
GOTO -->
  86:		goto err_unlock;
  87:	}
  88:	list_add(&triple->triples, &registered_triples);
  89:	spin_unlock(&registered_triples_lock);
  90:	dprintk("RPC: registered pseudoflavor %d\n", pseudoflavor);
  91:
  92:	return 0;
  93:
  94:err_unlock:
  95:	spin_unlock(&registered_triples_lock);
  96:err:
END -->
  97:	return -1;
  98:}
  99:
 100:int
 101:gss_unregister_triple(u32 pseudoflavor)
 102:{
---------------------------------------------------------

[FILE:  2.6.0-test5/security/selinux/selinuxfs.c]
[FUNC:  TA_write]
[LINES: 253-269]
[VAR:   ar]
 248:	if (file->private_data)
 249:		return -EINVAL; /* only one write allowed per open */
 250:	if (size > PAYLOAD_SIZE - 1) /* allow one byte for null terminator */
 251:		return -EFBIG;
 252:
START -->
 253:	ar = kmalloc(PAGE_SIZE, GFP_KERNEL);
 254:	if (!ar)
 255:		return -ENOMEM;
 256:	memset(ar, 0, PAGE_SIZE); /* clear buffer, particularly last byte */
 257:	ar->size = 0;
 258:	down(&file->f_dentry->d_inode->i_sem);
        ... DELETED 5 lines ...
 264:	if (rv) {
 265:		kfree(ar);
 266:		return rv;
 267:	}
 268:	if (copy_from_user(ar->data, buf, size))
END -->
 269:		return -EFAULT;
 270:
 271:	rv =  write_op[ino](file, ar->data, size);
 272:	if (rv>0) {
 273:		ar->size = rv;
 274:		rv = size;
---------------------------------------------------------

[FILE:  2.6.0-test5/security/selinux/ss/mls.c]
[FUNC:  mls_read_user]
[LINES: 543-561]
[VAR:   r]
 538:		goto out;
 539:	}
 540:	nel = le32_to_cpu(buf[0]);
 541:	l = NULL;
 542:	for (i = 0; i < nel; i++) {
START -->
 543:		r = kmalloc(sizeof(*r), GFP_ATOMIC);
 544:		if (!r) {
 545:			rc = -ENOMEM;
 546:			goto out;
 547:		}
 548:		memset(r, 0, sizeof(*r));
 549:
 550:		rc = mls_read_range_helper(&r->range, fp);
 551:		if (rc)
GOTO -->
 552:			goto out;
 553:
 554:		if (l)
 555:			l->next = r;
 556:		else
 557:			usrdatum->ranges = r;
 558:		l = r;
 559:	}
 560:out:
END -->
 561:	return rc;
 562:}
 563:
 564:int mls_read_nlevels(struct policydb *p, void *fp)
 565:{
 566:	u32 *buf;
---------------------------------------------------------

[FILE:  2.6.0-test5/security/selinux/ss/policydb.c]
[FUNC:  policydb_read]
[LINES: 1232-1427]
[VAR:   c]
1227:			goto bad;
1228:		}
1229:		nel = le32_to_cpu(buf[0]);
1230:		l = NULL;
1231:		for (j = 0; j < nel; j++) {
START -->
1232:			c = kmalloc(sizeof(*c), GFP_KERNEL);
1233:			if (!c) {
1234:				rc = -ENOMEM;
1235:				goto bad;
1236:			}
1237:			memset(c, 0, sizeof(*c));
        ... DELETED 182 lines ...
1420:		}
1421:	}
1422:
1423:	rc = mls_read_trusted(p, fp);
1424:	if (rc)
GOTO -->
1425:		goto bad;
1426:out:
END -->
1427:	return rc;
1428:bad:
1429:	policydb_destroy(p);
1430:	goto out;
---------------------------------------------------------

[FILE:  2.6.0-test5/security/selinux/ss/policydb.c]
[FUNC:  policydb_read]
[LINES: 1334-1427]
[VAR:   newgenfs]
1329:	}
1330:	nel = le32_to_cpu(buf[0]);
1331:	genfs_p = NULL;
1332:	rc = -EINVAL;
1333:	for (i = 0; i < nel; i++) {
START -->
1334:		newgenfs = kmalloc(sizeof(*newgenfs), GFP_KERNEL);
1335:		if (!newgenfs) {
1336:			rc = -ENOMEM;
1337:			goto bad;
1338:		}
1339:		memset(newgenfs, 0, sizeof(*newgenfs));
        ... DELETED 5 lines ...
1345:		if (!buf)
1346:			goto bad;
1347:		newgenfs->fstype = kmalloc(len + 1,GFP_KERNEL);
1348:		if (!newgenfs->fstype) {
1349:			rc = -ENOMEM;
GOTO -->
1350:			goto bad;
1351:		}
1352:		memcpy(newgenfs->fstype, buf, len);
1353:		newgenfs->fstype[len] = 0;
1354:		for (genfs_p = NULL, genfs = p->genfs; genfs;
1355:		     genfs_p = genfs, genfs = genfs->next) {
1356:			if (strcmp(newgenfs->fstype, genfs->fstype) == 0) {
1357:				printk(KERN_ERR "security:  dup genfs "
1358:				       "fstype %s\n", newgenfs->fstype);
GOTO -->
1359:				goto bad;
1360:			}
1361:			if (strcmp(newgenfs->fstype, genfs->fstype) < 0)
1362:				break;
1363:		}
1364:		newgenfs->next = genfs;
        ... DELETED 57 lines ...
1422:
1423:	rc = mls_read_trusted(p, fp);
1424:	if (rc)
1425:		goto bad;
1426:out:
END -->
1427:	return rc;
1428:bad:
1429:	policydb_destroy(p);
1430:	goto out;
---------------------------------------------------------

[FILE:  2.6.0-test5/security/selinux/ss/policydb.c]
[FUNC:  policydb_read]
[LINES: 1374-1427]
[VAR:   newc]
1369:		buf = next_entry(fp, sizeof(u32));
1370:		if (!buf)
1371:			goto bad;
1372:		nel2 = le32_to_cpu(buf[0]);
1373:		for (j = 0; j < nel2; j++) {
START -->
1374:			newc = kmalloc(sizeof(*newc), GFP_KERNEL);
1375:			if (!newc) {
1376:				rc = -ENOMEM;
1377:				goto bad;
1378:			}
1379:			memset(newc, 0, sizeof(*newc));
        ... DELETED 14 lines ...
1394:			buf = next_entry(fp, sizeof(u32));
1395:			if (!buf)
1396:				goto bad;
1397:			newc->v.sclass = le32_to_cpu(buf[0]);
1398:			if (context_read_and_validate(&newc->context[0], p, fp))
GOTO -->
1399:				goto bad;
1400:			for (l = NULL, c = newgenfs->head; c;
1401:			     l = c, c = c->next) {
1402:				if (!strcmp(newc->u.name, c->u.name) &&
1403:				    (!c->v.sclass || !newc->v.sclass ||
1404:				     newc->v.sclass == c->v.sclass)) {
1405:					printk(KERN_ERR "security:  dup genfs "
1406:					       "entry (%s,%s)\n",
1407:					       newgenfs->fstype, c->u.name);
GOTO -->
1408:					goto bad;
1409:				}
1410:				len = strlen(newc->u.name);
1411:				len2 = strlen(c->u.name);
1412:				if (len > len2)
1413:					break;
        ... DELETED 8 lines ...
1422:
1423:	rc = mls_read_trusted(p, fp);
1424:	if (rc)
1425:		goto bad;
1426:out:
END -->
1427:	return rc;
1428:bad:
1429:	policydb_destroy(p);
1430:	goto out;
---------------------------------------------------------

[FILE:  2.6.0-test5/security/selinux/ss/policydb.c]
[FUNC:  class_read]
[LINES: 759-851]
[VAR:   c]
 754:	}
 755:
 756:	lc = NULL;
 757:	rc = -EINVAL;
 758:	for (i = 0; i < ncons; i++) {
START -->
 759:		c = kmalloc(sizeof(*c), GFP_KERNEL);
 760:		if (!c) {
 761:			rc = -ENOMEM;
 762:			goto bad;
 763:		}
 764:		memset(c, 0, sizeof(*c));
        ... DELETED 64 lines ...
 829:				c->expr = e;
 830:			}
 831:			le = e;
 832:		}
 833:		if (depth != 0)
GOTO -->
 834:			goto bad;
 835:		if (lc) {
 836:			lc->next = c;
 837:		} else {
 838:			cladatum->constraints = c;
 839:		}
        ... DELETED 6 lines ...
 846:
 847:	rc = hashtab_insert(h, key, cladatum);
 848:	if (rc)
 849:		goto bad;
 850:out:
END -->
 851:	return rc;
 852:bad:
 853:	class_destroy(key, cladatum, NULL);
 854:	goto out;
 855:}
 856:
---------------------------------------------------------

[FILE:  2.6.0-test5/sound/oss/emu10k1/midi.c]
[FUNC:  emu10k1_seq_midi_open]
[LINES: 498-514]
[VAR:   midi_dev]
 493:	if (card->open_mode)		/* card is opened native */
 494:		return -EBUSY;
 495:			
 496:	DPF(2, "emu10k1_seq_midi_open()\n");
 497:	
START -->
 498:	if ((midi_dev = (struct emu10k1_mididevice *) kmalloc(sizeof(*midi_dev), GFP_KERNEL)) == NULL)
 499:		return -EINVAL;
 500:
 501:	midi_dev->card = card;
 502:	midi_dev->mistate = MIDIIN_STATE_STOPPED;
 503:	init_waitqueue_head(&midi_dev->oWait);
        ... DELETED 5 lines ...
 509:
 510:	dsCardMidiOpenInfo.refdata = (unsigned long) midi_dev;
 511:
 512:	if (emu10k1_mpuout_open(card, &dsCardMidiOpenInfo) < 0) {
 513:		ERROR();
END -->
 514:		return -ENODEV;
 515:	}
 516:
 517:	card->seq_mididev = midi_dev;
 518:		
 519:	return 0;
---------------------------------------------------------

[FILE:  2.6.0-test5/sound/oss/ymfpci.c]
[FUNC:  ymf_probe_one]
[LINES: 2530-2641]
[VAR:   codec]
2525:		printk(KERN_ERR "ymfpci: pci_enable_device failed\n");
2526:		return err;
2527:	}
2528:	base = pci_resource_start(pcidev, 0);
2529:
START -->
2530:	if ((codec = kmalloc(sizeof(ymfpci_t), GFP_KERNEL)) == NULL) {
2531:		printk(KERN_ERR "ymfpci: no core\n");
2532:		return -ENOMEM;
2533:	}
2534:	memset(codec, 0, sizeof(*codec));
2535:
        ... DELETED 11 lines ...
2547:		goto out_free;
2548:	}
2549:
2550:	if ((codec->reg_area_virt = ioremap(base, 0x8000)) == NULL) {
2551:		printk(KERN_ERR "ymfpci: unable to map registers\n");
GOTO -->
2552:		goto out_release_region;
2553:	}
2554:
2555:	pci_set_master(pcidev);
2556:
2557:	printk(KERN_INFO "ymfpci: %s at 0x%lx IRQ %d\n",
        ... DELETED 78 lines ...
2636: out_release_region:
2637:	release_mem_region(pci_resource_start(pcidev, 0), 0x8000);
2638: out_free:
2639:	if (codec->ac97_codec[0])
2640:		ac97_release_codec(codec->ac97_codec[0]);
END -->
2641:	return -ENODEV;
2642:}
2643:
2644:static void __devexit ymf_remove_one(struct pci_dev *pcidev)
2645:{
2646:	__u16 ctrl;
---------------------------------------------------------

