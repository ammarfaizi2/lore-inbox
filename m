Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbTJJOie (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 10:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbTJJOie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 10:38:34 -0400
Received: from opersys.com ([64.40.108.71]:7688 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262836AbTJJOi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 10:38:29 -0400
Message-ID: <3F86C519.4030209@opersys.com>
Date: Fri, 10 Oct 2003 10:41:29 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: jmorris@redhat.com, zanussi@us.ibm.com, linux-kernel@vger.kernel.org,
       bob@watson.ibm.com
Subject: Re: [PATCH][RFC] relayfs (1/4) (Documentation)
References: <Pine.LNX.4.44.0310091311440.14415-100000@thoron.boston.redhat.com>	<3F859DF1.8000602@opersys.com> <20031010005703.0daf3e19.davem@redhat.com>
In-Reply-To: <20031010005703.0daf3e19.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David S. Miller wrote:
> Of course it can.  Look, netlink is used on routers to transfer
> hundreds of thousands of routing table entries in one fell swoop
> between a user process and the kernel every time the next hop Cisco
> has a BGP routing flap.
> 
> If you must have "enterprise wide client server" performance, we can
> add mmap() support to netlink sockets just like AF_PACKET sockets support
> such a thing.  But I _really_ doubt you need this and unlike netlink sockets
> relayfs has no queueing model, whereas not only does netlink have one it's
> been tested in real life.
> 
> You guys are really out of your mind if you don't just take the netlink
> printk thing I did months ago and just run with it.  When someone first
> told showed me this relayfs thing, I nearly passed out in disbelief that
> people are still even considering non-netlink solutions.

Well, it wouldn't be the first time I've been called crazy on this mailing
list, and it certainly wouldn't be the first time my craziness has had some
some ill effects on others ... ;)

But let's get to real stuff here.

The question isn't whether netlink can transfer hundreds of thousands of
data units in one fell swoop. The question is: is it more efficient than
relayfs at this? I contend that it isn't. Transferring hundreds of
thousands of data units is one thing, being able to sustain tens of
thousands of data units per second, doing it continuously for hours while
still having all this data committed to disk is a completely different story.

In addition, consider that a user may want to disable networking in his
kernel entirely and still want to be able to transfer huge amounts of
data from kernel space to user space. So is that user going to just have
to live with the old printk just because he doesn't want to have
networking? The fact is relayfs is a best-of-breed buffering mechanism
which can replace many ad-hoc buffering mechanisms already in the kernel.
And contrary to Netlink, it doesn't need to drag with it a huge subsystem
for it to work. It's simple, small, elegant, and uses an API which is
consistent what you'd expect from a buffering mechanism. This includes
callbacks for key conditions that you'd expect to have from a buffering
mechanism: buffer start (for N buffering), buffer end, delivery, resize
needed.

Heck, I can even log one entry in a relayfs buffer for every kmalloc,
alloc_skb, netlink_sndmsg, etc. without my transmission being recursive.
Fact is, relayfs' dependencies on other kernel facilities are lower than
netlink.

Finally, if you think that "mmap" is really unnecessary for what we're
trying to do, then I suggest you try porting something as demanding as
LTT on netlink and show us some numbers. Not to mention that by porting
LTT onto an netlink you'd then be unable to trace some portions of the
networking code ...

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 514-812-4145

