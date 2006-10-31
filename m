Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965466AbWJaKXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965466AbWJaKXY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 05:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965525AbWJaKXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 05:23:24 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:9032 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S965466AbWJaKXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 05:23:24 -0500
Message-ID: <45472317.7060800@openvz.org>
Date: Tue, 31 Oct 2006 13:19:03 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Pavel Emelianov <xemul@openvz.org>, vatsa@in.ibm.com, dev@openvz.org,
       sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, pj@sgi.com,
       matthltc@us.ibm.com, dipankar@in.ibm.com, rohitseth@google.com,
       menage@google.com, linux-mm@kvack.org,
       Vaidyanathan S <svaidy@in.ibm.com>
Subject: Re: [ckrm-tech] RFC: Memory Controller
References: <20061030103356.GA16833@in.ibm.com> <4545D51A.1060808@in.ibm.com> <4546212B.4010603@openvz.org> <454638D2.7050306@in.ibm.com> <45463F70.1010303@in.ibm.com> <45470FEE.6040605@openvz.org> <45471510.4070407@in.ibm.com> <45471679.90103@openvz.org> <45472133.9090109@in.ibm.com>
In-Reply-To: <45472133.9090109@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[snip]

>>> Since it is easy to push the page out (as you said), it should be
>>> easy to impose a limit on the page cache usage of a container.
>> If a group is limited with memory _consumption_ it won't fill
>> the page cache...
>>
> 
> So you mean the memory _consumption_ limit is already controlling
> the page cache? That's what we need the ability for a container
> not to fill up the page cache :)

I mean page cache limiting is not needed. We need to make
sure group eats less that N physical pages. That can be
achieved by controlling page faults, setup_arg_pages(), etc.
Page cache is not to be touched.

> I don't remember correctly, but do you account for dirty page cache usage in
> the latest patches of BC?

We do not account for page cache itself. We track only
physical pages regardless of where they are.

[snip]

> The idea of pre-allocation was discussed as a possibility in the case
> that somebody needed hard guarantees, but most of us don't need it.
> I was in the RFC for the sake of completeness.
> 
> Coming back to your question
> 
> Why do you need to select a NUMA node? For performance?

Of course! Otherwise what do we need kmem_cache_alloc_node() etc
calls in kernel?

The second question is - what if two processes from different
beancounters try to share one page. I remember that the current
solution is to take the page from the first user's reserve. OK.
Consider then that this first user stops using the page. When
this happens one page must be put back to it's reserve, right?
But where to get this page from?

Note that making guarantee through limiting doesn't care about
where the page is get from.
