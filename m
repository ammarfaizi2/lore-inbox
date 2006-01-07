Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030566AbWAGTIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030566AbWAGTIv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030547AbWAGTIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:08:30 -0500
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:347 "HELO
	smtp108.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030552AbWAGTIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:08:22 -0500
Message-Id: <20060107172059.663472000.dtor_core@ameritech.net>
References: <20060107171559.593824000.dtor_core@ameritech.net>
Date: Sat, 07 Jan 2006 12:16:00 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 01/24] evdev: consolidate compat and normal code
Content-Disposition: inline; filename=evdev-compat-mess.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: evdev - consolidate compat and regular code

Compat and normal code mirror each other and are hard to maintain.
When EV_SW was added compat_ioctl case was missed. Here is my attempt
at consolidating the code.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/evdev.c |  491 +++++++++++++++++++++-----------------------------
 1 files changed, 212 insertions(+), 279 deletions(-)

Index: work/drivers/input/evdev.c
===================================================================
--- work.orig/drivers/input/evdev.c
+++ work/drivers/input/evdev.c
@@ -146,6 +146,7 @@ static int evdev_open(struct inode * ino
 }
 
 #ifdef CONFIG_COMPAT
+
 struct input_event_compat {
 	struct compat_timeval time;
 	__u16 type;
@@ -165,98 +166,107 @@ struct input_event_compat {
 #  define COMPAT_TEST test_thread_flag(TIF_32BIT)
 #endif
 
-static ssize_t evdev_write_compat(struct file * file, const char __user * buffer, size_t count, loff_t *ppos)
+static inline size_t evdev_event_size(void)
 {
-	struct evdev_list *list = file->private_data;
-	struct input_event_compat event;
-	int retval = 0;
+	return COMPAT_TEST ?
+		sizeof(struct input_event_compat) : sizeof(struct input_event);
+}
 
-	while (retval < count) {
-		if (copy_from_user(&event, buffer + retval, sizeof(struct input_event_compat)))
+static int evdev_event_from_user(const char __user *buffer, struct input_event *event)
+{
+	if (COMPAT_TEST) {
+		struct input_event_compat compat_event;
+
+		if (copy_from_user(&compat_event, buffer, sizeof(struct input_event_compat)))
+			return -EFAULT;
+
+		event->time.tv_sec = compat_event.time.tv_sec;
+		event->time.tv_usec = compat_event.time.tv_usec;
+		event->type = compat_event.type;
+		event->code = compat_event.code;
+		event->value = compat_event.value;
+
+	} else {
+		if (copy_from_user(event, buffer, sizeof(struct input_event)))
 			return -EFAULT;
-		input_event(list->evdev->handle.dev, event.type, event.code, event.value);
-		retval += sizeof(struct input_event_compat);
 	}
 
-	return retval;
+	return 0;
 }
-#endif
 
-static ssize_t evdev_write(struct file * file, const char __user * buffer, size_t count, loff_t *ppos)
+static int evdev_event_to_user(char __user *buffer, const struct input_event *event)
 {
-	struct evdev_list *list = file->private_data;
-	struct input_event event;
-	int retval = 0;
+	if (COMPAT_TEST) {
+		struct input_event_compat compat_event;
 
-	if (!list->evdev->exist) return -ENODEV;
+		compat_event.time.tv_sec = event->time.tv_sec;
+		compat_event.time.tv_usec = event->time.tv_usec;
+		compat_event.type = event->type;
+		compat_event.code = event->code;
+		compat_event.value = event->value;
 
-#ifdef CONFIG_COMPAT
-	if (COMPAT_TEST)
-		return evdev_write_compat(file, buffer, count, ppos);
-#endif
-
-	while (retval < count) {
+		if (copy_to_user(buffer, &compat_event, sizeof(struct input_event_compat)))
+			return -EFAULT;
 
-		if (copy_from_user(&event, buffer + retval, sizeof(struct input_event)))
+	} else {
+		if (copy_to_user(buffer, event, sizeof(struct input_event)))
 			return -EFAULT;
-		input_event(list->evdev->handle.dev, event.type, event.code, event.value);
-		retval += sizeof(struct input_event);
 	}
 
-	return retval;
+	return 0;
 }
 
-#ifdef CONFIG_COMPAT
-static ssize_t evdev_read_compat(struct file * file, char __user * buffer, size_t count, loff_t *ppos)
+#else
+
+static inline size_t evdev_event_size(void)
 {
-	struct evdev_list *list = file->private_data;
-	int retval;
+	return sizeof(struct input_event);
+}
 
-	if (count < sizeof(struct input_event_compat))
-		return -EINVAL;
+static int evdev_event_from_user(const char __user *buffer, struct input_event *event)
+{
+	if (copy_from_user(event, buffer, sizeof(struct input_event)))
+		return -EFAULT;
 
-	if (list->head == list->tail && list->evdev->exist && (file->f_flags & O_NONBLOCK))
-		return -EAGAIN;
+	return 0;
+}
 
-	retval = wait_event_interruptible(list->evdev->wait,
-		list->head != list->tail || (!list->evdev->exist));
+static int evdev_event_to_user(char __user *buffer, const struct input_event *event)
+{
+	if (copy_to_user(buffer, event, sizeof(struct input_event)))
+		return -EFAULT;
 
-	if (retval)
-		return retval;
+	return 0;
+}
+
+#endif /* CONFIG_COMPAT */
+
+static ssize_t evdev_write(struct file * file, const char __user * buffer, size_t count, loff_t *ppos)
+{
+	struct evdev_list *list = file->private_data;
+	struct input_event event;
+	int retval = 0;
 
 	if (!list->evdev->exist)
 		return -ENODEV;
 
-	while (list->head != list->tail && retval + sizeof(struct input_event_compat) <= count) {
-		struct input_event *event = (struct input_event *) list->buffer + list->tail;
-		struct input_event_compat event_compat;
-		event_compat.time.tv_sec = event->time.tv_sec;
-		event_compat.time.tv_usec = event->time.tv_usec;
-		event_compat.type = event->type;
-		event_compat.code = event->code;
-		event_compat.value = event->value;
+	while (retval < count) {
 
-		if (copy_to_user(buffer + retval, &event_compat,
-			sizeof(struct input_event_compat))) return -EFAULT;
-		list->tail = (list->tail + 1) & (EVDEV_BUFFER_SIZE - 1);
-		retval += sizeof(struct input_event_compat);
+		if (evdev_event_from_user(buffer + retval, &event))
+			return -EFAULT;
+		input_event(list->evdev->handle.dev, event.type, event.code, event.value);
+		retval += evdev_event_size();
 	}
 
 	return retval;
 }
-#endif
 
 static ssize_t evdev_read(struct file * file, char __user * buffer, size_t count, loff_t *ppos)
 {
 	struct evdev_list *list = file->private_data;
 	int retval;
 
-#ifdef CONFIG_COMPAT
-	if (COMPAT_TEST)
-		return evdev_read_compat(file, buffer, count, ppos);
-#endif
-
-	if (count < sizeof(struct input_event))
+	if (count < evdev_event_size())
 		return -EINVAL;
 
 	if (list->head == list->tail && list->evdev->exist && (file->f_flags & O_NONBLOCK))
@@ -271,11 +281,15 @@ static ssize_t evdev_read(struct file * 
 	if (!list->evdev->exist)
 		return -ENODEV;
 
-	while (list->head != list->tail && retval + sizeof(struct input_event) <= count) {
-		if (copy_to_user(buffer + retval, list->buffer + list->tail,
-			sizeof(struct input_event))) return -EFAULT;
+	while (list->head != list->tail && retval + evdev_event_size() <= count) {
+
+		struct input_event *event = (struct input_event *) list->buffer + list->tail;
+
+		if (evdev_event_to_user(buffer + retval, event))
+			return -EFAULT;
+
 		list->tail = (list->tail + 1) & (EVDEV_BUFFER_SIZE - 1);
-		retval += sizeof(struct input_event);
+		retval += evdev_event_size();
 	}
 
 	return retval;
@@ -290,17 +304,95 @@ static unsigned int evdev_poll(struct fi
 		(list->evdev->exist ? 0 : (POLLHUP | POLLERR));
 }
 
-static long evdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+#ifdef CONFIG_COMPAT
+
+#define BITS_PER_LONG_COMPAT (sizeof(compat_long_t) * 8)
+#define NBITS_COMPAT(x) ((((x) - 1) / BITS_PER_LONG_COMPAT) + 1)
+
+#ifdef __BIG_ENDIAN
+static int bits_to_user(unsigned long *bits, unsigned int maxbit,
+			unsigned int maxlen, void __user *p, int compat)
+{
+	int len, i;
+
+	if (compat) {
+		len = NBITS_COMPAT(maxbit) * sizeof(compat_long_t);
+		if (len < maxlen)
+			len = maxlen;
+
+		for (i = 0; i < len / sizeof(compat_long_t); i++)
+			if (copy_to_user((compat_long_t __user *) p + i,
+					 (compat_long_t *) bits +
+						i + 1 - ((i % 2) << 1),
+					 sizeof(compat_long_t)))
+				return -EFAULT;
+	} else {
+		len = NBITS(maxbit) * sizeof(long);
+		if (len > maxlen)
+			len = maxlen;
+
+		if (copy_to_user(p, bits, len))
+			return -EFAULT;
+	}
+
+	return len;
+}
+#else
+static int bits_to_user(unsigned long *bits, unsigned int maxbit,
+			unsigned int maxlen, void __user *p, int compat)
+{
+	int len = compat ?
+			NBITS_COMPAT(maxbit) * sizeof(compat_long_t) :
+			NBITS(maxbit) * sizeof(long);
+
+	if (len > maxlen)
+		len = maxlen;
+
+	return copy_to_user(p, bits, len) ? -EFAULT : len;
+}
+#endif /* __BIG_ENDIAN */
+
+#else
+
+static int bits_to_user(unsigned long *bits, unsigned int maxbit,
+			unsigned int maxlen, void __user *p, int compat)
+{
+	int len = NBITS(maxbit) * sizeof(long);
+
+	if (len > maxlen)
+		len = maxlen;
+
+	return copy_to_user(p, bits, len) ? -EFAULT : len;
+}
+
+#endif /* CONFIG_COMPAT */
+
+static int str_to_user(const char *str, unsigned int maxlen, void __user *p)
+{
+	int len;
+
+	if (!str)
+		return -ENOENT;
+
+	len = strlen(str) + 1;
+	if (len > maxlen)
+		len = maxlen;
+
+	return copy_to_user(p, str, len) ? -EFAULT : len;
+}
+
+static long evdev_ioctl_handler(struct file *file, unsigned int cmd,
+				void __user *p, int compat_mode)
 {
 	struct evdev_list *list = file->private_data;
 	struct evdev *evdev = list->evdev;
 	struct input_dev *dev = evdev->handle.dev;
 	struct input_absinfo abs;
-	void __user *p = (void __user *)arg;
-	int __user *ip = (int __user *)arg;
+	int __user *ip = (int __user *)p;
 	int i, t, u, v;
 
-	if (!evdev->exist) return -ENODEV;
+	if (!evdev->exist)
+		return -ENODEV;
 
 	switch (cmd) {
 
@@ -308,26 +400,39 @@ static long evdev_ioctl(struct file *fil
 			return put_user(EV_VERSION, ip);
 
 		case EVIOCGID:
-			return copy_to_user(p, &dev->id, sizeof(struct input_id)) ? -EFAULT : 0;
+			if (copy_to_user(p, &dev->id, sizeof(struct input_id)))
+				return -EFAULT;
+
+			return 0;
 
 		case EVIOCGKEYCODE:
-			if (get_user(t, ip)) return -EFAULT;
-			if (t < 0 || t >= dev->keycodemax || !dev->keycodesize) return -EINVAL;
-			if (put_user(INPUT_KEYCODE(dev, t), ip + 1)) return -EFAULT;
+			if (get_user(t, ip))
+				return -EFAULT;
+			if (t < 0 || t >= dev->keycodemax || !dev->keycodesize)
+				return -EINVAL;
+			if (put_user(INPUT_KEYCODE(dev, t), ip + 1))
+				return -EFAULT;
 			return 0;
 
 		case EVIOCSKEYCODE:
-			if (get_user(t, ip)) return -EFAULT;
-			if (t < 0 || t >= dev->keycodemax || !dev->keycodesize) return -EINVAL;
-			if (get_user(v, ip + 1)) return -EFAULT;
-			if (v < 0 || v > KEY_MAX) return -EINVAL;
-			if (dev->keycodesize < sizeof(v) && (v >> (dev->keycodesize * 8))) return -EINVAL;
+			if (get_user(t, ip))
+				return -EFAULT;
+			if (t < 0 || t >= dev->keycodemax || !dev->keycodesize)
+				return -EINVAL;
+			if (get_user(v, ip + 1))
+				return -EFAULT;
+			if (v < 0 || v > KEY_MAX)
+				return -EINVAL;
+			if (dev->keycodesize < sizeof(v) && (v >> (dev->keycodesize * 8)))
+				return -EINVAL;
+
 			u = SET_INPUT_KEYCODE(dev, t, v);
 			clear_bit(u, dev->keybit);
 			set_bit(v, dev->keybit);
 			for (i = 0; i < dev->keycodemax; i++)
-				if (INPUT_KEYCODE(dev,i) == u)
+				if (INPUT_KEYCODE(dev, i) == u)
 					set_bit(u, dev->keybit);
+
 			return 0;
 
 		case EVIOCSFF:
@@ -338,17 +443,17 @@ static long evdev_ioctl(struct file *fil
 				if (copy_from_user(&effect, p, sizeof(effect)))
 					return -EFAULT;
 				err = dev->upload_effect(dev, &effect);
-				if (put_user(effect.id, &(((struct ff_effect __user *)arg)->id)))
+				if (put_user(effect.id, &(((struct ff_effect __user *)p)->id)))
 					return -EFAULT;
 				return err;
-			}
-			else return -ENOSYS;
+			} else
+				return -ENOSYS;
 
 		case EVIOCRMFF:
-			if (dev->erase_effect) {
-				return dev->erase_effect(dev, (int)arg);
-			}
-			else return -ENOSYS;
+			if (!dev->erase_effect)
+				return -ENOSYS;
+
+			return dev->erase_effect(dev, (int)(unsigned long) p);
 
 		case EVIOCGEFFECTS:
 			if (put_user(dev->ff_effects_max, ip))
@@ -356,7 +461,7 @@ static long evdev_ioctl(struct file *fil
 			return 0;
 
 		case EVIOCGRAB:
-			if (arg) {
+			if (p) {
 				if (evdev->grab)
 					return -EBUSY;
 				if (input_grab_device(&evdev->handle))
@@ -395,62 +500,33 @@ static long evdev_ioctl(struct file *fil
 						case EV_SW:  bits = dev->swbit;  len = SW_MAX;  break;
 						default: return -EINVAL;
 					}
-					len = NBITS(len) * sizeof(long);
-					if (len > _IOC_SIZE(cmd)) len = _IOC_SIZE(cmd);
-					return copy_to_user(p, bits, len) ? -EFAULT : len;
+					return bits_to_user(bits, len, _IOC_SIZE(cmd), p, compat_mode);
 				}
 
-				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGKEY(0))) {
-					int len;
-					len = NBITS(KEY_MAX) * sizeof(long);
-					if (len > _IOC_SIZE(cmd)) len = _IOC_SIZE(cmd);
-					return copy_to_user(p, dev->key, len) ? -EFAULT : len;
-				}
+				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGKEY(0)))
+					return bits_to_user(dev->key, KEY_MAX, _IOC_SIZE(cmd),
+							    p, compat_mode);
 
-				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGLED(0))) {
-					int len;
-					len = NBITS(LED_MAX) * sizeof(long);
-					if (len > _IOC_SIZE(cmd)) len = _IOC_SIZE(cmd);
-					return copy_to_user(p, dev->led, len) ? -EFAULT : len;
-				}
+				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGLED(0)))
+					return bits_to_user(dev->led, LED_MAX, _IOC_SIZE(cmd),
+							    p, compat_mode);
 
-				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGSND(0))) {
-					int len;
-					len = NBITS(SND_MAX) * sizeof(long);
-					if (len > _IOC_SIZE(cmd)) len = _IOC_SIZE(cmd);
-					return copy_to_user(p, dev->snd, len) ? -EFAULT : len;
-				}
+				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGSND(0)))
+					return bits_to_user(dev->snd, SND_MAX, _IOC_SIZE(cmd),
+							    p, compat_mode);
 
-				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGSW(0))) {
-					int len;
-					len = NBITS(SW_MAX) * sizeof(long);
-					if (len > _IOC_SIZE(cmd)) len = _IOC_SIZE(cmd);
-					return copy_to_user(p, dev->sw, len) ? -EFAULT : len;
-				}
+				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGSW(0)))
+					return bits_to_user(dev->sw, SW_MAX, _IOC_SIZE(cmd),
+							    p, compat_mode);
 
-				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGNAME(0))) {
-					int len;
-					if (!dev->name) return -ENOENT;
-					len = strlen(dev->name) + 1;
-					if (len > _IOC_SIZE(cmd)) len = _IOC_SIZE(cmd);
-					return copy_to_user(p, dev->name, len) ? -EFAULT : len;
-				}
+				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGNAME(0)))
+					return str_to_user(dev->name, _IOC_SIZE(cmd), p);
 
-				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGPHYS(0))) {
-					int len;
-					if (!dev->phys) return -ENOENT;
-					len = strlen(dev->phys) + 1;
-					if (len > _IOC_SIZE(cmd)) len = _IOC_SIZE(cmd);
-					return copy_to_user(p, dev->phys, len) ? -EFAULT : len;
-				}
+				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGPHYS(0)))
+					return str_to_user(dev->phys, _IOC_SIZE(cmd), p);
 
-				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGUNIQ(0))) {
-					int len;
-					if (!dev->uniq) return -ENOENT;
-					len = strlen(dev->uniq) + 1;
-					if (len > _IOC_SIZE(cmd)) len = _IOC_SIZE(cmd);
-					return copy_to_user(p, dev->uniq, len) ? -EFAULT : len;
-				}
+				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGUNIQ(0)))
+					return str_to_user(dev->uniq, _IOC_SIZE(cmd), p);
 
 				if ((_IOC_NR(cmd) & ~ABS_MAX) == _IOC_NR(EVIOCGABS(0))) {
 
@@ -492,158 +568,15 @@ static long evdev_ioctl(struct file *fil
 	return -EINVAL;
 }
 
-#ifdef CONFIG_COMPAT
-
-#define BITS_PER_LONG_COMPAT (sizeof(compat_long_t) * 8)
-#define NBITS_COMPAT(x) ((((x)-1)/BITS_PER_LONG_COMPAT)+1)
-#define OFF_COMPAT(x)  ((x)%BITS_PER_LONG_COMPAT)
-#define BIT_COMPAT(x)  (1UL<<OFF_COMPAT(x))
-#define LONG_COMPAT(x) ((x)/BITS_PER_LONG_COMPAT)
-#define test_bit_compat(bit, array) ((array[LONG_COMPAT(bit)] >> OFF_COMPAT(bit)) & 1)
-
-#ifdef __BIG_ENDIAN
-#define bit_to_user(bit, max) \
-do { \
-	int i; \
-	int len = NBITS_COMPAT((max)) * sizeof(compat_long_t); \
-	if (len > _IOC_SIZE(cmd)) len = _IOC_SIZE(cmd); \
-	for (i = 0; i < len / sizeof(compat_long_t); i++) \
-		if (copy_to_user((compat_long_t __user *) p + i, \
-				 (compat_long_t*) (bit) + i + 1 - ((i % 2) << 1), \
-				 sizeof(compat_long_t))) \
-			return -EFAULT; \
-	return len; \
-} while (0)
-#else
-#define bit_to_user(bit, max) \
-do { \
-	int len = NBITS_COMPAT((max)) * sizeof(compat_long_t); \
-	if (len > _IOC_SIZE(cmd)) len = _IOC_SIZE(cmd); \
-	return copy_to_user(p, (bit), len) ? -EFAULT : len; \
-} while (0)
-#endif
+static long evdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	return evdev_ioctl_handler(file, cmd, (void __user *)arg, 0);
+}
 
+#ifdef CONFIG_COMPAT
 static long evdev_ioctl_compat(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct evdev_list *list = file->private_data;
-	struct evdev *evdev = list->evdev;
-	struct input_dev *dev = evdev->handle.dev;
-	struct input_absinfo abs;
-	void __user *p = compat_ptr(arg);
-
-	if (!evdev->exist) return -ENODEV;
-
-	switch (cmd) {
-
-		case EVIOCGVERSION:
-		case EVIOCGID:
-		case EVIOCGKEYCODE:
-		case EVIOCSKEYCODE:
-		case EVIOCSFF:
-		case EVIOCRMFF:
-		case EVIOCGEFFECTS:
-		case EVIOCGRAB:
-			return evdev_ioctl(file, cmd, (unsigned long) p);
-
-		default:
-
-			if (_IOC_TYPE(cmd) != 'E')
-				return -EINVAL;
-
-			if (_IOC_DIR(cmd) == _IOC_READ) {
-
-				if ((_IOC_NR(cmd) & ~EV_MAX) == _IOC_NR(EVIOCGBIT(0,0))) {
-					long *bits;
-					int max;
-
-					switch (_IOC_NR(cmd) & EV_MAX) {
-						case      0: bits = dev->evbit;  max = EV_MAX;  break;
-						case EV_KEY: bits = dev->keybit; max = KEY_MAX; break;
-						case EV_REL: bits = dev->relbit; max = REL_MAX; break;
-						case EV_ABS: bits = dev->absbit; max = ABS_MAX; break;
-						case EV_MSC: bits = dev->mscbit; max = MSC_MAX; break;
-						case EV_LED: bits = dev->ledbit; max = LED_MAX; break;
-						case EV_SND: bits = dev->sndbit; max = SND_MAX; break;
-						case EV_FF:  bits = dev->ffbit;  max = FF_MAX;  break;
-						case EV_SW:  bits = dev->swbit;  max = SW_MAX;  break;
-						default: return -EINVAL;
-					}
-					bit_to_user(bits, max);
-				}
-
-				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGKEY(0)))
-					bit_to_user(dev->key, KEY_MAX);
-
-				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGLED(0)))
-					bit_to_user(dev->led, LED_MAX);
-
-				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGSND(0)))
-					bit_to_user(dev->snd, SND_MAX);
-
-				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGSW(0)))
-					bit_to_user(dev->sw, SW_MAX);
-
-				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGNAME(0))) {
-					int len;
-					if (!dev->name) return -ENOENT;
-					len = strlen(dev->name) + 1;
-					if (len > _IOC_SIZE(cmd)) len = _IOC_SIZE(cmd);
-					return copy_to_user(p, dev->name, len) ? -EFAULT : len;
-				}
-
-				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGPHYS(0))) {
-					int len;
-					if (!dev->phys) return -ENOENT;
-					len = strlen(dev->phys) + 1;
-					if (len > _IOC_SIZE(cmd)) len = _IOC_SIZE(cmd);
-					return copy_to_user(p, dev->phys, len) ? -EFAULT : len;
-				}
-
-				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGUNIQ(0))) {
-					int len;
-					if (!dev->uniq) return -ENOENT;
-					len = strlen(dev->uniq) + 1;
-					if (len > _IOC_SIZE(cmd)) len = _IOC_SIZE(cmd);
-					return copy_to_user(p, dev->uniq, len) ? -EFAULT : len;
-				}
-
-				if ((_IOC_NR(cmd) & ~ABS_MAX) == _IOC_NR(EVIOCGABS(0))) {
-
-					int t = _IOC_NR(cmd) & ABS_MAX;
-
-					abs.value = dev->abs[t];
-					abs.minimum = dev->absmin[t];
-					abs.maximum = dev->absmax[t];
-					abs.fuzz = dev->absfuzz[t];
-					abs.flat = dev->absflat[t];
-
-					if (copy_to_user(p, &abs, sizeof(struct input_absinfo)))
-						return -EFAULT;
-
-					return 0;
-				}
-			}
-
-			if (_IOC_DIR(cmd) == _IOC_WRITE) {
-
-				if ((_IOC_NR(cmd) & ~ABS_MAX) == _IOC_NR(EVIOCSABS(0))) {
-
-					int t = _IOC_NR(cmd) & ABS_MAX;
-
-					if (copy_from_user(&abs, p, sizeof(struct input_absinfo)))
-						return -EFAULT;
-
-					dev->abs[t] = abs.value;
-					dev->absmin[t] = abs.minimum;
-					dev->absmax[t] = abs.maximum;
-					dev->absfuzz[t] = abs.fuzz;
-					dev->absflat[t] = abs.flat;
-
-					return 0;
-				}
-			}
-	}
-	return -EINVAL;
+	return evdev_ioctl_handler(file, cmd, compat_ptr(arg), 1);
 }
 #endif
 

