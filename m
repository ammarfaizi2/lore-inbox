Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWDKJeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWDKJeW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 05:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWDKJeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 05:34:22 -0400
Received: from pproxy.gmail.com ([64.233.166.180]:357 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932160AbWDKJeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 05:34:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=fQ/GRzqMtHAL2d35nnJYZz8oxZad9mT3MyHdlBm/N3H5Z95xMb1SmSSBVGd0uyRzRM/Yxf247xUedCuDJFK5ifBZ0QtLAoi1G/W8VFKGS7rPJh75Vjt0lbd6eSYIqWTg7Qxup0606602j6EI43rex/uhVAw1k3LIOad1uKIoLoA=
Message-ID: <443B785F.7000903@gmail.com>
Date: Tue, 11 Apr 2006 17:35:27 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [2.6.16 PATCH] Filessytem Events Reporter V3
References: <443A6F56.20701@gmail.com> <20060411082123.GB7852@2ka.mipt.ru> <443B6FE6.2020908@gmail.com> <20060411092034.GA13994@2ka.mipt.ru>
In-Reply-To: <20060411092034.GA13994@2ka.mipt.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> On Tue, Apr 11, 2006 at 04:59:18PM +0800, Yi Yang (yang.y.yi@gmail.com) wrote:
>
>   
>>>> +		if (skb->len >= FSEVENT_FILTER_MSGSIZE) {
>>>>    
>>>>         
>>> I'm not sure about your size checks.
>>> I think it should be compared with nlhdr->nlmsg_len?
>>>  
>>>       
>> At this point, skb->len  should be the same as nlhdr->nlmsg_len.
>>     
>
> Hmm, skb->len includes size of netlink header, but nlhdr->nlmsg_len does
> not.
>   
No, it  included length of netlink header, please see it.
struct nlmsghdr
{
        __u32           nlmsg_len;      /* Length of message including 
header */
        __u16           nlmsg_type;     /* Message content */
        __u16           nlmsg_flags;    /* Additional flags */
        __u32           nlmsg_seq;      /* Sequence number */
        __u32           nlmsg_pid;      /* Sending process PID */
};
>   
>>>> +#define DEFINE_FILTER_MATCH_FUNC(filtertype, key) 			\
>>>> +	static int match_##filtertype(listener * p,			\
>>>> +				struct fsevent * event,			\
>>>> +				struct sk_buff * skb)			\
>>>> +	{								\
>>>> +		int ret = 0;						\
>>>> +		filtertype * xfilter = NULL;				\
>>>> +		struct sk_buff * skb2 = NULL;				\
>>>> +		struct list_head *  head = &(p->key##_filter_list_head);  \
>>>> +		list_for_each_entry(xfilter, head, list) {		\
>>>> +			if (xfilter->key != event->key)			\
>>>> +				continue;				\
>>>> +			ret = filter_fsevent(xfilter->mask, event->type); \
>>>> +			if ( ret != 0)					\
>>>> +				return -1;				\
>>>> +			skb2 = skb_clone(skb, GFP_KERNEL);		\
>>>> +       			if (skb2 == NULL)			 \
>>>>    
>>>>         
>>> Coding style.
>>>
>>>  
>>>       
>>>> +				return -1;				\
>>>> +			NETLINK_CB(skb2).dst_group = 0;			\
>>>> +			NETLINK_CB(skb2).dst_pid = p->pid;		\
>>>> +			NETLINK_CB(skb2).pid = 0;			\
>>>> +			return (netlink_unicast(fsevent_sock, skb2,	\
>>>> +					p->pid, MSG_DONTWAIT));		\
>>>> +		}							\
>>>> +		return -1;						\
>>>> +	}								\
>>>> +
>>>> +DEFINE_FILTER_MATCH_FUNC(pid_filter, pid)
>>>> +
>>>> +DEFINE_FILTER_MATCH_FUNC(uid_filter, uid)
>>>> +
>>>> +DEFINE_FILTER_MATCH_FUNC(gid_filter, gid)
>>>>    
>>>>         
>>> You send the same data for each type of filters, maybe it is design
>>> approach, but why don't you want to send that data in one skb?
>>>  
>>>       
>> netlink control block is not the same, netlink_broadcast is a typical case.
>>     
>
> Yes, I see, pid is changed.
>
>   
>>>> +#define MATCH_XID(key, listenerp, event, skb) 			\
>>>> +	ret = match_##key##_filter(listenerp, event, skb); 	\
>>>> +	if (ret == 0) {					 	\
>>>> +		kfree_skb(skb);				 	\
>>>> +	        continue;				 	\
>>>>    
>>>>         
>>> Your match funtions can not return 0.
>>>  
>>>       
>> It can, if sending is successfull, netlink_unicast will return 0.
>>     
>
> No, it returns skb->len on success.
> netlink_broadcast() returns 0 on success.
>
>   
>>>> +static void __exit fsevent_exit(void)
>>>> +{
>>>> +	listener * p = NULL, * q = NULL;
>>>> +	int cpu;
>>>> +	int wait_flag = 0;
>>>> +	struct sk_buff_head * skb_head = NULL;
>>>> +
>>>> +	fsevents_mask = 0;
>>>> +	_raise_fsevent = 0;
>>>> +	exit_flag = 1;
>>>> +
>>>> +	for_each_cpu(cpu)
>>>> +		schedule_work(&per_cpu(fsevent_work, cpu));
>>>> +
>>>> +	while (1) {
>>>> +		wait_flag = 0;
>>>> +		for_each_cpu(cpu) {
>>>> +			skb_head = &per_cpu(fsevent_send_queue, cpu);
>>>> +			if (skb_head->qlen != 0) {
>>>> +				wait_flag = 1;
>>>> +				break;
>>>> +			}
>>>> +		}
>>>> +		if (wait_flag == 1) {
>>>> +			set_current_state(TASK_INTERRUPTIBLE);
>>>> +			schedule_timeout(HZ/10);
>>>> +		} else
>>>> +			break;
>>>> +	}
>>>>    
>>>>         
>>> This is still broken.
>>> You race with schedule_work() in this loop. It requires
>>> flush_scheduled_work().
>>>
>>> And I still have soume doubts about __raise_fsevent().
>>> What if you set fsevents_mask to zero after __raise_fsevent() is
>>> started, but not yet queued an skb, and above loop and scheduled work
>>> are completed?
>>>  
>>>       
>> I think it  is OK, schedule_timeout will release cpu to work queues, 
>> work queues should have enough time
>> to finish their works, I don't know what is your reason.
>>     
>
> It is not guaranteed that scheduled work will be processed until
> flush_scheduled_work() completion, no matter how many times processor
> has idle cycles.
>
> Second issue is that both above loop and work can be finished, but some
> __raise_fsevent() will be still in progress.
>   
I knew your meaning, if you have a better way, tell me.
>   
>>> You need some type of completion of the last worker...
>>>
>>>  
>>>       
>>>> +	atomic_set(&fsevent_sock->sk_rmem_alloc, 0);
>>>> +	atomic_set(&fsevent_sock->sk_wmem_alloc, 0);
>>>>    
>>>>         
>>> This is really wrong, since it hides skb processing errors like double
>>> freeing or leaks.
>>>  
>>>       
>> If userspace application terminated exceptionally, there are some skbs 
>> not to be consumed on socket, so
>> if you rmmod it, sock_release will report some failure information, the 
>> above two statements will remove this
>> error.
>>     
>
> All queues will be flushed, when socket is freed, and if sock_release() shows
> that assertion is failed, this definitely means you broke socket accounting, 
> for example freed skb two times.
>   
I searched those code, it didn't decrease sk_rmem_alloc, do you mean 
skb_queue_purge will decrease it?
>   
>>>> +	sock_release(fsevent_sock->sk_socket);
>>>>         
>
> ...
>
>   
>>> Btw, it would be nice to have some kind of microbenchmark,
>>> like http://permalink.gmane.org/gmane.linux.kernel/292755
>>> just to see how things go...
>>>  
>>>       
>> I have a userspace application to test fsevent, I'll release it to 
>> community in order to find more issues on
>> fsevent.
>>     
>
> And please publish some numbers so people could make some prognosis of
> system behaviour.
>   
Do you mean perfornance indice?

