Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVD0Bu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVD0Bu2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 21:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVD0Bu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 21:50:28 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:6851 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S261884AbVD0BuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 21:50:11 -0400
Subject: Re: [PATCH 1b/7] dlm: core locking
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: Daniel Phillips <phillips@istop.com>
Cc: David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <200504262053.07836.phillips@istop.com>
References: <20050425165826.GB11938@redhat.com>
	 <200504261824.22382.phillips@istop.com>
	 <1114556655.31647.90.camel@persist.az.mvista.com>
	 <200504262053.07836.phillips@istop.com>
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Message-Id: <1114566601.32399.3.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 26 Apr 2005 18:50:02 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgive the double post
forgot to hit "reply all"

Daniel

The issue is virtual synchrony for dlm, not virtual synchrony for
synchronization of your block device work.  However, since it appears
you would like to address it...  While we could talk about your
particular design, virtual synchrony can synchronize at near wire speed
for larger messages with encryption.  In this case, there would be
benefit to synchronizing larger blocks of data at once, instead of
individual (512 byte?) blocks of messages.  I really doubt you would see
any performance improvement in the pure synchronization, although you
would get encryption and authentication of messages, and you would not
have those pesky race conditions.  So, there would be security, at
little cost to performance.

Now on the topic of race conditions.  Any system with race conditions
will eventually (in some short interval of operation) fail.  Are you
suggesting that data is entrusted to a system with race conditions that
result in failures in short intervals?

But now back to the original point:

The context we are talking about here is dlm.  In the dlm case, I find
it highly unlikely the posted patches can process 100,000 locks per
second (between processors) as your claim would seem to suggest.  As the
benchmarks have not been posted, its hard to see.  If the benchmarks are
beyond the 15,000 locks per second that could easily be processed with
virtual synchrony with an average speed processor, then please, correct
me.

Post dlm benchmarks Daniel...
regards
-steve
On Tue, 2005-04-26 at 17:53, Daniel Phillips wrote:
> On Tuesday 26 April 2005 19:04, Steven Dake wrote:
> > ...Your performance impressions may be swayed by the benchmark results in
> > this message... 
> >
> > We have been over this before...  In September 2004, I posted benchmarks
> > to lkml (in a response to your questions about performance numbers)
> > which show messages per second of 7820 for 100 byte messages.
> 
> Hi Steven,
> 
> The source of the benchmark I alluded to is lost in the mists of my foggy 
> memory, however the numbers you just gave seem to be about the same as I 
> remember.
> 
> I get >>several hundred thousand<< synchronization messages per second in my 
> cluster block devices, using ordinary tcp sockets over 100 MHz ethernet.  
> This may help put things in perspective.
> 
> > I'd be 
> > impressed to see any other protocol deliver that number of messages per
> > second (in and of itself), maintain self delivery, implicit
> > acknowledgement, agreed ordering, and virtual synchrony...
> 
> Well, the way I do it is so much faster than what you're seeing that I can 
> easily justify putting in the extra effort to resolve issues that virtual 
> synchrony would apparently solve for me automagically.
> 
> Please let me save the details for a post tomorrow.  Then I will wax poetic 
> about what we do, or plan to do, to solve the various nasty problems that 
> come up as a result of membership changes, so that nobody runs such risks as 
> receiving messages from a node that thinks it is in the cluster but actually 
> isn't.
> 
> > <benchmarks>
> > Are you suggesting this is a dribble?
> 
> Sorry, in my world, that's a dribble ;-)
> 
> I stand by my statement that this is too slow to handle the heavy lifting, and 
> is marginal even for "slow path" cluster recovery.  But if you think 
> otherwise, you can easily prove it, see below.
> 
> > Your suggestion, reworking redhat's cluster suite to use virtual
> > synchrony (as a demo?), sounds intrigueing.  However, I just don't have
> > the bandwidth at this time to take on any more projects (although I am
> > happy to support redhat's use of virtual synchrony).  The community,
> > however, would very much benefit from redhat leading such an effort.
> 
> I did not suggest reworking Red Hat's cluster suite.  I suggested reworking 
> _one file_ of my cluster snapshot device.  This file was designed to be 
> reworked by someone such as yourself, even someone without an enormous amount 
> of time on their hands.  This file (agent.c) does not handle the high-speed 
> block device synchronization, it only handles inter-node recovery messages 
> and other slow-path chores.
> 
> For your convenience, the cluster snapshot device can be operated entirely 
> independently of the rest of the cluster suite, and you don't even need a 
> cluster.
> 
> Regards,
> 
> Daniel

