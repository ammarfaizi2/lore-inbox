Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265567AbUBFWko (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 17:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUBFWkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 17:40:43 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:28032 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265567AbUBFWkd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 17:40:33 -0500
Message-ID: <402417DA.4070308@cyberone.com.au>
Date: Sat, 07 Feb 2004 09:40:26 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rick Lindsley <ricklind@us.ibm.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, mjbligh@us.ibm.com,
       dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
References: <200402062230.i16MU8313429@owlet.beaverton.ibm.com>
In-Reply-To: <200402062230.i16MU8313429@owlet.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rick Lindsley wrote:

>    We also shouldn't need load_diff, because if (avg_load <= this_load)
>    then imbalance will be zero, so I'll fix that up.
>
>Are we sure imbalance will be zero?  I think we still need that.  We can
>turn it into a single C statement if we want to be clever but what you
>save in temporary variable we'd better replace in comments to make the
>cleverness plain.  We need there to be no "negative" numbers in the
>min() statement in case max-avg is non-zero but avg-this is "negative".
>
>Imagine loads of
>
>    cpu0	0
>    cpu1	0
>    cpu2	3 
>    cpu3	2
>    cpu4	0
>
>and we're running on cpu3.
>
>    max_load=3
>    avg_load=1
>    this_load=2
>
>min(max-avg, avg-this) will be min(3-1,1-2) or two, and we'll choose to
>try to pull two to cpu3 instead of just leaving it alone which is the
>right thing to do.
>
>

No you definitely still need the test... this is what I mean:

       if (avg_load > this_load)
                *imbalance = min(max_load - avg_load, avg_load - this_load);
        else
                *imbalance = 0;


