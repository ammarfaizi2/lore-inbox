Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbWCFRon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWCFRon (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 12:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751970AbWCFRon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 12:44:43 -0500
Received: from dsl093-016-182.msp1.dsl.speakeasy.net ([66.93.16.182]:13277
	"EHLO cinder.waste.org") by vger.kernel.org with ESMTP
	id S1751426AbWCFRom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 12:44:42 -0500
Date: Mon, 6 Mar 2006 11:44:23 -0600
From: Matt Mackall <mpm@selenic.com>
To: "Anders K. Pedersen" <akp@cohaesio.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Let DAC960 supply entropy to random pool
Message-ID: <20060306174423.GY14549@waste.org>
References: <1140713078.16199.25.camel@homer.cohaesio.com> <20060227000540.GN4650@waste.org> <1141644324.3627.15.camel@homer.cohaesio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141644324.3627.15.camel@homer.cohaesio.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 12:25:24PM +0100, Anders K. Pedersen wrote:
> On Mon, 2006-02-27 at 01:05, Matt Mackall wrote:
> > On Thu, Feb 23, 2006 at 05:44:38PM +0100, Anders K. Pedersen wrote:
> > > We have a couple of servers with Mylex RAID controllers (handled by the
> > > DAC960 block device driver). There's normally no keyboard or mouse
> > > attached, and neither the DAC960 nor the NIC driver (e100) provides
> > > entropy to the random pool, so it was impossible to get any data from
> > > /dev/random.
> > 
> > Doesn't the add_disk_randomness call in ll_rw_blk.c suffice? This is
> > the proper path for disks to add entropy.
> 
> Apparently the add_disk_randomness call in ll_rw_blk.c isn't invoked for
> my setup. There were absolutely no data available from /dev/random for
> more than an hour (with heavy disk activity) before applying the
> dac960.c patch, and after applying it, random data were instantly
> available.

Ok, we probably want this patch. Please test.

Add disk entropy in DAC960 request completions.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6/drivers/block/DAC960.c
===================================================================
--- 2.6.orig/drivers/block/DAC960.c	2006-03-01 23:32:32.000000000 -0600
+++ 2.6/drivers/block/DAC960.c	2006-03-06 11:41:45.000000000 -0600
@@ -41,6 +41,7 @@
 #include <linux/timer.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/random.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include "DAC960.h"
@@ -3463,7 +3464,7 @@ static inline boolean DAC960_ProcessComp
 		Command->SegmentCount, Command->DmaDirection);
 
 	 if (!end_that_request_first(Request, UpToDate, Command->BlockCount)) {
-
+		add_disk_randomness(Request->rq_disk);
  	 	end_that_request_last(Request, UpToDate);
 
 		if (Command->Completion) {


-- 
Mathematics is the supreme nostalgia of our time.
