Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264623AbTFLAO5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 20:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264624AbTFLAO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 20:14:57 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:13101 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264623AbTFLAO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 20:14:56 -0400
Date: Wed, 11 Jun 2003 17:24:44 -0700
From: Andrew Morton <akpm@digeo.com>
To: Robert Love <rml@tech9.net>
Cc: bos@serpentine.com, linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: 2.5.70-mm8: freeze after starting X
Message-Id: <20030611172444.76556d5d.akpm@digeo.com>
In-Reply-To: <1055377120.665.6.camel@localhost>
References: <1055369849.1084.4.camel@serpentine.internal.keyresearch.com>
	<20030611154122.55570de0.akpm@digeo.com>
	<1055374476.673.1.camel@localhost>
	<1055377120.665.6.camel@localhost>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jun 2003 00:28:39.0934 (UTC) FILETIME=[923FD9E0:01C33079]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@tech9.net> wrote:
>
> On Wed, 2003-06-11 at 16:34, Robert Love wrote:
> 
> > I will debunk both theories: its not Radeon (I have a Matrox) and its
> > not the pci-init-ordering-fix patch (I already tried that).
> 
> Ah, it is the anticipatory I/O scheduler.
> 
> There is a logic thinko somewhere... I have not found it yet, but I have
> narrowed it down to something which the attached patch fixes (i.e.,
> apply this patch and the problem is fixed).
> 
> Maybe Nick can see the bug and short circuit my search? The problem is
> related to the as-autotune-write-batches patch.

Do you know what the actual oops is?

Odd that starting the X server triggers it.  Be interesting if your patch
fixes things for Brian.

There appear to be several divide-by-zero possibilities in there.  A random
patch would be:



diff -puN drivers/block/as-iosched.c~a drivers/block/as-iosched.c
--- 25/drivers/block/as-iosched.c~a	Wed Jun 11 17:23:42 2003
+++ 25-akpm/drivers/block/as-iosched.c	Wed Jun 11 17:23:42 2003
@@ -950,13 +950,13 @@ void update_write_batch(struct as_data *
 		write_time = 0;
 
 	if (write_time > batch + 5 && !ad->write_batch_idled) {
-		if (write_time / batch > 2)
+		if (batch && (write_time / batch > 2))
 			ad->write_batch_count /= 2;
 		else
 			ad->write_batch_count--;
 		
 	} else if (write_time + 5 < batch && ad->current_write_count == 0) {
-		if (batch / write_time > 2)
+		if (write_time && (batch / write_time > 2))
 			ad->write_batch_count *= 2;
 		else
 			ad->write_batch_count++;

_

