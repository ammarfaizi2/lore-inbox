Return-Path: <linux-kernel-owner+w=401wt.eu-S1422668AbWLUDbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422668AbWLUDbU (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 22:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422665AbWLUDbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 22:31:19 -0500
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:31348 "HELO
	smtp107.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1422668AbWLUDbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 22:31:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=QE9kMCdW7Pfuc+g6NkpsI1UzFzHMVJHdqVQcRcyDfz/pO1vjvjzLlu/wicrQ3G0rYnomaxkrcIjL7OecYi2kxq5CmwjrkI/WKRjmmAwbI5mc+bP7aC7kuJcUeVr7xxWxaiS6z+66MkcfIeoYViKnVRr6c01QiXg/yROgEsa05+Y=  ;
X-YMail-OSG: cOf8YAUVM1lpw5Knem7mPsch1fBAPAuPDWca0c7dArhpuvbcWLvxmV2S.E.7bZocQBaUJtJMbXn49.NpemmvNtNYC.IIopojuzeF2ZtVOh8NJhZL5QEI7vMWMbeiP9CgyrTrNhLBYp7WU9.q99LLNiILGVjiVnjNrbzeNuM4GKm6KmAaJVC9Af9q3vmA
From: David Brownell <david-b@pacbell.net>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/2] Fix /sys/device/.../power/state
Date: Wed, 20 Dec 2006 19:04:28 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
References: <20061219185223.GA13256@srcf.ucam.org> <200612201318.06976.david-b@pacbell.net> <20061221012924.GC32625@srcf.ucam.org>
In-Reply-To: <20061221012924.GC32625@srcf.ucam.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200612201904.28681.david-b@pacbell.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 December 2006 5:29 pm, Matthew Garrett wrote:
> On Wed, Dec 20, 2006 at 01:18:06PM -0800, David Brownell wrote:
> > >  	/* disallow incomplete suspend sequences */
> > > -	if (dev->bus && (dev->bus->suspend_late || dev->bus->resume_early))
> > > +	if (dev->bus && dev->bus->pm_has_noirq_stage 
> > > +	    && dev->bus->pm_has_noirq_stage(dev))
> > >  		return error;
> > >  
> > 
> > I'm suspecting these two patches won't be merged,

Make that "strongly suspecting" given what Greg said ... he normally
gets the final say over drivers/core/* things, and you seem alone in
wanting to help those sysfs files extend their withered existence.


> > but this fragment has 
> > two bugs.  One is the whitespace bug already mentioned.
> 
> I'm a bit curious about the whitespace issue - CodingStyle doesn't seem 
> to discuss what to do with if statements that end up longer than 80 
> characters, which is (I think) what you're talking about?

It does say that indents must use only tabs, which that clearly doesn't.
I think you'll find that

	if (some_very_long_condition
			&& probably_not_quite_as_long
			&& or_too_long_for_one_line) {
		do_this;
		and_this;
	}

is widely accepted.  (The conditions get an extra indent so they don't
look like they're part of the block executing if the test is true.)


> 
> > The other is that
> > the original test must still be used if that bus primitve doesn't exist.
> 
> I dislike that.

Tough noogies, as they say.  In a tradeoff between correctness and your
personal taste (or even mine, sigh!), the normal tradeoff is in favor
of correctness.


> We're asking to suspend an individual device - whether  
> the bus supports devices that need to suspend with interrupts disabled 
> is irrelevent, it's the device that we care about. We should just make 
> it necessary for every bus to support this method until the interface is 
> removed.

But you _didn't_ do anything to "make it necessary".  Which means that
your patch *WILL* cause bugs whenever a driver uses those calls, and
courtesy of your patch userspace tries to suspend that device ... 


> > > +       bus->pm_has_noirq_stage()
> > > -When:  July 2007
> > > +When:  Once alternative functionality has been implemented
> > 
> > The "When" shouldn't change.
> 
> We shouldn't remove interfaces that userland uses until there's been a 
> replacement for long enough that userland can switch over.

Userland can stop using this **TODAY** and just "ifdown", so that
argument seems weak.  For all your examples, the userland interface
is already available.

- Dave

