Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264643AbUGCFXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264643AbUGCFXz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 01:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbUGCFXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 01:23:55 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:64390 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S264643AbUGCFXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 01:23:53 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] 3/5: Device-mapper: snapshots
Date: Sat, 3 Jul 2004 01:30:02 -0400
User-Agent: KMail/1.6.2
Cc: Alasdair G Kergon <agk@redhat.com>, linux-kernel@vger.kernel.org
References: <22Gkd-1AX-17@gated-at.bofh.it> <m3r7sx6dip.fsf@averell.firstfloor.org>
In-Reply-To: <m3r7sx6dip.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407030130.02067.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 June 2004 14:06, Andi Kleen wrote:
> Alasdair G Kergon <agk@redhat.com> writes:
> > +
> > +/*-----------------------------------------------------------------
> > + * Persistent snapshots, by persistent we mean that the snapshot
> > + * will survive a reboot.
> > + *---------------------------------------------------------------*/
>
> Is this target supposed to be crash safe? What happens when
> the computer crashes while writing to such a volume?
>
> I suppose it would need barriers for that at least, which it doesn't
> seem to use.

Hi Andi,

Please pardon the one month lag, I must bug Zack about getting Kernel Traffic 
out faster ;)

It is designed to be crash-safe:

  - Each snapshot exception is logged to disk by overwriting the last sector
    of a grow-only list of snapshot exceptions.

  - Write completion is not handed back up the chain until:

      - the data to be overwritten has been copied to a new exception
      - the new exception has been logged to the snapshot store as above

As far as I can see, the concept is leak-proof, except for being sensitive to 
random garbage in the last few sector writes.  I suspect that doesn't happen 
on modern disk drives.  If it does, I hope somebody will shout.

I am not sure what you mean about barriers, perhaps you were thinking of 
synchronous waiting.  This snapshot driver does wait for completions, but it 
pipelines the waits so throughput is not affected much (snapshot overhead is 
dominated by copyouts).

Incidently, there is an entirely new snapshot design coming down the pipe that 
uses a more traditional, journalling design to achieve the necessary 
hardware-like durability.

Regards,

Daniel
