Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264777AbTCEGbT>; Wed, 5 Mar 2003 01:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264788AbTCEGbT>; Wed, 5 Mar 2003 01:31:19 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:9857 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S264777AbTCEGbP>; Wed, 5 Mar 2003 01:31:15 -0500
Date: Wed, 5 Mar 2003 07:39:12 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Patrick Mochel <mochel@osdl.org>
Cc: torvalds@transmeta.com, jt@hpl.hp.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       mika.penttila@kolumbus.fi
Subject: [PATCH] driver model: fix platform_match [Was: Re: [PATCH] pcmcia: get initialization ordering right [Was: [PATCH 2.5] : i82365 & platform_bus_type]]
Message-ID: <20030305063912.GA2520@brodo.de>
References: <20030304095447.GA1408@brodo.de> <Pine.LNX.4.33.0303040831120.992-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303040831120.992-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pat,

On Tue, Mar 04, 2003 at 08:35:05AM -0600, Patrick Mochel wrote:
> 
> On Tue, 4 Mar 2003, Dominik Brodowski wrote:
> 
> > Hi Pat,
> > 
> > How is it supposed to work then? I thought adding a platform_device and
> > platform_driver with the same name and bus_id causes the platform_driver to
> > be bound to the platform_device?
> 
> Erm yes. Color me lazy, I just hadn't implemented that yet.. You've hit 
> something else no one had used before. 
> 
> This patch is completley untested, but it should work. 
...
> +
> +	if (sscanf(dev->bus_id,"%s",name))
> +		return (strcmp(name,drv->name) == 0);


Unfortunately, this won't work: digits are perfectly valid entries of
strings. However, we have the name without the appending instance still
saved in platform_device pdev->name... so what about this?

diff -ruN linux-original/drivers/base/platform.c linux/drivers/base/platform.c
--- linux-original/drivers/base/platform.c	2003-03-05 07:19:19.000000000 +0100
+++ linux/drivers/base/platform.c	2003-03-05 07:22:31.000000000 +0100
@@ -59,12 +59,9 @@
 
 static int platform_match(struct device * dev, struct device_driver * drv)
 {
-	char name[BUS_ID_SIZE];
+	struct platform_device *pdev = container_of(dev, struct platform_device, dev);
 
-	if (sscanf(dev->bus_id,"%s",name))
-		return (strcmp(name,drv->name) == 0);
-
-	return 0;
+	return (strncmp(pdev->name, drv->name, BUS_ID_SIZE) == 0);
 }
 
 struct bus_type platform_bus_type = {
