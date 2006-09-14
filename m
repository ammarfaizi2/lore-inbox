Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWINNCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWINNCu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 09:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWINNCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 09:02:50 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:63046 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932070AbWINNCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 09:02:50 -0400
Message-ID: <450952F8.8080606@openvz.org>
Date: Thu, 14 Sep 2006 17:02:48 +0400
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: balbir@in.ibm.com, sekharan@us.ibm.com, Srivatsa <vatsa@in.ibm.com>,
       Kirill Korotaev <dev@sw.ru>
CC: Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added	user
 memory)
References: <44FD918A.7050501@sw.ru>	<44FDAB81.5050608@in.ibm.com>		<44FEC7E4.7030708@sw.ru>	<44FF1EE4.3060005@in.ibm.com>		<1157580371.31893.36.camel@linuxchandra>	<45011CAC.2040502@openvz.org>		<1157730221.26324.52.camel@localhost.localdomain>		<4501B5F0.9050802@in.ibm.com> <450508BB.7020609@openvz.org>		<4505161E.1040401@in.ibm.com> <45051AC7.2000607@openvz.org>		<1158000590.6029.33.camel@linuxchandra>	<45069072.4010007@openvz.org>		<1158105488.4800.23.camel@linuxchandra>	<4507BC11.6080203@openvz.org>	<1158186664.18927.17.camel@linuxchandra> <45090A6E.1040206@openvz.org> <45090D9E.9000903@in.ibm.com>
In-Reply-To: <45090D9E.9000903@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> Pavel Emelianov wrote:
>
>> I don't understand your idea. Limit does _not_ imply anything - it's
>> just a limit.
>> You may limit anything to anyone w/o bothering the consequences.
>> Guarantee implies that the resource you guarantee will be available and
>> this "will be" is something not that easy.
>>
>> So I repeat my question - how can you be sure that these X megabytes you
>> guarantee to some group won't be used by others so that you won't be
>> able
>> to reclaim them?
>>
>>
>
> May be we can treat a guarantee as a soft guarantee. A soft
> guarantee would imply that when a group needs its guaranteed
> resources, the
> system makes its best effort to make it available.
>
> In soft guarantees, resources not actively used by a group can be
> shared with
> other groups.
>
> Hard guarantees would probably require reserving the resource in
> advance and
> sharing of the resources not used, with other groups, might not be
> possible.
>
> Comments?
>
Reserving in advance means that sometimes you won't be able to start a
new group without taking back some of reserved pages. This is ... strange.

I think that a satisfactory solution now would be:
 - limit unreclaimable memory during mmap() against soft limit to prevent
   potential rejects during page faults;
 - reclaim memory in case of hitting hard limit;
 - guarantees are done via setting soft and hard limits as I've shown
before.

The question still open is wether or not to account fractions.
I propose to skip fractions for a while and try to charge the page to
it's first user.

So final BC design is:
1. three resources:
       - kernel memory
       - user unreclaimable memory
       - user reclaimable memory
2. unreclaimable memory is charged "in advance", reclaimable
   is charged "on demand" with reclamation if needed
3. each object (kernel one or user page) is charged to the
   first user
4. each resource controller declares it's own
       - meaning of "limit" parameter (percent/size/bandwidth/etc)
       - behaviour on changing limit (e.g. reclamation)
       - behaviour on hitting the limit (e.g. reclamation)
5. BC can be assigned to any task by pid (not just current)
   without recharging currently charged resources.
