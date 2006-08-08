Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWHHOTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWHHOTv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 10:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWHHOTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 10:19:51 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:21420 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964894AbWHHOTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 10:19:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=KNnt8ed5gFjSjI58mD3z0hLDHGlJg4LYKaqwUykMbg/npH/FhHXTZWAHkkK6KgJa2Iw3+2wfPrYDg0JWSrFKOyZhLZKEa/hb0iTHBR1dyWPqKpvidXTS3R2rHQdJhoHki/G47ruk1dlUElG/SS3z8t7owyA29+vDVWjTSHkxTA8=  ;
Message-ID: <44D89D7D.8040006@yahoo.com.au>
Date: Wed, 09 Aug 2006 00:19:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Bligh <mbligh@mbligh.org>
CC: rohitseth@google.com, Dave Hansen <haveblue@us.ibm.com>,
       Kirill Korotaev <dev@sw.ru>, vatsa@in.ibm.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, sam@vilain.net, linux-kernel@vger.kernel.org,
       dev@openvz.org, efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       nagar@watson.ibm.com, pj@sgi.com, Andrey Savochkin <saw@sw.ru>
Subject: memory resource accounting (was Re: [RFC, PATCH 0/5] Going forward
 with Resource Management - A	cpu controller)
References: <20060804050753.GD27194@in.ibm.com>	 <20060803223650.423f2e6a.akpm@osdl.org>	 <20060803224253.49068b98.akpm@osdl.org>	 <1154684950.23655.178.camel@localhost.localdomain>	 <20060804114109.GA28988@in.ibm.com> <44D35F0B.5000801@sw.ru>	 <44D388DF.8010406@mbligh.org> <44D6EAFA.8080607@sw.ru>	 <44D74F77.7080000@mbligh.org>  <44D76B43.5080507@sw.ru>	 <1154975486.31962.40.camel@galaxy.corp.google.com>	 <1154976236.19249.9.camel@localhost.localdomain> <1154977257.31962.57.camel@galaxy.corp.google.com> <44D798B1.8010604@mbligh.org>
In-Reply-To: <44D798B1.8010604@mbligh.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:
> Rohit Seth wrote:
> 

Hi guys, let me make a fool of myself and jump in this thread...

>> I think there is lot of simplicity and value add by charging one
>> container (even unfairly) for one resource completely.  This puts the
>> onus on system admin to set up the containers appropriately.
> 
> 
> It also saves you from maintaining huge lists against each page.
> 
> Worse case, you want to bill everyone who opens that address_space
> equally. But the semantics on exit still suck.
> 
> What was Alan's quote again? "unfair, unreliable, inefficient ...
> pick at least one out of the three". or something like that.

What's the sucking semantics on exit? I haven't looked much at the
existing memory controllers going around, but the implementation I
imagine looks something like this (I think it is conceptually similar
to the basic beancounters idea):

- anyone who allocates a page for anything gets charged for that page.
   Except interrupt/softirq context. Could we ignore these for the moment?

   This does give you kernel (slab, pagetable, etc) allocations as well as
   userspace. I don't like the idea of doing controllers for inode cache
   and controllers for dentry cache, etc, etc, ad infinitum.

- each struct page has a backpointer to its billed container. At the mm
   summit Linus said he didn't want back pointers, but I clarified with him
   and he isn't against them if they are easily configured out when not using
   memory controllers.

- memory accounting containers are in a hierarchy. If you want to destroy a
   container but it still has billed memory outstanding, that gets charged
   back to the parent. The data structure itself obviously still needs to
   stay around, to keep the backpointers from going stale... but that could
   be as little as a word or two in size.

The reason I like this way of accounting is that it can be done with a couple
of hooks into page_alloc.c and an ifdef in mm.h, and that is the extent of
the impact on core mm/ so I'd be against anything more intrusive unless this
really doesn't work.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
