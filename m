Return-Path: <linux-kernel-owner+w=401wt.eu-S932192AbXACXhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbXACXhx (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 18:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbXACXhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 18:37:52 -0500
Received: from mailgw4.ericsson.se ([193.180.251.62]:57463 "EHLO
	mailgw4.ericsson.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbXACXhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 18:37:51 -0500
X-Greylist: delayed 1217 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 18:37:51 EST
Message-ID: <459C396B.1090508@ericsson.com>
Date: Wed, 03 Jan 2007 23:16:59 +0000
From: Jon Maloy <jon.maloy@ericsson.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jarek Poplawski <jarkao2@o2.pl>
CC: Eric Sesterhenn <snakebyte@gmx.de>, Per Liden <per.liden@ericsson.com>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       "'tipc-discussion@lists.sourceforge.net'" 
	<tipc-discussion@lists.sourceforge.net>
Subject: Re: [PATCH] tipc: checking returns and Re: Possible Circular Locking
 in TIPC
References: <20061228121702.GA5076@ff.dom.local>
In-Reply-To: <20061228121702.GA5076@ff.dom.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jan 2007 23:17:32.0215 (UTC) FILETIME=[58541C70:01C72F8D]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See my comments below.
Regards
///jon

Jarek Poplawski wrote:

> ..........
>
>Maybe I misinterpret this but, IMHO lockdep
>complains about locks acquired in different
>order: tipc_ref_acquire() gets ref_table_lock 
>and then tipc_ret_table.entries[index]->lock,
>but tipc_deleteport() inversely (with:
>tipc_port_lock() and tipc_ref_discard()).
>I hope maintainers will decide the correct
>order.
>  
>
This order is correct. There can never be parallel access to the
same _instance_ of tipc_ret_table.entries[index]->lock from
the two functions you mention.
Note that tipc_deleteport() takes as argument the reference (=index)
returned from tipc_ref_acquire(), so  it can not be (and is not) called
until and unless the latter function has returned a valid reference.
As a parallel, you can't do free() on a memory chunk until
malloc() has given you a pointer to it.

>Btw. there is a problem with tipc_ref_discard():
>it should be called with tipc_port_lock, but
>how to discard a ref if this lock can't be
>acquired? Is it OK to call it without the lock
>like in subscr_named_msg_event()?
>  
>
I suspect you are mixing up things here. 
We are handling two different reference entries and two
different locks in this function.
One reference entry points to a subscription instance, and its
reference (index) is obtainable from subscriber->ref. So, we
could easily lock the entry if needed. However, in this
particular case it is unnecessary, since there is no chance that
anybody else could have obtained the new reference, and
hence no risk for race conditions.
The other reference entry was intended to point to a new port,
but, since we didn't obtain any reference in the first place,
there is no port to delete and no reference to discard.


>Btw. #2: during this checking I've found
>two places where return values from
>tipc_ref_lock() and tipc_port_lock() are not 
>checked, so I attach a patch proposal for
>this (compiled but not tested):
>  
>
Thanks. 

>Regards,
>Jarek P.
>---
>
>[PATCH] tipc: checking returns from locking functions
>
>Checking of return values from tipc_ref_lock()
>and tipc_port_lock() added in 2 places. 
>
>Signed-off-by: Jarek Poplawski <jarkao2@o2.pl>
>---
>
>diff -Nurp linux-2.6.20-rc2-/net/tipc/port.c linux-2.6.20-rc2/net/tipc/port.c
>--- linux-2.6.20-rc2-/net/tipc/port.c	2006-11-29 22:57:37.000000000 +0100
>+++ linux-2.6.20-rc2/net/tipc/port.c	2006-12-28 11:05:17.000000000 +0100
>@@ -238,7 +238,12 @@ u32 tipc_createport_raw(void *usr_handle
> 		return 0;
> 	}
> 
>-	tipc_port_lock(ref);
>+	if (!tipc_port_lock(ref)) {
>+		tipc_ref_discard(ref);
>+		warn("Port creation failed, reference table invalid\n");
>+		kfree(p_ptr);
>+		return 0;
>+	}
> 	p_ptr->publ.ref = ref;
> 	msg = &p_ptr->publ.phdr;
> 	msg_init(msg, DATA_LOW, TIPC_NAMED_MSG, TIPC_OK, LONG_H_SIZE, 0);
>diff -Nurp linux-2.6.20-rc2-/net/tipc/subscr.c linux-2.6.20-rc2/net/tipc/subscr.c
>--- linux-2.6.20-rc2-/net/tipc/subscr.c	2006-12-18 09:01:04.000000000 +0100
>+++ linux-2.6.20-rc2/net/tipc/subscr.c	2006-12-28 11:31:27.000000000 +0100
>@@ -499,7 +499,12 @@ static void subscr_named_msg_event(void 
> 
> 	/* Add subscriber to topology server's subscriber list */
> 
>-	tipc_ref_lock(subscriber->ref);
>+	if (!tipc_ref_lock(subscriber->ref)) {
>+		warn("Subscriber rejected, unable to find port\n");
>+		tipc_ref_discard(subscriber->ref);
>+		kfree(subscriber);
>+		return;
>+	}
> 	spin_lock_bh(&topsrv.lock);
> 	list_add(&subscriber->subscriber_list, &topsrv.subscriber_list);
> 	spin_unlock_bh(&topsrv.lock);
>-
>To unsubscribe from this list: send the line "unsubscribe netdev" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>  
>

