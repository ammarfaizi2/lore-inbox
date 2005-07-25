Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVGYXqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVGYXqZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 19:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVGYXqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 19:46:24 -0400
Received: from p54A093C3.dip0.t-ipconnect.de ([84.160.147.195]:63990 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261249AbVGYXqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 19:46:23 -0400
Message-ID: <42E579BC.8000701@trash.net>
Date: Tue, 26 Jul 2005 01:46:04 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: James Morris <jmorris@redhat.com>, "David S. Miller" <davem@davemloft.net>,
       Harald Welte <laforge@netfilter.org>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org
Subject: Re: Netlink connector
References: <20050723125427.GA11177@rama> <20050723091455.GA12015@2ka.mipt.ru> <20050724.191756.105797967.davem@davemloft.net> <Lynx.SEL.4.62.0507250154000.21934@thoron.boston.redhat.com> <20050725070603.GA28023@2ka.mipt.ru> <42E4F800.1010908@trash.net> <20050725192853.GA30567@2ka.mipt.ru>
In-Reply-To: <20050725192853.GA30567@2ka.mipt.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> On Mon, Jul 25, 2005 at 04:32:32PM +0200, Patrick McHardy (kaber@trash.net) wrote:
> 
>>If I understand correctly it tries to workaround some netlink
>>limitations (limited number of netlink families and multicast groups)
>>by sending everything to userspace and demultiplexing it there.
>>Same in the other direction, an additional layer on top of netlink
>>does basically the same thing netlink already does. This looks like
>>a step in the wrong direction to me, netlink should instead be fixed
>>to support what is needed.
> 
> Not only it.
> The main _first_ idea was to simplify userspace mesasge handling as much
> as possible.
> In first releases I called it ioctl-ng - any module that want ot
> communicate with userspace in the way ioctl does, 

Usually netlink is easily extendable by using nested TLVs. By hiding
this you basically remove this extensibility.

> requires skb allocation/freeing/handling.
> Does RTC driver writer need to know what is the difference between
> shared and cloned skb? Should kernel user of such message bus
> have to know about skb at all?

Netlink users don't have to care about shared or cloned skbs. I don't
think its a big issue to use alloc_skb and then the usual netlink
macros. Thomas added a number of macros that simplfiy use a lot.

But my main objection is that it sends everything to userspace even
if noone is listening. This can't be used for things that generate
lots of events, and also will get problematic is the number of users
increases.

> With char device I only need to register my callback - with kernel
> connector it is the same, but allows to use the whole power of netlink,
> especially without nice ioctl features like different pointer size 
> in userspace and kernelspace.

You still have to take care of mixed 64/32 bit environments, u64 fields
for example are differently alligned.

> And number of free netlink sockets is _very_ small, especially
> if allocate new one for simple notifications, which can be easily done
> using connector.

Then fix it so we can use more families and groups. I started some work
on this, but I'm not sure if I have time to complete it.

> And netlink can be extended to support it - netlink is a transport
> protocol, it should not care about higher layer message handling,
> connector instead will deliver message to the end user in a very
> convenient form.

You can still built this stuff on top, but the workarounds for netlink
limitations need to be fixed in netlink.

> P.S. I've removed netdev@redhat.com - please do not add subscribers-only
> private mail lists.

Wasn't me :)
