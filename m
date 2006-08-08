Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbWHHPdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWHHPdx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWHHPdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:33:52 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:62809 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964958AbWHHPdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:33:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=LL5YTNFEKPu94IjoLJNKu+hoc2KezEPXvoOwd0v+tzlNapU/1ihddPLjL/nxBH9XALMiMdNPD9e0qK3TgWKi50Tlf45WcnsYp58vLi/laWcbw1MWqPdD9EdC9pq04FN+z+tYI1X3DtXFtABqfZc2gonjyAl0vjTKZSdcX7HqG0M=  ;
Message-ID: <44D8AC23.4090004@yahoo.com.au>
Date: Wed, 09 Aug 2006 01:22:11 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Martin Bligh <mbligh@mbligh.org>, rohitseth@google.com,
       Kirill Korotaev <dev@sw.ru>, vatsa@in.ibm.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, sam@vilain.net, linux-kernel@vger.kernel.org,
       dev@openvz.org, efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       nagar@watson.ibm.com, pj@sgi.com, Andrey Savochkin <saw@sw.ru>
Subject: Re: memory resource accounting (was Re: [RFC, PATCH 0/5] Going	forward
 with Resource Management - A	cpu controller)
References: <20060804050753.GD27194@in.ibm.com>	 <20060803223650.423f2e6a.akpm@osdl.org>	 <20060803224253.49068b98.akpm@osdl.org>	 <1154684950.23655.178.camel@localhost.localdomain>	 <20060804114109.GA28988@in.ibm.com> <44D35F0B.5000801@sw.ru>	 <44D388DF.8010406@mbligh.org> <44D6EAFA.8080607@sw.ru>	 <44D74F77.7080000@mbligh.org>  <44D76B43.5080507@sw.ru>	 <1154975486.31962.40.camel@galaxy.corp.google.com>	 <1154976236.19249.9.camel@localhost.localdomain>	 <1154977257.31962.57.camel@galaxy.corp.google.com>	 <44D798B1.8010604@mbligh.org>  <44D89D7D.8040006@yahoo.com.au> <1155049020.19249.32.camel@localhost.localdomain>
In-Reply-To: <1155049020.19249.32.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Wed, 2006-08-09 at 00:19 +1000, Nick Piggin wrote:
> 
>>   This does give you kernel (slab, pagetable, etc) allocations as well as
>>   userspace. I don't like the idea of doing controllers for inode cache
>>   and controllers for dentry cache, etc, etc, ad infinitum.
> 
> 
> Those two might not be such a bad idea.  Of the slab in my system, 90%
> is reliably from those two slabs alone.  Now, a controller for the
> 'Acpi-Operand' slab might be going too far. ;)
> 
> Certainly something we should at least consider down the road.

But if you have a unified struct page accounting, you don't need that.
You don't need struct radix_tree_node accounting, you don't need buffer_head
accounting, pagetable page accounting, vm_area_struct accounting, task_struct
accounting, etc etc in order to do your memory accounting if what you just
want to know is "who allocated what".

And remember that if you have one container going crazy with inode/dentry
cache, it will get hit by its resource limit and end up having to reclaim
them or go OOM.

Now you *may* want to split the actual accounting into kernel and user parts
if you're worried about obscure corner cases in kernel memory accounting. But
this would basically come for free when you have the GFP_EASYRECLAIM thingy
(at any rate, it is quite unintrusive).


Basically, what I have been hearing is that people want to be able to
surgically isolate the memory allocation of one container from that of
another. IMO this is simply infeasible (and exploit prone) to do it on a
per-kernel-object basis.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
