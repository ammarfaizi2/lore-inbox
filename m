Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132578AbRDEIxz>; Thu, 5 Apr 2001 04:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132579AbRDEIxp>; Thu, 5 Apr 2001 04:53:45 -0400
Received: from Xenon.Stanford.EDU ([171.64.66.201]:64193 "EHLO
	Xenon.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S132578AbRDEIxg>; Thu, 5 Apr 2001 04:53:36 -0400
Date: Thu, 5 Apr 2001 01:52:51 -0700
From: Andy Chou <acc@CS.Stanford.EDU>
To: linux-kernel@vger.kernel.org
Cc: mc@CS.Stanford.EDU
Subject: [CHECKER] 15 potential pointer dereference errors in 2.4.3
Message-ID: <20010405015251.A20904@Xenon.Stanford.EDU>
Reply-To: acc@CS.Stanford.EDU
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.1.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran the null pointer dereference checker over 2.4.3 and it found the
following 15 potential errors.  As usual, the context given with each
report may be misleading so you'll probably need to inspect the
source.  The checker tries to help by printing the function it thinks
is returning NULL.

Also, I've run the checker over 2.2.19, and there were a bunch of
issues but they would require some time and effort to inspect.  Some
of them are the same as issues reported for 2.4.x.  Would it be useful
to report these?

-Andy Chou

Files:

drivers/char/ip2main.c
drivers/ide/ide-probe.c
drivers/isdn/hisax/fsm.c
drivers/mtd/ftl.c
drivers/net/tokenring/tmsisa.c
drivers/pcmcia/rsrc_mgr.c
drivers/scsi/eata_dma.c
drivers/scsi/sr.c
fs/jffs/intrep.c
fs/udf/partition.c
fs/udf/super.c
ipc/util.c

Reports:

---------------------------------------------------------
[BUG]
/u2/acc/oses/linux/2.4.3/drivers/char/ip2main.c:1041:ip2_init_board: ERROR:NULL:1030:1041: Using
unknown ptr "pCh" illegally! set by 'kmalloc':1030

Start --->
			kmalloc( sizeof(i2ChanStr) * nports, GFP_KERNEL );
		if ( !i2InitChannels( pB, nports, pCh ) ) {
			printk(KERN_ERR "i2InitChannels
failed: %d\n",pB->i2eError);
		}
		pB->i2eChannelPtr = &DevTable[portnum];

	... DELETED 3 lines ...

		for( box = 0; box < ABS_MAX_BOXES; ++box, portnum +=
ABS_BIGGEST_BOX ) {
			for( i = 0; i < ABS_BIGGEST_BOX; ++i ) {
				if ( pB->i2eChannelMap[box] & (1 << i) ) {
					DevTable[portnum + i] = pCh;
Error --->
					pCh->port_index = portnum + i;
					pCh++;

[BUG]
/u2/acc/oses/linux/2.4.3/drivers/char/ip2main.c:1061:ip2_init_board: ERROR:NULL:1053:1061: Using
unknown ptr "pCh" illegally! set by 'kmalloc':1053

Start --->
		kmalloc ( sizeof (i2ChanStr) * nports, GFP_KERNEL );
	pB->i2eChannelPtr = pCh;
	pB->i2eChannelCnt = nports;
	i2InitChannels ( pB, pB->i2eChannelCnt, pCh );
	pB->i2eChannelPtr = &DevTable[IP2_PORTS_PER_BOARD * boardnum];

	for( i = 0; i < pB->i2eChannelCnt; ++i ) {
		DevTable[IP2_PORTS_PER_BOARD * boardnum + i] = pCh;
Error --->
		pCh->port_index = (IP2_PORTS_PER_BOARD * boardnum) + i;
		pCh++;
---------------------------------------------------------
[BUG]
/u2/acc/oses/linux/2.4.3/drivers/ide/ide-probe.c:66:do_identify: ERROR:NULL:60:66: Using
unknown ptr "id" illegally! set by 'kmalloc':60

Start --->
	id = drive->id = kmalloc (SECTOR_WORDS*4, GFP_ATOMIC);	/* called
with interrupts disabled! */
	ide_input_data(drive, id, SECTOR_WORDS);		/* read 512 bytes of id
info */
	ide__sti();	/* local CPU only */
	ide_fix_driveid(id);

	if (id->word156 == 0x4d42) {
Error --->
		printk("%s: drive->id->word156 == 0x%04x \n", drive->name,
drive->id->word156);
	}
---------------------------------------------------------

[BUG]
/u2/acc/oses/linux/2.4.3/drivers/isdn/hisax/fsm.c:34:FsmNew: ERROR:NULL:24:34: Using
unknown ptr "jumpmatrix" illegally! set by 'kmalloc':24

Start --->
		kmalloc(sizeof (FSMFNPTR) * fsm->state_count *
fsm->event_count, GFP_KERNEL);
	memset(fsm->jumpmatrix, 0, sizeof (FSMFNPTR) * fsm->state_count *
fsm->event_count);

	for (i = 0; i < fncount; i++) 
		if ((fnlist[i].state>=fsm->state_count) ||
(fnlist[i].event>=fsm->event_count)) {
			printk(KERN_ERR "FsmNew Error line %d
st(%ld/%ld) ev(%ld/%ld)\n",

i,(long)fnlist[i].state,(long)fsm->state_count,

(long)fnlist[i].event,(long)fsm->event_count);
		} else		
			fsm->jumpmatrix[fsm->state_count * fnlist[i].event
+
Error --->
				fnlist[i].state] =
(FSMFNPTR) fnlist[i].routine;
}
---------------------------------------------------------
[BUG]
/u2/acc/oses/linux/2.4.3/drivers/mtd/ftl.c:407:build_maps: ERROR:NULL:377:407: Using
unknown ptr "VirtualBlockMap" illegally! set by 'vmalloc':377

Start --->
    part->VirtualBlockMap = vmalloc(blocks * sizeof(u_int32_t));
    memset(part->VirtualBlockMap, 0xff, blocks * sizeof(u_int32_t));
    part->BlocksPerUnit = (1 << header.EraseUnitSize) >> header.BlockSize;

    part->bam_cache = kmalloc(part->BlocksPerUnit * sizeof(u_int32_t),

	... DELETED 22 lines ...

		part->FreeTotal++;
	    } else if ((BLOCK_TYPE(le32_to_cpu(part->bam_cache[j])) ==
BLOCK_DATA) &&
		     (BLOCK_NUMBER(le32_to_cpu(part->bam_cache[j])) <
blocks))

part->VirtualBlockMap[BLOCK_NUMBER(le32_to_cpu(part->bam_cache[j]))] =
Error --->
		    (i << header.EraseUnitSize) + (j << header.BlockSize);
	    else if (BLOCK_DELETED(le32_to_cpu(part->bam_cache[j])))
---------------------------------------------------------
[BUG]
/u2/acc/oses/linux/2.4.3/drivers/net/tokenring/tmsisa.c:274:tms_isa_probe: ERROR:NULL:273:274: Using
unknown ptr "card" illegally! set by 'kmalloc':273

Start --->
		card = kmalloc(sizeof(struct tms_isa_card), GFP_KERNEL);
Error --->
		card->next = tms_isa_card_list;
		tms_isa_card_list = card;
---------------------------------------------------------
[BUG]
/u2/acc/oses/linux/2.4.3/drivers/pcmcia/rsrc_mgr.c:199:do_io_probe: ERROR:NULL:191:199: Using
unknown ptr "b" illegally! set by 'kmalloc':191

Start --->
    b = kmalloc(256, GFP_KERNEL);
    memset(b, 0, 256);
    for (i = base, most = 0; i < base+num; i += 8) {
	if (check_io_resource(i, 8))
	    continue;
	hole = inb(i);
	for (j = 1; j < 8; j++)
	    if (inb(i+j) != hole) break;
Error --->
	if ((j == 8) && (++b[hole] > b[most]))
	    most = hole;

---------------------------------------------------------
[BUG] GEM this is bizarre
/u2/acc/oses/linux/2.4.3/drivers/scsi/eata_dma.c:1249:register_HBA: ERROR:NULL:1139:1249: Using
NULL ptr "buff" illegally! set by 'get_board_data':1139

Start --->
	buff = get_board_data(base, gc->IRQ, gc->scsi_id[3]);

    if (buff == NULL) {
	if (bustype == IS_EISA || bustype == IS_ISA) {
	    bugs = bugs || BROKEN_INQUIRY;

	... DELETED 102 lines ...

	strncpy(hd->vendor, &buff[8], 8);
	hd->vendor[8] = 0;
	strncpy(hd->name, &buff[16], 17);
	hd->name[17] = 0;
Error --->
	hd->revision[0] = buff[32];
	hd->revision[1] = buff[33];
---------------------------------------------------------
[BUG]
/u2/acc/oses/linux/2.4.3/drivers/scsi/sr.c:683:get_capabilities: ERROR:NULL:665:683: Using
unknown ptr "buffer" illegally! set by 'scsi_malloc':665

Start --->
	buffer = (unsigned char *) scsi_malloc(512);
	cmd[0] = MODE_SENSE;
	cmd[1] = (scsi_CDs[i].device->lun << 5) & 0xe0;
	cmd[2] = 0x2a;
	cmd[4] = 128;

	... DELETED 10 lines ...

		scsi_free(buffer, 512);
		printk("sr%i: scsi-1 drive\n", i);
		return;
	}
Error --->
	n = buffer[3] + 4;
	scsi_CDs[i].cdi.speed = ((buffer[n + 8] << 8) + buffer[n + 9]) /
176;
---------------------------------------------------------
[BUG]
/u2/acc/oses/linux/2.4.3/fs/jffs/intrep.c:349:jffs_checksum_flash: ERROR:NULL:333:349: Using
unknown ptr "read_buf" illegally! set by 'kmalloc':333

Start --->
	read_buf = (__u8 *) kmalloc (sizeof(__u8) * 4096, GFP_KERNEL);

	/* Loop until checksum done */
	while (size) {
		/* Get amount of data to read */

	... DELETED 8 lines ...

		flash_safe_read(mtd, ptr, &read_buf[0], length);

		/* Compute checksum */
		for (i=0; i < length ; i++)
Error --->
			sum += read_buf[i];

---------------------------------------------------------
[BUG]
/u2/acc/oses/linux/2.4.3/fs/jffs/intrep.c:634:jffs_scan_flash: ERROR:NULL:608:634: Using
unknown ptr "read_buf" illegally! set by 'kmalloc':608

Start --->
	read_buf = (__u8 *) kmalloc (sizeof(__u8) * 4096, GFP_KERNEL);

	/* Start the scan.  */
	while (pos < end) {
		deleted_file = 0;

	... DELETED 18 lines ...

			retlen &= ~3;

			for (i=0 ; i < retlen ; i+=4, pos += 4) {
				if(*((__u32 *) &read_buf[i]) !=
Error --->
						JFFS_EMPTY_BITMASK)
					break;
---------------------------------------------------------

[BUG]
/u2/acc/oses/linux/2.4.3/fs/udf/partition.c:186:udf_fill_spartable: ERROR:NULL:164:186: Using
unknown ptr "s_spar_map" illegally! set by 'kmalloc':164

Start --->
					sdata->s_spar_map =
kmalloc(mapsize, GFP_KERNEL);
					sdata->s_spar_remap.s_spar_remap32
= &sdata->s_spar_map[rtl];
					memset(sdata->s_spar_map, 0xFF,
mapsize);
				}


	... DELETED 14 lines ...

					}
					se = (SparingEntry
*)&(bh->b_data[index]);
					index += sizeof(SparingEntry);

Error --->
					if (sdata->s_spar_map[i] ==
0xFFFFFFFF)
						sdata->s_spar_map[i] =
le32_to_cpu(se->mappedLocation);
---------------------------------------------------------
[BUG] hidden in macro
/u2/acc/oses/linux/2.4.3/fs/udf/super.c:860:udf_load_logicalvol: ERROR:NULL:849:860: Using
unknown ptr "s_partmaps" illegally! set by 'kmalloc':849

Start --->
	UDF_SB_ALLOC_PARTMAPS(sb, UDF_SB_NUMPARTS(sb));

	for (i=0,offset=0;
		 i<UDF_SB_NUMPARTS(sb) &&
offset<le32_to_cpu(lvd->mapTableLength);
		 i++,offset+=((struct GenericPartitionMap
*)&(lvd->partitionMaps[offset]))->partitionMapLength)

	... DELETED 3 lines ...

		udf_debug("Partition (%d) type %d\n", i, type);
		if (type == 1)
		{
			struct GenericPartitionMap1 *gpm1 = (struct
GenericPartitionMap1 *)&(lvd->partitionMaps[offset]);
Error --->
			UDF_SB_PARTTYPE(sb,i) = UDF_TYPE1_MAP15;
			UDF_SB_PARTVSN(sb,i) =
le16_to_cpu(gpm1->volSeqNum);

---------------------------------------------------------
[BUG]
/u2/acc/oses/linux/2.4.3/fs/udf/super.c:1186:udf_load_partition: ERROR:NULL:1183:1186: Using
unknown ptr "bh" illegally! set by 'bread':1183

Start --->
					bh = bread(sb->s_dev, pos,
sb->s_blocksize);

UDF_SB_TYPEVIRT(sb,i).s_start_offset =
						le16_to_cpu(((struct
VirtualAllocationTable20 *)bh->b_data +
udf_ext0_offset(UDF_SB_VAT(sb)))->lengthHeader) +
Error --->

udf_ext0_offset(UDF_SB_VAT(sb));

UDF_SB_TYPEVIRT(sb,i).s_num_entries = (UDF_SB_VAT(sb)->i_size -
---------------------------------------------------------
[BUG] oops.
/u2/acc/oses/linux/2.4.3/ipc/util.c:79:ipc_init_ids: ERROR:NULL:71:79: Using
NULL ptr "entries" illegally! set by 'ipc_alloc':71

Start --->
	ids->entries = ipc_alloc(sizeof(struct ipc_id)*size);

	if(ids->entries == NULL) {
		printk(KERN_ERR "ipc_init_ids() failed, ipc service
disabled.\n");
		ids->size = 0;
	}
	ids->ary = SPIN_LOCK_UNLOCKED;
	for(i=0;i<size;i++)
Error --->
		ids->entries[i].p = NULL;
}
---------------------------------------------------------

