Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWEKQWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWEKQWL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 12:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbWEKQWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 12:22:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45953 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750872AbWEKQWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 12:22:09 -0400
Date: Thu, 11 May 2006 09:18:38 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, tytso@mit.edu,
       Herbert Xu <herbert@gondor.apana.org.au>, xen-devel@lists.xensource.com,
       ian.pratt@xensource.com, rdreier@cisco.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       virtualization@lists.osdl.org, chrisw@sous-sol.org
Subject: Re: [RFC PATCH 34/35] Add the Xen virtual network device driver.
Message-ID: <20060511091838.035c387c@localhost.localdomain>
In-Reply-To: <200605111147.53011.ak@suse.de>
References: <E1Fdz7v-0007zc-00@gondolin.me.apana.org.au>
	<fb99d7085b85310ef7d423a8f135db32@cl.cam.ac.uk>
	<200605111147.53011.ak@suse.de>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2006 11:47:52 +0200
Andi Kleen <ak@suse.de> wrote:

> On Thursday 11 May 2006 09:49, Keir Fraser wrote:
> > On 11 May 2006, at 01:33, Herbert Xu wrote:
> > >> But if sampling virtual events for randomness is really unsafe (is it
> > >> really?) then native guests in Xen would also get bad random numbers
> > >> and this would need to be somehow addressed.
> > >
> > > Good point.  I wonder what VMWare does in this situation.
> >
> > Well, there's not much they can do except maybe jitter interrupt
> > delivery. I doubt they do that though.
> >
> > The original complaint in our case was that we take entropy from
> > interrupts caused by other local VMs, as well as external sources.
> > There was a feeling that the former was more predictable and could form
> > the basis of an attack. I have to say I'm unconvinced: I don't really
> > see that it's significantly easier to inject precisely-timed interrupts
> > into a local VM. Certainly not to better than +/- a few microseconds.
> > As long as you add cycle-counter info to the entropy pool, the least
> > significant bits of that will always be noise.
> 
> I think I agree - e.g. i would expect the virtual interrupts to have
> enough jitter too. Maybe it would be good if someone could
> run a few statistics on the resulting numbers?
> 
> Ok the randomness added doesn't consist only of the least significant
> bits. Currently it adds jiffies+full 32bit cycle count.  I guess if it was
> a real problem the code could be changed to leave out the jiffies and 
> only add maybe a 8 bit word from the low bits. But that would only
> help for the para case because the algorithm for native guests
> cannot be changed.
> 
> >   2. An entropy front/back is tricky -- how do we decide how much
> > entropy to pull from domain0? How much should domain0 be prepared to
> > give other domains? How easy is it to DoS domain0 by draining its
> > entropy pool? Yuk.
> 
> I claim (without having read any code) that in theory you need to have solved 
> that problem already in the vTPM @)
> 

The base question under all this is "how good does an entropy source have
to be?" and then "what guarantees do we make about the entropy inputs used
by /dev/random?".  If we can resolve those, then the virtual environment
answer should fall out.

This is a area where the security tin-foil hat types take over, and it
gets real hard to make "good enough" argument. People have built an expectation
that /dev/random has really strong entropy, good enough to generate long term
keys etc.
