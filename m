Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263794AbSLQAsC>; Mon, 16 Dec 2002 19:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263986AbSLQAsC>; Mon, 16 Dec 2002 19:48:02 -0500
Received: from h001.c011.snv.cp.net ([209.228.34.214]:5584 "HELO
	c011.snv.cp.net") by vger.kernel.org with SMTP id <S263794AbSLQAr6> convert rfc822-to-8bit;
	Mon, 16 Dec 2002 19:47:58 -0500
X-Sent: 17 Dec 2002 00:55:54 GMT
Content-Type: text/plain; charset=US-ASCII
From: Steve Isaacs <steve@trevithick.net>
To: James Morris <jmorris@intercode.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [CryptoAPI-devel] [RFC] Hardware support notes for the kernel crypto API (2.5+)
Date: Mon, 16 Dec 2002 16:56:06 -0800
X-Mailer: KMail [version 1.4]
Cc: "David S. Miller" <davem@redhat.com>,
       cryptoapi-devel <cryptoapi-devel@kerneli.org>
References: <Mutt.LNX.4.44.0212150025190.24712-100000@blackbird.intercode.com.au>
In-Reply-To: <Mutt.LNX.4.44.0212150025190.24712-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212161656.06106.steve@trevithick.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 December 2002 05:51, James Morris wrote:
>  
>
> GPL Driver status:
>
>   HiFn 7751
>     James Morris (in progress).
>  
>   HiFn 7951
>     David Bryson (in progress).
>     Also see http://sourceforge.net/projects/hifn7951/
>  
>   HiFn 7901
>     See http://sources.colubris.com/en/projects/FreeSWAN/
>    
>   Motorola MPC190, MPC184
>     Steve (in progress).
>    

The driver for the MPC190 is now running with limited capability (although not 
very clean at the moment). Most of what I've done is workout the details of 
configuring the co-processor that are not described in the User's Manuala and 
builtind a basic framework to support mutiple coprocessors (of the same type) 
and callbacks. Motorola has been very helpful with this.

In case you're interrested here are some details (you can pick me apart if you 
want to -- I'm somewhat new to this so I could use some advice):

At this time only MD5 is supported but, now that I've got a better handle on 
the ideosyncrasies, implementing additional transforms should take less 
effort (and time). The driver is able to detect multiple mpc190s on the PCI 
bus and use them dynamically. 

Each mpc190 supports 9 execution "channels" (Motorola's term). The driver 
hides the fact that there are multiple channels or even multiple coprocessors 
and instead only exposes the various transforms (e.g. MD5, DES...). 

The driver internally allocates channels to satisfy cipher requests on an as 
need basis and does support callback from the bottom-half (interrupt tasklet) 
for asynchronous notification of completion of the task. 

To simplify management I implemented an abstract I call a "virtual channel" 
and maintain linked lists of "virtual channels" on idle and busy queues. 
Allocation of a channel is simply moving a channel from the idle queue to the 
busy queue. Deallocation is the reverse. 

Two of the attributes of a "virtual channel" are the base IO address of the 
processor and the offset of the channel to facilitate code that can work with 
any channel. 

Calling tasks are placed on sleep_interruptable queues (there is one for each 
"virtual channel") and are not awakened until after the callback has 
completed (if one was requested).

"Virtual channel" states are maintained internally to help track the progress 
of a channel and include IDLE, BUSY, PENDING, and CALLBACK. The IDLE and BUSY 
states are obvious. The PENDING state identifies a channel that has been 
queued for the bottom-half (interrupt tasklet) to process. The CALLBACK state 
indicates a channel that is awaiting a return from a call to a client 
callback function.

Thoughts for the future:

The MPC184 also uses the channel concept but provides fewer of them (4 versus 
9) and doesn't support all of transforms of the mpc190 (MD4 and HMAC-MD5 are 
missing). At the same time the mpc184 provides AES whereas the mpc190 does 
not. I've been struggling trying to figure out how to extend the "virtual 
channel" scheme to allow concurrent use of both an mpc190 and and mpc184 but 
not have to support both in the same driver (not something I want to do). The 
project which is the true motivation behind all of this has the possibility 
of having both on the bus at the same time.

Steve

