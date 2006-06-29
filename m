Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWF2O7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWF2O7h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 10:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWF2O7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 10:59:37 -0400
Received: from 25.mail-out.ovh.net ([213.186.37.103]:10648 "EHLO
	25.mail-out.ovh.net") by vger.kernel.org with ESMTP
	id S1750764AbWF2O7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 10:59:36 -0400
Message-ID: <10356.192.100.124.218.1151593170.squirrel@192.100.124.218>
In-Reply-To: <20060629142741.GA1294@us.ibm.com>
References: <1151542602.18723.19.camel@josh-work.beaverton.ibm.com>
    <20060629142741.GA1294@us.ibm.com>
Date: Thu, 29 Jun 2006 16:59:30 +0200 (CEST)
Subject: Re: [PATCH] irda: Fix RCU lock pairing on error path
From: "Samuel Ortiz" <samuel@sortiz.org>
To: paulmck@us.ibm.com, "Josh Triplett" <josht@vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, "Dipkanar Sarma" <dipankar@in.ibm.com>,
       "Andrew Morton" <akpm@osdl.org>, "Samuel Ortiz" <samuel@sortiz.org>
Reply-To: samuel@sortiz.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul, hi Josh,

Paul E. McKenney wrote :
> On Wed, Jun 28, 2006 at 05:56:41PM -0700, Josh Triplett wrote:
>> irlan_client_discovery_indication calls rcu_read_lock and
>> rcu_read_unlock, but
>> returns without unlocking in an error case.  Fix that by replacing the
>> return
>> with a goto so that the rcu_read_unlock always gets executed.
>
> Good catch!!!  Looks good from an RCU viewpoint, in fact, looks absolutely
> necessary to permit IRDA to work in debug mode, particularly in either
> a CONFIG_PREEMPT or a -rt kernel.
Indeed, nice catch.

> One question below, but up to the maintainer.  ;-)
Yes, definitely, IRDA_ASSERT_LABEL(out:) makes sense.
I will forward the patch to davem's netdev tree, thanks.

Cheers,
Samuel.


> 							Thanx, Paul
>
> Acked-by: Paul E. McKenney <paulmck@us.ibm.com>
>> Signed-off-by: Josh Triplett <josh@freedesktop.org>
>>
>> ---
>>
>>  net/irda/irlan/irlan_client.c |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> e20ab96944814489277c3bfd4e69133854ab01e9
>> diff --git a/net/irda/irlan/irlan_client.c
>> b/net/irda/irlan/irlan_client.c
>> index f8e6cb0..5ce7d2e 100644
>> --- a/net/irda/irlan/irlan_client.c
>> +++ b/net/irda/irlan/irlan_client.c
>> @@ -173,13 +173,14 @@ void irlan_client_discovery_indication(d
>>  	rcu_read_lock();
>>  	self = irlan_get_any();
>>  	if (self) {
>> -		IRDA_ASSERT(self->magic == IRLAN_MAGIC, return;);
>> +		IRDA_ASSERT(self->magic == IRLAN_MAGIC, goto out;);
>>
>>  		IRDA_DEBUG(1, "%s(), Found instance (%08x)!\n", __FUNCTION__ ,
>>  		      daddr);
>>
>>  		irlan_client_wakeup(self, saddr, daddr);
>>  	}
>> +out:
>
> Should the above label instead be as follows?
>
> 	IRDA_ASSERT_LABEL(out:)
>
> Just in case some variant of gcc, sparse, or whatever complains about
> labels that don't have a corresponding goto (in CONFIG_IRDA_DEBUG=n
> builds).
>
>>  	rcu_read_unlock();
>>  }
>>
>>
>>
>

