Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbVLaRjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVLaRjD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 12:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbVLaRjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 12:39:03 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:9889 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932122AbVLaRjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 12:39:01 -0500
Date: Sat, 31 Dec 2005 18:38:42 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jason Dravet <dravet@hotmail.com>
cc: linux-kernel@vger.kernel.org, linux-parport@lists.infradead.org
Subject: Re: RFC: add udev support to parport_pc
In-Reply-To: <BAY103-F5ABE5F52E47CC9DD71D21DF2B0@phx.gbl>
Message-ID: <Pine.LNX.4.61.0512311830030.7910@yvahk01.tjqt.qr>
References: <BAY103-F5ABE5F52E47CC9DD71D21DF2B0@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +	parallel_class = class_create(THIS_MODULE, "lp");
> +	if (p->base == 888) /* 888 is dec for 378h */

I would prefer to actually see == 0x378 in the code, because the 
hexademical number is what you see everywhere else, such as the BIOS POST 
and /proc/ioports. This also applies to 0x278 and 0x3BC below.

> +	{
> +		class_device_create(parallel_class, NULL, MKDEV(6, 0), NULL,
> "lp0");
> +		class_device_create(parallel_class, NULL, MKDEV(99, 0), NULL,
> "parport0");
> +	}

Background info before: Because I burnt my on-board LPT port (applying too 
much volts or milliamps), I bought a dual-slot PCI add-in card. This card 
provides "parport1" and "parport2" at ports at 0xC800 and 0xC00 
(/proc/ioports).

There are a number of problems in your code:

1- testing just for 0x378/0x278/0x3BC is not enough

2- parport0 could be 0xC800 (address may vary) if you do not
   have any onboard LPT ports.
    2=> that is why I think you should not reserver "lp0"/"parport0"
        for 0x378.

All this applies to the other chunks too of course...:

> +	if (p->base == 632) /* 632 is dec for 278h */
> +	{
> +		class_device_create(parallel_class, NULL, MKDEV(6, 1), NULL,
> "lp1");
> +		class_device_create(parallel_class, NULL, MKDEV(99, 1), NULL,
> "parport1");
> +	}
> +
> +	if (p->base == 956) /* 956 is dec for 3BCh */
> +	{
> +		class_device_create(parallel_class, NULL, MKDEV(6, 2), NULL,
> "lp2");
> +		class_device_create(parallel_class, NULL, MKDEV(99, 2), NULL,
> "parport2");
> +	}
> +


> +	class_device_destroy(parallel_class, MKDEV(99, 2));
> +	class_device_destroy(parallel_class, MKDEV(6, 2));
> +	class_device_destroy(parallel_class, MKDEV(99, 1));
> +	class_device_destroy(parallel_class, MKDEV(6, 1));
> +	class_device_destroy(parallel_class, MKDEV(99, 0));
> +	class_device_destroy(parallel_class, MKDEV(6, 0));
> +


Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
