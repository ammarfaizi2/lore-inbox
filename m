Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbVBPAg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVBPAg1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 19:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVBPAg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 19:36:27 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:13397 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261961AbVBPAgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 19:36:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=DU8k6hM9rjInLYypVpSgpO9MHazDyyLUR7SPCQQXMoZ4x5vkSPW2jhYng1DZRojj0RrrRwUN/hlViQGi1T0kNwj4Mnp/H+GbMF4g9d7S/TXUokksWJY5GbETP7tkJs2PSCCI0QZL9mjt9tihD1EvUjRxF3agbAJ6Z3UijnPBnQo=
Message-ID: <9e473391050215163621dafa65@mail.gmail.com>
Date: Tue, 15 Feb 2005 19:36:17 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jesse Barnes <jbarnes@sgi.com>
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
Cc: akpm@osdl.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
In-Reply-To: <200502151557.06049.jbarnes@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200502151557.06049.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're removing the check for 55AA at the start of the ROM. I though
the PCI standard was that all ROMs had to start with the no matter
what object code they contain. Then if you look for PCIR there is a
field in the stucture that says what language the ROM is in. Maybe the
problem is in the BIOS_IN16() function and things are getting byte
swapped wrong.

                void __iomem *pds;
                /* Standard PCI ROMs start out with these bytes 55 AA */
                if (readb(image) != 0x55)
                        break;
                if (readb(image + 1) != 0xAA)
                        break;
                /* get the PCI data structure and check its signature */
                pds = image + readw(image + 24);
                if (readb(pds) != 'P')
                        break;
                if (readb(pds + 1) != 'C')
                        break;
                if (readb(pds + 2) != 'I')
                        break;
                if (readb(pds + 3) != 'R')
                        break;
                last_image = readb(pds + 21) & 0x80;
                /* this length is reliable */
                image += readw(pds + 16) * 512;



On Tue, 15 Feb 2005 15:57:05 -0800, Jesse Barnes <jbarnes@sgi.com> wrote:
> Both the r128 and radeon drivers complain if they don't find an x86 option ROM
> on the device they're talking to.  This would be fine, except that the
> message is incorrect--not all option ROMs are required to be x86 based.  This
> small patch just removes the messages altogether, causing the drivers to
> *silently* fall back to the non-x86 option ROM behavior (it works fine and
> there's no cause for alarm).
> 
> Signed-off-by: Jesse Barnes <jbarnes@sgi.com>
> 
> 
> 


-- 
Jon Smirl
jonsmirl@gmail.com
