Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262925AbVGOA1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbVGOA1k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 20:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbVGOA1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 20:27:40 -0400
Received: from main.gmane.org ([80.91.229.2]:22471 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262925AbVGOA1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 20:27:38 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joe Seigh <jseigh_02@xemaps.com>
Subject: Re: rcu-refcount stacker performance
Date: Thu, 14 Jul 2005 20:29:57 -0400
Message-ID: <db6vsm$fpm$1@sea.gmane.org>
References: <20050714142107.GA20984@serge.austin.ibm.com> <20050714152321.GB1299@us.ibm.com> <20050714134450.GB7296@sergelap.austin.ibm.com> <20050714165936.GE1299@us.ibm.com> <20050714171357.GA23309@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.hsd1.ma.comcast.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
In-Reply-To: <20050714171357.GA23309@serge.austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

serue@us.ibm.com wrote:
> Quoting Paul E. McKenney (paulmck@us.ibm.com):
>>OK, but in the above case, "do something" cannot be sleeping, since
>>it is under rcu_read_lock().
> 
> 
> Oh, but that's not quite what the code is doing, rather it is doing:
> 
> 	rcu_read_lock
> 	while get next element from list
> 		inc element.refcount
> 		rcu_read_unlock
> 		do something
> 		rcu_read_lock
> 		dec refcount
> 	rcu_read_unlock
> 

I've been experimenting with various lock-free methods in user space, which
is preemptive.   Stuff like RCU, RCU+SMR which I've mentioned before,
and some atomically thread-safe reference counting.  I have a proxy
GC based on the latter called APPC (atomic pointer proxy collector).
Basically you use a proxy refcounted object for the whole list
rather than every element in the list.  Before you access the list,
you increment the refcount of the proxy object, and afterwards you
decrement it.  One interlocked instruction for each so performance
wise it looks like a reader lock which never blocks.

Writers enqueue deleted nodes on the collector object and then
push a new collector object in place.

The collector objects look like


    proxy_anchor -> c_obj <- c_obj <- c_obj
                                       ^
                                       | reader

The previous collector objects are back linked so when a reader
thread releases it, all unreference collector objects have
deallocation performed on them and attached nodes.

A bit sketchy.  You can see a working example of this using
C++ refcounted pointers (which can't be used in the kernel
naturally, you'll have to implement your own) at
http://atomic-ptr-plus.sourceforge.net/

--
Joe Seigh

