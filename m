Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263983AbTCWW7O>; Sun, 23 Mar 2003 17:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263986AbTCWW7O>; Sun, 23 Mar 2003 17:59:14 -0500
Received: from elaine24.Stanford.EDU ([171.64.15.99]:46728 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S263983AbTCWW7G>; Sun, 23 Mar 2003 17:59:06 -0500
Date: Sun, 23 Mar 2003 15:10:06 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: linux-kernel@vger.kernel.org
cc: mc@cs.stanford.edu
Subject: Re: [CHECKER] potential dereference of user pointer errors
In-Reply-To: <Pine.GSO.4.44.0303202226230.24869-100000@elaine24.Stanford.EDU>
Message-ID: <Pine.GSO.4.44.0303231506070.21702-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are more bugs on derefences of user pointers.

Where the bugs occur:

      fs/intermezzo/vfs.c
      drivers/media/video/zoran_procfs.c
      drivers/media/video/zr36120.c
      drivers/video/sis/sis_main.c
      drivers/char/specialix.c
      drivers/pnp/pnpbios/proc.c
      drivers/media/dvb/av7110/av7110_ir.c
      drivers/usb/serial/ipaq.c
      drivers/char/vt.c
      drivers/isdn/hardware/eicon/divasproc.c
      drivers/media/radio/radio-cadet.c
      drivers/media/video/bw-qcam.c
      sound/pci/es1938.c
      sound/oss/awe_wave.c
      sound/isa/sb/sb16_csp.c
      sound/oss/cmpci.c

Main sources of bugs: proc_write functions and ioctl functions

Thanks a lot for Chris and other people's replies on my previous error
reports.

Junfeng

---------------------------------------------------------
[BUG] write_proc
/home/junfeng/linux-2.5.63/drivers/media/video/zoran_procfs.c:122:zoran_write_proc:
ERROR:tainted:122:122: passing buffer into deref cal __constant_memcpy
[dist=1][thru proc_dir_entry:write_proc
/home/junfeng/linux-2.5.63/drivers/media/video/cpia.c:cpia_write_proc:parm1
copy_from_user:parm1][START: buffer, unknown->tainted,
/home/junfeng/linux-2.5.63/drivers/media/video/zoran_procfs.c,
zoran_write_proc, 122]

	string = sp = vmalloc(count + 1);
	if (!string) {
		printk(KERN_ERR "%s: write_proc: can not allocate
memory\n", zr->name);
		return -ENOMEM;
	}

Error --->
	memcpy(string, buffer, count);
	string[count] = 0;
	DEBUG2(printk(KERN_INFO "%s: write_proc: name=%s count=%lu
data=%x\n", zr->name, file->f_dentry->d_name.name, count, (int) data));
	ldelim = " \t\n";
---------------------------------------------------------
[BUG] buf is passed into access_ok.
/home/junfeng/linux-2.5.63/drivers/char/specialix.c:1654:sx_write:
ERROR:tainted:1654:1654: passing buf into deref cal __constant_memcpy
[dist=1][thru tty_driver:write
/home/junfeng/linux-2.5.63/drivers/char/epca.c:pc_write:parm2
copy_from_user:parm1][START: buf, unknown->tainted,
/home/junfeng/linux-2.5.63/drivers/char/specialix.c, sx_write, 1654]

					   SERIAL_XMIT_SIZE -
port->xmit_head));
			if (c <= 0) {
				restore_flags(flags);
				break;
			}

Error --->
			memcpy(port->xmit_buf + port->xmit_head, buf, c);
			port->xmit_head = (port->xmit_head + c) &
(SERIAL_XMIT_SIZE-1);
			port->xmit_cnt += c;
			restore_flags(flags);
---------------------------------------------------------
[BUG] buf is passed into access_ok, which implies it is tainted.
/home/junfeng/linux-2.5.63/drivers/media/video/zr36120.c:1698:vbi_read:
ERROR:tainted:1698:1698:deferencing optr++ tainted by [dist=-1][(null)]

		{
			/* copy to doubled data to userland */
			for (x=0; optr+1<eptr && x<-done->w; x++)
			{
				unsigned char a = iptr[x*2];

Error --->
				*optr++ = a;
				*optr++ = a;
			}
			/* and clear the rest of the line */
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/drivers/video/sis/sis_main.c:1817:sis_malloc:
ERROR:tainted:1817:1817:deferencing req tainted by [dist=2][ called by
sisfb_ioctl:parm3 thru fb_ops:fb_ioctl
/home/junfeng/linux-2.5.63/drivers/video/matrox/matroxfb_crtc2.c:matroxfb_dh_ioctl:parm3
copy_to_user:parm0][START: req, unknown->tainted,
/home/junfeng/linux-2.5.63/drivers/video/sis/sis_main.c, sis_malloc, 1817]


void sis_malloc(struct sis_memreq *req)
{
	SIS_OH *poh;


Error --->
	poh = sisfb_poh_allocate(req->size);

	if (poh == NULL) {
		req->offset = 0;
---------------------------------------------------------
[BUG] proc_write
/home/junfeng/linux-2.5.63/drivers/pnp/pnpbios/proc.c:190:proc_write_node:
ERROR:tainted:190:190: passing buf into deref cal __constant_memcpy
[dist=1][thru proc_dir_entry:write_proc
/home/junfeng/linux-2.5.63/drivers/media/video/cpia.c:cpia_write_proc:parm1
copy_from_user:parm1][START: buf, unknown->tainted,
/home/junfeng/linux-2.5.63/drivers/pnp/pnpbios/proc.c, proc_write_node,
190]

	if (!node) return -ENOMEM;
	if ( pnp_bios_get_dev_node(&nodenum, boot, node) )
		return -EIO;
	if (count != node->size - sizeof(struct pnp_bios_node))
		return -EINVAL;

Error --->
	memcpy(node->data, buf, count);
	if (pnp_bios_set_dev_node(node->handle, boot, node) != 0)
	    return -EINVAL;
	kfree(node);
---------------------------------------------------------
[BUG] bug is in lento_symlink. oldname is passed into getname, which
implies it is tainted. Then it is passed to presto_do_symlink. should pass
in "from" not "oldname".
/home/junfeng/linux-2.5.63/fs/namei.c:2190:page_symlink:
ERROR:tainted:2190:2190: passing symname into deref cal __constant_memcpy
[dist=6][ called by
/home/junfeng/linux-2.5.63/fs/ramfs/inode.c:ramfs_symlink:parm2 thru
inode_operations:symlink
/home/junfeng/linux-2.5.63/fs/intermezzo/dir.c:presto_symlink:parm2
calling
/home/junfeng/linux-2.5.63/fs/intermezzo/vfs.c:presto_do_symlink:parm3
called by lento_symlink  calling
/home/junfeng/linux-2.5.63/fs/namei.c:getname  called by
/home/junfeng/linux-2.5.63/fs/open.c:sys_open sys_open:parm0][START:
symname, unknown->tainted, /home/junfeng/linux-2.5.63/fs/namei.c,
page_symlink, 2190]

		goto fail;
	err = mapping->a_ops->prepare_write(NULL, page, 0, len-1);
	if (err)
		goto fail_map;
	kaddr = kmap_atomic(page, KM_USER0);

Error --->
	memcpy(kaddr, symname, len-1);
	kunmap_atomic(kaddr, KM_USER0);
	mapping->a_ops->commit_write(NULL, page, 0, len-1);
	/*
---------------------------------------------------------
[BUG] buf is passed to access_ok
/home/junfeng/linux-2.5.63/drivers/media/video/zr36120.c:1703:vbi_read:
ERROR:tainted:1703:1703:deferencing optr++ tainted by [dist=-1][(null)]

				*optr++ = a;
				*optr++ = a;
			}
			/* and clear the rest of the line */
			for (x*=2; optr<eptr && x<done->bpl; x++)

Error --->
				*optr++ = 0;
			/* next line */
			iptr += done->bpl;
		}
---------------------------------------------------------
[BUG] in the caller cm_write, buff is passed into access_ok
/home/junfeng/linux-2.5.63/sound/oss/cmpci.c:593:trans_ac3:
ERROR:tainted:593:593:deferencing src++ tainted by [dist=-1][(null)]

	unsigned long data;
	unsigned long *dst = (unsigned long *) dest;
	unsigned short *src = (unsigned short *)source;

	do {

Error --->
		data = (unsigned long) *src++;
		data <<= 12;			// ok for 16-bit data
		if (s->spdif_counter == 2 || s->spdif_counter == 3)
			data |= 0x40000000;	// indicate AC-3 raw data
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/cmpci.c:1673:cm_write:
ERROR:tainted:1673:1673:deferencing src++ tainted by [dist=-1][(null)]

			src = (unsigned long *) buffer;
			dst0 = (unsigned long *) (s->dma_dac.rawbuf +
swptr);
			dst1 = (unsigned long *) (s->dma_adc.rawbuf +
swptr);
			// copy left/right sample at one time
			for (i = 0; i <= cnt / 4; i++) {

Error --->
				*dst0++ = *src++;
				*dst1++ = *src++;
			}
			swptr = (swptr + cnt) % s->dma_dac.dmasize;
---------------------------------------------------------
[BUG] Bug is in ipaq_write. if debug is on, can print out kernel data
/home/junfeng/linux-2.5.63/drivers/usb/serial/usb-serial.h:363:usb_serial_debug_data:
ERROR:tainted:363:363:deferencing data tainted by [dist=2][ called by
/home/junfeng/linux-2.5.63/drivers/usb/serial/ipaq.c:ipaq_write:parm2 thru
usb_serial_device_type:write
/home/junfeng/linux-2.5.63/drivers/usb/serial/keyspan_pda.c:keyspan_pda_write:parm2
copy_from_user:parm1][START: data, unknown->tainted,
/home/junfeng/linux-2.5.63/drivers/usb/serial/usb-serial.h,
usb_serial_debug_data, 363]

	if (!debug)
		return;

	printk (KERN_DEBUG "%s: %s - length = %d, data = ", file,
function, size);
	for (i = 0; i < size; ++i) {

Error --->
		printk ("%.2x ", data[i]);
	}
	printk ("\n");
}
---------------------------------------------------------
[BUG] write_proc
/home/junfeng/linux-2.5.63/drivers/media/dvb/av7110/av7110_ir.c:116:av7110_ir_write_proc:
ERROR:tainted:116:116: passing buffer into deref cal __constant_memcpy
[dist=1][thru proc_dir_entry:write_proc
/home/junfeng/linux-2.5.63/drivers/media/video/cpia.c:cpia_write_proc:parm1
copy_from_user:parm1][START: buffer, unknown->tainted,
/home/junfeng/linux-2.5.63/drivers/media/dvb/av7110/av7110_ir.c,
av7110_ir_write_proc, 116]

	u32 ir_config;

	if (count < 4 + 256 * sizeof(u16))
		return -EINVAL;


Error --->
	memcpy (&ir_config, buffer, 4);
	memcpy (&key_map, buffer + 4, 256 * sizeof(u16));

	av7110_setup_irc_config (NULL, ir_config);
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/drivers/video/sis/sis_main.c:276:sis_dispinfo:
ERROR:tainted:276:276:deferencing rec tainted by [dist=2][ called by
sisfb_ioctl:parm3 thru fb_ops:fb_ioctl
/home/junfeng/linux-2.5.63/drivers/video/matrox/matroxfb_crtc2.c:matroxfb_dh_ioctl:parm3
copy_to_user:parm0][START: rec, unknown->tainted,
/home/junfeng/linux-2.5.63/drivers/video/sis/sis_main.c, sis_dispinfo,
276]

	gly->ngmask = size;
}

void sis_dispinfo(struct ap_data *rec)
{

Error --->
	rec->minfo.bpp    = ivideo.video_bpp;
	rec->minfo.xres   = ivideo.video_width;
	rec->minfo.yres   = ivideo.video_height;
	rec->minfo.v_xres = ivideo.video_vwidth;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-2.5.63/sound/oss/awe_wave.c:2049:awe_ioctl:
ERROR:tainted:2049:2049: passing arg into deref cal __constant_memcpy
[dist=1][thru synth_operations:ioctl
/home/junfeng/linux-2.5.63/sound/oss/gus_wave.c:guswave_ioctl:parm2
copy_to_user:parm0][START: arg, unknown->tainted,
/home/junfeng/linux-2.5.63/sound/oss/awe_wave.c, awe_ioctl, 2049]

	case SNDCTL_SYNTH_INFO:
		if (playing_mode == AWE_PLAY_DIRECT)
			awe_info.nr_voices = awe_max_voices;
		else
			awe_info.nr_voices = AWE_MAX_CHANNELS;

Error --->
		memcpy((char*)arg, &awe_info, sizeof(awe_info));
		return 0;
		break;

---------------------------------------------------------
[BUG] snd_sb_csp_ioctl -> snd_sb_csp_riff_load ->snd_sb_csp_load.
/home/junfeng/linux-2.5.63/sound/isa/sb/sb16_csp.c:647:snd_sb_csp_load:
ERROR:tainted:647:647:deferencing buf++ tainted by
[dist=-1][(null)][TRANS: buf++, $stop$->tainted,
/home/junfeng/linux-2.5.63/sound/isa/sb/sb16_csp.c, snd_sb_csp_load, 647]

		}
		kfree (_kbuf);
	} else {
		/* load from kernel space */
		while (size--) {

Error --->
			if (!snd_sbdsp_command(p->chip, *buf++))
				goto __fail;
		}
	}
---------------------------------------------------------
[BUG] vt_console_print is assigned to struct console.write
/home/junfeng/linux-2.5.63/drivers/char/vt.c:2126:vt_console_print:
ERROR:tainted:2126:2126:deferencing b++ tainted by
[dist=-1][(null)][TRANS: b++, $stop$->tainted,
/home/junfeng/linux-2.5.63/drivers/char/vt.c, vt_console_print, 2126]

	start = (ushort *)pos;

	/* Contrived structure to try to emulate original need_wrap
behaviour
	 * Problems caused when we have need_wrap set on '\n' character */
	while (count--) {

Error --->
		c = *b++;
		if (c == 10 || c == 13 || c == 8 || need_wrap) {
			if (cnt > 0) {
				if (IS_VISIBLE)
---------------------------------------------------------
[BUG] write_proc
/home/junfeng/linux-2.5.63/drivers/isdn/hardware/eicon/divasproc.c:191:write_d_l1_down:
ERROR:tainted:191:191:deferencing buffer tainted by [dist=1][thru
proc_dir_entry:write_proc
/home/junfeng/linux-2.5.63/drivers/media/video/cpia.c:cpia_write_proc:parm1
copy_from_user:parm1][START: buffer, unknown->tainted,
/home/junfeng/linux-2.5.63/drivers/isdn/hardware/eicon/divasproc.c,
write_d_l1_down, 191]

{
	diva_os_xdi_adapter_t *a = (diva_os_xdi_adapter_t *) data;
	PISDN_ADAPTER IoAdapter = IoAdapters[a->controller - 1];

	if ((count == 1) || (count == 2)) {

Error --->
		switch (buffer[0]) {
		case '0':
			IoAdapter->capi_cfg.cfg_1 &=
			    ~DIVA_XDI_CAPI_CFG_1_DYNAMIC_L1_ON;
---------------------------------------------------------
[BUG] in ioctl
/home/junfeng/linux-2.5.63/drivers/media/radio/radio-cadet.c:396:cadet_do_ioctl:
ERROR:tainted:395:396: passing v into deref cal
__constant_c_and_count_memset [dist=-1][(null)][TRANS: v,
tainted->tainted,
/home/junfeng/linux-2.5.63/drivers/media/radio/radio-cadet.c,
cadet_do_ioctl, 395]

{
	switch(cmd)
	{
		case VIDIOCGCAP:
		{
Start --->
			struct video_capability *v = arg;
Error --->
			memset(v,0,sizeof(*v));
			v->type=VID_TYPE_TUNER;
			v->channels=2;
			v->audios=1;
---------------------------------------------------------
[BUG] in ioctl
/home/junfeng/linux-2.5.63/drivers/media/video/bw-qcam.c:836:qcam_do_ioctl:
ERROR:tainted:835:836: passing vw into deref cal
__constant_c_and_count_memset [dist=-1][(null)][TRANS: vw,
tainted->tainted,
/home/junfeng/linux-2.5.63/drivers/media/video/bw-qcam.c, qcam_do_ioctl,
835]

			/* Ok we figured out what to use from our wide
choice */
			return 0;
		}
		case VIDIOCGWIN:
		{
Start --->
			struct video_window *vw = arg;
Error --->
			memset(vw, 0, sizeof(*vw));
			vw->width=qcam->width/qcam->transfer_scale;
			vw->height=qcam->height/qcam->transfer_scale;
			return 0;
---------------------------------------------------------
[BUG] copy function can take tainted inputs
/home/junfeng/linux-2.5.63/sound/pci/es1938.c:833:snd_es1938_capture_copy:
ERROR:tainted:835:833: passing dst into deref cal __constant_memcpy
[dist=1][thru snd_pcm_ops_t:copy
/home/junfeng/linux-2.5.63/sound/pci/cmipci.c:snd_cmipci_ac3_copy:parm3
copy_from_user:parm1][START: dst, unknown->tainted,
/home/junfeng/linux-2.5.63/sound/pci/es1938.c, snd_es1938_capture_copy,
833]

	es1938_t *chip = snd_pcm_substream_chip(substream);
	pos <<= chip->dma1_shift;
	count <<= chip->dma1_shift;
	snd_assert(pos + count <= chip->dma1_size, return -EINVAL);
	if (pos + count < chip->dma1_size)
Error --->
		memcpy(dst, runtime->dma_area + pos + 1, count);
	else {
Start --->
		memcpy(dst, runtime->dma_area + pos + 1, count - 1);
		((unsigned char *)dst)[count - 1] = runtime->dma_area[0];
	}
	return 0;



