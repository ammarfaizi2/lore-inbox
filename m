Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbVKWBHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbVKWBHR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 20:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbVKWBHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 20:07:17 -0500
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:14468 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1030296AbVKWBHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 20:07:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=FEDy7LqoMtVqQMrKJ96gf+EJJZ7ycT/rs7qyufJLYYK8U6iH/v7LHEcXXVamLn7MsS1GRfaVIlFhsOV9qWJQzlxewoLXTRehVl9lx78JU188S99xER8tsQO1Ih/DsAlDvUwCC9XyAwiAIkFdvGxdO0J5qEHvr8o+/Vtl86/E2eI=  ;
Message-ID: <4383CF6C.4060001@yahoo.com.au>
Date: Wed, 23 Nov 2005 13:09:48 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 6/12] mm: remove bad_range
References: <20051121123906.14370.3039.sendpatchset@didi.local0.net>	 <20051121124126.14370.50844.sendpatchset@didi.local0.net> <1132662725.6696.45.camel@localhost>
In-Reply-To: <1132662725.6696.45.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

> 
> I seem to also remember a case with this bad_range() check was useful
> for zones that don't have their boundaries aligned on a MAX_ORDER
> boundary.  Would this change break such a zone?  Do we care?
> 

Hmm, I guess that would be covered by the:

         if (page_to_pfn(page) >= zone->zone_start_pfn + zone->spanned_pages)
                 return 1;
         if (page_to_pfn(page) < zone->zone_start_pfn)
                 return 1;

checks in bad_range. ISTR some "warning: zone not aligned, kernel
*will* crash" message got printed in that case. I always thought
that zones were supposed to be MAX_ORDER aligned, but I can see how
that restriction might be relaxed with these checks in place.

This commit introduced the change:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;a=commitdiff;h=d60c9dbc4589766ef5fe88f082052ccd4ecaea59

I think this basically says that architectures who care need to define
CONFIG_HOLES_IN_ZONE and handle this in pfn_valid.

Unless this is a very common requirement and such a solution would have
too much performance cost? Anyone?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
