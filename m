Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422724AbWF0X0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422724AbWF0X0F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 19:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422726AbWF0X0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 19:26:05 -0400
Received: from mail.gmx.net ([213.165.64.21]:14802 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422724AbWF0X0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 19:26:04 -0400
X-Authenticated: #704063
Subject: Re: [Patch] Off by one in drivers/usb/input/yealink.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, Henk.Vergonet@gmail.com
In-Reply-To: <20060627161826.db62fd00.rdunlap@xenotime.net>
References: <1151448080.16217.3.camel@alice>
	 <20060627155143.b0e3e1dd.rdunlap@xenotime.net>
	 <20060627230415.GA16561@alice>
	 <20060627161826.db62fd00.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 01:26:01 +0200
Message-Id: <1151450761.16746.1.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> :) Yep.
> 
> so for the floppy.c patch, I still prefer to see:
> +	if (drive < 0 || drive >= N_DRIVE) {
> 
> instead of
> +	if (drive < 0 || drive > N_DRIVE-1) {
> 
> Does that make sense?

looks better :)

--- 

another bug spotted by coverity (id #481).
In the case that drive == N_DRIVE we acess past the
drive_params array which is defined as 
drive_params[N_DRIVE]. By using the UDP define
in the else case because UDP is &drive_params[drive]

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-git11/drivers/block/floppy.c.orig	2006-06-28 01:22:59.000000000 +0200
+++ linux-2.6.17-git11/drivers/block/floppy.c	2006-06-28 01:23:24.000000000 +0200
@@ -684,7 +684,7 @@ static void __reschedule_timeout(int dri
 	if (drive == current_reqD)
 		drive = current_drive;
 	del_timer(&fd_timeout);
-	if (drive < 0 || drive > N_DRIVE) {
+	if (drive < 0 || drive >= N_DRIVE) {
 		fd_timeout.expires = jiffies + 20UL * HZ;
 		drive = 0;
 	} else


