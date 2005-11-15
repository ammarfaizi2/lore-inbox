Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932567AbVKOXY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbVKOXY0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 18:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbVKOXYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 18:24:25 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:64909 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932567AbVKOXYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 18:24:24 -0500
Date: Tue, 15 Nov 2005 15:24:14 -0800
From: Paul Jackson <pj@sgi.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-mm@kvack.org, mel@csn.ul.ie, mingo@elte.hu,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: [PATCH 4/5] Light Fragmentation Avoidance V20: 004_percpu
Message-Id: <20051115152414.568dc3a8.pj@sgi.com>
In-Reply-To: <20051115165007.21980.37336.sendpatchset@skynet.csn.ul.ie>
References: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie>
	<20051115165007.21980.37336.sendpatchset@skynet.csn.ul.ie>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel wrote:
> -		mark -= mark / 2;			[A]
> +		mark /= 2;				[B]
>  	if (alloc_flags & ALLOC_HARDER)
> -		mark -= mark / 4;			[C]
> +		mark /= 4;				[D]

Why these changes?  For each of [A] - [D] above, if I start with a
value of mark == 33 and recycle that same mark through the above
transformation 16 times, I get the following sequence of values:

 A:  33  17   9   5   3   2   1   1   1   1   1   1   1   1   1   1
 B:  33  16   8   4   2   1   0   0   0   0   0   0   0   0   0   0
 C:  33  25  19  15  12   9   7   6   5   4   3   3   3   3   3   3
 D:  33   8   2   0   0   0   0   0   0   0   0   0   0   0   0   0

Comparing [A] to [B], observe that [A] converges to 1, but [B] to 0,
due to handling the underflow differently.

Comparing [C] to [D], observe that [D] converges to 0, due to the
different underflow, and converges much faster, since it is taking off
3/4's instead of 1/4 each iteration.

I doubt you want this change.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
