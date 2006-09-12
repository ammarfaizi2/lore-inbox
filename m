Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWILLGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWILLGe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 07:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWILLGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 07:06:34 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:35726 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932255AbWILLGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 07:06:33 -0400
Message-ID: <450694BB.3060304@openvz.org>
Date: Tue, 12 Sep 2006 15:06:35 +0400
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Pavel Emelianov <xemul@openvz.org>, sekharan@us.ibm.com,
       Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Kirill Korotaev <dev@sw.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user
 memory)
References: <1157478392.3186.26.camel@localhost.localdomain> <44FED3CA.7000005@sw.ru> <1157579641.31893.26.camel@linuxchandra> <44FFCA4D.9090202@openvz.org> <1157656616.19884.34.camel@linuxchandra> <45011A47.1020407@openvz.org> <1157742442.19884.47.camel@linuxchandra> <450509EE.9010809@openvz.org> <20060911130428.GA16404@in.ibm.com> <45068AD9.50308@openvz.org> <20060912102943.GA28128@in.ibm.com>
In-Reply-To: <20060912102943.GA28128@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Tue, Sep 12, 2006 at 02:24:25PM +0400, Pavel Emelianov wrote:
>   
>> Srivatsa Vaddagiri wrote:
>>     
>>> On Mon, Sep 11, 2006 at 11:02:06AM +0400, Pavel Emelianov wrote:
>>>   
>>>       
>>>> Sure. At the beginning I have one task with one BC. Then
>>>> 1. A thread is spawned and new BC is created;
>>>>     
>>>>         
>>> Why do we have to create a BC for every new thread? A new BC is needed
>>> for every new service level instead IMO. And typically there wont be
>>> unlimited service levels.
>>>   
>>>       
>> That's the scenario we started from - each domain is served in a separate
>> BC with *threaded* Apache.
>>     
>
> Sure ..but you can still meet that requirement by creating fixed set of
> BCs (for each domain) and let each new thread be associated with a
> corresponding BC (w/o requiring to create BC for every new thread),
> depending on which domain's request it is serving?
>   
Hmmm... Beancounters can provide this after trivial changes.
We may schedule them in current set of "pending" features
(http://wiki.openvz.org/UBC_discussion)

But this can create a kind of DoS within an application:
  A thread continuously touches new and new pages to it's BC and
these pages are get touched by other threads also. Sooner or later
this BC will hit it's limit and reclaiming this set of pages would affect
all the other threads.

Also such accounting reveals you NOTHING about real memory usage.
E.g. 100Mb charged for one BC can mean "this BC ate 100Mb of
memory" as well as "this BC uses one page really, but all the others
are just used by other threads" and anything between these two
corner cases.

Well. We've digressed from our main thread - discussing (dis)advantages
of current BC implemenation.
>   
>>>   
>>>       
>>>> 2. New thread touches a new page (e.g. maps a new file) which is charged
>>>> to new BC
>>>>     (and this means that this BC's must stay in memory till page is
>>>> uncharged);
>>>> 3. Thread exits after serving the request, but since it's mm is shared
>>>> with parent
>>>>     all the touched pages stay resident and, thus, the new BC is still
>>>> pinned in memory.
>>>> Steps 1-3 are done multiple times for new pages (new files).
>>>> Remember that we're discussing the case when pages are not recharged.
>>>>         
