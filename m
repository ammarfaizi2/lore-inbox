Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946105AbWKJJdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946105AbWKJJdh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946220AbWKJJdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:33:37 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:44477 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1946105AbWKJJdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:33:35 -0500
Message-ID: <4554466F.8010602@openvz.org>
Date: Fri, 10 Nov 2006 12:29:19 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Pavel Emelianov <xemul@openvz.org>, Linux MM <linux-mm@kvack.org>,
       dev@openvz.org, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       haveblue@us.ibm.com, rohitseth@google.com
Subject: Re: [RFC][PATCH 8/8] RSS controller support reclamation
References: <20061109193523.21437.86224.sendpatchset@balbir.in.ibm.com> <20061109193636.21437.11778.sendpatchset@balbir.in.ibm.com> <45543E36.2080600@openvz.org> <45544362.9040805@in.ibm.com>
In-Reply-To: <45544362.9040805@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:

[snip]

>> And what about a hard limit - how would you fail in page fault in
>> case of limit hit? SIGKILL/SEGV is not an option - in this case we
>> should run synchronous reclamation. This is done in beancounter
>> patches v6 we've sent recently.
>>
> 
> I thought about running synchronous reclamation, but then did not follow
> that approach, I was not sure if calling the reclaim routines from the
> page fault context is a good thing to do. It's worth trying out, since

Each page fault potentially calls reclamation by allocating
required page with __GFP_IO | __GFP_FS bits set. Synchronous
reclamation in page fault is really normal.

[snip]

>> Please correct me if I'm wrong, but does this reclamation work like
>> "run over all the zones' lists searching for page whose controller
>> is sc->container" ?
>>
> 
> Yeah, that's correct. The code can also reclaim memory from all over-the-limit

OK. What if I have a container with 100 pages limit in a 4Gb
(~ million of pages) machine and this group starts reclaiming
its pages. In case this group uses its pages heavily they will
be at the beginning of an LRU list and reclamation code would
have to scan through all (million) pages before it finds proper
ones. This is not optimal!

> containers (by passing SC_OVERLIMIT_ALL). The idea behind using such a scheme
> is to ensure that the global LRU list is not broken.

isolate_lru_pages() helps in this. As far as I remember this
was introduced to reduce lru lock contention and keep lru
lists integrity.

In beancounters patches this is used to shrink BC's pages.
