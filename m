Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWDGGZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWDGGZL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 02:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWDGGZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 02:25:10 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:6601 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932308AbWDGGZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 02:25:09 -0400
Date: Fri, 7 Apr 2006 10:24:30 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Yi Yang <yang.y.yi@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [2.6.16 PATCH] Filessytem Events Reporter V2
Message-ID: <20060407062428.GA31351@2ka.mipt.ru>
References: <4433C456.7010708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <4433C456.7010708@gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 07 Apr 2006 10:24:33 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 09:21:26PM +0800, Yi Yang (yang.y.yi@gmail.com) wrote:
> Compared with Filesystem Events Reporter v1, the following changes are done:
>   - Use workqueue/keventd instead of kfseventd. 
>   - fsevent_mask can be set by sysctl and proc
>     interface.
>   - Add missed spinlock
>   - Ensure fsevent sequence number is uniqe
> 
> This patch implements a filsystem events report facitily, Filesystem Events
> Reporter, the user can monitor filesystem activities via it, currently, it
>  can monitor access, attribute change, open, create, modify, delete,
>  move and close of any file or directory as well as mount/umount.

Comments below.

...
> +
> +static int fsevent_ack(enum fsevent_type type, pid_t pid, u32 seq)
> +{
> +	struct fsevent *event;
> +	unsigned int size;
> +	struct sk_buff * skb = NULL;
> +	struct nlmsghdr * nlhdr = NULL;
> +
> +	size = NLMSG_SPACE(sizeof(struct fsevent));
> +	                                                                                                                                       
> +	skb = alloc_skb(size, GFP_KERNEL);
> +	if (!skb)
> +	        return -ENOMEM;
> +	                                                                                                                                       
> +	nlhdr = NLMSG_PUT(skb, 0, seq, NLMSG_DONE, size - sizeof(*nlhdr));
> +	event = NLMSG_DATA(nlhdr);
> +
> +	ktime_get_ts(&event->timestamp);
> +	event->cpu = -1;
> +	event->type = type; 
> +	event->pid = 0;
> +	event->uid = 0;
> +	event->gid = 0;
> +	event->len = 0;
> +	event->pname_len = 0;
> +	event->fname_len = 0;
> +	event->new_fname_len = 0;
> +	event->err = 0;
> +	                                                                                                                                       
> +	NETLINK_CB(skb).dst_group = 0;
> +	NETLINK_CB(skb).dst_pid = pid;
> +	NETLINK_CB(skb).pid = 0;
> +
> +	return (netlink_unicast(fsevent_sock, skb, pid, MSG_DONTWAIT));

netlink_unicast() uses boolean value but ont MSG_* flags for nonblocking, 
so this should be netlink_unicast(fsevent_sock, skb, pid, 0);

> +nlmsg_failure:
> +	kfree_skb(skb);
> +	return -1;
> +}

...

> +static void fsevent_recv(struct sock *sk, int len)
> +{
> +	struct sk_buff *skb = NULL;
> +	struct nlmsghdr *nlhdr = NULL;
> +	struct fsevent_filter * filter = NULL;
> +	pid_t pid;
> +
> +	while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {
> +		skb_get(skb);
> +		if (skb->len >= FSEVENT_FILTER_MSGSIZE) {
> +			nlhdr = (struct nlmsghdr *)skb->data;
> +			filter = NLMSG_DATA(nlhdr);
> +			pid = NETLINK_CREDS(skb)->pid;
> +			if (find_fsevent_listener(pid) == NULL)
> +				atomic_inc(&fsevent_listener_num);
> +			set_fsevent_filter(filter, pid);

What is the logic behind this steps?
If there are no listeners you increment it's number no matter if it will
or not be added in set_fsevent_filter().

> +		}
> +		kfree_skb(skb);
> +	}
> +}
> +
> +#define DEFINE_FILTER_MATCH_FUNC(filtertype, key) 			\
> +	static int match_##filtertype(listener * p,			\
> +				struct fsevent * event,			\
> +				struct sk_buff * skb)			\
> +	{								\
> +		int ret = 0;						\
> +		filtertype * xfilter = NULL;				\
> +		struct sk_buff * skb2 = NULL;				\
> +		struct list_head *  head = &(p->key##_filter_list_head);  \
> +		list_for_each_entry(xfilter, head, list) {		\
> +			if (xfilter->key != event->key)			\
> +				continue;				\
> +			ret = filter_fsevent(xfilter->mask, event->type); \
> +			if ( ret != 0)					\
> +				return -1;				\
> +			skb2 = skb_clone(skb, GFP_KERNEL);		\
> +       			if (skb2 == NULL)				\
> +				return -ENOMEM;				\
> +			NETLINK_CB(skb2).dst_group = 0;			\
> +			NETLINK_CB(skb2).dst_pid = p->pid;		\
> +			NETLINK_CB(skb2).pid = 0;			\
> +			return (netlink_unicast(fsevent_sock, skb2,	\
> +					p->pid, MSG_DONTWAIT));		\

The same issue about nonblocking sending.

> +		}							\
> +		return -ENODEV;						\
> +	}								\
> +
> +DEFINE_FILTER_MATCH_FUNC(pid_filter, pid)
> +
> +DEFINE_FILTER_MATCH_FUNC(uid_filter, uid)
> +
> +DEFINE_FILTER_MATCH_FUNC(gid_filter, gid)
> +
> +#define MATCH_XID(key, listenerp, event, skb) 			\
> +	ret = match_##key##_filter(listenerp, event, skb); 	\
> +	if (ret == 0) {					 	\
> +		kfree_skb(skb);				 	\
> +	        continue;				 	\
> +	}						 	\
> +	do {} while (0)					 	\
> +
> +static int fsevent_send_to_process(struct sk_buff * skb)
> +{
> +	listener * p  = NULL, * q = NULL;
> +	struct fsevent * event = NULL;
> +	struct sk_buff * skb2 = NULL;
> +	int ret = 0;
> +
> +	event = (struct fsevent *)(skb->data + sizeof(struct nlmsghdr));
> +	spin_lock(&listener_list_lock);
> +	list_for_each_entry_safe(p, q, &listener_list_head, list) {
> +		MATCH_XID(pid, p, event, skb);
> +		MATCH_XID(uid, p, event, skb);
> +		MATCH_XID(gid, p, event, skb);
> +
> +		if (filter_fsevent(p->mask, event->type) == 0) {
> +			 skb2 = skb_clone(skb, GFP_KERNEL);
> +	                 if (skb2 == NULL)
> +	                 	return -ENOMEM;
> +	                 NETLINK_CB(skb2).dst_group = 0;
> +	                 NETLINK_CB(skb2).dst_pid = p->pid;
> +	                 NETLINK_CB(skb2).pid = 0;
> +	                 ret = netlink_unicast(fsevent_sock, skb2,
> +	                                p->pid, MSG_DONTWAIT);
> +			if (ret == -ECONNREFUSED) {
> +				atomic_dec(&fsevent_listener_num);
> +				cleanup_dead_listener(p);
> +			}
> +		}
> +	}
> +	spin_unlock(&listener_list_lock);
> +	return ret;
> +}
> +
> +static void fsevent_commit(void * unused)
> +{
> +	struct sk_buff * skb = NULL;
> +		
> +	while((skb = skb_dequeue(&get_cpu_var(fsevent_send_queue)))
> +		!= NULL) {
> +		fsevent_send_to_process(skb);
> +		put_cpu_var(fsevent_send_queue);
> +	}
> +}

Really strange mix of per-cpu variables for optimized performance and
global spin locking.
Consider using RCU for list of listeners.

You use unicast delivery for netlink messages. 
According to my investigation [1], it's performance is better only when
there is only one listener (or maybe two in some cases), but then it is
noticebly slower than broadcasting.

1. http://marc.theaimsgroup.com/?l=linux-netdev&m=114424884216006&w=2

> +static struct ctl_table fsevent_mask_sysctl[] = {
> +	{
> +		.ctl_name = FSEVENT_MASK_CTL_NAME,
> +		.procname = "fsevent_mask",
> +		.data = &fsevents_mask,
> +		.maxlen = sizeof(u32),
> +		.mode = 0644,
> +		.proc_handler = &proc_dointvec,
> +	},
> +	{ .ctl_name = 0 }
> +};
> +
> +static struct ctl_table fs_root_sysctl[] = {
> +	{
> +		.ctl_name = CTL_FS,
> +		.procname = "fs",
> +		.mode = 0555,
> +		.child = fsevent_mask_sysctl,
> +	},
> +	{ .ctl_name = 0 }
> +};
> +
> +static int __init fsevent_init(void)
> +{
> +	int cpu;
> +	struct sk_buff_head * listptr;
> +	struct work_struct * workptr;
> +
> +	fsevent_sock = netlink_kernel_create(NETLINK_FSEVENT, 0,
> +					 fsevent_recv, THIS_MODULE);
> +	if (!fsevent_sock)
> +		return -EIO;
> +	for_each_cpu(cpu) {
> +		listptr = &per_cpu(fsevent_send_queue, cpu);
> +		skb_queue_head_init(listptr);
> +		workptr = &per_cpu(fsevent_work, cpu);
> +		INIT_WORK(workptr, fsevent_commit, NULL);
> +	}

Btw, you need some rebalancing of the per-cpu queues, probably in
keventd, since CPUs can go offline and your messages will stuck foreve
there.

> +	if (register_sysctl_table(fs_root_sysctl, 0) == NULL)
> +                return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void __exit fsevent_exit(void)
> +{
> +	listener * p = NULL, * q = NULL;
> +	sock_release(fsevent_sock->sk_socket);
> +	spin_lock(&listener_list_lock);
> +	list_for_each_entry_safe(p, q, &listener_list_head, list) {
> +		cleanup_dead_listener(p);
> +	}
> +	spin_unlock(&listener_list_lock);

Broken. Your work can be pending on this stage, but you already removed
and freed resources.

> +}
> +
> +module_init(fsevent_init);
> +module_exit(fsevent_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Yi Yang <yang.y.yi@gmail.com>");
> +MODULE_DESCRIPTION("File System Events Reporter");
> 

-- 
	Evgeniy Polyakov
