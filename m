Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273535AbRIUP2R>; Fri, 21 Sep 2001 11:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273578AbRIUP2H>; Fri, 21 Sep 2001 11:28:07 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:29077 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S273535AbRIUP1u>; Fri, 21 Sep 2001 11:27:50 -0400
Date: Fri, 21 Sep 2001 11:27:23 -0400
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Rob Fuller <rfuller@nsisoftware.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: broken VM in 2.4.10-pre9
Message-ID: <20010921112722.A3646@cs.cmu.edu>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	Rik van Riel <riel@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Rob Fuller <rfuller@nsisoftware.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.33L.0109200903100.19147-100000@imladris.rielhome.conectiva> <20010921080549Z16344-2758+350@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010921080549Z16344-2758+350@humbolt.nl.linux.org>
User-Agent: Mutt/1.3.20i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2001 at 10:13:11AM +0200, Daniel Phillips wrote:
>   - small inactive list really means large active list (and vice versa)
>   - aging increments need to depend on the size of the active list
>   - "exponential" aging may be completely bogus

I don't think so, whenever there is sufficient memory pressure, the scan
of the active list is not only done by kswapd, but also by the page
allocations.

This does have the nice effect that with a large active list on a system
that has a working set that fits in memory, pages basically always age
up, and we get an automatic used-once/drop-behind behaviour for
streaming data because the age of these pages is relatively low.

As soon as the rate of new allocations increases to the point that
kswapd can't keep up, which happens if the number of cached used-once
pages is too small, or the working set expands so that it doesn't fit in
memory. The memory shortage then causes all pages to agressively get
aged down, pushing out the less frequently used pages of the working set.

Exponential down aging simply causes us to loop fewer times in
do_try_to_free_pages is such situations.

Jan

