Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTELQnR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 12:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbTELQnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 12:43:17 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:28549 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262288AbTELQmX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 12:42:23 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 12 May 2003 19:04:54 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: #2 - v4l1-compat update
Message-ID: <20030512170454.GA23890@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch updates the v4l1-compat module.  Changes:
 * use f_op->poll() instead of do_select()
 * reduce stack usage of the v4l1_translate_ioctl() function.
 * misc minor fixes here and there.

Please apply,

  Gerd

diff -u linux-2.5.69/drivers/media/video/v4l1-compat.c linux/drivers/media/video/v4l1-compat.c
--- linux-2.5.69/drivers/media/video/v4l1-compat.c	2003-05-08 13:31:03.000000000 +0200
+++ linux/drivers/media/video/v4l1-compat.c	2003-05-08 13:55:11.000000000 +0200
@@ -127,6 +127,8 @@
 	return 0;
 }
 
+/* ----------------------------------------------------------------- */
+
 static int palette2pixelformat[] = {
 	[VIDEO_PALETTE_GREY]    = V4L2_PIX_FMT_GREY,
 	[VIDEO_PALETTE_RGB555]  = V4L2_PIX_FMT_RGB555,
@@ -145,16 +147,16 @@
 	[VIDEO_PALETTE_YUV422P] = V4L2_PIX_FMT_YUV422P,
 };
 
-static int
-palette_to_pixelformat(int palette)
+static unsigned int
+palette_to_pixelformat(unsigned int palette)
 {
-	if (palette < sizeof(palette2pixelformat)/sizeof(int))
+	if (palette < ARRAY_SIZE(palette2pixelformat))
 		return palette2pixelformat[palette];
 	else
 		return 0;
 }
 
-static int
+static unsigned int
 pixelformat_to_palette(int pixelformat)
 {
 	int	palette = 0;
@@ -199,66 +201,43 @@
 	return palette;
 }
 
-/*  Do an 'in' (wait for input) select on a single file descriptor  */
-/*  This stuff plaigarized from linux/fs/select.c     */
-#define __FD_IN(fds, n)	(fds->in + n)
-#define BIT(i)		(1UL << ((i)&(__NFDBITS-1)))
-#define SET(i,m)	(*(m) |= (i))
-extern int do_select(int n, fd_set_bits *fds, long *timeout);
-
+/* ----------------------------------------------------------------- */
 
-static int
-simple_select(struct file *file)
+static int poll_one(struct file *file)
 {
-	fd_set_bits fds;
-	char *bits;
-	long timeout;
-	int i, fd, n, ret, size;
-
-	for (i = 0; i < current->files->max_fds; ++i)
-		if (file == current->files->fd[i])
-			break;
-	if (i == current->files->max_fds)
-		return -EINVAL;
-	fd = i;
-	n = fd + 1;
-
-	timeout = MAX_SCHEDULE_TIMEOUT;
-	/*
-	 * We need 6 bitmaps (in/out/ex for both incoming and outgoing),
-	 * since we used fdset we need to allocate memory in units of
-	 * long-words. 
-	 */
-	ret = -ENOMEM;
-	size = FDS_BYTES(n);
-	bits = kmalloc(6 * size, GFP_KERNEL);
-	if (!bits)
-		goto out_nofds;
-	fds.in      = (unsigned long *)  bits;
-	fds.out     = (unsigned long *) (bits +   size);
-	fds.ex      = (unsigned long *) (bits + 2*size);
-	fds.res_in  = (unsigned long *) (bits + 3*size);
-	fds.res_out = (unsigned long *) (bits + 4*size);
-	fds.res_ex  = (unsigned long *) (bits + 5*size);
-
-	/*  All zero except our one file descriptor bit, for input  */
-	memset(bits, 0, 6 * size);
-	SET(BIT(fd), __FD_IN((&fds), fd / __NFDBITS));
-
-	ret = do_select(n, &fds, &timeout);
-
-	if (ret < 0)
-		goto out;
-	if (!ret) {
-		ret = -ERESTARTNOHAND;
-		if (signal_pending(current))
-			goto out;
-		ret = 0;
-	}
-out:
-	kfree(bits);
-out_nofds:
-	return ret;
+	int retval = 1;
+	poll_table *table;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,48)
+	poll_table wait_table;
+
+	poll_initwait(&wait_table);
+	table = &wait_table;
+#else
+	struct poll_wqueues pwq;
+
+	poll_initwait(&pwq);
+	table = &pwq.pt;
+#endif
+	for (;;) {
+		int mask;
+		set_current_state(TASK_INTERRUPTIBLE);
+		mask = file->f_op->poll(file, table);
+		if (mask & POLLIN)
+			break;
+		table = NULL;
+		if (signal_pending(current)) {
+			retval = -ERESTARTSYS;
+			break;
+		}
+		schedule();
+	}
+	current->state = TASK_RUNNING;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,48)
+	poll_freewait(&wait_table);
+#else
+	poll_freewait(&pwq);
+#endif
+	return retval;
 }
 
 static int count_inputs(struct inode         *inode,
@@ -306,6 +285,7 @@
 	return 0;
 }
 
+/* ----------------------------------------------------------------- */
 
 /*
  *	This function is exported.
@@ -317,26 +297,36 @@
 			   void			*arg,
 			   v4l2_kioctl          drv)
 {
-	int	             err = -ENOIOCTLCMD;
+	struct v4l2_capability  *cap2 = NULL;
+	struct v4l2_format	*fmt2 = NULL;
 
-	switch (cmd)
-	{
+	struct v4l2_framebuffer fbuf2;
+	struct v4l2_input	input2;
+	struct v4l2_tuner	tun2;
+	struct v4l2_standard	std2;
+	struct v4l2_frequency   freq2;
+	struct v4l2_audio	aud2;
+	struct v4l2_queryctrl	qctrl2;
+	struct v4l2_buffer	buf2;
+	v4l2_std_id    		sid;
+	int i, err = 0;
+
+	switch (cmd) {
 	case VIDIOCGCAP:	/* capability */
 	{
 		struct video_capability *cap = arg;
-		struct v4l2_capability cap2;
-		struct v4l2_framebuffer fbuf2;
-		
+
+		cap2 = kmalloc(sizeof(*cap2),GFP_KERNEL);
 		memset(cap, 0, sizeof(*cap));
-		memset(&cap2, 0, sizeof(cap2));
+		memset(cap2, 0, sizeof(*cap2));
 		memset(&fbuf2, 0, sizeof(fbuf2));
 
-		err = drv(inode, file, VIDIOC_QUERYCAP, &cap2);
+		err = drv(inode, file, VIDIOC_QUERYCAP, cap2);
 		if (err < 0) {
 			dprintk("VIDIOCGCAP / VIDIOC_QUERYCAP: %d\n",err);
 			break;
 		}
-		if (cap2.capabilities & V4L2_CAP_VIDEO_OVERLAY) {
+		if (cap2->capabilities & V4L2_CAP_VIDEO_OVERLAY) {
 			err = drv(inode, file, VIDIOC_G_FBUF, &fbuf2);
 			if (err < 0) {
 				dprintk("VIDIOCGCAP / VIDIOC_G_FBUF: %d\n",err);
@@ -345,16 +335,16 @@
 			err = 0;
 		}
 
-		memcpy(cap->name, cap2.card, 
-		       min(sizeof(cap->name), sizeof(cap2.card)));
+		memcpy(cap->name, cap2->card, 
+		       min(sizeof(cap->name), sizeof(cap2->card)));
 		cap->name[sizeof(cap->name) - 1] = 0;
-		if (cap2.capabilities & V4L2_CAP_VIDEO_CAPTURE)
+		if (cap2->capabilities & V4L2_CAP_VIDEO_CAPTURE)
 			cap->type |= VID_TYPE_CAPTURE;
-		if (cap2.capabilities & V4L2_CAP_TUNER)
+		if (cap2->capabilities & V4L2_CAP_TUNER)
 			cap->type |= VID_TYPE_TUNER;
-		if (cap2.capabilities & V4L2_CAP_VBI_CAPTURE)
+		if (cap2->capabilities & V4L2_CAP_VBI_CAPTURE)
 			cap->type |= VID_TYPE_TELETEXT;
-		if (cap2.capabilities & V4L2_CAP_VIDEO_OVERLAY)
+		if (cap2->capabilities & V4L2_CAP_VIDEO_OVERLAY)
 			cap->type |= VID_TYPE_OVERLAY;
 		if (fbuf2.capability & V4L2_FBUF_CAP_LIST_CLIPPING)
 			cap->type |= VID_TYPE_CLIPPING;
@@ -370,7 +360,6 @@
 	case VIDIOCGFBUF: /*  get frame buffer  */
 	{
 		struct video_buffer	*buffer = arg;
-		struct v4l2_framebuffer	fbuf2;
 
 		err = drv(inode, file, VIDIOC_G_FBUF, &fbuf2);
 		if (err < 0) {
@@ -412,7 +401,6 @@
 	case VIDIOCSFBUF: /*  set frame buffer  */
 	{
 		struct video_buffer	*buffer = arg;
-		struct v4l2_framebuffer	fbuf2;
 
 		memset(&fbuf2, 0, sizeof(fbuf2));
 		fbuf2.base       = buffer->base;
@@ -444,36 +432,36 @@
 	case VIDIOCGWIN: /*  get window or capture dimensions  */
 	{
 		struct video_window	*win = arg;
-		struct v4l2_format	fmt2;
 
+		fmt2 = kmalloc(sizeof(*fmt2),GFP_KERNEL);
 		memset(win,0,sizeof(*win));
-		memset(&fmt2,0,sizeof(fmt2));
+		memset(fmt2,0,sizeof(*fmt2));
 
-		fmt2.type = V4L2_BUF_TYPE_VIDEO_OVERLAY;
-		err = drv(inode, file, VIDIOC_G_FMT, &fmt2);
+		fmt2->type = V4L2_BUF_TYPE_VIDEO_OVERLAY;
+		err = drv(inode, file, VIDIOC_G_FMT, fmt2);
 		if (err < 0)
 			dprintk("VIDIOCGWIN / VIDIOC_G_WIN: %d\n",err);
 		if (err == 0) {
-			win->x         = fmt2.fmt.win.w.left;
-			win->y         = fmt2.fmt.win.w.top;
-			win->width     = fmt2.fmt.win.w.width;
-			win->height    = fmt2.fmt.win.w.height;
-			win->chromakey = fmt2.fmt.win.chromakey;
+			win->x         = fmt2->fmt.win.w.left;
+			win->y         = fmt2->fmt.win.w.top;
+			win->width     = fmt2->fmt.win.w.width;
+			win->height    = fmt2->fmt.win.w.height;
+			win->chromakey = fmt2->fmt.win.chromakey;
 			win->clips     = NULL;
 			win->clipcount = 0;
 			break;
 		}
 
-		fmt2.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
-		err = drv(inode, file, VIDIOC_G_FMT, &fmt2);
+		fmt2->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+		err = drv(inode, file, VIDIOC_G_FMT, fmt2);
 		if (err < 0) {
 			dprintk("VIDIOCGWIN / VIDIOC_G_FMT: %d\n",err);
 			break;
 		}
 		win->x         = 0;
 		win->y         = 0;
-		win->width     = fmt2.fmt.pix.width;
-		win->height    = fmt2.fmt.pix.height;
+		win->width     = fmt2->fmt.pix.width;
+		win->height    = fmt2->fmt.pix.height;
 		win->chromakey = 0;
 		win->clips     = NULL;
 		win->clipcount = 0;
@@ -482,37 +470,41 @@
 	case VIDIOCSWIN: /*  set window and/or capture dimensions  */
 	{
 		struct video_window	*win = arg;
-		struct v4l2_format	fmt2;
+		int err1,err2;
 
-		memset(&fmt2,0,sizeof(fmt2));
-		fmt2.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
-		err = drv(inode, file, VIDIOC_G_FMT, &fmt2);
-		if (err < 0)
+		fmt2 = kmalloc(sizeof(*fmt2),GFP_KERNEL);
+		memset(fmt2,0,sizeof(*fmt2));
+		fmt2->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+		err1 = drv(inode, file, VIDIOC_G_FMT, fmt2);
+		if (err1 < 0)
 			dprintk("VIDIOCSWIN / VIDIOC_G_FMT: %d\n",err);
-		if (err == 0) {
-			fmt2.fmt.pix.width  = win->width;
-			fmt2.fmt.pix.height = win->height;
-			fmt2.fmt.pix.field  = V4L2_FIELD_ANY;
-			err = drv(inode, file, VIDIOC_S_FMT, &fmt2);
+		if (err1 == 0) {
+			fmt2->fmt.pix.width  = win->width;
+			fmt2->fmt.pix.height = win->height;
+			fmt2->fmt.pix.field  = V4L2_FIELD_ANY;
+			err = drv(inode, file, VIDIOC_S_FMT, fmt2);
 			if (err < 0)
 				dprintk("VIDIOCSWIN / VIDIOC_S_FMT #1: %d\n",
 					err);
-			win->width  = fmt2.fmt.pix.width;
-			win->height = fmt2.fmt.pix.height;
+			win->width  = fmt2->fmt.pix.width;
+			win->height = fmt2->fmt.pix.height;
 		}
 
-		memset(&fmt2,0,sizeof(fmt2));
-		fmt2.type = V4L2_BUF_TYPE_VIDEO_OVERLAY;
-		fmt2.fmt.win.w.left    = win->x;
-		fmt2.fmt.win.w.top     = win->y;
-		fmt2.fmt.win.w.width   = win->width;
-		fmt2.fmt.win.w.height  = win->height;
-		fmt2.fmt.win.chromakey = win->chromakey;
-		fmt2.fmt.win.clips     = (void *)win->clips;
-		fmt2.fmt.win.clipcount = win->clipcount;
-		err = drv(inode, file, VIDIOC_S_FMT, &fmt2);
-		if (err < 0)
+		memset(fmt2,0,sizeof(*fmt2));
+		fmt2->type = V4L2_BUF_TYPE_VIDEO_OVERLAY;
+		fmt2->fmt.win.w.left    = win->x;
+		fmt2->fmt.win.w.top     = win->y;
+		fmt2->fmt.win.w.width   = win->width;
+		fmt2->fmt.win.w.height  = win->height;
+		fmt2->fmt.win.chromakey = win->chromakey;
+		fmt2->fmt.win.clips     = (void *)win->clips;
+		fmt2->fmt.win.clipcount = win->clipcount;
+		err2 = drv(inode, file, VIDIOC_S_FMT, fmt2);
+		if (err2 < 0)
 			dprintk("VIDIOCSWIN / VIDIOC_S_FMT #2: %d\n",err);
+
+		if (err1 != 0 && err2 != 0)
+			err = err1;
 		break;
 	}
 	case VIDIOCCAPTURE: /*  turn on/off preview  */
@@ -525,8 +517,6 @@
 	case VIDIOCGCHAN: /*  get input information  */
 	{
 		struct video_channel	*chan = arg;
-		struct v4l2_input	input2;
-		v4l2_std_id    		sid;
 
 		memset(&input2,0,sizeof(input2));
 		input2.index = chan->channel;
@@ -568,16 +558,32 @@
 	case VIDIOCSCHAN: /*  set input  */
 	{
 		struct video_channel *chan = arg;
-		
+
+		sid = 0;
 		err = drv(inode, file, VIDIOC_S_INPUT, &chan->channel);
 		if (err < 0)
 			dprintk("VIDIOCSCHAN / VIDIOC_S_INPUT: %d\n",err);
+		switch (chan->norm) {
+		case VIDEO_MODE_PAL:
+			sid = V4L2_STD_PAL;
+			break;
+		case VIDEO_MODE_NTSC:
+			sid = V4L2_STD_NTSC;
+			break;
+		case VIDEO_MODE_SECAM:
+			sid = V4L2_STD_SECAM;
+			break;
+		}
+		if (0 != sid) {
+			err = drv(inode, file, VIDIOC_S_STD, &sid);
+			if (err < 0)
+				dprintk("VIDIOCSCHAN / VIDIOC_S_STD: %d\n",err);
+		}
 		break;
 	}
 	case VIDIOCGPICT: /*  get tone controls & partial capture format  */
 	{
 		struct video_picture	*pict = arg;
-		struct v4l2_format	fmt2;
 
 		pict->brightness = get_v4l_control(inode, file,
 						   V4L2_CID_BRIGHTNESS,drv);
@@ -590,25 +596,24 @@
 		pict->whiteness = get_v4l_control(inode, file,
 						  V4L2_CID_WHITENESS, drv);
 
-		memset(&fmt2,0,sizeof(fmt2));
-		fmt2.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
-		err = drv(inode, file, VIDIOC_G_FMT, &fmt2);
+		fmt2 = kmalloc(sizeof(*fmt2),GFP_KERNEL);
+		memset(fmt2,0,sizeof(*fmt2));
+		fmt2->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+		err = drv(inode, file, VIDIOC_G_FMT, fmt2);
 		if (err < 0) {
 			dprintk("VIDIOCGPICT / VIDIOC_G_FMT: %d\n",err);
 			break;
 		}
 #if 0 /* FIXME */
-		pict->depth   = fmt2.fmt.pix.depth;
+		pict->depth   = fmt2->fmt.pix.depth;
 #endif
 		pict->palette = pixelformat_to_palette(
-			fmt2.fmt.pix.pixelformat);
+			fmt2->fmt.pix.pixelformat);
 		break;
 	}
 	case VIDIOCSPICT: /*  set tone controls & partial capture format  */
 	{
 		struct video_picture	*pict = arg;
-		struct v4l2_format	fmt2;
-		struct v4l2_framebuffer	fbuf2;
 
 		set_v4l_control(inode, file,
 				V4L2_CID_BRIGHTNESS, pict->brightness, drv);
@@ -621,16 +626,17 @@
 		set_v4l_control(inode, file,
 				V4L2_CID_WHITENESS, pict->whiteness, drv);
 
-		memset(&fmt2,0,sizeof(fmt2));
-		fmt2.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
-		err = drv(inode, file, VIDIOC_G_FMT, &fmt2);
+		fmt2 = kmalloc(sizeof(*fmt2),GFP_KERNEL);
+		memset(fmt2,0,sizeof(*fmt2));
+		fmt2->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+		err = drv(inode, file, VIDIOC_G_FMT, fmt2);
 		if (err < 0)
 			dprintk("VIDIOCSPICT / VIDIOC_G_FMT: %d\n",err);
-		if (fmt2.fmt.pix.pixelformat != 
+		if (fmt2->fmt.pix.pixelformat != 
 		    palette_to_pixelformat(pict->palette)) {
-			fmt2.fmt.pix.pixelformat = palette_to_pixelformat(
+			fmt2->fmt.pix.pixelformat = palette_to_pixelformat(
 				pict->palette);
-			err = drv(inode, file, VIDIOC_S_FMT, &fmt2);
+			err = drv(inode, file, VIDIOC_S_FMT, fmt2);
 			if (err < 0)
 				dprintk("VIDIOCSPICT / VIDIOC_S_FMT: %d\n",err);
 		}
@@ -652,8 +658,6 @@
 	case VIDIOCGTUNER: /*  get tuner information  */
 	{
 		struct video_tuner	*tun = arg;
-		struct v4l2_tuner	tun2;
-		v4l2_std_id    		sid;
 
 		memset(&tun2,0,sizeof(tun2));
 		err = drv(inode, file, VIDIOC_G_TUNER, &tun2);
@@ -669,6 +673,19 @@
 		tun->flags = 0;
 		tun->mode = VIDEO_MODE_AUTO;
 
+		for (i = 0; i < 64; i++) {
+			memset(&std2,0,sizeof(std2));
+			std2.index = i;
+			if (0 != drv(inode, file, VIDIOC_ENUMSTD, &std2))
+				break;
+			if (std2.id & V4L2_STD_PAL)
+				tun->flags |= VIDEO_TUNER_PAL;
+			if (std2.id & V4L2_STD_NTSC)
+				tun->flags |= VIDEO_TUNER_NTSC;
+			if (std2.id & V4L2_STD_SECAM)
+				tun->flags |= VIDEO_TUNER_SECAM;
+		}
+
 		err = drv(inode, file, VIDIOC_G_STD, &sid);
 		if (err < 0)
 			dprintk("VIDIOCGTUNER / VIDIOC_G_STD: %d\n",err);
@@ -688,21 +705,20 @@
 		tun->signal = tun2.signal;
 		break;
 	}
-#if 0 /* FIXME */
 	case VIDIOCSTUNER: /*  select a tuner input  */
 	{
-		int	i;
-
+#if 0 /* FIXME */
 		err = drv(inode, file, VIDIOC_S_INPUT, &i);
 		if (err < 0)
 			dprintk("VIDIOCSTUNER / VIDIOC_S_INPUT: %d\n",err);
+#else
+		err = 0;
+#endif
 		break;
 	}
-#endif
 	case VIDIOCGFREQ: /*  get frequency  */
 	{
 		int *freq = arg;
-		struct v4l2_frequency freq2;
 		
 		err = drv(inode, file, VIDIOC_G_FREQUENCY, &freq2);
 		if (err < 0)
@@ -714,7 +730,6 @@
 	case VIDIOCSFREQ: /*  set frequency  */
 	{
 		int *freq = arg;
-		struct v4l2_frequency freq2;
 
 		drv(inode, file, VIDIOC_G_FREQUENCY, &freq2);
 		freq2.frequency = *freq;
@@ -726,10 +741,6 @@
 	case VIDIOCGAUDIO: /*  get audio properties/controls  */
 	{
 		struct video_audio	*aud = arg;
-		struct v4l2_audio	aud2;
-		struct v4l2_queryctrl	qctrl2;
-		struct v4l2_tuner	tun2;
-		int			v;
 
 		err = drv(inode, file, VIDIOC_G_AUDIO, &aud2);
 		if (err < 0) {
@@ -741,34 +752,29 @@
 		aud->name[sizeof(aud->name) - 1] = 0;
 		aud->audio = aud2.index;
 		aud->flags = 0;
-		v = get_v4l_control(inode, file, V4L2_CID_AUDIO_VOLUME, drv);
-		if (v >= 0)
-		{
-			aud->volume = v;
+		i = get_v4l_control(inode, file, V4L2_CID_AUDIO_VOLUME, drv);
+		if (i >= 0) {
+			aud->volume = i;
 			aud->flags |= VIDEO_AUDIO_VOLUME;
 		}
-		v = get_v4l_control(inode, file, V4L2_CID_AUDIO_BASS, drv);
-		if (v >= 0)
-		{
-			aud->bass = v;
+		i = get_v4l_control(inode, file, V4L2_CID_AUDIO_BASS, drv);
+		if (i >= 0) {
+			aud->bass = i;
 			aud->flags |= VIDEO_AUDIO_BASS;
 		}
-		v = get_v4l_control(inode, file, V4L2_CID_AUDIO_TREBLE, drv);
-		if (v >= 0)
-		{
-			aud->treble = v;
+		i = get_v4l_control(inode, file, V4L2_CID_AUDIO_TREBLE, drv);
+		if (i >= 0) {
+			aud->treble = i;
 			aud->flags |= VIDEO_AUDIO_TREBLE;
 		}
-		v = get_v4l_control(inode, file, V4L2_CID_AUDIO_BALANCE, drv);
-		if (v >= 0)
-		{
-			aud->balance = v;
+		i = get_v4l_control(inode, file, V4L2_CID_AUDIO_BALANCE, drv);
+		if (i >= 0) {
+			aud->balance = i;
 			aud->flags |= VIDEO_AUDIO_BALANCE;
 		}
-		v = get_v4l_control(inode, file, V4L2_CID_AUDIO_MUTE, drv);
-		if (v >= 0)
-		{
-			if (v)
+		i = get_v4l_control(inode, file, V4L2_CID_AUDIO_MUTE, drv);
+		if (i >= 0) {
+			if (i)
 				aud->flags |= VIDEO_AUDIO_MUTE;
 			aud->flags |= VIDEO_AUDIO_MUTABLE;
 		}
@@ -795,8 +801,6 @@
 	case VIDIOCSAUDIO: /*  set audio controls  */
 	{
 		struct video_audio	*aud = arg;
-		struct v4l2_audio	aud2;
-		struct v4l2_tuner	tun2;
 
 		memset(&aud2,0,sizeof(aud2));
 		memset(&tun2,0,sizeof(tun2));
@@ -844,83 +848,36 @@
 		break;
 	}
 #if 0
-	case VIDIOCGMBUF: /*  get mmap parameters  */
-	{
-		struct video_mbuf		*mbuf = arg;
-		struct v4l2_requestbuffers	reqbuf2;
-		struct v4l2_buffer		buf2;
-		struct v4l2_format		fmt2, fmt2o;
-		struct v4l2_capability		cap2;
-		int				i;
-
-		/*  Set the format to maximum dimensions  */
-		if ((err = drv(inode, file, VIDIOC_QUERYCAP, &cap2)) < 0)
-			break;
-		fmt2o.type = V4L2_BUF_TYPE_CAPTURE;
-		if ((err = drv(inode, file, VIDIOC_G_FMT, &fmt2o)) < 0)
-			break;
-		fmt2 = fmt2o;
-		fmt2.fmt.pix.width = cap2.maxwidth;
-		fmt2.fmt.pix.height = cap2.maxheight;
-		fmt2.fmt.pix.flags |= V4L2_FMT_FLAG_INTERLACED;
-		if ((err = drv(inode, file, VIDIOC_S_FMT, &fmt2)) < 0)
-			break;
-		reqbuf2.count = 2; /* v4l always used two buffers */
-		reqbuf2.type = V4L2_BUF_TYPE_CAPTURE | V4L2_BUF_REQ_CONTIG;
-		err = drv(inode, file, VIDIOC_REQBUFS, &reqbuf2);
-		if (err < 0 || reqbuf2.count < 2 || reqbuf2.type
-		    != (V4L2_BUF_TYPE_CAPTURE | V4L2_BUF_REQ_CONTIG))
-		{/*	Driver doesn't support v4l back-compatibility  */
-			fmt2o.fmt.pix.flags |= V4L2_FMT_FLAG_INTERLACED;
-			drv(inode, file, VIDIOC_S_FMT, &fmt2o);
-			reqbuf2.count = 1;
-			reqbuf2.type = V4L2_BUF_TYPE_CAPTURE;
-			err = drv(inode, file, VIDIOC_REQBUFS, &reqbuf2);
-			if (err < 0)
-			{
-				err = -EINVAL;
-				break;
-			}
-			printk(KERN_INFO"V4L2: Device \"%s\" doesn't support"
-			       " v4l memory mapping\n", vfl->name);
-		}
-		buf2.index = 0;
-		buf2.type = V4L2_BUF_TYPE_CAPTURE;
-		err = drv(inode, file, VIDIOC_QUERYBUF, &buf2);
-		mbuf->size = buf2.length * reqbuf2.count;
-		mbuf->frames = reqbuf2.count;
-		memset(mbuf->offsets, 0, sizeof(mbuf->offsets));
-		for (i = 0; i < mbuf->frames; ++i)
-			mbuf->offsets[i] = i * buf2.length;
-		break;
-	}
+	case VIDIOCGMBUF:
+		/* v4l2 drivers must implement that themself.  The
+		   mmap() differences can't be translated fully
+		   transparent, thus there is no point to try that */
 #endif
 	case VIDIOCMCAPTURE: /*  capture a frame  */
 	{
 		struct video_mmap	*mm = arg;
-		struct v4l2_buffer	buf2;
-		struct v4l2_format	fmt2;
 
+		fmt2 = kmalloc(sizeof(*fmt2),GFP_KERNEL);
 		memset(&buf2,0,sizeof(buf2));
-		memset(&fmt2,0,sizeof(fmt2));
+		memset(fmt2,0,sizeof(*fmt2));
 		
-		fmt2.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
-		err = drv(inode, file, VIDIOC_G_FMT, &fmt2);
+		fmt2->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+		err = drv(inode, file, VIDIOC_G_FMT, fmt2);
 		if (err < 0) {
 			dprintk("VIDIOCMCAPTURE / VIDIOC_G_FMT: %d\n",err);
 			break;
 		}
-		if (mm->width   != fmt2.fmt.pix.width || 
-		    mm->height != fmt2.fmt.pix.height ||
+		if (mm->width   != fmt2->fmt.pix.width  || 
+		    mm->height  != fmt2->fmt.pix.height ||
 		    palette_to_pixelformat(mm->format) != 
-		    fmt2.fmt.pix.pixelformat)
+		    fmt2->fmt.pix.pixelformat)
 		{/* New capture format...  */
-			fmt2.fmt.pix.width = mm->width;
-			fmt2.fmt.pix.height = mm->height;
-			fmt2.fmt.pix.pixelformat =
+			fmt2->fmt.pix.width = mm->width;
+			fmt2->fmt.pix.height = mm->height;
+			fmt2->fmt.pix.pixelformat =
 				palette_to_pixelformat(mm->format);
-			fmt2.fmt.pix.field = V4L2_FIELD_ANY;
-			err = drv(inode, file, VIDIOC_S_FMT, &fmt2);
+			fmt2->fmt.pix.field = V4L2_FIELD_ANY;
+			err = drv(inode, file, VIDIOC_S_FMT, fmt2);
 			if (err < 0) {
 				dprintk("VIDIOCMCAPTURE / VIDIOC_S_FMT: %d\n",err);
 				break;
@@ -946,7 +903,6 @@
 	case VIDIOCSYNC: /*  wait for a frame  */
 	{
 		int			*i = arg;
-		struct v4l2_buffer	buf2;
 
 		buf2.index = *i;
 		buf2.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
@@ -967,7 +923,7 @@
 			(V4L2_BUF_FLAG_QUEUED | V4L2_BUF_FLAG_DONE))
 		       == V4L2_BUF_FLAG_QUEUED)
 		{
-			err = simple_select(file);
+			err = poll_one(file);
 			if (err < 0 ||	/* error or sleep was interrupted  */
 			    err == 0)	/* timeout? Shouldn't occur.  */
 				break;
@@ -984,20 +940,80 @@
 		} while (err == 0 && buf2.index != *i);
 		break;
 	}
-	case VIDIOCGUNIT: /*  get related device minors  */
-		/*  No translation  */
-		break;
-	case VIDIOCGCAPTURE: /*    */
-		/*  No translation, yet...  */
-		printk(KERN_INFO"v4l1-compat: VIDIOCGCAPTURE not implemented."
-		       " Send patches to bdirks@pacbell.net :-)\n");
-		break;
-	case VIDIOCSCAPTURE: /*    */
-		/*  No translation, yet...  */
-		printk(KERN_INFO"v4l1-compat: VIDIOCSCAPTURE not implemented."
-		       " Send patches to bdirks@pacbell.net :-)\n");
+
+	case VIDIOCGVBIFMT: /* query VBI data capture format */
+	{
+		struct vbi_format      *fmt = arg;
+		
+		fmt2 = kmalloc(sizeof(*fmt2),GFP_KERNEL);
+		memset(fmt2, 0, sizeof(*fmt2));
+		fmt2->type = V4L2_BUF_TYPE_VBI_CAPTURE;
+		
+		err = drv(inode, file, VIDIOC_G_FMT, fmt2);
+		if (err < 0) {
+			dprintk("VIDIOCGVBIFMT / VIDIOC_G_FMT: %d\n", err);
+			break;
+		}
+		memset(fmt, 0, sizeof(*fmt));
+		fmt->samples_per_line = fmt2->fmt.vbi.samples_per_line;
+		fmt->sampling_rate    = fmt2->fmt.vbi.sampling_rate;
+		fmt->sample_format    = VIDEO_PALETTE_RAW;
+		fmt->start[0]         = fmt2->fmt.vbi.start[0];
+		fmt->count[0]         = fmt2->fmt.vbi.count[0];
+		fmt->start[1]         = fmt2->fmt.vbi.start[1];
+		fmt->count[1]         = fmt2->fmt.vbi.count[1];
+		fmt->flags            = fmt2->fmt.vbi.flags & 0x03;
+                break;
+	}
+	case VIDIOCSVBIFMT:
+	{
+		struct vbi_format      *fmt = arg;
+		
+		fmt2 = kmalloc(sizeof(*fmt2),GFP_KERNEL);
+		memset(fmt2, 0, sizeof(*fmt2));
+
+		fmt2->type = V4L2_BUF_TYPE_VBI_CAPTURE;
+		fmt2->fmt.vbi.samples_per_line = fmt->samples_per_line;
+		fmt2->fmt.vbi.sampling_rate    = fmt->sampling_rate;
+		fmt2->fmt.vbi.sample_format    = V4L2_PIX_FMT_GREY;
+		fmt2->fmt.vbi.start[0]         = fmt->start[0]; 
+		fmt2->fmt.vbi.count[0]         = fmt->count[0]; 
+		fmt2->fmt.vbi.start[1]         = fmt->start[1]; 
+		fmt2->fmt.vbi.count[1]         = fmt->count[1]; 
+		fmt2->fmt.vbi.flags            = fmt->flags;
+		err = drv(inode, file, VIDIOC_TRY_FMT, fmt2);
+		if (err < 0) {
+			dprintk("VIDIOCSVBIFMT / VIDIOC_TRY_FMT: %d\n", err);
+			break;
+		}
+
+		if (fmt2->fmt.vbi.samples_per_line != fmt->samples_per_line ||
+		    fmt2->fmt.vbi.sampling_rate    != fmt->sampling_rate    ||
+		    fmt2->fmt.vbi.sample_format    != V4L2_PIX_FMT_GREY     ||
+		    fmt2->fmt.vbi.start[0]         != fmt->start[0]         ||
+		    fmt2->fmt.vbi.count[0]         != fmt->count[0]         ||
+		    fmt2->fmt.vbi.start[1]         != fmt->start[1]         ||
+		    fmt2->fmt.vbi.count[1]         != fmt->count[1]         ||
+		    fmt2->fmt.vbi.flags            != fmt->flags) {
+			err = -EINVAL;
+			break;
+		}
+		err = drv(inode, file, VIDIOC_S_FMT, fmt2);
+		if (err < 0) {
+			dprintk("VIDIOCSVBIFMT / VIDIOC_S_FMT: %d\n", err);
+			break;
+		}
+	}
+	
+	default:
+		err = -ENOIOCTLCMD;
 		break;
 	}
+
+	if (cap2)
+		kfree(cap2);
+	if (fmt2)
+		kfree(fmt2);
 	return err;
 }
 

-- 
sigfault
