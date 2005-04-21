Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVDUT5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVDUT5O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 15:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVDUT5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 15:57:14 -0400
Received: from pirx.hexapodia.org ([199.199.212.25]:26978 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S261825AbVDUT4n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 15:56:43 -0400
Date: Thu, 21 Apr 2005 12:56:41 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: Troy Benjegerdes <hozer@hozed.org>, Bernhard Fischer <blist@aon.at>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050421195641.GB13312@hexapodia.org>
References: <20050421173821.GA13312@hexapodia.org> <4267F367.3090508@ammasso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4267F367.3090508@ammasso.com>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2005 at 01:39:35PM -0500, Timur Tabi wrote:
> Andy Isaacson wrote:
> >If you take the hardline position that "the app is the only thing that
> >matters", your code is unlikely to get merged.  Linux is a
> >general-purpose OS.
> 
> The problem is that our driver and library implement an API that we don't 
> fully control. The API states that the application allocates the memory and 
> tells the library to register it.  The app then goes on its merry way until 
> it's done, at which point it tells the library to deregister the memory.  
> Neither the app nor the API has any provision for the app to be notified 
> that the memory is no longer pinned and therefore can't be trusted. That 
> would be considered a critical failure from the app's perspective, so the 
> kernel would be doing it a favor by killing the process.

I'm familiar with MPI 1.0 and 2.0, but I haven't been following the
development of modern messaging APIs, so I might not make sense here...

Assuming that the app calls into the library on a fairly regular basis,
you could implement a fast-path/slow-path scheme where the library
normally operates in go-fast mode, but if a "unregister" event has
occurred, the library falls back to a less performant mode.

But now having written that I'm thinking that it's not worth the bother
- if you've got a 512P MPP job, it's basically equivalent to job death
for one of the nodes to go away in this manner -- even if the process is
still running on the node, the fact that you took a giant performance
hiccup is unacceptable.  Therefore, cluster admins are going to do their
darndest to avoid this behavior, so we might as well just kill the job
and make it explicit.

> >You might want to consider what happens with your communication system
> >in a machine running power-saving modes (in the limit, suspend-to-disk).
> >Of course most machines with Infiniband adapters aren't running swsusp,
> >but it's not inconceivable that blade servers might sleep to lower power
> >and cooling costs.
> 
> Any application that registers memory, will in all likelihood be running at 
> 100% CPU non-stop.  The computer is not going to be doing anything else but 
> whatever that app is trying to do.  The application could conceiveable 
> register gigabytes of RAM, and if even a single page becomes unpinned, the 
> whole thing is worthless.  The application cannot do anything meaningful if 
> it gets a message saying that some of the memory has become unpinned and 
> should not be used.
> 
> So the real question is: how important is it to the kernel developers that 
> Linux support these kinds of enterprise-class applications?

While I understand your arguments, this kind of rhetoric is more likely
to harden ears than to convince people you're right.  I refer you to the
"Live Patching Function" thread.

*You* need to come up with a solution that looks good to *the community*
if you want it merged.  In the long run, this process is likely to
result in *your* systems working better than if you had just gone off
and done your thing.  If you have to do something that "tastes bad" to
the average l-k hacker, *justify* it by addressing the alternatives and
explaining why your solution is the right one.

I'm leaning towards agreeing that mlock()-alicious code is the right way
to solve this problem, and it's not clear to me what the benefit of
adding a new VM_REGISTERED flag would be.

Do you guys simply raise RLIMIT_MEMLOCK to allow apps to lock their
pages?  Or are you doing something more nasty?

(Oh, I see that Libor has contributed to the other branch of this
thread... off to read...)

-andy
