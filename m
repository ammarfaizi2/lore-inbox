Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267358AbTACA25>; Thu, 2 Jan 2003 19:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267361AbTACA25>; Thu, 2 Jan 2003 19:28:57 -0500
Received: from Xenon.Stanford.EDU ([171.64.66.201]:9119 "EHLO
	Xenon.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S267358AbTACA2q>; Thu, 2 Jan 2003 19:28:46 -0500
Date: Thu, 2 Jan 2003 16:37:08 -0800
From: Andy Chou <acc@CS.Stanford.EDU>
To: linux-kernel@vger.kernel.org
Cc: mc@cs.stanford.edu
Subject: [CHECKER] 24 more buffer overruns in 2.5.48
Message-ID: <20030103003708.GA2861@Xenon.stanford.edu>
Reply-To: acc@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are 24 potential buffer overruns from the 2.5.48 kernel that
cross procedure boundaries.  The summary below is probably misleading
because in many cases the error is not in the function where the error
is detected but rather in some caller of that function.  Check the
callstack listed with each error to see what caller(s) might have
caused the error.

For example, probably the most serious error found was this one from
the NFS code:

---------------------------------------------------------
[BUG] [GEM] Off by one.
/u1/acc/linux/2.5.48/fs/nfs/inode.c:1411:nfs_copy_user_string: ERROR:BUFFER:1411:1411:Deref bounds error: dst + (char*)(__u32)maxlen points to offset [16] of buffer of size [16] [Callstack: /u1/acc/linux/2.5.48/fs/nfs/inode.c:1449:nfs_copy_user_string(<len=16, off=0>, _, 16)] 
	if (copy_from_user(dst, src->data, maxlen)) {
		if (p != NULL)
			kfree(p);
		return ERR_PTR(-EFAULT);
	}

Error --->
	dst[maxlen] = '\0';
	return dst;
}
---------------------------------------------------------

It's complaining about "dst[maxlen]" being out of bounds in
nfs_copy_user_string().  To see why, you need to look at the
callstack, which shows that in nfs/inode.c:1449, the pointer passed in
as "dst" points to offset 0 of a 16-byte buffer, and the "maxlen"
argument is 16.

-Andy


# BUGs	|	File Name
3	|	/u1/acc/linux/2.5.48/sound/oss/sb_mixer.c
2	|	/u1/acc/linux/2.5.48/drivers/video/sstfb.c
2	|	/u1/acc/linux/2.5.48/drivers/cdrom/cdu31a.c
1	|	/u1/acc/linux/2.5.48/drivers/scsi/aha1542.c
1	|	/u1/acc/linux/2.5.48/sound/pci/ac97/ac97_patch.c
1	|	/u1/acc/linux/2.5.48/drivers/block/cciss_scsi.c
1	|	/u1/acc/linux/2.5.48/drivers/ide/ide-lib.c
1	|	/u1/acc/linux/2.5.48/fs/devfs/base.c
1	|	/u1/acc/linux/2.5.48/drivers/pnp/pnpbios/core.c
1	|	/u1/acc/linux/2.5.48/drivers/media/video/saa7134/saa7134-tvaudio.c
1	|	/u1/acc/linux/2.5.48/drivers/video/fbgen.c
1	|	/u1/acc/linux/2.5.48/drivers/parport/probe.c
1	|	/u1/acc/linux/2.5.48/drivers/scsi/cpqfcTSworker.c
1	|	/u1/acc/linux/2.5.48/drivers/scsi/scsi.c
1	|	/u1/acc/linux/2.5.48/fs/nfs/inode.c
1	|	/u1/acc/linux/2.5.48/drivers/media/video/tvaudio.c
1	|	/u1/acc/linux/2.5.48/drivers/scsi/sym53c416.c
1	|	/u1/acc/linux/2.5.48/drivers/media/video/c-qcam.c
1	|	/u1/acc/linux/2.5.48/drivers/media/video/bt856.c
1	|	/u1/acc/linux/2.5.48/drivers/scsi/sym53c8xx_2/sym_malloc.c


---------------------------------------------------------
[BUG] Same as another, happens when num_luns = CISS_MAX_PHYS_LUN;
/u1/acc/linux/2.5.48/drivers/block/cciss_scsi.c:449:adjust_cciss_scsi_table: ERROR:BUFFER:449:449:Deref bounds error: sd + (struct cciss_scsi_dev_t*)(long unsigned int)j * 24 points to offset [384] of buffer of size [384] [Callstack: /u1/acc/linux/2.5.48/drivers/block/cciss_scsi.c:1224:adjust_cciss_scsi_table(_, _, <len=384, off=0>, 17)] 
	i = 0;
	while(i<ccissscsi[ctlr].ndevices) {
		csd = &ccissscsi[ctlr].dev[i];
		found=0;
		for (j=0;j<nsds;j++) {

Error --->
			if (SCSI3ADDR_EQ(sd[j].scsi3addr,
				csd->scsi3addr)) {
				if (sd[j].devtype == csd->devtype)
					found=2;
---------------------------------------------------------
[BUG] Looks like a bug.
/u1/acc/linux/2.5.48/drivers/cdrom/cdu31a.c:855:get_result: ERROR:BUFFER:855:855:Deref bounds error: result_buffer points to offset [12] of buffer of size [12] [Callstack: /u1/acc/linux/2.5.48/drivers/cdrom/cdu31a.c:2625:get_result(<len=12, off=0>, _)] 
				}

				clear_result_ready();

				for (i = 0; i < 10; i++) {

Error --->
					*result_buffer =
					    read_result_register();
					result_buffer++;
					(*result_size)++;
---------------------------------------------------------
[BUG] Similar to another.
/u1/acc/linux/2.5.48/drivers/cdrom/cdu31a.c:875:get_result: ERROR:BUFFER:875:875:Deref bounds error: result_buffer + 1 points to offset [21] of buffer of size [12] [Callstack: /u1/acc/linux/2.5.48/drivers/cdrom/cdu31a.c:2625:get_result(<len=12, off=0>, _)] 
#if DEBUG
					printk("CDU31A timeout out %d\n",
					       __LINE__);
#endif
					result_buffer[0] = 0x20;

Error --->
					result_buffer[1] =
					    SONY_TIMEOUT_OP_ERR;
					*result_size = 2;
					return;
---------------------------------------------------------
[BUG] Possibly the caller's fault.
/u1/acc/linux/2.5.48/drivers/ide/ide-lib.c:380:ide_get_best_pio_mode: ERROR:BUFFER:380:380:Array bounds error: ide_pio_timings[6] indexed with [255] [Callstack: /u1/acc/linux/2.5.48/drivers/ide/legacy/qd65xx.c:272:ide_get_best_pio_mode(_, _, 255, _)] 
		pio_mode = max_mode;
		cycle_time = 0;
	}
	if (d) {
		d->pio_mode = pio_mode;

Error --->
		d->cycle_time = cycle_time ? cycle_time : ide_pio_timings[pio_mode].cycle_time;
		d->use_iordy = use_iordy;
		d->overridden = overridden;
		d->blacklisted = blacklisted;
---------------------------------------------------------
[BUG] Bug in caller.
/u1/acc/linux/2.5.48/drivers/media/video/bt856.c:100:bt856_setbit: ERROR:BUFFER:100:100:Array bounds error: dev->reg[128] indexed with [220] [Callstack: /u1/acc/linux/2.5.48/drivers/media/video/bt856.c:146:bt856_setbit(<len=160, off=0>, 220, 3, 1)] 
	return i2c_probe(adap, &addr_data , bt856_attach);
}

static int bt856_setbit(struct bt856 *dev, int subaddr, int bit, int data)
{

Error --->
	return i2c_smbus_write_byte_data(dev->client, subaddr,(dev->reg[subaddr] & ~(1 << bit)) | (data ? (1 << bit) : 0));
}

/* ----------------------------------------------------------------------- */
---------------------------------------------------------
[BUG] Loop should be while(n < nbytes)?
/u1/acc/linux/2.5.48/drivers/media/video/c-qcam.c:342:qcam_read_bytes: ERROR:BUFFER:342:342:Deref bounds error: buf + (__u8*)(unsigned int)n points to offset [150] of buffer of size [150] [Callstack: /u1/acc/linux/2.5.48/drivers/media/video/c-qcam.c:416:qcam_read_bytes(_, <len=150, off=0>, 150)] 
			/* flip some bits */
			rgb[(i = bytes++ % 3)] = (hi | (lo >> 4)) ^ 0x88;
			if (i >= 2) {
get_fragment:
				if (force_rgb) {

Error --->
					buf[n++] = rgb[0];
					buf[n++] = rgb[1];
					buf[n++] = rgb[2];
				} else {
---------------------------------------------------------
[BUG] Caller should pass in &tvaudio[audio]?
/u1/acc/linux/2.5.48/drivers/media/video/saa7134/saa7134-tvaudio.c:280:saa7134_tvaudio_getstereo: ERROR:BUFFER:280:280:Deref bounds error: audio points to offset [200] of buffer of size [200] [Callstack: /u1/acc/linux/2.5.48/drivers/media/video/saa7134/saa7134-tvaudio.c:481:saa7134_tvaudio_getstereo(_, <len=200, off=200>)] 
			      struct saa7134_tvaudio *audio)
{
	__u32 idp,nicam;
	int retval = -1;
	

Error --->
	switch (audio->mode) {
	case TVAUDIO_FM_MONO:
		return V4L2_TUNER_SUB_MONO;
	case TVAUDIO_FM_K_STEREO:
---------------------------------------------------------
[BUG] [GEM] Caller passes in 0xFF, which is not -1 for an int.
/u1/acc/linux/2.5.48/drivers/media/video/tvaudio.c:183:chip_write: ERROR:BUFFER:183:183:Array bounds error: chip->shadow.bytes[65] indexed with [256] [Callstack: /u1/acc/linux/2.5.48/drivers/media/video/tvaudio.c:843:chip_write(_, 255, _)] 
			       chip->c.name, val);
			return -1;
		}
	} else {
		dprintk("%s: chip_write: reg%d=0x%x\n", chip->c.name, subaddr, val);

Error --->
		chip->shadow.bytes[subaddr+1] = val;
		buffer[0] = subaddr;
		buffer[1] = val;
		if (2 != i2c_master_send(&chip->c,buffer,2)) {
---------------------------------------------------------
[BUG] Off-by-one?
/u1/acc/linux/2.5.48/drivers/parport/probe.c:203:parport_device_id: ERROR:BUFFER:203:203:Deref bounds error: buffer + (char*)len points to offset [1000] of buffer of size [1000] [Callstack: /u1/acc/linux/2.5.48/drivers/parport/daisy.c:525:parport_device_id(_, <len=1000, off=0>, 1000)] 
                                   device is non-compliant anyhow. */
			}
		}

	end_id:

Error --->
		buffer[len] = '\0';
		parport_negotiate (dev->port, IEEE1284_MODE_COMPAT);
	}
	parport_release (dev);
---------------------------------------------------------
[BUG] Caller's array is too small.
/u1/acc/linux/2.5.48/drivers/pnp/pnpbios/core.c:1050:pnpid32_to_pnpid: ERROR:BUFFER:1050:1050:Deref bounds error: str + 7 points to offset [7] of buffer of size [7] [Callstack: /u1/acc/linux/2.5.48/drivers/pnp/pnpbios/core.c:1423:pnpid32_to_pnpid(_, <len=7, off=0>)] 
	str[2] = CHAR(id,16);
	str[3] = HEX(id, 12);
	str[4] = HEX(id, 8);
	str[5] = HEX(id, 4);
	str[6] = HEX(id, 0);

Error --->
	str[7] = '\0';

	return;
}
---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/drivers/scsi/aha1542.c:992:aha1542_setup: ERROR:BUFFER:992:992:Deref bounds error: ints + 16 points to offset [16] of buffer of size [16] [Callstack: /u1/acc/linux/2.5.48/drivers/scsi/aha1542.c:1029:aha1542_setup(_, <len=16, off=0>)] 
	setup_buson[setup_idx] = ints[0] >= 2 ? ints[2] : 7;
	setup_busoff[setup_idx] = ints[0] >= 3 ? ints[3] : 5;
	if (ints[0] >= 4) 
	{
		int atbt = -1;

Error --->
		switch (ints[4]) {
		case 5:
			atbt = 0x00;
			break;
---------------------------------------------------------
[BUG] Caller accesses past end of buffer.
/u1/acc/linux/2.5.48/drivers/scsi/cpqfcTSworker.c:4031:BigEndianSwap: ERROR:BUFFER:4031:4031:Deref bounds error: source - (unsigned char*)(unsigned int)i points to offset [123] of buffer of size [120] [Callstack: /u1/acc/linux/2.5.48/drivers/scsi/cpqfcTSworker.c:1641:BigEndianSwap(<len=120, off=120>, _, 4)] 

  source+=3;   // start at MSB of 1st ULONG
  for( j=0; j < cnt; j+=4, source+=4, dest+=4)  // every ULONG
  {
    for( i=0; i<4; i++)  // every UCHAR in ULONG

Error --->
          *(dest+i) = *(source-i);
  }
}

---------------------------------------------------------
[BUG] In caller, err_out: is reached in cases where SRpnt is uninitialized.
/u1/acc/linux/2.5.48/drivers/scsi/scsi.c:341:scsi_release_request: ERROR:BUFFER:341:341:Deref uninitialized pointer req [Callstack: /u1/acc/linux/2.5.48/drivers/scsi/osst.c:4511:scsi_release_request(<len=0, off=0>)] 
 *              has not yet reached the top of the queue.  We still need
 *              to free a request when we are done with it, of course.
 */
void scsi_release_request(Scsi_Request * req)
{

Error --->
	if( req->sr_command != NULL )
	{
		scsi_release_command(req->sr_command);
		req->sr_command = NULL;
---------------------------------------------------------
[BUG] Should be ints[1], not ints[2]?
/u1/acc/linux/2.5.48/drivers/scsi/sym53c416.c:587:sym53c416_setup: ERROR:BUFFER:587:587:Deref bounds error: ints + 8 points to offset [8] of buffer of size [8] [Callstack: /u1/acc/linux/2.5.48/drivers/scsi/sym53c416.c:627:sym53c416_setup(NULL, <len=8, off=0>)] 
	        if(hosts[i].base == ints[1])
        		i = -2;
	if(i >= 0)
	{
        	hosts[host_index].base = ints[1];

Error --->
        	hosts[host_index].irq = (ints[0] == 2)? ints[2] : 0;
        	host_index++;
	}
}
---------------------------------------------------------
[BUG] Missing loop exit or an assert?
/u1/acc/linux/2.5.48/drivers/scsi/sym53c8xx_2/sym_malloc.c:158:___sym_mfree: ERROR:BUFFER:158:158:Deref bounds error: h + (struct sym_m_link*)(long unsigned int)i * 4 points to offset [36] of buffer of size [36] [Callstack: /u1/acc/linux/2.5.48/drivers/scsi/sym53c8xx_2/sym_glue.c:2910:sym_mfree(_, 4096, <len=7, off=0>) -> /u1/acc/linux/2.5.48/drivers/scsi/sym53c8xx_2/sym_glue.c:175:sym_mfree_unlocked(_, 4096, <len=7, off=0>) -> /u1/acc/linux/2.5.48/drivers/scsi/sym53c8xx_2/sym_malloc.c:257:__sym_mfree(_, _, 4096, <len=7, off=0>) -> /u1/acc/linux/2.5.48/drivers/scsi/sym53c8xx_2/sym_malloc.c:198:___sym_mfree(_, _, 4096)] 
		q = &h[i];
		while (q->next && q->next != (m_link_p) b) {
			q = q->next;
		}
		if (!q->next) {

Error --->
			((m_link_p) a)->next = h[i].next;
			h[i].next = (m_link_p) a;
			break;
		}
---------------------------------------------------------
[BUG] [GEM] The caller is probably at fault: look at the call chain.
/u1/acc/linux/2.5.48/drivers/video/fbgen.c:180:do_install_cmap: ERROR:BUFFER:180:180:Array bounds error: fb_display[63] indexed with [-1] [Callstack: /u1/acc/linux/2.5.48/drivers/video/aty128fb.c:1746:aty128fb_set_var(_, -1, _) -> /u1/acc/linux/2.5.48/drivers/video/aty128fb.c:1406:do_install_cmap(-1, _)] 

void do_install_cmap(int con, struct fb_info *info)
{
    if (con != info->currcon)
	return;

Error --->
    if (fb_display[con].cmap.len)
	fb_set_cmap(&fb_display[con].cmap, 1, info);
    else {
	int size = fb_display[con].var.bits_per_pixel == 16 ? 64 : 256;
---------------------------------------------------------
[BUG] Maybe.  Can only happen if sst_info->currcon can be -1.
/u1/acc/linux/2.5.48/drivers/video/sstfb.c:472:sstfb_install_cmap: ERROR:BUFFER:472:472:Array bounds error: fb_display[63] indexed with [-1] [Callstack: /u1/acc/linux/2.5.48/drivers/video/sstfb.c:1894:sstfb_set_var(_, -1, _) -> /u1/acc/linux/2.5.48/drivers/video/sstfb.c:902:sstfb_install_cmap(-1, _)] 
#define sst_info	((struct sstfb_info *) info)
	f_dprintk("sstfb_install_cmap(con: %d)\n",con);
	f_ddprintk("currcon: %d\n", sst_info->currcon);
	if (con != sst_info->currcon)
		return;

Error --->
	if (fb_display[con].cmap.len)
		fb_set_cmap(&fb_display[con].cmap, 1, sstfb_setcolreg, info);
	else
		fb_set_cmap(
---------------------------------------------------------
[BUG] [GEM] Looks bad.
/u1/acc/linux/2.5.48/drivers/video/sstfb.c:692:sstfb_encode_var: ERROR:BUFFER:692:692:Deref uninitialized pointer var [Callstack: /u1/acc/linux/2.5.48/drivers/video/sstfb.c:780:sstfb_encode_var(<len=0, off=0>, _, _)] 
                             const struct sstfb_par *par,
                             const struct sstfb_info *sst_info)
{
	memset(var,0,sizeof(struct fb_var_screeninfo));


Error --->
	var->xres           = par->xDim;
	var->yres           = par->yDim;
	var->xres_virtual   = par->xDim;
	var->yres_virtual   = par->yDim;
---------------------------------------------------------
[BUG] [GEM] Not sure which call is at fault.  Look at the callstack.
/u1/acc/linux/2.5.48/fs/devfs/base.c:2025:devfs_generate_path: ERROR:BUFFER:2025:2025:Deref bounds error: path + (char*)buflen - 1 points to offset [63] of buffer of size [40] [Callstack: /u1/acc/linux/2.5.48/fs/partitions/check.c:135:disk_name(_, 0, <len=40, off=0>) -> /u1/acc/linux/2.5.48/fs/partitions/check.c:97:devfs_generate_path(_, <len=40, off=0>, 64)] 
#define NAMEOF(de) ( (de)->mode ? (de)->name : (de)->u.name )

    if (de == NULL) return -EINVAL;
    VERIFY_ENTRY (de);
    if (de->namelen >= buflen) return -ENAMETOOLONG; /*  Must be first       */

Error --->
    path[buflen - 1] = '\0';
    if (de->parent == NULL) return buflen - 1;       /*  Don't prepend root  */
    pos = buflen - de->namelen - 1;
    memcpy (path + pos, NAMEOF (de), de->namelen);
---------------------------------------------------------
[BUG] [GEM] Off by one.
/u1/acc/linux/2.5.48/fs/nfs/inode.c:1411:nfs_copy_user_string: ERROR:BUFFER:1411:1411:Deref bounds error: dst + (char*)(__u32)maxlen points to offset [16] of buffer of size [16] [Callstack: /u1/acc/linux/2.5.48/fs/nfs/inode.c:1449:nfs_copy_user_string(<len=16, off=0>, _, 16)] 
	if (copy_from_user(dst, src->data, maxlen)) {
		if (p != NULL)
			kfree(p);
		return ERR_PTR(-EFAULT);
	}

Error --->
	dst[maxlen] = '\0';
	return dst;
}

---------------------------------------------------------
[BUG]
/u1/acc/linux/2.5.48/sound/oss/sb_mixer.c:238:change_bits: ERROR:BUFFER:238:238:Array bounds error: *devc->iomap[32] indexed with [32] [Callstack: /u1/acc/linux/2.5.48/sound/oss/sb_ess.c:1722:sb_common_mixer_set(_, 32, _, _) -> /u1/acc/linux/2.5.48/sound/oss/sb_mixer.c:282:change_bits(_, _, 32, 0, _)] 
static void change_bits(sb_devc * devc, unsigned char *regval, int dev, int chn, int newval)
{
	unsigned char mask;
	int shift;


Error --->
	mask = (1 << (*devc->iomap)[dev][chn].nbits) - 1;
	newval = (int) ((newval * mask) + 50) / 100;	/* Scale */

	shift = (*devc->iomap)[dev][chn].bitoffs - (*devc->iomap)[dev][LEFT_CHN].nbits + 1;
---------------------------------------------------------
[BUG] Caller at fault?
/u1/acc/linux/2.5.48/sound/oss/sb_mixer.c:276:sb_common_mixer_set: ERROR:BUFFER:276:276:Array bounds error: *devc->iomap[32] indexed with [32] [Callstack: /u1/acc/linux/2.5.48/sound/oss/sb_ess.c:1722:sb_common_mixer_set(_, 32, _, _)] 
int sb_common_mixer_set(sb_devc * devc, int dev, int left, int right)
{
	int regoffs;
	unsigned char val;


Error --->
	regoffs = (*devc->iomap)[dev][LEFT_CHN].regno;

	if (regoffs == 0)
		return -EINVAL;
---------------------------------------------------------
[BUG] Look at callstack.
/u1/acc/linux/2.5.48/sound/oss/sb_mixer.c:336:smw_mixer_set: ERROR:BUFFER:336:336:Array bounds error: smw_mix_regs[17] indexed with [17] [Callstack: /u1/acc/linux/2.5.48/sound/oss/sb_mixer.c:656:sb_mixer_set(_, 17, _) -> /u1/acc/linux/2.5.48/sound/oss/sb_mixer.c:369:smw_mixer_set(_, 17, _, 100)] 
			sb_setmixer(devc, 0x0e, val);
		
			break;

		default:

Error --->
			reg = smw_mix_regs[dev];
			if (reg == 0)
				return -EINVAL;
			sb_setmixer(devc, reg, (24 - (24 * left / 100)) | 0x20);	/* 24=mute, 0=max */
---------------------------------------------------------
[BUG] The caller is at fault.
/u1/acc/linux/2.5.48/sound/pci/ac97/ac97_patch.c:218:patch_ad1881_chained1: ERROR:BUFFER:218:218:Array bounds error: cfg_bits[3] indexed with [-1] [Callstack: /u1/acc/linux/2.5.48/sound/pci/ac97/ac97_patch.c:244:patch_ad1881_chained1(_, -1, 0)] 
static int patch_ad1881_chained1(ac97_t * ac97, int idx, unsigned short codec_bits)
{
	static int cfg_bits[3] = { 1<<12, 1<<14, 1<<13 };
	unsigned short val;
	

Error --->
	snd_ac97_write_cache(ac97, AC97_AD_SERIAL_CFG, cfg_bits[idx]);
	snd_ac97_write_cache(ac97, AC97_AD_CODEC_CFG, 0x0004);	// SDIE
	val = snd_ac97_read(ac97, AC97_VENDOR_ID2);
	if ((val & 0xff40) != 0x5340)

