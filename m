Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbUFJSjC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbUFJSjC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 14:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUFJSjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 14:39:02 -0400
Received: from mail.kroah.org ([65.200.24.183]:51623 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262337AbUFJSiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 14:38:03 -0400
Date: Thu, 10 Jun 2004 11:34:42 -0700
From: Greg KH <greg@kroah.com>
To: viro@parcelfarce.linux.theplanet.co.uk,
       linux-usb-devel@lists.sourceforge.net
Cc: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Finding user/kernel pointer bugs [no html]
Message-ID: <20040610183442.GA1271@kroah.com>
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu> <20040610044903.GE12308@parcelfarce.linux.theplanet.co.uk> <20040610165821.GB32577@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040610165821.GB32577@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 09:58:21AM -0700, Greg KH wrote:
> On Thu, Jun 10, 2004 at 05:49:03AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > > bugs in drivers/usb/core/devio.c:proc_control() even though that
> > > function has been annotated (this is not the first time cqual has found
> > > bugs in code audited by sparse).   I didn't write any annotations in any
> > 
> > sparse gives warnings on lines 272, 293, 561, 581, 976, 979, 982, 989, 992.
> 
> Ick, sorry, I haven't run sparse on the usb tree in a while, I'll do
> that today and fix it all up.

Ok, here's the patch that I just applied to my trees.  I'll send it off
to Linus after 2.6.7 is out.  It fixes up almost all sparse warnings in
the drivers/usb/* tree.  The main exception is the tty_write warnings
due to the from_user nonesense in that api...

thanks,

greg k-h

# USB: sparse cleanups for the whole driver/usb/* tree.
#
# Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/drivers/usb/class/audio.c b/drivers/usb/class/audio.c
--- a/drivers/usb/class/audio.c	Thu Jun 10 11:34:03 2004
+++ b/drivers/usb/class/audio.c	Thu Jun 10 11:34:03 2004
@@ -2008,6 +2008,7 @@
 {
 	struct usb_mixerdev *ms = (struct usb_mixerdev *)file->private_data;
 	int i, j, val;
+	int __user *int_user_arg = (int __user *)arg;
 
 	if (!ms->state->usbdev)
 		return -ENODEV;
@@ -2034,7 +2035,7 @@
 		return 0;
 	}
 	if (cmd == OSS_GETVERSION)
-		return put_user(SOUND_VERSION, (int *)arg);
+		return put_user(SOUND_VERSION, int_user_arg);
 	if (_IOC_TYPE(cmd) != 'M' || _IOC_SIZE(cmd) != sizeof(int))
 		return -EINVAL;
 	if (_IOC_DIR(cmd) == _IOC_READ) {
@@ -2043,27 +2044,27 @@
 			val = get_rec_src(ms);
 			if (val < 0)
 				return val;
-			return put_user(val, (int *)arg);
+			return put_user(val, int_user_arg);
 
 		case SOUND_MIXER_DEVMASK: /* Arg contains a bit for each supported device */
 			for (val = i = 0; i < ms->numch; i++)
 				val |= 1 << ms->ch[i].osschannel;
-			return put_user(val, (int *)arg);
+			return put_user(val, int_user_arg);
 
 		case SOUND_MIXER_RECMASK: /* Arg contains a bit for each supported recording source */
 			for (val = i = 0; i < ms->numch; i++)
 				if (ms->ch[i].slctunitid)
 					val |= 1 << ms->ch[i].osschannel;
-			return put_user(val, (int *)arg);
+			return put_user(val, int_user_arg);
 
 		case SOUND_MIXER_STEREODEVS: /* Mixer channels supporting stereo */
 			for (val = i = 0; i < ms->numch; i++)
 				if (ms->ch[i].flags & (MIXFLG_STEREOIN | MIXFLG_STEREOOUT))
 					val |= 1 << ms->ch[i].osschannel;
-			return put_user(val, (int *)arg);
+			return put_user(val, int_user_arg);
 			
 		case SOUND_MIXER_CAPS:
-			return put_user(SOUND_CAP_EXCL_INPUT, (int *)arg);
+			return put_user(SOUND_CAP_EXCL_INPUT, int_user_arg);
 
 		default:
 			i = _IOC_NR(cmd);
@@ -2071,7 +2072,7 @@
 				return -EINVAL;
 			for (j = 0; j < ms->numch; j++) {
 				if (ms->ch[j].osschannel == i) {
-					return put_user(ms->ch[j].value, (int *)arg);
+					return put_user(ms->ch[j].value, int_user_arg);
 				}
 			}
 			return -EINVAL;
@@ -2082,7 +2083,7 @@
 	ms->modcnt++;
 	switch (_IOC_NR(cmd)) {
 	case SOUND_MIXER_RECSRC: /* Arg contains a bit for each recording source */
-		if (get_user(val, (int *)arg))
+		if (get_user(val, int_user_arg))
 			return -EFAULT;
 		return set_rec_src(ms, val);
 
@@ -2093,11 +2094,11 @@
 		for (j = 0; j < ms->numch && ms->ch[j].osschannel != i; j++);
 		if (j >= ms->numch)
 			return -EINVAL;
-		if (get_user(val, (int *)arg))
+		if (get_user(val, int_user_arg))
 			return -EFAULT;
 		if (wrmixer(ms, j, val))
 			return -EIO;
-		return put_user(ms->ch[j].value, (int *)arg);
+		return put_user(ms->ch[j].value, int_user_arg);
 	}
 }
 
@@ -2370,6 +2371,7 @@
 {
 	struct usb_audiodev *as = (struct usb_audiodev *)file->private_data;
 	struct usb_audio_state *s = as->state;
+	int __user *int_user_arg = (int __user *)arg;
 	unsigned long flags;
 	audio_buf_info abinfo;
 	count_info cinfo;
@@ -2387,7 +2389,7 @@
 #endif
 	switch (cmd) {
 	case OSS_GETVERSION:
-		return put_user(SOUND_VERSION, (int *)arg);
+		return put_user(SOUND_VERSION, int_user_arg);
 
 	case SNDCTL_DSP_SYNC:
 		if (file->f_mode & FMODE_WRITE)
@@ -2399,7 +2401,7 @@
 
 	case SNDCTL_DSP_GETCAPS:
 		return put_user(DSP_CAP_DUPLEX | DSP_CAP_REALTIME | DSP_CAP_TRIGGER | 
-				DSP_CAP_MMAP | DSP_CAP_BATCH, (int *)arg);
+				DSP_CAP_MMAP | DSP_CAP_BATCH, int_user_arg);
 
 	case SNDCTL_DSP_RESET:
 		if (file->f_mode & FMODE_WRITE) {
@@ -2413,7 +2415,7 @@
 		return 0;
 
 	case SNDCTL_DSP_SPEED:
-		if (get_user(val, (int *)arg))
+		if (get_user(val, int_user_arg))
 			return -EFAULT;
 		if (val >= 0) {
 			if (val < 4000)
@@ -2423,10 +2425,12 @@
 			if (set_format(as, file->f_mode, AFMT_QUERY, val))
 				return -EIO;
 		}
-		return put_user((file->f_mode & FMODE_READ) ? as->usbin.dma.srate : as->usbout.dma.srate, (int *)arg);
+		return put_user((file->f_mode & FMODE_READ) ? 
+				as->usbin.dma.srate : as->usbout.dma.srate,
+				int_user_arg);
 
 	case SNDCTL_DSP_STEREO:
-		if (get_user(val, (int *)arg))
+		if (get_user(val, int_user_arg))
 			return -EFAULT;
 		val2 = (file->f_mode & FMODE_READ) ? as->usbin.dma.format : as->usbout.dma.format;
 		if (val)
@@ -2438,7 +2442,7 @@
 		return 0;
 
 	case SNDCTL_DSP_CHANNELS:
-		if (get_user(val, (int *)arg))
+		if (get_user(val, int_user_arg))
 			return -EFAULT;
 		if (val != 0) {
 			val2 = (file->f_mode & FMODE_READ) ? as->usbin.dma.format : as->usbout.dma.format;
@@ -2450,14 +2454,14 @@
 				return -EIO;
 		}
 		val2 = (file->f_mode & FMODE_READ) ? as->usbin.dma.format : as->usbout.dma.format;
-		return put_user(AFMT_ISSTEREO(val2) ? 2 : 1, (int *)arg);
+		return put_user(AFMT_ISSTEREO(val2) ? 2 : 1, int_user_arg);
 
 	case SNDCTL_DSP_GETFMTS: /* Returns a mask */
 		return put_user(AFMT_U8 | AFMT_U16_LE | AFMT_U16_BE |
-				AFMT_S8 | AFMT_S16_LE | AFMT_S16_BE, (int *)arg);
+				AFMT_S8 | AFMT_S16_LE | AFMT_S16_BE, int_user_arg);
 
 	case SNDCTL_DSP_SETFMT: /* Selects ONE fmt*/
-		if (get_user(val, (int *)arg))
+		if (get_user(val, int_user_arg))
 			return -EFAULT;
 		if (val != AFMT_QUERY) {
 			if (hweight32(val) != 1)
@@ -2471,7 +2475,7 @@
 				return -EIO;
 		}
 		val2 = (file->f_mode & FMODE_READ) ? as->usbin.dma.format : as->usbout.dma.format;
-		return put_user(val2 & ~AFMT_STEREO, (int *)arg);
+		return put_user(val2 & ~AFMT_STEREO, int_user_arg);
 
 	case SNDCTL_DSP_POST:
 		return 0;
@@ -2482,10 +2486,10 @@
 			val |= PCM_ENABLE_INPUT;
 		if (file->f_mode & FMODE_WRITE && as->usbout.flags & FLG_RUNNING) 
 			val |= PCM_ENABLE_OUTPUT;
-		return put_user(val, (int *)arg);
+		return put_user(val, int_user_arg);
 
 	case SNDCTL_DSP_SETTRIGGER:
-		if (get_user(val, (int *)arg))
+		if (get_user(val, int_user_arg))
 			return -EFAULT;
 		if (file->f_mode & FMODE_READ) {
 			if (val & PCM_ENABLE_INPUT) {
@@ -2543,7 +2547,7 @@
 		spin_lock_irqsave(&as->lock, flags);
 		val = as->usbout.dma.count;
 		spin_unlock_irqrestore(&as->lock, flags);
-		return put_user(val, (int *)arg);
+		return put_user(val, int_user_arg);
 
 	case SNDCTL_DSP_GETIPTR:
 		if (!(file->f_mode & FMODE_READ))
@@ -2577,14 +2581,14 @@
 		if (file->f_mode & FMODE_WRITE) {
 			if ((val = prog_dmabuf_out(as)))
 				return val;
-			return put_user(as->usbout.dma.fragsize, (int *)arg);
+			return put_user(as->usbout.dma.fragsize, int_user_arg);
 		}
 		if ((val = prog_dmabuf_in(as)))
 			return val;
-		return put_user(as->usbin.dma.fragsize, (int *)arg);
+		return put_user(as->usbin.dma.fragsize, int_user_arg);
 
 	case SNDCTL_DSP_SETFRAGMENT:
-		if (get_user(val, (int *)arg))
+		if (get_user(val, int_user_arg))
 			return -EFAULT;
 		if (file->f_mode & FMODE_READ) {
 			as->usbin.dma.ossfragshift = val & 0xffff;
@@ -2612,7 +2616,7 @@
 		if ((file->f_mode & FMODE_READ && as->usbin.dma.subdivision) ||
 		    (file->f_mode & FMODE_WRITE && as->usbout.dma.subdivision))
 			return -EINVAL;
-		if (get_user(val, (int *)arg))
+		if (get_user(val, int_user_arg))
 			return -EFAULT;
 		if (val != 1 && val != 2 && val != 4)
 			return -EINVAL;
@@ -2623,15 +2627,17 @@
 		return 0;
 
 	case SOUND_PCM_READ_RATE:
-		return put_user((file->f_mode & FMODE_READ) ? as->usbin.dma.srate : as->usbout.dma.srate, (int *)arg);
+		return put_user((file->f_mode & FMODE_READ) ? 
+				as->usbin.dma.srate : as->usbout.dma.srate,
+				int_user_arg);
 
 	case SOUND_PCM_READ_CHANNELS:
 		val2 = (file->f_mode & FMODE_READ) ? as->usbin.dma.format : as->usbout.dma.format;
-		return put_user(AFMT_ISSTEREO(val2) ? 2 : 1, (int *)arg);
+		return put_user(AFMT_ISSTEREO(val2) ? 2 : 1, int_user_arg);
 
 	case SOUND_PCM_READ_BITS:
 		val2 = (file->f_mode & FMODE_READ) ? as->usbin.dma.format : as->usbout.dma.format;
-		return put_user(AFMT_IS16BIT(val2) ? 16 : 8, (int *)arg);
+		return put_user(AFMT_IS16BIT(val2) ? 16 : 8, int_user_arg);
 
 	case SOUND_PCM_WRITE_FILTER:
 	case SNDCTL_DSP_SETSYNCRO:
diff -Nru a/drivers/usb/image/mdc800.c b/drivers/usb/image/mdc800.c
--- a/drivers/usb/image/mdc800.c	Thu Jun 10 11:34:03 2004
+++ b/drivers/usb/image/mdc800.c	Thu Jun 10 11:34:03 2004
@@ -667,10 +667,10 @@
 /*
  * The Device read callback Function
  */
-static ssize_t mdc800_device_read (struct file *file, char *buf, size_t len, loff_t *pos)
+static ssize_t mdc800_device_read (struct file *file, char __user *buf, size_t len, loff_t *pos)
 {
 	size_t left=len, sts=len; /* single transfer size */
-	char* ptr=buf;
+	char __user *ptr = buf;
 	long timeout;
 	DECLARE_WAITQUEUE(wait, current);
 
@@ -767,7 +767,7 @@
  * After this the driver initiates the request for the answer or
  * just waits until the camera becomes ready.
  */
-static ssize_t mdc800_device_write (struct file *file, const char *buf, size_t len, loff_t *pos)
+static ssize_t mdc800_device_write (struct file *file, const char __user *buf, size_t len, loff_t *pos)
 {
 	size_t i=0;
 	DECLARE_WAITQUEUE(wait, current);
diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	Thu Jun 10 11:34:03 2004
+++ b/drivers/usb/input/hid-core.c	Thu Jun 10 11:34:03 2004
@@ -1324,12 +1324,14 @@
 	}
 
 	err = 0;
-	while ((ret = hid_wait_io(hid))) {
+	ret = hid_wait_io(hid);
+	while (ret) {
 		err |= ret;
 		if (test_bit(HID_CTRL_RUNNING, &hid->iofl))
 			usb_unlink_urb(hid->urbctrl);
 		if (test_bit(HID_OUT_RUNNING, &hid->iofl))
 			usb_unlink_urb(hid->urbout);
+		ret = hid_wait_io(hid);
 	}
 
 	if (err)
diff -Nru a/drivers/usb/input/hiddev.c b/drivers/usb/input/hiddev.c
--- a/drivers/usb/input/hiddev.c	Thu Jun 10 11:34:03 2004
+++ b/drivers/usb/input/hiddev.c	Thu Jun 10 11:34:03 2004
@@ -295,7 +295,7 @@
 /*
  * "write" file op
  */
-static ssize_t hiddev_write(struct file * file, const char * buffer, size_t count, loff_t *ppos)
+static ssize_t hiddev_write(struct file * file, const char __user * buffer, size_t count, loff_t *ppos)
 {
 	return -EINVAL;
 }
@@ -303,7 +303,7 @@
 /*
  * "read" file op
  */
-static ssize_t hiddev_read(struct file * file, char * buffer, size_t count, loff_t *ppos)
+static ssize_t hiddev_read(struct file * file, char __user * buffer, size_t count, loff_t *ppos)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	struct hiddev_list *list = file->private_data;
@@ -406,6 +406,8 @@
 	struct hiddev_devinfo dinfo;
 	struct hid_report *report;
 	struct hid_field *field;
+	int __user *int_user_arg = (int __user *)arg;
+	void __user *user_arg = (void __user *)arg;
 	int i;
 
 	if (!hiddev->exist)
@@ -414,7 +416,7 @@
 	switch (cmd) {
 
 	case HIDIOCGVERSION:
-		return put_user(HID_VERSION, (int *) arg);
+		return put_user(HID_VERSION, int_user_arg);
 
 	case HIDIOCAPPLICATION:
 		if (arg < 0 || arg >= hid->maxapplication)
@@ -439,13 +441,13 @@
 		dinfo.product = dev->descriptor.idProduct;
 		dinfo.version = dev->descriptor.bcdDevice;
 		dinfo.num_applications = hid->maxapplication;
-		if (copy_to_user((void *) arg, &dinfo, sizeof(dinfo)))
+		if (copy_to_user(user_arg, &dinfo, sizeof(dinfo)))
 			return -EFAULT;
 
 		return 0;
 
 	case HIDIOCGFLAG:
-		if (put_user(list->flags, (int *) arg))
+		if (put_user(list->flags, int_user_arg))
 			return -EFAULT;
 
 		return 0;
@@ -453,7 +455,7 @@
 	case HIDIOCSFLAG:
 		{
 			int newflags;
-			if (get_user(newflags, (int *) arg))
+			if (get_user(newflags, int_user_arg))
 				return -EFAULT;
 
 			if ((newflags & ~HIDDEV_FLAGS) != 0 ||
@@ -471,7 +473,7 @@
 			int idx, len;
 			char *buf;
 
-			if (get_user(idx, (int *) arg))
+			if (get_user(idx, int_user_arg))
 				return -EFAULT;
 
 			if ((buf = kmalloc(HID_STRING_SIZE, GFP_KERNEL)) == NULL)
@@ -482,7 +484,7 @@
 				return -EINVAL;
 			}
 
-			if (copy_to_user((void *) (arg+sizeof(int)), buf, len+1)) {
+			if (copy_to_user(user_arg+sizeof(int), buf, len+1)) {
 				kfree(buf);
 				return -EFAULT;
 			}
@@ -498,7 +500,7 @@
 		return 0;
 
 	case HIDIOCGREPORT:
-		if (copy_from_user(&rinfo, (void *) arg, sizeof(rinfo)))
+		if (copy_from_user(&rinfo, user_arg, sizeof(rinfo)))
 			return -EFAULT;
 
 		if (rinfo.report_type == HID_REPORT_TYPE_OUTPUT)
@@ -513,7 +515,7 @@
 		return 0;
 
 	case HIDIOCSREPORT:
-		if (copy_from_user(&rinfo, (void *) arg, sizeof(rinfo)))
+		if (copy_from_user(&rinfo, user_arg, sizeof(rinfo)))
 			return -EFAULT;
 
 		if (rinfo.report_type == HID_REPORT_TYPE_INPUT)
@@ -527,7 +529,7 @@
 		return 0;
 
 	case HIDIOCGREPORTINFO:
-		if (copy_from_user(&rinfo, (void *) arg, sizeof(rinfo)))
+		if (copy_from_user(&rinfo, user_arg, sizeof(rinfo)))
 			return -EFAULT;
 
 		if ((report = hiddev_lookup_report(hid, &rinfo)) == NULL)
@@ -535,13 +537,13 @@
 
 		rinfo.num_fields = report->maxfield;
 
-		if (copy_to_user((void *) arg, &rinfo, sizeof(rinfo)))
+		if (copy_to_user(user_arg, &rinfo, sizeof(rinfo)))
 			return -EFAULT;
 
 		return 0;
 
 	case HIDIOCGFIELDINFO:
-		if (copy_from_user(&finfo, (void *) arg, sizeof(finfo)))
+		if (copy_from_user(&finfo, user_arg, sizeof(finfo)))
 			return -EFAULT;
 		rinfo.report_type = finfo.report_type;
 		rinfo.report_id = finfo.report_id;
@@ -568,7 +570,7 @@
 		finfo.unit_exponent = field->unit_exponent;
 		finfo.unit = field->unit;
 
-		if (copy_to_user((void *) arg, &finfo, sizeof(finfo)))
+		if (copy_to_user(user_arg, &finfo, sizeof(finfo)))
 			return -EFAULT;
 
 		return 0;
@@ -578,7 +580,7 @@
 		if (!uref_multi)
 			return -ENOMEM;
 		uref = &uref_multi->uref;
-		if (copy_from_user(uref, (void *) arg, sizeof(*uref))) 
+		if (copy_from_user(uref, user_arg, sizeof(*uref))) 
 			goto fault;
 
 		rinfo.report_type = uref->report_type;
@@ -595,7 +597,7 @@
 
 		uref->usage_code = field->usage[uref->usage_index].hid;
 
-		if (copy_to_user((void *) arg, uref, sizeof(*uref)))
+		if (copy_to_user(user_arg, uref, sizeof(*uref)))
 			goto fault;
 
 		kfree(uref_multi);
@@ -611,11 +613,11 @@
 			return -ENOMEM;
 		uref = &uref_multi->uref;
 		if (cmd == HIDIOCGUSAGES || cmd == HIDIOCSUSAGES) {
-			if (copy_from_user(uref_multi, (void *) arg, 
+			if (copy_from_user(uref_multi, user_arg, 
 					   sizeof(*uref_multi)))
 				goto fault;
 		} else {
-			if (copy_from_user(uref, (void *) arg, sizeof(*uref)))
+			if (copy_from_user(uref, user_arg, sizeof(*uref)))
 				goto fault;
 		}
 
@@ -652,7 +654,7 @@
 		switch (cmd) {
 			case HIDIOCGUSAGE:
 				uref->value = field->value[uref->usage_index];
-				if (copy_to_user((void *) arg, uref, sizeof(*uref)))
+				if (copy_to_user(user_arg, uref, sizeof(*uref)))
 					goto fault;
 				goto goodreturn;
 
@@ -667,7 +669,7 @@
 				for (i = 0; i < uref_multi->num_values; i++)
 					uref_multi->values[i] = 
 					    field->value[uref->usage_index + i];
-				if (copy_to_user((void *) arg, uref_multi, 
+				if (copy_to_user(user_arg, uref_multi, 
 						 sizeof(*uref_multi)))
 					goto fault;
 				goto goodreturn;
@@ -689,7 +691,7 @@
 		return -EINVAL;
 
 	case HIDIOCGCOLLECTIONINFO:
-		if (copy_from_user(&cinfo, (void *) arg, sizeof(cinfo)))
+		if (copy_from_user(&cinfo, user_arg, sizeof(cinfo)))
 			return -EFAULT;
 
 		if (cinfo.index >= hid->maxcollection)
@@ -699,7 +701,7 @@
 		cinfo.usage = hid->collection[cinfo.index].usage;
 		cinfo.level = hid->collection[cinfo.index].level;
 
-		if (copy_to_user((void *) arg, &cinfo, sizeof(cinfo)))
+		if (copy_to_user(user_arg, &cinfo, sizeof(cinfo)))
 			return -EFAULT;
 		return 0;
 
@@ -715,7 +717,7 @@
 			len = strlen(hid->name) + 1;
 			if (len > _IOC_SIZE(cmd))
 				 len = _IOC_SIZE(cmd);
-			return copy_to_user((char *) arg, hid->name, len) ?
+			return copy_to_user(user_arg, hid->name, len) ?
 				-EFAULT : len;
 		}
 
@@ -726,7 +728,7 @@
 			len = strlen(hid->phys) + 1;
 			if (len > _IOC_SIZE(cmd))
 				len = _IOC_SIZE(cmd);
-			return copy_to_user((char *) arg, hid->phys, len) ?
+			return copy_to_user(user_arg, hid->phys, len) ?
 				-EFAULT : len;
 		}
 	}
diff -Nru a/drivers/usb/media/dabusb.c b/drivers/usb/media/dabusb.c
--- a/drivers/usb/media/dabusb.c	Thu Jun 10 11:34:03 2004
+++ b/drivers/usb/media/dabusb.c	Thu Jun 10 11:34:03 2004
@@ -476,7 +476,7 @@
 	return 0;
 }
 
-static ssize_t dabusb_read (struct file *file, char *buf, size_t count, loff_t * ppos)
+static ssize_t dabusb_read (struct file *file, char __user *buf, size_t count, loff_t * ppos)
 {
 	pdabusb_t s = (pdabusb_t) file->private_data;
 	unsigned long flags;
@@ -670,7 +670,7 @@
 			break;
 		}
 
-		if (copy_from_user (pbulk, (void *) arg, sizeof (bulk_transfer_t))) {
+		if (copy_from_user (pbulk, (void __user *) arg, sizeof (bulk_transfer_t))) {
 			ret = -EFAULT;
 			kfree (pbulk);
 			break;
@@ -678,18 +678,18 @@
 
 		ret=dabusb_bulk (s, pbulk);
 		if(ret==0)
-			if (copy_to_user((void *)arg, pbulk,
+			if (copy_to_user((void __user *)arg, pbulk,
 					 sizeof(bulk_transfer_t)))
 				ret = -EFAULT;
 		kfree (pbulk);
 		break;
 
 	case IOCTL_DAB_OVERRUNS:
-		ret = put_user (s->overruns, (unsigned int *) arg);
+		ret = put_user (s->overruns, (unsigned int __user *) arg);
 		break;
 
 	case IOCTL_DAB_VERSION:
-		ret = put_user (version, (unsigned int *) arg);
+		ret = put_user (version, (unsigned int __user *) arg);
 		break;
 
 	default:
diff -Nru a/drivers/usb/media/ov511.c b/drivers/usb/media/ov511.c
--- a/drivers/usb/media/ov511.c	Thu Jun 10 11:34:03 2004
+++ b/drivers/usb/media/ov511.c	Thu Jun 10 11:34:03 2004
@@ -4593,7 +4593,7 @@
 }
 
 static ssize_t
-ov51x_v4l1_read(struct file *file, char *buf, size_t cnt, loff_t *ppos)
+ov51x_v4l1_read(struct file *file, char __user *buf, size_t cnt, loff_t *ppos)
 {
 	struct video_device *vdev = file->private_data;
 	int noblock = file->f_flags&O_NONBLOCK;
diff -Nru a/drivers/usb/media/ov511.h b/drivers/usb/media/ov511.h
--- a/drivers/usb/media/ov511.h	Thu Jun 10 11:34:03 2004
+++ b/drivers/usb/media/ov511.h	Thu Jun 10 11:34:03 2004
@@ -11,7 +11,7 @@
 #ifdef OV511_DEBUG
 	#define PDEBUG(level, fmt, args...) \
 		if (debug >= (level)) info("[%s:%d] " fmt, \
-		__PRETTY_FUNCTION__, __LINE__ , ## args)
+		__FUNCTION__, __LINE__ , ## args)
 #else
 	#define PDEBUG(level, fmt, args...) do {} while(0)
 #endif
diff -Nru a/drivers/usb/media/pwc-if.c b/drivers/usb/media/pwc-if.c
--- a/drivers/usb/media/pwc-if.c	Thu Jun 10 11:34:03 2004
+++ b/drivers/usb/media/pwc-if.c	Thu Jun 10 11:34:03 2004
@@ -129,7 +129,7 @@
 
 static int pwc_video_open(struct inode *inode, struct file *file);
 static int pwc_video_close(struct inode *inode, struct file *file);
-static ssize_t pwc_video_read(struct file *file, char *buf,
+static ssize_t pwc_video_read(struct file *file, char __user *buf,
 			  size_t count, loff_t *ppos);
 static unsigned int pwc_video_poll(struct file *file, poll_table *wait);
 static int  pwc_video_ioctl(struct inode *inode, struct file *file,
@@ -1132,7 +1132,7 @@
                 device is tricky anyhow.
  */
 
-static ssize_t pwc_video_read(struct file *file, char *buf,
+static ssize_t pwc_video_read(struct file *file, char __user *buf,
 			  size_t count, loff_t *ppos)
 {
 	struct video_device *vdev = file->private_data;
diff -Nru a/drivers/usb/media/se401.c b/drivers/usb/media/se401.c
--- a/drivers/usb/media/se401.c	Thu Jun 10 11:34:03 2004
+++ b/drivers/usb/media/se401.c	Thu Jun 10 11:34:03 2004
@@ -1121,7 +1121,7 @@
 	return video_usercopy(inode, file, cmd, arg, se401_do_ioctl);
 }
 
-static ssize_t se401_read(struct file *file, char *buf,
+static ssize_t se401_read(struct file *file, char __user *buf,
 		     size_t count, loff_t *ppos)
 {
 	int realcount=count, ret=0;
diff -Nru a/drivers/usb/media/stv680.c b/drivers/usb/media/stv680.c
--- a/drivers/usb/media/stv680.c	Thu Jun 10 11:34:03 2004
+++ b/drivers/usb/media/stv680.c	Thu Jun 10 11:34:03 2004
@@ -1309,7 +1309,7 @@
 	return 0;
 }
 
-static ssize_t stv680_read (struct file *file, char *buf,
+static ssize_t stv680_read (struct file *file, char __user *buf,
 			size_t count, loff_t *ppos)
 {
 	struct video_device *dev = file->private_data;
diff -Nru a/drivers/usb/media/usbvideo.c b/drivers/usb/media/usbvideo.c
--- a/drivers/usb/media/usbvideo.c	Thu Jun 10 11:34:03 2004
+++ b/drivers/usb/media/usbvideo.c	Thu Jun 10 11:34:03 2004
@@ -46,7 +46,7 @@
 			      unsigned int cmd, unsigned long arg);
 static int usbvideo_v4l_mmap(struct file *file, struct vm_area_struct *vma);
 static int usbvideo_v4l_open(struct inode *inode, struct file *file);
-static ssize_t usbvideo_v4l_read(struct file *file, char *buf,
+static ssize_t usbvideo_v4l_read(struct file *file, char __user *buf,
 			     size_t count, loff_t *ppos);
 static int usbvideo_v4l_close(struct inode *inode, struct file *file);
 
@@ -1587,7 +1587,7 @@
  * 20-Oct-2000 Created.
  * 01-Nov-2000 Added mutex (uvd->lock).
  */
-static ssize_t usbvideo_v4l_read(struct file *file, char *buf,
+static ssize_t usbvideo_v4l_read(struct file *file, char __user *buf,
 		      size_t count, loff_t *ppos)
 {
 	struct uvd *uvd = file->private_data;
diff -Nru a/drivers/usb/media/vicam.c b/drivers/usb/media/vicam.c
--- a/drivers/usb/media/vicam.c	Thu Jun 10 11:34:03 2004
+++ b/drivers/usb/media/vicam.c	Thu Jun 10 11:34:03 2004
@@ -523,9 +523,9 @@
 }
 
 static int
-vicam_ioctl(struct inode *inode, struct file *file, unsigned int ioctlnr, unsigned long ul_arg)
+vicam_ioctl(struct inode *inode, struct file *file, unsigned int ioctlnr, unsigned long arg)
 {
-	void *arg = (void *)ul_arg;
+	void __user *user_arg = (void __user *)arg;
 	struct vicam_camera *cam = file->private_data;
 	int retval = 0;
 
@@ -549,7 +549,7 @@
 			b.minwidth = 320;	/* VIDEOSIZE_48_48 */
 			b.minheight = 240;
 
-			if (copy_to_user(arg, &b, sizeof (b)))
+			if (copy_to_user(user_arg, &b, sizeof(b)))
 				retval = -EFAULT;
 
 			break;
@@ -560,7 +560,7 @@
 			struct video_channel v;
 
 			DBG("VIDIOCGCHAN\n");
-			if (copy_from_user(&v, arg, sizeof (v))) {
+			if (copy_from_user(&v, user_arg, sizeof(v))) {
 				retval = -EFAULT;
 				break;
 			}
@@ -576,7 +576,7 @@
 			v.type = VIDEO_TYPE_CAMERA;
 			v.norm = 0;
 
-			if (copy_to_user(arg, &v, sizeof (v)))
+			if (copy_to_user(user_arg, &v, sizeof(v)))
 				retval = -EFAULT;
 			break;
 		}
@@ -585,7 +585,7 @@
 		{
 			int v;
 
-			if (copy_from_user(&v, arg, sizeof (v)))
+			if (copy_from_user(&v, user_arg, sizeof(v)))
 				retval = -EFAULT;
 			DBG("VIDIOCSCHAN %d\n", v);
 
@@ -604,8 +604,7 @@
 			vp.brightness = cam->gain << 8;
 			vp.depth = 24;
 			vp.palette = VIDEO_PALETTE_RGB24;
-			if (copy_to_user
-			    (arg, &vp, sizeof (struct video_picture)))
+			if (copy_to_user(user_arg, &vp, sizeof (struct video_picture)))
 				retval = -EFAULT;
 			break;
 		}
@@ -614,7 +613,7 @@
 		{
 			struct video_picture vp;
 			
-			if (copy_from_user(&vp, arg, sizeof(vp))) {
+			if (copy_from_user(&vp, user_arg, sizeof(vp))) {
 				retval = -EFAULT;
 				break;
 			}
@@ -646,8 +645,7 @@
 
 			DBG("VIDIOCGWIN\n");
 
-			if (copy_to_user
-			    ((void *) arg, (void *) &vw, sizeof (vw)))
+			if (copy_to_user(user_arg, (void *)&vw, sizeof(vw)))
 				retval = -EFAULT;
 
 			// I'm not sure what the deal with a capture window is, it is very poorly described
@@ -660,7 +658,7 @@
 
 			struct video_window vw;
 
-			if (copy_from_user(&vw, arg, sizeof(vw))) {
+			if (copy_from_user(&vw, user_arg, sizeof(vw))) {
 				retval = -EFAULT;
 				break;
 			}
@@ -687,8 +685,7 @@
 			for (i = 0; i < VICAM_FRAMES; i++)
 				vm.offsets[i] = VICAM_MAX_FRAME_SIZE * i;
 
-			if (copy_to_user
-			    ((void *) arg, (void *) &vm, sizeof (vm)))
+			if (copy_to_user(user_arg, (void *)&vm, sizeof(vm)))
 				retval = -EFAULT;
 
 			break;
@@ -699,8 +696,7 @@
 			struct video_mmap vm;
 			// int video_size;
 
-			if (copy_from_user
-			    ((void *) &vm, (void *) arg, sizeof (vm))) {
+			if (copy_from_user((void *)&vm, user_arg, sizeof(vm))) {
 				retval = -EFAULT;
 				break;
 			}
@@ -723,7 +719,7 @@
 		{
 			int frame;
 
-			if (copy_from_user((void *) &frame, arg, sizeof (int))) {
+			if (copy_from_user((void *)&frame, user_arg, sizeof(int))) {
 				retval = -EFAULT;
 				break;
 			}
@@ -1003,7 +999,7 @@
 }
 
 static ssize_t
-vicam_read( struct file *file, char *buf, size_t count, loff_t *ppos )
+vicam_read( struct file *file, char __user *buf, size_t count, loff_t *ppos )
 {
 	struct vicam_camera *cam = file->private_data;
 
diff -Nru a/drivers/usb/media/w9968cf.c b/drivers/usb/media/w9968cf.c
--- a/drivers/usb/media/w9968cf.c	Thu Jun 10 11:34:03 2004
+++ b/drivers/usb/media/w9968cf.c	Thu Jun 10 11:34:03 2004
@@ -388,7 +388,7 @@
 static struct file_operations w9968cf_fops;
 static int w9968cf_open(struct inode*, struct file*);
 static int w9968cf_release(struct inode*, struct file*);
-static ssize_t w9968cf_read(struct file*, char*, size_t, loff_t*);
+static ssize_t w9968cf_read(struct file*, char __user *, size_t, loff_t*);
 static int w9968cf_mmap(struct file*, struct vm_area_struct*);
 static int w9968cf_ioctl(struct inode*, struct file*, unsigned, unsigned long);
 static int w9968cf_v4l_ioctl(struct inode*, struct file*, unsigned int, void*);
@@ -444,8 +444,8 @@
 /* High-level CMOS sensor control functions */
 static int w9968cf_sensor_set_control(struct w9968cf_device*,int cid,int val);
 static int w9968cf_sensor_get_control(struct w9968cf_device*,int cid,int *val);
-static inline int w9968cf_sensor_cmd(struct w9968cf_device*, 
-                                     unsigned int cmd, void *arg);
+static int w9968cf_sensor_cmd(struct w9968cf_device*, 
+                              unsigned int cmd, void *arg);
 static int w9968cf_sensor_init(struct w9968cf_device*);
 static int w9968cf_sensor_update_settings(struct w9968cf_device*);
 static int w9968cf_sensor_get_picture(struct w9968cf_device*);
@@ -461,7 +461,7 @@
 static int w9968cf_set_picture(struct w9968cf_device*, struct video_picture);
 static int w9968cf_set_window(struct w9968cf_device*, struct video_window);
 static inline u16 w9968cf_valid_palette(u16 palette);
-static inline u16 w9968cf_valid_depth(u16 palette);
+static u16 w9968cf_valid_depth(u16 palette);
 static inline u8 w9968cf_need_decompression(u16 palette);
 static int w9968cf_postprocess_frame(struct w9968cf_device*, 
                                      struct w9968cf_frame_t*);
@@ -1959,7 +1959,7 @@
   Return the depth corresponding to the given palette.
   Palette _must_ be supported !
   --------------------------------------------------------------------------*/
-static inline u16 w9968cf_valid_depth(u16 palette)
+static u16 w9968cf_valid_depth(u16 palette)
 {
 	u8 i=0;
 	while (w9968cf_formatlist[i].palette != palette)
@@ -2178,7 +2178,7 @@
 }
 
 
-static inline int
+static int
 w9968cf_sensor_cmd(struct w9968cf_device* cam, unsigned int cmd, void* arg)
 {
 	struct i2c_client* c = cam->sensor_client;
@@ -2770,7 +2770,7 @@
 
 
 static ssize_t
-w9968cf_read(struct file* filp, char* buf, size_t count, loff_t* f_pos)
+w9968cf_read(struct file* filp, char __user * buf, size_t count, loff_t* f_pos)
 {
 	struct w9968cf_device* cam;
 	struct w9968cf_frame_t* fr;
@@ -2915,6 +2915,7 @@
                   unsigned int cmd, void* arg)
 {
 	struct w9968cf_device* cam;
+	void __user *user_arg = (void __user *)arg;
 	const char* v4l1_ioctls[] = {
 		"?", "CGAP", "GCHAN", "SCHAN", "GTUNER", "STUNER", 
 		"GPICT", "SPICT", "CCAPTURE", "GWIN", "SWIN", "GFBUF",
@@ -2948,7 +2949,7 @@
 		cap.maxheight = (cam->upscaling && w9968cf_vppmod_present)
 		                ? W9968CF_MAX_HEIGHT : cam->maxheight;
 
-		if (copy_to_user(arg, &cap, sizeof(cap)))
+		if (copy_to_user(user_arg, &cap, sizeof(cap)))
 			return -EFAULT;
 
 		DBG(5, "VIDIOCGCAP successfully called.")
@@ -2958,7 +2959,7 @@
 	case VIDIOCGCHAN: /* get video channel informations */
 	{
 		struct video_channel chan;
-		if (copy_from_user(&chan, arg, sizeof(chan)))
+		if (copy_from_user(&chan, user_arg, sizeof(chan)))
 			return -EFAULT;
 
 		if (chan.channel != 0)
@@ -2970,7 +2971,7 @@
 		chan.type = VIDEO_TYPE_CAMERA;
 		chan.norm = VIDEO_MODE_AUTO;
 
-		if (copy_to_user(arg, &chan, sizeof(chan)))
+		if (copy_to_user(user_arg, &chan, sizeof(chan)))
 			return -EFAULT;
 
 		DBG(5, "VIDIOCGCHAN successfully called.")
@@ -2981,7 +2982,7 @@
 	{
 		struct video_channel chan;
 
-		if (copy_from_user(&chan, arg, sizeof(chan)))
+		if (copy_from_user(&chan, user_arg, sizeof(chan)))
 			return -EFAULT;
 
 		if (chan.channel != 0)
@@ -2996,7 +2997,7 @@
 		if (w9968cf_sensor_get_picture(cam))
 			return -EIO;
 
-		if (copy_to_user(arg, &cam->picture, sizeof(cam->picture)))
+		if (copy_to_user(user_arg, &cam->picture, sizeof(cam->picture)))
 			return -EFAULT;
 
 		DBG(5, "VIDIOCGPICT successfully called.")
@@ -3008,7 +3009,7 @@
 		struct video_picture pict;
 		int err = 0;
 
-		if (copy_from_user(&pict, arg, sizeof(pict)))
+		if (copy_from_user(&pict, user_arg, sizeof(pict)))
 			return -EFAULT;
 
 		if ( (cam->force_palette || !w9968cf_vppmod_present) 
@@ -3087,7 +3088,7 @@
 		struct video_window win;
 		int err = 0;
 
-		if (copy_from_user(&win, arg, sizeof(win)))
+		if (copy_from_user(&win, user_arg, sizeof(win)))
 			return -EFAULT;
 
 		DBG(6, "VIDIOCSWIN called: clipcount=%d, flags=%d, "
@@ -3141,7 +3142,7 @@
 
 	case VIDIOCGWIN: /* get current window properties */
 	{
-		if (copy_to_user(arg,&cam->window,sizeof(struct video_window)))
+		if (copy_to_user(user_arg, &cam->window, sizeof(struct video_window)))
 			return -EFAULT;
 
 		DBG(5, "VIDIOCGWIN successfully called.")
@@ -3159,7 +3160,7 @@
 			mbuf.offsets[i] = (unsigned long)cam->frame[i].buffer -
 			                  (unsigned long)cam->frame[0].buffer;
 
-		if (copy_to_user(arg, &mbuf, sizeof(mbuf)))
+		if (copy_to_user(user_arg, &mbuf, sizeof(mbuf)))
 			return -EFAULT;
 
 		DBG(5, "VIDIOCGMBUF successfully called.")
@@ -3172,7 +3173,7 @@
 		struct w9968cf_frame_t* fr;
 		int err = 0;
 
-		if (copy_from_user(&mmap, arg, sizeof(mmap)))
+		if (copy_from_user(&mmap, user_arg, sizeof(mmap)))
 			return -EFAULT;
 
 		DBG(6, "VIDIOCMCAPTURE called: frame #%d, format=%s, %dx%d",
@@ -3295,7 +3296,7 @@
 		struct w9968cf_frame_t* fr;
 		int err = 0;
 
-		if (copy_from_user(&f_num, arg, sizeof(f_num)))
+		if (copy_from_user(&f_num, user_arg, sizeof(f_num)))
 			return -EFAULT;
 
 		if (f_num >= cam->nbuffers) {
@@ -3348,7 +3349,7 @@
 			.teletext = VIDEO_NO_UNIT,
 		};
 
-		if (copy_to_user(arg, &unit, sizeof(unit)))
+		if (copy_to_user(user_arg, &unit, sizeof(unit)))
 			return -EFAULT;
 
 		DBG(5, "VIDIOCGUNIT successfully called.")
@@ -3360,7 +3361,7 @@
 
 	case VIDIOCGFBUF:
 	{
-		if (clear_user(arg, sizeof(struct video_buffer)))
+		if (clear_user(user_arg, sizeof(struct video_buffer)))
 			return -EFAULT;
 
 		DBG(5, "VIDIOCGFBUF successfully called.")
@@ -3370,7 +3371,7 @@
 	case VIDIOCGTUNER:
 	{
 		struct video_tuner tuner;
-		if (copy_from_user(&tuner, arg, sizeof(tuner)))
+		if (copy_from_user(&tuner, user_arg, sizeof(tuner)))
 			return -EFAULT;
 
 		if (tuner.tuner != 0)
@@ -3383,7 +3384,7 @@
 		tuner.mode = VIDEO_MODE_AUTO;
 		tuner.signal = 0xffff;
 
-		if (copy_to_user(arg, &tuner, sizeof(tuner)))
+		if (copy_to_user(user_arg, &tuner, sizeof(tuner)))
 			return -EFAULT;
 
 		DBG(5, "VIDIOCGTUNER successfully called.")
@@ -3393,7 +3394,7 @@
 	case VIDIOCSTUNER:
 	{
 		struct video_tuner tuner;
-		if (copy_from_user(&tuner, arg, sizeof(tuner)))
+		if (copy_from_user(&tuner, user_arg, sizeof(tuner)))
 			return -EFAULT;
 
 		if (tuner.tuner != 0)
diff -Nru a/drivers/usb/media/w9968cf.h b/drivers/usb/media/w9968cf.h
--- a/drivers/usb/media/w9968cf.h	Thu Jun 10 11:34:03 2004
+++ b/drivers/usb/media/w9968cf.h	Thu Jun 10 11:34:03 2004
@@ -293,7 +293,7 @@
 		warn(fmt, ## args); \
 	else if ((level) >= 5) \
 		info("[%s:%d] " fmt, \
-		     __PRETTY_FUNCTION__, __LINE__ , ## args); \
+		     __FUNCTION__, __LINE__ , ## args); \
 } \
 }
 #else
diff -Nru a/drivers/usb/misc/auerswald.c b/drivers/usb/misc/auerswald.c
--- a/drivers/usb/misc/auerswald.c	Thu Jun 10 11:34:03 2004
+++ b/drivers/usb/misc/auerswald.c	Thu Jun 10 11:34:03 2004
@@ -1452,6 +1452,8 @@
         audevinfo_t devinfo;
         pauerswald_t cp = NULL;
 	unsigned int u;
+	unsigned int __user *int_user_arg = (unsigned int __user *)arg;
+
         dbg ("ioctl");
 
 	/* get the mutexes */
@@ -1483,14 +1485,14 @@
 		u   = ccp->auerdev
 		   && (ccp->scontext.id != AUH_UNASSIGNED)
 		   && !list_empty (&cp->bufctl.free_buff_list);
-	        ret = put_user (u, (unsigned int *) arg);
+	        ret = put_user (u, int_user_arg);
 		break;
 
 	/* return != 0 if connected to a service channel */
 	case IOCTL_AU_CONNECT:
 		dbg ("IOCTL_AU_CONNECT");
 		u = (ccp->scontext.id != AUH_UNASSIGNED);
-	        ret = put_user (u, (unsigned int *) arg);
+	        ret = put_user (u, int_user_arg);
 		break;
 
 	/* return != 0 if Receive Data available */
@@ -1511,14 +1513,14 @@
 				u = 1;
 			}
 		}
-	        ret = put_user (u, (unsigned int *) arg);
+	        ret = put_user (u, int_user_arg);
 		break;
 
 	/* return the max. buffer length for the device */
 	case IOCTL_AU_BUFLEN:
 		dbg ("IOCTL_AU_BUFLEN");
 		u = cp->maxControlLength;
-	        ret = put_user (u, (unsigned int *) arg);
+	        ret = put_user (u, int_user_arg);
 		break;
 
 	/* requesting a service channel */
@@ -1527,7 +1529,7 @@
                 /* requesting a service means: release the previous one first */
 		auerswald_removeservice (cp, &ccp->scontext);
 		/* get the channel number */
-		ret = get_user (u, (unsigned int *) arg);
+		ret = get_user (u, int_user_arg);
 		if (ret) {
 			break;
 		}
@@ -1564,7 +1566,7 @@
         case IOCTL_AU_SLEN:
 		dbg ("IOCTL_AU_SLEN");
 		u = AUSI_DLEN;
-	        ret = put_user (u, (unsigned int *) arg);
+	        ret = put_user (u, int_user_arg);
 		break;
 
 	default:
diff -Nru a/drivers/usb/misc/legousbtower.c b/drivers/usb/misc/legousbtower.c
--- a/drivers/usb/misc/legousbtower.c	Thu Jun 10 11:34:03 2004
+++ b/drivers/usb/misc/legousbtower.c	Thu Jun 10 11:34:03 2004
@@ -236,8 +236,8 @@
 
 
 /* local function prototypes */
-static ssize_t tower_read	(struct file *file, char *buffer, size_t count, loff_t *ppos);
-static ssize_t tower_write	(struct file *file, const char *buffer, size_t count, loff_t *ppos);
+static ssize_t tower_read	(struct file *file, char __user *buffer, size_t count, loff_t *ppos);
+static ssize_t tower_write	(struct file *file, const char __user *buffer, size_t count, loff_t *ppos);
 static inline void tower_delete (struct lego_usb_tower *dev);
 static int tower_open		(struct inode *inode, struct file *file);
 static int tower_release	(struct inode *inode, struct file *file);
@@ -560,7 +560,7 @@
 /**
  *	tower_read
  */
-static ssize_t tower_read (struct file *file, char *buffer, size_t count, loff_t *ppos)
+static ssize_t tower_read (struct file *file, char __user *buffer, size_t count, loff_t *ppos)
 {
 	struct lego_usb_tower *dev;
 	size_t bytes_to_read;
@@ -651,7 +651,7 @@
 /**
  *	tower_write
  */
-static ssize_t tower_write (struct file *file, const char *buffer, size_t count, loff_t *ppos)
+static ssize_t tower_write (struct file *file, const char __user *buffer, size_t count, loff_t *ppos)
 {
 	struct lego_usb_tower *dev;
 	size_t bytes_to_write;
diff -Nru a/drivers/usb/net/rtl8150.c b/drivers/usb/net/rtl8150.c
--- a/drivers/usb/net/rtl8150.c	Thu Jun 10 11:34:03 2004
+++ b/drivers/usb/net/rtl8150.c	Thu Jun 10 11:34:03 2004
@@ -398,6 +398,21 @@
 	usb_unlink_urb(dev->ctrl_urb);
 }
 
+static inline struct sk_buff *pull_skb(rtl8150_t *dev)
+{
+	struct sk_buff *skb;
+	int i;
+
+	for (i = 0; i < RX_SKB_POOL_SIZE; i++) {
+		if (dev->rx_skb_pool[i]) {
+			skb = dev->rx_skb_pool[i];
+			dev->rx_skb_pool[i] = NULL;
+			return skb;
+		}
+	}
+	return NULL;
+}
+
 static void read_bulk_callback(struct urb *urb, struct pt_regs *regs)
 {
 	rtl8150_t *dev;
@@ -601,21 +616,6 @@
 	for (i = 0; i < RX_SKB_POOL_SIZE; i++)
 		if (dev->rx_skb_pool[i])
 			dev_kfree_skb(dev->rx_skb_pool[i]);
-}
-
-static inline struct sk_buff *pull_skb(rtl8150_t *dev)
-{
-	struct sk_buff *skb;
-	int i;
-
-	for (i = 0; i < RX_SKB_POOL_SIZE; i++) {
-		if (dev->rx_skb_pool[i]) {
-			skb = dev->rx_skb_pool[i];
-			dev->rx_skb_pool[i] = NULL;
-			return skb;
-		}
-	}
-	return NULL;
 }
 
 static int enable_net_traffic(rtl8150_t * dev)
diff -Nru a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
--- a/drivers/usb/serial/ftdi_sio.c	Thu Jun 10 11:34:03 2004
+++ b/drivers/usb/serial/ftdi_sio.c	Thu Jun 10 11:34:03 2004
@@ -1022,7 +1022,7 @@
 }
 
 
-static int get_serial_info(struct usb_serial_port * port, struct serial_struct * retinfo)
+static int get_serial_info(struct usb_serial_port * port, struct serial_struct __user * retinfo)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 	struct serial_struct tmp;
@@ -1039,7 +1039,7 @@
 } /* get_serial_info */
 
 
-static int set_serial_info(struct usb_serial_port * port, struct serial_struct * newinfo)
+static int set_serial_info(struct usb_serial_port * port, struct serial_struct __user * newinfo)
 { /* set_serial_info */
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 	struct serial_struct new_serial;
@@ -2043,7 +2043,7 @@
 
 	case TIOCMBIS: /* turns on (Sets) the lines as specified by the mask */
 		dbg("%s TIOCMBIS", __FUNCTION__);
- 	        if (get_user(mask, (unsigned long *) arg))
+ 	        if (get_user(mask, (unsigned long __user *) arg))
 			return -EFAULT;
   	        if (mask & TIOCM_DTR){
 			if ((ret = set_dtr(port, HIGH)) < 0) {
@@ -2062,7 +2062,7 @@
 
 	case TIOCMBIC: /* turns off (Clears) the lines as specified by the mask */
 		dbg("%s TIOCMBIC", __FUNCTION__);
- 	        if (get_user(mask, (unsigned long *) arg))
+ 	        if (get_user(mask, (unsigned long __user *) arg))
 			return -EFAULT;
   	        if (mask & TIOCM_DTR){
 			if ((ret = set_dtr(port, LOW)) < 0){
@@ -2089,10 +2089,10 @@
 		 */
 
 	case TIOCGSERIAL: /* gets serial port data */
-		return get_serial_info(port, (struct serial_struct *) arg);
+		return get_serial_info(port, (struct serial_struct __user *) arg);
 
 	case TIOCSSERIAL: /* sets serial port data */
-		return set_serial_info(port, (struct serial_struct *) arg);
+		return set_serial_info(port, (struct serial_struct __user *) arg);
 
 	/*
 	 * Wait for any of the 4 modem inputs (DCD,RI,DSR,CTS) to change
diff -Nru a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
--- a/drivers/usb/serial/io_edgeport.c	Thu Jun 10 11:34:03 2004
+++ b/drivers/usb/serial/io_edgeport.c	Thu Jun 10 11:34:03 2004
@@ -1705,7 +1705,7 @@
  * 	    transmit holding register is empty.  This functionality
  * 	    allows an RS485 driver to be written in user space. 
  *****************************************************************************/
-static int get_lsr_info(struct edgeport_port *edge_port, unsigned int *value)
+static int get_lsr_info(struct edgeport_port *edge_port, unsigned int __user *value)
 {
 	unsigned int result = 0;
 
@@ -1720,7 +1720,7 @@
 	return 0;
 }
 
-static int get_number_bytes_avail(struct edgeport_port *edge_port, unsigned int *value)
+static int get_number_bytes_avail(struct edgeport_port *edge_port, unsigned int __user *value)
 {
 	unsigned int result = 0;
 	struct tty_struct *tty = edge_port->port->tty;
@@ -1790,7 +1790,7 @@
 	return result;
 }
 
-static int get_serial_info(struct edgeport_port *edge_port, struct serial_struct * retinfo)
+static int get_serial_info(struct edgeport_port *edge_port, struct serial_struct __user *retinfo)
 {
 	struct serial_struct tmp;
 
@@ -1812,7 +1812,6 @@
 //	tmp.hub6		= state->hub6;
 //	tmp.io_type		= state->io_type;
 
-
 	if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
 		return -EFAULT;
 	return 0;
@@ -1838,17 +1837,17 @@
 		// return number of bytes available
 		case TIOCINQ:
 			dbg("%s (%d) TIOCINQ", __FUNCTION__,  port->number);
-			return get_number_bytes_avail(edge_port, (unsigned int *) arg);
+			return get_number_bytes_avail(edge_port, (unsigned int __user *) arg);
 			break;
 
 		case TIOCSERGETLSR:
 			dbg("%s (%d) TIOCSERGETLSR", __FUNCTION__,  port->number);
-			return get_lsr_info(edge_port, (unsigned int *) arg);
+			return get_lsr_info(edge_port, (unsigned int __user *) arg);
 			return 0;
 
 		case TIOCGSERIAL:
 			dbg("%s (%d) TIOCGSERIAL", __FUNCTION__,  port->number);
-			return get_serial_info(edge_port, (struct serial_struct *) arg);
+			return get_serial_info(edge_port, (struct serial_struct __user *) arg);
 
 		case TIOCSSERIAL:
 			dbg("%s (%d) TIOCSSERIAL", __FUNCTION__,  port->number);
@@ -1893,7 +1892,7 @@
 			icount.buf_overrun = cnow.buf_overrun;
 
 			dbg("%s (%d) TIOCGICOUNT RX=%d, TX=%d", __FUNCTION__,  port->number, icount.rx, icount.tx );
-			if (copy_to_user((void *)arg, &icount, sizeof(icount)))
+			if (copy_to_user((void __user *)arg, &icount, sizeof(icount)))
 				return -EFAULT;
 			return 0;
 	}
diff -Nru a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
--- a/drivers/usb/serial/io_ti.c	Thu Jun 10 11:34:03 2004
+++ b/drivers/usb/serial/io_ti.c	Thu Jun 10 11:34:03 2004
@@ -2428,7 +2428,7 @@
 	return result;
 }
 
-static int get_serial_info (struct edgeport_port *edge_port, struct serial_struct * retinfo)
+static int get_serial_info (struct edgeport_port *edge_port, struct serial_struct __user *retinfo)
 {
 	struct serial_struct tmp;
 
@@ -2477,7 +2477,7 @@
 
 		case TIOCGSERIAL:
 			dbg("%s - (%d) TIOCGSERIAL", __FUNCTION__, port->number);
-			return get_serial_info(edge_port, (struct serial_struct *) arg);
+			return get_serial_info(edge_port, (struct serial_struct __user *) arg);
 			break;
 
 		case TIOCSSERIAL:
@@ -2510,7 +2510,7 @@
 		case TIOCGICOUNT:
 			dbg ("%s - (%d) TIOCGICOUNT RX=%d, TX=%d", __FUNCTION__,
 			     port->number, edge_port->icount.rx, edge_port->icount.tx);
-			if (copy_to_user((void *)arg, &edge_port->icount, sizeof(edge_port->icount)))
+			if (copy_to_user((void __user *)arg, &edge_port->icount, sizeof(edge_port->icount)))
 				return -EFAULT;
 			return 0;
 	}
diff -Nru a/drivers/usb/serial/kl5kusb105.c b/drivers/usb/serial/kl5kusb105.c
--- a/drivers/usb/serial/kl5kusb105.c	Thu Jun 10 11:34:03 2004
+++ b/drivers/usb/serial/kl5kusb105.c	Thu Jun 10 11:34:03 2004
@@ -926,6 +926,7 @@
 			   unsigned int cmd, unsigned long arg)
 {
 	struct klsi_105_private *priv = usb_get_serial_port_data(port);
+	void __user *user_arg = (void __user *)arg;
 	
 	dbg("%scmd=0x%x", __FUNCTION__, cmd);
 
@@ -948,13 +949,12 @@
 
 	     dbg("%s - TCGETS data faked/incomplete", __FUNCTION__);
 
-	     retval = verify_area(VERIFY_WRITE, (void *)arg,
+	     retval = verify_area(VERIFY_WRITE, user_arg,
 				  sizeof(struct termios));
-
 	     if (retval)
-			 return(retval);
+			 return retval;
 
-	     if (kernel_termios_to_user_termios((struct termios *)arg,  
+	     if (kernel_termios_to_user_termios((struct termios __user *)arg,
 						&priv->termios))
 		     return -EFAULT;
 	     return(0);
@@ -965,14 +965,13 @@
 
 		dbg("%s - TCSETS not handled", __FUNCTION__);
 
-		retval = verify_area(VERIFY_READ, (void *)arg,
+		retval = verify_area(VERIFY_READ, user_arg,
 				     sizeof(struct termios));
-
 		if (retval)
-			    return(retval);
+			    return retval;
 
 		if (user_termios_to_kernel_termios(&priv->termios,
-						  (struct termios *)arg))
+						  (struct termios __user *)arg))
 			return -EFAULT;
 		klsi_105_set_termios(port, &priv->termios);
 		return(0);
diff -Nru a/drivers/usb/serial/kobil_sct.c b/drivers/usb/serial/kobil_sct.c
--- a/drivers/usb/serial/kobil_sct.c	Thu Jun 10 11:34:03 2004
+++ b/drivers/usb/serial/kobil_sct.c	Thu Jun 10 11:34:03 2004
@@ -643,6 +643,7 @@
 	unsigned char *transfer_buffer;
 	int transfer_buffer_length = 8;
 	char *settings;
+	void __user *user_arg = (void __user *)arg;
 
 	priv = usb_get_serial_port_data(port);
 	if ((priv->device_type == KOBIL_USBTWIN_PRODUCT_ID) || (priv->device_type == KOBIL_KAAN_SIM_PRODUCT_ID)) {
@@ -652,12 +653,12 @@
 
 	switch (cmd) {
 	case TCGETS:   // 0x5401
-		result = verify_area(VERIFY_WRITE, (void *)arg, sizeof(struct termios));
+		result = verify_area(VERIFY_WRITE, user_arg, sizeof(struct termios));
 		if (result) {
 			dbg("%s - port %d Error in verify_area", __FUNCTION__, port->number);
 			return(result);
 		}
-		if (kernel_termios_to_user_termios((struct termios *)arg,
+		if (kernel_termios_to_user_termios((struct termios __user *)arg,
 						   &priv->internal_termios))
 			return -EFAULT;
 		return 0;
@@ -667,13 +668,13 @@
 			dbg("%s - port %d Error: port->tty->termios is NULL", __FUNCTION__, port->number);
 			return -ENOTTY;
 		}
-		result = verify_area(VERIFY_READ, (void *)arg, sizeof(struct termios));
+		result = verify_area(VERIFY_READ, user_arg, sizeof(struct termios));
 		if (result) {
 			dbg("%s - port %d Error in verify_area", __FUNCTION__, port->number);
 			return result;
 		}
 		if (user_termios_to_kernel_termios(&priv->internal_termios,
-						   (struct termios *)arg))
+						   (struct termios __user *)arg))
 			return -EFAULT;
 		
 		settings = (unsigned char *) kmalloc(50, GFP_KERNEL);  
diff -Nru a/drivers/usb/serial/whiteheat.c b/drivers/usb/serial/whiteheat.c
--- a/drivers/usb/serial/whiteheat.c	Thu Jun 10 11:34:03 2004
+++ b/drivers/usb/serial/whiteheat.c	Thu Jun 10 11:34:03 2004
@@ -835,6 +835,7 @@
 static int whiteheat_ioctl (struct usb_serial_port *port, struct file * file, unsigned int cmd, unsigned long arg)
 {
 	struct serial_struct serstruct;
+	void __user *user_arg = (void __user *)arg;
 
 	dbg("%s - port %d, cmd 0x%.4x", __FUNCTION__, port->number, cmd);
 
@@ -851,13 +852,13 @@
 			serstruct.close_delay = CLOSING_DELAY;
 			serstruct.closing_wait = CLOSING_DELAY;
 
-			if (copy_to_user((void *)arg, &serstruct, sizeof(serstruct)))
+			if (copy_to_user(user_arg, &serstruct, sizeof(serstruct)))
 				return -EFAULT;
 
 			break;
 
 		case TIOCSSERIAL:
-			if (copy_from_user(&serstruct, (void *)arg, sizeof(serstruct)))
+			if (copy_from_user(&serstruct, user_arg, sizeof(serstruct)))
 				return -EFAULT;
 
 			/*
