Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263506AbTD1Giq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 02:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263507AbTD1Giq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 02:38:46 -0400
Received: from elaine24.Stanford.EDU ([171.64.15.99]:30110 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id S263506AbTD1Gim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 02:38:42 -0400
Date: Sun, 27 Apr 2003 23:50:53 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: linux-kernel@vger.kernel.org, Chris Wright <chris@wirex.com>
cc: mc@cs.stanford.edu
Subject: [CHECKER] 8 potential user-pointer errors that allow arbitrary writes
 to kernel 
In-Reply-To: <Pine.GSO.4.44.0304251855390.21961-100000@elaine24.Stanford.EDU>
Message-ID: <Pine.GSO.4.44.0304272346550.15342-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here are 8 bugs where user-pointers are dereferenced or passed into memcpy
without being checked. This allows a malicious user to write to anywhere
he wants.

Any confirmations or clarifications will be appreciated.

-Junfeng


---------------------------------------------------------
[BUG] Can write to anywhere in kernel. Should have used video_usercopy
(..., vicam_ioctl) and removed all the copy_*_user calls

/home/junfeng/linux-tainted/drivers/usb/media/vicam.c:617:vicam_ioctl:
ERROR:TAINTED:617:617: dereferencing tainted ptr 'vp' [Callstack:
/home/junfeng/linux-tainted/drivers/scsi/sg.c:1002:vicam_ioctl((tainted
3))]

			struct video_picture *vp = (struct video_picture
*) arg;

			DBG("VIDIOCSPICT depth = %d, pal = %d\n",
vp->depth,
			    vp->palette);


Error --->
			cam->gain = vp->brightness >> 8;

			if (vp->depth != 24
			    || vp->palette != VIDEO_PALETTE_RGB24)
---------------------------------------------------------
[BUG] can write to anywhere in kernel. all the other *_ioctl functions
that are assigned to struct fb_ops.fb_ioctl assume "arg" is tainted.

/home/junfeng/linux-tainted/drivers/video/sis/sis_main.c:2476:sisfb_ioctl:
ERROR:TAINTED:2476:2476: dereferencing tainted ptr 'x' [Callstack:
/home/junfeng/linux-tainted/drivers/video/sstfb.c:808:sisfb_ioctl((tainted
3))]

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
[BUG] can write to anywhere in kernel. do_read is assigned to
file_operations.read, which can take tainted inputs. even the parm itself
has a name pUserBuffer

/home/junfeng/linux-tainted/drivers/isdn/eicon/linchr.c:166:do_read:
ERROR:TAINTED:166:166: passing tainted ptr 'pClientLogBuffer' to
__constant_memcpy [Callstack:
/home/junfeng/linux-tainted/drivers/scsi/sg.c:362:do_read((tainted 1))]


	pHeadItem = (klog_t *) DivasLogFifoRead();

	if (pHeadItem)
	{

Error --->
		memcpy(pClientLogBuffer, pHeadItem, sizeof(klog_t));
		kfree(pHeadItem);
		return sizeof(klog_t);
	}
---------------------------------------------------------
[BUG] can write to anywhere in kernel. in the same subdir,
midi_synth.c:midi_synth_ioctl does __copy_to_user(not copy_to_user?). it
could be that there are some assumptions about the devices.

/home/junfeng/linux-tainted/sound/oss/mpu401.c:792:mpu_synth_ioctl:
ERROR:TAINTED:792:792: passing tainted ptr 'arg' to __constant_memcpy
[Callstack:
/home/junfeng/linux-tainted/sound/oss/midi_synth.c:270:mpu_synth_ioctl((tainted
2))]


	switch (cmd)
	{

		case SNDCTL_SYNTH_INFO:

Error --->
			memcpy((&((char *) arg)[0]), (char *)
&mpu_synth_info[midi_dev], sizeof(struct synth_info));
			return 0;

		case SNDCTL_SYNTH_MEMAVL:
---------------------------------------------------------
[BUG] can write to anywhere in kernel. mdc800_device_read is assigned to
file_operations.read, which can take tainted inputs

/home/junfeng/linux-tainted/drivers/usb/image/mdc800.c:750:mdc800_device_read:
ERROR:TAINTED:750:750: passing tainted ptr 'ptr' to __memcpy [Callstack:
/home/junfeng/linux-tainted/drivers/scsi/sg.c:362:mdc800_device_read((tainted
1))]

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
[BUG] can write to anywhere in kernel. file_operations.write

/home/junfeng/linux-tainted/drivers/usb/image/mdc800.c:805:mdc800_device_write:
ERROR:TAINTED:805:805: dereferencing tainted ptr 'buf + i' [Callstack:
/home/junfeng/linux-tainted/drivers/media/dvb/av7110/av7110.c:3858:mdc800_device_write((tainted
1))]

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
[BUG] can write to anywhere in kernel.
sound/pci/rme9652/rme9652.c:snd_rme9652_capture_copy treats the parm "dst"
as tainted and they are both assigned to snd_pcm_ops_t.copy

/home/junfeng/linux-tainted/sound/pci/es1938.c:833:snd_es1938_capture_copy:
ERROR:TAINTED:833:833: passing tainted ptr 'dst' to __constant_memcpy
[Callstack:
/home/junfeng/linux-tainted/sound/pci/rme9652/rme9652.c:2010:snd_es1938_capture_copy((tainted
3))]

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
[BUG] can write to anywhere in kernel. awe_ioctl is assigned to
file_operations.ioctl

/home/junfeng/linux-tainted/sound/oss/awe_wave.c:2049:awe_ioctl:
ERROR:TAINTED:2049:2049: passing tainted ptr 'arg' to __constant_memcpy
[Callstack:
/home/junfeng/linux-tainted/sound/oss/midi_synth.c:270:awe_ioctl((tainted
2))]

	case SNDCTL_SYNTH_INFO:
		if (playing_mode == AWE_PLAY_DIRECT)
			awe_info.nr_voices = awe_max_voices;
		else
			awe_info.nr_voices = AWE_MAX_CHANNELS;

Error --->
		memcpy((char*)arg, &awe_info, sizeof(awe_info));
		return 0;
		break;



