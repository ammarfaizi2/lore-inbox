Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932617AbWCPD70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbWCPD70 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932618AbWCPD7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:59:25 -0500
Received: from smtp-relay.dca.net ([216.158.48.66]:8926 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S932617AbWCPD7Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:59:24 -0500
Date: Wed, 15 Mar 2006 22:59:16 -0500
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, Etienne Lorrain <etienne_lorrain@yahoo.fr>,
       lm-sensors <lm-sensors@lm-sensors.org>
Subject: Re: sis96x compiled in by error: delay of one minute at boot
Message-ID: <20060316035916.GA10675@jupiter.solarsys.private>
References: <20060315034625.GA21733@jupiter.solarsys.private> <zJe6kSDV.1142413307.3312800.khali@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zJe6kSDV.1142413307.3312800.khali@localhost>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean:

(cc'ed lm-sensors ML)

[user reports waiting ~23 seconds for i2c/hwmon stuff to init in a
monolithic kernel build]

> On 2006-03-15, Mark M. Hoffman wrote:
> > Wow, that's a huge delay.  One alternative would be for i2c slaves to
> > behave more like USB and do the probing asynchronous to driver load;
> > i.e. 'modprobe w83627hf' returns before the chip is actually recognized
> > and attached.
> 
* Jean Delvare <khali@linux-fr.org> [2006-03-15 10:01:47 +0100]:
> You mean that the i2c subsystem would finally be rewritten from scratch
> to comply with the driver model? I'm waiting for your patches :)

Heh, 'spose I asked for that.

> > OTOH, that brings up all the related problems.  E.g., you could no longer
> > expect this simple fragment of a RC script to work...
> >
> >	modprobe i2c-sis96x
> >	modprobe asb100
> >	sensors -s
> 
> I guess we would have to use hotplug instead then.
> 
> > Short of fixing all that... one has to accept that (1) i2c bus probing
> > is slow, and (2) some i2c busses themselves are not reliably
> > detectable...
> 
> Things can be improved still. The busses which cannot be reliably
> detected could test themselves, and discard themselves if they find they
> don't work. This is much the spirit of the bit_test parameter of the
> i2c-algo-bit module; it could be made the default. i2c-algo-pca could be
> added a similar option.
> 
> Also, the i2c subsystem is currently relying on general probing for
> almost everything. Whenever you load an i2c chip driver, it'll probe
> all the i2c busses for supported chips. We tried to limit the probing
> area by introducing the concept of "classes", and we now only probe
> the busses which share a class with the i2c chip driver. Not all drivers
> have been modified to take benefit of that class check though, and the
> i2c core doesn't enforce it at the moment; it is all based on drivers
> cooperation. So there is room for improvement here.
> 
> Last, sometimes you know exactly where the chip is, yet the i2c core
> doesn't offer a way to skip the probing step and attach the driver
> directly to the device. I'm working on a way to do that, and hope to
> have something ready to show soon. This should speed up the driver load
> quite a bit.

Here's a start: why does i2c-parport[-light] have a default adapter type?
Loading it with the default could be considered an accident by definition.
It takes ~6 seconds to load all of kernel/drivers/hwmon/*.ko on a test box
here with i2c-parport-light present (but without any adapter hardware).
With this patch, that drops to ~1 second.

---

This patch forces the user to specify what type of adapter is present when
loading i2c-parport or i2c-parport-light.  If none is specified, the driver
init simply fails - instead of assuming adapter type 0.

This alleviates the sometimes lengthy boot time delays which can be caused
by accidentally building one of these into a kernel along with several i2c
slave drivers that have lengthy probe routines (e.g. hwmon drivers).

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

--- linux-2.6.16-rc6.orig/drivers/i2c/busses/i2c-parport-light.c
+++ linux-2.6.16-rc6/drivers/i2c/busses/i2c-parport-light.c
@@ -121,9 +121,14 @@ static struct i2c_adapter parport_adapte
 
 static int __init i2c_parport_init(void)
 {
-	if (type < 0 || type >= ARRAY_SIZE(adapter_parm)) {
+	if (type < 0) {
+		printk(KERN_WARNING "i2c-parport: adapter type unspecified\n");
+		return -ENODEV;
+	}
+
+	if (type >= ARRAY_SIZE(adapter_parm)) {
 		printk(KERN_WARNING "i2c-parport: invalid type (%d)\n", type);
-		type = 0;
+		return -ENODEV;
 	}
 
 	if (base == 0) {
--- linux-2.6.16-rc6.orig/drivers/i2c/busses/i2c-parport.h
+++ linux-2.6.16-rc6/drivers/i2c/busses/i2c-parport.h
@@ -90,7 +90,7 @@ static struct adapter_parm adapter_parm[
 	},
 };
 
-static int type;
+static int type = -1;
 module_param(type, int, 0);
 MODULE_PARM_DESC(type,
 	"Type of adapter:\n"
--- linux-2.6.16-rc6.orig/drivers/i2c/busses/i2c-parport.c
+++ linux-2.6.16-rc6/drivers/i2c/busses/i2c-parport.c
@@ -241,9 +241,14 @@ static struct parport_driver i2c_parport
 
 static int __init i2c_parport_init(void)
 {
-	if (type < 0 || type >= ARRAY_SIZE(adapter_parm)) {
+	if (type < 0) {
+		printk(KERN_WARNING "i2c-parport: adapter type unspecified\n");
+		return -ENODEV;
+	}
+
+	if (type >= ARRAY_SIZE(adapter_parm)) {
 		printk(KERN_WARNING "i2c-parport: invalid type (%d)\n", type);
-		type = 0;
+		return -ENODEV;
 	}
 
 	return parport_register_driver(&i2c_parport_driver);

-- 
Mark M. Hoffman
mhoffman@lightlink.com

