Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbVIQChA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVIQChA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 22:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbVIQChA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 22:37:00 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:29318 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1750832AbVIQCg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 22:36:59 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=plrRU0jf9+cdr5+O5Kf86DeUqIyxVwstfBPiZwZYUnkMysuXy+AW5dEVXDSsejBFR
	r/EKkEa50DgJmUvHP9Elg==
Date: Fri, 16 Sep 2005 19:36:39 -0700
From: David Brownell <david-b@pacbell.net>
To: rene.herman@keyaccess.nl
Subject: Re: External USB2 HDD affects speed hda
Cc: linux-kernel@vger.kernel.org
References: <429BA001.2030405@keyaccess.nl>
 <200506011643.42073.david-b@pacbell.net>
 <Pine.LNX.4.58.0506020316240.28167@artax.karlin.mff.cuni.cz>
 <200506011917.14678.david-b@pacbell.net>
 <429F075F.7030804@keyaccess.nl> <42F3E95B.4050704@keyaccess.nl>
In-Reply-To: <42F3E95B.4050704@keyaccess.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050917023639.B49481FF9E@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi David. Has there been any progress on this issue?
>
> (thread at http://marc.theaimsgroup.com/?t=111749614000002&r=1&w=2)

Taking a look at that, I found one case that _might_ explain it.  That
scenario could crop more (or less) based on loads and timings, and I've
suspected that the VIA chips have significantly different timings for
certain things.  This patch handles that case differently, just expecting
the unlink completion code (later) to restart the schedule.

I sanity tested this, but that's all.

- Dave

--- g26.orig/drivers/usb/host/ehci-q.c	2005-09-12 17:58:21.000000000 -0700
+++ g26/drivers/usb/host/ehci-q.c	2005-09-14 10:26:07.000000000 -0700
@@ -781,7 +781,7 @@ static void qh_link_async (struct ehci_h
 	/* (re)start the async schedule? */
 	head = ehci->async;
 	timer_action_done (ehci, TIMER_ASYNC_OFF);
-	if (!head->qh_next.qh) {
+	if (!head->qh_next.qh && !ehci->reclaim) {
 		u32	cmd = readl (&ehci->regs->command);
 
 		if (!(cmd & CMD_ASE)) {
