Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316488AbSFJD4J>; Sun, 9 Jun 2002 23:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSFJD4I>; Sun, 9 Jun 2002 23:56:08 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:21652 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S316488AbSFJDzX>;
	Sun, 9 Jun 2002 23:55:23 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200206100355.UAA17040@csl.Stanford.EDU>
Subject: [CHECKER] 54 missing null pointer checks in 2.4.17
To: linux-kernel@vger.kernel.org
Date: Sun, 9 Jun 2002 20:55:22 -0700 (PDT)
Cc: mc@cs.Stanford.EDU
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Enclosed are 54 potential errors where code gets a pointer from a
possibly-failing routine (kmalloc, etc) and dereferences it without
checking.  Many follow the simple pattern of alloc-memset:

	dev->priv = kmalloc(sizeof(struct awc_private),GFP_KERNEL );
	memset(dev->priv,0,sizeof(struct awc_private));

If these kind of errors are useful, let me know --- there are *many*
others that I didn't inspect.

Dawson

# BUGs	|	File Name
6	|	/drivers/se401.c
5	|	/char/sis_ds.c
3	|	/drivers/aironet4500_card.c
2	|	/drivers/catc.c
2	|	/drivers/hosts.c
2	|	/net/sdla_fr.c
2	|	/net/cosa.c
2	|	/fs/dcache.c
2	|	/drivers/cpqphp_proc.c
2	|	/net/skge.c
2	|	/drivers/ide-probe.c
1	|	/video/sis_main.c
1	|	/media/saa7110.c
1	|	/drivers/ide-tape.c
1	|	/fs/sysctl.c
1	|	/net/sch_gred.c
1	|	/drivers/pci2220i.c
1	|	/fs/inode.c
1	|	/drivers/btaudio.c
1	|	/drivers/bonding.c
1	|	/drivers/dpt_i2o.c
1	|	/drivers/i2c-proc.c
1	|	/drivers/pppoe.c
1	|	/net/sdla_chdlc.c
1	|	/fs/binsert.c
1	|	/scsi/linit.c
1	|	/fs/journal.c
1	|	/drivers/cpqfcTScontrol.c
1	|	/drivers/DAC960.c
1	|	/net/airo_cs.c
1	|	/char/drm_context.h
1	|	/drivers/eexpress.c
1	|	/char/riotable.c
1	|	/net/skfddi.c
1	|	/drivers/ide-scsi.c


############################################################
# 2.4.17 specific errors

#
---------------------------------------------------------
[BUG] funny --- checking the wrong index.
/u2/engler/mc/oses/linux/2.4.17/net/sched/sch_gred.c:443:gred_change: ERROR:NULL:438:443:Passing unknown ptr "(*table).tab[(*table).def]"! as arg 0 to call "memset"! set by 'kmalloc':438 [COUNTER=kmalloc:438] [fit=1] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -4.35889894354067]
        	over-written 
		*/

		if (table->tab[table->def] == NULL) {
			table->tab[table->def]=
Start --->
				kmalloc(sizeof(struct gred_sched_data), GFP_KERNEL);
			if (NULL == table->tab[ctl->DP])
				return -ENOMEM;

			memset(table->tab[table->def], 0,
Error --->
			       (sizeof(struct gred_sched_data)));
		}
		q= table->tab[table->def]; 
		q->DP=table->def;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/aironet4500_card.c:570:awc4500_isa_probe: ERROR:NULL:569:570:Passing unknown ptr "(*dev).priv"! as arg 0 to call "memset"! set by 'kmalloc':569 [COUNTER=kmalloc:569] [fit=1] [fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -4.35889894354067]
			if (!dev) {
				release_region(isa_ioaddr, AIRONET4X00_IO_SIZE);
				return (card == 0) ? -ENOMEM : 0;
			}
		}
Start --->
		dev->priv = kmalloc(sizeof(struct awc_private),GFP_KERNEL );
Error --->
		memset(dev->priv,0,sizeof(struct awc_private));
		if (!dev->priv) {
			printk(KERN_CRIT "aironet4x00: could not allocate device private, some unstability may follow\n");
			return -1;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/bonding.c:1671:bond_xmit_activebackup: ERROR:NULL:1670:1671:Passing unknown ptr "arp_target_hw_addr"! as arg 0 to call "memcpy"! set by 'kmalloc':1670 [COUNTER=kmalloc:1670] [fit=1] [fit_fn=3] [fn_ex=0] [fn_counter=1] [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -4.35889894354067]
	   to use a broadcast address */
	if ( (arp_interval > 0) && (arp_target_hw_addr==NULL) &&
	     (skb->protocol == __constant_htons(ETH_P_IP) ) ) {
		struct ethhdr *eth_hdr = 
			(struct ethhdr *) (((char *)skb->data));
Start --->
		arp_target_hw_addr = kmalloc(ETH_ALEN, GFP_KERNEL);
Error --->
		memcpy(arp_target_hw_addr, eth_hdr->h_dest, ETH_ALEN);
	}

	read_lock_irqsave(&bond->lock, flags);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/video/sis/sis_main.c:1318:sisfb_poh_new_node: ERROR:NULL:1316:1318:Using ptr "poha" illegally! set by 'kmalloc':1316 [COUNTER=kmalloc:1316] [fit=1] [fit_fn=4] [fn_ex=0] [fn_counter=1] [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -4.35889894354067]
	unsigned long cOhs;
	SIS_OHALLOC *poha;
	SIS_OH *poh;

	if (sisfb_heap.poh_freelist == NULL) {
Start --->
		poha = kmalloc (OH_ALLOC_SIZE, GFP_KERNEL);

Error --->
		poha->poha_next = sisfb_heap.poha_chain;
		sisfb_heap.poha_chain = poha;

		cOhs =
---------------------------------------------------------
[BUG] (synonums aren't working)
/u2/engler/mc/oses/linux/2.4.17/drivers/net/eexpress.c:1088:eexp_hw_probe: ERROR:NULL:1083:1088:Using ptr "lp" illegally! set by 'kmalloc':1083 [COUNTER=kmalloc:1083] [fit=1] [fit_fn=5] [fn_ex=0] [fn_counter=1] [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -4.35889894354067]
		}

		buswidth = !((setupval & 0x400) >> 10);
	}

Start --->
	dev->priv = lp = kmalloc(sizeof(struct net_local), GFP_KERNEL);
	if (!dev->priv)
		return -ENOMEM;

	memset(dev->priv, 0, sizeof(struct net_local));
Error --->
	spin_lock_init(&lp->lock);

 	printk("(IRQ %d, %s connector, %d-bit bus", dev->irq, 
 	       eexp_ifmap[dev->if_port], buswidth?8:16);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/media/video/saa7110.c:211:saa7110_attach: ERROR:NULL:204:211:Passing unknown ptr "decoder"! as arg 0 to call "memset"! set by 'kmalloc':204 [COUNTER=kmalloc:204] [fit=1] [fit_fn=6] [fn_ex=0] [fn_counter=1] [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -4.35889894354067]
		0xFE, 0x01, 0xCF, 0x0F, 0x03, 0x01, 0x81, 0x03,
		0x40, 0x75, 0x01, 0x8C, 0x03};
	struct	saa7110*	decoder;
	int			rv;

Start --->
	device->data = decoder = kmalloc(sizeof(struct saa7110), GFP_KERNEL);
	if (device->data == 0)
		return -ENOMEM;

	MOD_INC_USE_COUNT;

	/* clear our private data */
Error --->
	memset(decoder, 0, sizeof(struct saa7110));
	strcpy(device->name, "saa7110");
	decoder->bus = device->bus;
	decoder->addr = device->addr;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/aironet4500_card.c:396:awc4500_pnp_probe: ERROR:NULL:395:396:Passing unknown ptr "(*dev).priv"! as arg 0 to call "memset"! set by 'kmalloc':395 [COUNTER=kmalloc:395] [fit=1] [fit_fn=7] [fn_ex=0] [fn_counter=1] [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -4.35889894354067]
				isapnp_deactivate(logdev->PNP_DEV_NUMBER);
				isapnp_cfg_end();
				return -ENOMEM;
			}
		}
Start --->
		dev->priv = kmalloc(sizeof(struct awc_private),GFP_KERNEL );
Error --->
		memset(dev->priv,0,sizeof(struct awc_private));
		if (!dev->priv) {
			printk(KERN_CRIT "aironet4x00: could not allocate device private, some unstability may follow\n");
			return -1;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/char/drm/sis_ds.c:175:calloc: ERROR:NULL:174:175:Passing unknown ptr "addr"! as arg 0 to call "memset"! set by 'kmalloc':174 [COUNTER=kmalloc:174] [fit=1] [fit_fn=8] [fn_ex=0] [fn_counter=1] [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -4.35889894354067]
#define fprintf(fmt, arg...) do{}while(0)

static void *calloc(size_t nmemb, size_t size)
{
  void *addr;
Start --->
  addr = kmalloc(nmemb*size, GFP_KERNEL);
Error --->
  memset(addr, 0, nmemb*size);
  return addr;
}
#define free(n) kfree(n)
---------------------------------------------------------
[BUG] checking the wrong thing.
/u2/engler/mc/oses/linux/2.4.17/drivers/scsi/dpt_i2o.c:1507:adpt_i2o_parse_lct: ERROR:NULL:1503:1507:Passing unknown ptr "(*pDev).next_lun"! as arg 0 to call "memset"! set by 'kmalloc':1503 [COUNTER=kmalloc:1503] [fit=1] [fit_fn=9] [fn_ex=0] [fn_counter=1] [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -4.35889894354067]
					memset(pDev,0,sizeof(struct adpt_device));
				} else {
					for( pDev = pHba->channel[bus_no].device[scsi_id];	
							pDev->next_lun; pDev = pDev->next_lun){
					}
Start --->
					pDev->next_lun = kmalloc(sizeof(struct adpt_device),GFP_KERNEL);
					if(pDev == NULL) {
						return -ENOMEM;
					}
Error --->
					memset(pDev->next_lun,0,sizeof(struct adpt_device));
					pDev = pDev->next_lun;
				}
				pDev->tid = tid;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/fs/qnx4/inode.c:321:qnx4_checkroot: ERROR:NULL:320:321:Passing unknown ptr "(((*sb).u).qnx4_sb).BitMap"! as arg 0 to call "memcpy"! set by 'kmalloc':320 [COUNTER=kmalloc:320] [fit=1] [fit_fn=11] [fn_ex=0] [fn_counter=1] [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -4.35889894354067]
				rootdir = (struct qnx4_inode_entry *) (bh->b_data + i * QNX4_DIR_ENTRY_SIZE);
				if (rootdir->di_fname != NULL) {
					QNX4DEBUG(("Rootdir entry found : [%s]\n", rootdir->di_fname));
					if (!strncmp(rootdir->di_fname, QNX4_BMNAME, sizeof QNX4_BMNAME)) {
						found = 1;
Start --->
						sb->u.qnx4_sb.BitMap = kmalloc( sizeof( struct qnx4_inode_entry ), GFP_KERNEL );
Error --->
						memcpy( sb->u.qnx4_sb.BitMap, rootdir, sizeof( struct qnx4_inode_entry ) );	/* keep bitmap inode known */
						break;
					}
				}
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/ide/ide-probe.c:762:init_gendisk: ERROR:NULL:761:762:Using ptr "gd" illegally! set by 'kmalloc':761 [COUNTER=kmalloc:761] [fit=1] [fit_fn=12] [fn_ex=0] [fn_counter=1] [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -4.35889894354067]
	for (units = MAX_DRIVES; units > 0; --units) {
		if (hwif->drives[units-1].present)
			break;
	}
	minors    = units * (1<<PARTN_BITS);
Start --->
	gd        = kmalloc (sizeof(struct gendisk), GFP_KERNEL);
Error --->
	gd->sizes = kmalloc (minors * sizeof(int), GFP_KERNEL);
	gd->part  = kmalloc (minors * sizeof(struct hd_struct), GFP_KERNEL);
	bs        = kmalloc (minors*sizeof(int), GFP_KERNEL);
	max_sect  = kmalloc (minors*sizeof(int), GFP_KERNEL);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/wan/sdla_chdlc.c:1068:if_open: ERROR:NULL:1067:1068:Passing unknown ptr "(*chdlc_priv_area).bh_head"! as arg 0 to call "memset"! set by 'kmalloc':1067 [COUNTER=kmalloc:1067] [fit=1] [fit_fn=13] [fn_ex=0] [fn_counter=1] [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -4.35889894354067]
	chdlc_priv_area->common.wanpipe_task.routine = (void *)(void *)chdlc_bh;
	chdlc_priv_area->common.wanpipe_task.data = dev;

	/* Allocate and initialize BH circular buffer */
	/* Add 1 to MAX_BH_BUFF so we don't have test with (MAX_BH_BUFF-1) */
Start --->
	chdlc_priv_area->bh_head = kmalloc((sizeof(bh_data_t)*(MAX_BH_BUFF+1)),GFP_ATOMIC);
Error --->
	memset(chdlc_priv_area->bh_head,0,(sizeof(bh_data_t)*(MAX_BH_BUFF+1)));
	atomic_set(&chdlc_priv_area->bh_buff_used, 0);
#endif
 
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/ide/ide-probe.c:768:init_gendisk: ERROR:NULL:763:768:Passing unknown ptr "(*gd).part"! as arg 0 to call "memset"! set by 'kmalloc':763 [COUNTER=kmalloc:763] [fit=1] [fit_fn=14] [fn_ex=0] [fn_counter=1] [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -4.35889894354067]
			break;
	}
	minors    = units * (1<<PARTN_BITS);
	gd        = kmalloc (sizeof(struct gendisk), GFP_KERNEL);
	gd->sizes = kmalloc (minors * sizeof(int), GFP_KERNEL);
Start --->
	gd->part  = kmalloc (minors * sizeof(struct hd_struct), GFP_KERNEL);
	bs        = kmalloc (minors*sizeof(int), GFP_KERNEL);
	max_sect  = kmalloc (minors*sizeof(int), GFP_KERNEL);
	max_ra    = kmalloc (minors*sizeof(int), GFP_KERNEL);

Error --->
	memset(gd->part, 0, minors * sizeof(struct hd_struct));

	/* cdroms and msdos f/s are examples of non-1024 blocksizes */
	blksize_size[hwif->major] = bs;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/usb/catc.c:621:catc_probe: ERROR:NULL:620:621:Passing unknown ptr "catc"! as arg 0 to call "memset"! set by 'kmalloc':620 [COUNTER=kmalloc:620] [fit=1] [fit_fn=15] [fn_ex=0] [fn_counter=1] [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -4.35889894354067]
	if (usb_set_interface(usbdev, ifnum, 1)) {
                err("Can't set altsetting 1.");
		return NULL;
	}

Start --->
	catc = kmalloc(sizeof(struct catc), GFP_KERNEL);
Error --->
	memset(catc, 0, sizeof(struct catc));

	netdev = init_etherdev(0, 0);

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/scsi/ide-scsi.c:662:idescsi_kmalloc_bh: ERROR:NULL:660:662:Passing unknown ptr "bh"! as arg 0 to call "memset"! set by 'kmalloc':660 [COUNTER=kmalloc:660] [fit=1] [fit_fn=16] [fn_ex=0] [fn_counter=1] [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -4.35889894354067]

static inline struct buffer_head *idescsi_kmalloc_bh (int count)
{
	struct buffer_head *bh, *bhp, *first_bh;

Start --->
	if ((first_bh = bhp = bh = kmalloc (sizeof(struct buffer_head), GFP_ATOMIC)) == NULL)
		goto abort;
Error --->
	memset (bh, 0, sizeof (struct buffer_head));
	bh->b_reqnext = NULL;
	while (--count) {
		if ((bh = kmalloc (sizeof(struct buffer_head), GFP_ATOMIC)) == NULL)
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/char/rio/riotable.c:977:RIOReMapPorts: ERROR:NULL:976:977:Passing unknown ptr "(*PortP).TxRingBuffer"! as arg 0 to call "memset"! set by 'kmalloc':976 [COUNTER=kmalloc:976] [fit=1] [fit_fn=17] [fn_ex=0] [fn_counter=1] [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -4.35889894354067]
		PortP->closes = 0;
		PortP->ioctls = 0;
		if ( PortP->TxRingBuffer )
			bzero( PortP->TxRingBuffer, p->RIOBufferSize );
		else if ( p->RIOBufferSize ) {
Start --->
			PortP->TxRingBuffer = sysbrk(p->RIOBufferSize);
Error --->
			bzero( PortP->TxRingBuffer, p->RIOBufferSize );
		}
		PortP->TxBufferOut	= 0;
		PortP->TxBufferIn	 = 0;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/i2c/i2c-proc.c:122:i2c_create_name: ERROR:NULL:121:122:Passing unknown ptr "*name"! as arg 0 to call "strcpy"! set by 'kmalloc':121 [COUNTER=kmalloc:121] [fit=1] [fit_fn=18] [fn_ex=0] [fn_counter=1] [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -4.35889894354067]
	else {
		if ((id = i2c_adapter_id(adapter)) < 0)
			return -ENOENT;
		sprintf(name_buffer, "%s-i2c-%d-%02x", prefix, id, addr);
	}
Start --->
	*name = kmalloc(strlen(name_buffer) + 1, GFP_KERNEL);
Error --->
	strcpy(*name, name_buffer);
	return 0;
}

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/wan/sdla_fr.c:4197:send_inarp_request: ERROR:NULL:4195:4197:Using ptr "ArpPacket" illegally! set by 'kmalloc':4195 [COUNTER=kmalloc:4195] [fit=1] [fit_fn=19] [fn_ex=0] [fn_counter=1] [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -4.35889894354067]

	in_dev = dev->ip_ptr;

	if(in_dev != NULL ) {	

Start --->
		ArpPacket = kmalloc(sizeof(arphdr_1490_t) + sizeof(arphdr_fr_t), GFP_ATOMIC);
		/* SNAP Header indicating ARP */
Error --->
		ArpPacket->control	= 0x03;
		ArpPacket->pad		= 0x00;
		ArpPacket->NLPID	= 0x80;
		ArpPacket->OUI[0]	= 0;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/wan/sdla_fr.c:1340:if_open: ERROR:NULL:1339:1340:Passing unknown ptr "(*chan).bh_head"! as arg 0 to call "memset"! set by 'kmalloc':1339 [COUNTER=kmalloc:1339] [fit=1] [fit_fn=21] [fn_ex=0] [fn_counter=1] [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -4.35889894354067]
	chan->common.wanpipe_task.sync = 0;
	chan->common.wanpipe_task.routine = (void *)(void *)fr_bh;
	chan->common.wanpipe_task.data = dev;

	/* Allocate and initialize BH circular buffer */
Start --->
	chan->bh_head = kmalloc((sizeof(bh_data_t)*MAX_BH_BUFF),GFP_ATOMIC);
Error --->
	memset(chan->bh_head,0,(sizeof(bh_data_t)*MAX_BH_BUFF));
	atomic_set(&chan->bh_buff_used, 0);
#endif

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/sound/btaudio.c:888:btaudio_probe: ERROR:NULL:887:888:Passing unknown ptr "bta"! as arg 0 to call "memset"! set by 'kmalloc':887 [COUNTER=kmalloc:887] [fit=1] [fit_fn=22] [fn_ex=0] [fn_counter=1] [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -4.35889894354067]
				pci_resource_len(pci_dev,0),
				"btaudio")) {
		return -EBUSY;
	}

Start --->
	bta = kmalloc(sizeof(*bta),GFP_ATOMIC);
Error --->
	memset(bta,0,sizeof(*bta));

	bta->pci  = pci_dev;
	bta->irq  = pci_dev->irq;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/char/drm/sis_ds.c:54:setInit: ERROR:NULL:52:54:Using ptr "set" illegally! set by 'kmalloc':52 [COUNTER=kmalloc:52] [fit=1] [fit_fn=23] [fn_ex=0] [fn_counter=2] [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -6.16441400296897]
set_t *setInit(void)
{
  int i;
  set_t *set;

Start --->
  set = (set_t *)MALLOC(sizeof(set_t));
  for(i = 0; i < SET_SIZE; i++){
Error --->
    set->list[i].free_next = i+1;    
    set->list[i].alloc_next = -1;
  }    
  set->list[SET_SIZE-1].free_next = -1;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/char/drm/sis_ds.c:57:setInit: ERROR:NULL:52:57:Using ptr "set" illegally! set by 'kmalloc':52 [COUNTER=kmalloc:52] [fit=1] [fit_fn=23] [fn_ex=0] [fn_counter=2] [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -6.16441400296897]
set_t *setInit(void)
{
  int i;
  set_t *set;

Start --->
  set = (set_t *)MALLOC(sizeof(set_t));
  for(i = 0; i < SET_SIZE; i++){
    set->list[i].free_next = i+1;    
    set->list[i].alloc_next = -1;
  }    
Error --->
  set->list[SET_SIZE-1].free_next = -1;
  set->free = 0;
  set->alloc = -1;
  set->trace = -1;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/scsi/hosts.c:178:scsi_register: ERROR:NULL:176:178:Passing unknown ptr "(*shn).name"! as arg 0 to call "strncpy"! set by 'kmalloc':176 [COUNTER=kmalloc:176] [fit=1] [fit_fn=24] [fn_ex=0] [fn_counter=2] [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -6.16441400296897]
        if (!shn) {
                kfree(retval);
                printk(KERN_ERR "scsi: out of memory(2) in scsi_register.\n");
                return NULL;
        }
Start --->
	shn->name = kmalloc(hname_len + 1, GFP_ATOMIC);
	if (hname_len > 0)
Error --->
	    strncpy(shn->name, hname, hname_len);
	shn->name[hname_len] = 0;
	shn->host_no = max_scsi_hosts++;
	shn->host_registered = 1;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/scsi/hosts.c:179:scsi_register: ERROR:NULL:176:179:Using ptr "(*shn).name" illegally! set by 'kmalloc':176 [COUNTER=kmalloc:176] [fit=1] [fit_fn=24] [fn_ex=0] [fn_counter=2] [ex=1399] [counter=26] [z = 5.50002098543802] [fn-z = -6.16441400296897]
        if (!shn) {
                kfree(retval);
                printk(KERN_ERR "scsi: out of memory(2) in scsi_register.\n");
                return NULL;
        }
Start --->
	shn->name = kmalloc(hname_len + 1, GFP_ATOMIC);
	if (hname_len > 0)
	    strncpy(shn->name, hname, hname_len);
Error --->
	shn->name[hname_len] = 0;
	shn->host_no = max_scsi_hosts++;
	shn->host_registered = 1;
	shn->loaded_as_module = 1;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/fs/intermezzo/dcache.c:94:presto_set_dd: ERROR:NULL:93:94:Passing unknown ptr "(*dentry).d_fsdata"! as arg 0 to call "memset"! set by 'kmem_cache_alloc':93 [COUNTER=kmem_cache_alloc:93] [fit=3] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=75] [counter=2] [z = 0.967340923389605] [fn-z = -4.35889894354067]
                return;
        }

        if (dentry->d_inode == NULL) {
                dentry->d_fsdata = kmem_cache_alloc(presto_dentry_slab,
Start --->
                                                    SLAB_KERNEL);
Error --->
                memset(dentry->d_fsdata, 0, sizeof(struct presto_dentry_data));
                presto_d2d(dentry)->dd_count = 1;
                EXIT;
                return;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/fs/intermezzo/dcache.c:119:presto_set_dd: ERROR:NULL:118:119:Passing unknown ptr "(*dentry).d_fsdata"! as arg 0 to call "memset"! set by 'kmem_cache_alloc':118 [COUNTER=kmem_cache_alloc:118] [fit=3] [fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=75] [counter=2] [z = 0.967340923389605] [fn-z = -4.35889894354067]
                presto_d2d(dentry)->dd_count++;
                EXIT;
                return;
        }

Start --->
        dentry->d_fsdata = kmem_cache_alloc(presto_dentry_slab, SLAB_KERNEL);
Error --->
        memset(dentry->d_fsdata, 0, sizeof(struct presto_dentry_data));
        presto_d2d(dentry)->dd_count = 1;
        EXIT;
        return; 
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/scsi/aacraid/linit.c:196:aac_detect: ERROR:NULL:191:196:Using ptr "host_ptr" illegally! set by 'scsi_register':191 [COUNTER=scsi_register:191] [fit=5] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=51] [counter=2] [z = 0.409664769581117] [fn-z = -4.35889894354067]
			 * will need to make two Scsi_Host entries, but there will be only
			 * one Scsi_Host_Template entry. The second argument to scsi_register()
			 * specifies the size of the extra memory we want to hold any device 
			 * specific information.
			 */
Start --->
			host_ptr = scsi_register( template, sizeof(struct aac_dev) );
			/* 
			 * These three parameters can be used to allow for wide SCSI 
			 * and for host adapters that support multiple buses.
			 */
Error --->
			host_ptr->max_id = 17;
			host_ptr->max_lun = 8;
			host_ptr->max_channel = 1;
			host_ptr->irq = dev->irq;		/* Adapter IRQ number */
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/scsi/pci2220i.c:2652:Pci2220i_Detect: ERROR:NULL:2651:2652:Using ptr "pshost" illegally! set by 'scsi_register':2651 [COUNTER=scsi_register:2651] [fit=5] [fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=51] [counter=2] [z = 0.409664769581117] [fn-z = -4.35889894354067]
		scsi_unregister (pshost);
		}

	while ( (pcidev = pci_find_device (VENDOR_PSI, DEVICE_BIGD_1, pcidev)) != NULL )
		{
Start --->
		pshost = scsi_register (tpnt, sizeof(ADAPTER2220I));
Error --->
		padapter = HOSTDATA(pshost);

		if ( GetRegs (pshost, TRUE, pcidev) )
			goto unregister1;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/hotplug/cpqphp_proc.c:156:cpqhp_proc_create_ctrl: ERROR:NULL:155:156:Using ptr "(*ctrl).proc_entry" illegally! set by 'create_proc_entry':155 [COUNTER=create_proc_entry:155] [fit=7] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=88] [counter=4] [z = 0.287018923940967] [fn-z = -4.35889894354067]
int cpqhp_proc_create_ctrl (struct controller *ctrl)
{
	strcpy(ctrl->proc_name, "hpca");
	ctrl->proc_name[3] = 'a' + ctrl->bus;

Start --->
	ctrl->proc_entry = create_proc_entry(ctrl->proc_name, S_IFREG | S_IRUGO, ctrl_proc_root);
Error --->
	ctrl->proc_entry->data = ctrl;
	ctrl->proc_entry->read_proc = &read_ctrl;

	strcpy(ctrl->proc_name2, "slot_a");
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/hotplug/cpqphp_proc.c:162:cpqhp_proc_create_ctrl: ERROR:NULL:161:162:Using ptr "(*ctrl).proc_entry2" illegally! set by 'create_proc_entry':161 [COUNTER=create_proc_entry:161] [fit=7] [fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=88] [counter=4] [z = 0.287018923940967] [fn-z = -4.35889894354067]
	ctrl->proc_entry->data = ctrl;
	ctrl->proc_entry->read_proc = &read_ctrl;

	strcpy(ctrl->proc_name2, "slot_a");
	ctrl->proc_name2[5] = 'a' + ctrl->bus;
Start --->
	ctrl->proc_entry2 = create_proc_entry(ctrl->proc_name2, S_IFREG | S_IRUGO, ctrl_proc_root);
Error --->
	ctrl->proc_entry2->data = ctrl;
	ctrl->proc_entry2->read_proc = &read_dev;

	return 0;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/sk98lin/skge.c:490:skge_probe: ERROR:NULL:489:490:Using ptr "pProcFile" illegally! set by 'create_proc_entry':489 [COUNTER=create_proc_entry:489] [fit=7] [fit_fn=3] [fn_ex=0] [fn_counter=1] [ex=88] [counter=4] [z = 0.287018923940967] [fn-z = -4.35889894354067]
		dev->set_mac_address =	&SkGeSetMacAddr;
		dev->do_ioctl =		&SkGeIoctl;
		dev->change_mtu =	&SkGeChangeMtu;

		pProcFile = create_proc_entry(dev->name, 
Start --->
			S_IFREG | 0444, pSkRootDir);
Error --->
		pProcFile->read_proc = proc_read;
		pProcFile->write_proc = NULL;
		pProcFile->nlink = 1;
		pProcFile->size = sizeof(dev->name+1);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/sk98lin/skge.c:435:skge_probe: ERROR:NULL:433:435:Using ptr "pSkRootDir" illegally! set by 'create_proc_entry':433 [COUNTER=create_proc_entry:433] [fit=7] [fit_fn=4] [fn_ex=0] [fn_counter=1] [ex=88] [counter=4] [z = 0.287018923940967] [fn-z = -4.35889894354067]

	if (!pci_present())		/* is PCI support present? */
		return -ENODEV;

        pSkRootDir = create_proc_entry("sk98lin",
Start --->
                S_IFDIR | S_IWUSR | S_IRUGO | S_IXUGO, proc_net); 

Error --->
	pSkRootDir->owner = THIS_MODULE;

	while((pdev = pci_find_device(PCI_VENDOR_ID_SYSKONNECT,
				      PCI_DEVICE_ID_SYSKONNECT_GE, pdev)) != NULL) {
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/pppoe.c:893:__pppoe_xmit: ERROR:NULL:888:893:Using ptr "skb2" illegally! set by 'skb_clone':888 [COUNTER=skb_clone:888] [fit=8] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=25] [counter=1] [z = 0.26995276239951] [fn-z = -4.35889894354067]
		memcpy(skb_put(skb2, skb->len), skb->data, skb->len);
	} else {
		/* Make a clone so as to not disturb the original skb,
		 * give dev_queue_xmit something it can free.
		 */
Start --->
		skb2 = skb_clone(skb, GFP_ATOMIC);
	}

	ph = (struct pppoe_hdr *) skb_push(skb2, sizeof(struct pppoe_hdr));
	memcpy(ph, &hdr, sizeof(struct pppoe_hdr));
Error --->
	skb2->protocol = __constant_htons(ETH_P_PPP_SES);

	skb2->nh.raw = skb2->data;

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/char/drm/drm_context.h:559:gamma_alloc_queue: ERROR:NULL:558:559:Passing unknown ptr "queue"! as arg 0 to call "memset"! set by 'gamma_alloc':558 [COUNTER=gamma_alloc:558] [fit=9] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=17] [counter=1] [z = -0.108147614087175] [fn-z = -4.35889894354067]
		atomic_dec(&dev->queuelist[i]->use_count);
	}
				/* Allocate a new queue */
	down(&dev->struct_sem);

Start --->
	queue = gamma_alloc(sizeof(*queue), DRM_MEM_QUEUES);
Error --->
	memset(queue, 0, sizeof(*queue));
	atomic_set(&queue->use_count, 1);

	++dev->queue_count;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/scsi/cpqfcTScontrol.c:119:CpqTsCreateTachLiteQues: ERROR:NULL:117:119:Passing unknown ptr "(*cpqfcHBAdata).fcLQ"! as arg 0 to call "memset"! set by 'pci_alloc_consistent':117 [COUNTER=pci_alloc_consistent:117] [fit=11] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=31] [counter=2] [z = -0.279553072340802] [fn-z = -4.35889894354067]
  memset( fcChip->Exchanges, 0, sizeof( FC_EXCHANGES));  


  printk("Allocating %u for LinkQ ", (ULONG)sizeof(FC_LINK_QUE));
  cpqfcHBAdata->fcLQ = pci_alloc_consistent(cpqfcHBAdata->PciDev,
Start --->
				 sizeof( FC_LINK_QUE), &cpqfcHBAdata->fcLQ_dma_handle);
  printk("@ %p (%u elements)\n", cpqfcHBAdata->fcLQ, FC_LINKQ_DEPTH);
Error --->
  memset( cpqfcHBAdata->fcLQ, 0, sizeof( FC_LINK_QUE));

  if( cpqfcHBAdata->fcLQ == NULL ) // fatal error!!
  {
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/skfp/skfddi.c:710:skfp_driver_init: ERROR:NULL:696:710:Passing unknown ptr "(*bp).SharedMemAddr"! as arg 0 to call "memset"! set by 'pci_alloc_consistent':696 [COUNTER=pci_alloc_consistent:696] [fit=11] [fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=31] [counter=2] [z = -0.279553072340802] [fn-z = -4.35889894354067]
	if (bp->SharedMemSize > 0) {
		bp->SharedMemSize += 16;	// for descriptor alignment

		bp->SharedMemAddr = pci_alloc_consistent(&bp->pdev,
							 bp->SharedMemSize,
Start --->
							 &bp->SharedMemDMA);
		if (!bp->SharedMemSize) {
			printk("could not allocate mem for ");
			printk("hardware module: %ld byte\n",
			       bp->SharedMemSize);
			goto fail;
		}
		bp->SharedMemHeap = 0;	// Nothing used yet.

	} else {
		bp->SharedMemAddr = NULL;
		bp->SharedMemHeap = 0;
	}			// SharedMemSize > 0

Error --->
	memset(bp->SharedMemAddr, 0, bp->SharedMemSize);

	card_stop(smc);		// Reset adapter.

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/fs/hfs/binsert.c:423:binsert: ERROR:NULL:379:423:Passing unknown ptr "tmpkey"! as arg 0 to call "memcpy"! set by 'hfs_malloc':379 [COUNTER=hfs_malloc:379] [fit=15] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=9] [counter=1] [z = -0.72547625011001] [fn-z = -4.35889894354067]
{
	struct hfs_bnode_ref left, right, other;
	struct hfs_btree *tree = brec->tree;
	struct hfs_belem *belem = brec->bottom;
	int tmpsize = 1 + tree->bthKeyLen;
Start --->
	struct hfs_bkey *tmpkey = hfs_malloc(tmpsize);

	... DELETED 38 lines ...

		data = &node;
		datasize = sizeof(node);
		node = htonl(right.bn->node);
		key = tmpkey;
		keysize = tree->bthKeyLen;
Error --->
		memcpy(tmpkey, bnode_key(right.bn, 1), keysize+1);
		hfs_bnode_relse(&other);
		
		--belem;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/fs/intermezzo/sysctl.c:327:init_intermezzo_sysctl: ERROR:NULL:326:327:Using ptr "proc_fs_intermezzo" illegally! set by 'proc_mkdir':326 [COUNTER=proc_mkdir:326] [fit=18] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=7] [counter=1] [z = -0.973328526784574] [fn-z = -4.35889894354067]
	if ( !intermezzo_table_header )
		intermezzo_table_header =
			register_sysctl_table(intermezzo_table, 0);
#endif
#ifdef CONFIG_PROC_FS
Start --->
	proc_fs_intermezzo = proc_mkdir("intermezzo", proc_root_fs);
Error --->
	proc_fs_intermezzo->owner = THIS_MODULE;
	create_proc_info_entry("mounts", 0, proc_fs_intermezzo, 
			       intermezzo_mount_get_info);
#endif
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/ide/ide-tape.c:3491:idetape_onstream_read_back_buffer: ERROR:NULL:3488:3491:Using ptr "stage" illegally! set by '__idetape_kmalloc_stage':3488 [COUNTER=__idetape_kmalloc_stage:3488] [fit=20] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=6] [counter=1] [z = -1.12724296038136] [fn-z = -4.35889894354067]
	idetape_update_stats(drive);
	frames = tape->cur_frames;
	logical_blk_num = ntohl(tape->first_stage->aux->logical_blk_num) - frames;
	printk(KERN_INFO "ide-tape: %s: reading back %d frames from the drive's internal buffer\n", tape->name, frames);
	for (i = 0; i < frames; i++) {
Start --->
		stage = __idetape_kmalloc_stage(tape, 0, 0);
		if (!first)
			first = stage;
Error --->
		aux = stage->aux;
		p = stage->bh->b_data;
		idetape_queue_rw_tail(drive, IDETAPE_READ_BUFFER_RQ, tape->capabilities.ctl, stage->bh);
#if ONSTREAM_DEBUG
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/fs/jbd/journal.c:441:journal_write_metadata_buffer: ERROR:NULL:438:441:Passing unknown ptr "tmp"! as arg 0 to call "memcpy"! set by '__jbd_kmalloc':438 [COUNTER=__jbd_kmalloc:438] [fit=22] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=5] [counter=1] [z = -1.31122013621437] [fn-z = -4.35889894354067]
	 * Do we need to do a data copy?
	 */

	if (need_copy_out && !done_copy_out) {
		char *tmp;
Start --->
		tmp = jbd_rep_kmalloc(jh2bh(jh_in)->b_size, GFP_NOFS);

		jh_in->b_frozen_data = tmp;
Error --->
		memcpy (tmp, mapped_data, jh2bh(jh_in)->b_size);
		
		/* If we get to this path, we'll always need the new
		   address kmapped so that we can clear the escaped
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/block/DAC960.c:6984:DAC960_CreateProcEntries: ERROR:NULL:6983:6984:Using ptr "UserCommandProcEntry" illegally! set by 'create_proc_read_entry':6983 [COUNTER=create_proc_read_entry:6983] [fit=23] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=5] [counter=1] [z = -1.31122013621437] [fn-z = -4.35889894354067]
      create_proc_read_entry("current_status", 0, ControllerProcEntry,
			     DAC960_ProcReadCurrentStatus, Controller);
      UserCommandProcEntry =
	create_proc_read_entry("user_command", S_IWUSR | S_IRUSR,
			       ControllerProcEntry, DAC960_ProcReadUserCommand,
Start --->
			       Controller);
Error --->
      UserCommandProcEntry->write_proc = DAC960_ProcWriteUserCommand;
      Controller->ControllerProcEntry = ControllerProcEntry;
    }
}
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/usb/catc.c:625:catc_probe: ERROR:NULL:623:625:Using ptr "netdev" illegally! set by 'init_etherdev':623 [COUNTER=init_etherdev:623] [fit=32] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=18] [counter=3] [z = -1.95244207985486] [fn-z = -4.35889894354067]
	}

	catc = kmalloc(sizeof(struct catc), GFP_KERNEL);
	memset(catc, 0, sizeof(struct catc));

Start --->
	netdev = init_etherdev(0, 0);

Error --->
	netdev->open = catc_open;
	netdev->hard_start_xmit = catc_hard_start_xmit;
	netdev->stop = catc_stop;
	netdev->get_stats = catc_get_stats;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/aironet4500_card.c:852:awc_i365_init: ERROR:NULL:847:852:Using ptr "dev" illegally! set by 'init_etherdev':847 [COUNTER=init_etherdev:847] [fit=32] [fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=18] [counter=3] [z = -1.95244207985486] [fn-z = -4.35889894354067]

	struct net_device * dev;
	int i;


Start --->
	dev = init_etherdev(0, sizeof(struct awc_private) );

//	dev->tx_queue_len = tx_queue_len;
	ether_setup(dev);

Error --->
	dev->hard_start_xmit = 		&awc_start_xmit;
//	dev->set_config = 		&awc_config_misiganes,aga mitte awc_config;
	dev->get_stats = 		&awc_get_stats;
	dev->set_multicast_list = 	&awc_set_multicast_list;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/wan/cosa.c:567:cosa_probe: ERROR:NULL:566:567:Passing unknown ptr "(*cosa).chan"! as arg 0 to call "memset"! set by 'kmalloc_Rsmp_93d4cfe6':566 [COUNTER=kmalloc_Rsmp_93d4cfe6:566] [fit=46] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=59] [counter=9] [z = -3.11592335081808] [fn-z = -4.35889894354067]
	cosa->bouncebuf = kmalloc(COSA_MTU, GFP_KERNEL|GFP_DMA);
	sprintf(cosa->name, "cosa%d", cosa->num);

	/* Initialize the per-channel data */
	cosa->chan = kmalloc(sizeof(struct channel_data)*cosa->nchannels,
Start --->
		GFP_KERNEL);
Error --->
	memset(cosa->chan, 0, sizeof(struct channel_data)*cosa->nchannels);
	for (i=0; i<cosa->nchannels; i++) {
		cosa->chan[i].cosa = cosa;
		cosa->chan[i].num = i;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/wan/cosa.c:589:sppp_channel_init: ERROR:NULL:588:589:Passing unknown ptr "((*chan).pppdev).dev"! as arg 0 to call "memset"! set by 'kmalloc_Rsmp_93d4cfe6':588 [COUNTER=kmalloc_Rsmp_93d4cfe6:588] [fit=46] [fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=59] [counter=9] [z = -3.11592335081808] [fn-z = -4.35889894354067]

static void sppp_channel_init(struct channel_data *chan)
{
	struct net_device *d;
	chan->if_ptr = &chan->pppdev;
Start --->
	chan->pppdev.dev = kmalloc(sizeof(struct net_device), GFP_KERNEL);
Error --->
	memset(chan->pppdev.dev, 0, sizeof(struct net_device));
	sppp_attach(&chan->pppdev);
	d=chan->pppdev.dev;
	strcpy(d->name, chan->name);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/wireless/airo_cs.c:247:airo_attach: ERROR:NULL:246:247:Passing unknown ptr "local"! as arg 0 to call "memset"! set by 'kmalloc_Rsmp_93d4cfe6':246 [COUNTER=kmalloc_Rsmp_93d4cfe6:246] [fit=46] [fit_fn=3] [fn_ex=0] [fn_counter=1] [ex=59] [counter=9] [z = -3.11592335081808] [fn-z = -4.35889894354067]
	link->conf.Attributes = 0;
	link->conf.Vcc = 50;
	link->conf.IntType = INT_MEMORY_AND_IO;
	
	/* Allocate space for private device-specific data */
Start --->
	local = kmalloc(sizeof(local_info_t), GFP_KERNEL);
Error --->
	memset(local, 0, sizeof(local_info_t));
	link->priv = local;
	
	/* Register with Card Services */
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/usb/se401.c:1430:se401_init: ERROR:NULL:1427:1430:Using ptr "(*se401).width" illegally! set by 'kmalloc_Rsmp_93d4cfe6':1427 [COUNTER=kmalloc_Rsmp_93d4cfe6:1427] [fit=46] [fit_fn=4] [fn_ex=0] [fn_counter=3] [ex=59] [counter=9] [z = -3.11592335081808] [fn-z = -7.54983443527075]
		return 1;
	}
	sprintf (temp, "ExtraFeatures: %d", cp[3]);

	se401->sizes=cp[4]+cp[5]*256;
Start --->
	se401->width=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
	se401->height=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
	for (i=0; i<se401->sizes; i++) {
Error --->
		    se401->width[i]=cp[6+i*4+0]+cp[6+i*4+1]*256;
		    se401->height[i]=cp[6+i*4+2]+cp[6+i*4+3]*256;
	}
	sprintf (temp, "%s Sizes:", temp);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/usb/se401.c:1435:se401_init: ERROR:NULL:1427:1435:Using ptr "(*se401).width" illegally! set by 'kmalloc_Rsmp_93d4cfe6':1427 [COUNTER=kmalloc_Rsmp_93d4cfe6:1427] [fit=46] [fit_fn=4] [fn_ex=0] [fn_counter=3] [ex=59] [counter=9] [z = -3.11592335081808] [fn-z = -7.54983443527075]
		return 1;
	}
	sprintf (temp, "ExtraFeatures: %d", cp[3]);

	se401->sizes=cp[4]+cp[5]*256;
Start --->
	se401->width=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
	se401->height=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
	for (i=0; i<se401->sizes; i++) {
		    se401->width[i]=cp[6+i*4+0]+cp[6+i*4+1]*256;
		    se401->height[i]=cp[6+i*4+2]+cp[6+i*4+3]*256;
	}
	sprintf (temp, "%s Sizes:", temp);
	for (i=0; i<se401->sizes; i++) {
Error --->
		sprintf(temp, "%s %dx%d", temp, se401->width[i], se401->height[i]);
	}
	info("%s", temp);
	se401->maxframesize=se401->width[se401->sizes-1]*se401->height[se401->sizes-1]*3;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/usb/se401.c:1438:se401_init: ERROR:NULL:1427:1438:Using ptr "(*se401).width" illegally! set by 'kmalloc_Rsmp_93d4cfe6':1427 [COUNTER=kmalloc_Rsmp_93d4cfe6:1427] [fit=46] [fit_fn=4] [fn_ex=0] [fn_counter=3] [ex=59] [counter=9] [z = -3.11592335081808] [fn-z = -7.54983443527075]
		return 1;
	}
	sprintf (temp, "ExtraFeatures: %d", cp[3]);

	se401->sizes=cp[4]+cp[5]*256;
Start --->
	se401->width=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
	se401->height=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
	for (i=0; i<se401->sizes; i++) {
		    se401->width[i]=cp[6+i*4+0]+cp[6+i*4+1]*256;
		    se401->height[i]=cp[6+i*4+2]+cp[6+i*4+3]*256;
	}
	sprintf (temp, "%s Sizes:", temp);
	for (i=0; i<se401->sizes; i++) {
		sprintf(temp, "%s %dx%d", temp, se401->width[i], se401->height[i]);
	}
	info("%s", temp);
Error --->
	se401->maxframesize=se401->width[se401->sizes-1]*se401->height[se401->sizes-1]*3;

	rc=se401_sndctrl(0, se401, SE401_REQ_GET_WIDTH, 0, cp, sizeof(cp));
	se401->cwidth=cp[0]+cp[1]*256;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/usb/se401.c:1431:se401_init: ERROR:NULL:1428:1431:Using ptr "(*se401).height" illegally! set by 'kmalloc_Rsmp_93d4cfe6':1428 [COUNTER=kmalloc_Rsmp_93d4cfe6:1428] [fit=46] [fit_fn=5] [fn_ex=0] [fn_counter=3] [ex=59] [counter=9] [z = -3.11592335081808] [fn-z = -7.54983443527075]
	}
	sprintf (temp, "ExtraFeatures: %d", cp[3]);

	se401->sizes=cp[4]+cp[5]*256;
	se401->width=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
Start --->
	se401->height=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
	for (i=0; i<se401->sizes; i++) {
		    se401->width[i]=cp[6+i*4+0]+cp[6+i*4+1]*256;
Error --->
		    se401->height[i]=cp[6+i*4+2]+cp[6+i*4+3]*256;
	}
	sprintf (temp, "%s Sizes:", temp);
	for (i=0; i<se401->sizes; i++) {
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/usb/se401.c:1435:se401_init: ERROR:NULL:1428:1435:Using ptr "(*se401).height" illegally! set by 'kmalloc_Rsmp_93d4cfe6':1428 [COUNTER=kmalloc_Rsmp_93d4cfe6:1428] [fit=46] [fit_fn=5] [fn_ex=0] [fn_counter=3] [ex=59] [counter=9] [z = -3.11592335081808] [fn-z = -7.54983443527075]
	}
	sprintf (temp, "ExtraFeatures: %d", cp[3]);

	se401->sizes=cp[4]+cp[5]*256;
	se401->width=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
Start --->
	se401->height=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
	for (i=0; i<se401->sizes; i++) {
		    se401->width[i]=cp[6+i*4+0]+cp[6+i*4+1]*256;
		    se401->height[i]=cp[6+i*4+2]+cp[6+i*4+3]*256;
	}
	sprintf (temp, "%s Sizes:", temp);
	for (i=0; i<se401->sizes; i++) {
Error --->
		sprintf(temp, "%s %dx%d", temp, se401->width[i], se401->height[i]);
	}
	info("%s", temp);
	se401->maxframesize=se401->width[se401->sizes-1]*se401->height[se401->sizes-1]*3;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/usb/se401.c:1438:se401_init: ERROR:NULL:1428:1438:Using ptr "(*se401).height" illegally! set by 'kmalloc_Rsmp_93d4cfe6':1428 [COUNTER=kmalloc_Rsmp_93d4cfe6:1428] [fit=46] [fit_fn=5] [fn_ex=0] [fn_counter=3] [ex=59] [counter=9] [z = -3.11592335081808] [fn-z = -7.54983443527075]
	}
	sprintf (temp, "ExtraFeatures: %d", cp[3]);

	se401->sizes=cp[4]+cp[5]*256;
	se401->width=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
Start --->
	se401->height=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
	for (i=0; i<se401->sizes; i++) {
		    se401->width[i]=cp[6+i*4+0]+cp[6+i*4+1]*256;
		    se401->height[i]=cp[6+i*4+2]+cp[6+i*4+3]*256;
	}
	sprintf (temp, "%s Sizes:", temp);
	for (i=0; i<se401->sizes; i++) {
		sprintf(temp, "%s %dx%d", temp, se401->width[i], se401->height[i]);
	}
	info("%s", temp);
Error --->
	se401->maxframesize=se401->width[se401->sizes-1]*se401->height[se401->sizes-1]*3;

	rc=se401_sndctrl(0, se401, SE401_REQ_GET_WIDTH, 0, cp, sizeof(cp));
	se401->cwidth=cp[0]+cp[1]*256;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/char/drm/sis_ds.c:253:SliceBlock: ERROR:NULL:252:253:Using ptr "newblock" illegally! set by 'calloc':252 [COUNTER=calloc:252] [fit=49] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=2] [counter=2] [z = -4.12948320967011] [fn-z = -4.35889894354067]
{
  TMemBlock *newblock;

  /* break left */
  if (startofs > p->ofs) {
Start --->
    newblock = (TMemBlock*) calloc(1,sizeof(TMemBlock));
Error --->
    newblock->ofs = startofs;
    newblock->size = p->size - (startofs - p->ofs);
    newblock->free = 1;
    newblock->next = p->next;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/char/drm/sis_ds.c:265:SliceBlock: ERROR:NULL:264:265:Using ptr "newblock" illegally! set by 'calloc':264 [COUNTER=calloc:264] [fit=49] [fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=2] [counter=2] [z = -4.12948320967011] [fn-z = -4.35889894354067]
    p = newblock;
  }

  /* break right */
  if (size < p->size) {
Start --->
    newblock = (TMemBlock*) calloc(1,sizeof(TMemBlock));
Error --->
    newblock->ofs = startofs + size;
    newblock->size = p->size - size;
    newblock->free = 1;
    newblock->next = p->next;

