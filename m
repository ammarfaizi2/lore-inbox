Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVGZEyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVGZEyg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 00:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVGZEyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 00:54:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10160 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261697AbVGZEy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 00:54:28 -0400
Message-ID: <42E5C298.8010209@osdl.org>
Date: Mon, 25 Jul 2005 21:56:56 -0700
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: Patrick McHardy <kaber@trash.net>, James Morris <jmorris@redhat.com>,
       "David S. Miller" <davem@davemloft.net>,
       Harald Welte <laforge@netfilter.org>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org
Subject: Re: Netlink connector
References: <20050723125427.GA11177@rama> <20050723091455.GA12015@2ka.mipt.ru> <20050724.191756.105797967.davem@davemloft.net> <Lynx.SEL.4.62.0507250154000.21934@thoron.boston.redhat.com> <20050725070603.GA28023@2ka.mipt.ru> <42E4F800.1010908@trash.net> <20050725192853.GA30567@2ka.mipt.ru> <42E579BC.8000701@trash.net> <20050726044547.GA32006@2ka.mipt.ru>
In-Reply-To: <20050726044547.GA32006@2ka.mipt.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:

>On Tue, Jul 26, 2005 at 01:46:04AM +0200, Patrick McHardy (kaber@trash.net) wrote:
>  
>
>>Evgeniy Polyakov wrote:
>>    
>>
>>>On Mon, Jul 25, 2005 at 04:32:32PM +0200, Patrick McHardy 
>>>(kaber@trash.net) wrote:
>>>
>>>      
>>>
>>>>If I understand correctly it tries to workaround some netlink
>>>>limitations (limited number of netlink families and multicast groups)
>>>>by sending everything to userspace and demultiplexing it there.
>>>>Same in the other direction, an additional layer on top of netlink
>>>>does basically the same thing netlink already does. This looks like
>>>>a step in the wrong direction to me, netlink should instead be fixed
>>>>to support what is needed.
>>>>        
>>>>
>>>Not only it.
>>>The main _first_ idea was to simplify userspace mesasge handling as much
>>>as possible.
>>>In first releases I called it ioctl-ng - any module that want ot
>>>communicate with userspace in the way ioctl does, 
>>>      
>>>
>>Usually netlink is easily extendable by using nested TLVs. By hiding
>>this you basically remove this extensibility.
>>    
>>
>
>Current netlink is not extensible for _many_ different users.
>It has only 32 sockets.
>
>  
>
>>>requires skb allocation/freeing/handling.
>>>Does RTC driver writer need to know what is the difference between
>>>shared and cloned skb? Should kernel user of such message bus
>>>have to know about skb at all?
>>>      
>>>
>>Netlink users don't have to care about shared or cloned skbs. I don't
>>think its a big issue to use alloc_skb and then the usual netlink
>>macros. Thomas added a number of macros that simplfiy use a lot.
>>    
>>
>
>Kernel user also must know about difference between unicast/broadcast,
>how to dequeue the skb, how to free it and in what context.
>ioctl users do not need to know how file_operations is bound to file.
>
>  
>
>>But my main objection is that it sends everything to userspace even
>>if noone is listening. This can't be used for things that generate
>>lots of events, and also will get problematic is the number of users
>>increases.
>>    
>>
>
>It is a problem for existing netlink - either check in bind time, 
>what could be done for connector, or in socket creation time.
>
>Actually it is not even a problem, since checking is being done, 
>but after allocation and message filling, such check can be moved into
>cn_netlink_send() in connector, but different netlink users, 
>who prefers to use different sockets, must perform it by itself in each
>place, where skb is allocated...
>
>Connector is a solution for current situation, 
>it can be deployed with few casualties.
>Creating a new netlink2 socket for device, which wants to replace ioctl
>controlling or broadcast it's state is a wrong way.
>Different sockets/flows does not allow easy flow control.
>
>We have one pipe - ethernet, and many protocols inside this pipe
>with different headers - it is the same here - netlink is such a pipe,
>and with connector it allows to have different protocols in it.
>
>  
>
>>>With char device I only need to register my callback - with kernel
>>>connector it is the same, but allows to use the whole power of netlink,
>>>especially without nice ioctl features like different pointer size 
>>>in userspace and kernelspace.
>>>      
>>>
>>You still have to take care of mixed 64/32 bit environments, u64 fields
>>for example are differently alligned.
>>    
>>
>
>Connector has a size in it's header - ioctl does not.
>
>  
>
>>>And number of free netlink sockets is _very_ small, especially
>>>if allocate new one for simple notifications, which can be easily done
>>>using connector.
>>>      
>>>
>>Then fix it so we can use more families and groups. I started some work
>>on this, but I'm not sure if I have time to complete it.
>>    
>>
>
>It does not "fix" the "problem" of skb management knowledge, which I
>described.
>Netlink is a transport protocol, some general logic must be created on
>top of it, like it is done in TCP/IP.
>
>  
>
>>>And netlink can be extended to support it - netlink is a transport
>>>protocol, it should not care about higher layer message handling,
>>>connector instead will deliver message to the end user in a very
>>>convenient form.
>>>      
>>>
>>You can still built this stuff on top, but the workarounds for netlink
>>limitations need to be fixed in netlink.
>>    
>>
>
>I could not call it workaround, I think it is a management layer,
>which allows :
>1. easy usage. Just register a callback and that is all. Callback will
>be invoced each time new message arrives. No need to
>dequeue/free/anything.
>2. easy usage. Call one function for message delivering, which can
>care of nonexistent users, perform flow control, congestion control,
>guarantee delivery and any other.
>3. Easily deployable - current implementation is so simple, and it does
>work with existing netlink.
>4. It is logical level on top of transport protocol, it is UDP/IP over
>ethernet :)
>
>  
>
If it is a transport, then it should be in the kernel. Otherwise, it 
becomes painful
for applications with multiple input sources.  Think of 
epoll/poll/select and threads,
doing the demultiplexing in user space would be a pain for applications 
and libraries.

The other way to go is to use something like dbus/hal and use a higher level
application oriented interface. The problem with that approach, is it 
assumes
every management app wants to drag in gnome..


