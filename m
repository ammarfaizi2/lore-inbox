Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWDKJwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWDKJwK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 05:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWDKJwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 05:52:10 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:9932 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750710AbWDKJwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 05:52:09 -0400
Date: Tue, 11 Apr 2006 13:51:32 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Yi Yang <yang.y.yi@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [2.6.16 PATCH] Filessytem Events Reporter V3
Message-ID: <20060411095132.GB12244@2ka.mipt.ru>
References: <443A6F56.20701@gmail.com> <20060411082123.GB7852@2ka.mipt.ru> <443B6FE6.2020908@gmail.com> <20060411092034.GA13994@2ka.mipt.ru> <443B785F.7000903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <443B785F.7000903@gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 11 Apr 2006 13:51:35 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2006 at 05:35:27PM +0800, Yi Yang (yang.y.yi@gmail.com) wrote:
> Evgeniy Polyakov wrote:
> >On Tue, Apr 11, 2006 at 04:59:18PM +0800, Yi Yang (yang.y.yi@gmail.com) 
> >wrote:
> >
> >  
> >>>>+		if (skb->len >= FSEVENT_FILTER_MSGSIZE) {
> >>>>   
> >>>>        
> >>>I'm not sure about your size checks.
> >>>I think it should be compared with nlhdr->nlmsg_len?
> >>> 
> >>>      
> >>At this point, skb->len  should be the same as nlhdr->nlmsg_len.
> >>    
> >
> >Hmm, skb->len includes size of netlink header, but nlhdr->nlmsg_len does
> >not.
> >  
> No, it  included length of netlink header, please see it.
> struct nlmsghdr
> {
>        __u32           nlmsg_len;      /* Length of message including 
> header */
>        __u16           nlmsg_type;     /* Message content */
>        __u16           nlmsg_flags;    /* Additional flags */
>        __u32           nlmsg_seq;      /* Sequence number */
>        __u32           nlmsg_pid;      /* Sending process PID */
> };

You are right, you do not use netlink header size explicitly in skb size
calculation during allocation, so this is ok.

> >>>>+static void __exit fsevent_exit(void)
> >>>>+{
> >>>>+	listener * p = NULL, * q = NULL;
> >>>>+	int cpu;
> >>>>+	int wait_flag = 0;
> >>>>+	struct sk_buff_head * skb_head = NULL;
> >>>>+
> >>>>+	fsevents_mask = 0;
> >>>>+	_raise_fsevent = 0;
> >>>>+	exit_flag = 1;
> >>>>+
> >>>>+	for_each_cpu(cpu)
> >>>>+		schedule_work(&per_cpu(fsevent_work, cpu));
> >>>>+
> >>>>+	while (1) {
> >>>>+		wait_flag = 0;
> >>>>+		for_each_cpu(cpu) {
> >>>>+			skb_head = &per_cpu(fsevent_send_queue, cpu);
> >>>>+			if (skb_head->qlen != 0) {
> >>>>+				wait_flag = 1;
> >>>>+				break;
> >>>>+			}
> >>>>+		}
> >>>>+		if (wait_flag == 1) {
> >>>>+			set_current_state(TASK_INTERRUPTIBLE);
> >>>>+			schedule_timeout(HZ/10);
> >>>>+		} else
> >>>>+			break;
> >>>>+	}
> >>>>   
> >>>>        
> >>>This is still broken.
> >>>You race with schedule_work() in this loop. It requires
> >>>flush_scheduled_work().
> >>>
> >>>And I still have soume doubts about __raise_fsevent().
> >>>What if you set fsevents_mask to zero after __raise_fsevent() is
> >>>started, but not yet queued an skb, and above loop and scheduled work
> >>>are completed?
> >>> 
> >>>      
> >>I think it  is OK, schedule_timeout will release cpu to work queues, 
> >>work queues should have enough time
> >>to finish their works, I don't know what is your reason.
> >>    
> >
> >It is not guaranteed that scheduled work will be processed until
> >flush_scheduled_work() completion, no matter how many times processor
> >has idle cycles.
> >
> >Second issue is that both above loop and work can be finished, but some
> >__raise_fsevent() will be still in progress.
> >  
> I knew your meaning, if you have a better way, tell me.

Some kind of flag to specify that work is in progress, or reference
counters for subsystem, or even use mutuxes in sending path...
There are a lot of variants, from complex and fast to slow and simple.

> >>>You need some type of completion of the last worker...
> >>>
> >>> 
> >>>      
> >>>>+	atomic_set(&fsevent_sock->sk_rmem_alloc, 0);
> >>>>+	atomic_set(&fsevent_sock->sk_wmem_alloc, 0);
> >>>>   
> >>>>        
> >>>This is really wrong, since it hides skb processing errors like double
> >>>freeing or leaks.
> >>> 
> >>>      
> >>If userspace application terminated exceptionally, there are some skbs 
> >>not to be consumed on socket, so
> >>if you rmmod it, sock_release will report some failure information, the 
> >>above two statements will remove this
> >>error.
> >>    
> >
> >All queues will be flushed, when socket is freed, and if sock_release() 
> >shows
> >that assertion is failed, this definitely means you broke socket 
> >accounting, for example freed skb two times.
> >  
> I searched those code, it didn't decrease sk_rmem_alloc, do you mean 
> skb_queue_purge will decrease it?

Yes.

__kfree_skb() calls skb->destructor() callback, which can be
sock_rfree() or sock_wfree() for example, depending on socket type,
which decreases appropriate queue accounting variable.

> >  
> >>>>+	sock_release(fsevent_sock->sk_socket);
> >>>>        
> >
> >...
> >
> >  
> >>>Btw, it would be nice to have some kind of microbenchmark,
> >>>like http://permalink.gmane.org/gmane.linux.kernel/292755
> >>>just to see how things go...
> >>> 
> >>>      
> >>I have a userspace application to test fsevent, I'll release it to 
> >>community in order to find more issues on
> >>fsevent.
> >>    
> >
> >And please publish some numbers so people could make some prognosis of
> >system behaviour.
> >  
> Do you mean perfornance indice?

Probably.

It is quite hard to tell how well system behaves only looking into the
code, although it tells a lot.

Create for example a lot of files, or measure some other parameters
which are more close to real life behaviour, and check the time with and without
your code turned on, how many messages were lost if any, CPU usage and
so on...

-- 
	Evgeniy Polyakov
