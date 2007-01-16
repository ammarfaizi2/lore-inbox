Return-Path: <linux-kernel-owner+w=401wt.eu-S932423AbXAPG2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbXAPG2W (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 01:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbXAPG2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 01:28:21 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:44262 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932422AbXAPG1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 01:27:52 -0500
Message-Id: <20070116063029.862885000@bull.net>
References: <20070116061516.899460000@bull.net>
User-Agent: quilt/0.45-1
Date: Tue, 16 Jan 2007 07:15:20 +0100
From: Nadia.Derbey@bull.net
To: linux-kernel@vger.kernel.org
Cc: Nadia Derbey <Nadia.Derbey@bull.net>
Subject: [RFC][PATCH 4/6] min and max kobjects
Content-Disposition: inline; filename=tunable_min_max_kobjects.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 04/06]


Introduces the kobjects associated to each tunable min and max value


Signed-off-by: Nadia Derbey <Nadia.Derbey@bull.net>


---
 include/linux/akt.h         |   30 ++++
 include/linux/akt_ops.h     |  311 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/autotune/akt.c       |  120 ++++++++++++++++
 kernel/autotune/akt_sysfs.c |    8 +
 4 files changed, 469 insertions(+)

Index: linux-2.6.20-rc4/include/linux/akt.h
===================================================================
--- linux-2.6.20-rc4.orig/include/linux/akt.h	2007-01-15 15:08:41.000000000 +0100
+++ linux-2.6.20-rc4/include/linux/akt.h	2007-01-15 15:21:47.000000000 +0100
@@ -62,6 +62,13 @@ struct tunable_kobject {
  * auto_tune structure.
  * These values are type dependent and are used as high / low boundaries when
  * tuning up or down.
+ * The show and store routines (thare are type dependent too) are here for
+ * sysfs support (since the min and max can be updated through sysfs).
+ * The abs_value field is used to check that we are not:
+ *   . falling under the very 1st min value when updating the min value
+ *     through sysfs
+ *   . going over the very 1st max value when updating the max value
+ *     through sysfs
  * The type is known when the tunable is defined (see DEFINE_TUNABLE macro).
  */
 struct typed_value {
@@ -74,6 +81,17 @@ struct typed_value {
 		long   val_long;
 		ulong  val_ulong;
 	} value;
+	union {
+		short  val_short;
+		ushort val_ushort;
+		int    val_int;
+		uint   val_uint;
+		size_t val_size_t;
+		long   val_long;
+		ulong  val_ulong;
+	} abs_value;
+	ssize_t (*show)(struct auto_tune *, char *);
+	ssize_t (*store)(struct auto_tune *, const char *, size_t);
 };
 
 
@@ -170,9 +188,15 @@ static inline int is_tunable_registered(
 		.threshold	= (_thresh),				\
 		.min	= {						\
 			.value		= { .val_##type = (_min), },	\
+			.abs_value	= { .val_##type = (_min), },	\
+			.show		= show_tunable_min_##type,	\
+			.store		= store_tunable_min_##type,	\
 		},							\
 		.max	= {						\
 			.value		= { .val_##type = (_max), },	\
+			.abs_value	= { .val_##type = (_max), },	\
+			.show		= show_tunable_max_##type,	\
+			.store		= store_tunable_max_##type,	\
 		},							\
 		.tun_kobj	= { .tun = NULL, },			\
 		.tunable	= (_tun),				\
@@ -186,7 +210,9 @@ static inline int is_tunable_registered(
 #define set_tunable_min_max(s, _min, _max, type)	\
 	do {						\
 		(s).min.value.val_##type = _min;	\
+		(s).min.abs_value.val_##type = _min;	\
 		(s).max.value.val_##type = _max;	\
+		(s).max.abs_value.val_##type = _max;	\
 	} while (0)
 
 
@@ -234,6 +260,10 @@ extern int unregister_tunable(struct aut
 extern int tunable_sysfs_setup(struct auto_tune *);
 extern ssize_t show_tuning_mode(struct auto_tune *, char *);
 extern ssize_t store_tuning_mode(struct auto_tune *, const char *, size_t);
+extern ssize_t show_tunable_min(struct auto_tune *, char *);
+extern ssize_t store_tunable_min(struct auto_tune *, const char *, size_t);
+extern ssize_t show_tunable_max(struct auto_tune *, char *);
+extern ssize_t store_tunable_max(struct auto_tune *, const char *, size_t);
 
 
 #else	/* CONFIG_AKT */
Index: linux-2.6.20-rc4/include/linux/akt_ops.h
===================================================================
--- linux-2.6.20-rc4.orig/include/linux/akt_ops.h	2007-01-15 14:28:16.000000000 +0100
+++ linux-2.6.20-rc4/include/linux/akt_ops.h	2007-01-15 15:22:53.000000000 +0100
@@ -182,5 +182,316 @@ static inline int default_auto_tuning_ul
 }
 
 
+/*
+ * member can be one of min / max
+ */
+#define __show_tunable_member(member, p, type, buf, format, y)	\
+do {								\
+	type _xx = (type) p->member.value.val_##type;		\
+								\
+	y = snprintf(buf, PAGE_SIZE, format "\n", _xx);		\
+} while (0)
+
+/*
+ * Show routines for the min and max tunables values
+ */
+static inline ssize_t show_tunable_min_short(struct auto_tune *p, char *buf)
+{
+	ssize_t _count;
+	__show_tunable_member(min, p, short, buf, "%d", _count);
+	return _count;
+}
+
+static inline ssize_t show_tunable_min_ushort(struct auto_tune *p, char *buf)
+{
+	ssize_t _count;
+	__show_tunable_member(min, p, ushort, buf, "%u", _count);
+	return _count;
+}
+
+static inline ssize_t show_tunable_min_int(struct auto_tune *p, char *buf)
+{
+	ssize_t _count;
+	__show_tunable_member(min, p, int, buf, "%d", _count);
+	return _count;
+}
+
+static inline ssize_t show_tunable_min_uint(struct auto_tune *p, char *buf)
+{
+	ssize_t _count;
+	__show_tunable_member(min, p, uint, buf, "%u", _count);
+	return _count;
+}
+
+static inline ssize_t show_tunable_min_size_t(struct auto_tune *p, char *buf)
+{
+	ssize_t _count;
+	__show_tunable_member(min, p, ulong, buf, "%lu", _count);
+	return _count;
+}
+
+static inline ssize_t show_tunable_min_long(struct auto_tune *p, char *buf)
+{
+	ssize_t _count;
+	__show_tunable_member(min, p, long, buf, "%ld", _count);
+	return _count;
+}
+
+static inline ssize_t show_tunable_min_ulong(struct auto_tune *p, char *buf)
+{
+	ssize_t _count;
+	__show_tunable_member(min, p, ulong, buf, "%lu", _count);
+	return _count;
+}
+
+static inline ssize_t show_tunable_max_short(struct auto_tune *p, char *buf)
+{
+	ssize_t _count;
+	__show_tunable_member(max, p, short, buf, "%d", _count);
+	return _count;
+}
+
+static inline ssize_t show_tunable_max_ushort(struct auto_tune *p, char *buf)
+{
+	ssize_t _count;
+	__show_tunable_member(max, p, ushort, buf, "%u", _count);
+	return _count;
+}
+
+static inline ssize_t show_tunable_max_int(struct auto_tune *p, char *buf)
+{
+	ssize_t _count;
+	__show_tunable_member(max, p, int, buf, "%d", _count);
+	return _count;
+}
+
+static inline ssize_t show_tunable_max_uint(struct auto_tune *p, char *buf)
+{
+	ssize_t _count;
+	__show_tunable_member(max, p, uint, buf, "%u", _count);
+	return _count;
+}
+
+static inline ssize_t show_tunable_max_size_t(struct auto_tune *p, char *buf)
+{
+	ssize_t _count;
+	__show_tunable_member(max, p, ulong, buf, "%lu", _count);
+	return _count;
+}
+
+static inline ssize_t show_tunable_max_long(struct auto_tune *p, char *buf)
+{
+	ssize_t _count;
+	__show_tunable_member(max, p, long, buf, "%ld", _count);
+	return _count;
+}
+
+static inline ssize_t show_tunable_max_ulong(struct auto_tune *p, char *buf)
+{
+	ssize_t _count;
+	__show_tunable_member(max, p, ulong, buf, "%lu", _count);
+	return _count;
+}
+
+
+/*
+ * when setting the min: we don't accept to fall under the absolute min
+ *                       (the very 1st one that has been set)
+ */
+#define __store_tunable_min(p, type, buf, y)				\
+do {									\
+	long _vv;							\
+	char *_rr;							\
+									\
+	_vv = simple_strtol(buf, &_rr, 0);				\
+	if (_rr == buf)							\
+		y = -EINVAL;						\
+	else {								\
+		if (_vv >= p->min.abs_value.val_##type &&		\
+				_vv < p->max.value.val_##type) {	\
+			p->min.value.val_##type = _vv;			\
+			y = _rr - buf;					\
+		} else							\
+			y = -EINVAL;					\
+	}								\
+} while (0)
+
+#define __store_tunable_umin(p, type, buf, y)				\
+do {									\
+	ulong _vv;							\
+	char *_rr;							\
+									\
+	_vv = simple_strtoul(buf, &_rr, 0);				\
+	if (_rr == buf)							\
+		y = -EINVAL;						\
+	else {								\
+		if (_vv >= p->min.abs_value.val_##type &&		\
+				_vv < p->max.value.val_##type) {	\
+			p->min.value.val_##type = _vv;			\
+			y = _rr - buf;					\
+		} else							\
+			y = -EINVAL;					\
+	}								\
+} while (0)
+
+/*
+ * Store routines for the min tunables values
+ */
+static inline ssize_t store_tunable_min_short(struct auto_tune *p,
+					const char *buf, size_t count)
+{
+	ssize_t _count;
+	__store_tunable_min(p, short, buf, _count);
+	return _count;
+}
+
+static inline ssize_t store_tunable_min_ushort(struct auto_tune *p,
+					const char *buf, size_t count)
+{
+	ssize_t _count;
+	__store_tunable_umin(p, ushort, buf, _count);
+	return _count;
+}
+
+static inline ssize_t store_tunable_min_int(struct auto_tune *p,
+					const char *buf, size_t count)
+{
+	ssize_t _count;
+	__store_tunable_min(p, int, buf, _count);
+	return _count;
+}
+
+static inline ssize_t store_tunable_min_uint(struct auto_tune *p,
+					const char *buf, size_t count)
+{
+	ssize_t _count;
+	__store_tunable_umin(p, uint, buf, _count);
+	return _count;
+}
+
+static inline ssize_t store_tunable_min_size_t(struct auto_tune *p,
+					const char *buf, size_t count)
+{
+	ssize_t _count;
+	__store_tunable_umin(p, size_t, buf, _count);
+	return _count;
+}
+
+static inline ssize_t store_tunable_min_long(struct auto_tune *p,
+					const char *buf, size_t count)
+{
+	ssize_t _count;
+	__store_tunable_min(p, long, buf, _count);
+	return _count;
+}
+
+static inline ssize_t store_tunable_min_ulong(struct auto_tune *p,
+					const char *buf, size_t count)
+{
+	ssize_t _count;
+	__store_tunable_umin(p, ulong, buf, _count);
+	return _count;
+}
+
+
+/*
+ * when setting the max: we don't accept to go over the absolute max
+ *                       (the very 1st one that has been set)
+ *
+ */
+#define __store_tunable_max(p, type, buf, y)				\
+do {									\
+	long _vv;							\
+	char *_rr;							\
+									\
+	_vv = simple_strtol(buf, &_rr, 0);				\
+	if (_rr == buf)							\
+		y = -EINVAL;						\
+	else {								\
+		if (_vv <= p->max.abs_value.val_##type &&		\
+				_vv > p->min.value.val_##type) {	\
+			p->max.value.val_##type = _vv;			\
+			y = _rr - buf;					\
+		} else							\
+			y = -EINVAL;					\
+	}								\
+} while (0)
+
+#define __store_tunable_umax(p, type, buf, y)				\
+do {									\
+	ulong _vv;							\
+	char *_rr;							\
+									\
+	_vv = simple_strtoul(buf, &_rr, 0);				\
+	if (_rr == buf)							\
+		y = -EINVAL;						\
+	else {								\
+		if (_vv <= p->max.abs_value.val_##type &&		\
+				_vv > p->min.value.val_##type) {	\
+			p->max.value.val_##type = _vv;			\
+			y = _rr - buf;					\
+		} else							\
+			y = -EINVAL;					\
+	}								\
+} while (0)
+
+/*
+ * Store routines for the max tunables values
+ */
+static inline ssize_t store_tunable_max_short(struct auto_tune *p,
+					const char *buf, size_t count)
+{
+	ssize_t _count;
+	__store_tunable_umax(p, short, buf, _count);
+	return _count;
+}
+
+static inline ssize_t store_tunable_max_ushort(struct auto_tune *p,
+					const char *buf, size_t count)
+{
+	ssize_t _count;
+	__store_tunable_umax(p, ushort, buf, _count);
+	return _count;
+}
+
+static inline ssize_t store_tunable_max_int(struct auto_tune *p,
+					const char *buf, size_t count)
+{
+	ssize_t _count;
+	__store_tunable_max(p, int, buf, _count);
+	return _count;
+}
+
+static inline ssize_t store_tunable_max_uint(struct auto_tune *p,
+					const char *buf, size_t count)
+{
+	ssize_t _count;
+	__store_tunable_umax(p, uint, buf, _count);
+	return _count;
+}
+
+static inline ssize_t store_tunable_max_size_t(struct auto_tune *p,
+					const char *buf, size_t count)
+{
+	ssize_t _count;
+	__store_tunable_umax(p, size_t, buf, _count);
+	return _count;
+}
+
+static inline ssize_t store_tunable_max_long(struct auto_tune *p,
+					const char *buf, size_t count)
+{
+	ssize_t _count;
+	__store_tunable_max(p, long, buf, _count);
+	return _count;
+}
+
+static inline ssize_t store_tunable_max_ulong(struct auto_tune *p,
+					const char *buf, size_t count)
+{
+	ssize_t _count;
+	__store_tunable_umax(p, ulong, buf, _count);
+	return _count;
+}
 
 #endif /* AKT_OPS_H */
Index: linux-2.6.20-rc4/kernel/autotune/akt.c
===================================================================
--- linux-2.6.20-rc4.orig/kernel/autotune/akt.c	2007-01-15 15:13:31.000000000 +0100
+++ linux-2.6.20-rc4/kernel/autotune/akt.c	2007-01-15 15:25:35.000000000 +0100
@@ -28,6 +28,10 @@
  *              unregister_tunable         (exported)
  *              show_tuning_mode           (exported)
  *              store_tuning_mode          (exported)
+ *              show_tunable_min           (exported)
+ *              store_tunable_min          (exported)
+ *              show_tunable_max           (exported)
+ *              store_tunable_max          (exported)
  */
 
 #include <linux/init.h>
@@ -203,5 +207,121 @@ ssize_t store_tuning_mode(struct auto_tu
 }
 
 
+/*
+ * FUNCTION:    Get operation called by tunable_attr_show (i.e. when the file
+ *              /sys/tunables/<tunable>/min is displayed).
+ *              Outputs the current tunable minimum value
+ *
+ * RETURN VALUE: >0 : output string length (including the '\0')
+ *               <0 : failure
+ */
+ssize_t show_tunable_min(struct auto_tune *tun_addr, char *buf)
+{
+	ssize_t rc;
+
+	if (tun_addr == NULL) {
+		printk(KERN_ERR
+			" show_tunable_min(): tunable address is invalid\n");
+		return -EINVAL;
+	}
+
+	spin_lock(&tun_addr->tunable_lck);
+
+	rc = tun_addr->min.show(tun_addr, buf);
+
+	spin_unlock(&tun_addr->tunable_lck);
+
+	return rc;
+}
+
+
+/*
+ * FUNCTION:    Set operation called by tunable_attr_store (i.e. when a
+ *              string is stored into /sys/tunables/<tunable>/min).
+ *
+ * PARAMETERS:  count: input buffer size (including the '\0')
+ *
+ * RETURN VALUE: >0: number of characters used from the input buffer
+ *               <= 0: failure
+ */
+ssize_t store_tunable_min(struct auto_tune *tun_addr, const char *buf,
+			size_t count)
+{
+	ssize_t rc;
+
+	if (tun_addr == NULL) {
+		printk(KERN_ERR
+			" store_tunable_min(): tunable address is invalid\n");
+		return -EINVAL;
+	}
+
+	spin_lock(&tun_addr->tunable_lck);
+
+	rc = tun_addr->min.store(tun_addr, buf, count);
+
+	spin_unlock(&tun_addr->tunable_lck);
+
+	return rc;
+}
+
+
+/*
+ * FUNCTION:    Get operation called by tunable_attr_show (i.e. when the file
+ *              /sys/tunables/<tunable>/max is displayed).
+ *              Outputs the current tunable maximum value
+ *
+ * RETURN VALUE: >0 : output string length (including the '\0')
+ *               <0 : failure
+ */
+ssize_t show_tunable_max(struct auto_tune *tun_addr, char *buf)
+{
+	ssize_t rc;
+
+	if (tun_addr == NULL) {
+		printk(KERN_ERR
+			" show_tunable_max(): tunable address is invalid\n");
+		return -EINVAL;
+	}
+
+	spin_lock(&tun_addr->tunable_lck);
+
+	rc = tun_addr->max.show(tun_addr, buf);
+
+	spin_unlock(&tun_addr->tunable_lck);
+
+	return rc;
+}
+
+
+/*
+ * FUNCTION:    Set operation called by tunable_attr_store (i.e. when a
+ *              string is stored into /sys/tunables/<tunable>/max).
+ *
+ * PARAMETERS:  count: input buffer size (including the '\0')
+ *
+ * RETURN VALUE: >0: number of characters used from the input buffer
+ *               <= 0: failure
+ */
+ssize_t store_tunable_max(struct auto_tune *tun_addr, const char *buf,
+			size_t count)
+{
+	ssize_t rc;
+
+	if (tun_addr == NULL) {
+		printk(KERN_ERR
+			" store_tunable_max(): tunable address is invalid\n");
+		return -EINVAL;
+	}
+
+	spin_lock(&tun_addr->tunable_lck);
+
+	rc = tun_addr->max.store(tun_addr, buf, count);
+
+	spin_unlock(&tun_addr->tunable_lck);
+
+	return rc;
+}
+
+
 EXPORT_SYMBOL_GPL(register_tunable);
 EXPORT_SYMBOL_GPL(unregister_tunable);
Index: linux-2.6.20-rc4/kernel/autotune/akt_sysfs.c
===================================================================
--- linux-2.6.20-rc4.orig/kernel/autotune/akt_sysfs.c	2007-01-15 15:14:55.000000000 +0100
+++ linux-2.6.20-rc4/kernel/autotune/akt_sysfs.c	2007-01-15 15:26:31.000000000 +0100
@@ -54,8 +54,16 @@ struct tunable_attribute tun_attr_##_nam
 static TUNABLE_ATTR(autotune, S_IWUSR | S_IRUGO, show_tuning_mode,
 		store_tuning_mode);
 
+static TUNABLE_ATTR(min, S_IWUSR | S_IRUGO, show_tunable_min,
+		store_tunable_min);
+
+static TUNABLE_ATTR(max, S_IWUSR | S_IRUGO, show_tunable_max,
+		store_tunable_max);
+
 static struct tunable_attribute *tunable_sysfs_attrs[] = {
 	&tun_attr_autotune,	/* to (de)activate auto tuning */
+	&tun_attr_min,		/* to play with the tunable min value */
+	&tun_attr_max,		/* to play with the tunable max value */
 	NULL,
 };
 

--
