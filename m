Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262609AbVAPVL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbVAPVL0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 16:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbVAPVL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 16:11:26 -0500
Received: from opersys.com ([64.40.108.71]:55314 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262609AbVAPVKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 16:10:49 -0500
Message-ID: <41EADA11.70403@opersys.com>
Date: Sun, 16 Jan 2005 16:18:09 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Andi Kleen <ak@muc.de>, Nikita Danilov <nikita@clusterfs.com>,
       linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de> <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de> <41E7A7A6.3060502@opersys.com> <Pine.LNX.4.61.0501141626310.6118@scrub.home> <41E8358A.4030908@opersys.com> <Pine.LNX.4.61.0501150101010.30794@scrub.home> <41E899AC.3070705@opersys.com> <Pine.LNX.4.61.0501160245180.30794@scrub.home> <41EA0307.6020807@opersys.com> <Pine.LNX.4.61.0501161648310.30794@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0501161648310.30794@scrub.home>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Roman,

Roman Zippel wrote:
> It seems we first need to specify, what relayfs actually is supposed to 
> be. Is it a relaying mechanism for large amount of data from kernel to 
> user space or is it a general communication channel between kernel and 
> user space? You have to choose one, if you mix contradicting requirements, 
> you'll never get a simple abstraction layer and relayfs will always be a 
> pain to work with.

I think we want to concentrate on the former, though I suspect the latter
will happen eventually. But let's keep our focus on providing a mechanism
for relaying large amounts of data from the kernel to user-space.

> You can make it even simpler by dropping this completely. Every buffer is 
> simply a list of events and you can let ltt write periodically a timer 
> event. In userspace you can randomly seek at buffer boundaries and search 
> for the timer events. It will require a bit more work for userspace, but 
> even large amount of tracing data stays managable.

We already do write a heartbeat event periodically to have readable
traces in the case where the lower 32 bits of the TSC wrap-around.

As I mentioned elsewhere, please don't think of this in terms of
kbs or mbs of data. What we're talking about here is gbs if not
100gbs of data. Having to start reading each sub-buffer until you
hit a heartbeat really is a killer for such large traces. If there
was a significant impact on relayfs for having this I would have
understood the argument, but relayfs needs to do buffer-management
anyway, so I don't see that much complexity being added by allowing
the channel user to ask relayfs for delimiters.

> Userspace can then easily restore the original order of events.

As above, restoring the original order of events is fine if you are
looking at mbs or kbs of data. It's just totally unrealistic for
the amounts of data we want to handle.

But like I said earlier, the added relayfs mode (kdebug) would allow
for exactly what you are suggesting:
	event_id = atomic_inc_return(&event_cnt);

So here's the new API based on input from Christoph and Tom:

rchan* relay_open(channel_path, bufsize, nbufs);
int    relay_close(*rchan);
int    relay_reset(*rchan)
int    relay_write(*rchan, *data_ptr, count, **wrote-pos);

int    relay_info(*rchan, *channel_info)
void   relay_set_property(*rchan, property, value);
void   relay_get_property(*rchan, property, *value);

For direct writing (currently already used by ltt, for example):

char*  relay_reserve(*rchan, len, *ts, *td, *err, *interrupting)
void   relay_commit(*rchan, *from, len, reserve_code, interrupting);
void   relay_buffers_consumed(*rchan, u32)

These are the related macros:

#define relay_write_direct(DEST, SRC, SIZE) \
#define relay_lock_channel(RCHAN, FLAGS) \
#define relay_unlock_channel(RCHAN, FLAGS) \

What we are dropping for later review: read/write semantics from
user-space. It has to be understood that we believe that this is
a major drawback. For one thing, you won't be able to do something
like:
$ cat /relayfs/xchg/my-file > ~/test-data

Instead, you will have to write a custom app that does open(),
mmap(), write(). We could still provide a small app/library that
did this automagically, but you've got to admit that nothing
beats the real thing.

Also note that there are people who currently use this already,
so there will be some unhappy campers.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
