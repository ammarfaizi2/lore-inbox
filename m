Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbVAUGQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbVAUGQf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 01:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbVAUGQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 01:16:35 -0500
Received: from opersys.com ([64.40.108.71]:19728 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262274AbVAUGQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 01:16:06 -0500
Message-ID: <41F0A0A2.1010109@opersys.com>
Date: Fri, 21 Jan 2005 01:26:42 -0500
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
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de> <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de> <41E7A7A6.3060502@opersys.com> <Pine.LNX.4.61.0501141626310.6118@scrub.home> <41E8358A.4030908@opersys.com> <Pine.LNX.4.61.0501150101010.30794@scrub.home> <41E899AC.3070705@opersys.com> <Pine.LNX.4.61.0501160245180.30794@scrub.home> <41EA0307.6020807@opersys.com> <Pine.LNX.4.61.0501161648310.30794@scrub.home> <41EADA11.70403@opersys.com> <Pine.LNX.4.61.0501171403490.30794@scrub.home> <41EC2DCA.50904@opersys.com> <Pine.LNX.4.61.0501172323310.30794@scrub.home> <41EC8AA2.1030000@opersys.com> <Pine.LNX.4.61.0501181359250.30794@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0501181359250.30794@scrub.home>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, I finally come around to answering this ...

Roman Zippel wrote:
> Sorry, you missunderstood me. At the moment I'm only secondarily 
> interested in the API details, primarily I want to work out the details of 
> what exactly relayfs/ltt are supposed to do. One main question here I 
> can't answer yet, why you insist on multiple relayfs modes.

I should have avoided earlier confusing the use of a certain type of
relayfs channel for a given purpose (i.e. LTT should not necessarily
depend on the managed mode.) I believe that there is a need for
more than one mode in relayfs independently of LTT. There are users
who want to be able to manage the data in a buffer (by manage I mean:
receive notification of important buffer events, be able to insert
important data at boundaries, etc.), and there are users who just
want to dump as much information as possible in as fast a way as
possible without having to deal with non-essential codepaths.

> This is what I basically have in mind for the relay_write function:
> 
> 	cpu = get_cpu();
> 	buffer = relay_get_buffer(chan, cpu);
> 	while(1) {
> 		offset = local_add_return(buffer->offset, length);
> 		if (likely(offset + length <= buffer->size))
> 			break;
> 		buffer = relay_switch_buffer(chan, buffer, offset);
> 	}
> 	memcpy(buffer->data + offset, data, length);
> 	put_cpu();

looking at this code:

1) get_cpu() and put_cpu() won't do. You need to outright disable
interrupts because you may be called from an interrupt handler.

2) You assume that relayfs creates one buffer per cpu for each
channel. We think this is wrong. Relayfs should not need to care
about the number of CPUs, it's the clients' responsibility to
create as many channels as they see fit, whether it be one channel
per CPU or 10 channels per CPU or 1 channel per interrupt, etc.

3) I'm unclear about the need for local_add_return(), why not
just:
	if (likely(buffer->offset + length <= buffer->size)
In any case, here's what we do in relay_write():
	write_pos = relay_reserve(rchan, count, &reserve_code, &interrupting);
If there's any buffer switching required, that will be done in
relay_reserve. This has the added advantage that clients that
want to write directly to the buffer without using relay_write()
can do so by calling relay_reserve() and not care about required
buffer switching.

4) After securing the area, you simply go ahead and do a memcpy()
and leave. We think that this is insufficient. Here's what we
do:
	if (likely(write_pos != NULL)) {
		relay_write_direct(write_pos, data_ptr, count);
		relay_commit(rchan, write_pos, count, reserve_code, interrupting);
		*wrote_pos = write_pos;
the relay_write_direct() is basically an memcpy(). We also do
a relay_commit(). This actually effects the delivery of the
event. If, for example, there had been a buffer switch at the
previous relay_reserve(), then this call to relay_commit() will
generate a call to the client's deliver() callback function.
In the case of LTT, for example, this is how it knows that it's
got to notify the user-space daemon that there are buffers to
consume (i.e. write to disk.)

> ltt_log_event should only be a few lines more (for writing header and 
> event data).

Actually no, you don't want ltt_log_event using relay_write(),
for one thing because is can generate variable size events.
Instead, ltt_log_event does (basically):
	data_size = sizeof(event_id) + sizeof(time_delta) + sizeof(data_size);

	relay_lock_channel();
	relay_reserve();

	relay_write_direct(&event_id, sizeof(event_id));
	relay_write_direct(&time_delta, sizeof(event_id));
	if (var_data) {
		relay_write_direct(var_data, var_data_len);
		data_size += var_data_len;
	}
	relay_write_direct(&data_size, sizeof(data_size));

	relay_commit();
	relay_unlock_channel();

> What I'd like to know now are the reasons why you need more than this.

I hope the above explanation clarifies things.

> It's not the amount of data and any timing requirements have to be done by 
> the caller. During processing you either take the events in the order they 
> were recorded (often that's good enough) or you sort them which is not 
> that difficult.

Ordering is a non-issue to be honest. Unless you've got some hardware
scope in there, it's almost impossible to pinpoint exactly when an
event occurred. There is no single line of code where an event occurs,
so it's all an educated guess anyway. You want things to resemble what
really happened in as much as possible though.

> I know you don't want to touch the topic of kernel debugging, but its 
> requirements greatly overlap with what you want to do with ltt, e.g. one 
> needs very often information about scheduling events as many kernel 
> processes rely more and more on kernel threads. The only real requirement 
> for kernel debugging is low runtime overhead, which you certainly like to 
> have as well. So what exactly are these requirements and why can't there 
> be no reasonable alternative?

ok, ok, ok, ok, ok, ok, OK!

You've hit it enough times on its head that I'll actually have to answer.

In terms of low runtime overhead, you are correct, the requirements overlap,
and I will agree to do my best to trim down LTT to make it useable for
kernel tracing without jeopardizing its existing purpose.

I'll start this separately in a "Ripping LTT apart" thread.

In regards to relayfs, I think that LTT should run on both modes
transparently. Unlike what I said before, no single mode should be tied
to LTT. If you want tracing with the ad-hoc mode, then fine, you should
be able to do that. There is merit in keeping both relayfs modes,
irrespective of what modes LTT uses. A review of the managed and adhoc
code should consider all clients, including LTT,  as potential users of
both. Sure, we'll want to optimize the managed mode in as much as
possible, but its functionality stands on its own and is different from
that of the ad-hoc mode. The difference between these modes is akin the
difference between GFP_KERNEL, GFP_ATOMIC, GFP_USER, etc.: same API,
different underlying functionality.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
