Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVGZGO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVGZGO3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 02:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVGZGO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 02:14:29 -0400
Received: from postel.suug.ch ([195.134.158.23]:65162 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S261738AbVGZGO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 02:14:27 -0400
Date: Tue, 26 Jul 2005 08:14:47 +0200
From: Thomas Graf <tgraf@suug.ch>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Patrick McHardy <kaber@trash.net>, Andrew Morton <akpm@osdl.org>,
       Harald Welte <laforge@netfilter.org>, netdev@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: Netlink connector
Message-ID: <20050726061447.GZ10481@postel.suug.ch>
References: <20050723125427.GA11177@rama> <20050723091455.GA12015@2ka.mipt.ru> <20050724.191756.105797967.davem@davemloft.net> <Lynx.SEL.4.62.0507250154000.21934@thoron.boston.redhat.com> <20050725070603.GA28023@2ka.mipt.ru> <42E4F800.1010908@trash.net> <20050725192853.GA30567@2ka.mipt.ru> <42E579BC.8000701@trash.net> <20050726044547.GA32006@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050726044547.GA32006@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Evgeniy Polyakov <20050726044547.GA32006@2ka.mipt.ru> 2005-07-26 08:45
> On Tue, Jul 26, 2005 at 01:46:04AM +0200, Patrick McHardy (kaber@trash.net) wrote:
> > Usually netlink is easily extendable by using nested TLVs. By hiding
> > this you basically remove this extensibility.
> 
> Current netlink is not extensible for _many_ different users.

Patrick's key point was that by hiding some of the functionality
you remove a lot of the flexbility.

> It has only 32 sockets.

You mean MAX_LINKS? That is the current number of reserved
netlink protocols. The ethertaps are obsolete and can be
reused so we're currently using 16 out of 256 possible
protocols. If that is not enough there are ways to work
around this. However, I also see a need for a generic protocol
providing a simplified interface for small applications.
Nevertheless we should take the time and work things out on
the netlink level first, netlink has issues and we should not
work around them in a upper layer.

> > But my main objection is that it sends everything to userspace even
> > if noone is listening. This can't be used for things that generate
> > lots of events, and also will get problematic is the number of users
> > increases.
> 
> It is a problem for existing netlink - either check in bind time, 
> what could be done for connector, or in socket creation time.

No, I think you are misunderstanding something. As I said, we can
easly add a function netlink_nr_subscribers(sk, groups) so the
check can be done before starting to build the message. This is
no problem, it simply didn't make sense so far because netlink
event messages were mostly used for rare events.

> Actually it is not even a problem, since checking is being done, 
> but after allocation and message filling, such check can be moved into
> cn_netlink_send() in connector, but different netlink users, 
> who prefers to use different sockets, must perform it by itself in each
> place, where skb is allocated...

Sure, which is the right thing, it makes perfect sense to check
before starting the process of building and event and sending it.

> Connector is a solution for current situation, 
> it can be deployed with few casualties.

The problem is that netlink is likely to change in order
to cope with some recent needs, e.g. ctnetlink but also other
current issues which need to be addressed.  Therefore I suggest
to build connector on top of the updated netlink so you we have
one thing less to worry about when thinking about compatibility.

> Creating a new netlink2 socket for device, which wants to replace ioctl
> controlling or broadcast it's state is a wrong way.

Slowly, we might need netlink2 _in case_ we cannot work things
out without breaking compatibility. This has nothing to do with
the connector, there are netlink users which have new needs such
as more groups, at least some of them need the flexibility of
netlink itself so we have to work things out for them.

> Different sockets/flows does not allow easy flow control.

I'm not sure what you mean.

> We have one pipe - ethernet, and many protocols inside this pipe
> with different headers - it is the same here - netlink is such a pipe,
> and with connector it allows to have different protocols in it.

At least parts of your connector is just a redudant implementation
of what netlink is already capable of doing. Sure, some of them
have issues but there is no reason to just build a new protocol on
top of another one if the protocol beneath has issues which can be
resolved.

> > You still have to take care of mixed 64/32 bit environments, u64 fields
> > for example are differently alligned.
> 
> Connector has a size in it's header - ioctl does not.

You have exactly the same issues as netlink as soon as you transfer
structs, believe it or not.

> It does not "fix" the "problem" of skb management knowledge, which I
> described.

Yes ok, this is a different issue and as Patrick stated already
those have been mostly worked out by providing a new set of
macros. Except for a few leftovers, which will be addressed, there
is no need to call skb functions anymore. The reason the plain
skb interface was used is simply that the authors of most of the
netlink using code are in fact very familiar with the skb interface,
that's it.

> > You can still built this stuff on top, but the workarounds for netlink
> > limitations need to be fixed in netlink.
> 
> I could not call it workaround, I think it is a management layer,
> which allows :

Listen, nobody wants to take away your baby. ;-> There are some
objections of things which would rather be fixed in the netlink
layer first and the remaining part that is missing goes into the
connector. I see a lot of replicated netlink code in the connector
which is no necessary. I perfectly agree with you that we require
some form of simplified addressing and easier message handling
for simple applications but just building another layer on top
of netlink without respecting the capabilities of netlink itself
is not the way to go as I see it. For example, we'll probably add
a new group subscription mechanism to netlink which might perfectly
suit the needs of your connector.

> 1. easy usage. Just register a callback and that is all. Callback will
> be invoced each time new message arrives. No need to
> dequeue/free/anything.

Good point, also doable in netlink directly. Just get rid of the
usual family_rcv -> family_rcv_skb -> family_rcv_msg process and
do a callback registration interface instead. However, often the
processing of a message and the resulting ack must be done as an
atomic operation, e.g. rtnetlink.

> 2. easy usage. Call one function for message delivering, which can
> care of nonexistent users, perform flow control, congestion control,
> guarantee delivery and any other.

I don't understand what exactly you mean but netlink itself
is not reliable under memory pressure.
