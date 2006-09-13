Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWIMMpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWIMMpk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 08:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWIMMpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 08:45:40 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:30180 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750760AbWIMMpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 08:45:39 -0400
Subject: Re: [patch 1/9] Guest page hinting: unused / free pages.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       rhim@cc.gateh.edu
In-Reply-To: <4507F453.1040809@watson.ibm.com>
References: <20060901110908.GB15684@skybase> <45073901.8020906@redhat.com>
	 <45074BD0.3060400@watson.ibm.com>  <45075F09.5010708@redhat.com>
	 <1158137786.2560.3.camel@localhost>  <4507F453.1040809@watson.ibm.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Wed, 13 Sep 2006 14:45:35 +0200
Message-Id: <1158151535.2560.20.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-13 at 08:06 -0400, Hubertus Franke wrote:
> Martin Schwidefsky wrote:
> > On Tue, 2006-09-12 at 21:29 -0400, Rik van Riel wrote:
> > 
> >>Note that the transition _to_ volatile can also be batched
> >>and done somewhat lazily.  For frequently mmaped pages that
> >>could end up saving us the transition the other way, too...
> > 
> > 
> > That would be helpful, only how to do it? We need some sort of list or
> > array where to store the pages that should be made volatile. The main
> > problem that I see is that you have to remove a page that is freed from
> > the list/array again, otherwise you would end up with a non page-cache
> > page being made volatile. That makes using per-cpu arrays hard since a
> > page can be freed on another cpu.
> > 
> 
> 
> Martin. the point was that pages
> which are in the hold/cold lists are technically free.
> However we keep them stable.
> When the hot/cold list is spilled back to the buddy allocator
> we make them volatile in buld (i.e. through the array).

You mean unused.

> So we only build the array for the duration of the bulk-release
> to the buddy allocator (and potentially the other way as well).
> Hence there is no "state" to maintain or track for the array.
> Pages in the hot/cold lists remain stable.
> This would not any of the problems you described as long as we hold
> the lock for the hot/cold list during buld-volatile.

I was not talking about free pages, and I don't think Rik was either.
The idea is to be lazy about the make-volatile calls. Put the pages for
which a make-volatile call should be done to some array/list and do a
bulk make-volatile. These pages are still in the page/swap cache. The
trouble is we have to be sure these pages have not been freed in the
meantime.

The bulk set-unused/set-stable to the buddy allocator should not be to
problematic. We just have to find new places where to do the calls.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


