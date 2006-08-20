Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWHTUjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWHTUjT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 16:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWHTUjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 16:39:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:50856 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751118AbWHTUjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 16:39:18 -0400
X-Authenticated: #704063
Subject: Re: [Patch] Signedness issue in drivers/net/phy/phy_device.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: Dave Jones <davej@redhat.com>
Cc: Richard Knutsson <ricknu-0@student.ltu.se>, linux-kernel@vger.kernel.org,
       drzeus-sdhci@drzeus.cx
In-Reply-To: <20060820191643.GA2608@redhat.com>
References: <1156008815.18192.3.camel@alice>
	 <44E7E112.3010500@student.ltu.se> <20060820183600.GA3431@alice>
	 <20060820191643.GA2608@redhat.com>
Content-Type: text/plain
Date: Sun, 20 Aug 2006 22:39:08 +0200
Message-Id: <1156106348.5150.1.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-20 at 15:16 -0400, Dave Jones wrote:
> On Sun, Aug 20, 2006 at 08:36:00PM +0200, Eric Sesterhenn / Snakebyte wrote:
>  > * Richard Knutsson (ricknu-0@student.ltu.se) wrote:
>  > > Eric Sesterhenn wrote:
>  > hi,
>  > 
>  > > Would it not be preferable to use a 's32' instead of an 'int'? After 
>  > > all, it seem 'val' needs to be 32 bits.
>  > 
>  > not sure, but wouldnt this collide with platforms where an int is 64
>  > Bits?
> 
> None of the 64-bit Linux ports use ILP64.

Here is an updated patch.

while checking gcc 4.1 -Wextra warnings, I stumbled across the following
two warnings:

drivers/net/phy/phy_device.c:528: warning: comparison of unsigned expression < 0 is always false
drivers/net/phy/phy_device.c:546: warning: comparison of unsigned expression < 0 is always false

Since phy_read() returns an integer and can return negative values, as proposed
by Richard Knutsson this patch changes val to s32. Currently it is an u32, so the < 0 check
always fails.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-rc4/drivers/net/phy/phy_device.c.orig	2006-08-20 22:05:26.000000000 +0200
+++ linux-2.6.18-rc4/drivers/net/phy/phy_device.c	2006-08-20 22:05:42.000000000 +0200
@@ -513,7 +513,7 @@ EXPORT_SYMBOL(genphy_read_status);
 
 static int genphy_config_init(struct phy_device *phydev)
 {
-	u32 val;
+	s32 val;
 	u32 features;
 
 	/* For now, I'll claim that the generic driver supports


