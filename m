Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264894AbUABFI6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 00:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbUABFI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 00:08:58 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:37053 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264894AbUABFI4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 00:08:56 -0500
Date: Fri, 2 Jan 2004 10:44:22 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Daniel McNeil <daniel@osdl.org>, janetmor@us.ibm.com, pbadari@us.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6.1-rc1-mm1] aiodio_fallback_bio_count.patch
Message-ID: <20040102051422.GB3311@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20031231015913.34fc0176.akpm@osdl.org> <20031231100949.GA4099@in.ibm.com> <20031231021042.5975de04.akpm@osdl.org> <20031231104801.GB4099@in.ibm.com> <20031231025309.6bc8ca20.akpm@osdl.org> <20031231025410.699a3317.akpm@osdl.org> <20031231031736.0416808f.akpm@osdl.org> <1072910061.712.67.camel@ibm-c.pdx.osdl.net> <1072910475.712.74.camel@ibm-c.pdx.osdl.net> <20031231154648.2af81331.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031231154648.2af81331.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Dec 31, 2003 at 03:46:48PM -0800, Andrew Morton wrote:
> Daniel McNeil <daniel@osdl.org> wrote:
> >
> > This is an update of AIO fallback patch and with the bio_count race
> >  fixed by changing bio_list_lock into bio_lock and using that for all
> >  the bio fields.  I changed bio_count and bios_in_flight from atomics
> >  into int.  They are now proctected by the bio_lock.  I fixed the race,
> >  by in finished_one_bio() by leaving the bio_count at 1 until after the
> >  dio_complete() and then do the bio_count decrement and wakeup holding
> >  the bio_lock.
> 
> Sob.  Daniel, please assume that I have an extremely small brain and forget
> things very easily.  And that 2,000 patches have passed under my nose since
> last I contemplated the direct-io code, OK?
> 
> What bio_count race?
> 
> And the patch seems to be doing more than your description describes?
> --

We need to combine this with my original patch description of the
aio-dio-fallback + follow on patch which had the race that Daniel
fixed and then rolled together into one working patch.

Does the following sound better as complete description ?

-----------------------------------------------------------------

This patch ensures that when the DIO code falls back to buffered i/o 
after having submitted part of the i/o, then buffered i/o is issued only
for the remaining part of the request (i.e. the part not already
covered by DIO), rather than redo the entire i/o.

We need to careful not to access dio fields if its possible that 
the dio could already have been freed asynchronously during i/o 
completion. A tricky part of this involves plugging the window between 
the decrement of bio_count and accessing dio->waiter during i/o 
completion where the dio could get freed by the submission path. 
This potential "bio_count race" was tackled (by Daniel) by changing 
bio_list_lock into bio_lock and using that for all the bio fields. 
Now bio_count and bios_in_flight have been converted from atomics 
into int and are both protected by the bio_lock. The race in 
finished_one_bio() could thus be fixed by leaving the bio_count at 1 
until after the dio_complete() and then doing the bio_count decrement 
and wakeup holding the bio_lock. It appears that shifting to the
spin_lock instead of atomic_inc/decs is ok performance wise as 
well.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

