Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWJEJly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWJEJly (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 05:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWJEJly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 05:41:54 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:59881 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751288AbWJEJlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 05:41:52 -0400
Date: Thu, 5 Oct 2006 13:41:16 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Yi Yang <yang.y.yi@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       matthltc@us.ibm.com
Subject: Re: [2.6.18 PATCH]: Filesystem Event Reporter V4
Message-ID: <20061005094114.GD1015@2ka.mipt.ru>
References: <451E8C47.6090407@gmail.com> <20061003164727.GA1804@2ka.mipt.ru> <4523D01F.6030202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <4523D01F.6030202@gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 05 Oct 2006 13:41:17 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 11:15:43PM +0800, Yi Yang (yang.y.yi@gmail.com) wrote:
> >>+extern int * get_fsevent_refcnt(void);
> >>+extern void put_fsevent_refcnt(void);
> >>+extern int per_cpu_fsevent_refcnt(int cpu);
> >>+extern void init_fsevent_refcnt(int cpu);
> >>+extern void init_missed_fsevent_refcnt(int cpu);
> >>+extern atomic_t * per_cpu_missed_refcnt(int cpu);
> >>    
> >
> >This protects against nothing, since there are now correct reference
> >counters.
> >  
> Maybe you misunderstand them, new-added reference will synchronize rmmod,
> you know there are possibly some processes using raise_fsevent hook when a
> user rmmods fsevent, if just set raise_fsevent to NULL, the kernel will 
> panic
> because fsevent is released but some processes need to refer to it. 
> Andrew thinks
> any lock operation shouldn't be involved in filesytem code path, so 
> reference count
> per cpu is a good choice, the principle behind it is any process will 
> increase reference
> count of calling raise_fsevent before it is ready for calling 
> raise_fsevent and decrease
> that reference count after finishing the call, the process scheduler 
> possibly
> migrate a raise_fsevent caller process from current cpu to another cpu 
> because of
> workload balance, so for the process migration case, reference count 
> won't work well,
> I added another reference count -- missed_refcnt which records this kind 
> of migration.

I do not say that they are broken, but you in some places you access per-cpu
variuables without turning preemption off. I think some locking or
preemption tweaks should be done there to explicitly mark critical
regions.

> >>+	                 NETLINK_CB(skb2).dst_group = 0;
> >>+	                 NETLINK_CB(skb2).dst_pid = p->pid;
> >>+	                 NETLINK_CB(skb2).pid = 0;
> >>+	                 ret = netlink_unicast(fsevent_sock, skb2,
> >>+	                                p->pid, 0);
> >>    
> >
> >Btw, pid in netlink messages should not be considered as 'process id' of
> >the sending process. Processes can be changed, but pid will be the same.
> >  
> I don't understand your comment, do you mean the other id can identify 
> the sender of
> fsevent correctly, that a pid is used again will take a very long time, 
> I think pid can identify
> a fsevent sender process, can you explain your comment more detailded?

PID in the netlink message is just identity number, it is not and should
not be considered as 'process id'. You do not know in advance how long
it will take to wrap PIDs, so do not make any assumptions on netlink pid
field at all.

> >>+static void fsevent_commit(void * unused)
> >>+{
> >>+	struct sk_buff * skb = NULL;
> >>+	int * refcnt, missed_refcnt;
> >>+	int cpuid;
> >>+
> >>+		
> >>+	while((skb = skb_dequeue(&get_cpu_var(fsevent_send_queue)))
> >>+		!= NULL) {
> >>+		fsevent_send_to_process(skb);
> >>+		kfree_skb(skb);
> >>+		put_cpu_var(fsevent_send_queue);
> >>+	}
> >>+
> >>+	if (exit_flag == 1) {
> >>+		refcnt = get_fsevent_refcnt();
> >>    
> >
> >What prevents from adding another skb into the queue between above loop
> >and check for flag?
> >  
> before adding a fsevent to the queue, a process will check exit_flag, if 
> it is set to 1, that
> process won't queue the fsevent and return immediately.

But you check for exit_flag in fsevent_commit() without any locks.

> >>+		if (*refcnt <= 0) {
> >>+			*refcnt = -1;
> >>+			put_fsevent_refcnt();
> >>+			return;
> >>+		}
> >>+		cpuid = smp_processor_id();
> >>+
> >>+		missed_refcnt = atomic_read(per_cpu_missed_refcnt(cpuid));
> >>+		if (missed_refcnt == *refcnt)
> >>+		{
> >>+			*refcnt = -1;
> >>+			printk("cpu#%d: missed refcnt = %d\n", cpuid, 
> >>missed_refcnt);
> >>+		}
> >>+		else {
> >>+			if (missed_refcnt != 0) {
> >>+				printk("cpu#%d: refcnt = %d, missed refcnt = 
> >>%d\n", cpuid, *refcnt, missed_refcnt);
> >>+			}
> >>+		}
> >>    
> >
> >Above operation seems racy, what prevents from changing missed_refcnt
> >after it was read?
> >  
> if the case you said is hit, missed_refcnt must be not equal to 
> missed_refcnt, because they are for the same cpu, so no problem, it will 
> be checked
> in the next work schedule.

Since it is called with disabled preemption it is ok, but in that case
you do not need missed_refcnt to be atomic.

> >>+static void __exit fsevent_exit(void)
> >>+{
> >>+	listener * p = NULL, * q = NULL;
> >>+	int cpu;
> >>+	int wait_flag = 1;
> >>+	struct sk_buff * skb = NULL;
> >>+
> >>+	fsevents_mask = 0;
> >>+	exit_flag = 1;
> >>+
> >>+	while (wait_flag == 1) {
> >>+		wait_flag = 0;
> >>+		for_each_possible_cpu(cpu) {
> >>+			if (per_cpu_fsevent_refcnt(cpu) >= 0) {
> >>    
> >
> >This check is racy against above checks (marked as racy in comments).
> >  
> No problem, the real processing is within the work kthread, that will 
> avoid this.
> >  
> >>+				wait_flag = 1;
> >>+				schedule_work(&per_cpu(fsevent_work, cpu));
> >>+			}
> >>+		}
> >>+		flush_scheduled_work();
> >>+	}
> >>+	__raise_fsevent = 0;
> >>+
> >>+	while ((skb = skb_dequeue(&fsevent_sock->sk_receive_queue)) != NULL) 
> >>{
> >>+		kfree_skb(skb);
> >>+	}
> >>+	while ((skb = skb_dequeue(&fsevent_sock->sk_write_queue)) != NULL) {
> >>+		kfree_skb(skb);
> >>+	}
> >>    
> >
> >Why are you doing this? It looks wrong, since socket's queue is cleaned
> >automatically.
> >  
> When I release fsevent_sock, the kernel always printk a message which 
> says "sk_rmem_alloc isn't zero",
> I don't know why, I doubt there are some packets in recieve and write 
> queue, so try to free them.
> but sk_rmem_alloc is always non-zero, so I must set it to 0, the kernel 
> doesn't printk.

That means that you broke socket accounting in some way.
sock_release() should do all cleanup for you.

> >  
> >>+	printk("sk_rmem_alloc=%d, sk_wmem_alloc=%d\n", 
> >>+		atomic_read(&fsevent_sock->sk_rmem_alloc),
> >>+		atomic_read(&fsevent_sock->sk_wmem_alloc));
> >>+	atomic_set(&fsevent_sock->sk_rmem_alloc, 0);
> >>+	atomic_set(&fsevent_sock->sk_wmem_alloc, 0);
> >>    
> >
> >100 % broken - you should not look into that variables, if kernel prints
> >assertions about sizes, that means either leaked skbs or double
> >freeings.
> >  
> Can you tell me when sk_rmem_alloc will increase and when it will 
> decrease? How to
> check whether the skb leakage or double free happened? When I test this, 
> sk_rmem_alloc
> is always 888, I don't understand it.

Each time you add skb into socket queue appropriate socket is charged for 
value equal to sizeof(skb)+sizeof(skb_shared_info)+aligned size of the data.
That number is added to the one of the sk_r/wmem_alloc, depending on the
direction of the skb way, skb's destructor is set to the function which
will remove appropiate amount of from above variables.
When you call sock_release() all skbs are removed and freed, so socket
accounting is corrected in kfree_skb(), which (if there are no users)
calls destructor and frees skb and data.
If you see asserions that above variables are not zero, that means that
you either removed skb from the queue and forgot to free it, or freed it
several times (although it will be likely a crash in this case), or you
overwrote that variables after some memory corruption.

> >>+
> >>+void init_fsevent_refcnt(int cpu)
> >>+{
> >>+	int * refcnt = &per_cpu(raise_fsevent_refcnt, cpu);
> >>+	*refcnt = 0;
> >>+}
> >>+EXPORT_SYMBOL(init_fsevent_refcnt);
> >>    
> >
> >This is racy.
> >  
> This doesn't take effect in the normal processing, the work kthread will 
> do the real
> work which will ensure no racy.

Then just remove it, and actually the whole modularity does not seems a
good idea, although it is of course your decision to make design static
or not. I would implement such things with dynamic registration of the
clients and just make fsevent statically built into the kernel.

> >>+struct fsevent_filter {
> >>+	/* filter type, it just is one of them
> >>+	 * FSEVENT_FILTER_ALL
> >>+	 * FSEVENT_FILTER_PID
> >>+	 * FSEVENT_FILTER_UID
> >>+	 * FSEVENT_FILTER_GID
> >>+	 */
> >>+	enum fsevent_type type;	/* filter type */
> >>+
> >>+	/* mask of file system events the user listen or ignore
> >>+	 * if the user need to ignore all the events of some pid
> >>+	 * , gid or uid, he(she) must set mask to FSEVENT_MASK.
> >>+	 */ 
> >>+	fsevent_mask_t mask;
> >>    
> >
> >This is wrong, since it has different size on 64 and 32 platforms.
> >  
> thanks, I'll check it.
> >  
> >>+	union {
> >>+		pid_t pid;
> >>+		uid_t uid;
> >>+		gid_t gid;
> >>+	} id;
> >>+
> >>+	enum filter_control control;
> >>+};
> >>+
> >>+struct fsevent {
> >>+	__u32 type;
> >>+	__u32 cpu;
> >>+	struct timespec timestamp;
> >>    
> >
> >Wrong size.
> >  
> I don't understand it, can you explain it further?

It has different size on 32 and 64 bit platforms, since it uses longs.
Your application will not work if kernel and userspace has different
size of the long, like can happen with for example x86_64.

> >>+static inline int _raise_fsevent
> >>+	(const char * oldname, const char * newname, u32 mask)
> >>+{
> >>+	int ret;
> >>+	int * refcnt = NULL;
> >>+	int start_cpuid, end_cpuid;
> >>+
> >>+	refcnt = get_fsevent_refcnt();
> >>+	start_cpuid = smp_processor_id();
> >>+	if ((*refcnt == -1) || (__raise_fsevent == 0)) {
> >>+		put_fsevent_refcnt();
> >>+		return -1;
> >>+	}
> >>+	(*refcnt)++;
> >>+	put_fsevent_refcnt();
> >>    
> >
> >This looks really racy.
> >What prevents from rescheduling here?
> >  
> This has disabled the preemption, so it is impossible to reshcedule.

No, put_fsevent_refcnt() andbles it again.
Or is it disabled on higher layer?

> >>+	ret = __raise_fsevent(oldname, newname, mask);
> >>+	refcnt = get_fsevent_refcnt();
> >>+	end_cpuid = smp_processor_id();
> >>+	if (start_cpuid != end_cpuid) {
> >>+		printk("fsevent: process '%s' migration: cpu#%d -> cpu#%d.", 
> >>current->comm, start_cpuid, end_cpuid);
> >>+		atomic_inc(per_cpu_missed_refcnt(start_cpuid));
> >>+		put_fsevent_refcnt();
> >>+		return -1;
> >>+	}
> >>+	(*refcnt)--;
> >>+	put_fsevent_refcnt();
> >>+	return ret;
> >>+}
> >>    
> >
> >What prevents change for __raise_fsevent in that function?
> >  
> If reference count is not -1, rmmod won't change __raise_fsevent. the 
> key is two new-added
> refrence counters.

You do it without preemption disabled and any other locks...

-- 
	Evgeniy Polyakov
