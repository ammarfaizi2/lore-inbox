Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVD0EVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVD0EVJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 00:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbVD0EVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 00:21:09 -0400
Received: from smtp.istop.com ([66.11.167.126]:18402 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261906AbVD0EU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 00:20:57 -0400
From: Daniel Phillips <phillips@istop.com>
To: sdake@mvista.com
Subject: Re: [PATCH 1b/7] dlm: core locking
Date: Wed, 27 Apr 2005 00:21:17 -0400
User-Agent: KMail/1.7
Cc: David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <20050425165826.GB11938@redhat.com> <200504262053.07836.phillips@istop.com> <1114566601.32399.3.camel@persist.az.mvista.com>
In-Reply-To: <1114566601.32399.3.camel@persist.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504270021.17408.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 April 2005 21:50, Steven Dake wrote:
> Daniel
>
> The issue is virtual synchrony for dlm, not virtual synchrony for
> synchronization of your block device work.

Honestly, at 250 uSec/message you don't have a hope of convincing anybody to 
use virtual synchrony in a dlm for anything other than slow path recovery.  
And even the performance requirements for recovery are more stringent than 
you would think.

> However, since it appears you would like to address it...

Actually, I just pointed out a practical opportunity for you to demonstrate 
the advantages of virtual synchrony in this context.

> While we could talk about your 
> particular design, virtual synchrony can synchronize at near wire speed
> for larger messages with encryption.

Maybe so, but the short message case is vastly more important.  And you would 
actually have to work at it to fall much below wire speed on long messages.

> In this case, there would be 
> benefit to synchronizing larger blocks of data at once, instead of
> individual (512 byte?) blocks of messages.

That is exactly what I do, of course.  More specifically, I let Linux do it 
for me.  My average synchronization message size is 20 bytes including 
header.  I also have very low latency because the wrapper on the raw tcp is 
thin.  Maybe I should strip away the last layer and ride right on the 
ethernet transport, to win another 10%.  Not that I really need it.  And not 
that not really needing it means I am prepared to give any up!

> I really doubt you would see 
> any performance improvement in the pure synchronization, although you
> would get encryption and authentication of messages, and you would not
> have those pesky race conditions.

What race conditions?  If you can spot any unhandled races, please let me know 
as soon as possible.

> So, there would be security, at little cost to performance.

Security has not yet become an issue for shared-disk filesystems, since any 
node with root basically owns the shared disk.  Hopefully, one day we will do 
something about that[1].  Even then chances are, only the packet headers need 
encrypting (or signing, more likely).

> Now on the topic of race conditions.  Any system with race conditions
> will eventually (in some short interval of operation) fail.  Are you
> suggesting that data is entrusted to a system with race conditions that
> result in failures in short intervals?

Surely you mean unhandled races?  Please show me any in my code, and I will be 
eternally indebted.

> But now back to the original point:
>
> The context we are talking about here is dlm.  In the dlm case, I find
> it highly unlikely the posted patches can process 100,000 locks per
> second (between processors) as your claim would seem to suggest.

Read the code and prepare to be amazed ;-)

> As the benchmarks have not been posted, its hard to see.

I posted some results for ddraid earlier, here and on linux-cluster.  There 
will be charts and graphs as I get time.  Anybody who is impatient can grab 
the code and make charts for themselves.  (But beware: the cluster snapshot 
has a nasty bottleneck in the server, due to no parallel disk IO.  The 
cluster raid is ok.)

> If the benchmarks 
> are beyond the 15,000 locks per second that could easily be processed with
> virtual synchrony with an average speed processor, then please, correct
> me.

Consider yourself corrected.

> Post dlm benchmarks Daniel...

I'm dancing as fast as I can ;-)

[1] I already lost a rather expensive bet re cluster security becoming a 
checkbox item within the past year.

Regards,

Daniel
