Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278592AbRJXPoN>; Wed, 24 Oct 2001 11:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278593AbRJXPn4>; Wed, 24 Oct 2001 11:43:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15882 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278592AbRJXPnl>; Wed, 24 Oct 2001 11:43:41 -0400
Date: Wed, 24 Oct 2001 08:41:22 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>,
        Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <E15wKn8-00013C-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0110240831200.8049-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Oct 2001, Alan Cox wrote:
>
> That will scramble large numbers of devices. Randomly erroring pending block
> writes is -not- civilised.

Note that one thing in suspending the machine that has _nothing_ to do
with the actual device tree is that higher layers have to suspend whatever
it is they are doing anyway.

Ie part of the suspend action (which is unrelated to the driver model) is
to stop all regularly scheduled activity - not necessarily flushing all
dirty buffers, but certainly waiting for all pending IO. That's a much
higher level thing that the device though - the devices themselves should
never ever see this (except in the sense that they don't see new requests
coming in).

There are other "higher-level" issues: while a device "prepare to suspend"
call might block for some device information, that does not mean that it
can allocate memory with GFP_KERNEL, for example: when we shut off device
X, the disk may have been prepared for shutdown already, and the VM layer
cannot do any IO. So the suspend (and resume) function have to use
GFP_NOIO for their allocations - _regardless_ of any other device issues.

So sure, there are tons of issues here, but none of them have, in my
opinion, anything to do with the device model itself. More just normal
implementation details.

		Linus

