Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266652AbUBFG6e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 01:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266654AbUBFG6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 01:58:34 -0500
Received: from keskus.netlab.hut.fi ([130.233.154.176]:10376 "EHLO
	keskus.netlab.hut.fi") by vger.kernel.org with ESMTP
	id S266652AbUBFG6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 01:58:32 -0500
Message-ID: <40233B13.8050703@netlab.hut.fi>
Date: Fri, 06 Feb 2004 08:58:27 +0200
From: Emmanuel Guiton <emmanuel@netlab.hut.fi>
Reply-To: emmanuel@netlab.hut.fi
Organization: HUT Networking Laboratory
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Muli Ben-Yehuda <mulix@mulix.org>
CC: Duncan Sands <baldrick@free.fr>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Freeing skbuff (was: Re: Sending built-by-hand packet and kernel
 panic.)
References: <401E62C3.60503@netlab.hut.fi> <200402021602.56242.baldrick@free.fr> <401E8E33.7050305@netlab.hut.fi> <20040203094938.GE5212@actcom.co.il>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Well, my investigations led me to precise a bit more my problem. There 
is no problem with NF_HOOK as it returns 0 and the packet is sent on the 
wire.
Upper layers are not a problem neither, because I bypass them totally. 
However, handling myself the dtructor function seems to be definitely a 
must do.

Concerning what I noticed that was wrong in my code, there was this 
trick I used to initialize my socket:

struct socket *sending_socket;
struct sock *sk;

   if (sock_create(PF_INET, SOCK_RAW, IPPROTO_RAW, &sending_socket) < 0)
   {
       printk("Error socket creation.\n");
       sock_release(sending_socket);
       return -1;
   }
   sk = kmalloc(sizeof(struct sock), GFP_KERNEL);
   memcpy(&(sending_socket->sk), sk, sizeof(struct sock));

I noticed that the sock_create function increments the reference count 
by two. When I copy the sending_socket->sk field in my sk variable, sk 
still gets this ref count =2. Thus when destroying the skbuff the socket 
is not freed (the release function decreases the sk ref count by one, 
see that there is one left, and exit without freeing the socket).
I also now think that I was doing the operations the wrong way around: I 
was trying to initialize all the skbuff fields, amongst whose was the 
socket. I discovered in some other codes that it is usually the socket 
which is first initialized and then the skbuff is attached to it. At 
least I'm now following that idea but I haven't had much time recently 
to go deeper on the implementation.

Thanks for your help,

        Emmanuel


Muli Ben-Yehuda wrote:

>On Mon, Feb 02, 2004 at 07:51:47PM +0200, Emmanuel Guiton wrote:
>
>  
>
>>However, my overall problem is not solved. As far as my investigations 
>>led me, my sk_buff structure is never released after having been sent on 
>>the wire. So I guess I need an explicit destructor function in my 
>>sk_buff as the following is present in the definition of struct sk_buff:
>>void         (*destructor)(struct sk_buff *);    /* Destruct function  */
>>    
>>
>
>Note that depending on what you're doing, you might not be able to use
>the destructor, because the upper layers use it without regards to
>whether it was set before. To the best of my understanding, the rules
>for the destructor say that it is free for the use of whatever layer
>owns the skbuff at the moment. There are three ways around it - the
>first and obvious is to avoid relying on the destructor. The second is
>that you can use skb_clone() to get your own copy of the headers and
>the destructor (but that doesn't really help you because how does the
>layer that ends up freeing the skb know to use your version of the
>headers?) and the third is to use this patch,
>http://www.mulix.org/patches/skb-destructor-chaining-A2-2.6.1, to 
>allow more than destructor per skb. 
>
>Hope this helps, 
>Muli 
>  
>



