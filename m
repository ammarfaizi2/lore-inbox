Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932678AbWAMNoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678AbWAMNoJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 08:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932711AbWAMNoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 08:44:08 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:18885 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932678AbWAMNoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 08:44:07 -0500
Date: Fri, 13 Jan 2006 14:44:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Duncan Sands <baldrick@free.fr>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: [patch 00/62] sem2mutex: -V1
Message-ID: <20060113134412.GA20339@elte.hu>
References: <20060113124402.GA7351@elte.hu> <200601131400.00279.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601131400.00279.baldrick@free.fr>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.1 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Duncan Sands <baldrick@free.fr> wrote:

> > this patch-queue converts 66% of all semaphore users in 2.6.15-git9 to 
> > mutexes.
> 
> Hi Ingo, the changes to drivers/usb/atm/usbatm.[ch] conflict with a 
> bunch of patches I just sent to Greg KH.  How do you plan to handle 
> this kind of thing?  If you like, I can tweak this part of your patch 
> so it applies on top of mine, and push it to Greg.

yeah, the best solution from our POV is if you pick it up and send it to 
Greg on your own schedule. We'll probably still carry all the patches in 
our tree up until your changes upstream, because it's hard to keep track 
of who does what, and we try to cover all the conversions. In general, 
the faster this phase is over, the better.

we expect there to be two types of bugs introduced by these patches:

 - build error - if we forgot to add mutex.h somewhere.

   We think we covered most of the build issues via allyesconfig QA, but 
   it's possible in theory under some .config's.

 - we misidentified a semaphore and converted it to mutexes, albeit the 
   use was not purely mutex.

   all such misidentifications should trigger runtime warnings if 
   CONFIG_DEBUG_MUTEXES is turned on. If this happens, then one of the 
   following 3 scenarios should trigger:

    - it should stay a semaphore (if it's a genuine counting 
      semaphore)

    - or it should get converted to a completion (if it's used as
      a completion)

    - or it should get converted to struct work (if it's used as a 
      workflow synchronizer).

   we _think_ we've identified all the converted semaphores correctly 
   (and we have source-code-analyzing tools to underline that belief, 
   plus we have a track record in -rt, which runs with all these 
   semaphores converted to mutexes, plus we have done our own QA), but 
   at 500+ files changed, it would be quite over-confident to claim that 
   the patch is 100% perfect :-)

   another thing raises the confidence in the analysis: none of the
   runtime mutex checks ever triggered during the development of this
   conversion patchset. We did find a handful of bugs in drivers, but
   they were all caught at the source/analysis level. We occasionally
   forgot to convert some affected .c or .h modules, which errors were
   caught at the build stage.

   famous last words? :-)

	Ingo
