Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVARPcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVARPcW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 10:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVARPcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 10:32:22 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:3544 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261322AbVARPby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 10:31:54 -0500
Date: Tue, 18 Jan 2005 16:31:41 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Karim Yaghmour <karim@opersys.com>
cc: Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
In-Reply-To: <41EC8AA2.1030000@opersys.com>
Message-ID: <Pine.LNX.4.61.0501181359250.30794@scrub.home>
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de>
 <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de>
 <41E7A7A6.3060502@opersys.com> <Pine.LNX.4.61.0501141626310.6118@scrub.home>
 <41E8358A.4030908@opersys.com> <Pine.LNX.4.61.0501150101010.30794@scrub.home>
 <41E899AC.3070705@opersys.com> <Pine.LNX.4.61.0501160245180.30794@scrub.home>
 <41EA0307.6020807@opersys.com> <Pine.LNX.4.61.0501161648310.30794@scrub.home>
 <41EADA11.70403@opersys.com> <Pine.LNX.4.61.0501171403490.30794@scrub.home>
 <41EC2DCA.50904@opersys.com> <Pine.LNX.4.61.0501172323310.30794@scrub.home>
 <41EC8AA2.1030000@opersys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 17 Jan 2005, Karim Yaghmour wrote:

> With that said, I hope we've agreed that we'll have a callback for
> letting relayfs clients know that they need to write the begining of
> the buffer event. There won't be any associated reserve. Conversly,
> I hope it is not too much to ask to have an end-of-buffer callback.

There of course has to be some kind of end marker, but that's less 
critical as it's not the active buffer anymore.

> Roman, of all people I've been more than happy to change my stuff following
> your recommendations. Do I have to list how far down relayfs has been
> stripped down?

Sorry, you missunderstood me. At the moment I'm only secondarily 
interested in the API details, primarily I want to work out the details of 
what exactly relayfs/ltt are supposed to do. One main question here I 
can't answer yet, why you insist on multiple relayfs modes.
This is what I basically have in mind for the relay_write function:

	cpu = get_cpu();
	buffer = relay_get_buffer(chan, cpu);
	while(1) {
		offset = local_add_return(buffer->offset, length);
		if (likely(offset + length <= buffer->size))
			break;
		buffer = relay_switch_buffer(chan, buffer, offset);
	}
	memcpy(buffer->data + offset, data, length);
	put_cpu();

ltt_log_event should only be a few lines more (for writing header and 
event data).
What I'd like to know now are the reasons why you need more than this.
It's not the amount of data and any timing requirements have to be done by 
the caller. During processing you either take the events in the order they 
were recorded (often that's good enough) or you sort them which is not 
that difficult.

> You ask what compromises can be found from both sides to obtain a
> single implementation. I have looked at this, and given how
> stripped down it has become, anything less from relayfs will make
> it useless for LTT. IOW, I would have to reimplement a buffering
> scheme within LTT outside of relayfs.

I know you don't want to touch the topic of kernel debugging, but its 
requirements greatly overlap with what you want to do with ltt, e.g. one 
needs very often information about scheduling events as many kernel 
processes rely more and more on kernel threads. The only real requirement 
for kernel debugging is low runtime overhead, which you certainly like to 
have as well. So what exactly are these requirements and why can't there 
be no reasonable alternative?

bye, Roman
