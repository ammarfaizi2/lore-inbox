Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbVKEU6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbVKEU6d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 15:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVKEU6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 15:58:33 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:61266 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750852AbVKEU6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 15:58:32 -0500
From: David Brownell <david-b@pacbell.net>
To: stephen@streetfiresound.com
Subject: Re: [PATCH/RFC] simple SPI controller on PXA2xx SSP port, refresh
Date: Sat, 5 Nov 2005 12:58:30 -0800
User-Agent: KMail/1.7.1
Cc: eemike@gmail.com, Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200511031615.22630.david-b@pacbell.net> <200511041654.47109.david-b@pacbell.net> <1131157728.426.113.camel@localhost.localdomain>
In-Reply-To: <1131157728.426.113.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511051258.30539.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 November 2005 6:28 pm, Stephen Street wrote:
> My understanding also.  Let's at least do the renames.

Consider it done.

I'll leave "controller_data" in board_info and spi_device too.
You're right ... plus, we need to let that be separate from the
controller platform_data for hotplugging usage, spi_new_device()
and such.


> Occupying some spare cycles is the idea that what we really need is the
> ability to sub-class spi_device and spi_master via structure embedding.
> This would be in the spirit of the 2.6 driver model and would map to the
> platform_device model better.  

Not really.  "Struture embedding" is used more by bus infrastruture than
by driver infrastructure ... and even there, it's more often done by
sharing storage.  And spi_master supports that usage:

	/* at the top of probe(dev) */
        struct spi_master       *master;
        struct MYSOC_DATA       *data;

        master = spi_alloc_master(dev, sizeof *data);
        if (!master)
                return -ENODEV;

        data = class_get_devdata(&master->cdev);

That's because spi_master is a class view of the underlying "dev",
used to access the controller hardware.  (Likely a platform_device
created as part of board setup.)

A difference for normal spi_device nodes is that the drivers you'd
presumably want to "subclass" spi_device isn't responsible for
creating the device note.  It might however create a class device
node, and that could end up looking much like that spi_master snippet.

- Dave

