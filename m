Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264340AbRFHVeY>; Fri, 8 Jun 2001 17:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264355AbRFHVeP>; Fri, 8 Jun 2001 17:34:15 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:39810 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S264340AbRFHVeF>;
	Fri, 8 Jun 2001 17:34:05 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200106082134.OAA12792@csl.Stanford.EDU>
Subject: [CHECKER] 15 probable security holes in 2.4.5-ac8
To: linux-kernel@vger.kernel.org
Date: Fri, 8 Jun 2001 14:34:01 -0700 (PDT)
Cc: mc@cs.Stanford.EDU
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

here are 15 probable security holes where user input (e.g. data from
copy_from_user, get_user, etc) is:

	1. passed as a length argument to copy_*user (or passed to a 
	function that does so),  OR

	2. is used as an array index.  

The main difference between this and past checkers is that we do
"inherited" tainting: if a structure is copied in from user space,
we recursively mark all of it's fields as tainted as well.  I'm still
fussing with the extension, so hopefully find a bunch more errors after
this batch.

You can look at this checker as essentially tracking whether the
information from an untrusted source (e.g., from copy_from_user) can reach
a trusting sink (e.g., an array index).  The main limiting factor on its
effectiveness is that we have a very incomplete notion of trusting sinks.
If anyone has suggestions for other general places where it's dangerous
to consume bad data, please send me an email.

Here's the location summary:

#  Total 				  = 15
# BUGs	|	File Name
3	|	drivers/char/drm/mga_state.c
2	|	drivers/scsi/megaraid.c
2	|	drivers/char/drm/i810_dma.c
2	|	drivers/char/raw.c
1	|	drivers/usb/usbvideo.c
1	|	drivers/usb/se401.c
1	|	drivers/net/hamradio/scc.c
1	|	drivers/char/moxa.c
1	|	drivers/media/video/zr36120.c
1	|	drivers/media/video/zr36067.c

Dawson
---------------------------------------------------------
[BUG]  dataxferlen is never checked.
/u2/engler/mc/oses/linux/2.4.5-ac8/drivers/scsi/megaraid.c:4108:megadev_ioctl: ERROR:RANGE:3825:4108: Using user length "dataxferlen" as argument to "copy_from_user" [type=LOCAL] [state = any_check] set by 'copy_from_user':3825 [val=28300]
	ret = verify_area (VERIFY_WRITE, (char *) arg, sizeof (struct uioctl_t));

	if (ret)
		return ret;

Start --->
	if(copy_from_user (&ioc, (char *) arg, sizeof (struct uioctl_t)))

	... DELETED 277 lines ...

			if (inlen) {
				if (ioc.mbox[0] == MEGA_MBOXCMD_PASSTHRU) {
					/* copyin the user data */
					copy_from_user (kphysaddr,
							uaddr,
Error --->
							ioc.pthru.dataxferlen);
				} else {
					copy_from_user (kphysaddr,
							uaddr, inlen);
---------------------------------------------------------
[BUG] symetry.
/u2/engler/mc/oses/linux/2.4.5-ac8/drivers/scsi/megaraid.c:4167:megadev_ioctl: ERROR:RANGE:3825:4167: Using user length "dataxferlen" as argument to "copy_to_user" [type=LOCAL] [state = any_check] set by 'copy_from_user':3825 [val=34200]
	ret = verify_area (VERIFY_WRITE, (char *) arg, sizeof (struct uioctl_t));

	if (ret)
		return ret;

Start --->
	if(copy_from_user (&ioc, (char *) arg, sizeof (struct uioctl_t)))

	... DELETED 336 lines ...

		down (&mimd_ioctl_sem);

		if (!scsicmd->result && outlen) {
			if (ioc.mbox[0] == MEGA_MBOXCMD_PASSTHRU) {
				copy_to_user (uaddr,
Error --->
					      kphysaddr, ioc.pthru.dataxferlen);
			} else {
				copy_to_user (uaddr, kphysaddr, outlen);
			}
---------------------------------------------------------
[BUG]
static int moxaload320b(int cardno, unsigned char * tmp, int len)
{
        unsigned long baseAddr;
        int i;
        if(copy_from_user(moxaBuff, tmp, len))
                return -EFAULT;
/u2/engler/mc/oses/linux/2.4.5-ac8/drivers/char/moxa.c:1730:MoxaDriverIoctl: ERROR:RANGE:1728:1730: Using user length "len" as argument to "moxaload320b" [type=GLOBAL] [state = tainted] set by 'copy_from_user':1728 [val=200]
	case MOXA_FIND_BOARD:
		if(copy_from_user(&dltmp, (void *)arg, sizeof(struct dl_str)))
			return -EFAULT;
		return moxafindcard(dltmp.cardno);
	case MOXA_LOAD_C320B:
Start --->
		if(copy_from_user(&dltmp, (void *)arg, sizeof(struct dl_str)))
			return -EFAULT;
Error --->
		moxaload320b(dltmp.cardno, dltmp.buf, dltmp.len);
		return (0);
	case MOXA_LOAD_CODE:
		if(copy_from_user(&dltmp, (void *)arg, sizeof(struct dl_str)))
---------------------------------------------------------
[BUG]  d.idx is an int: < 0 = bad news.
/u2/engler/mc/oses/linux/2.4.5-ac8/drivers/char/drm/i810_dma.c:1413:i810_copybuf: ERROR:RANGE:1409:1413: Using user length "idx"as an array index for "buflist" set by 'copy_from_user':1409 [val=400]
	if(!_DRM_LOCK_IS_HELD(dev->lock.hw_lock->lock)) {
		DRM_ERROR("i810_dma called without lock held\n");
		return -EINVAL;
	}
   
Start --->
   	if (copy_from_user(&d, (drm_i810_copy_t *)arg, sizeof(d)))
		return -EFAULT;

	if(d.idx > dma->buf_count) return -EINVAL;
Error --->
	buf = dma->buflist[ d.idx ];
   	buf_priv = buf->dev_private;
	if (buf_priv->currently_mapped != I810_BUF_MAPPED) return -EPERM;

---------------------------------------------------------
[BUG]  ouch.  (routine also uses it as an index)
/u2/engler/mc/oses/linux/2.4.5-ac8/drivers/usb/se401.c:1290:se401_ioctl: ERROR:RANGE:1286:1290: Using user length "frame"as an array index for "frame" set by 'copy_from_user':1286 [val=400]
	}
	case VIDIOCSYNC:
	{
		int frame, ret=0;

Start --->
		if (copy_from_user((void *)&frame, arg, sizeof(int)))
			return -EFAULT;

		ret=se401_newframe(se401, frame);
Error --->
		se401->frame[frame].grabstate=FRAME_UNUSED;
		return ret;
	}
	case VIDIOCGFBUF:
---------------------------------------------------------
[BUG]  ouch x 2: no check either way.
/u2/engler/mc/oses/linux/2.4.5-ac8/drivers/char/drm/mga_state.c:835:mga_iload: ERROR:RANGE:827:835: Using user length "idx"as an array index for "buflist" set by 'copy_from_user':827 [val=800]
	drm_buf_t *buf;
	drm_mga_buf_priv_t *buf_priv;
	drm_mga_iload_t iload;
	unsigned long bus_address;

Start --->
	if (copy_from_user(&iload, (drm_mga_iload_t *) arg, sizeof(iload)))
		return -EFAULT;

	if (!_DRM_LOCK_IS_HELD(dev->lock.hw_lock->lock)) {
		DRM_ERROR("mga_iload called without lock held\n");
		return -EINVAL;
	}

Error --->
	buf = dma->buflist[iload.idx];
	buf_priv = buf->dev_private;
	bus_address = buf->bus_address;

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac8/drivers/char/drm/mga_state.c:923:mga_indices: ERROR:RANGE:915:923: Using user length "idx"as an array index for "buflist" set by 'copy_from_user':915 [val=800]
	drm_buf_t *buf;
	drm_mga_buf_priv_t *buf_priv;
	drm_mga_indices_t indices;

	if (copy_from_user(&indices,
Start --->
			   (drm_mga_indices_t *)arg, sizeof(indices)))
		return -EFAULT;

	if (!_DRM_LOCK_IS_HELD(dev->lock.hw_lock->lock)) {
		DRM_ERROR("mga_indices called without lock held\n");
		return -EINVAL;
	}

Error --->
	buf = dma->buflist[indices.idx];
	buf_priv = buf->dev_private;

	buf_priv->discard = indices.discard;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac8/drivers/char/drm/mga_state.c:877:mga_vertex: ERROR:RANGE:869:877: Using user length "idx"as an array index for "buflist" set by 'copy_from_user':869 [val=800]
	drm_device_dma_t *dma = dev->dma;
	drm_buf_t *buf;
	drm_mga_buf_priv_t *buf_priv;
	drm_mga_vertex_t vertex;

Start --->
	if (copy_from_user(&vertex, (drm_mga_vertex_t *) arg, sizeof(vertex)))
		return -EFAULT;

	if (!_DRM_LOCK_IS_HELD(dev->lock.hw_lock->lock)) {
		DRM_ERROR("mga_vertex called without lock held\n");
		return -EINVAL;
	}

Error --->
	buf = dma->buflist[vertex.idx];
	buf_priv = buf->dev_private;

	buf->used = vertex.used;
---------------------------------------------------------
[BUG] (but i'm not sure whey we're missing the initial irq).
/u2/engler/mc/oses/linux/2.4.5-ac8/drivers/net/hamradio/scc.c:1772:scc_net_ioctl: ERROR:RANGE:1762:1772: Using user length "irq"as an array index for "Ivec" set by 'copy_from_user':1762 [val=1000]
			if (!arg) return -EFAULT;

			if (Nchips >= SCC_MAXCHIPS) 
				return -EINVAL;

Start --->
			if (copy_from_user(&hwcfg, arg, sizeof(hwcfg)))
				return -EFAULT;

			if (hwcfg.irq == 2) hwcfg.irq = 9;

			if (!Ivec[hwcfg.irq].used && hwcfg.irq)
			{
				if (request_irq(hwcfg.irq, scc_isr, SA_INTERRUPT, "AX.25 SCC", NULL))
					printk(KERN_WARNING "z8530drv: warning, cannot get IRQ %d\n", hwcfg.irq);
				else
Error --->
					Ivec[hwcfg.irq].used = 1;
			}

			if (hwcfg.vector_latch) {
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac8/drivers/char/drm/i810_dma.c:1291:i810_dma_vertex: ERROR:RANGE:1278:1291: Using user length "idx"as an array index for "buflist" set by 'copy_from_user':1278 [val=1300]
      	u32 *hw_status = (u32 *)dev_priv->hw_status_page;
   	drm_i810_sarea_t *sarea_priv = (drm_i810_sarea_t *) 
     					dev_priv->sarea_priv; 
	drm_i810_vertex_t vertex;

Start --->
	if (copy_from_user(&vertex, (drm_i810_vertex_t *)arg, sizeof(vertex)))
		return -EFAULT;

   	if(!_DRM_LOCK_IS_HELD(dev->lock.hw_lock->lock)) {
		DRM_ERROR("i810_dma_vertex called without lock held\n");
		return -EINVAL;
	}

	DRM_DEBUG("i810 dma vertex, idx %d used %d discard %d\n",
		  vertex.idx, vertex.used, vertex.discard);

	i810_dma_dispatch_vertex( dev, 
				  dma->buflist[ vertex.idx ], 
Error --->
				  vertex.discard, vertex.used );

   	atomic_add(vertex.used, &dma->total_bytes);
	atomic_inc(&dma->total_dmas);
---------------------------------------------------------
[BUG]  channel is an integer.
/u2/engler/mc/oses/linux/2.4.5-ac8/drivers/media/video/zr36120.c:1032:zoran_ioctl: ERROR:RANGE:1010:1032: Using user length "channel"as an array index for "video_mux" set by 'copy_from_user':1010 [val=2200]

	 case VIDIOCGCHAN:
	 {
		struct video_channel v;
		int mux;
Start --->
		if (copy_from_user(&v, arg,sizeof(v)))

	... DELETED 16 lines ...

		/* too many inputs? no decoder -> no channels */
		if (!ztv->have_decoder || v.channel >= ztv->card->video_inputs)
			return -EINVAL;

		/* now determine the name of the channel */
Error --->
		mux = ztv->card->video_mux[v.channel];
		if (mux & IS_TUNER) {
			/* lets assume only one tuner, yes? */
			strcpy(v.name,"Television");
---------------------------------------------------------
[BUG]  usbvideo_GetFrame can fail, but result is not checked before index.
/u2/engler/mc/oses/linux/2.4.5-ac8/drivers/usb/usbvideo.c:1596:usbvideo_v4l_ioctl: ERROR:RANGE:1572:1596: Using user length "frameNum"as an array index for "frame" set by 'copy_from_user':1572 [val=2400]
		}
		case VIDIOCSYNC:
		{
			int frameNum, ret;

Start --->
			if (copy_from_user((void *)&frameNum, arg, sizeof(frameNum))) {

	... DELETED 18 lines ...

			 * The frame is in FrameState_Done_Hold state. Release it
			 * right now because its data is already mapped into
			 * the user space and it's up to the application to
			 * make use of it until it asks for another frame.
			 */
Error --->
			uvd->frame[frameNum].frameState = FrameState_Unused;
			return ret;
		}
		case VIDIOCGFBUF:
---------------------------------------------------------
[BUG]  though, actually, the line: down(&raw_devices[minor].mutex) is much
	more dangerous.
/u2/engler/mc/oses/linux/2.4.5-ac8/drivers/char/raw.c:234:raw_ctl_ioctl: ERROR:RANGE:192:234: Using user length "minor"as an array index for "raw_devices" [val=4200]
	case RAW_SETBIND:
	case RAW_GETBIND:

		/* First, find out which raw minor we want */

Start --->
		err = copy_from_user(&rq, (void *) arg, sizeof(rq));

	... DELETED 36 lines ...

				up(&raw_devices[minor].mutex);
				err = -EBUSY;
				break;
			}
			if (raw_devices[minor].binding)
Error --->
				bdput(raw_devices[minor].binding);
			raw_devices[minor].binding = 
				bdget(kdev_t_to_nr(MKDEV(rq.block_major, rq.block_minor)));
			up(&raw_devices[minor].mutex);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac8/drivers/char/raw.c:242:raw_ctl_ioctl: ERROR:RANGE:192:242: Using user length "minor"as an array index for "raw_devices" [val=5000]
	case RAW_SETBIND:
	case RAW_GETBIND:

		/* First, find out which raw minor we want */

Start --->
		err = copy_from_user(&rq, (void *) arg, sizeof(rq));

	... DELETED 44 lines ...

			up(&raw_devices[minor].mutex);
		} else {
			struct block_device *bdev;
			kdev_t dev;

Error --->
			bdev = raw_devices[minor].binding;
			if (bdev) {
				dev = to_kdev_t(bdev->bd_dev);
				rq.block_major = MAJOR(dev);
---------------------------------------------------------
[BUG] pretty sure, though the code is convoluted.
/u2/engler/mc/oses/linux/2.4.5-ac8/drivers/media/video/zr36067.c:3505:do_zoran_ioctl: ERROR:RANGE:3435:3505: Using user length "norm"as an array index for "cardnorms" [val=7000]
			struct video_channel v;
			int input;
			int on, res;
			int encoder_norm;

Start --->
			if (copy_from_user(&v, arg, sizeof(v))) {

	... DELETED 64 lines ...

			}
			encoder_norm = v.norm;

			zr->params.norm = v.norm;
			zr->params.input = v.channel;
Error --->
			zr->timing = cardnorms[zr->card][zr->params.norm];

			/* We switch overlay off and on since a change in the norm
			   needs different VFE settings */

