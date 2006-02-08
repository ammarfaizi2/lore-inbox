Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161051AbWBHHOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161051AbWBHHOO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161044AbWBHHKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:10:43 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:31643 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161045AbWBHHKb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:10:31 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 05/17] drivers/media/video __user annotations and fixes
Cc: mchehab@infradead.org
Message-Id: <E1F6jTC-0002Vx-Vf@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 07:10:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138789460 -0500

* compat_alloc_user_space() returns __user pointer
* copying between two userland areas is copy_in_user(), not copy_from_user()
* dereferencing userland pointers is bad
* so's get_user() from local variables

... plus usual __user annotations

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/media/video/compat_ioctl32.c |   89 ++++++++++++++++------------------
 include/linux/videodev2.h            |    2 -
 2 files changed, 42 insertions(+), 49 deletions(-)

5b1a43d7df65689b4c3b5a1c5c8158f1d4f74fbd
diff --git a/drivers/media/video/compat_ioctl32.c b/drivers/media/video/compat_ioctl32.c
index 297c32a..840fe01 100644
--- a/drivers/media/video/compat_ioctl32.c
+++ b/drivers/media/video/compat_ioctl32.c
@@ -167,29 +167,32 @@ static int get_v4l2_window32(struct v4l2
 	if (kp->clipcount > 2048)
 		return -EINVAL;
 	if (kp->clipcount) {
-		struct v4l2_clip32 *uclips = compat_ptr(up->clips);
-		struct v4l2_clip *kclips;
+		struct v4l2_clip32 __user *uclips;
+		struct v4l2_clip __user *kclips;
 		int n = kp->clipcount;
+		compat_caddr_t p;
 
+		if (get_user(p, &up->clips))
+			return -EFAULT;
+		uclips = compat_ptr(p);
 		kclips = compat_alloc_user_space(n * sizeof(struct v4l2_clip));
 		kp->clips = kclips;
 		while (--n >= 0) {
-			if (!access_ok(VERIFY_READ, &uclips->c, sizeof(uclips->c)) ||
-				copy_from_user(&kclips->c, &uclips->c, sizeof(uclips->c)))
+			if (copy_in_user(&kclips->c, &uclips->c, sizeof(uclips->c)))
+				return -EFAULT;
+			if (put_user(n ? kclips + 1 : NULL, &kclips->next))
 				return -EFAULT;
-			kclips->next = n ? kclips + 1 : 0;
 			uclips += 1;
 			kclips += 1;
 		}
 	} else
-		kp->clips = 0;
+		kp->clips = NULL;
 	return 0;
 }
 
 static int put_v4l2_window32(struct v4l2_window *kp, struct v4l2_window32 __user *up)
 {
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_window32)) ||
-		copy_to_user(&up->w, &kp->w, sizeof(up->w)) ||
+	if (copy_to_user(&up->w, &kp->w, sizeof(up->w)) ||
 		put_user(kp->field, &up->field) ||
 		put_user(kp->chromakey, &up->chromakey) ||
 		put_user(kp->clipcount, &up->clipcount))
@@ -199,33 +202,29 @@ static int put_v4l2_window32(struct v4l2
 
 static inline int get_v4l2_pix_format(struct v4l2_pix_format *kp, struct v4l2_pix_format __user *up)
 {
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_pix_format)) ||
-		copy_from_user(kp, up, sizeof(struct v4l2_pix_format)))
-			return -EFAULT;
+	if (copy_from_user(kp, up, sizeof(struct v4l2_pix_format)))
+		return -EFAULT;
 	return 0;
 }
 
 static inline int put_v4l2_pix_format(struct v4l2_pix_format *kp, struct v4l2_pix_format __user *up)
 {
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_pix_format)) ||
-		copy_to_user(up, kp, sizeof(struct v4l2_pix_format)))
-			return -EFAULT;
+	if (copy_to_user(up, kp, sizeof(struct v4l2_pix_format)))
+		return -EFAULT;
 	return 0;
 }
 
 static inline int get_v4l2_vbi_format(struct v4l2_vbi_format *kp, struct v4l2_vbi_format __user *up)
 {
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_vbi_format)) ||
-		copy_from_user(kp, up, sizeof(struct v4l2_vbi_format)))
-			return -EFAULT;
+	if (copy_from_user(kp, up, sizeof(struct v4l2_vbi_format)))
+		return -EFAULT;
 	return 0;
 }
 
 static inline int put_v4l2_vbi_format(struct v4l2_vbi_format *kp, struct v4l2_vbi_format __user *up)
 {
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_vbi_format)) ||
-		copy_to_user(up, kp, sizeof(struct v4l2_vbi_format)))
-			return -EFAULT;
+	if (copy_to_user(up, kp, sizeof(struct v4l2_vbi_format)))
+		return -EFAULT;
 	return 0;
 }
 
@@ -279,18 +278,16 @@ static int put_v4l2_format32(struct v4l2
 
 static inline int get_v4l2_standard(struct v4l2_standard *kp, struct v4l2_standard __user *up)
 {
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_standard)) ||
-		copy_from_user(kp, up, sizeof(struct v4l2_standard)))
-			return -EFAULT;
+	if (copy_from_user(kp, up, sizeof(struct v4l2_standard)))
+		return -EFAULT;
 	return 0;
 
 }
 
 static inline int put_v4l2_standard(struct v4l2_standard *kp, struct v4l2_standard __user *up)
 {
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_standard)) ||
-		copy_to_user(up, kp, sizeof(struct v4l2_standard)))
-			return -EFAULT;
+	if (copy_to_user(up, kp, sizeof(struct v4l2_standard)))
+		return -EFAULT;
 	return 0;
 }
 
@@ -328,18 +325,16 @@ static int put_v4l2_standard32(struct v4
 
 static inline int get_v4l2_tuner(struct v4l2_tuner *kp, struct v4l2_tuner __user *up)
 {
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_tuner)) ||
-		copy_from_user(kp, up, sizeof(struct v4l2_tuner)))
-			return -EFAULT;
+	if (copy_from_user(kp, up, sizeof(struct v4l2_tuner)))
+		return -EFAULT;
 	return 0;
 
 }
 
 static inline int put_v4l2_tuner(struct v4l2_tuner *kp, struct v4l2_tuner __user *up)
 {
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_tuner)) ||
-		copy_to_user(up, kp, sizeof(struct v4l2_tuner)))
-			return -EFAULT;
+	if (copy_to_user(up, kp, sizeof(struct v4l2_tuner)))
+		return -EFAULT;
 	return 0;
 }
 
@@ -380,11 +375,13 @@ static int get_v4l2_buffer32(struct v4l2
 		break;
 	case V4L2_MEMORY_USERPTR:
 		{
-		unsigned long tmp = (unsigned long)compat_ptr(up->m.userptr);
+		compat_long_t tmp;
 
-		if(get_user(kp->length, &up->length) ||
-			get_user(kp->m.userptr, &tmp))
-				return -EFAULT;
+		if (get_user(kp->length, &up->length) ||
+		    get_user(tmp, &up->m.userptr))
+			return -EFAULT;
+
+		kp->m.userptr = (unsigned long)compat_ptr(tmp);
 		}
 		break;
 	case V4L2_MEMORY_OVERLAY:
@@ -468,33 +465,29 @@ static int put_v4l2_framebuffer32(struct
 
 static inline int get_v4l2_input32(struct v4l2_input *kp, struct v4l2_input __user *up)
 {
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_input) - 4) ||
-		copy_from_user(kp, up, sizeof(struct v4l2_input) - 4))
-			return -EFAULT;
+	if (copy_from_user(kp, up, sizeof(struct v4l2_input) - 4))
+		return -EFAULT;
 	return 0;
 }
 
 static inline int put_v4l2_input32(struct v4l2_input *kp, struct v4l2_input __user *up)
 {
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_input) - 4) ||
-		copy_to_user(up, kp, sizeof(struct v4l2_input) - 4))
-			return -EFAULT;
+	if (copy_to_user(up, kp, sizeof(struct v4l2_input) - 4))
+		return -EFAULT;
 	return 0;
 }
 
 static inline int get_v4l2_input(struct v4l2_input *kp, struct v4l2_input __user *up)
 {
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_input)) ||
-		copy_from_user(kp, up, sizeof(struct v4l2_input)))
-			return -EFAULT;
+	if (copy_from_user(kp, up, sizeof(struct v4l2_input)))
+		return -EFAULT;
 	return 0;
 }
 
 static inline int put_v4l2_input(struct v4l2_input *kp, struct v4l2_input __user *up)
 {
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_input)) ||
-		copy_to_user(up, kp, sizeof(struct v4l2_input)))
-			return -EFAULT;
+	if (copy_to_user(up, kp, sizeof(struct v4l2_input)))
+		return -EFAULT;
 	return 0;
 }
 
diff --git a/include/linux/videodev2.h b/include/linux/videodev2.h
index b23be44..5208b12 100644
--- a/include/linux/videodev2.h
+++ b/include/linux/videodev2.h
@@ -549,7 +549,7 @@ struct v4l2_framebuffer
 struct v4l2_clip
 {
 	struct v4l2_rect        c;
-	struct v4l2_clip	*next;
+	struct v4l2_clip	__user *next;
 };
 
 struct v4l2_window
-- 
0.99.9.GIT

