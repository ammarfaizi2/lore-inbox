Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262540AbVAPQwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbVAPQwx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 11:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVAPQwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 11:52:53 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:7116 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262540AbVAPQwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 11:52:40 -0500
Date: Sun, 16 Jan 2005 17:52:25 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Karim Yaghmour <karim@opersys.com>
cc: Andi Kleen <ak@muc.de>, Nikita Danilov <nikita@clusterfs.com>,
       linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
In-Reply-To: <41EA0307.6020807@opersys.com>
Message-ID: <Pine.LNX.4.61.0501161648310.30794@scrub.home>
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de>
 <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de>
 <41E7A7A6.3060502@opersys.com> <Pine.LNX.4.61.0501141626310.6118@scrub.home>
 <41E8358A.4030908@opersys.com> <Pine.LNX.4.61.0501150101010.30794@scrub.home>
 <41E899AC.3070705@opersys.com> <Pine.LNX.4.61.0501160245180.30794@scrub.home>
 <41EA0307.6020807@opersys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 16 Jan 2005, Karim Yaghmour wrote:

> The per-cpu buffering issue is really specific to the client. It just
> so happens that LTT creates one channel for each CPU. Not everyone
> who needs to ship lots of data to user-space needs/wants one channel
> per cpu. You could, for example, use a relayfs channel as a big
> chunk of memory visible to both a user-space app and its kernel buddy
> in order to exchange data without ever using either needing more
> than one such channel for your entire subsystem.

It seems we first need to specify, what relayfs actually is supposed to 
be. Is it a relaying mechanism for large amount of data from kernel to 
user space or is it a general communication channel between kernel and 
user space? You have to choose one, if you mix contradicting requirements, 
you'll never get a simple abstraction layer and relayfs will always be a 
pain to work with.

> > Why not just move the ltt buffer management into relayfs and provide a 
> > small library, which extracts the event stream again? Otherwise you have 
> > to duplicate this work for every serious relayfs user anyway.
> 
> Ok, I've been meditating over what you say above for some time in order
> to understand how best to follow what you are suggesting. So here's
> what I've been able to come up with. Let me know if you have other
> suggestions:
> 
> Drop the buffer-start/end callbacks altogether. Instead, allow user
> to specify in the channel properties whether they want to have
> sub-buffer delimiters. If so, relayfs would automatically prepend
> and append the structures currently written by ltt:
> /* Start of trace buffer information */
> typedef struct _ltt_buffer_start {
> 	struct timeval time;	/* Time stamp of this buffer */
> 	u32 tsc;   		/* TSC of this buffer, if applicable */
> 	u32 id;			/* Unique buffer ID */
> } LTT_PACKED_STRUCT ltt_buffer_start;
> 
> /* End of trace buffer information */
> typedef struct _ltt_buffer_end {
> 	struct timeval time;	/* Time stamp of this buffer */
> 	u32 tsc;   		/* TSC of this buffer, if applicable */
> } LTT_PACKED_STRUCT ltt_buffer_end;

You can make it even simpler by dropping this completely. Every buffer is 
simply a list of events and you can let ltt write periodically a timer 
event. In userspace you can randomly seek at buffer boundaries and search 
for the timer events. It will require a bit more work for userspace, but 
even large amount of tracing data stays managable.

> As for lockless vs. locking there is a need for both. Not having
> to get locks has obvious advantages, but if you require strict
> timing you will want to use the locking scheme because its logging
> time is linear (see Thomas' complaints about lockless elsewhere
> in this thread, and Ingo's complaints about relayfs somewhere back
> in October.)

But why has it to be done in relayfs? Simply leave it to the user to write 
an extra id field:

	event_id = atomic_inc_return(&event_cnt);

Userspace can then easily restore the original order of events.

bye, Roman
