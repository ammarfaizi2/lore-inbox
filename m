Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267210AbTGLAAi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 20:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267214AbTGLAAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 20:00:38 -0400
Received: from dyn-ctb-203-221-74-60.webone.com.au ([203.221.74.60]:14852 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S267210AbTGLAAZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 20:00:25 -0400
Message-ID: <3F0F52D9.70802@cyberone.com.au>
Date: Sat, 12 Jul 2003 10:14:17 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@zip.com.au>
CC: Matthew Wilcox <willy@debian.org>, Bernardo Innocenti <bernie@develer.com>,
       linux-kernel@vger.kernel.org
Subject: Re: do_div vs sector_t (patch)
References: <20030711223359.GP20424@parcelfarce.linux.theplanet.co.uk> <16143.15690.106092.770785@gargle.gargle.HOWL>
In-Reply-To: <16143.15690.106092.770785@gargle.gargle.HOWL>
Content-Type: multipart/mixed;
 boundary="------------090206080507090502010207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090206080507090502010207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Neil Brown wrote:

>On Friday July 11, willy@debian.org wrote:
>
>># define do_div(n,base) ({                              \
>>        uint32_t __base = (base);                       \
>>        uint32_t __rem;                                 \
>>        if (likely(((n) >> 32) == 0)) {                 \
>>
>>so if we call do_div() on a u32, the compiler emits nasal daemons.
>>and we do this -- in the antcipatory scheduler:
>>
>>                if (aic->seek_samples) {
>>                        aic->seek_mean = aic->seek_total + 128;
>>                        do_div(aic->seek_mean, aic->seek_samples);
>>                }
>>
>>seek_mean is a sector_t so sometimes it's 64-bit on a 32-bit platform.
>>so we can't avoid calling do_div().
>>
>>This almost works (the warning is harmless since gcc optimises away the call)
>>
>># define do_div(n,base) ({                                              \
>>        uint32_t __base = (base);                                       \
>>        uint32_t __rem;                                                 \
>>        if ((sizeof(n) < 8) || (likely(((n) >> 32) == 0))) {            \
>>                __rem = (uint32_t)(n) % __base;                         \
>>                (n) = (uint32_t)(n) / __base;                           \
>>        } else                                                          \
>>                __rem = __div64_32(&(n), __base);                       \
>>        __rem;                                                          \
>> })
>>
>>Better ideas?
>>
>
>sector_div, defined in blkdev.h, is probably what you want.
>

Looks right. Following patch alright?


--------------090206080507090502010207
Content-Type: text/plain;
 name="as-do-div"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="as-do-div"

--- linux-2.5/drivers/block/as-iosched.c.orig	2003-07-12 10:12:20.000000000 +1000
+++ linux-2.5/drivers/block/as-iosched.c	2003-07-12 10:12:28.000000000 +1000
@@ -837,7 +837,7 @@ static void as_update_iohist(struct as_i
 		aic->seek_total += 256*seek_dist;
 		if (aic->seek_samples) {
 			aic->seek_mean = aic->seek_total + 128;
-			do_div(aic->seek_mean, aic->seek_samples);
+			sector_div(aic->seek_mean, aic->seek_samples);
 		}
 		aic->seek_samples = (aic->seek_samples>>1)
 					+ (aic->seek_samples>>2);

--------------090206080507090502010207--

