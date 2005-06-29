Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262695AbVF2Whz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbVF2Whz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 18:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbVF2Whz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 18:37:55 -0400
Received: from fmr20.intel.com ([134.134.136.19]:29652 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262695AbVF2WgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 18:36:12 -0400
Date: Wed, 29 Jun 2005 15:35:40 -0700
From: Rusty Lynch <rusty@linux.intel.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Jeff Chua <jeffchua@silk.corp.fedex.com>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       "'Arjan van de Ven'" <arjan@infradead.org>,
       "'Jeff Chua'" <jeff96@silk.corp.fedex.com>,
       ipw2100-devel@lists.sourceforge.net,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: [Ipw2100-devel] Re: ipw2200 can't compile under linux 2.6.13-rc1
Message-ID: <20050629223540.GA22949@linux.jf.intel.com>
References: <jeffchua@silk.corp.fedex.com> <Pine.LNX.4.63.0506292209050.6581@boston.corp.fedex.com> <200506291655.j5TGtpkX011008@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506291655.j5TGtpkX011008@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 12:55:51PM -0400, Horst von Brand wrote:
> Jeff Chua <jeffchua@silk.corp.fedex.com> wrote:
> 
> [...]
> 
> > All the ipw2200 files has ...
> > 
> >  	#include <net/ieee80211.h>
> > 
> > and that points to the new linux header in
> > /usr/src/linux/include/net/ieee80211.h instead of the local include
> > file under the ipw2200/net directory.
> > 
> > I've modified all ipw2200 files to #include "net/ieee80211.h" and now
> > it compiles ok.
> 
> No, it doesn't. The warnings are about /function pointers/ that have the
> wrong type (this comes from an earlier 2.6.12-git). AFAICS, this is due to
> a change in device handling, and as long as this isn't fixed, I won't even
> try to load the module.
> 
> Just need a little time to decrypt this macro mess...
> 
> And again, shouldn't we push for the header here going into the kernel? Or
> fix up the code to work with the kernel version? The current situation
> isn't confortable at all.

The prototype for the driver show and store functions has a new argument,
struct device_attribute *.  Here is a patch that adds the argument for the
many device files that the ipw2200 has.

    --rusty

 ipw2200.c |   95 +++++++++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 63 insertions(+), 32 deletions(-)

Index: ipw2200-1.0.4/ipw2200.c
===================================================================
--- ipw2200-1.0.4.orig/ipw2200.c
+++ ipw2200-1.0.4/ipw2200.c
@@ -1071,7 +1071,8 @@ static DRIVER_ATTR(debug_level, S_IWUSR 
 
 #define STAT_PRINT(b, x, y) sprintf(b, # x ": " y "\n", priv->x);
 
-static ssize_t show_stats(struct device *d, char *buf)
+static ssize_t show_stats(struct device *d, struct device_attribute *attr,
+			  char *buf)
 {
 	struct ipw_priv *priv = dev_get_drvdata(d);
 	u32 len = 0;
@@ -1081,13 +1082,15 @@ static ssize_t show_stats(struct device 
 static DEVICE_ATTR(stats, S_IRUGO, show_stats, NULL);
 
 
-static ssize_t show_scan_age(struct device *d, char *buf)
+static ssize_t show_scan_age(struct device *d, struct device_attribute *attr,
+			     char *buf)
 {
 	struct ipw_priv *priv = dev_get_drvdata(d);
 	return sprintf(buf, "%d\n", priv->ieee->scan_age);
 }
 
-static ssize_t store_scan_age(struct device *d, const char *buf, size_t count)
+static ssize_t store_scan_age(struct device *d, struct device_attribute *attr,
+			      const char *buf, size_t count)
 {
 	struct ipw_priv *priv = dev_get_drvdata(d);
 #ifdef CONFIG_IPW_DEBUG
@@ -1124,13 +1127,15 @@ static ssize_t store_scan_age(struct dev
 }
 static DEVICE_ATTR(scan_age, S_IWUSR | S_IRUGO, show_scan_age, store_scan_age);
 
-static ssize_t show_led(struct device *d, char *buf)
+static ssize_t show_led(struct device *d, struct device_attribute *attr,
+			char *buf)
 {
 	struct ipw_priv *priv = dev_get_drvdata(d);
 	return sprintf(buf, "%d\n", (priv->config & CFG_NO_LED) ? 0 : 1);
 }
 
-static ssize_t store_led(struct device *d, const char *buf, size_t count)
+static ssize_t store_led(struct device *d, struct device_attribute *attr,
+			 const char *buf, size_t count)
 {
 	struct ipw_priv *priv = dev_get_drvdata(d);
 
@@ -1155,21 +1160,24 @@ static ssize_t store_led(struct device *
 static DEVICE_ATTR(led, S_IWUSR | S_IRUGO, show_led, store_led);
 
 
-static ssize_t show_status(struct device *d, char *buf)
+static ssize_t show_status(struct device *d, struct device_attribute *attr,
+			   char *buf)
 {
 	struct ipw_priv *p = (struct ipw_priv *)d->driver_data;
 	return sprintf(buf, "0x%08x\n", (int)p->status);
 }
 static DEVICE_ATTR(status, S_IRUGO, show_status, NULL);
 
-static ssize_t show_cfg(struct device *d, char *buf)
+static ssize_t show_cfg(struct device *d, struct device_attribute *attr,
+			char *buf)
 {
 	struct ipw_priv *p = (struct ipw_priv *)d->driver_data;
 	return sprintf(buf, "0x%08x\n", (int)p->config);
 }
 static DEVICE_ATTR(cfg, S_IRUGO, show_cfg, NULL);
 
-static ssize_t show_nic_type(struct device *d, char *buf)
+static ssize_t show_nic_type(struct device *d, struct device_attribute *attr,
+			     char *buf)
 {
 	struct ipw_priv *priv = (struct ipw_priv *)d->driver_data;
 
@@ -1177,8 +1185,8 @@ static ssize_t show_nic_type(struct devi
 }
 static DEVICE_ATTR(nic_type, S_IRUGO, show_nic_type, NULL);
 
-static ssize_t dump_error_log(struct device *d, const char *buf,
-			      size_t count)
+static ssize_t dump_error_log(struct device *d, struct device_attribute *attr,
+			      const char *buf, size_t count)
 {
 	char *p = (char *)buf;
 
@@ -1189,8 +1197,8 @@ static ssize_t dump_error_log(struct dev
 }
 static DEVICE_ATTR(dump_errors, S_IWUSR, NULL, dump_error_log);
 
-static ssize_t dump_event_log(struct device *d, const char *buf,
-			      size_t count)
+static ssize_t dump_event_log(struct device *d, struct device_attribute *attr,
+			      const char *buf, size_t count)
 {
 	char *p = (char *)buf;
 
@@ -1201,7 +1209,8 @@ static ssize_t dump_event_log(struct dev
 }
 static DEVICE_ATTR(dump_events, S_IWUSR, NULL, dump_event_log);
 
-static ssize_t show_ucode_version(struct device *d, char *buf)
+static ssize_t show_ucode_version(struct device *d,
+				  struct device_attribute *attr, char *buf)
 {
 	u32 len = sizeof(u32), tmp = 0;
 	struct ipw_priv *p = (struct ipw_priv*)d->driver_data;
@@ -1213,7 +1222,8 @@ static ssize_t show_ucode_version(struct
 }
 static DEVICE_ATTR(ucode_version, S_IWUSR|S_IRUGO, show_ucode_version, NULL);
 
-static ssize_t show_rtc(struct device *d, char *buf)
+static ssize_t show_rtc(struct device *d, struct device_attribute *attr,
+			char *buf)
 {
 	u32 len = sizeof(u32), tmp = 0;
 	struct ipw_priv *p = (struct ipw_priv*)d->driver_data;
@@ -1229,13 +1239,15 @@ static DEVICE_ATTR(rtc, S_IWUSR|S_IRUGO,
  * Add a device attribute to view/control the delay between eeprom
  * operations.
  */
-static ssize_t show_eeprom_delay(struct device *d, char *buf)
+static ssize_t show_eeprom_delay(struct device *d,
+				 struct device_attribute *attr, char *buf)
 {
 	int n = ((struct ipw_priv*)d->driver_data)->eeprom_delay;
 	return sprintf(buf, "%i\n", n);
 }
-static ssize_t store_eeprom_delay(struct device *d, const char *buf,
-				  size_t count)
+static ssize_t store_eeprom_delay(struct device *d,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
 {
 	struct ipw_priv *p = (struct ipw_priv*)d->driver_data;
 	sscanf(buf, "%i", &p->eeprom_delay);
@@ -1244,7 +1256,9 @@ static ssize_t store_eeprom_delay(struct
 static DEVICE_ATTR(eeprom_delay, S_IWUSR|S_IRUGO,
 		   show_eeprom_delay,store_eeprom_delay);
 
-static ssize_t show_command_event_reg(struct device *d, char *buf)
+static ssize_t show_command_event_reg(struct device *d,
+				      struct device_attribute *attr,
+				      char *buf)
 {
 	u32 reg = 0;
 	struct ipw_priv *p = (struct ipw_priv *)d->driver_data;
@@ -1253,6 +1267,7 @@ static ssize_t show_command_event_reg(st
 	return sprintf(buf, "0x%08x\n", reg);
 }
 static ssize_t store_command_event_reg(struct device *d,
+				       struct device_attribute *attr,
 				       const char *buf,
 				       size_t count)
 {
@@ -1266,7 +1281,9 @@ static ssize_t store_command_event_reg(s
 static DEVICE_ATTR(command_event_reg, S_IWUSR|S_IRUGO,
 		   show_command_event_reg,store_command_event_reg);
 
-static ssize_t show_mem_gpio_reg(struct device *d, char *buf)
+static ssize_t show_mem_gpio_reg(struct device *d,
+				 struct device_attribute *attr,
+				 char *buf)
 {
 	u32 reg = 0;
 	struct ipw_priv *p = (struct ipw_priv *)d->driver_data;
@@ -1275,6 +1292,7 @@ static ssize_t show_mem_gpio_reg(struct 
 	return sprintf(buf, "0x%08x\n", reg);
 }
 static ssize_t store_mem_gpio_reg(struct device *d,
+				  struct device_attribute *attr,
 				  const char *buf,
 				  size_t count)
 {
@@ -1288,7 +1306,8 @@ static ssize_t store_mem_gpio_reg(struct
 static DEVICE_ATTR(mem_gpio_reg, S_IWUSR|S_IRUGO,
 		   show_mem_gpio_reg,store_mem_gpio_reg);
 
-static ssize_t show_indirect_dword(struct device *d, char *buf)
+static ssize_t show_indirect_dword(struct device *d,
+				   struct device_attribute *attr, char *buf)
 {
 	u32 reg = 0;
 	struct ipw_priv *priv = (struct ipw_priv *)d->driver_data;
@@ -1300,8 +1319,9 @@ static ssize_t show_indirect_dword(struc
 	return sprintf(buf, "0x%08x\n", reg);
 }
 static ssize_t store_indirect_dword(struct device *d,
-				   const char *buf,
-				   size_t count)
+				    struct device_attribute *attr,
+				    const char *buf,
+				    size_t count)
 {
 	struct ipw_priv *priv = (struct ipw_priv *)d->driver_data;
 
@@ -1312,7 +1332,8 @@ static ssize_t store_indirect_dword(stru
 static DEVICE_ATTR(indirect_dword, S_IWUSR|S_IRUGO,
 		   show_indirect_dword,store_indirect_dword);
 
-static ssize_t show_indirect_byte(struct device *d, char *buf)
+static ssize_t show_indirect_byte(struct device *d,
+				  struct device_attribute *attr, char *buf)
 {
 	u8 reg = 0;
 	struct ipw_priv *priv = (struct ipw_priv *)d->driver_data;
@@ -1324,6 +1345,7 @@ static ssize_t show_indirect_byte(struct
 	return sprintf(buf, "0x%02x\n", reg);
 }
 static ssize_t store_indirect_byte(struct device *d,
+				   struct device_attribute *attr,
 				   const char *buf,
 				   size_t count)
 {
@@ -1336,7 +1358,8 @@ static ssize_t store_indirect_byte(struc
 static DEVICE_ATTR(indirect_byte, S_IWUSR|S_IRUGO,
 		   show_indirect_byte, store_indirect_byte);
 
-static ssize_t show_direct_dword(struct device *d, char *buf)
+static ssize_t show_direct_dword(struct device *d,
+				 struct device_attribute *attr, char *buf)
 {
 	u32 reg = 0;
 	struct ipw_priv *priv = (struct ipw_priv *)d->driver_data;
@@ -1349,8 +1372,9 @@ static ssize_t show_direct_dword(struct 
 	return sprintf(buf, "0x%08x\n", reg);
 }
 static ssize_t store_direct_dword(struct device *d,
-				 const char *buf,
-				 size_t count)
+				  struct device_attribute *attr,
+				  const char *buf,
+				  size_t count)
 {
 	struct ipw_priv *priv = (struct ipw_priv *)d->driver_data;
 
@@ -1372,7 +1396,8 @@ static inline int rf_kill_active(struct 
 	return (priv->status & STATUS_RF_KILL_HW) ? 1 : 0;
 }
 
-static ssize_t show_rf_kill(struct device *d, char *buf)
+static ssize_t show_rf_kill(struct device *d, struct device_attribute *attr,
+			    char *buf)
 {
 	/* 0 - RF kill not enabled
 	   1 - SW based RF kill active (sysfs)
@@ -1415,7 +1440,8 @@ static int ipw_radio_kill_sw(struct ipw_
 	return 1;
 }
 
-static ssize_t store_rf_kill(struct device *d, const char *buf, size_t count)
+static ssize_t store_rf_kill(struct device *d, struct device_attribute *attr,
+			     const char *buf, size_t count)
 {
 	struct ipw_priv *priv = (struct ipw_priv *)d->driver_data;
 
@@ -1425,7 +1451,8 @@ static ssize_t store_rf_kill(struct devi
 }
 static DEVICE_ATTR(rf_kill, S_IWUSR|S_IRUGO, show_rf_kill, store_rf_kill);
 
-static ssize_t show_speed_scan(struct device *d, char *buf)
+static ssize_t show_speed_scan(struct device *d, struct device_attribute *attr,
+			       char *buf)
 {
 	struct ipw_priv *priv = (struct ipw_priv *)d->driver_data;
 	int pos = 0, len = 0;
@@ -1439,7 +1466,9 @@ static ssize_t show_speed_scan(struct de
 	return sprintf(buf, "0\n");
 }
 
-static ssize_t store_speed_scan(struct device *d, const char *buf, size_t count)
+static ssize_t store_speed_scan(struct device *d,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
 {
 	struct ipw_priv *priv = (struct ipw_priv *)d->driver_data;
 	int channel, pos = 0;
@@ -1477,14 +1506,16 @@ static ssize_t store_speed_scan(struct d
 static DEVICE_ATTR(speed_scan, S_IWUSR|S_IRUGO, show_speed_scan,
 		   store_speed_scan);
 
-static ssize_t show_net_stats(struct device *d, char *buf)
+static ssize_t show_net_stats(struct device *d, struct device_attribute *attr,
+			      char *buf)
 {
 	struct ipw_priv *priv = (struct ipw_priv *)d->driver_data;
 	return sprintf(buf, "%c\n", (priv->config & CFG_NET_STATS) ?
 		       '1' : '0');
 }
 
-static ssize_t store_net_stats(struct device *d, const char *buf, size_t count)
+static ssize_t store_net_stats(struct device *d, struct device_attribute *attr,
+			       const char *buf, size_t count)
 {
 	struct ipw_priv *priv = (struct ipw_priv *)d->driver_data;
 	if (buf[0] == '1')
