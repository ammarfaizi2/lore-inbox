Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265422AbUFHXcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265422AbUFHXcv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 19:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265429AbUFHXcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 19:32:51 -0400
Received: from mail.dif.dk ([193.138.115.101]:53665 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265422AbUFHXct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 19:32:49 -0400
Date: Wed, 9 Jun 2004 01:32:06 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Thomas Pfeiffer <pfeiffer@pds.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Kill uninitialized variable warning in drivers/isdn/i4l/isdn_v110.c
Message-ID: <Pine.LNX.4.56.0406090122090.25359@jjulnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here's a small patch to shut up a gcc warning about 'ret' being possibly
used uninitialized in drivers/isdn/i4l/isdn_v110.c::isdn_v110_stat_callback

drivers/isdn/i4l/isdn_v110.c: In function `isdn_v110_stat_callback':
drivers/isdn/i4l/isdn_v110.c:523: warning: `ret' might be used uninitialized in this function

I've read through the code, and as I read it, to use ret uninitialized
we'd have to never enter the for() loop at all for the c->command ==
ISDN_STAT_BSENT case, which (as I read the code) can never happen.
So, I believe everything is OK and the gcc warning is bogus in this
case - so the patch simply shuts up gcc by initially initializing 'ret'
to zero (which looks to be a sane value sane even if the case of
v->framelen being initially greater than c->parm.length should ever happen
in some freak case I'm not aware of).

Comments are always welcome.

Patch is against 2.6.7-rc3 :


--- linux-2.6.7-rc3/drivers/isdn/i4l/isdn_v110.c-orig	2004-06-09 01:18:18.000000000 +0200
+++ linux-2.6.7-rc3/drivers/isdn/i4l/isdn_v110.c	2004-06-09 01:22:33.000000000 +0200
@@ -520,7 +520,7 @@ isdn_v110_stat_callback(int idx, isdn_ct
 {
 	isdn_v110_stream *v = NULL;
 	int i;
-	int ret;
+	int ret = 0;

 	if (idx < 0)
 		return 0;


--
Jesper Juhl <juhl-lkml@dif.dk>

