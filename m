Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264592AbTDZCGN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 22:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264593AbTDZCGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 22:06:13 -0400
Received: from elaine24.Stanford.EDU ([171.64.15.99]:145 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id S264592AbTDZCF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 22:05:57 -0400
Date: Fri, 25 Apr 2003 19:18:02 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: linux-kernel@vger.kernel.org, Chris Wright <chris@wirex.com>
cc: mc@cs.stanford.edu
Subject: [CHECKER] 30 potential dereference of user-pointer errors
In-Reply-To: <20030421142624.B11886@figure1.int.wirex.com>
Message-ID: <Pine.GSO.4.44.0304251855390.21961-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------------------------------------------------------
Hi,

I've submitted 8 such bugs several weeks before and thanks to Chris and
other guys to fix most of them. Here are another 30 similar bugs. I got a
warning in net/ipv4, which must be that I'm missing something, so please
clarify. Also it seems I'm missing some assumptions for those video
drivers.

As usual, any responses will be appreciated. Thanks!

Where bugs occur:

net/ipv4/ip_sockglue.c
drivers/i2c/i2c-dev.c
drivers/ieee1394/video1394.c
drivers/isdn/eicon/linchr.c
drivers/media/dvb/av7110/av7110_ir.c
drivers/media/radio/radio-cadet.c
drivers/media/video/bw-qcam.c
drivers/media/video/cpia.c
drivers/media/video/zoran_procfs.c
drivers/media/video/zr36120.c
drivers/pnp/pnpbios/proc.c
drivers/scsi/aacraid/commctrl.c
drivers/usb/image/mdc800.c
drivers/usb/media/vicam.c
drivers/usb/serial/empeg.c
drivers/usb/serial/io_edgeport.c
drivers/usb/serial/ipaq.c
drivers/usb/serial/keyspan.c
drivers/video/sis/sis_main.c
sound/oss/awe_wave.c
sound/oss/cmpci.c
sound/oss/mpu401.c
sound/pci/es1938.c


[UNKNOWN] maybe? it is in ipv4 though. ip_cmsg_send -> ip_options_get
implies CMSG_DATA(cmsg) is tainted. It could be that the taintedness of CMSG_DATA(cmsg) depends on the case branch

/home/junfeng/linux-tainted/net/ipv4/ip_sockglue.c:168:ip_cmsg_send: ERROR:TAINTED:168:168: dereferencing tainted ptr 'info' [Callstack: /home/junfeng/linux-tainted/net/ipv4/ip_options.c:518:ip_cmsg_send()]

		{
			struct in_pktinfo *info;
			if (cmsg->cmsg_len != CMSG_LEN(sizeof(struct in_pktinfo)))
				return -EINVAL;
			info = (struct in_pktinfo *)CMSG_DATA(cmsg);

Error --->
			ipc->oif = info->ipi_ifindex;
			ipc->addr = info->ipi_spec_dst.s_addr;
			break;
		}
---------------------------------------------------------
[BUG] buf is tainted. can print out arbitrary kernel data
/home/junfeng/linux-tainted/drivers/usb/serial/empeg.c:225:empeg_write: ERROR:TAINTED:225:225: passing tainted ptr 'buf' to usb_serial_debug_data [Callstack: /home/junfeng/linux-tainted/drivers/usb/serial/safe_serial.c:327:empeg_write((tainted 2))]

	int bytes_sent = 0;
	int transfer_size;

	dbg("%s - port %d", __FUNCTION__, port->number);


Error --->
	usb_serial_debug_data (__FILE__, __FUNCTION__, count, buf);

	while (count > 0) {

---------------------------------------------------------
[BUG] can print out arbitrary kernel data
/home/junfeng/linux-tainted/drivers/usb/serial/ipaq.c:371:ipaq_write: ERROR:TAINTED:371:371: passing tainted ptr 'buf' to usb_serial_debug_data [Callstack: /home/junfeng/linux-tainted/drivers/usb/serial/safe_serial.c:327:ipaq_write((tainted 2))]

	int			bytes_sent = 0;
	int			transfer_size;

	dbg("%s - port %d", __FUNCTION__, port->number);


Error --->
	usb_serial_debug_data(__FILE__, __FUNCTION__, count, buf);

	while (count > 0) {
		transfer_size = min(count, PACKET_SIZE);
---------------------------------------------------------
[BUG] can print out arbitrary kernel data
/home/junfeng/linux-tainted/drivers/usb/serial/keyspan.c:328:keyspan_write: ERROR:TAINTED:328:328: dereferencing tainted ptr 'buf' [Callstack: ]


	p_priv = usb_get_serial_port_data(port);
	d_details = p_priv->device_details;

	dbg("%s - for port %d (%d chars [%x]), flip=%d",

Error --->
	    __FUNCTION__, port->number, count, buf[0], p_priv->out_flip);

	for (left = count; left > 0; left -= todo) {
		todo = left;
---------------------------------------------------------
[BUG] pointer (rdwr_arg.msgs[i]) points to user space
/home/junfeng/linux-tainted/drivers/i2c/i2c-dev.c:230:i2cdev_ioctl: ERROR:TAINTED:230:230: dereferencing tainted ptr 'rdwr_arg.msgs + i * 12' [Callstack: ]

			if(rdwr_pa[i].buf == NULL)
			{
				res = -ENOMEM;
				break;
			}

Error --->
			if(copy_from_user(rdwr_pa[i].buf,
				rdwr_arg.msgs[i].buf,
				rdwr_pa[i].len))
			{
---------------------------------------------------------
[BUG] file_operations.read. even the parm itself has a name pUserBuffer
/home/junfeng/linux-tainted/drivers/isdn/eicon/linchr.c:166:do_read: ERROR:TAINTED:166:166: passing tainted ptr 'pClientLogBuffer' to __constant_memcpy [Callstack: /home/junfeng/linux-tainted/drivers/scsi/sg.c:362:do_read((tainted 1))]


	pHeadItem = (klog_t *) DivasLogFifoRead();

	if (pHeadItem)
	{

Error --->
		memcpy(pClientLogBuffer, pHeadItem, sizeof(klog_t));
		kfree(pHeadItem);
		return sizeof(klog_t);
	}
---------------------------------------------------------
[BUG] file_operations.write -> cm_write -> trans_ac3. write can take tainted. write can take tainted inputs.
/home/junfeng/linux-tainted/sound/oss/cmpci.c:593:trans_ac3: ERROR:TAINTED:593:593: dereferencing tainted ptr 'src' [Callstack: /home/junfeng/linux-tainted/fs/read_write.c:307:vfs_write((tainted 1)(tainted 2)) -> /home/junfeng/linux-tainted/fs/read_write.c:241:cm_write((tainted 1)(tainted 2)) -> /home/junfeng/linux-tainted/sound/oss/cmpci.c:1662:trans_ac3((tainted 2))]

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
[BUG] in ioctl function. v (==arg) is not checked at all. can write arbitrary data to the kernel. on the same case branch, copy_to_user is called on arg
/home/junfeng/linux-tainted/drivers/media/radio/radio-cadet.c:397:cadet_do_ioctl: ERROR:TAINTED:397:397: dereferencing tainted ptr 'v' [Callstack: ]

	{
		case VIDIOCGCAP:
		{
			struct video_capability *v = arg;
			memset(v,0,sizeof(*v));

Error --->
			v->type=VID_TYPE_TUNER;
			v->channels=2;
			v->audios=1;
			strcpy(v->name, "ADS Cadet");
---------------------------------------------------------
[BUG] no check in sis_main.c at all. can write arbitrary data to kernel
/home/junfeng/linux-tainted/drivers/video/sis/sis_main.c:2476:sisfb_ioctl: ERROR:TAINTED:2476:2476: dereferencing tainted ptr 'x' [Callstack: /home/junfeng/linux-tainted/drivers/video/sstfb.c:808:sisfb_ioctl((tainted 3))]

		}
	   case FBIOPUT_MODEINFO:
		{
			struct mode_info *x = (struct mode_info *)arg;


Error --->
			ivideo.video_bpp      = x->bpp;
			ivideo.video_width    = x->xres;
			ivideo.video_height   = x->yres;
			ivideo.video_vwidth   = x->v_xres;
---------------------------------------------------------
[BUG] on VIDIOCGCAPUTRE and VIDIOCSCAPUTRE branches copy_*_user functions are called. on other branches not
/home/junfeng/linux-tainted/drivers/media/video/cpia.c:3432:cpia_do_ioctl: ERROR:TAINTED:3432:3432: dereferencing tainted ptr 'vp' [Callstack: ]

		DBG("VIDIOCSPICT\n");

		/* check validity */
		DBG("palette: %d\n", vp->palette);
		DBG("depth: %d\n", vp->depth);

Error --->
		if (!valid_mode(vp->palette, vp->depth)) {
			retval = -EINVAL;
			break;
		}
---------------------------------------------------------
[BUG] sisfb_ioctl->sis_dispinfo. drivers/video/sstfb_ioctl assumes "arg" is tainted. both of them are assigned to fb_ops.fb_ioctl
/home/junfeng/linux-tainted/drivers/video/sis/sis_main.c:276:sis_dispinfo: ERROR:TAINTED:276:276: dereferencing tainted ptr 'rec' [Callstack: /home/junfeng/linux-tainted/drivers/video/sstfb.c:808:sisfb_ioctl((tainted 3)) -> /home/junfeng/linux-tainted/drivers/video/sis/sis_main.c:2488:sis_dispinfo((tainted 0))]

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
[BUG] mdc800_device_read is assigned to file_operations.read, which can take tainted inputs
/home/junfeng/linux-tainted/drivers/usb/image/mdc800.c:750:mdc800_device_read: ERROR:TAINTED:750:750: passing tainted ptr 'ptr' to __memcpy [Callstack: /home/junfeng/linux-tainted/drivers/scsi/sg.c:362:mdc800_device_read((tainted 1))]

			}
		}
		else
		{
			/* memcpy Bytes */

Error --->
			memcpy (ptr, &mdc800->out [mdc800->out_ptr], sts);
			ptr+=sts;
			left-=sts;
			mdc800->out_ptr+=sts;
---------------------------------------------------------
[BUG] call usb_serial_debug_data on data
/home/junfeng/linux-tainted/drivers/usb/serial/io_edgeport.c:1381:edge_write: ERROR:TAINTED:1381:1381: passing tainted ptr 'data' to usb_serial_debug_data [Callstack: ]

		fifo->head  += secondhalf;
		// No need to check for wrap since we can not get to end of fifo in this part
	}

	if (copySize) {

Error --->
		usb_serial_debug_data (__FILE__, __FUNCTION__, copySize, data);
	}

	send_more_port_data((struct edgeport_serial *)usb_get_serial_data(port->serial), edge_port);
---------------------------------------------------------
[BUG] proc_dir_entry.read_proc can take tainted inputs
/home/junfeng/linux-tainted/drivers/usb/media/vicam.c:1117:vicam_write_proc_gain: ERROR:TAINTED:1117:1117: passing tainted ptr 'buffer' to simple_strtoul [Callstack: /home/junfeng/linux-tainted/net/core/pktgen.c:991:vicam_write_proc_gain((tainted 1))]

static int vicam_write_proc_gain(struct file *file, const char *buffer,
				unsigned long count, void *data)
{
	struct vicam_camera *cam = (struct vicam_camera *)data;


Error --->
	cam->gain = simple_strtoul(buffer, NULL, 10);

	return count;
}
---------------------------------------------------------
[BUG] midi_synth.c:midi_synth_ioctl does __copy_to_user(not copy_to_user?). it could be that there are some assumptions about the devices.
/home/junfeng/linux-tainted/sound/oss/mpu401.c:792:mpu_synth_ioctl: ERROR:TAINTED:792:792: passing tainted ptr 'arg' to __constant_memcpy [Callstack: /home/junfeng/linux-tainted/sound/oss/midi_synth.c:270:mpu_synth_ioctl((tainted 2))]


	switch (cmd)
	{

		case SNDCTL_SYNTH_INFO:

Error --->
			memcpy((&((char *) arg)[0]), (char *) &mpu_synth_info[midi_dev], sizeof(struct synth_info));
			return 0;

		case SNDCTL_SYNTH_MEMAVL:
---------------------------------------------------------
[BUG] similar errors
/home/junfeng/linux-tainted/drivers/media/radio/radio-cadet.c:399:cadet_do_ioctl: ERROR:TAINTED:399:399: dereferencing tainted ptr 'v' [Callstack: ]

		{
			struct video_capability *v = arg;
			memset(v,0,sizeof(*v));
			v->type=VID_TYPE_TUNER;
			v->channels=2;

Error --->
			v->audios=1;
			strcpy(v->name, "ADS Cadet");
			return 0;
		}
---------------------------------------------------------
[BUG] ioctl
/home/junfeng/linux-tainted/drivers/usb/media/vicam.c:617:vicam_ioctl: ERROR:TAINTED:617:617: dereferencing tainted ptr 'vp' [Callstack: /home/junfeng/linux-tainted/drivers/scsi/sg.c:1002:vicam_ioctl((tainted 3))]

			struct video_picture *vp = (struct video_picture *) arg;

			DBG("VIDIOCSPICT depth = %d, pal = %d\n", vp->depth,
			    vp->palette);


Error --->
			cam->gain = vp->brightness >> 8;

			if (vp->depth != 24
			    || vp->palette != VIDEO_PALETTE_RGB24)
---------------------------------------------------------
[BUG] copy_to_user is called on case VIDIOCGCHAN
/home/junfeng/linux-tainted/drivers/media/video/bw-qcam.c:763:qcam_do_ioctl: ERROR:TAINTED:763:763: dereferencing tainted ptr 'p' [Callstack: ]

			return 0;
		}
		case VIDIOCGPICT:
		{
			struct video_picture *p = arg;

Error --->
			p->colour=0x8000;
			p->hue=0x8000;
			p->brightness=qcam->brightness<<8;
			p->contrast=qcam->contrast<<8;
---------------------------------------------------------
[BUG]
/home/junfeng/linux-tainted/drivers/media/video/bw-qcam.c:723:qcam_do_ioctl: ERROR:TAINTED:723:723: dereferencing tainted ptr 'v' [Callstack: ]

		case VIDIOCGCHAN:
		{
			struct video_channel *v = arg;
			if(v->channel!=0)
				return -EINVAL;

Error --->
			v->flags=0;
			v->tuners=0;
			/* Good question.. its composite or SVHS so.. */
			v->type = VIDEO_TYPE_CAMERA;
---------------------------------------------------------
[BUG] file_opetations.ioctl -> aac_cfg_ioctl -> aac_do_ioctl -> close_getadapter_fib -> aac_close_fib_context. also, check_revision calls copy_to_user on "arg"
/home/junfeng/linux-tainted/drivers/scsi/aacraid/commctrl.c:277:aac_close_fib_context: ERROR:TAINTED:277:277: dereferencing tainted ptr 'fibctx' [Callstack: /home/junfeng/linux-tainted/drivers/scsi/sg.c:1002:aac_cfg_ioctl((tainted 3)) -> /home/junfeng/linux-tainted/drivers/scsi/aacraid/linit.c:671:aac_do_ioctl((tainted 2)) -> /home/junfeng/linux-tainted/drivers/scsi/aacraid/commctrl.c:421:close_getadapter_fib((tainted 1)) -> /home/junfeng/linux-tainted/drivers/scsi/aacraid/commctrl.c:348:aac_close_fib_context((tainted 1))]

	while (!list_empty(&fibctx->fibs)) {
		struct list_head * entry;
		/*
		 *	Pull the next fib from the fibs
		 */

Error --->
		entry = fibctx->fibs.next;
		list_del(entry);
		fib = list_entry(entry, struct hw_fib, header.FibLinks);
		fibctx->count--;
---------------------------------------------------------
[BUG] zoran_read and vbi_read are both assigned to video_device.read, while zoran_read assumes "buf" is tainted
/home/junfeng/linux-tainted/drivers/media/video/zr36120.c:1698:vbi_read: ERROR:TAINTED:1698:1698: dereferencing tainted ptr 'optr' [Callstack: /home/junfeng/linux-tainted/drivers/media/video/zr36120.c:934:vbi_read((tainted 1))]

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
[BUG] video1394_ioctl's param arg is tainted -> initialize_dma_it_prg_var_packet_queue's param packet_sizes is also tainted
/home/junfeng/linux-tainted/drivers/ieee1394/video1394.c:668:initialize_dma_it_prg_var_packet_queue: ERROR:TAINTED:668:668: dereferencing tainted ptr 'packet_sizes + i * 4' [Callstack: /home/junfeng/linux-tainted/drivers/ieee1394/video1394.c:1047:initialize_dma_it_prg_var_packet_queue((tainted 2))]

	for (i = 0; i < d->nb_cmd; i++) {
		unsigned int size;
		if (packet_sizes[i] > d->packet_size) {
			size = d->packet_size;
		} else {

Error --->
			size = packet_sizes[i];
		}
		it_prg[i].data[1] = cpu_to_le32(size << 16);
		it_prg[i].end.control = cpu_to_le32(DMA_CTL_OUTPUT_LAST | DMA_CTL_BRANCH);
---------------------------------------------------------
[BUG] sound/pci/rme9652/rme9652.c:snd_rme9652_capture_copy treats the parm "dst" as tainted and they are both assigned to snd_pcm_ops_t.copy
/home/junfeng/linux-tainted/sound/pci/es1938.c:833:snd_es1938_capture_copy: ERROR:TAINTED:833:833: passing tainted ptr 'dst' to __constant_memcpy [Callstack: /home/junfeng/linux-tainted/sound/pci/rme9652/rme9652.c:2010:snd_es1938_capture_copy((tainted 3))]

	es1938_t *chip = snd_pcm_substream_chip(substream);
	pos <<= chip->dma1_shift;
	count <<= chip->dma1_shift;
	snd_assert(pos + count <= chip->dma1_size, return -EINVAL);
	if (pos + count < chip->dma1_size)

Error --->
		memcpy(dst, runtime->dma_area + pos + 1, count);
	else {
		memcpy(dst, runtime->dma_area + pos + 1, count - 1);
		((unsigned char *)dst)[count - 1] = runtime->dma_area[0];
---------------------------------------------------------
[BUG] proc_dir_entry.write_proc
/home/junfeng/linux-tainted/drivers/media/video/zoran_procfs.c:122:zoran_write_proc: ERROR:TAINTED:122:122: passing tainted ptr 'buffer' to __memcpy [Callstack: /home/junfeng/linux-tainted/net/core/pktgen.c:991:zoran_write_proc((tainted 1))]

	string = sp = vmalloc(count + 1);
	if (!string) {
		printk(KERN_ERR "%s: write_proc: can not allocate memory\n", zr->name);
		return -ENOMEM;
	}

Error --->
	memcpy(string, buffer, count);
	string[count] = 0;
	DEBUG2(printk(KERN_INFO "%s: write_proc: name=%s count=%lu data=%x\n", zr->name, file->f_dentry->d_name.name, count, (int) data));
	ldelim = " \t\n";
---------------------------------------------------------
[BUG] proc_dir_entry.write_proc
/home/junfeng/linux-tainted/drivers/pnp/pnpbios/proc.c:190:proc_write_node: ERROR:TAINTED:190:190: passing tainted ptr 'buf' to __memcpy [Callstack: /home/junfeng/linux-tainted/net/core/pktgen.c:991:proc_write_node((tainted 1))]

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
[BUG] file_operations.write
/home/junfeng/linux-tainted/drivers/usb/image/mdc800.c:805:mdc800_device_write: ERROR:TAINTED:805:805: dereferencing tainted ptr 'buf + i' [Callstack: /home/junfeng/linux-tainted/drivers/media/dvb/av7110/av7110.c:3858:mdc800_device_write((tainted 1))]

		}

		/* save command byte */
		if (mdc800->in_count < 8)
		{

Error --->
			mdc800->in[mdc800->in_count]=buf[i];
			mdc800->in_count++;
		}
		else
---------------------------------------------------------
[BUG] proc_dir_entry.write_proc can take tainted inputs
/home/junfeng/linux-tainted/drivers/usb/media/vicam.c:1107:vicam_write_proc_shutter: ERROR:TAINTED:1107:1107: passing tainted ptr 'buffer' to simple_strtoul [Callstack: /home/junfeng/linux-tainted/net/core/pktgen.c:991:vicam_write_proc_shutter((tainted 1))]

static int vicam_write_proc_shutter(struct file *file, const char *buffer,
				unsigned long count, void *data)
{
	struct vicam_camera *cam = (struct vicam_camera *)data;


Error --->
	cam->shutter_speed = simple_strtoul(buffer, NULL, 10);

	return count;
}
---------------------------------------------------------
[BUG] av7110_ir_write_proc is assigned to proc_dir_entry.write_proc
/home/junfeng/linux-tainted/drivers/media/dvb/av7110/av7110_ir.c:116:av7110_ir_write_proc: ERROR:TAINTED:116:116: passing tainted ptr 'buffer' to __constant_memcpy [Callstack: /home/junfeng/linux-tainted/net/core/pktgen.c:991:av7110_ir_write_proc((tainted 1))]

	u32 ir_config;

	if (count < 4 + 256 * sizeof(u16))
		return -EINVAL;


Error --->
	memcpy (&ir_config, buffer, 4);
	memcpy (&key_map, buffer + 4, 256 * sizeof(u16));

	av7110_setup_irc_config (NULL, ir_config);
---------------------------------------------------------
[BUG] pointer (rdwr_arg.msgs[i]) points to user space
/home/junfeng/linux-tainted/drivers/i2c/i2c-dev.c:249:i2cdev_ioctl: ERROR:TAINTED:249:249: dereferencing tainted ptr 'rdwr_arg.msgs + i * 12' [Callstack: ]

		}
		while(i-- > 0)
		{
			if( res>=0 && (rdwr_pa[i].flags & I2C_M_RD))
			{

Error --->
				if(copy_to_user(
					rdwr_arg.msgs[i].buf,
					rdwr_pa[i].buf,
					rdwr_pa[i].len))
---------------------------------------------------------
[BUG] ioctl
/home/junfeng/linux-tainted/sound/oss/awe_wave.c:2049:awe_ioctl: ERROR:TAINTED:2049:2049: passing tainted ptr 'arg' to __constant_memcpy [Callstack: /home/junfeng/linux-tainted/sound/oss/midi_synth.c:270:awe_ioctl((tainted 2))]

	case SNDCTL_SYNTH_INFO:
		if (playing_mode == AWE_PLAY_DIRECT)
			awe_info.nr_voices = awe_max_voices;
		else
			awe_info.nr_voices = AWE_MAX_CHANNELS;

Error --->
		memcpy((char*)arg, &awe_info, sizeof(awe_info));
		return 0;
		break;


