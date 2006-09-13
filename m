Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWIMRF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWIMRF2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 13:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWIMRF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 13:05:28 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:13490 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750788AbWIMRF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 13:05:27 -0400
Message-ID: <45083A50.8030708@watson.ibm.com>
Date: Wed, 13 Sep 2006 13:05:20 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: schwidefsky@de.ibm.com
CC: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       rhim@cc.gatech.edu
Subject: Re: [patch 1/9] Guest page hinting: unused / free pages.
References: <20060901110908.GB15684@skybase> <45073901.8020906@redhat.com>	 <45074BD0.3060400@watson.ibm.com>  <45075F09.5010708@redhat.com>	 <1158137786.2560.3.camel@localhost>  <4507F453.1040809@watson.ibm.com>	 <1158151535.2560.20.camel@localhost> <45080262.8050009@watson.ibm.com>	 <4508198E.10707@redhat.com> <1158159543.2560.29.camel@localhost>
In-Reply-To: <1158159543.2560.29.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
> On Wed, 2006-09-13 at 10:45 -0400, Rik van Riel wrote:
> 
>>>But another trouble you have not mentioned is what happens to pages
>>>with pending make-volatile that need to and/or have been made stable
>>>in the meantime. They too need to be removed from this pending list.
>>
>>At the time where you walk the set of pages (pagevec?) to make
>>volatile, you can check whether the page flags are still right.
> 
> 
> A make volatile can be done anytime as long as the page is in page
> cache. Before a page can be made stable the caller needs to make sure
> that one of the conditions that prevent a make volatile becomes true.
> So a page in the pending make-volatile array does not have to be removed
> because a make stable has been done. It only has to be removed if it
> gets freed.
> 
> 
>>A page that was set to be marked volatile with the hypervisor,
>>but later turned stable again would have that indicated in its
>>page flags, right?
> 
> 
> Several page flag bits and some other conditions like "has a mapping"
> and "reference count is map count + 1". Most of the checks that need to
> be done for make volatile are on page flags.
> 

Interesting..
But don't we have to do some locking on the page to avoid race conditions?
A page needs to be consistent between check through __page_discardable and
committing to the hypervisor. We could raise the PG_state_change flag for
that period.


