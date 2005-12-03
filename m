Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbVLCEqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbVLCEqQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 23:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVLCEqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 23:46:16 -0500
Received: from soundwarez.org ([217.160.171.123]:49348 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751146AbVLCEqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 23:46:16 -0500
Date: Sat, 3 Dec 2005 05:46:14 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Scott James Remnant <scott@ubuntu.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, linux-input@atrey.karlin.mff.cuni.cz,
       vojtech@suse.cz
Subject: Re: Two module-init-
Message-ID: <20051203044614.GA8418@vrfy.org>
References: <1133359773.2779.13.camel@localhost.localdomain> <1133482376.4094.11.camel@localhost.localdomain> <1133514074.20712.0.camel@localhost.localdomain> <1133567988.21941.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133567988.21941.12.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 10:59:48AM +1100, Rusty Russell wrote:
> On Fri, 2005-12-02 at 09:01 +0000, Scott James Remnant wrote:
> > On Fri, 2005-12-02 at 11:12 +1100, Rusty Russell wrote:
> > 
> > > On Wed, 2005-11-30 at 14:09 +0000, Scott James Remnant wrote:
> > > > Hi Rusty,
> > > > 
> > > > Attached are two patches to module-init-tools from Ubuntu.
> > > > 
> > > > The first (input_table_size) is a catch-up with 2.6.15, it's adding an
> > > > extra field to the input_device_id struct; m-u-t needs updating to be
> > > > able to read the modules correctly.
> > > 
> > > Unfortunately, it's not that simple.  Your patch will break previous
> > > kernels, which have a smaller structure.  I've had the discussion years
> > > ago with the input people on using module aliases, and it's not entirely
> > > trivial.  I will prepare another patch, however.
> > > 
> > Are the modules.*map files intended to be deprecated entirely in favour
> > of aliases?  The problem this patch fixed was that the parser couldn't
> > read the tables, so produced invalid output for the modules (ie. an
> > empty modules.inputmap).
> 
> Yes, but now it will produce a bad modules.inputmap for previous
> kernels.
> 
> Here's the patch for modalias support for input classes.  It uses
> comma-separated numbers, and doesn't describe all the potential keys (no
> module currently cares, and that would make the strings huge).  The
> changes to input.h are to move the definitions needed by file2alias
> outside __KERNEL__.  I chose not to move those definitions to
> mod_devicetable.h, because there are so many that it might break compile
> of something else in the kernel.
> 
> The rest is fairly straightforward.

Nice! Seems the last user of the map files is gone now.
Here is the MODALIAS for the event environment.



From: Kay Sievers <kay.sievers@suse.de>

input: add MODALIAS to the event environment

Signed-off-by: Kay Sievers <kay.sievers@suse.de>
---

diff --git a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -528,40 +528,56 @@ INPUT_DEV_STRING_ATTR_SHOW(name);
 INPUT_DEV_STRING_ATTR_SHOW(phys);
 INPUT_DEV_STRING_ATTR_SHOW(uniq);
 
-static int print_modalias_bits(char *buf, char prefix, unsigned long *arr,
+static int print_modalias_bits(char *buf, int size, char prefix, unsigned long *arr,
 			       unsigned int min, unsigned int max)
 {
 	int len, i;
 
-	len = sprintf(buf, "%c", prefix);
+	len = snprintf(buf, size, "%c", prefix);
 	for (i = min; i < max; i++)
 		if (arr[LONG(i)] & BIT(i))
-			len += sprintf(buf+len, "%X,", i);
+			len += snprintf(buf + len, size - len, "%X,", i);
 	return len;
 }
-	
-static ssize_t input_dev_show_modalias(struct class_device *dev, char *buf)
+
+static int print_modalias(char *buf, int size, struct input_dev *id)
 {
-	struct input_dev *id = to_input_dev(dev);
-	ssize_t len = 0;
+	int len;
 
-	len += sprintf(buf+len, "input:b%04Xv%04Xp%04Xe%04X-",
+	len = snprintf(buf, size, "input:b%04Xv%04Xp%04Xe%04X-",
 		       id->id.bustype,
 		       id->id.vendor,
 		       id->id.product,
 		       id->id.version);
 
-	len += print_modalias_bits(buf+len, 'e', id->evbit, 0, EV_MAX);
-	len += print_modalias_bits(buf+len, 'k', id->keybit,
+	len += print_modalias_bits(buf + len, size - len, 'e', id->evbit,
+				   0, EV_MAX);
+	len += print_modalias_bits(buf + len, size - len, 'k', id->keybit,
 				   KEY_MIN_INTERESTING, KEY_MAX);
-	len += print_modalias_bits(buf+len, 'r', id->relbit, 0, REL_MAX);
-	len += print_modalias_bits(buf+len, 'a', id->absbit, 0, ABS_MAX);
-	len += print_modalias_bits(buf+len, 'm', id->mscbit, 0, MSC_MAX);
-	len += print_modalias_bits(buf+len, 'l', id->ledbit, 0, LED_MAX);
-	len += print_modalias_bits(buf+len, 's', id->sndbit, 0, SND_MAX);
-	len += print_modalias_bits(buf+len, 'f', id->ffbit, 0, FF_MAX);
-	len += print_modalias_bits(buf+len, 'w', id->swbit, 0, SW_MAX);
-	len += sprintf(buf+len, "\n");
+	len += print_modalias_bits(buf + len, size - len, 'r', id->relbit,
+				   0, REL_MAX);
+	len += print_modalias_bits(buf + len, size - len, 'a', id->absbit,
+				   0, ABS_MAX);
+	len += print_modalias_bits(buf + len, size - len, 'm', id->mscbit,
+				   0, MSC_MAX);
+	len += print_modalias_bits(buf + len, size - len, 'l', id->ledbit,
+				   0, LED_MAX);
+	len += print_modalias_bits(buf + len, size - len, 's', id->sndbit,
+				   0, SND_MAX);
+	len += print_modalias_bits(buf + len, size - len, 'f', id->ffbit,
+				   0, FF_MAX);
+	len += print_modalias_bits(buf + len, size - len, 'w', id->swbit,
+				   0, SW_MAX);
+	return len;
+}
+
+static ssize_t input_dev_show_modalias(struct class_device *dev, char *buf)
+{
+	struct input_dev *id = to_input_dev(dev);
+	ssize_t len;
+
+	len = print_modalias(buf, PAGE_SIZE, id);
+	len += snprintf(buf + len, PAGE_SIZE-len, "\n");
 	return len;
 }
 static CLASS_DEVICE_ATTR(modalias, S_IRUGO, input_dev_show_modalias, NULL);
@@ -728,8 +744,11 @@ static int input_dev_uevent(struct class
 	if (test_bit(EV_SW, dev->evbit))
 		INPUT_ADD_HOTPLUG_BM_VAR("SW=", dev->swbit, SW_MAX);
 
-	envp[i] = NULL;
+	envp[i++] = buffer + len;
+	len += snprintf(buffer + len, buffer_size - len, "MODALIAS=");
+	len += print_modalias(buffer + len, buffer_size - len, dev) + 1;
 
+	envp[i] = NULL;
 	return 0;
 }
 

