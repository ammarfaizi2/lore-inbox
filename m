Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbWGCKMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWGCKMx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 06:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWGCKMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 06:12:53 -0400
Received: from sd291.sivit.org ([194.146.225.122]:15364 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S1750911AbWGCKMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 06:12:52 -0400
Subject: Re: [RFC] Apple Motion Sensor driver
From: Stelian Pop <stelian@popies.net>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
       khali@linux-fr.org, linux-kernel@killerfox.forkbomb.ch,
       benh@kernel.crashing.org, johannes@sipsolutions.net,
       chainsaw@gentoo.org
In-Reply-To: <20060702222649.GA13411@hansmi.ch>
References: <20060702222649.GA13411@hansmi.ch>
Content-Type: text/plain; charset=ISO-8859-15
Date: Mon, 03 Jul 2006 12:12:47 +0200
Message-Id: <1151921567.10711.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 03 juillet 2006 à 00:26 +0200, Michael Hanselmann a écrit :

> [AMS patch]

Okay, I've tried the driver and it oopsed on rmmod:

Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc01cfd1c
Oops: Kernel access of bad area, sig: 11 [#1]

Modules linked in: ams nfsd exportfs lockd sunrpc appletouch bcm43xx ohci1394 ie ee80211softmac ieee80211 pcmcia ieee80211_crypt yenta_socket rsrc_nonstatic pcmc ia_core ohci_hcd ehci_hcd
NIP: C01CFD1C LR: C01CFCFC CTR: C01CFC6C
REGS: c48b9d90 TRAP: 0300   Not tainted  (2.6.17.2)
MSR: 00009032 <EE,ME,IR,DR>  CR: 22004422  XER: 20000000
DAR: 00000000, DSISR: 42000000
TASK = dd79b340[26173] 'rmmod' THREAD: c48b8000
GPR00: 00100100 C48B9E40 DD79B340 C0CDA828 C00F4CD0 00000001 C48B8000 F22451F8
GPR08: 00000000 00200200 00000000 F2245238 00000000 1001A188 100D0000 00000000
GPR16: 00000000 10104308 100D0000 100B0000 100D0000 100B0000 10013008 00000000
GPR24: C0380000 C0380000 EFFCCC88 C0350000 C0CDA828 F22450D0 00000000 F22450B8
NIP [C01CFD1C] i2c_detach_client+0xb0/0x16c
LR [C01CFCFC] i2c_detach_client+0x90/0x16c
Call Trace:
[C48B9E40] [DDF8077C] 0xddf8077c (unreliable)
[C48B9E60] [F2242984] ams_i2c_detach+0x20/0x60 [ams]
[C48B9E80] [C01D1024] i2c_del_driver+0x60/0x1d0
[C48B9EB0] [F22429DC] ams_i2c_exit+0x18/0x28 [ams]
[C48B9EC0] [F2242428] cleanup_module+0x58/0xd4 [ams]
[C48B9ED0] [C0045C70] sys_delete_module+0x180/0x1e8
[C48B9F40] [C000EE7C] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xff7320c
    LR = 0x1000103c
Instruction dump:
3b9c0028 3bbf0018 7f83e378 480c4839 38ff0140 815f0140 3c000010 81070004
60000100 3d200020 397f0180 61290200 <91480000> 3c80c038 7fa3eb78 901f0140

I haven't had the time too look into the issue yet. 

Below are a few comments on the patch:

> +	/* calibrated null values */
> +	int xcalib, ycalib;

Add zcalib too for movement on z-axis.

> +		input_report_abs(ams.idev, ABS_X, x - ams.xcalib);
> +		input_report_abs(ams.idev, ABS_Y, y - ams.ycalib);

Ditto, ABS_Z...

> +	input_set_abs_params(ams.idev, ABS_X, -50, 50, 3, 0);
> +	input_set_abs_params(ams.idev, ABS_Y, -50, 50, 3, 0);

And here...

> +static ssize_t ams_mouse_store_mouse(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	int oldmouse = mouse;
> +
> +	if (sscanf(buf, "%d\n", &mouse) != 1)
> +		return -EINVAL;
> +
> +	mouse = !!mouse;
> +
> +	if (oldmouse != mouse) {
> +		mutex_lock(&ams.lock);
> +
> +		if (mouse)
> +			ams_mouse_enable();
> +		else
> +			ams_mouse_disable();
> +
> +		mutex_unlock(&ams.lock);
> +	}

No need for oldmouse here. Just call ams_mouse_enable() or disable() in
every case.

> +
> +static DEVICE_ATTR(mouse, S_IRUGO | S_IWUSR,
> +	ams_mouse_show_mouse, ams_mouse_store_mouse);

I would prefer three different files for x, y and z instead of a single
one... 

> +	result = ams_sensor_attach();
> +	if (result < 0) {
> +		goto exit;
> +	}

No need for braces.

> +config SENSORS_AMS_MOUSE
> +	bool "Support for mouse mode with motion sensor"
> +	depends on SENSORS_AMS && INPUT
> +	help
> +	  Support for mouse emulation with motion sensor.

Is it really necessary to have a config option here ?

Stelian.
-- 
Stelian Pop <stelian@popies.net>

