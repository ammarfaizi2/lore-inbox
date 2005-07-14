Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262835AbVGNAau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262835AbVGNAau (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 20:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbVGNAat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 20:30:49 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:41196 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262852AbVGNAaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 20:30:17 -0400
Date: Thu, 14 Jul 2005 10:22:46 +1000
From: Nathan Scott <nathans@sgi.com>
To: Daniel Walker <dwalker@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       Steve Lord <lord@xfs.org>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: RT and XFS
Message-ID: <20050714002246.GA937@frodo>
References: <1121209293.26644.8.camel@dhcp153.mvista.com> <20050713002556.GA980@frodo> <20050713064739.GD12661@elte.hu> <1121273158.13259.9.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121273158.13259.9.camel@c-67-188-6-232.hsd1.ca.comcast.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

On Wed, Jul 13, 2005 at 09:45:58AM -0700, Daniel Walker wrote:
> On Wed, 2005-07-13 at 08:47 +0200, Ingo Molnar wrote:
> > 
> > downgrade_write() wasnt the main problem - the main problem was that for 
> > PREEMPT_RT i implemented 'strict' semaphores, which are not identical to 
> > vanilla kernel semaphores. The thing that seemed to impact XFS the most 
> > is the 'acquirer thread has to release the lock' rule of strict 
> > semaphores.  Both the XFS logging code and the XFS IO completion code 
> > seems to release locks in a different context from where the acquire 
> > happened. It's of course valid upstream behavior, but without these 
> > extra rules it's hard to do sane priority inheritance. (who do you boost 
> > if you dont really know who 'owns' the lock?) It might make sense to 
> > introduce some sort of sem_pass_to(new_owner) interface? For now i 
> > introduced a compat type, which lets those semaphores fall back to the 
> > vanilla implementation.

Hmm, I'm not aware of anywhere in XFS where we do that.  From talking
to some colleagues here, they're claiming that we can't be doing that
since it'd trip an assert in the IRIX mrlock code.

> There's a lot of code like this in there .. I've seen some that down()
> in process contex, and up() in interrupt contex which is weird .. But
> those aren't major features, just little drivers. XFS is pretty major
> feature.
> 
> Nathan, does XFS need this property or could we convert it to
> synchronize the locking (with ease?)?

I'm not yet sure in what situations we are doing this, so can't
really say.  It'd be interesting to see an implementation of the
downgrade_write functionality and then a specific case where the
above locking behaviour happens ... and I'd then be able to say
how tricky that would be to resolve.

Steve, are you aware of situations where we unlock in a different 
thread to where we acquired the lock?  It'd surprise me, as we're
holding these things for as short a time as possible - afaict the
transactions always ilock, copy delta to iclog, pin, and unlock,
no?  (all in the same thread).  I can't see the iolock being used
in this way anywhere either... you?

cheers.

-- 
Nathan
