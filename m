Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161040AbWGMXIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbWGMXIS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 19:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbWGMXIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 19:08:18 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:51386 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161040AbWGMXIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 19:08:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BJ3+HjYlTnjMe361VBvYHSQuoFYHcab1XJmQvFL50fR4xydU3YE46RVV7lK6Z9Ngze2mlQx0OQ3BhlUIVwDZ188HIL05ZvWLDZIfcuRk2e7Q7VzsSeYL45xnOFedcA0QQ4apaa0eiOGtNs51mHrq0nrMLQzgh/sYrUGwZ1i4WFw=
Message-ID: <35f686220607131608ic63a346p248020b48d4cc734@mail.gmail.com>
Date: Thu, 13 Jul 2006 16:08:17 -0700
From: "Alok kataria" <alokkataria1@gmail.com>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: [patch] lockdep: annotate mm/slab.c
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Pekka Enberg" <penberg@cs.helsinki.fi>, "Ingo Molnar" <mingo@elte.hu>,
       "Andrew Morton" <akpm@osdl.org>, sekharan@us.ibm.com,
       linux-kernel@vger.kernel.org, nagar@watson.ibm.com, balbir@in.ibm.com,
       alokk@calsoftinc.com
In-Reply-To: <Pine.LNX.4.64.0607131520340.30403@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1152763195.11343.16.camel@linuxchandra>
	 <20060713071221.GA31349@elte.hu>
	 <20060713002803.cd206d91.akpm@osdl.org> <20060713072635.GA907@elte.hu>
	 <20060713004445.cf7d1d96.akpm@osdl.org>
	 <20060713124603.GB18936@elte.hu>
	 <84144f020607130858l60792ac0t5f9cdabf1902339c@mail.gmail.com>
	 <Pine.LNX.4.64.0607131156060.5623@g5.osdl.org>
	 <1152818472.3024.75.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0607131520340.30403@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 7/13/06, Christoph Lameter <clameter@sgi.com> wrote:
> On Thu, 13 Jul 2006, Arjan van de Ven wrote:
>
> > there is a corner case in the slab code that I personally don't trust at
> > all. In the NUMA case, if the memory is not originally from your own
> > node, the cache_free_alien() function takes, while having your own local
> > lock, the lock of the remote node as well. (at least on my reading of
> > the code) to free the memory to that node. I have yet to see where in
> > the code it safeguards against that remote node doing the exact same
> > thing in the opposite direction concurrently, and causing a basic ABBA
> > deadlock.
>
> Hmmm.. This case is only followed during bootup when we do not have
> alien caches yet. And its pretty rare to free memory on bootup. Once the
> alien caches are present then we do not take the listlock anymore but
> use the lock of the alien structure.
>

Christoph, IMO even then we wont deadlock, because in the case of a
remote free when there are no alien caches, we simply take the remote
node's list_lock and free the object, directly in the remote slab.

> This could cause an ABBA deadlock if a free happens on another
> processor during bootup before all the slabs are established.
>
> That then brings us to look if a slab free can happen before a slab is
> completely established via kmem_cache_create.
>
> kmem_cache_create takes the cpu hotplug lock and the cache_chain_mutex.
>
> One could argue that a subsystem must make sure that the slab cache it
> creates should not be used before kmem_cache_create is complete?
>
> Alokk: Do we really need to check for alien caches not present there?
>

Yes we do need to, there can be a case when all cpu's of a node have
gone down, we free the alien cache, and this alien cache might have
come from this cache itself, (see cpuup_callback).  In this case we
will find the alien caches to be absent and then we will directly free
to the remote nodes slab.


Thanks & Regards,
Alok
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


-- 
A computer scientist is someone who, when told to "Go to Hell," sees
the "go to," rather than the destination, as harmful.

Alok Kataria
