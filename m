Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261676AbSI2SZx>; Sun, 29 Sep 2002 14:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261713AbSI2SZx>; Sun, 29 Sep 2002 14:25:53 -0400
Received: from gate.perex.cz ([194.212.165.105]:5904 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S261676AbSI2SZh>;
	Sun, 29 Sep 2002 14:25:37 -0400
Date: Sun, 29 Sep 2002 20:30:14 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA update [1/10] - 2002/06/24
Message-ID: <Pine.LNX.4.33.0209292026550.591-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	1-st patch from first set of ALSA update patches.

						Jaroslav

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.605.4.1, 2002-09-25 10:00:04+02:00, perex@pnote.perex-int.cz
  ALSA update 2002/06/24:
    - ioctl32 emulation update
    - intel8x0 driver
      - fixed PCI ID of AMD8111
    - compilation fixes for HDSP
    - fixes for PCI memory allocation




diff -Nru a/include/sound/asequencer.h b/include/sound/asequencer.h
--- a/include/sound/asequencer.h	Sun Sep 29 20:18:57 2002
+++ b/include/sound/asequencer.h	Sun Sep 29 20:18:57 2002
@@ -257,7 +257,7 @@
 struct sndrv_seq_ev_ext {
 	unsigned int len;	/* length of data */
 	void *ptr;		/* pointer to data (note: maybe 64-bit) */
-};
+} __attribute__((packed));
 
 /* Instrument cluster type */
 typedef unsigned int sndrv_seq_instr_cluster_t;
@@ -373,7 +373,7 @@
 	struct sndrv_seq_addr origin;		/* original sender */
 	unsigned short value;		/* optional data */
 	struct sndrv_seq_event *event;		/* quoted event */
-};
+} __attribute__((packed));
 
 
 	/* sequencer event */
@@ -486,6 +486,16 @@
 };
 
 
+	/* system running information */
+struct sndrv_seq_running_info {
+	unsigned char client;		/* client id */
+	unsigned char big_endian;	/* 1 = big-endian */
+	unsigned char cpu_mode;		/* 4 = 32bit, 8 = 64bit */
+	unsigned char pad;		/* reserved */
+	unsigned char reserved[12];
+};
+
+
 	/* known client numbers */
 #define SNDRV_SEQ_CLIENT_SYSTEM		0
 #define SNDRV_SEQ_CLIENT_DUMMY		62	/* dummy ports */
@@ -609,7 +619,6 @@
 	int write_use;			/* R/O: subscribers for input (to this port) */
 
 	void *kernel;			/* reserved for kernel use (must be NULL) */
-
 	unsigned int flags;		/* misc. conditioning */
 	char reserved[60];		/* for future use */
 };
@@ -853,6 +862,7 @@
 #define SNDRV_SEQ_IOCTL_PVERSION	_IOR ('S', 0x00, int)
 #define SNDRV_SEQ_IOCTL_CLIENT_ID	_IOR ('S', 0x01, int)
 #define SNDRV_SEQ_IOCTL_SYSTEM_INFO	_IOWR('S', 0x02, struct sndrv_seq_system_info)
+#define SNDRV_SEQ_IOCTL_RUNNING_MODE	_IOWR('S', 0x03, struct sndrv_seq_running_info)
 
 #define SNDRV_SEQ_IOCTL_GET_CLIENT_INFO	_IOWR('S', 0x10, struct sndrv_seq_client_info)
 #define SNDRV_SEQ_IOCTL_SET_CLIENT_INFO	_IOW ('S', 0x11, struct sndrv_seq_client_info)
diff -Nru a/include/sound/driver.h b/include/sound/driver.h
--- a/include/sound/driver.h	Sun Sep 29 20:18:57 2002
+++ b/include/sound/driver.h	Sun Sep 29 20:18:57 2002
@@ -50,7 +50,7 @@
  */
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 4, 0)
-#if defined(__i386__) || defined(__ppc__)
+#if defined(__i386__) || defined(__ppc__) || defined(__x86_64__)
 /*
  * Here a dirty hack for 2.4 kernels.. See sound/core/memory.c.
  */
diff -Nru a/include/sound/version.h b/include/sound/version.h
--- a/include/sound/version.h	Sun Sep 29 20:18:57 2002
+++ b/include/sound/version.h	Sun Sep 29 20:18:57 2002
@@ -1,3 +1,3 @@
 /* include/version.h.  Generated automatically by configure.  */
 #define CONFIG_SND_VERSION "0.9.0rc2"
-#define CONFIG_SND_DATE " (Wed Jun 19 08:56:25 2002 UTC)"
+#define CONFIG_SND_DATE " (Fri Jun 21 12:21:17 2002 UTC)"
diff -Nru a/sound/core/ioctl32/Makefile b/sound/core/ioctl32/Makefile
--- a/sound/core/ioctl32/Makefile	Sun Sep 29 20:18:57 2002
+++ b/sound/core/ioctl32/Makefile	Sun Sep 29 20:18:57 2002
@@ -4,7 +4,7 @@
 #
 
 snd-ioctl32-objs := ioctl32.o pcm32.o rawmidi32.o timer32.o hwdep32.o
-ifeq ($(CONFIG_SND_SEQUENCER),y)
+ifneq ($(CONFIG_SND_SEQUENCER),n)
   snd-ioctl32-objs += seq32.o
 endif
 
diff -Nru a/sound/core/ioctl32/ioctl32.c b/sound/core/ioctl32/ioctl32.c
--- a/sound/core/ioctl32/ioctl32.c	Sun Sep 29 20:18:57 2002
+++ b/sound/core/ioctl32/ioctl32.c	Sun Sep 29 20:18:57 2002
@@ -21,6 +21,7 @@
 #define __NO_VERSION__
 #include <sound/driver.h>
 #include <linux/smp_lock.h>
+#include <linux/init.h>
 #include <linux/time.h>
 #include <sound/core.h>
 #include <sound/control.h>
@@ -32,6 +33,10 @@
  * exported for other modules
  */
 
+MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
+MODULE_DESCRIPTION("ioctl32 wrapper for ALSA");
+MODULE_LICENSE("GPL");
+
 int register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned int, unsigned int, unsigned long, struct file *));
 int unregister_ioctl32_conversion(unsigned int cmd);
 
@@ -79,7 +84,7 @@
 	u32 count;
 	u32 pids;
 	unsigned char reserved[50];
-};
+} /* don't set packed attribute here */;
 
 #define CVT_sndrv_ctl_elem_list()\
 {\
@@ -90,8 +95,43 @@
 	CPTR(pids);\
 }
 
-DEFINE_ALSA_IOCTL(ctl_elem_list);
+static int _snd_ioctl32_ctl_elem_list(unsigned int fd, unsigned int cmd, unsigned long arg, struct file *file, unsigned int native_ctl)
+{
+	struct sndrv_ctl_elem_list32 data32;
+	struct sndrv_ctl_elem_list data;
+	mm_segment_t oldseg = get_fs();
+	int err;
+
+	set_fs(KERNEL_DS);
+	if (copy_from_user(&data32, (void*)arg, sizeof(data32))) {
+		err = -EFAULT;
+		goto __err;
+	}
+	memset(&data, 0, sizeof(data));
+	data.offset = data32.offset;
+	data.space = data32.space;
+	data.used = data32.used;
+	data.count = data32.count;
+	data.pids = A(data32.pids);
+	err = file->f_op->ioctl(file->f_dentry->d_inode, file, native_ctl, (unsigned long)&data);
+	if (err < 0)
+		goto __err;
+	/* copy the result */
+	data32.offset = data.offset;
+	data32.space = data.space;
+	data32.used = data.used;
+	data32.count = data.count;
+	//data.pids = data.pids;
+	if (copy_to_user((void*)arg, &data32, sizeof(data32))) {
+		err = -EFAULT;
+		goto __err;
+	}
+ __err:
+	set_fs(oldseg);
+	return err;
+}
 
+DEFINE_ALSA_IOCTL_ENTRY(ctl_elem_list, ctl_elem_list, SNDRV_CTL_IOCTL_ELEM_LIST);
 
 /*
  * control element info
@@ -123,22 +163,31 @@
 		unsigned char reserved[128];
 	} value;
 	unsigned char reserved[64];
-};
+} __attribute__((packed));
 
-static int snd_ioctl32_ctl_elem_info(unsigned int fd, unsigned int cmd, unsigned long arg, struct file *file)
+static int _snd_ioctl32_ctl_elem_info(unsigned int fd, unsigned int cmd, unsigned long arg, struct file *file, unsigned int native_ctl)
 {
 	struct sndrv_ctl_elem_info data;
 	struct sndrv_ctl_elem_info32 data32;
 	int err;
+	mm_segment_t oldseg = get_fs();
 
-	if (copy_from_user(&data32, (void*)arg, sizeof(data32)))
-		return -EFAULT;
+	set_fs(KERNEL_DS);
+	if (copy_from_user(&data32, (void*)arg, sizeof(data32))) {
+		err = -EFAULT;
+		goto __err;
+	}
 	memset(&data, 0, sizeof(data));
 	data.id = data32.id;
-	err = file->f_op->ioctl(file->f_dentry->d_inode, file, cmd, (unsigned long)&data);
+	/* we need to copy the item index.
+	 * hope this doesn't break anything..
+	 */
+	data.value.enumerated.item = data32.value.enumerated.item;
+	err = file->f_op->ioctl(file->f_dentry->d_inode, file, native_ctl, (unsigned long)&data);
 	if (err < 0)
-		return err;
+		goto __err;
 	/* restore info to 32bit */
+	data32.id = data.id;
 	data32.type = data.type;
 	data32.access = data.access;
 	data32.count = data.count;
@@ -147,12 +196,12 @@
 	case SNDRV_CTL_ELEM_TYPE_BOOLEAN:
 	case SNDRV_CTL_ELEM_TYPE_INTEGER:
 		data32.value.integer.min = data.value.integer.min;
-		data32.value.integer.max = data.value.integer.min;
+		data32.value.integer.max = data.value.integer.max;
 		data32.value.integer.step = data.value.integer.step;
 		break;
 	case SNDRV_CTL_ELEM_TYPE_INTEGER64:
 		data32.value.integer64.min = data.value.integer64.min;
-		data32.value.integer64.max = data.value.integer64.min;
+		data32.value.integer64.max = data.value.integer64.max;
 		data32.value.integer64.step = data.value.integer64.step;
 		break;
 	case SNDRV_CTL_ELEM_TYPE_ENUMERATED:
@@ -165,14 +214,17 @@
 		break;
 	}
 	if (copy_to_user((void*)arg, &data32, sizeof(data32)))
-		return -EFAULT;
+		err = -EFAULT;
+ __err:
+	set_fs(oldseg);
 	return err;
 }
 
+DEFINE_ALSA_IOCTL_ENTRY(ctl_elem_info, ctl_elem_info, SNDRV_CTL_IOCTL_ELEM_INFO);
 
 struct sndrv_ctl_elem_value32 {
 	struct sndrv_ctl_elem_id id;
-	unsigned int indirect: 1;
+	unsigned int indirect;	/* bit-field causes misalignment */
         union {
 		union {
 			s32 value[128];
@@ -193,7 +245,7 @@
 		struct sndrv_aes_iec958 iec958;
         } value;
         unsigned char reserved[128];
-};
+} __attribute__((packed));
 
 
 /* hmm, it's so hard to retrieve the value type from the control id.. */
@@ -221,25 +273,33 @@
 }
 
 
-static int snd_ioctl32_ctl_elem_value(unsigned int fd, unsigned int cmd, unsigned long arg, struct file *file)
+static int _snd_ioctl32_ctl_elem_value(unsigned int fd, unsigned int cmd, unsigned long arg, struct file *file, unsigned int native_ctl)
 {
 	// too big?
 	struct sndrv_ctl_elem_value data;
 	struct sndrv_ctl_elem_value32 data32;
 	int err, i;
 	int type;
+	mm_segment_t oldseg = get_fs();
+
+	set_fs(KERNEL_DS);
+
 	/* FIXME: check the sane ioctl.. */
 
-	if (copy_from_user(&data32, (void*)arg, sizeof(data32)))
-		return -EFAULT;
+	if (copy_from_user(&data32, (void*)arg, sizeof(data32))) {
+		err = -EFAULT;
+		goto __err;
+	}
 	memset(&data, 0, sizeof(data));
 	data.id = data32.id;
 	data.indirect = data32.indirect;
 	if (data.indirect) /* FIXME: this is not correct for long arrays */
 		data.value.integer.value_ptr = (void*)TO_PTR(data32.value.integer.value_ptr);
 	type = get_ctl_type(file, &data.id);
-	if (type < 0)
-		return type;
+	if (type < 0) {
+		err = type;
+		goto __err;
+	}
 	if (! data.indirect) {
 		switch (type) {
 		case SNDRV_CTL_ELEM_TYPE_BOOLEAN:
@@ -263,45 +323,50 @@
 			data.value.iec958 = data32.value.iec958;
 			break;
 		default:
+			printk("unknown type %d\n", type);
 			break;
 		}
 	}
 
-	err = file->f_op->ioctl(file->f_dentry->d_inode, file, cmd, (unsigned long)&data);
+	err = file->f_op->ioctl(file->f_dentry->d_inode, file, native_ctl, (unsigned long)&data);
 	if (err < 0)
-		return err;
+		goto __err;
 	/* restore info to 32bit */
 	if (! data.indirect) {
 		switch (type) {
 		case SNDRV_CTL_ELEM_TYPE_BOOLEAN:
 		case SNDRV_CTL_ELEM_TYPE_INTEGER:
 			for (i = 0; i < 128; i++)
-				data.value.integer.value[i] = data32.value.integer.value[i];
+				data32.value.integer.value[i] = data.value.integer.value[i];
 			break;
 		case SNDRV_CTL_ELEM_TYPE_INTEGER64:
 			for (i = 0; i < 64; i++)
-				data.value.integer64.value[i] = data32.value.integer64.value[i];
+				data32.value.integer64.value[i] = data.value.integer64.value[i];
 			break;
 		case SNDRV_CTL_ELEM_TYPE_ENUMERATED:
 			for (i = 0; i < 128; i++)
-				data.value.enumerated.item[i] = data32.value.enumerated.item[i];
+				data32.value.enumerated.item[i] = data.value.enumerated.item[i];
 			break;
 		case SNDRV_CTL_ELEM_TYPE_BYTES:
-			memcpy(data.value.bytes.data, data32.value.bytes.data,
+			memcpy(data32.value.bytes.data, data.value.bytes.data,
 			       sizeof(data.value.bytes.data));
 			break;
 		case SNDRV_CTL_ELEM_TYPE_IEC958:
-			data.value.iec958 = data32.value.iec958;
+			data32.value.iec958 = data.value.iec958;
 			break;
 		default:
 			break;
 		}
 	}
 	if (copy_to_user((void*)arg, &data32, sizeof(data32)))
-		return -EFAULT;
+		err = -EFAULT;
+ __err:
+	set_fs(oldseg);
 	return err;
 }
 
+DEFINE_ALSA_IOCTL_ENTRY(ctl_elem_read, ctl_elem_value, SNDRV_CTL_IOCTL_ELEM_READ);
+DEFINE_ALSA_IOCTL_ENTRY(ctl_elem_write, ctl_elem_value, SNDRV_CTL_IOCTL_ELEM_WRITE);
 
 /*
  */
@@ -321,8 +386,8 @@
 	{ SNDRV_CTL_IOCTL_CARD_INFO , NULL },
 	{ SNDRV_CTL_IOCTL_ELEM_LIST32, AP(ctl_elem_list) },
 	{ SNDRV_CTL_IOCTL_ELEM_INFO32, AP(ctl_elem_info) },
-	{ SNDRV_CTL_IOCTL_ELEM_READ32, AP(ctl_elem_value) },
-	{ SNDRV_CTL_IOCTL_ELEM_WRITE32, AP(ctl_elem_value) },
+	{ SNDRV_CTL_IOCTL_ELEM_READ32, AP(ctl_elem_read) },
+	{ SNDRV_CTL_IOCTL_ELEM_WRITE32, AP(ctl_elem_write) },
 	{ SNDRV_CTL_IOCTL_ELEM_LOCK, NULL },
 	{ SNDRV_CTL_IOCTL_ELEM_UNLOCK, NULL },
 	{ SNDRV_CTL_IOCTL_SUBSCRIBE_EVENTS, NULL },
@@ -393,6 +458,7 @@
 		return err;
 	}
 #endif
+	return 0;
 }
 
 module_init(snd_ioctl32_init)
diff -Nru a/sound/core/ioctl32/ioctl32.h b/sound/core/ioctl32/ioctl32.h
--- a/sound/core/ioctl32/ioctl32.h	Sun Sep 29 20:18:57 2002
+++ b/sound/core/ioctl32/ioctl32.h	Sun Sep 29 20:18:57 2002
@@ -26,6 +26,15 @@
 #ifndef __ALSA_IOCTL32_H
 #define __ALSA_IOCTL32_H
 
+#ifndef A
+#ifdef CONFIG_PPC64
+#include <asm/ppc32.h>
+#else
+/* x86-64, sparc64 */
+#define A(__x) ((void *)(unsigned long)(__x))
+#endif
+#endif
+
 #define TO_PTR(x)  A(x)
 
 #define COPY(x)  (dst->x = src->x)
@@ -47,25 +56,38 @@
 
 
 #define DEFINE_ALSA_IOCTL(type) \
-static int snd_ioctl32_##type(unsigned int fd, unsigned int cmd, unsigned long arg, struct file *file)\
+static int _snd_ioctl32_##type(unsigned int fd, unsigned int cmd, unsigned long arg, struct file *file, unsigned int native_ctl)\
 {\
 	struct sndrv_##type##32 data32;\
 	struct sndrv_##type data;\
+	mm_segment_t oldseg = get_fs();\
 	int err;\
-	if (copy_from_user(&data32, (void*)arg, sizeof(data32)))\
-		return -EFAULT;\
+	set_fs(KERNEL_DS);\
+	if (copy_from_user(&data32, (void*)arg, sizeof(data32))) {\
+		err = -EFAULT;\
+		goto __err;\
+	}\
 	memset(&data, 0, sizeof(data));\
 	convert_from_32(type, &data, &data32);\
-	err = file->f_op->ioctl(file->f_dentry->d_inode, file, cmd, (unsigned long)&data);\
-	if (err < 0)\
-		return err;\
-	if (cmd & (_IOC_READ << _IOC_DIRSHIFT)) {\
+	err = file->f_op->ioctl(file->f_dentry->d_inode, file, native_ctl, (unsigned long)&data);\
+	if (err < 0) \
+		goto __err;\
+	if (native_ctl & (_IOC_READ << _IOC_DIRSHIFT)) {\
 		convert_to_32(type, &data32, &data);\
-		if (copy_to_user((void*)arg, &data32, sizeof(data32)))\
-			return -EFAULT;\
+		if (copy_to_user((void*)arg, &data32, sizeof(data32))) {\
+			err = -EFAULT;\
+			goto __err;\
+		}\
 	}\
+ __err: set_fs(oldseg);\
 	return err;\
 }
+
+#define DEFINE_ALSA_IOCTL_ENTRY(name,type,native_ctl) \
+static int snd_ioctl32_##name(unsigned int fd, unsigned int cmd, unsigned long arg, struct file *file) {\
+	return _snd_ioctl32_##type(fd, cmd, arg, file, native_ctl);\
+}
+
 
 struct ioctl32_mapper {
 	unsigned int cmd;
diff -Nru a/sound/core/ioctl32/pcm32.c b/sound/core/ioctl32/pcm32.c
--- a/sound/core/ioctl32/pcm32.c	Sun Sep 29 20:18:57 2002
+++ b/sound/core/ioctl32/pcm32.c	Sun Sep 29 20:18:57 2002
@@ -54,7 +54,7 @@
 
 struct sndrv_pcm_hw_params32 {
 	u32 flags;
-	u32 masks[SNDRV_PCM_HW_PARAM_LAST_MASK - SNDRV_PCM_HW_PARAM_FIRST_MASK + 1];
+	struct sndrv_mask masks[SNDRV_PCM_HW_PARAM_LAST_MASK - SNDRV_PCM_HW_PARAM_FIRST_MASK + 1]; /* this must be identical */
 	struct sndrv_interval32 intervals[SNDRV_PCM_HW_PARAM_LAST_INTERVAL - SNDRV_PCM_HW_PARAM_FIRST_INTERVAL + 1];
 	u32 rmask;
 	u32 cmask;
@@ -64,7 +64,7 @@
 	u32 rate_den;
 	u32 fifo_size;
 	unsigned char reserved[64];
-};
+} __attribute__((packed));
 
 #define numberof(array)  (sizeof(array)/sizeof(array[0]))
 
@@ -103,7 +103,7 @@
 	u32 silence_size;
 	u32 boundary;
 	unsigned char reserved[64];
-};
+} __attribute__((packed));
 
 #define CVT_sndrv_pcm_sw_params()\
 {\
@@ -124,7 +124,7 @@
 	u32 offset;
 	u32 first;
 	u32 step;
-};
+} __attribute__((packed));
 
 #define CVT_sndrv_pcm_channel_info()\
 {\
@@ -137,7 +137,7 @@
 struct timeval32 {
 	s32 tv_sec;
 	s32 tv_usec;
-};
+} __attribute__((packed));
 
 struct sndrv_pcm_status32 {
 	s32 state;
@@ -151,7 +151,7 @@
 	u32 overrange;
 	s32 suspended_state;
 	unsigned char reserved[60];
-};
+} __attribute__((packed));
 
 #define CVT_sndrv_pcm_status()\
 {\
@@ -169,33 +169,58 @@
 	COPY(suspended_state);\
 }
 
+DEFINE_ALSA_IOCTL(pcm_uframes_str);
+DEFINE_ALSA_IOCTL(pcm_sframes_str);
+DEFINE_ALSA_IOCTL(pcm_hw_params);
+DEFINE_ALSA_IOCTL(pcm_sw_params);
+DEFINE_ALSA_IOCTL(pcm_channel_info);
+DEFINE_ALSA_IOCTL(pcm_status);
+
+/*
+ */
 struct sndrv_xferi32 {
 	s32 result;
 	u32 buf;
 	u32 frames;
-};
+} __attribute__((packed));
 
-#define CVT_sndrv_xferi()\
-{\
-	COPY(result);\
-	CPTR(buf);\
-	COPY(frames);\
+static int _snd_ioctl32_xferi(unsigned int fd, unsigned int cmd, unsigned long arg, struct file *file, unsigned int native_ctl)
+{
+	struct sndrv_xferi32 data32;
+	struct sndrv_xferi data;
+	mm_segment_t oldseg = get_fs();
+	int err;
+
+	set_fs(KERNEL_DS);
+	if (copy_from_user(&data32, (void*)arg, sizeof(data32))) {
+		err = -EFAULT;
+		goto __err;
+	}
+	memset(&data, 0, sizeof(data));
+	data.result = data32.result;
+	data.buf = A(data32.buf);
+	data.frames = data32.frames;
+	err = file->f_op->ioctl(file->f_dentry->d_inode, file, native_ctl, (unsigned long)&data);
+	if (err < 0)
+		goto __err;
+	/* copy the result */
+	data32.result = data.result;
+	if (copy_to_user((void*)arg, &data32, sizeof(data32))) {
+		err = -EFAULT;
+		goto __err;
+	}
+ __err:
+	set_fs(oldseg);
+	return err;
 }
 
-DEFINE_ALSA_IOCTL(pcm_uframes_str);
-DEFINE_ALSA_IOCTL(pcm_sframes_str);
-DEFINE_ALSA_IOCTL(pcm_hw_params);
-DEFINE_ALSA_IOCTL(pcm_sw_params);
-DEFINE_ALSA_IOCTL(pcm_channel_info);
-DEFINE_ALSA_IOCTL(pcm_status);
-DEFINE_ALSA_IOCTL(xferi);
 
 /* snd_xfern needs remapping of bufs */
 struct sndrv_xfern32 {
 	s32 result;
 	u32 bufs;  /* this is void **; */
 	u32 frames;
-};
+} __attribute__((packed));
 
 /*
  * xfern ioctl nees to copy (up to) 128 pointers on stack.
@@ -203,7 +228,7 @@
  * handler there expands again the same 128 pointers on stack, so it is better
  * to handle the function (calling pcm_readv/writev) directly in this handler.
  */
-static int snd_ioctl32_xfern(unsigned int fd, unsigned int cmd, unsigned long arg, struct file *file)
+static int _snd_ioctl32_xfern(unsigned int fd, unsigned int cmd, unsigned long arg, struct file *file, unsigned int native_ctl)
 {
 	snd_pcm_file_t *pcm_file;
 	snd_pcm_substream_t *substream;
@@ -211,6 +236,9 @@
 	void *bufs[128];
 	int err = 0, ch, i;
 	u32 *bufptr;
+	mm_segment_t oldseg = get_fs();
+
+	set_fs(KERNEL_DS);
 
 	/* FIXME: need to check whether fop->ioctl is sane */
 
@@ -219,31 +247,44 @@
 	snd_assert(substream != NULL && substream->runtime, return -ENXIO);
 
 	/* check validty of the command */
-	switch (cmd) {
+	switch (native_ctl) {
 	case SNDRV_PCM_IOCTL_WRITEN_FRAMES:
-		if (substream->stream  != SNDRV_PCM_STREAM_PLAYBACK)
-			return -EINVAL;
-		if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
-			return -EBADFD;
+		if (substream->stream  != SNDRV_PCM_STREAM_PLAYBACK) {
+			err = -EINVAL;
+			goto __err;
+		}
+		if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+			err = -EBADFD;
+			goto __err;
+		}
+		break;
 	case SNDRV_PCM_IOCTL_READN_FRAMES:
-		if (substream->stream  != SNDRV_PCM_STREAM_CAPTURE)
-			return -EINVAL;
+		if (substream->stream  != SNDRV_PCM_STREAM_CAPTURE) {
+			err = -EINVAL;
+			goto __err;
+		}
 		break;
 	}
-	if ((ch = substream->runtime->channels) > 128)
-		return -EINVAL;
-	if (get_user(data32.frames, &srcptr->frames))
-		return -EFAULT;
+	if ((ch = substream->runtime->channels) > 128) {
+		err = -EINVAL;
+		goto __err;
+	}
+	if (get_user(data32.frames, &srcptr->frames)) {
+		err = -EFAULT;
+		goto __err;
+	}
 	__get_user(data32.bufs, &srcptr->bufs);
 	bufptr = (u32*)TO_PTR(data32.bufs);
 	for (i = 0; i < ch; i++) {
 		u32 ptr;
-		if (get_user(ptr, bufptr))
-			return -EFAULT;
+		if (get_user(ptr, bufptr)) {
+			err = -EFAULT;
+			goto __err;
+		}
 		bufs[ch] = (void*)TO_PTR(ptr);
 		bufptr++;
 	}
-	switch (cmd) {
+	switch (native_ctl) {
 	case SNDRV_PCM_IOCTL_WRITEN_FRAMES:
 		err = snd_pcm_lib_writev(substream, bufs, data32.frames);
 		break;
@@ -253,13 +294,33 @@
 	}
 	
 	if (err < 0)
-		return err;
+		goto __err;
 	if (put_user(err, &srcptr->result))
-		return -EFAULT;
+		err = -EFAULT;
+ __err:
+	set_fs(oldseg);
 	return err < 0 ? err : 0;
 }
 
 
+/*
+ */
+
+DEFINE_ALSA_IOCTL_ENTRY(pcm_hw_refine, pcm_hw_params, SNDRV_PCM_IOCTL_HW_REFINE);
+DEFINE_ALSA_IOCTL_ENTRY(pcm_sw_params, pcm_sw_params, SNDRV_PCM_IOCTL_SW_PARAMS);
+DEFINE_ALSA_IOCTL_ENTRY(pcm_hw_params, pcm_hw_params, SNDRV_PCM_IOCTL_HW_PARAMS);
+DEFINE_ALSA_IOCTL_ENTRY(pcm_status, pcm_status, SNDRV_PCM_IOCTL_STATUS);
+DEFINE_ALSA_IOCTL_ENTRY(pcm_delay, pcm_sframes_str, SNDRV_PCM_IOCTL_DELAY);
+DEFINE_ALSA_IOCTL_ENTRY(pcm_channel_info, pcm_channel_info, SNDRV_PCM_IOCTL_CHANNEL_INFO);
+DEFINE_ALSA_IOCTL_ENTRY(pcm_rewind, pcm_uframes_str, SNDRV_PCM_IOCTL_REWIND);
+DEFINE_ALSA_IOCTL_ENTRY(pcm_readi, xferi, SNDRV_PCM_IOCTL_READI_FRAMES);
+DEFINE_ALSA_IOCTL_ENTRY(pcm_writei, xferi, SNDRV_PCM_IOCTL_WRITEI_FRAMES);
+DEFINE_ALSA_IOCTL_ENTRY(pcm_readn, xfern, SNDRV_PCM_IOCTL_READN_FRAMES);
+DEFINE_ALSA_IOCTL_ENTRY(pcm_writen, xfern, SNDRV_PCM_IOCTL_WRITEN_FRAMES);
+
+
+/*
+ */
 #define AP(x) snd_ioctl32_##x
 
 enum {
@@ -279,12 +340,12 @@
 struct ioctl32_mapper pcm_mappers[] = {
 	{ SNDRV_PCM_IOCTL_PVERSION, NULL },
 	{ SNDRV_PCM_IOCTL_INFO, NULL },
-	{ SNDRV_PCM_IOCTL_HW_REFINE32, AP(pcm_hw_params) },
+	{ SNDRV_PCM_IOCTL_HW_REFINE32, AP(pcm_hw_refine) },
 	{ SNDRV_PCM_IOCTL_HW_PARAMS32, AP(pcm_hw_params) },
 	{ SNDRV_PCM_IOCTL_HW_FREE, NULL },
 	{ SNDRV_PCM_IOCTL_SW_PARAMS32, AP(pcm_sw_params) },
 	{ SNDRV_PCM_IOCTL_STATUS32, AP(pcm_status) },
-	{ SNDRV_PCM_IOCTL_DELAY32, AP(pcm_sframes_str) },
+	{ SNDRV_PCM_IOCTL_DELAY32, AP(pcm_delay) },
 	{ SNDRV_PCM_IOCTL_CHANNEL_INFO32, AP(pcm_channel_info) },
 	{ SNDRV_PCM_IOCTL_PREPARE, NULL },
 	{ SNDRV_PCM_IOCTL_RESET, NULL },
@@ -292,13 +353,13 @@
 	{ SNDRV_PCM_IOCTL_DROP, NULL },
 	{ SNDRV_PCM_IOCTL_DRAIN, NULL },
 	{ SNDRV_PCM_IOCTL_PAUSE, NULL },
-	{ SNDRV_PCM_IOCTL_REWIND32, AP(pcm_uframes_str) },
+	{ SNDRV_PCM_IOCTL_REWIND32, AP(pcm_rewind) },
 	{ SNDRV_PCM_IOCTL_RESUME, NULL },
 	{ SNDRV_PCM_IOCTL_XRUN, NULL },
-	{ SNDRV_PCM_IOCTL_WRITEI_FRAMES32, AP(xferi) },
-	{ SNDRV_PCM_IOCTL_READI_FRAMES32, AP(xferi) },
-	{ SNDRV_PCM_IOCTL_WRITEN_FRAMES32, AP(xfern) },
-	{ SNDRV_PCM_IOCTL_READN_FRAMES32, AP(xfern) },
+	{ SNDRV_PCM_IOCTL_WRITEI_FRAMES32, AP(pcm_writei) },
+	{ SNDRV_PCM_IOCTL_READI_FRAMES32, AP(pcm_readi) },
+	{ SNDRV_PCM_IOCTL_WRITEN_FRAMES32, AP(pcm_writen) },
+	{ SNDRV_PCM_IOCTL_READN_FRAMES32, AP(pcm_readn) },
 	{ SNDRV_PCM_IOCTL_LINK, NULL },
 	{ SNDRV_PCM_IOCTL_UNLINK, NULL },
 
diff -Nru a/sound/core/ioctl32/rawmidi32.c b/sound/core/ioctl32/rawmidi32.c
--- a/sound/core/ioctl32/rawmidi32.c	Sun Sep 29 20:18:57 2002
+++ b/sound/core/ioctl32/rawmidi32.c	Sun Sep 29 20:18:57 2002
@@ -30,9 +30,9 @@
 	s32 stream;
 	u32 buffer_size;
 	u32 avail_min;
-	unsigned int no_active_sensing: 1;
+	unsigned int no_active_sensing; /* avoid bit-field */
 	unsigned char reserved[16];
-};
+} __attribute__((packed));
 
 #define CVT_sndrv_rawmidi_params()\
 {\
@@ -45,7 +45,7 @@
 struct timeval32 {
 	s32 tv_sec;
 	s32 tv_usec;
-};
+} __attribute__((packed));
 
 struct sndrv_rawmidi_status32 {
 	s32 stream;
@@ -53,7 +53,7 @@
 	u32 avail;
 	u32 xruns;
 	unsigned char reserved[16];
-};
+} __attribute__((packed));
 
 #define CVT_sndrv_rawmidi_status()\
 {\
@@ -67,6 +67,8 @@
 DEFINE_ALSA_IOCTL(rawmidi_params);
 DEFINE_ALSA_IOCTL(rawmidi_status);
 
+DEFINE_ALSA_IOCTL_ENTRY(rawmidi_params, rawmidi_params, SNDRV_RAWMIDI_IOCTL_PARAMS);
+DEFINE_ALSA_IOCTL_ENTRY(rawmidi_status, rawmidi_status, SNDRV_RAWMIDI_IOCTL_STATUS);
 
 #define AP(x) snd_ioctl32_##x
 
diff -Nru a/sound/core/ioctl32/seq32.c b/sound/core/ioctl32/seq32.c
--- a/sound/core/ioctl32/seq32.c	Sun Sep 29 20:18:57 2002
+++ b/sound/core/ioctl32/seq32.c	Sun Sep 29 20:18:57 2002
@@ -27,16 +27,67 @@
 #include <sound/asequencer.h>
 #include "ioctl32.h"
 
+struct sndrv_seq_port_info32 {
+	struct sndrv_seq_addr addr;	/* client/port numbers */
+	char name[64];			/* port name */
+
+	u32 capability;	/* port capability bits */
+	u32 type;		/* port type bits */
+	s32 midi_channels;		/* channels per MIDI port */
+	s32 midi_voices;		/* voices per MIDI port */
+	s32 synth_voices;		/* voices per SYNTH port */
+
+	s32 read_use;			/* R/O: subscribers for output (from this port) */
+	s32 write_use;			/* R/O: subscribers for input (to this port) */
+
+	u32 kernel;			/* reserved for kernel use (must be NULL) */
+	u32 flags;		/* misc. conditioning */
+	char reserved[60];		/* for future use */
+};
+
+#define CVT_sndrv_seq_port_info()\
+{\
+	COPY(addr);\
+	memcpy(dst->name, src->name, sizeof(dst->name));\
+	COPY(capability);\
+	COPY(type);\
+	COPY(midi_channels);\
+	COPY(midi_voices);\
+	COPY(synth_voices);\
+	COPY(read_use);\
+	COPY(write_use);\
+	COPY(flags);\
+}
+
+DEFINE_ALSA_IOCTL(seq_port_info);
+DEFINE_ALSA_IOCTL_ENTRY(create_port, seq_port_info, SNDRV_SEQ_IOCTL_CREATE_PORT);
+DEFINE_ALSA_IOCTL_ENTRY(delete_port, seq_port_info, SNDRV_SEQ_IOCTL_DELETE_PORT);
+DEFINE_ALSA_IOCTL_ENTRY(get_port_info, seq_port_info, SNDRV_SEQ_IOCTL_GET_PORT_INFO);
+DEFINE_ALSA_IOCTL_ENTRY(set_port_info, seq_port_info, SNDRV_SEQ_IOCTL_SET_PORT_INFO);
+DEFINE_ALSA_IOCTL_ENTRY(query_next_port, seq_port_info, SNDRV_SEQ_IOCTL_QUERY_NEXT_PORT);
+
+/*
+ */
+#define AP(x) snd_ioctl32_##x
+
+enum {
+  SNDRV_SEQ_IOCTL_CREATE_PORT32 = _IOWR('S', 0x20, struct sndrv_seq_port_info32),
+  SNDRV_SEQ_IOCTL_DELETE_PORT32 = _IOW ('S', 0x21, struct sndrv_seq_port_info32),
+  SNDRV_SEQ_IOCTL_GET_PORT_INFO32 = _IOWR('S', 0x22, struct sndrv_seq_port_info32),
+  SNDRV_SEQ_IOCTL_SET_PORT_INFO32 = _IOW ('S', 0x23, struct sndrv_seq_port_info32),
+  SNDRV_SEQ_IOCTL_QUERY_NEXT_PORT32 = _IOWR('S', 0x52, struct sndrv_seq_port_info32),
+};
+
 struct ioctl32_mapper seq_mappers[] = {
 	{ SNDRV_SEQ_IOCTL_PVERSION, NULL },
 	{ SNDRV_SEQ_IOCTL_CLIENT_ID, NULL },
 	{ SNDRV_SEQ_IOCTL_SYSTEM_INFO, NULL },
 	{ SNDRV_SEQ_IOCTL_GET_CLIENT_INFO, NULL },
 	{ SNDRV_SEQ_IOCTL_SET_CLIENT_INFO, NULL },
-	{ SNDRV_SEQ_IOCTL_CREATE_PORT, NULL },
-	{ SNDRV_SEQ_IOCTL_DELETE_PORT, NULL },
-	{ SNDRV_SEQ_IOCTL_GET_PORT_INFO, NULL },
-	{ SNDRV_SEQ_IOCTL_SET_PORT_INFO, NULL },
+	{ SNDRV_SEQ_IOCTL_CREATE_PORT32, AP(create_port) },
+	{ SNDRV_SEQ_IOCTL_DELETE_PORT32, AP(delete_port) },
+	{ SNDRV_SEQ_IOCTL_GET_PORT_INFO32, AP(get_port_info) },
+	{ SNDRV_SEQ_IOCTL_SET_PORT_INFO32, AP(set_port_info) },
 	{ SNDRV_SEQ_IOCTL_SUBSCRIBE_PORT, NULL },
 	{ SNDRV_SEQ_IOCTL_UNSUBSCRIBE_PORT, NULL },
 	{ SNDRV_SEQ_IOCTL_CREATE_QUEUE, NULL },
@@ -47,8 +98,6 @@
 	{ SNDRV_SEQ_IOCTL_GET_QUEUE_STATUS, NULL },
 	{ SNDRV_SEQ_IOCTL_GET_QUEUE_TEMPO, NULL },
 	{ SNDRV_SEQ_IOCTL_SET_QUEUE_TEMPO, NULL },
-	{ SNDRV_SEQ_IOCTL_GET_QUEUE_OWNER, NULL },
-	{ SNDRV_SEQ_IOCTL_SET_QUEUE_OWNER, NULL },
 	{ SNDRV_SEQ_IOCTL_GET_QUEUE_TIMER, NULL },
 	{ SNDRV_SEQ_IOCTL_SET_QUEUE_TIMER, NULL },
 	{ SNDRV_SEQ_IOCTL_GET_QUEUE_CLIENT, NULL },
@@ -59,6 +108,7 @@
 	{ SNDRV_SEQ_IOCTL_QUERY_SUBS, NULL },
 	{ SNDRV_SEQ_IOCTL_GET_SUBSCRIPTION, NULL },
 	{ SNDRV_SEQ_IOCTL_QUERY_NEXT_CLIENT, NULL },
-	{ SNDRV_SEQ_IOCTL_QUERY_NEXT_PORT, NULL },
+	{ SNDRV_SEQ_IOCTL_QUERY_NEXT_PORT32, AP(query_next_port) },
+	{ SNDRV_SEQ_IOCTL_RUNNING_MODE, NULL },
 	{ 0 },
 };
diff -Nru a/sound/core/ioctl32/timer32.c b/sound/core/ioctl32/timer32.c
--- a/sound/core/ioctl32/timer32.c	Sun Sep 29 20:18:57 2002
+++ b/sound/core/ioctl32/timer32.c	Sun Sep 29 20:18:57 2002
@@ -73,6 +73,8 @@
 DEFINE_ALSA_IOCTL(timer_info);
 DEFINE_ALSA_IOCTL(timer_status);
 
+DEFINE_ALSA_IOCTL_ENTRY(timer_info, timer_info, SNDRV_TIMER_IOCTL_INFO);
+DEFINE_ALSA_IOCTL_ENTRY(timer_status, timer_status, SNDRV_TIMER_IOCTL_STATUS);
 
 /*
  */
diff -Nru a/sound/core/memory.c b/sound/core/memory.c
--- a/sound/core/memory.c	Sun Sep 29 20:18:57 2002
+++ b/sound/core/memory.c	Sun Sep 29 20:18:57 2002
@@ -439,7 +439,7 @@
 		size_t c = count;
 		if (c > sizeof(buf))
 			c = sizeof(buf);
-		memcpy_fromio(buf, src, c);
+		memcpy_fromio(buf, (void*)src, c);
 		if (copy_to_user(dst, buf, c))
 			return -EFAULT;
 		count -= c;
@@ -462,7 +462,7 @@
 			c = sizeof(buf);
 		if (copy_from_user(buf, src, c))
 			return -EFAULT;
-		memcpy_toio(dst, buf, c);
+		memcpy_toio((void*)dst, buf, c);
 		count -= c;
 		dst += c;
 		src += c;
@@ -484,7 +484,7 @@
  */
 #ifdef __i386__
 #define get_phys_addr(x) virt_to_phys(x)
-#else /* ppc */
+#else /* ppc and x86-64 */
 #define get_phys_addr(x) virt_to_bus(x)
 #endif
 void *snd_pci_hack_alloc_consistent(struct pci_dev *hwdev, size_t size,
diff -Nru a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
--- a/sound/core/seq/seq_clientmgr.c	Sun Sep 29 20:18:57 2002
+++ b/sound/core/seq/seq_clientmgr.c	Sun Sep 29 20:18:57 2002
@@ -37,6 +37,9 @@
 #include "seq_info.h"
 #include "seq_system.h"
 #include <sound/seq_device.h>
+#if defined(CONFIG_SND_BIT32_EMUL) || defined(CONFIG_SND_BIT32_EMUL_MODULE)
+#include "../ioctl32/ioctl32.h"
+#endif
 
 /* Client Manager
 
@@ -1018,6 +1021,13 @@
 			event.data.ext.len = extlen | SNDRV_SEQ_EXT_USRPTR;
 			event.data.ext.ptr = (char*)buf + sizeof(snd_seq_event_t);
 			len += extlen; /* increment data length */
+		} else {
+#if defined(CONFIG_SND_BIT32_EMUL) || defined(CONFIG_SND_BIT32_EMUL_MODULE)
+			if (client->convert32 && snd_seq_ev_is_varusr(&event)) {
+				void *ptr = (void*)A(event.data.raw32.d[1]);
+				event.data.ext.ptr = ptr;
+			}
+#endif
 		}
 
 		/* ok, enqueue it */
@@ -1092,6 +1102,43 @@
 }
 
 
+/* RUNNING_MODE ioctl() */
+static int snd_seq_ioctl_running_mode(client_t *client, unsigned long arg)
+{
+	struct sndrv_seq_running_info info;
+	client_t *cptr;
+	int err = 0;
+
+	if (copy_from_user(&info, (void*)arg, sizeof(info)))
+		return -EFAULT;
+
+	/* requested client number */
+	cptr = snd_seq_client_use_ptr(info.client);
+	if (cptr == NULL)
+		return -ENOENT;		/* don't change !!! */
+
+#ifdef SNDRV_BIG_ENDIAN
+	if (! info.big_endian) {
+		err = -EINVAL;
+		goto __err;
+	}
+#else
+	if (info.big_endian) {
+		err = -EINVAL;
+		goto __err;
+	}
+
+#endif
+	if (info.cpu_mode > sizeof(long)) {
+		err = -EINVAL;
+		goto __err;
+	}
+	cptr->convert32 = (info.cpu_mode < sizeof(long));
+ __err:
+	snd_seq_client_unlock(cptr);
+	return err;
+}
+
 /* CLIENT_INFO ioctl() */
 static void get_client_info(client_t *cptr, snd_seq_client_info_t *info)
 {
@@ -2042,6 +2089,7 @@
 	int (*func)(client_t *client, unsigned long arg);
 } ioctl_tables[] = {
 	{ SNDRV_SEQ_IOCTL_SYSTEM_INFO, snd_seq_ioctl_system_info },
+	{ SNDRV_SEQ_IOCTL_RUNNING_MODE, snd_seq_ioctl_running_mode },
 	{ SNDRV_SEQ_IOCTL_GET_CLIENT_INFO, snd_seq_ioctl_get_client_info },
 	{ SNDRV_SEQ_IOCTL_SET_CLIENT_INFO, snd_seq_ioctl_set_client_info },
 	{ SNDRV_SEQ_IOCTL_CREATE_PORT, snd_seq_ioctl_create_port },
diff -Nru a/sound/core/seq/seq_clientmgr.h b/sound/core/seq/seq_clientmgr.h
--- a/sound/core/seq/seq_clientmgr.h	Sun Sep 29 20:18:57 2002
+++ b/sound/core/seq/seq_clientmgr.h	Sun Sep 29 20:18:57 2002
@@ -61,6 +61,7 @@
 	struct list_head ports_list_head;
 	rwlock_t ports_lock;
 	struct semaphore ports_mutex;
+	int convert32;		/* convert 32->64bit */
 
 	/* output pool */
 	pool_t *pool;		/* memory pool for this client */
diff -Nru a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
--- a/sound/pci/intel8x0.c	Sun Sep 29 20:18:57 2002
+++ b/sound/pci/intel8x0.c	Sun Sep 29 20:18:57 2002
@@ -293,7 +293,7 @@
 	{ 0x8086, 0x7195, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL },	/* 440MX */
 	{ 0x1039, 0x7012, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_SIS },	/* SI7012 */
 	{ 0x10de, 0x01b1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL },	/* NFORCE */
-	{ 0x1022, 0x764d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL },	/* AMD8111 */
+	{ 0x1022, 0x746d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL },	/* AMD8111 */
 	{ 0x1022, 0x7445, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL },	/* AMD768 */
 	{ 0, }
 };
@@ -1233,7 +1233,10 @@
 	chip->playback.substream = NULL; /* don't process interrupts */
 
 	/* set rate */
-	snd_ac97_set_rate(chip->ac97, AC97_PCM_FRONT_DAC_RATE, 48000);
+	if (snd_ac97_set_rate(chip->ac97, AC97_PCM_FRONT_DAC_RATE, 48000) < 0) {
+		snd_printk(KERN_ERR "cannot set ac97 rate: clock = %d\n", chip->ac97->clock);
+		return;
+	}
 	snd_intel8x0_setup_periods(chip, &chip->playback);
 	port = chip->bmport + chip->playback.reg_offset;
 	spin_lock_irqsave(&chip->reg_lock, flags);
@@ -1412,7 +1415,7 @@
 	{ PCI_DEVICE_ID_INTEL_ICH4, "Intel 82801DB-ICH4" },
 	{ PCI_DEVICE_ID_SI_7012, "SiS SI7012" },
 	{ PCI_DEVICE_ID_NVIDIA_MCP_AUDIO, "NVidia NForce" },
-	{ 0x764d, "AMD AMD8111" },
+	{ 0x746d, "AMD AMD8111" },
 	{ 0x7445, "AMD AMD768" },
 	{ 0, 0 },
 };
diff -Nru a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
--- a/sound/pci/rme9652/hdsp.c	Sun Sep 29 20:18:57 2002
+++ b/sound/pci/rme9652/hdsp.c	Sun Sep 29 20:18:57 2002
@@ -25,6 +25,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/pcm.h>

===================================================================


This BitKeeper patch contains the following changesets:
1.605.4.1
## Wrapped with gzip_uu ##


begin 664 bkpatch2254
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
+.OL!"3V\?7YE````
`
end

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

