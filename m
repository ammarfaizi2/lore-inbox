Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266513AbUHBNZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266513AbUHBNZN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 09:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266517AbUHBNZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 09:25:13 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:13263 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266513AbUHBNZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 09:25:06 -0400
Date: Mon, 2 Aug 2004 15:24:57 +0200
From: Jens Axboe <axboe@suse.de>
To: David Ford <david+challenge-response@blue-labs.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       wiggly@wiggly.org, dnarnold@yahoo.com, matt@mattcaron.net,
       seymour@astro.utoronto.ca
Subject: Re: cdrom: dropping to single frame dma
Message-ID: <20040802132457.GT10496@suse.de>
References: <41040A4B.6080703@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41040A4B.6080703@blue-labs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 25 2004, David Ford wrote:
> I've been trying to rip my CDs onto my HD, and last night after about 7 
> CDs I realized I was getting junk and it was taking forever to rip a 
> CD.  I'm using 2.6.8-rc2 and I have two different CD-ROMs in my 
> machine.  Both are burners.
> 
> I got a single "cdrom: dropping to single frame dma" message which 
> according to my research is part of the culprit.
> 
> See the thread on LKML back on 5/15/2004 titled "dma ripping", and again 
> on 6/15 titled "cdrom ripping / dropping to dingle frame dma" -- yes 
> that's a "d".
> 
> I'm guessing that Jens' patch for this didn't make it into the kernel.

Try this.

--- linux-2.6.8-rc2-mm1/drivers/cdrom/cdrom.c~	2004-08-02 14:56:48.259992912 +0200
+++ linux-2.6.8-rc2-mm1/drivers/cdrom/cdrom.c	2004-08-02 15:20:58.326549288 +0200
@@ -2004,6 +2004,8 @@
 	struct packet_command cgc;
 	int nr, ret;
 
+	cdi->last_sense = 0;
+
 	memset(&cgc, 0, sizeof(cgc));
 
 	/*
@@ -2055,6 +2057,8 @@
 	if (!q)
 		return -ENXIO;
 
+	cdi->last_sense = 0;
+
 	while (nframes) {
 		nr = nframes;
 		if (cdi->cdda_method == CDDA_BPC_SINGLE)
@@ -2102,6 +2106,7 @@
 
 		nframes -= nr;
 		lba += nr;
+		ubuf += len;
 	}
 
 	return ret;

-- 
Jens Axboe

