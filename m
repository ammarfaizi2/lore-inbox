Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266733AbUGUUxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266733AbUGUUxl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 16:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266736AbUGUUxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 16:53:41 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:64660 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266733AbUGUUxh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 16:53:37 -0400
Date: Wed, 21 Jul 2004 15:52:44 -0500
To: linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org,
       paulus@samba.org
Subject: resending .. Re: [PATCH] 2.6 PPC64: EEH notifier call chain
Message-ID: <20040721205244.GG13171@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Resending due to an email gateway outage.

--linas

----- Forwarded message from Mail Delivery System <Mailer-Daemon@bilge> -----
------ This is a copy of the message, including all the headers. ------

Return-path: <linas@bilge>
Received: from linas by bilge with local (Exim 3.36 #1 (Debian))
	id 1Bmc3c-000205-00; Mon, 19 Jul 2004 12:36:08 -0500
Date: Mon, 19 Jul 2004 12:36:08 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org,
	greg@kroah.com
Subject: Re: [PATCH] 2.6 PPC64: EEH notifier call chain
Message-ID: <20040719173608.GD7544@bilge>
References: <20040707152412.F21634@forte.austin.ibm.com> <16633.20057.434313.475775@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16633.20057.434313.475775@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040523i
From: Linas Vepstas <linas@bilge>

On Sun, Jul 18, 2004 at 02:05:45AM +1000, Paul Mackerras was heard to remark:
> Linas,
> 
> > Please review and forward upstream as appropriate.  
> 
> Sorry for the delay; have been on vacation.

And I just nagged you about this, just before discovering this email
in the inbox ... so apologies for nagging..

> > This patch implements a notifier call chain for EEH, as per pervious emails.
> > When an EEH slot freeze is detected, it is placed on a workqueue, from
> > whence it is dispatched to any regiistered notify callbacks.   The goal 
> > of the qorkqueue is to pull the slot-freeze detection out of an interrupt 
> > context.    As before, this patch only handles events for ethernet controllers;
> > I'll try to broaden the scope in future revisions.
> 
> I don't like the way we are making a policy decision here that
> ethernet devices can be recovered but other devices can't.  I would
> much rather call the notifier for all EEH events and have the notify
> callback(s) make the decision.  That could be either the hotplug
> driver or the device driver itself.  We get a return value from
> notifier_call_chain that could be used to communicate that back to
> eeh.c, if that is useful.

:)

Yes, except that some MMIO's occur in an interrupt context; ergo,
there must be some sort of policy in the interrupt handler until 
such time that device drivers become suitably EEH-aware.  Right
now, we can barely claim that ethernet is EEH-aware, but even that 
claim is pretty shaky, and is based on surmise rather than any 
analysis.

Note also, there are still firmware bugs in this call chain, even for
ethernet.  I also attempted a common USB controller (I forget the
brandname), and got some kind of massive corruption and flaming crash
before the workqueue code ever got a chance to run.   That's the 
why for the polciy in the interrupt context: to halt the system before
the corruption escapes into the wild.

I'm trying to think of this as an intermediate stepping stone until
such time that I get to actually start auditing the sea of device
drivers out there for correctness.  This will take a while; 
management has once again pulled me off of this task and onto 
something else :(

--linas

----- End forwarded message -----
