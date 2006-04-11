Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWDKI6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWDKI6P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 04:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWDKI6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 04:58:14 -0400
Received: from pproxy.gmail.com ([64.233.166.183]:2341 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932367AbWDKI6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 04:58:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=s2My0/A0Fjm3EKIQMEjkmqCC1WUtO8d9ELnZtSHyUpenkMgzaqTdIhG2M9c3ZogOg4hgiD6ZJRxc4go73l0B88A3WRZahpcACVMGQSaLYBBQDMViIa8jSLxuDYqYHq/LpkrllBdlyKEJycq1EKnZO+oyejsANs1J21hJOMWkLcM=
Message-ID: <443B6FE6.2020908@gmail.com>
Date: Tue, 11 Apr 2006 16:59:18 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [2.6.16 PATCH] Filessytem Events Reporter V3
References: <443A6F56.20701@gmail.com> <20060411082123.GB7852@2ka.mipt.ru>
In-Reply-To: <20060411082123.GB7852@2ka.mipt.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> On Mon, Apr 10, 2006 at 10:44:38PM +0800, Yi Yang (yang.y.yi@gmail.com) wrote:
>   
>> Compared with Filesystem Events Reporter v2, the following changes are done:
>>   - Can be built as module. 
>>   - Fix some bugs pointed out by Evgeniy
>>   - Substitute spinlock with mutex
>>   - Complete exit cleanup
>>     
>
> ...
>
>   
>> --- /dev/null	2003-01-30 18:24:37.000000000 +0800
>> +++ b/include/linux/fsevent.h	2006-04-08 22:09:30.000000000 +0800
>> @@ -0,0 +1,167 @@
>> +/*
>> + * fsevent.h - filesystem events connector
>>     
>
> I think you want to change this sentence to "... reporter", don't you :)
>
> ...
>   
>> +static inline int filter_fsevent(u32 filter_mask, u32 event_mask)
>> +{
>> +	event_mask &= FSEVENT_MASK;
>> +	event_mask &= filter_mask;
>> +	if (event_mask == 0) {
>> +		return -1;
>> +	}
>>     
>
> Coding style...
> ...
>
>   
>> +	(*mask) &= fsevents_mask;
>> +	if ((*mask) == 0) {
>> +		ret = -1;
>> +	}
>>     
>
> Ditto.
>
> ...
>
>   
>> +static void fsevent_recv(struct sock *sk, int len)
>> +{
>> +	struct sk_buff *skb = NULL;
>> +	struct nlmsghdr *nlhdr = NULL;
>> +	struct fsevent_filter * filter = NULL;
>> +	pid_t pid;
>> +	int inc_flag = 0;
>> +
>> +	if (exit_flag == 1)
>> +		return;
>> +
>> +	while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {
>> +		skb_get(skb);
>>     
>
> Really suspicious, only you own skb at this place, no need to grab a
> reference, which, btw, will never be released.
>
>   
>> +		if (skb->len >= FSEVENT_FILTER_MSGSIZE) {
>>     
>
> I'm not sure about your size checks.
> I think it should be compared with nlhdr->nlmsg_len?
>   
At this point, skb->len  should be the same as nlhdr->nlmsg_len.
>   
>> +			nlhdr = (struct nlmsghdr *)skb->data;
>> +			filter = NLMSG_DATA(nlhdr);
>> +			pid = NETLINK_CREDS(skb)->pid;
>> +			if (find_fsevent_listener(pid) == NULL)
>> +				inc_flag = 1;
>>     
>
> This logic is broken if several skbs are processed at once, since
> inc_flag is not cleared if find_fsevent_listener() fails for second skb.
>
>   
>> +			if (set_fsevent_filter(filter, pid) == 0) {
>> +				if (inc_flag == 1)
>> +					atomic_inc(&fsevent_listener_num);
>> +			}
>>     
>
> Why not 
> if ((find_fsevent_listener(pid) == NULL) &&
> 	(set_fsevent_filter(filter, pid) == 0))
> 		atomic_inc(&fsevent_listener_num);
>
>   
Your method is right.
>> +		}
>> +		kfree_skb(skb);
>>     
>
> Here you only release a reference to skb, but do not free skb itself.
>
>   
>> +	}
>> +}
>> +
>> +#define DEFINE_FILTER_MATCH_FUNC(filtertype, key) 			\
>> +	static int match_##filtertype(listener * p,			\
>> +				struct fsevent * event,			\
>> +				struct sk_buff * skb)			\
>> +	{								\
>> +		int ret = 0;						\
>> +		filtertype * xfilter = NULL;				\
>> +		struct sk_buff * skb2 = NULL;				\
>> +		struct list_head *  head = &(p->key##_filter_list_head);  \
>> +		list_for_each_entry(xfilter, head, list) {		\
>> +			if (xfilter->key != event->key)			\
>> +				continue;				\
>> +			ret = filter_fsevent(xfilter->mask, event->type); \
>> +			if ( ret != 0)					\
>> +				return -1;				\
>> +			skb2 = skb_clone(skb, GFP_KERNEL);		\
>> +       			if (skb2 == NULL)				\
>>     
>
> Coding style.
>
>   
>> +				return -1;				\
>> +			NETLINK_CB(skb2).dst_group = 0;			\
>> +			NETLINK_CB(skb2).dst_pid = p->pid;		\
>> +			NETLINK_CB(skb2).pid = 0;			\
>> +			return (netlink_unicast(fsevent_sock, skb2,	\
>> +					p->pid, MSG_DONTWAIT));		\
>> +		}							\
>> +		return -1;						\
>> +	}								\
>> +
>> +DEFINE_FILTER_MATCH_FUNC(pid_filter, pid)
>> +
>> +DEFINE_FILTER_MATCH_FUNC(uid_filter, uid)
>> +
>> +DEFINE_FILTER_MATCH_FUNC(gid_filter, gid)
>>     
>
> You send the same data for each type of filters, maybe it is design
> approach, but why don't you want to send that data in one skb?
>   
netlink control block is not the same, netlink_broadcast is a typical case.
>   
>> +#define MATCH_XID(key, listenerp, event, skb) 			\
>> +	ret = match_##key##_filter(listenerp, event, skb); 	\
>> +	if (ret == 0) {					 	\
>> +		kfree_skb(skb);				 	\
>> +	        continue;				 	\
>>     
>
> Your match funtions can not return 0.
>   
It can, if sending is successfull, netlink_unicast will return 0.
>   
>> +	}						 	\
>> +	do {} while (0)					 	\
>> +
>> +static int fsevent_send_to_process(struct sk_buff * skb)
>> +{
>> +	listener * p  = NULL, * q = NULL;
>> +	struct fsevent * event = NULL;
>> +	struct sk_buff * skb2 = NULL;
>> +	int ret = 0;
>> +
>> +	event = (struct fsevent *)(skb->data + sizeof(struct nlmsghdr));
>> +	mutex_lock(&listener_list_mutex);
>> +	list_for_each_entry_safe(p, q, &listener_list_head, list) {
>> +		MATCH_XID(pid, p, event, skb);
>> +		MATCH_XID(uid, p, event, skb);
>> +		MATCH_XID(gid, p, event, skb);
>>     
>
> Khm, you free the same skb three times here if each filter returns 0,
> is it right? I do not see where appropriate reference is grabbed.
>
> Well, since your match functions can not return 0, so it is ok,
> but in this case you do not need a check in MATCH_XID() check.
>   
There are really some issues here, I'll fix it.
>   
>> +		if (filter_fsevent(p->mask, event->type) == 0) {
>> +			 skb2 = skb_clone(skb, GFP_KERNEL);
>> +	                 if (skb2 == NULL)
>> +	                 	return -1;
>> +	                 NETLINK_CB(skb2).dst_group = 0;
>> +	                 NETLINK_CB(skb2).dst_pid = p->pid;
>> +	                 NETLINK_CB(skb2).pid = 0;
>> +	                 ret = netlink_unicast(fsevent_sock, skb2,
>> +	                                p->pid, 0);
>> +			if (ret == -ECONNREFUSED) {
>> +				atomic_dec(&fsevent_listener_num);
>> +				cleanup_dead_listener(p);
>> +			}
>> +		}
>> +	}
>> +	mutex_unlock(&listener_list_mutex);
>> +	return ret;
>> +}
>> +
>> +static void fsevent_commit(void * unused)
>> +{
>> +	struct sk_buff * skb = NULL;
>> +		
>> +	while((skb = skb_dequeue(&get_cpu_var(fsevent_send_queue)))
>> +		!= NULL) {
>> +		fsevent_send_to_process(skb);
>> +		kfree_skb(skb);
>> +		put_cpu_var(fsevent_send_queue);
>> +	}
>> +}
>> +
>> +static struct ctl_table fsevent_mask_sysctl[] = {
>> +	{
>> +		.ctl_name = FSEVENT_MASK_CTL_NAME,
>> +		.procname = "fsevent_mask",
>> +		.data = &fsevents_mask,
>> +		.maxlen = sizeof(u32),
>> +		.mode = 0644,
>> +		.proc_handler = &proc_dointvec,
>> +	},
>> +	{ .ctl_name = 0 }
>> +};
>> +
>> +static struct ctl_table fs_root_sysctl[] = {
>> +	{
>> +		.ctl_name = CTL_FS,
>> +		.procname = "fs",
>> +		.mode = 0555,
>> +		.child = fsevent_mask_sysctl,
>> +	},
>> +	{ .ctl_name = 0 }
>> +};
>> +
>> +static int __init fsevent_init(void)
>> +{
>> +	int cpu;
>> +	struct sk_buff_head * listptr;
>> +	struct work_struct * workptr;
>> +
>> +	fsevent_sock = netlink_kernel_create(NETLINK_FSEVENT, 0,
>> +					 fsevent_recv, THIS_MODULE);
>> +	if (!fsevent_sock)
>> +		return -EIO;
>> +	for_each_cpu(cpu) {
>> +		listptr = &per_cpu(fsevent_send_queue, cpu);
>> +		skb_queue_head_init(listptr);
>> +		workptr = &per_cpu(fsevent_work, cpu);
>> +		INIT_WORK(workptr, fsevent_commit, NULL);
>> +	}
>> +
>> +	if (register_sysctl_table(fs_root_sysctl, 0) == NULL)
>> +                return -ENOMEM;
>> +
>> +	_raise_fsevent = __raise_fsevent;
>> +
>> +	return 0;
>> +}
>> +
>> +static void __exit fsevent_exit(void)
>> +{
>> +	listener * p = NULL, * q = NULL;
>> +	int cpu;
>> +	int wait_flag = 0;
>> +	struct sk_buff_head * skb_head = NULL;
>> +
>> +	fsevents_mask = 0;
>> +	_raise_fsevent = 0;
>> +	exit_flag = 1;
>> +
>> +	for_each_cpu(cpu)
>> +		schedule_work(&per_cpu(fsevent_work, cpu));
>> +
>> +	while (1) {
>> +		wait_flag = 0;
>> +		for_each_cpu(cpu) {
>> +			skb_head = &per_cpu(fsevent_send_queue, cpu);
>> +			if (skb_head->qlen != 0) {
>> +				wait_flag = 1;
>> +				break;
>> +			}
>> +		}
>> +		if (wait_flag == 1) {
>> +			set_current_state(TASK_INTERRUPTIBLE);
>> +			schedule_timeout(HZ/10);
>> +		} else
>> +			break;
>> +	}
>>     
>
> This is still broken.
> You race with schedule_work() in this loop. It requires
> flush_scheduled_work().
>
> And I still have soume doubts about __raise_fsevent().
> What if you set fsevents_mask to zero after __raise_fsevent() is
> started, but not yet queued an skb, and above loop and scheduled work
> are completed?
>   
I think it  is OK, schedule_timeout will release cpu to work queues, 
work queues should have enough time
to finish their works, I don't know what is your reason.
> You need some type of completion of the last worker...
>
>   
>> +	atomic_set(&fsevent_sock->sk_rmem_alloc, 0);
>> +	atomic_set(&fsevent_sock->sk_wmem_alloc, 0);
>>     
>
> This is really wrong, since it hides skb processing errors like double
> freeing or leaks.
>   
If userspace application terminated exceptionally, there are some skbs 
not to be consumed on socket, so
if you rmmod it, sock_release will report some failure information, the 
above two statements will remove this
error.
>   
>> +	sock_release(fsevent_sock->sk_socket);
>> +	mutex_lock(&listener_list_mutex);
>> +	list_for_each_entry_safe(p, q, &listener_list_head, list) {
>> +		cleanup_dead_listener(p);
>> +	}
>> +	mutex_unlock(&listener_list_mutex);
>> +}
>> +
>> +module_init(fsevent_init);
>> +module_exit(fsevent_exit);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Yi Yang <yang.y.yi@gmail.com>");
>> +MODULE_DESCRIPTION("File System Events Reporter");
>> --- /dev/null	2003-01-30 18:24:37.000000000 +0800
>> +++ b/fs/fsevent_hook.c	2006-04-08 22:01:30.000000000 +0800
>> @@ -0,0 +1,5 @@
>> +#include <linux/fsevent.h>
>> +
>> +int (* _raise_fsevent)
>> +        (const char * oldname, const char * newname, u32 mask) = 0;
>> +EXPORT_SYMBOL(_raise_fsevent);
>>     
>
> Well, this is a hack :)
>
>
> Btw, it would be nice to have some kind of microbenchmark,
> like http://permalink.gmane.org/gmane.linux.kernel/292755
> just to see how things go...
>   
I have a userspace application to test fsevent, I'll release it to 
community in order to find more issues on
fsevent.

