Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVAXAl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVAXAl6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 19:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVAXAl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 19:41:57 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:62602 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261393AbVAXAif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 19:38:35 -0500
Date: Mon, 24 Jan 2005 01:38:26 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Karim Yaghmour <karim@opersys.com>
cc: Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
In-Reply-To: <41F355AD.50901@opersys.com>
Message-ID: <Pine.LNX.4.61.0501231703010.30794@scrub.home>
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de>
 <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de>
 <41E7A7A6.3060502@opersys.com> <Pine.LNX.4.61.0501141626310.6118@scrub.home>
 <41E8358A.4030908@opersys.com> <Pine.LNX.4.61.0501150101010.30794@scrub.home>
 <41E899AC.3070705@opersys.com> <Pine.LNX.4.61.0501160245180.30794@scrub.home>
 <41EA0307.6020807@opersys.com> <Pine.LNX.4.61.0501161648310.30794@scrub.home>
 <41EADA11.70403@opersys.com> <Pine.LNX.4.61.0501171403490.30794@scrub.home>
 <41EC2DCA.50904@opersys.com> <Pine.LNX.4.61.0501172323310.30794@scrub.home>
 <41EC8AA2.1030000@opersys.com> <Pine.LNX.4.61.0501181359250.30794@scrub.home>
 <41F0A0A2.1010109@opersys.com> <Pine.LNX.4.61.0501211754110.30794@scrub.home>
 <41F355AD.50901@opersys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 23 Jan 2005, Karim Yaghmour wrote:

> But how does relayfs organize the namespace then? What if I have
> multiple channels per CPU, each for a different type of data, will
> all channels for the same CPU be under the same directory or will
> each type of data have its own directory with one entry per CPU?

I'd say the latter, you already do this for ltt.

> I don't have an answer to that, and I don't know that we should. Why
> not just leave it to the client to organize his data as he wishes.
> If we must assume that everyone will have at least one channel per
> CPU, then why not provide helper functions built on top of very
> basic functions instead of fixing the namespace in stone?

How should simple do you want to have these helper functions, isn't 
something like relay_create(path, num_chan) simple enough?
I don't think a directory structure is that bad, as that allows to add 
more control files to the relay stream and still leave the option to write 
out all buffers into one file.

> > I have to modify it a little (only the if (!buffer) part is new):
> > 
> > 	cpu = get_cpu();
> > 	buffer = relay_get_buffer(chan, cpu);
> > 	while(1) {
> > 		offset = local_add_return(buffer->offset, length);
> > 		if (likely(offset + length <= buffer->size))
> > 			break;
> > 		buffer = relay_switch_buffer(chan, buffer, offset);
> > 		if (!buffer) {
> > 			put_cpu();
> > 			return;
> > 		}
> > 	}
> > 	memcpy(buffer->data + offset, data, length);
> > 	put_cpu();
> > 
> > This has a very short fast path and I need very good reasons to change/add 
> > anything here. OTOH the slow path with relay_switch_buffer() is less 
> > critical and still leaves a lot of flexibility.
> 
> This is not good for any client that doesn't know beforehand the exact
> size of their data units, as in the case of LTT. If LTT has to use this
> code that means we are going to loose performance because we will need to
> fill an intermediate data structure which will only be used for relay_write().
> Instead of zero-copy, we would have an extra unnecessary copy. There has
> got to be a way for clients to directly reserve and write as they wish.

Ok, let's change it a little so it's more familiar. :)

void *relay_reserve(chan, length, cpu)
{
	buffer = relay_get_buffer(chan, cpu);
	while(1) {
		offset = local_add_return(buffer->offset, length);
		if (likely(offset + length <= buffer->size))
			return buffer->data + offset;
		buffer = relay_switch_buffer(chan, buffer, offset);
		if (!buffer)
			return NULL;
	}
}

All you have to do is to put between get_cpu()/put_cpu().
The same is also possible as macro, which allows you to directly jump out 
of it to the failure code and avoid one test.

> > Look closer, it's already interrupt safe, the synchronization for the 
> > buffer switch is left to relay_switch_buffer().
> 
> Sorry, I'm still missing something. What exactly does local_add_return()
> do? I assume this code has got to be interrupt safe? Something like:
> #define local_add_return(OFFSET, LEN) \
> do {\
> ...
> 	local_irq_save(); \
> 	OFFSET += LEN;
> 	local_irq_restore(); \
> ...
> } while(0);
> 
> I'm assuming local_irq_XXX because we were told by quite a few people
> in the related thread to avoid atomic ops because they are more expensive
> on most CPUs than cli/sti.

That would be about the generic implementation, but it allows archs to 
provide more efficient implementations in <asm/local.h>, e.g. i386 can use 
xadd.

> Also how does relay_get_buffer() operate?

#define relay_get_buffer(chan, cpu)	chan->buffer[cpu]

> What if I'm writing an event
> from within a system call and I'm about to switch buffers and get
> an interrupt at the if(likely(...))? Isn't relay_get_buffer() going to
> return the same pointer as the one obtained for the syscall, and aren't
> both cases now going to effect relay_switch_buffer(), one of which will
> be superfluous?

The synchronization has to be done in relay_switch_buffer(), but catching 
it there is still cheaper as in the fast path.

> > This adds a conditional and is not really needed. Above shows how to make 
> > it interrupt safe and if the clients wants to reuse the same buffer, leave 
> > the locking to the client.
> 
> Fine, but how is the client going to be able to reuse the same buffer if
> relayfs always assumes per-CPU buffer as you said above? This would be
> solved if at its core relayfs' functions worked on single channels and
> additional code provided helpers for making the SMP case very simple.

What do you mean? Why not make SMP case simple (less to get wrong)? The 
client can still serialize everything with a simple spinlock.

> > That's quite a lot of code with at least 14 conditions (or 13 conditions 
> > too much) and this is just relayfs.
> 
> I believe Tom has refactored the code with your comments in mind, and has
> something ready for review. I just want to clear up the above before we
> make this final. Among other things, he just dropped all modes, and there's
> only a basic relay_write() that closely resembles what you have above.

Ok, great.
BTW I don't really expect the first version to be fully optimized (unless 
you want to :) ), but once the basics are right, that can still be added 
later.

bye, Roman
