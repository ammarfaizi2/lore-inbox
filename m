Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932694AbVKBJqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694AbVKBJqu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 04:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbVKBJqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 04:46:50 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:36956 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932694AbVKBJqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 04:46:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=RzdGzKtfep60VmLK5wMe87CvCFC/bvdamYV7DtIeHsrOSCEFHPwaWrWrk0n7r5osFdJpn83QmdlbUzGW4w3Zx5XYP9fihDkTg/7fnWOksfFeQFWzPpVpPMvFRZ3MPJIflppkrJwUCMgYhSlNW6qn3s9U1fVDNWyheFF0Lj69DTo=  ;
Message-ID: <43688B74.20002@yahoo.com.au>
Date: Wed, 02 Nov 2005 20:48:36 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Ingo Molnar <mingo@elte.hu>, Mel Gorman <mel@csn.ul.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <4366C559.5090504@yahoo.com.au>	 <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au>	 <Pine.LNX.4.58.0511011014060.14884@skynet> <20051101135651.GA8502@elte.hu>	 <1130854224.14475.60.camel@localhost> <20051101142959.GA9272@elte.hu>	 <1130856555.14475.77.camel@localhost> <20051101150142.GA10636@elte.hu>	 <1130858580.14475.98.camel@localhost> <20051102084946.GA3930@elte.hu>	 <436880B8.1050207@yahoo.com.au> <1130923969.15627.11.camel@localhost>
In-Reply-To: <1130923969.15627.11.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Wed, 2005-11-02 at 20:02 +1100, Nick Piggin wrote:
> 
>>I agree. Especially considering that all this memory hotplug usage for
>>hypervisors etc. is a relatively new thing with few of our userbase
>>actually using it. I think a simple zones solution is the right way to
>>go for now.
> 
> 
> I agree enough on concept that I think we can go implement at least a
> demonstration of how easy it is to perform.
> 
> There are a couple of implementation details that will require some
> changes to the current zone model, however.  Perhaps you have some
> suggestions on those.
> 
> In which zone do we place hot-added RAM?  I don't think answer can
> simply be the HOTPLUGGABLE zone.  If you start with sufficiently small
> of a machine, you'll degrade into the same horrible HIGHMEM behavior
> that a 64GB ia32 machine has today, despite your architecture.  Think of
> a machine that starts out with a size of 256MB and grows to 1TB.
> 

What can we do reasonably sanely? I think we can drive about 16GB of
highmem per 1GB of normal fairly well. So on your 1TB system, you
should be able to unplug 960GB RAM.

Lower the ratio to taste if you happen to be doing something
particularly zone normal intensive - remember in that case the frag
patches won't buy you anything more because a zone normal intensive
workload is going to cause unreclaimable regions by definition.

> So, if you have to add to NORMAL/DMA on the fly, how do you handle a
> case where the new NORMAL/DMA ram is physically above
> HIGHMEM/HOTPLUGGABLE?  Is there any other course than to make a zone
> required to be able to span other zones, and be noncontiguous?  Would
> that represent too much of a change to the current model?
> 

Perhaps. Perhaps it wouldn't be required to get a solution that is
"good enough" though.

But if you can reclaim your ZONE_RECLAIMABLE, then you could reclaim
it all and expand your normal zones into it, bottom up.

>>From where do we perform reclaim when we run out of a particular zone?
> Getting reclaim rates of the HIGHMEM and NORMAL zones balanced has been
> hard, and I worry that we never got it quite.  Introducing yet another
> zone makes this harder.
> 

We didn't get it right, but there are fairly simple things we can do
(http://marc.theaimsgroup.com/?l=linux-kernel&m=113082256231168&w=2)
to improve things remarkably, and having yet more users should result
in even more improvements.

We still have ZONE_DMA and ZONE_DMA32, so we can't just afford to
abandon zones because they're crap ;)

> Should we allow allocations for NORMAL to fall back into HOTPLUGGABLE in
> any case?
> 

I think this would defeat the purpose if we really want to set limits,
but we could have a sysctl perhaps to turn it on or off, or say, only
allow it if the alternative is going OOM.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
