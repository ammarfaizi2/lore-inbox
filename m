Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWHDS1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWHDS1p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 14:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWHDS1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 14:27:45 -0400
Received: from smtp-out.google.com ([216.239.45.12]:48439 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751112AbWHDS1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 14:27:44 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=uAYksqOWwYsnz5CfkLeQFrXX+URNE8XoSg8/7cCKdS4AJ9N9F4r2oRVAOA3KjEjDv
	/jDvRDoeRuwr6AF1M8FsQ==
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A
	cpu controller
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Kirill Korotaev <dev@sw.ru>
Cc: vatsa@in.ibm.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, mingo@elte.hu, nickpiggin@yahoo.com.au,
       sam@vilain.net, linux-kernel@vger.kernel.org, dev@openvz.org,
       efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       nagar@watson.ibm.com, haveblue@us.ibm.com, pj@sgi.com
In-Reply-To: <44D36FB5.3050002@sw.ru>
References: <20060804050753.GD27194@in.ibm.com>
	 <20060803223650.423f2e6a.akpm@osdl.org>
	 <20060803224253.49068b98.akpm@osdl.org>
	 <1154684950.23655.178.camel@localhost.localdomain>
	 <20060804114109.GA28988@in.ibm.com> <44D35F0B.5000801@sw.ru>
	 <20060804153123.GB32412@in.ibm.com>  <44D36FB5.3050002@sw.ru>
Content-Type: text/plain
Organization: Google Inc
Date: Fri, 04 Aug 2006 11:27:04 -0700
Message-Id: <1154716024.7228.32.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 20:03 +0400, Kirill Korotaev wrote:
 
> > Doesnt the ability to move tasks between groups dynamically affect
> > (atleast) memory controller design (in giving up ownership etc)?
> we save object owner on the object. So if you change the container,
> objects are still correctly charged to the creator and are uncharged
> correctly on free.
> 

Seems like the object owner should also change when the object moves
from one container to another.

> > Also if we need to support this movement, we need to have some
> > corresponding system call/file-system interface which supports this move 
> > operation.
> it can be done by the same syscall or whatever which sets your
> container group.
> we have the same syscall for creating/setting/entering to the container.
> i.e. chaning the container dynamically doesn't change the interface.
> 
> >>BTW, do you see any practical use cases for tasks jumping between 
> >>resource-containers?
> > 

I think the ability to move file backed memory from one container to
another is useful.  This allows appropriate containers to get charged
based on the usage pattern.  Though this (movement between containers)
is not something that should be encouraged.

> > 
> > The use cases I have heard of which would benefit such a feature is
> > (say) for database threads which want to change their "resource
> > affinity" status depending on which customer query they are currently handling. 
> > If they are handling a query for a "important" customer, they will want affinied
> > to a high bandwidth resource container and later if they start handling
> > a less important query they will want to give up this affinity and
> > instead move to a low-bandwidth container.

hmm, would it not be better to have a thread each in two different
containers for handling different kind of requests.  Or if there is too
much of sharing between threads, then setting the individual priority
should help.

> this works mostly for CPU only. And OpenVZ design allows to change CPU
> resource container  dynamically.
> But such a trick works poorly for memory, because:
> 1. threads share lots of resources.
> 2. complex databases can have more complicated handling than a thread per request.
>   e.g. one thread servers memory pools, another one caches, some for stored procedures, some for requests etc.
> 

Any resource movement between containers should be at best efforts.  The
stats will tend to be more inaccurate (which I think is okay) as the
sharing between resources across increases.

> BTW, exactly this difference shows the reason to have different groups for different resources.
> 

Well, for a set of processes that are sharing a set of resources
perfectly, it would be okay to combine all such resources in a single
container.  But for a shared resource, like file(that spans across
processes in different containers), it could be useful to have a
stand-alone container.

-rohit 

