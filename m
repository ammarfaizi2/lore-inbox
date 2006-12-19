Return-Path: <linux-kernel-owner+w=401wt.eu-S1752793AbWLSGix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbWLSGix (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 01:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789AbWLSGix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 01:38:53 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:33257 "HELO
	smtp108.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752724AbWLSGiw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 01:38:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=ydBozdbnEj3tAdHUgeBt57nCcpVIrT7btevJ1MMCgWi0l0tGwK7PnrkeaDR3/lfK1mwVfw6xSGYWbtY0aucqIlybBzmYI+mTuOTUFOmm4RA2HdlkVTz0IY03GxkNEe8+d/YeAI4zELxr8heHP0AWsg6fFkIBBGEt6mkQ127CzFs=  ;
X-YMail-OSG: r9aozTgVM1mYx2QrcXmOjDgpdAQeapBywVh2G7hjIvA0Jf0fVAh0HtfIsxrQfSxYSXc5LkxMQIbpZ53zsCFUL0E8EvqSHD7e1GwfZl7L8AOKQ37Mt6kn8RbjE0azuSxyqYkEfY8mvJoRD4Q-
Message-ID: <458788D7.2070107@yahoo.com.au>
Date: Tue, 19 Dec 2006 17:38:15 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Manish Regmi <regmi.manish@gmail.com>
CC: Erik Mouw <mouw@nl.linux.org>, kernelnewbies@nl.linux.org,
       linux-kernel@vger.kernel.org
Subject: Re: Linux disk performance.
References: <652016d30612172007m58d7a828q378863121ebdc535@mail.gmail.com>	 <1166431020.3365.931.camel@laptopd505.fenrus.org>	 <652016d30612180439y6cd12089l115e4ef6ce2e59fe@mail.gmail.com>	 <20061218130702.GA14984@gateway.home> <652016d30612182222h7fde4ea5jbc0927c8ebeae76a@mail.gmail.com>
In-Reply-To: <652016d30612182222h7fde4ea5jbc0927c8ebeae76a@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------040407040209040306090302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040407040209040306090302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Manish Regmi wrote:

> Nick Piggin:
> 
>> but
>> they look like they might be a (HZ quantised) delay coming from
>> block layer plugging.
> 
> 
> Sorry i didn´t understand what you mean.

When you submit a request to an empty block device queue, it can
get "plugged" for a number of timer ticks before any IO is actually
started. This is done for efficiency reasons and is independent of
the IO scheduler used.

Use the noop IO scheduler, as well as the attached patch, and let's
see what your numbers look like.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

--------------040407040209040306090302
Content-Type: text/plain;
 name="block-no-plug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="block-no-plug.patch"

Index: linux-2.6/block/ll_rw_blk.c
===================================================================
--- linux-2.6.orig/block/ll_rw_blk.c	2006-12-19 17:35:00.000000000 +1100
+++ linux-2.6/block/ll_rw_blk.c	2006-12-19 17:35:53.000000000 +1100
@@ -226,6 +226,8 @@ void blk_queue_make_request(request_queu
 	q->unplug_delay = (3 * HZ) / 1000;	/* 3 milliseconds */
 	if (q->unplug_delay == 0)
 		q->unplug_delay = 1;
+	q->unplug_delay = 0;
+	q->unplug_thresh = 0;
 
 	INIT_WORK(&q->unplug_work, blk_unplug_work, q);
 

--------------040407040209040306090302--
Send instant messages to your online friends http://au.messenger.yahoo.com 
