Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264064AbRFPXaU>; Sat, 16 Jun 2001 19:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264672AbRFPXaJ>; Sat, 16 Jun 2001 19:30:09 -0400
Received: from smtp-rt-12.wanadoo.fr ([193.252.19.60]:62610 "EHLO
	tamaris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264064AbRFPX35>; Sat, 16 Jun 2001 19:29:57 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Tom Gall <tom_gall@vnet.ibm.com>
Subject: Re: Going beyond 256 PCI buses
Date: Sun, 17 Jun 2001 01:29:39 +0200
Message-Id: <20010616232939.17227@smtp.wanadoo.fr>
In-Reply-To: <3B2BD058.22E4A9EA@mandrakesoft.com>
In-Reply-To: <3B2BD058.22E4A9EA@mandrakesoft.com>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>"David S. Miller" wrote:
>> 
>> Jeff Garzik writes:
>>  > ok with me.  would bus #0 be the system or root bus?  that would be my
>>  > preference, in a tiered system like this.
>> 
>> Bus 0 is controller 0, of whatever bus type that happens to be.
>> If we want to do something special we could create something
>> like /proc/bus/root or whatever, but I feel this unnecessary.
>
>Basically I would prefer some sort of global tree so we can figure out a
>sane ordering for PM.  Power down the pcmcia cards before the add-on
>card containing a PCI-pcmcia bridge, that sort of thing.  Cross-bus-type
>ordering.

Welcome to the PM tree....

What I would have liked, but it looks like our current design is not
going that way, would have been a tree structure for the PM notifiers
from the beginning. And instead of having various kind of callbacks
(like PCI suspend/resume/whatever, others for USB, FW, etc..), we
can just have a PM notifier node for each device and have notifiers
handle calling their childs.

That also allow bus "controllers" (in general) to broadcast specific
messages to their childs for things that don't fit in the D0..D3
scheme.

For PCI, instead of having the PCI layer itself having one node and
call the tree, I'd rather see it having one node per pci_dev, and 
layout them according to the PCI tree by default. I can see (and
already know of) cases where the PM tree is _not_ the PCI tree
(because power/reset lines are wired to various ASICs on a motherboard),
and having this PM tree structure separate allow the arch to 
influence it if necessary.

It's simple (a notifier node is a lightweight structure, only one
callback function is implemented, only a few messages are usually
needed to be handled in a given node).

Ben.


