Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264657AbTFLAzl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 20:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264659AbTFLAzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 20:55:41 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:12275 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S264657AbTFLAzi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 20:55:38 -0400
Subject: [patch] as-iosched divide by zero fix
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: bos@serpentine.com, linux-kernel@vger.kernel.org, piggin@cyberone.com.au
In-Reply-To: <20030611172444.76556d5d.akpm@digeo.com>
References: <1055369849.1084.4.camel@serpentine.internal.keyresearch.com>
	 <20030611154122.55570de0.akpm@digeo.com> <1055374476.673.1.camel@localhost>
	 <1055377120.665.6.camel@localhost> <20030611172444.76556d5d.akpm@digeo.com>
Content-Type: text/plain
Message-Id: <1055380257.662.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 11 Jun 2003 18:10:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 17:24, Andrew Morton wrote:

> Do you know what the actual oops is?

I got it all figured out now.

It is a divide by zero in update_write_batch() called from
as_completed_request().

> Odd that starting the X server triggers it.  Be interesting if your patch
> fixes things for Brian.

I reproduced it without X.

The divide by zero is on line 959 with the divide by 'write_time'. It
can obviously be zero (see line 950). The divide by 'batch' on line 953
seems safe.

The correct patch is below.

Most important question: why are only some of us seeing this?

	Robert Love


Fix as-iosched divide-by-zero bug.

 drivers/block/as-iosched.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -urN linux-2.5.70-mm8/drivers/block/as-iosched.c linux/drivers/block/as-iosched.c
--- linux-2.5.70-mm8/drivers/block/as-iosched.c	2003-06-11 17:12:02.000000000 -0700
+++ linux/drivers/block/as-iosched.c	2003-06-11 18:04:15.222619392 -0700
@@ -954,9 +954,9 @@
 			ad->write_batch_count /= 2;
 		else
 			ad->write_batch_count--;
-		
+
 	} else if (write_time + 5 < batch && ad->current_write_count == 0) {
-		if (batch / write_time > 2)
+		if (write_time && (batch / write_time > 2))
 			ad->write_batch_count *= 2;
 		else
 			ad->write_batch_count++;



