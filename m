Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSHISbL>; Fri, 9 Aug 2002 14:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315415AbSHISbK>; Fri, 9 Aug 2002 14:31:10 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:64470 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315413AbSHISbK>; Fri, 9 Aug 2002 14:31:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Daniel Phillips <phillips@arcor.de>, davidm@hpl.hp.com,
       David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: large page patch (fwd) (fwd)
Date: Fri, 9 Aug 2002 14:32:38 -0400
User-Agent: KMail/1.4.1
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, torvalds@transmeta.com,
       gh@us.ibm.com, Martin.Bligh@us.ibm.com, wli@holomorpy.com,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208031240270.9758-100000@home.transmeta.com> <200208041319.05210.frankeh@watson.ibm.com> <E17dBZN-0001Ng-00@starship>
In-Reply-To: <E17dBZN-0001Ng-00@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208091432.38561.frankeh@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 August 2002 11:20 am, Daniel Phillips wrote:
> On Sunday 04 August 2002 19:19, Hubertus Franke wrote:
> > "General Purpose Operating System Support for Multiple Page Sizes"
> > htpp://www.usenix.org/publications/library/proceedings/usenix98/full_pape
> >rs/ganapathy/ganapathy.pdf
>
> This reference describes roughly what I had in mind for active
> defragmentation, which depends on reverse mapping.  The main additional
> wrinkle I'd contemplated is introducing a new ZONE_LARGE, and GPF_LARGE,
> which means the caller promises not to pin the allocation unit for long
> periods and does not mind if the underlying physical page changes
> spontaneously.  Defragmenting in this zone is straightforward.

I think the objection to that is that in many cases the cost of 
defragmentation is to heavy to be recollectable through TLB miss handling 
alone.
What the above paper does is a reservation protocol with timeouts
which decide that either (a) the reserved mem was used in time and hence
the page is upgraded to a large page OR (b) the reserved mem is not used and
hence unused parts are released. 
It relies on the fact that within the given timeout, most/mamy pages are 
typically referenced.

In our patch we have the ZONE_LARGE into which we allocate the
large page. Currently they are effectively pinned down, but in 2.4.18
we had it backed by the page cache.

My gut feeling right now would be to follow the reservation based scheme, 
but as said its a gut feeling.
Defragmenting to me seems a matter of last resort, Copying pages is expensive.
If you however simply target the superpages for smaller clusters, then its an
option. But at the same time one might contemplate to simply make 
the base page 16K or 32K and page fault time simply map / swap / read / 
writeback the whole cluster.
What studies has been done on this wrt to benefits of such an approach.
I talked to Ted Tso who would really like small super pages for better I/O 
performance...

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
