Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262888AbVAQVUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbVAQVUl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 16:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbVAQVUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 16:20:41 -0500
Received: from opersys.com ([64.40.108.71]:2313 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262888AbVAQVUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:20:23 -0500
Message-ID: <41EC2DCA.50904@opersys.com>
Date: Mon, 17 Jan 2005 16:27:38 -0500
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
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de> <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de> <41E7A7A6.3060502@opersys.com> <Pine.LNX.4.61.0501141626310.6118@scrub.home> <41E8358A.4030908@opersys.com> <Pine.LNX.4.61.0501150101010.30794@scrub.home> <41E899AC.3070705@opersys.com> <Pine.LNX.4.61.0501160245180.30794@scrub.home> <41EA0307.6020807@opersys.com> <Pine.LNX.4.61.0501161648310.30794@scrub.home> <41EADA11.70403@opersys.com> <Pine.LNX.4.61.0501171403490.30794@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0501171403490.30794@scrub.home>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Roman,

Roman Zippel wrote:
> Periodically can also mean a buffer start call back from relayfs 
> (although that would mean the first entry is not guaranteed) or a 
> (per cpu) eventcnt from the subsystem. The amount of needed search would 
> be limited. The main point is from the relayfs POV the buffer structure 
> has always the same (simple) structure.

But two e-mails ago, you told us to drop the start_reserve and end_reserve
and move the details of the buffer management into relayfs and out of
ltt? Either we have a callback, like you suggest, and then we need to
reserve some space to make sure that the callback is guaranteed to have
the first entry, or we drop the callback and provide an option to the
user for relayfs to write this first entry for him. Providing a callback
without reservation is no different than relying purely on the heartbeat,
which, like I said before and for the reasons illustrated below, is
unrealistic.

> You have to be more specific, what's so special about this amount of data. 
> You likely want to (incrementally) build an index file, so you don't have 
> to repeat the searches, but even with your current format you would 
> benefit from such an index file.
[snip]
>>As above, restoring the original order of events is fine if you are
>>looking at mbs or kbs of data. It's just totally unrealistic for
>>the amounts of data we want to handle.
> 
> 
> Why is it "totally unrealistic"?

Ok, let's expand a little here on the amount of data. Say you're getting
2MB/s of data (which is not unrealistic on a loaded system.) That means
that if I'm tracing for 2 days, I've got 345GB of data (~7.5GB/hour).
In practice, users aren't necessarily interested in plowing through the
entire 345GB, they just want to view a given portion of it. Now, if I
follow what you are suggesting, I have to go through the entire 345GB to:
a) create indexes, b) reorder events, and likely c) have to rewrite
another 345GB of data. And I haven't yet discussed the kind of problems
you would encounter in trying to reorder such a beast that contains,
by definition, variable-sized events. For one thing, if event N+1 doesn't
follow N, then you would be forced to browse forward until you actually
found it before you could write a properly ordered trace. And it just
takes a few processes that are interrupted and forced to sleep here and
there to make this unusable. That's without the RAM or fs space required
to store those index tables ... At 3 to 12 bytes per events, that's a lot
of space for indexes ...

If I keep things as they are with ordered events and delimiters on buffer
boundaries, I can skip to any place within this 345GB and start processing
from there.

And that's for two days. If you're a sysadmin encountering a transient
problem on a server, you may actually want more than that.

>>But like I said earlier, the added relayfs mode (kdebug) would allow
>>for exactly what you are suggesting:
>>	event_id = atomic_inc_return(&event_cnt);
> 
> 
> Actually that would be already too much for low level kernel debugging.
> Why do you want to put this into relayfs?

I don't. I was just saying that with the adhoc mode, a relayfs client
could use the code snippet you were suggesting.

> What are the _specific_ reasons you need these various modes, why can't 
> you build any special requirements on top of a very light weight relay 
> mechanism?

Because of the opposite requirements.

Here are the two modes I'm suggesting in relayfs and how they operate:

Managed:
- Presumes active user-space daemon interested in catching _all_ events.
- Allows N buffers in buffer ring
- Provides limit-checking (callback on end of sub-buffer)
- Provides buffer delimiters (writes timestamp at beg and end)
- Suited for all types of event sizes (both fixed and variable) at
  very high frequency.
- Daemon is woken up when buffer is ready for writing, executes a
  write() on an mmaped area and notifies relevant kernel subsystem,
  which in turn notifies relayfs that buffer can now be reused.
- Relies on proper abstraction of cli/sti.

Ad-Hoc:
- Presumes transient userspace tool interested in event snapshots.
- Single circular buffer.
- No limits checking (or very basic: as in stop if overwrite).
- No buffer delimiters.
- Best suited for fixed-size events at extreme high frequency.
- User-space tool simply does a write() on an mmaped area and
  exits or goes back to sleep.
- Relies on proper abstraction of cli/sti.

Basically, the ad-hoc modes abides by the principles of KISS, whereas
the managed is a more elaborate for clients like LTT.

Rhetorical: Couldn't the ad-hoc mode case be a special case of the
managed mode? In theory yes, in practice no. The various conditionals
and code paths for switching buffers, invoking callbacks, writing
delimiters and the likes, which make this mode useful to client like
LTT, will always be a problem for those seeking the shortest path to
buffer comital. In the case of Ingo, for example, I'm sure he'd
probably go in the code and "#if 0" it to make sure it doesn't slow
him down.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
