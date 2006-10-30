Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWJ3SPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWJ3SPF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 13:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbWJ3SPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 13:15:05 -0500
Received: from smtp-out.google.com ([216.239.33.17]:22058 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751539AbWJ3SPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:15:01 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=KQEz9O+FKyx6uqEB/kG5cAdPtThJFaqLUsVdJRt+xzRlD+hnNgV7sgO7um+WjarlF
	vIDwvfCSUK4A5lFxoumiQ==
Message-ID: <6599ad830610301014l1bf78ce8q998229483d055a90@mail.gmail.com>
Date: Mon, 30 Oct 2006 10:14:44 -0800
From: "Paul Menage" <menage@google.com>
To: balbir@in.ibm.com
Subject: Re: [ckrm-tech] RFC: Memory Controller
Cc: dev@openvz.org, vatsa@in.ibm.com, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com
In-Reply-To: <4545FDCD.3080107@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030103356.GA16833@in.ibm.com> <4545D51A.1060808@in.ibm.com>
	 <6599ad830610300304l58e235f7td54ef8744e462a55@mail.gmail.com>
	 <4545FDCD.3080107@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/06, Balbir Singh <balbir@in.ibm.com> wrote:
>
> You'll also end up with per zone page cache pools for each zone. A list of
> active/inactive pages per zone (which will split up the global LRU list).

Yes, these are some of the inefficiencies that we're ironing out.

> What about the hard-partitioning. If a container/cpuset is not using its full
> 64MB of a fake node, can some other node use it?

No. So the granularity at which you can divide up the system depends
on how big your fake nodes are. For our purposes, we figure that 64MB
granularity should be fine.

> Also, won't you end up
> with a big zonelist?

Yes - but PaulJ's recent patch to speed up the zone selection helped
reduce the overhead of this a lot.

>
> Consider the other side of the story. lets say we have a shared lib shared
> among quite a few containers. We limit the usage of the inode containing
> the shared library to 50M. Tasks A and B use some part of the library
> and cause the container "C" to reach the limit. Container C is charged
> for all usage of the shared library. Now no other task, irrespective of which
> container it belongs to, can touch any new pages of the shared library.

Well, if the pages aren't mlocked then presumably some of the existing
pages can be flushed out to disk and replaced with other pages.

>
> What you are suggesting is to virtually group the inodes by container rather
> than task. It might make sense in some cases, but not all.

Right - I think it's an important feature to be able to support, but I
agree that it's not suitable for all situations.

>
> We could consider implementing the controllers in phases
>
> 1. RSS control (anon + mapped pages)
> 2. Page Cache control

Page cache control is actually more essential that RSS control, in our
experience - it's pretty easy to track RSS values from userspace, and
react reasonably quickly to kill things that go over their limit, but
determining page cache usage (i.e. determining which job on the system
is flooding the page cache with dirty buffers) is pretty much
impossible currently.

Paul
