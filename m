Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752133AbWCGJoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbWCGJoM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 04:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbWCGJoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 04:44:12 -0500
Received: from mail.axxeo.de ([82.100.226.146]:31404 "EHLO mail.axxeo.de")
	by vger.kernel.org with ESMTP id S1752133AbWCGJoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 04:44:11 -0500
From: Ingo Oeser <netdev@axxeo.de>
Organization: Axxeo GmbH
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [PATCH 0/8] Intel I/O Acceleration Technology (I/OAT)
Date: Tue, 7 Mar 2006 10:43:59 +0100
User-Agent: KMail/1.7.2
Cc: "David S. Miller" <davem@davemloft.net>, jengelh@linux01.gwdg.de,
       christopher.leech@intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
References: <20060303214036.11908.10499.stgit@gitlost.site> <200603061844.07439.netdev@axxeo.de> <20060307074438.GA22672@2ka.mipt.ru>
In-Reply-To: <20060307074438.GA22672@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603071043.59479.netdev@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> On Mon, Mar 06, 2006 at 06:44:07PM +0100, Ingo Oeser (netdev@axxeo.de) wrote:
> > Hmm, so I should resurrect my user page table walker abstraction?
> > 
> > There I would hand each page to a "recording" function, which
> > can drop the page from the collection or coalesce it in the collector
> > if your scatter gather implementation allows it.
> 
> It depends on where performance growth is stopped.
> From the first glance it does not look like find_extend_vma(),
> probably follow_page() fault and thus __handle_mm_fault().
> I can not say actually, but if it is true and performance growth is
> stopped due to increased number of faults and it's processing, 
> your approach will hit this problem too, doesn't it?

My approach reduced the number of loops performed and number
of memory needed at the expense of doing more work in the main
loop of get_user_pages. 

This was mitigated for the common case of getting just one page by 
providing a get_one_user_page() function.

The whole problem, why we need such multiple loops is that we have
no common container object for "IO vector + additional data".

So we always do a loop working over the vector returned by 
get_user_pages() all the time. The bigger that vector, 
the bigger the impact.

Maybe sth. as simple as providing get_user_pages() with some offset_of 
and container_of hackery will work these days without the disadvantages 
my old get_user_pages() work had.

The idea is, that you'll provide a vector (like arguments to calloc) and two 
offsets: One for the page to store within the offset and one for the vma 
to store.

If the offset has a special value (e.g MAX_LONG) you don't store there at all.

But if the performance problem really is get_user_pages() itself 
(and not its callers), then my approach won't help at all.


Regards

Ingo Oeser
