Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVAWHdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVAWHdT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 02:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVAWHdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 02:33:18 -0500
Received: from opersys.com ([64.40.108.71]:39690 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261239AbVAWHdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 02:33:07 -0500
Message-ID: <41F355AD.50901@opersys.com>
Date: Sun, 23 Jan 2005 02:43:41 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de> <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de> <41E7A7A6.3060502@opersys.com> <Pine.LNX.4.61.0501141626310.6118@scrub.home> <41E8358A.4030908@opersys.com> <Pine.LNX.4.61.0501150101010.30794@scrub.home> <41E899AC.3070705@opersys.com> <Pine.LNX.4.61.0501160245180.30794@scrub.home> <41EA0307.6020807@opersys.com> <Pine.LNX.4.61.0501161648310.30794@scrub.home> <41EADA11.70403@opersys.com> <Pine.LNX.4.61.0501171403490.30794@scrub.home> <41EC2DCA.50904@opersys.com> <Pine.LNX.4.61.0501172323310.30794@scrub.home> <41EC8AA2.1030000@opersys.com> <Pine.LNX.4.61.0501181359250.30794@scrub.home> <41F0A0A2.1010109@opersys.com> <Pine.LNX.4.61.0501211754110.30794@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0501211754110.30794@scrub.home>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Roman,

Roman Zippel wrote:
> Well, let's concentrate for a moment on the last thing and check later 
> if and how they fit into relayfs. Since ltt will be first main user, let's 
> optimize it for this.
> Also since relayfs is intended for large, fast data transfers, per cpu 
> buffers are pretty much always required, so it would make sense to leave 
> this to relayfs (less to get wrong for the client).

But how does relayfs organize the namespace then? What if I have
multiple channels per CPU, each for a different type of data, will
all channels for the same CPU be under the same directory or will
each type of data have its own directory with one entry per CPU?
I don't have an answer to that, and I don't know that we should. Why
not just leave it to the client to organize his data as he wishes.
If we must assume that everyone will have at least one channel per
CPU, then why not provide helper functions built on top of very
basic functions instead of fixing the namespace in stone?

> I have to modify it a little (only the if (!buffer) part is new):
> 
> 	cpu = get_cpu();
> 	buffer = relay_get_buffer(chan, cpu);
> 	while(1) {
> 		offset = local_add_return(buffer->offset, length);
> 		if (likely(offset + length <= buffer->size))
> 			break;
> 		buffer = relay_switch_buffer(chan, buffer, offset);
> 		if (!buffer) {
> 			put_cpu();
> 			return;
> 		}
> 	}
> 	memcpy(buffer->data + offset, data, length);
> 	put_cpu();
> 
> This has a very short fast path and I need very good reasons to change/add 
> anything here. OTOH the slow path with relay_switch_buffer() is less 
> critical and still leaves a lot of flexibility.

This is not good for any client that doesn't know beforehand the exact
size of their data units, as in the case of LTT. If LTT has to use this
code that means we are going to loose performance because we will need to
fill an intermediate data structure which will only be used for relay_write().
Instead of zero-copy, we would have an extra unnecessary copy. There has
got to be a way for clients to directly reserve and write as they wish.
Even Zach Brown recognized this in his tracepipe proposal, here's from
his patch:
+ * 	- let caller reserve space and get a pointer into buf

>>1) get_cpu() and put_cpu() won't do. You need to outright disable
>>interrupts because you may be called from an interrupt handler.
> 
> 
> Look closer, it's already interrupt safe, the synchronization for the 
> buffer switch is left to relay_switch_buffer().

Sorry, I'm still missing something. What exactly does local_add_return()
do? I assume this code has got to be interrupt safe? Something like:
#define local_add_return(OFFSET, LEN) \
do {\
...
	local_irq_save(); \
	OFFSET += LEN;
	local_irq_restore(); \
...
} while(0);

I'm assuming local_irq_XXX because we were told by quite a few people
in the related thread to avoid atomic ops because they are more expensive
on most CPUs than cli/sti.

Also how does relay_get_buffer() operate? What if I'm writing an event
from within a system call and I'm about to switch buffers and get
an interrupt at the if(likely(...))? Isn't relay_get_buffer() going to
return the same pointer as the one obtained for the syscall, and aren't
both cases now going to effect relay_switch_buffer(), one of which will
be superfluous?

> This adds a conditional and is not really needed. Above shows how to make 
> it interrupt safe and if the clients wants to reuse the same buffer, leave 
> the locking to the client.

Fine, but how is the client going to be able to reuse the same buffer if
relayfs always assumes per-CPU buffer as you said above? This would be
solved if at its core relayfs' functions worked on single channels and
additional code provided helpers for making the SMP case very simple.

> That's quite a lot of code with at least 14 conditions (or 13 conditions 
> too much) and this is just relayfs.

I believe Tom has refactored the code with your comments in mind, and has
something ready for review. I just want to clear up the above before we
make this final. Among other things, he just dropped all modes, and there's
only a basic relay_write() that closely resembles what you have above.

> That's not always true, where perfomance matters we provide different 
> functions (e.g. spinlocks), so having an alternative version of 
> relay_write is a possibility (although I'd like to see the user first).

Sure, see above in the case of LTT.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
