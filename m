Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965199AbWEKH4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965199AbWEKH4r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 03:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbWEKH4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 03:56:47 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:12430 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S965195AbWEKH4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 03:56:46 -0400
In-Reply-To: <E1Fdz7v-0007zc-00@gondolin.me.apana.org.au>
References: <E1Fdz7v-0007zc-00@gondolin.me.apana.org.au>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fb99d7085b85310ef7d423a8f135db32@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: xen-devel@lists.xensource.com, ian.pratt@xensource.com, rdreier@cisco.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       ak@suse.de (Andi Kleen), virtualization@lists.osdl.org,
       chrisw@sous-sol.org, shemminger@osdl.org
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 34/35] Add the Xen virtual network device driver.
Date: Thu, 11 May 2006 08:49:04 +0100
To: Herbert Xu <herbert@gondor.apana.org.au>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11 May 2006, at 01:33, Herbert Xu wrote:

>> But if sampling virtual events for randomness is really unsafe (is it
>> really?) then native guests in Xen would also get bad random numbers
>> and this would need to be somehow addressed.
>
> Good point.  I wonder what VMWare does in this situation.

Well, there's not much they can do except maybe jitter interrupt 
delivery. I doubt they do that though.

The original complaint in our case was that we take entropy from 
interrupts caused by other local VMs, as well as external sources. 
There was a feeling that the former was more predictable and could form 
the basis of an attack. I have to say I'm unconvinced: I don't really 
see that it's significantly easier to inject precisely-timed interrupts 
into a local VM. Certainly not to better than +/- a few microseconds. 
As long as you add cycle-counter info to the entropy pool, the least 
significant bits of that will always be noise.

The alternatives are unattractive:
  1. We have no good way to distinguish interrupts caused by packets 
from local VMs versus packets from remote hosts. Both get muxed on the 
same virtual interface.
  2. An entropy front/back is tricky -- how do we decide how much 
entropy to pull from domain0? How much should domain0 be prepared to 
give other domains? How easy is it to DoS domain0 by draining its 
entropy pool? Yuk.

  -- Keir

