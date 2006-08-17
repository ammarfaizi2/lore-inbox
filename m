Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965119AbWHQQig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbWHQQig (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 12:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965120AbWHQQig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 12:38:36 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:42728 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965119AbWHQQif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 12:38:35 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting
	(core)
From: Dave Hansen <haveblue@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: rohitseth@google.com, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@sw.ru>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Pavel Emelianov <xemul@openvz.org>,
       dave@sr71.net
In-Reply-To: <1155826917.15195.101.camel@localhost.localdomain>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
	 <1155754029.9274.21.camel@localhost.localdomain>
	 <1155755729.22595.101.camel@galaxy.corp.google.com>
	 <1155758369.9274.26.camel@localhost.localdomain>
	 <1155774274.15195.3.camel@localhost.localdomain>
	 <1155824788.9274.32.camel@localhost.localdomain>
	 <1155826917.15195.101.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 09:37:39 -0700
Message-Id: <1155832659.9274.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 16:01 +0100, Alan Cox wrote:
> Ar Iau, 2006-08-17 am 07:26 -0700, ysgrifennodd Dave Hansen:
> > My main thought is that _everybody_ is going to have to live with the
> > entry in the 'struct page'.  Distros ship one kernel for everybody, and
> > the cost will be paid by those not even using any kind of resource
> > control or containers.
> > 
> > That said, it sure is simpler to implement, so I'm all for it!
> 
> I don't see any good way around that. For the page struct it is a
> material issue, for the others its not a big deal providing we avoid
> accounting dumb stuff like dentries.

The only way I see around it is using other mechanisms to more loosely
attribute ownership of a page to particular containers.  I know that my
suggestion of traversing the rmap chains at page reclaim time is going
appears to be slow compared to the regular reclaim path, but I'm not
sure it really matters.  

Let's say you have 20 containers sharing 20 pages which are on the LRU,
and those pages are evenly distributed so that each container owns one
page.  Only one of those 20 containers is over its limit.  With
something that strictly assigns container ownership to one and only one
container, you're going to have to walk half of the LRU to find the
page.

With a "loose ownership" scheme, you'd hit on the first page, and you'd
pay the cost by having to walk halfway through the 20 rmap entries.
Admittedly, the rmap walk is much slower than an LRU walk.  

-- Dave

