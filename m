Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271797AbRHWJrO>; Thu, 23 Aug 2001 05:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271799AbRHWJrF>; Thu, 23 Aug 2001 05:47:05 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:2320 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S271797AbRHWJqq>; Thu, 23 Aug 2001 05:46:46 -0400
Date: Thu, 23 Aug 2001 06:46:59 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "Jens Hoffrichter" <HOFFRICH@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Allocation of sk_buffs in the kernel
Message-ID: <20010823064659.V5062@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"Jens Hoffrichter" <HOFFRICH@de.ibm.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <OF551C0474.A161B459-ONC1256AB1.00337905@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <OF551C0474.A161B459-ONC1256AB1.00337905@de.ibm.com>; from HOFFRICH@de.ibm.com on Thu, Aug 23, 2001 at 11:29:11AM +0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 23, 2001 at 11:29:11AM +0200, Jens Hoffrichter escreveu:
> > > > Maybe Jens should use something like WAITQUEUE_DEBUG if he want to
> know
> > > > where alloc_skb and friends were called, see include/linux/wait.h 8)
> > > Do you mean I should use something LIKE the WAITQUEUE_DEBUG (eg.
> > > implementing something like that in skbuff.c) or I should use
> > > WAITQUEUE_DEBUG?
> > no, just use the same idea that is used to debug wait_queues
> OK, then I interpreted the code in wait.h right ;)
> 
> > > Are there any examples how to use the WAITQUEUE_DEBUG?
> 
> > oops, I mean the __waker thing, for debugging you could get the address
> of
> > the caller with current_text_addr() and store it in an extra sk_buff
> field
> > so that later on you could know who create the skb.
> But where should I fill this field in the sk_buff? I know that alloc_skb
> creates an sk_buff, so this would be of no use for me. Or do you mean to
> add something like that to the initialization of the sk_buff struct, like a
> "long allocator = current_text_addr()" in skbuff.h? Is something like this
> possible? I'm not sure about it....

look, alloc_skb is not inline, so you need to use
__builtin_return_address(0) to know who called alloc_skb, you have to
change struct sk_buff to have an extra member where you will store the
return of __builtin_return_address(0), and possibly another field to store
the jiffies, so that you'll have the time when the alloc_skb was called,
then, later on, you could just printk the time it took from the alloc_skb
to the place where you want to know how long it took to traverse the
section of the network stack you're interested in.
 
> > About the example of WAITQUEUE_DEBUG:
> >
> > after being awaken you could do this:
> 
> >                 dprintk("sleeper=%p, waker=%lx\n",
> >                          current_text_addr(), wait.__waker);
> 
> > in a inline function does the trick, but this is just an example of a
> > function that uses an extra debug field in a structure that is alocated
> > somewhere and you want to know who allocated it later on.
> 
> > Yes, you'll have to decode the address from syslog, gotcha?
> But the __waker member is filled by a macro from wait.h, if I had seen it
> right. Where would you issue such a dprintk call?
 
> Sorry about my missing knowledge about wait queues, but I don't get the
> point where to fill the member. That I could print it later on, thats
> clear, but how to fill it?

creating another field in the struct sk_buff, like I said above. The whole
point of the wait_queue was to show you the idea, the fact that you could
add another field to the struct you want to watch, see this excerpt from
include/linux/wait.h:

struct __wait_queue {
        unsigned int flags;
#define WQ_FLAG_EXCLUSIVE       0x01
        struct task_struct * task;
        struct list_head task_list;
#if WAITQUEUE_DEBUG
        long __magic;
        long __waker;
#endif
};

see? you just add a 'long allocator; long jiffies_creation;' to struct
sk_buff like in the struct above, for WAITQUEUE_DEBUG debugging the kernel
has __magic and __waker, and store at alloc_skb time there the return of
__builtin_return_address(0) and jiffies, the later on you use it for your
purposes.

- Arnaldo
