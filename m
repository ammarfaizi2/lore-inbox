Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbVKQNpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVKQNpX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 08:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVKQNpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 08:45:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:26142 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750825AbVKQNpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 08:45:22 -0500
Date: Thu, 17 Nov 2005 14:46:32 +0100
From: Jens Axboe <axboe@suse.de>
To: Dirk Henning Gerdes <mail@dirk-gerdes.de>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6-14-mm2] block: problem unloading I/O-Scheduler Module
Message-ID: <20051117134632.GJ7787@suse.de>
References: <20051019123429.450E4424@htj.dyndns.org> <20051019123429.D377069C@htj.dyndns.org> <20051020112109.GC2811@suse.de> <20051020135124.GB26004@htj.dyndns.org> <20051020141104.GQ2811@suse.de> <4357AB3F.1050004@gmail.com> <20051020144108.GR2811@suse.de> <4357B10E.7010608@gmail.com> <1132234464.4856.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132234464.4856.12.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17 2005, Dirk Henning Gerdes wrote:
> If you have compiled an I/O-Scheduler as module you cannot unload it,
> because of a memory-error.
> 
> Signed-off-by: Dirk Gerdes mail@dirk-gerdes.de
> 
> --- linux-2.6.14-mm2-pagecache/block/elevator.c	2005-11-17
> 12:37:10.000000000 +0100
> +++ linux-2.6.14-mm2-pagecache_fix/block/elevator.c	2005-11-17
> 14:05:41.000000000 +0100
> @@ -656,7 +656,7 @@
>  		struct io_context *ioc = p->io_context;
>  		struct cfq_io_context *cic;
>  
> -		if (ioc->cic_root.rb_node != NULL) {
> +		if (ioc != NULL && ioc->cic_root.rb_node != NULL) {
>  			cic = rb_entry(rb_first(&ioc->cic_root), struct cfq_io_context,
> rb_node);
>  			cic->exit(ioc);
>  			cic->dtor(ioc);

Shouldn't that just read

        if (!ioc)
                continue;

instead? Otherwise you'd crash on 'as' exit next. Ah, it already has
that. Ok, so I prefer this (what I merged).


diff --git a/block/elevator.c b/block/elevator.c
index 5720409..0c389a0 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -652,13 +652,16 @@ void elv_unregister(struct elevator_type
 		struct io_context *ioc = p->io_context;
 		struct cfq_io_context *cic;
 
+		if (!ioc)
+			continue;
+
 		if (ioc->cic_root.rb_node != NULL) {
 			cic = rb_entry(rb_first(&ioc->cic_root), struct cfq_io_context, rb_node);
 			cic->exit(ioc);
 			cic->dtor(ioc);
 		}
 
-		if (ioc && ioc->aic) {
+		if (ioc->aic) {
 			ioc->aic->exit(ioc->aic);
 			ioc->aic->dtor(ioc->aic);
 			ioc->aic = NULL;

-- 
Jens Axboe

