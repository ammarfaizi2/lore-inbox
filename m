Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbVAQNzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbVAQNzV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 08:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbVAQNzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 08:55:21 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:60368 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262802AbVAQNzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 08:55:12 -0500
Date: Mon, 17 Jan 2005 14:54:51 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Karim Yaghmour <karim@opersys.com>
cc: Andi Kleen <ak@muc.de>, Nikita Danilov <nikita@clusterfs.com>,
       linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
In-Reply-To: <41EADA11.70403@opersys.com>
Message-ID: <Pine.LNX.4.61.0501171403490.30794@scrub.home>
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de>
 <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de>
 <41E7A7A6.3060502@opersys.com> <Pine.LNX.4.61.0501141626310.6118@scrub.home>
 <41E8358A.4030908@opersys.com> <Pine.LNX.4.61.0501150101010.30794@scrub.home>
 <41E899AC.3070705@opersys.com> <Pine.LNX.4.61.0501160245180.30794@scrub.home>
 <41EA0307.6020807@opersys.com> <Pine.LNX.4.61.0501161648310.30794@scrub.home>
 <41EADA11.70403@opersys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 16 Jan 2005, Karim Yaghmour wrote:

> > You can make it even simpler by dropping this completely. Every buffer is 
> > simply a list of events and you can let ltt write periodically a timer 
> > event. In userspace you can randomly seek at buffer boundaries and search 
> > for the timer events. It will require a bit more work for userspace, but 
> > even large amount of tracing data stays managable.
> 
> We already do write a heartbeat event periodically to have readable
> traces in the case where the lower 32 bits of the TSC wrap-around.
> 
> As I mentioned elsewhere, please don't think of this in terms of
> kbs or mbs of data. What we're talking about here is gbs if not
> 100gbs of data. Having to start reading each sub-buffer until you
> hit a heartbeat really is a killer for such large traces. If there
> was a significant impact on relayfs for having this I would have
> understood the argument, but relayfs needs to do buffer-management
> anyway, so I don't see that much complexity being added by allowing
> the channel user to ask relayfs for delimiters.

Periodically can also mean a buffer start call back from relayfs 
(although that would mean the first entry is not guaranteed) or a 
(per cpu) eventcnt from the subsystem. The amount of needed search would 
be limited. The main point is from the relayfs POV the buffer structure 
has always the same (simple) structure.
You have to be more specific, what's so special about this amount of data. 
You likely want to (incrementally) build an index file, so you don't have 
to repeat the searches, but even with your current format you would 
benefit from such an index file.

> > Userspace can then easily restore the original order of events.
> 
> As above, restoring the original order of events is fine if you are
> looking at mbs or kbs of data. It's just totally unrealistic for
> the amounts of data we want to handle.

Why is it "totally unrealistic"?

> But like I said earlier, the added relayfs mode (kdebug) would allow
> for exactly what you are suggesting:
> 	event_id = atomic_inc_return(&event_cnt);

Actually that would be already too much for low level kernel debugging.
Why do you want to put this into relayfs?
What are the _specific_ reasons you need these various modes, why can't 
you build any special requirements on top of a very light weight relay 
mechanism?

bye, Roman
