Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264659AbTFLBIR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 21:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264662AbTFLBIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 21:08:17 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:26164 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264659AbTFLBIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 21:08:10 -0400
Date: Wed, 11 Jun 2003 18:22:49 -0700
From: Andrew Morton <akpm@digeo.com>
To: Robert Love <rml@tech9.net>
Cc: bos@serpentine.com, linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: [patch] as-iosched divide by zero fix
Message-Id: <20030611182249.0f1168e4.akpm@digeo.com>
In-Reply-To: <1055380257.662.8.camel@localhost>
References: <1055369849.1084.4.camel@serpentine.internal.keyresearch.com>
	<20030611154122.55570de0.akpm@digeo.com>
	<1055374476.673.1.camel@localhost>
	<1055377120.665.6.camel@localhost>
	<20030611172444.76556d5d.akpm@digeo.com>
	<1055380257.662.8.camel@localhost>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jun 2003 01:21:54.0393 (UTC) FILETIME=[024B9C90:01C33081]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@tech9.net> wrote:
>
> Fix as-iosched divide-by-zero bug.

hrm, OK.  Still not convinced about `batch'.

How about this?

--- 25/drivers/block/as-iosched.c~as-div-by-zero-fix	2003-06-11 18:17:04.000000000 -0700
+++ 25-akpm/drivers/block/as-iosched.c	2003-06-11 18:20:58.000000000 -0700
@@ -930,13 +930,12 @@ void update_write_batch(struct as_data *
 		write_time = 0;
 
 	if (write_time > batch + 5 && !ad->write_batch_idled) {
-		if (write_time / batch > 2)
+		if (write_time > batch * 2)
 			ad->write_batch_count /= 2;
 		else
 			ad->write_batch_count--;
-		
 	} else if (write_time + 5 < batch && ad->current_write_count == 0) {
-		if (batch / write_time > 2)
+		if (batch > write_time * 2)
 			ad->write_batch_count *= 2;
 		else
 			ad->write_batch_count++;

_

