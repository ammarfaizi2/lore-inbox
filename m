Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbTFJF1d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 01:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbTFJF1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 01:27:33 -0400
Received: from charger.oldcity.dca.net ([207.245.82.76]:16774 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id S262340AbTFJF1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 01:27:32 -0400
Date: Tue, 10 Jun 2003 01:41:07 -0400
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@Stimpy.netroedge.com>
Subject: Re: OOPS w83781d during rmmod (2.5.70-bk1[1234])
Message-ID: <20030610054107.GA22719@earth.solarsys.private>
Mail-Followup-To: Martin Schlemmer <azarah@gentoo.org>,
	Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
	Sensors <sensors@Stimpy.netroedge.com>
References: <20030524183748.GA3097@earth.solarsys.private> <3ED8067E.1050503@paradyne.com> <20030601143808.GA30177@earth.solarsys.private> <20030602172040.GC4992@kroah.com> <20030605023922.GA8943@earth.solarsys.private> <20030605194734.GA6238@kroah.com> <1055136870.5280.196.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055136870.5280.196.camel@workshop.saharacpt.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin Schlemmer <azarah@gentoo.org> [2003-06-09 07:34:30 +0200]:
> 
> Anyhow, Only change I have made to the w83781d driver, is one line
> (just tell it to that if the chip id is 0x72, its also of type
> w83726HF), but now (2.5.70-bk1[123]) it segfaults for me on rmmod, where
> it did not with 2.5.68 kernels when I still had the other board.  I will
> attach a oops tomorrow or such when I get home.

I reproduced the segfault here.  It looks like i2c_del_driver() tries
to call w83781d_detach_client() more than once now, partly because of
the safe list fix in 2.5.70-bk11.  But that function should only be
called for the "primary" client, not the subclients.

The quick/ugly patch below fixes the symptom, but maybe not the disease.
There might be more fundamental brokenness in the whole subclient scheme.
I'll keep looking when I get the chance.

--- linux-2.5.70-bk14/drivers/i2c/chips/w83781d.c	2003-06-10 00:49:19.831210956 -0400
+++ linux-2.5.70/drivers/i2c/chips/w83781d.c	2003-06-10 00:53:35.041027614 -0400
@@ -1412,6 +1412,10 @@
 	struct w83781d_data *data = i2c_get_clientdata(client);
 	int err;
 
+	/* if this is a subclient, do nothing */
+	if (!data)
+		return 0;
+
 	/* release ISA region or I2C subclients first */
 	if (i2c_is_isa_client(client)) {
 		release_region(client->addr, W83781D_EXTENT);

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

