Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932618AbWHFHez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbWHFHez (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 03:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWHFHdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 03:33:22 -0400
Received: from mx-outbound.sourceforge.net ([66.35.250.223]:33957 "EHLO
	sc8-sf-sshgate.sourceforge.net") by vger.kernel.org with ESMTP
	id S932549AbWHFHdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 03:33:05 -0400
From: Shem Multinymous <multinymous@gmail.com>
To: Robert Love <rlove@rlove.org>
Cc: Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: [PATCH 09/12] hdaps: Add new sysfs attributes
Reply-To: Shem Multinymous <multinymous@gmail.com>
Date: Sun, 06 Aug 2006 10:26:54 +0300
Message-Id: <11548492882249-git-send-email-multinymous@gmail.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11548492171301-git-send-email-multinymous@gmail.com>
References: <11548492171301-git-send-email-multinymous@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds 4 new r/w sysfs attributes to the hdaps driver:

/sys/devices/platform/hdaps/sampling_rate:
  This determines the frequency of hardware queries and input device updates.
  Default=50.
/sys/devices/platform/hdaps/oversampling_ratio:
  When set to X, the embedded controller is told to do physical accelerometer
  measurements at a rate that is X times higher than the rate at which
  the driver reads those measurements (i.e., X*sampling_rate). This
  reduces sample phase difference is, and useful for the running average
  filter (see next). Default=5
/sys/devices/platform/hdaps/running_avg_filter_order:
  When set to X, reported readouts will be the average of the last X physical
  accelerometer measurements. Current firmware allows 1<=X<=8. Setting to a
  high value decreases readout fluctuations. The averaging is handled
  by the embedded controller, so no CPU resources are used. Default=2.
/sys/devices/platform/hdaps/fake_data_mode:
  If set to 1, enables a test mode where the physical accelerometer readouts
  are replaced with an incrementing counter. This is useful for checking the
  regularity of the sampling interval and driver<->userspace communication,
  which is useful for development and testing of the hdapd userspace daemon.

Signed-off-by: Shem Multinymous <multinymous@gmail.com>
---
 hdaps.c |  110 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff -up a/drivers/hwmon/hdaps.c a/drivers/hwmon/hdaps.c
--- a/drivers/hwmon/hdaps.c
+++ a/drivers/hwmon/hdaps.c
@@ -495,6 +495,102 @@ static ssize_t hdaps_invert_store(struct
 	return count;
 }
 
+static ssize_t hdaps_sampling_rate_show(
+	struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", sampling_rate);
+}
+
+static ssize_t hdaps_sampling_rate_store(
+	struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+	int rate, ret;
+	if (sscanf(buf, "%d", &rate) != 1 || rate>HZ || rate<0) {
+		printk(KERN_WARNING 
+		       "must have 0<input_sampling_rate<=HZ=%d\n", HZ);
+		return -EINVAL;
+	}
+	ret = hdaps_set_ec_config(rate*oversampling_ratio,
+	                          running_avg_filter_order);
+	if (ret)
+		return ret;
+	sampling_rate = rate;
+	return count;
+}
+
+static ssize_t hdaps_oversampling_ratio_show(
+	struct device *dev, struct device_attribute *attr, char *buf)
+{
+	int ec_rate, order;
+	int ret = hdaps_get_ec_config(&ec_rate, &order);
+	if (ret)
+		return ret;
+	return sprintf(buf, "%u\n", ec_rate / sampling_rate);
+}
+
+static ssize_t hdaps_oversampling_ratio_store(
+	struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+	int ratio, ret;
+	if (sscanf(buf, "%d", &ratio) != 1 || ratio<1)
+		return -EINVAL;
+	ret = hdaps_set_ec_config(sampling_rate*ratio, 
+	                          running_avg_filter_order);
+	if (ret)
+		return ret;
+	oversampling_ratio = ratio;
+	return count;
+}
+
+static ssize_t hdaps_running_avg_filter_order_show(
+	struct device *dev, struct device_attribute *attr, char *buf)
+{
+	int rate, order;
+	int ret = hdaps_get_ec_config(&rate, &order);
+	if (ret)
+		return ret;
+	return sprintf(buf, "%u\n", order);
+}
+
+static ssize_t hdaps_running_avg_filter_order_store(
+	struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+	int order, ret;
+	if (sscanf(buf, "%d", &order) != 1)
+		return -EINVAL;
+	ret = hdaps_set_ec_config(sampling_rate*oversampling_ratio, order);
+	if (ret)
+		return ret;
+	running_avg_filter_order = order;
+	return count;
+}
+
+static ssize_t hdaps_fake_data_mode_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	int on, ret;
+	if (sscanf(buf, "%d", &on) != 1 || on<0 || on>1) {
+		printk(KERN_WARNING
+		       "fake_data should be 0 or 1\n");
+		return -EINVAL;
+	}
+	ret = hdaps_set_fake_data_mode(on);
+	if (ret)
+		return ret;
+	fake_data_mode = on;
+	return count;
+}
+
+static ssize_t hdaps_fake_data_mode_show(
+	struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", fake_data_mode);
+}
+
 static DEVICE_ATTR(position, 0444, hdaps_position_show, NULL);
 static DEVICE_ATTR(temp1, 0444, hdaps_temp1_show, NULL);
   /* "temp1" instead of "temperature" is hwmon convention */
@@ -502,6 +598,16 @@ static DEVICE_ATTR(keyboard_activity, 04
 static DEVICE_ATTR(mouse_activity, 0444, hdaps_mouse_activity_show, NULL);
 static DEVICE_ATTR(calibrate, 0644, hdaps_calibrate_show,hdaps_calibrate_store);
 static DEVICE_ATTR(invert, 0644, hdaps_invert_show, hdaps_invert_store);
+static DEVICE_ATTR(sampling_rate, 0644,
+		hdaps_sampling_rate_show, hdaps_sampling_rate_store);
+static DEVICE_ATTR(oversampling_ratio, 0644,
+		   hdaps_oversampling_ratio_show,
+		   hdaps_oversampling_ratio_store);
+static DEVICE_ATTR(running_avg_filter_order, 0644,
+		hdaps_running_avg_filter_order_show,
+		hdaps_running_avg_filter_order_store);
+static DEVICE_ATTR(fake_data_mode, 0644,
+		   hdaps_fake_data_mode_show, hdaps_fake_data_mode_store);
 
 static struct attribute *hdaps_attributes[] = {
 	&dev_attr_position.attr,
@@ -510,6 +616,10 @@ static struct attribute *hdaps_attribute
 	&dev_attr_mouse_activity.attr,
 	&dev_attr_calibrate.attr,
 	&dev_attr_invert.attr,
+	&dev_attr_sampling_rate.attr,
+	&dev_attr_oversampling_ratio.attr,
+	&dev_attr_running_avg_filter_order.attr,
+	&dev_attr_fake_data_mode.attr,
 	NULL,
 };
 
