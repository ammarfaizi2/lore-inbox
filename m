Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbVHQPVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVHQPVl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 11:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbVHQPVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 11:21:41 -0400
Received: from spc1-leed3-6-0-cust185.seac.broadband.ntl.com ([80.7.68.185]:54545
	"EHLO fentible.pjc.net") by vger.kernel.org with ESMTP
	id S1751150AbVHQPVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 11:21:40 -0400
Message-ID: <430355F3.5000807@tykepenguin.com>
Date: Wed, 17 Aug 2005 16:21:23 +0100
From: Patrick Caulfield <patrick@tykepenguin.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: Steven Whitehouse <steve@chygwyn.com>, Suzanne Wood <suzannew@cs.pdx.edu>,
       linux-kernel@vger.kernel.org, walpole@cs.pdx.edu
Subject: Re: rcu read-side protection
References: <000f01c5a2bf$f8e752d0$6401a8c0@woodworkxi42l4> <20050817020156.GF1319@us.ibm.com> <20050817082552.GA25537@souterrain.chygwyn.com> <20050817141438.GD1300@us.ibm.com>
In-Reply-To: <20050817141438.GD1300@us.ibm.com>
X-Enigmail-Version: 0.92.0.0
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAHlBMVEXmxsMFAgCWmaJAJSmo
 bWgJBADGoakXEBRfXFQIBAjp3NUzAAACaElEQVQ4jVXTQWvbMBQHcNFBtqsoIeRWRsm22zYV5F2z
 h9HVFJH5VooRO654QfWtxV6n3ma64Pnb7v8kJ01fSGL003t6z9jCFvwp7KD01lpbevxKhMCynRd2
 U/P6XNrBHwG+tW8aXrDWbwv8z4WNMSjvSyxg18bLlBGjBmzj1c56bJhPsFFK+x3XLEfr+5ixSwlK
 ee7JWsBNBI+Sc8UA2URoImhdyAWDbgaGsvR8SCGU6uXApVTjUxImQtcitL30PtXyvvYDdqG/AiAX
 WJgg03zNjQsyctEMMQVx8dXrCd6+lwPXyDKsBzLMEdz3BCpw5FVqvJCAJRf3KgvBkKsCYKNupBBv
 eu8HX+eOOnKuot/eb3SEseZ2sOYQBCgv6RfgFaBWnUsBaOzl+QG4SgyUKu236nGCjEJH+ZWYVcgY
 7N/ZBDozwYQud86EVmv7Z3YPeM0QciLKXWU6auvtDzGByrrKBABRIFLNHp7aDPsNUUXrNpDyHycY
 sNvxdoyI0P5sDxRyADrqmNtbIT4B3o2DQ3keASdgxPbzHsYEtIezA6DXCI6haq8SfBjHhz2YmPEM
 P19AEEKMCf6dEx+dA+gY+tMKsyHi+PQA6BMsuzwCR053Qsw443Ec5VOcO3acE84+SdDL0zg30tAv
 odKJjCDlYo3dbuau+Z6IQ4aUy26F6YWokLU+BnnBtbgDV929gFtaudQTnR1gCVh069hxFcc7ypCB
 0oymjRn9M3RpjqDVag9cahn4jqOBFk97tjpkLOvOoOP82mRtfIF0L8T9iHXV8bNIBq9I22ahVVqI
 L318sPhkfkMMUgJekv/6D1oqiFUyQgAAAABJRU5ErkJggg==
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney wrote:
> On Wed, Aug 17, 2005 at 09:25:52AM +0100, Steven Whitehouse wrote:
> 
>>Hi,
>>
>>On Tue, Aug 16, 2005 at 07:01:57PM -0700, Paul E. McKenney wrote:
>>
>>>On Tue, Aug 16, 2005 at 05:09:29PM -0700, Suzanne Wood wrote:
>>>[ . . . ]
>>>
>>>>A read-side critical section is marked to protect the dereference of the 
>>>>dn_ptr and assignment to dn_db which is a pointer to a dn_dev.  (struct 
>>>>net_device is defined in /linux/netdevice.h and its dn_ptr in 
>>>>/include/net/dn_dev.h)  Should this rcu-protection be extended to the line 
>>>>following rcu_read_lock()?  Even though use_long is a simple char, it 
>>>>appears to be a member of an rcu-protected structure.
>>>
>>>Looks to me that this could indeed be a problem -- the structure
>>>pointed to by dn_db could potentially be freed immediately after the
>>>rcu_read_unlock(), unless there is some other non-obvious locking
>>>mechanism protecting it.  In which case, why the rcu_read_lock()
>>>and rcu_read_unlock()...
>>>
>>>						Thanx, Paul
>>
>>The dev->dn_ptr points to the DECnet specific portion of a net device which
>>is allocated in dn_dev.c/dn_dev_up and freed in dn_dev.c/dn_dev_delete when
>>the net device goes up and down.
>>
>>So I think you are right in that as far as I can see, its possible for a
>>net device going down to race with this, but the window of opportunity is
>>very small indeed (in fact possibly zero?) due to the ordering of operations
>>in dn_dev_delete where dev->dn_ptr is set to NULL (esentially preventing
>>any more DECnet packets being received on that device) before flushing all
>>neighbours and only then releasing dn_db.
> 
> 
> I agree that the window is quite small, but suppose that there was a
> lengthy interrupt received just after the rcu_read_unlock()?
> 
> 
>>Also, Patrick Caulfield is maintaining this code now, so I've added him to
>>the CC list. Thanks for the report though,
> 
> 
> How about the following patch?  Untested, but seems pretty straightforward.
> 
> 							Thanx, Paul
> 
> Fix RCU race condition in dn_neigh_construct().
> 
> ---
> 
> Signed-off-by: <paulmck@us.ibm.com>
> 
> diff -urpNa -X dontdiff linux-2.6.13-rc6/net/decnet/dn_neigh.c linux-2.6.13-rc6-db_db/net/decnet/dn_neigh.c
> --- linux-2.6.13-rc6/net/decnet/dn_neigh.c	2005-08-08 19:59:25.000000000 -0700
> +++ linux-2.6.13-rc6-db_db/net/decnet/dn_neigh.c	2005-08-17 07:08:10.000000000 -0700
> @@ -148,12 +148,12 @@ static int dn_neigh_construct(struct nei
>  
>  	__neigh_parms_put(neigh->parms);
>  	neigh->parms = neigh_parms_clone(parms);
> -	rcu_read_unlock();
>  
>  	if (dn_db->use_long)
>  		neigh->ops = &dn_long_ops;
>  	else
>  		neigh->ops = &dn_short_ops;
> +	rcu_read_unlock();
>  
>  	if (dn->flags & DN_NDFLAG_P3)
>  		neigh->ops = &dn_phase3_ops;
> 
> 

Looks fine to me. I've done a quick test and it doesn't seem to interfere - not
that I expected it to :)

Thanks.

-- 

patrick
