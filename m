Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161218AbWJDPPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161218AbWJDPPP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 11:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161219AbWJDPPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 11:15:14 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:40520 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161218AbWJDPPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 11:15:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=RNJpIDbLoRGezVUSPEFOdGalX7FIvdRtBCdew/5wHJG7sqP08Or4mNnLUDOwGkdWIb+rxO8dmumcXLghrHtoefL7ogwqVRxSRvu60cePN3dXDDv7NMb7LkPoRdagjRZqCexY80RZJkogUOhvAI7qvX7ea+KIvef/AqRl2wDjSIw=
Message-ID: <4523D01F.6030202@gmail.com>
Date: Wed, 04 Oct 2006 23:15:43 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       matthltc@us.ibm.com
Subject: Re: [2.6.18 PATCH]: Filesystem Event Reporter V4
References: <451E8C47.6090407@gmail.com> <20061003164727.GA1804@2ka.mipt.ru>
In-Reply-To: <20061003164727.GA1804@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov 写道:
> Hello.
>
> On Sat, Sep 30, 2006 at 11:24:55PM +0800, Yi Yang (yang.y.yi@gmail.com) wrote:
>   
>> This patch implements a new feature -- Filesystem Event Reporter, the user
>>  can monitor filesystem activities via it, currently, it can monitor access, 
>> write, utime, chmod, chown, chgrp, close, open, create, rename, unlink, mkdir,
>>  rmdir, mount, umount.
>>     
>
> With each new version you add more features, but it seems that code is
> racy in some places. I've some comments after quite look.
>   
Thank for your careful review, I'll check them and send a new version.
>> +extern int * get_fsevent_refcnt(void);
>> +extern void put_fsevent_refcnt(void);
>> +extern int per_cpu_fsevent_refcnt(int cpu);
>> +extern void init_fsevent_refcnt(int cpu);
>> +extern void init_missed_fsevent_refcnt(int cpu);
>> +extern atomic_t * per_cpu_missed_refcnt(int cpu);
>>     
>
> This protects against nothing, since there are now correct reference
> counters.
>   
Maybe you misunderstand them, new-added reference will synchronize rmmod,
you know there are possibly some processes using raise_fsevent hook when a
user rmmods fsevent, if just set raise_fsevent to NULL, the kernel will 
panic
because fsevent is released but some processes need to refer to it. 
Andrew thinks
any lock operation shouldn't be involved in filesytem code path, so 
reference count
per cpu is a good choice, the principle behind it is any process will 
increase reference
count of calling raise_fsevent before it is ready for calling 
raise_fsevent and decrease
that reference count after finishing the call, the process scheduler 
possibly
migrate a raise_fsevent caller process from current cpu to another cpu 
because of
workload balance, so for the process migration case, reference count 
won't work well,
I added another reference count -- missed_refcnt which records this kind 
of migration.

when a user rmmods fsevent, the work kthread per cpu will check that 
reference count, if it is zero,
the work kthread can ensure there is not any process on this cpu using 
raise_fsevent, so
fsevent can be rmmoded on this cpu, if current reference count is equal 
to missed_refcnt
, fsevent can also decide it can exit safely, because that also means 
there is not any process
on this cpu using raise_fsevent, otherwise, the work kthread must yield 
the cpu and let the
process using raise_fsevent progress until any one of the above two 
cases happens.

In fact, the new code in this version just implement the rmmod 
synchronization, I spend much
time working out this solution, it is really hard a bit not to use any 
lock to implement it. :)
>   
>> +static inline void get_seq(__u32 *ts, int *cpu)
>> +{
>> +	*ts = atomic_inc_return(&fsevent_count);
>> +	*cpu = smp_processor_id();
>> +}
>>     
>
> Only correct if you call it with disabled preemption.
>   
Yes, you're right, I'll change it.
>> +static int filter_fsevent_all(u32 * mask)
>> +{
>> +	int ret = 0;
>> +
>> +	(*mask) &= FSEVENT_MASK;
>> +
>> +	if ((((*mask) & FSEVENT_ISDIR) == FSEVENT_ISDIR)
>> +		 && ((fsevents_mask & FSEVENT_ISDIR) == 0)) {
>> +		ret = -1;
>> +		goto out;
>> +	}
>> +
>> +	(*mask) &= fsevents_mask;
>> +	if ((*mask) == 0) {
>> +		ret = -1;
>> +	}
>> +
>> +out:
>> +	return ret;
>> +}
>>     
>
> This function is called in the context which allows to change
> @fsevents_mask, so it is racy.
>   
Yes, to avoid atomic or lock operation is not easy. :)
>> +
>> +	get_seq(&(nlhdr->nlmsg_seq), &event->cpu);
>> +	ktime_get_ts(&event->timestamp);
>>     
>
> This timestamp has different size on 32 and 64 bit platforms, so you can
> not use it for example on x86_64.
>   
Thank you, I'll change it.
>   
>> +	event->type = mask;
>> +	event->pid = current->tgid;
>> +	event->uid = current->uid;
>> +	event->gid = current->gid;
>> +	nameptr = event->name;
>> +	event->pname_len = strlen(current->comm);
>> +	append_string(&nameptr, current->comm, event->pname_len);
>> +	event->fname_len = strlen(oldname);
>> +	append_string(&nameptr, oldname, event->fname_len);
>> +	event->len = event->pname_len +  event->fname_len + 2;
>> +	event->new_fname_len = 0;
>> +	if (newname) {
>> +		event->new_fname_len = strlen(newname);
>> +		append_string(&nameptr, newname, event->new_fname_len);
>> +		event->len += event->new_fname_len + 1;
>> +	}
>> +	fsevent_send(skb);
>> +	return 0;
>>     
>
> A lot of strlen() slows code down noticebly.
>   
Yes, I should use it once and saves it to a variable.
>> +	event->fname_len = 0;
>> +	event->new_fname_len = 0;
>> +	event->err = 0;
>> +	                                                                                                                                       
>> +	NETLINK_CB(skb).dst_group = 0;
>> +	NETLINK_CB(skb).dst_pid = pid;
>> +	NETLINK_CB(skb).pid = 0;
>> +
>> +	return (netlink_unicast(fsevent_sock, skb, pid, MSG_DONTWAIT));
>>     
>
> You can lose acks. If you do care about them you need some kind of ack
> sequence number.
>   
Good, I'll consider it.
>> +
>> +	while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {
>> +		skb_get(skb);
>> +		if (skb->len >= FSEVENT_FILTER_MSGSIZE) {
>> +			nlhdr = (struct nlmsghdr *)skb->data;
>> +			filter = NLMSG_DATA(nlhdr);
>> +			pid = NETLINK_CREDS(skb)->pid;
>> +			if (find_fsevent_listener(pid) == NULL)
>> +				inc_flag = 1;
>> +			if (set_fsevent_filter(filter, pid) == 0) {
>> +				if (inc_flag == 1)
>> +					atomic_inc(&fsevent_listener_num);
>> +			}
>> +	
>> +		}
>> +		kfree_skb(skb);
>>     
>
> You leak skb here, no need to grab it's reference counter above.
>   
You're right, I should remove skb_get();
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
>> +				return -1;				\
>> +			NETLINK_CB(skb2).dst_group = 0;			\
>> +			NETLINK_CB(skb2).dst_pid = p->pid;		\
>> +			NETLINK_CB(skb2).pid = 0;			\
>> +			return (netlink_unicast(fsevent_sock, skb2,	\
>> +					p->pid, MSG_DONTWAIT));		\
>>     
>
> You reinvent netlink_broadcast() in some way...
>   
Because pids of the destination processes are unknow before tranversing 
the fsevent filter list,
and every fsevent just is sent to those process which are intereted in 
it, any other process shouldn't
receive a fsevent it aren't intereted in.
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
>> +
>> +		if (filter_fsevent(p->mask, event->type) == 0) {
>> +			 skb2 = skb_clone(skb, GFP_KERNEL);
>> +	                 if (skb2 == NULL)
>> +	                 	return -1;
>>     
>
> Mutex is not unlocked.
>   
Yes, I missed it before "return -1", I'll change it.
>   
>> +	                 NETLINK_CB(skb2).dst_group = 0;
>> +	                 NETLINK_CB(skb2).dst_pid = p->pid;
>> +	                 NETLINK_CB(skb2).pid = 0;
>> +	                 ret = netlink_unicast(fsevent_sock, skb2,
>> +	                                p->pid, 0);
>>     
>
> Btw, pid in netlink messages should not be considered as 'process id' of
> the sending process. Processes can be changed, but pid will be the same.
>   
I don't understand your comment, do you mean the other id can identify 
the sender of
fsevent correctly, that a pid is used again will take a very long time, 
I think pid can identify
a fsevent sender process, can you explain your comment more detailded?
>> +static void fsevent_commit(void * unused)
>> +{
>> +	struct sk_buff * skb = NULL;
>> +	int * refcnt, missed_refcnt;
>> +	int cpuid;
>> +
>> +		
>> +	while((skb = skb_dequeue(&get_cpu_var(fsevent_send_queue)))
>> +		!= NULL) {
>> +		fsevent_send_to_process(skb);
>> +		kfree_skb(skb);
>> +		put_cpu_var(fsevent_send_queue);
>> +	}
>> +
>> +	if (exit_flag == 1) {
>> +		refcnt = get_fsevent_refcnt();
>>     
>
> What prevents from adding another skb into the queue between above loop
> and check for flag?
>   
before adding a fsevent to the queue, a process will check exit_flag, if 
it is set to 1, that
process won't queue the fsevent and return immediately.
>   
>> +		if (*refcnt <= 0) {
>> +			*refcnt = -1;
>> +			put_fsevent_refcnt();
>> +			return;
>> +		}
>> +		cpuid = smp_processor_id();
>> +
>> +		missed_refcnt = atomic_read(per_cpu_missed_refcnt(cpuid));
>> +		if (missed_refcnt == *refcnt)
>> +		{
>> +			*refcnt = -1;
>> +			printk("cpu#%d: missed refcnt = %d\n", cpuid, missed_refcnt);
>> +		}
>> +		else {
>> +			if (missed_refcnt != 0) {
>> +				printk("cpu#%d: refcnt = %d, missed refcnt = %d\n", cpuid, *refcnt, missed_refcnt);
>> +			}
>> +		}
>>     
>
> Above operation seems racy, what prevents from changing missed_refcnt
> after it was read?
>   
if the case you said is hit, missed_refcnt must be not equal to 
missed_refcnt, because they are for the same cpu, so no problem, it will 
be checked
in the next work schedule.
>> +static void __exit fsevent_exit(void)
>> +{
>> +	listener * p = NULL, * q = NULL;
>> +	int cpu;
>> +	int wait_flag = 1;
>> +	struct sk_buff * skb = NULL;
>> +
>> +	fsevents_mask = 0;
>> +	exit_flag = 1;
>> +
>> +	while (wait_flag == 1) {
>> +		wait_flag = 0;
>> +		for_each_possible_cpu(cpu) {
>> +			if (per_cpu_fsevent_refcnt(cpu) >= 0) {
>>     
>
> This check is racy against above checks (marked as racy in comments).
>   
No problem, the real processing is within the work kthread, that will 
avoid this.
>   
>> +				wait_flag = 1;
>> +				schedule_work(&per_cpu(fsevent_work, cpu));
>> +			}
>> +		}
>> +		flush_scheduled_work();
>> +	}
>> +	__raise_fsevent = 0;
>> +
>> +	while ((skb = skb_dequeue(&fsevent_sock->sk_receive_queue)) != NULL) {
>> +		kfree_skb(skb);
>> +	}
>> +	while ((skb = skb_dequeue(&fsevent_sock->sk_write_queue)) != NULL) {
>> +		kfree_skb(skb);
>> +	}
>>     
>
> Why are you doing this? It looks wrong, since socket's queue is cleaned
> automatically.
>   
When I release fsevent_sock, the kernel always printk a message which 
says "sk_rmem_alloc isn't zero",
I don't know why, I doubt there are some packets in recieve and write 
queue, so try to free them.
but sk_rmem_alloc is always non-zero, so I must set it to 0, the kernel 
doesn't printk.
>   
>> +	printk("sk_rmem_alloc=%d, sk_wmem_alloc=%d\n", 
>> +		atomic_read(&fsevent_sock->sk_rmem_alloc),
>> +		atomic_read(&fsevent_sock->sk_wmem_alloc));
>> +	atomic_set(&fsevent_sock->sk_rmem_alloc, 0);
>> +	atomic_set(&fsevent_sock->sk_wmem_alloc, 0);
>>     
>
> 100 % broken - you should not look into that variables, if kernel prints
> assertions about sizes, that means either leaked skbs or double
> freeings.
>   
Can you tell me when sk_rmem_alloc will increase and when it will 
decrease? How to
check whether the skb leakage or double free happened? When I test this, 
sk_rmem_alloc
is always 888, I don't understand it.
>> +
>> +void init_fsevent_refcnt(int cpu)
>> +{
>> +	int * refcnt = &per_cpu(raise_fsevent_refcnt, cpu);
>> +	*refcnt = 0;
>> +}
>> +EXPORT_SYMBOL(init_fsevent_refcnt);
>>     
>
> This is racy.
>   
This doesn't take effect in the normal processing, the work kthread will 
do the real
work which will ensure no racy.
>   
>> +void init_missed_fsevent_refcnt(int cpu)
>> +{
>> +	atomic_t * missed_refcnt = &per_cpu(missed_fsevent_refcnt, cpu);
>> +	
>> +	atomic_set(missed_refcnt, 0);
>> +}
>> +EXPORT_SYMBOL(init_missed_fsevent_refcnt);
>> +
>> +atomic_t * per_cpu_missed_refcnt(int cpu)
>> +{
>> +	return &per_cpu(missed_fsevent_refcnt, cpu);
>> +}
>>     
>
> Racy.
>   
See the above comments
>> +
>> +struct fsevent_filter {
>> +	/* filter type, it just is one of them
>> +	 * FSEVENT_FILTER_ALL
>> +	 * FSEVENT_FILTER_PID
>> +	 * FSEVENT_FILTER_UID
>> +	 * FSEVENT_FILTER_GID
>> +	 */
>> +	enum fsevent_type type;	/* filter type */
>> +
>> +	/* mask of file system events the user listen or ignore
>> +	 * if the user need to ignore all the events of some pid
>> +	 * , gid or uid, he(she) must set mask to FSEVENT_MASK.
>> +	 */ 
>> +	fsevent_mask_t mask;
>>     
>
> This is wrong, since it has different size on 64 and 32 platforms.
>   
thanks, I'll check it.
>   
>> +	union {
>> +		pid_t pid;
>> +		uid_t uid;
>> +		gid_t gid;
>> +	} id;
>> +
>> +	enum filter_control control;
>> +};
>> +
>> +struct fsevent {
>> +	__u32 type;
>> +	__u32 cpu;
>> +	struct timespec timestamp;
>>     
>
> Wrong size.
>   
I don't understand it, can you explain it further?
>> +
>> +static inline int _raise_fsevent
>> +	(const char * oldname, const char * newname, u32 mask)
>> +{
>> +	int ret;
>> +	int * refcnt = NULL;
>> +	int start_cpuid, end_cpuid;
>> +
>> +	refcnt = get_fsevent_refcnt();
>> +	start_cpuid = smp_processor_id();
>> +	if ((*refcnt == -1) || (__raise_fsevent == 0)) {
>> +		put_fsevent_refcnt();
>> +		return -1;
>> +	}
>> +	(*refcnt)++;
>> +	put_fsevent_refcnt();
>>     
>
> This looks really racy.
> What prevents from rescheduling here?
>   
This has disabled the preemption, so it is impossible to reshcedule.
>   
>> +	ret = __raise_fsevent(oldname, newname, mask);
>> +	refcnt = get_fsevent_refcnt();
>> +	end_cpuid = smp_processor_id();
>> +	if (start_cpuid != end_cpuid) {
>> +		printk("fsevent: process '%s' migration: cpu#%d -> cpu#%d.", current->comm, start_cpuid, end_cpuid);
>> +		atomic_inc(per_cpu_missed_refcnt(start_cpuid));
>> +		put_fsevent_refcnt();
>> +		return -1;
>> +	}
>> +	(*refcnt)--;
>> +	put_fsevent_refcnt();
>> +	return ret;
>> +}
>>     
>
> What prevents change for __raise_fsevent in that function?
>   
If reference count is not -1, rmmod won't change __raise_fsevent. the 
key is two new-added
refrence counters.

