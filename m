Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWDGKB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWDGKB6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 06:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWDGKB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 06:01:58 -0400
Received: from xproxy.gmail.com ([66.249.82.192]:27981 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932217AbWDGKB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 06:01:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=hyds3yVc3TEO0mG3UmbbYgX3YAgDw/XE1+Q3DJTrNjDHxpt1qGv34ptPfi4ttPiK9D8DrkMJhT/knhhiNG5PatOpJwgc3v4YytfqYg6Xm92abI8B404IXsnWPOUG7Vlq8NB0UFpWcnRBaidyDt9nYUTmTM+LWTr8PT7qUWAETFc=
Message-ID: <443638D8.2010800@gmail.com>
Date: Fri, 07 Apr 2006 18:03:04 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [2.6.16 PATCH] Filessytem Events Reporter V2
References: <4433C456.7010708@gmail.com> <20060407062428.GA31351@2ka.mipt.ru> <44361F39.4020501@gmail.com> <20060407094732.GA13235@2ka.mipt.ru>
In-Reply-To: <20060407094732.GA13235@2ka.mipt.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> On Fri, Apr 07, 2006 at 04:13:45PM +0800, Yi Yang (yang.y.yi@gmail.com) wrote:
>   
>>>> +
>>>> +	return (netlink_unicast(fsevent_sock, skb, pid, MSG_DONTWAIT));
>>>>    
>>>>         
>>> netlink_unicast() uses boolean value but ont MSG_* flags for nonblocking, 
>>> so this should be netlink_unicast(fsevent_sock, skb, pid, 0);
>>>  
>>>       
>> a example invocation in file net/netlink/af_netlink.c:
>> netlink_unicast(in_skb->sk, skb, NETLINK_CB(in_skb).pid, MSG_DONTWAIT);
>> so, it hasn't any problem.
>>     
>
> Well...
>
> static inline long sock_sndtimeo(const struct sock *sk, int noblock)
> {
> 	return noblock ? 0 : sk->sk_sndtimeo;
> }
>
> int netlink_unicast(struct sock *ssk, struct sk_buff *skb, u32 pid, int nonblock)
> {
> 	struct sock *sk;
> 	int err;
> 	long timeo;
>
> 	skb = netlink_trim(skb, gfp_any());
>
> 	timeo = sock_sndtimeo(ssk, nonblock);
>
> I mean that it is boolean value, MSG_PEEK will produce the same result.
> But it is a matter of coding style probably.
>
>   
>>>> +nlmsg_failure:
>>>> +	kfree_skb(skb);
>>>> +	return -1;
>>>> +}
>>>>    
>>>>         
>>> ...
>>>
>>>  
>>>       
>>>> +static void fsevent_recv(struct sock *sk, int len)
>>>> +{
>>>> +	struct sk_buff *skb = NULL;
>>>> +	struct nlmsghdr *nlhdr = NULL;
>>>> +	struct fsevent_filter * filter = NULL;
>>>> +	pid_t pid;
>>>> +
>>>> +	while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {
>>>> +		skb_get(skb);
>>>> +		if (skb->len >= FSEVENT_FILTER_MSGSIZE) {
>>>> +			nlhdr = (struct nlmsghdr *)skb->data;
>>>> +			filter = NLMSG_DATA(nlhdr);
>>>> +			pid = NETLINK_CREDS(skb)->pid;
>>>> +			if (find_fsevent_listener(pid) == NULL)
>>>> +				atomic_inc(&fsevent_listener_num);
>>>> +			set_fsevent_filter(filter, pid);
>>>>    
>>>>         
>>> What is the logic behind this steps?
>>> If there are no listeners you increment it's number no matter if it will
>>> or not be added in set_fsevent_filter().
>>>  
>>>       
>> fsevent_recv is used to receive listener's commands, a listener must 
>> send commands in order to get fsevents it
>> interests, so this is the best point to increment number of listeners. 
>> set_fsevent_filter will add listener to listener
>> list, so it is OK.
>>     
>
> And what if set_fsevent_filter() fails?
>   
I didn't consider this case, thanks, I will do with it.
>   
>>>> +		}
>>>> +		kfree_skb(skb);
>>>> +	}
>>>> +}
>>>> +
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
>>>> +				return -ENOMEM;				\
>>>> +			NETLINK_CB(skb2).dst_group = 0;			\
>>>> +			NETLINK_CB(skb2).dst_pid = p->pid;		\
>>>> +			NETLINK_CB(skb2).pid = 0;			\
>>>> +			return (netlink_unicast(fsevent_sock, skb2,	\
>>>> +					p->pid, MSG_DONTWAIT));		\
>>>>    
>>>>         
>>> The same issue about nonblocking sending.
>>>
>>>  
>>>       
>>>> +		}							\
>>>> +		return -ENODEV;						\
>>>> +	}								\
>>>> +
>>>> +DEFINE_FILTER_MATCH_FUNC(pid_filter, pid)
>>>> +
>>>> +DEFINE_FILTER_MATCH_FUNC(uid_filter, uid)
>>>> +
>>>> +DEFINE_FILTER_MATCH_FUNC(gid_filter, gid)
>>>> +
>>>> +#define MATCH_XID(key, listenerp, event, skb) 			\
>>>> +	ret = match_##key##_filter(listenerp, event, skb); 	\
>>>> +	if (ret == 0) {					 	\
>>>> +		kfree_skb(skb);				 	\
>>>> +	        continue;				 	\
>>>> +	}						 	\
>>>> +	do {} while (0)					 	\
>>>> +
>>>> +static int fsevent_send_to_process(struct sk_buff * skb)
>>>> +{
>>>> +	listener * p  = NULL, * q = NULL;
>>>> +	struct fsevent * event = NULL;
>>>> +	struct sk_buff * skb2 = NULL;
>>>> +	int ret = 0;
>>>> +
>>>> +	event = (struct fsevent *)(skb->data + sizeof(struct nlmsghdr));
>>>> +	spin_lock(&listener_list_lock);
>>>> +	list_for_each_entry_safe(p, q, &listener_list_head, list) {
>>>> +		MATCH_XID(pid, p, event, skb);
>>>> +		MATCH_XID(uid, p, event, skb);
>>>> +		MATCH_XID(gid, p, event, skb);
>>>> +
>>>> +		if (filter_fsevent(p->mask, event->type) == 0) {
>>>> +			 skb2 = skb_clone(skb, GFP_KERNEL);
>>>> +	                 if (skb2 == NULL)
>>>> +	                 	return -ENOMEM;
>>>> +	                 NETLINK_CB(skb2).dst_group = 0;
>>>> +	                 NETLINK_CB(skb2).dst_pid = p->pid;
>>>> +	                 NETLINK_CB(skb2).pid = 0;
>>>> +	                 ret = netlink_unicast(fsevent_sock, skb2,
>>>> +	                                p->pid, MSG_DONTWAIT);
>>>> +			if (ret == -ECONNREFUSED) {
>>>> +				atomic_dec(&fsevent_listener_num);
>>>> +				cleanup_dead_listener(p);
>>>> +			}
>>>> +		}
>>>> +	}
>>>> +	spin_unlock(&listener_list_lock);
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static void fsevent_commit(void * unused)
>>>> +{
>>>> +	struct sk_buff * skb = NULL;
>>>> +		
>>>> +	while((skb = skb_dequeue(&get_cpu_var(fsevent_send_queue)))
>>>> +		!= NULL) {
>>>> +		fsevent_send_to_process(skb);
>>>> +		put_cpu_var(fsevent_send_queue);
>>>> +	}
>>>> +}
>>>>    
>>>>         
>>> Really strange mix of per-cpu variables for optimized performance and
>>> global spin locking.
>>> Consider using RCU for list of listeners.
>>>  
>>>       
>> per cpu queue is used to avoid raise_fsevent to contend spinlock, but 
>> listener_list_lock just is used
>> to synchronize the operations of userspace applications(listener) on 
>> listener list, it just protect listener
>> list.
>>
>> Of course, your advice is good, RCU will be better, I'm considering 
>> substitute spinlock with RCU,
>> maybe list*_rcu  functions can help me.
>>     
>
> You get global lock in each processor when traverse the list
> &listener_list_lock.
>
> And you call GFP_KERNEL allocation under that lock, which is wrong.
>
> If all your code is called from process context (it looks so), you
> could mutexes.
>   
Yes, mutex should be the best choice.
>   
>>> You use unicast delivery for netlink messages. 
>>> According to my investigation [1], it's performance is better only when
>>> there is only one listener (or maybe two in some cases), but then it is
>>> noticebly slower than broadcasting.
>>>
>>> 1. http://marc.theaimsgroup.com/?l=linux-netdev&m=114424884216006&w=2
>>>  
>>>       
>> Because fsevent has to deliver different events to different listeners, 
>> so I must use netlink_unicast,
>> in fact, netlink_broadcast also must send skb to every member of the 
>> group, so in my opinion,
>> they haven't  big difference.
>>     
>
> And what if there are several listeners for the same type of events?
>
>   
>> Can you explain why there is such a big difference between 
>> netlink_unicast and netlink_broadcast?
>>     
>
> Netlink broadcast clones skbs, while unicasting requires the whole new
> one.
>   
No, I also use clone to send skb, so they should have the same overhead.
>   
>>> Btw, you need some rebalancing of the per-cpu queues, probably in
>>> keventd, since CPUs can go offline and your messages will stuck foreve
>>> there.
>>>  
>>>       
>> Does keventd not do it? if so, keventd should be modified.
>>     
>
> How does keventd know about your own structures?
> You have an per-cpu object, but your keventd function gets object 
> from running cpu, not from any other cpus.
>
>   

