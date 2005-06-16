Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVFPDrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVFPDrR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 23:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVFPDrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 23:47:17 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:924 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261715AbVFPDrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 23:47:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=jxT1b7dVhQZvsuFeTUnDzdj+/ZCvqM4Ni8zo8WFWroNrZrI2I0X/iJ4JEnET7kt8Qs/L/lrKxv1YJb2FSKyVK+BFvtAiOy9PThnzkVQSvCA752sM0mgPG+IwTCBJRdggzXzoee78c+pvCdlVGPbPlbS2K4A8tQ8gJtskNuBSf3g=
Date: Thu, 16 Jun 2005 12:47:06 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH linux-2.6.12-rc6-mm1] blk: elevator unplug thresh hanlding fix
Message-ID: <20050616034705.GA29048@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Jens.
 Hello, Andrew.

 This patch fixes q->unplug_thresh condition check in
__elv_add_request().  rq.count[READ] + rq.count[WRITE] can increase
more than one if another thread has allocated a request after the
current request is allocated or in_flight could have changed resulting
in larger-than-one change of nrq, thus breaking the threshold
mechanism.

 Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: blk-fixes/drivers/block/elevator.c
===================================================================
--- blk-fixes.orig/drivers/block/elevator.c	2005-06-16 12:16:59.000000000 +0900
+++ blk-fixes/drivers/block/elevator.c	2005-06-16 12:17:03.000000000 +0900
@@ -352,7 +352,7 @@ void __elv_add_request(request_queue_t *
 			int nrq = q->rq.count[READ] + q->rq.count[WRITE]
 				  - q->in_flight;
 
-			if (nrq == q->unplug_thresh)
+			if (nrq >= q->unplug_thresh)
 				__generic_unplug_device(q);
 		}
 	} else

