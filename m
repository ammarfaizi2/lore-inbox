Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262555AbVDABbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbVDABbU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 20:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbVDABbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 20:31:20 -0500
Received: from fire.osdl.org ([65.172.181.4]:48310 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262555AbVDABaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 20:30:52 -0500
Date: Thu, 31 Mar 2005 17:30:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org
Subject: connector.c
Message-Id: <20050331173026.3de81a05.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some belated comments...


> 
> module_param(unit, int, 0);
> module_param(cn_idx, uint, 0);
> module_param(cn_val, uint, 0);

MODULE_PARM_DESC needed, please.

> static DEFINE_SPINLOCK(notify_lock);
> static LIST_HEAD(notify_list);
> 
> static struct cn_dev cdev;
> 
> int cn_already_initialized = 0;
> 
> /*
>  * msg->seq and msg->ack are used to determine message genealogy.
>  * When someone sends message it puts there locally unique sequence 
>  * and random acknowledge numbers.
>  * Sequence number may be copied into nlmsghdr->nlmsg_seq too.
>  *
>  * Sequence number is incremented with each message to be sent.
>  *
>  * If we expect reply to our message, 
>  * then sequence number in received message MUST be the same as in original message,
>  * and acknowledge number MUST be the same + 1.
>  *
>  * If we receive message and it's sequence number is not equal to one we are expecting, 
>  * then it is new message.
>  * If we receive message and it's sequence number is the same as one we are expecting,
>  * but it's acknowledge is not equal acknowledge number in original message + 1,
>  * then it is new message.
>  *
>  */

This comment looks crappy in an 80-col xterm.

What happens if we expect a reply to our message but userspace never sends
one?  Does the kernel leak memory?  Do other processes hang?

> void cn_netlink_send(struct cn_msg *msg, u32 __groups)
> {
> 	struct cn_callback_entry *n, *__cbq;
> 	unsigned int size;
> 	struct sk_buff *skb, *uskb;
> 	struct nlmsghdr *nlh;
> 	struct cn_msg *data;
> 	struct cn_dev *dev = &cdev;
> 	u32 groups = 0;
> 	int found = 0;
> 
> 	if (!__groups)
> 	{

Wrong indenting.

> 		spin_lock_bh(&dev->cbdev->queue_lock);
> 		list_for_each_entry_safe(__cbq, n, &dev->cbdev->queue_list, callback_entry) {
> 			if (cn_cb_equal(&__cbq->cb->id, &msg->id)) {
> 				found = 1;
> 				groups = __cbq->group;
> 			}
> 		}
> 		spin_unlock_bh(&dev->cbdev->queue_lock);
> 
> 		if (!found) {
> 			printk(KERN_ERR "Failed to find multicast netlink group for callback[0x%x.0x%x]. seq=%u\n",
> 			       msg->id.idx, msg->id.val, msg->seq);

Needs wrapping.

> 			return;
> 		}
> 	}
> 	else
> 		groups = __groups;
> 
> 	size = NLMSG_SPACE(sizeof(*msg) + msg->len);
> 
> 	skb = alloc_skb(size, GFP_ATOMIC);

GFP_ATOMIC is quite unreliable.  Better to find a way to use GFP_KERNEL here.

> 	if (!skb) {
> 		printk(KERN_ERR "Failed to allocate new skb with size=%u.\n", size);
> 		return;
> 	}

Surely we should return -ENOMEM here?  How is the caller to know that the
send attempt worked?

> 	nlh = NLMSG_PUT(skb, 0, msg->seq, NLMSG_DONE, size - sizeof(*nlh));
> 
> 	data = (struct cn_msg *)NLMSG_DATA(nlh);

Unneeded typecast.

> 	memcpy(data, msg, sizeof(*data) + msg->len);
> #if 0
> 	printk("%s: len=%u, seq=%u, ack=%u, group=%u.\n",
> 	       __func__, msg->len, msg->seq, msg->ack, groups);
> #endif
> 	
> 	NETLINK_CB(skb).dst_groups = groups;
> 
> 	uskb = skb_clone(skb, GFP_ATOMIC);
> 	if (uskb) {
> 		netlink_unicast(dev->nls, uskb, 0, 0);
> 	}

Unneeded {}

> 	netlink_broadcast(dev->nls, skb, 0, groups, GFP_ATOMIC);

GFP_ATOMIC is quite undesirable.

> 
> static int cn_call_callback(struct cn_msg *msg, void (*destruct_data) (void *), void *data)

80 cols

> {
> 	struct cn_callback_entry *n, *__cbq;
> 	struct cn_dev *dev = &cdev;
> 	int found = 0;
> 
> 	spin_lock_bh(&dev->cbdev->queue_lock);
> 	list_for_each_entry_safe(__cbq, n, &dev->cbdev->queue_list, callback_entry) {

80 cols

> 		if (cn_cb_equal(&__cbq->cb->id, &msg->id)) {
> 			__cbq->cb->priv = msg;
> 
> 			__cbq->ddata = data;
> 			__cbq->destruct_data = destruct_data;
> 
> 			queue_work(dev->cbdev->cn_queue, &__cbq->work);
> 			found = 1;
> 			break;
> 		}
> 	}
> 	spin_unlock_bh(&dev->cbdev->queue_lock);
> 
> 	return found;
> }

Why is spin_lock_bh() being used here?

> static int __cn_rx_skb(struct sk_buff *skb, struct nlmsghdr *nlh)
> {
> 	u32 pid, uid, seq, group;
> 	struct cn_msg *msg;
> 
> 	pid = NETLINK_CREDS(skb)->pid;
> 	uid = NETLINK_CREDS(skb)->uid;
> 	seq = nlh->nlmsg_seq;
> 	group = NETLINK_CB((skb)).groups;
> 	msg = (struct cn_msg *)NLMSG_DATA(nlh);
> 
> 	if (NLMSG_SPACE(msg->len + sizeof(*msg)) != nlh->nlmsg_len) {
> 		printk(KERN_ERR "skb does not have enough length: "
> 				"requested msg->len=%u[%u], nlh->nlmsg_len=%u, skb->len=%u.\n",

80 cols (all over the place)

> static void cn_notify(struct cb_id *id, u32 notify_event)
> {
> 	struct cn_ctl_entry *ent;
> 
> 	spin_lock_bh(&notify_lock);
> 	list_for_each_entry(ent, &notify_list, notify_entry) {
> 		int i;
> 		struct cn_notify_req *req;
> 		struct cn_ctl_msg *ctl = ent->msg;
> 		int a, b;
> 
> 		a = b = 0;
> 		
> 		req = (struct cn_notify_req *)ctl->data;
> 		for (i=0; i<ctl->idx_notify_num; ++i, ++req) {

		for (i = 0; i < ctl->idx_notify_num; i++, req++) {

> 			if (id->idx >= req->first && id->idx < req->first + req->range) {
> 				a = 1;
> 				break;
> 			}
> 		}
> 		
> 		for (i=0; i<ctl->val_notify_num; ++i, ++req) {
> 			if (id->val >= req->first && id->val < req->first + req->range) {
> 				b = 1;
> 				break;
> 			}
> 		}
> 
> 		if (a && b) {
> 			struct cn_msg m;
> 			
> 			printk(KERN_INFO "Notifying group %x with event %u about %x.%x.\n", 
> 					ctl->group, notify_event, 
> 					id->idx, id->val);
> 
> 			memset(&m, 0, sizeof(m));
> 			m.ack = notify_event;
> 
> 			memcpy(&m.id, id, sizeof(m.id));
> 			cn_netlink_send(&m, ctl->group);
> 		}

What's all the above code doing?  What do `a' and `b' mean?  Needs
commentary and better-chosen identifiers.

> 	}
> 	spin_unlock_bh(&notify_lock);
> }
> 
> int cn_add_callback(struct cb_id *id, char *name, void (*callback) (void *))
> {
> 	int err;
> 	struct cn_dev *dev = &cdev;
> 	struct cn_callback *cb;
> 
> 	cb = kmalloc(sizeof(*cb), GFP_KERNEL);
> 	if (!cb) {
> 		printk(KERN_INFO "%s: Failed to allocate new struct cn_callback.\n",
> 		       dev->cbdev->name);
> 		return -ENOMEM;
> 	}
> 
> 	memset(cb, 0, sizeof(*cb));
> 
> 	snprintf(cb->name, sizeof(cb->name), "%s", name);

scnprintf?

> 	memcpy(&cb->id, id, sizeof(cb->id));
> 	cb->callback = callback;
> 
> 	atomic_set(&cb->refcnt, 0);
> 
> 	err = cn_queue_add_callback(dev->cbdev, cb);
> 	if (err) {
> 		kfree(cb);
> 		return err;
> 	}
> 			
> 	cn_notify(id, 0);
> 
> 	return 0;
> }
> 
> void cn_del_callback(struct cb_id *id)
> {
> 	struct cn_dev *dev = &cdev;
> 	struct cn_callback_entry *n, *__cbq;
> 
> 	list_for_each_entry_safe(__cbq, n, &dev->cbdev->queue_list, callback_entry) {
> 		if (cn_cb_equal(&__cbq->cb->id, id)) {
> 			cn_queue_del_callback(dev->cbdev, __cbq->cb);
> 			cn_notify(id, 1);
> 			break;
> 		}
> 	}
> }

Doesn't this list walk need locking?

Please document all functions with comments.  Functions which constitute
part of the external API should be commented using the kernel-doc format.

> static void cn_callback(void * data)
> {
> 	struct cn_msg *msg = (struct cn_msg *)data;
> 	struct cn_ctl_msg *ctl;
> 	struct cn_ctl_entry *ent;
> 	u32 size;
>  
> 	if (msg->len < sizeof(*ctl)) {
> 		printk(KERN_ERR "Wrong connector request size %u, must be >= %u.\n", 
> 				msg->len, sizeof(*ctl));
> 		return;
> 	}
> 	
> 	ctl = (struct cn_ctl_msg *)msg->data;
> 
> 	size = sizeof(*ctl) + (ctl->idx_notify_num + ctl->val_notify_num)*sizeof(struct cn_notify_req);
> 
> 	if (msg->len != size) {
> 		printk(KERN_ERR "Wrong connector request size %u, must be == %u.\n", 
> 				msg->len, size);
> 		return;
> 	}
> 
> 	if (ctl->len + sizeof(*ctl) != msg->len) {
> 		printk(KERN_ERR "Wrong message: msg->len=%u must be equal to inner_len=%u [+%u].\n", 
> 				msg->len, ctl->len, sizeof(*ctl));
> 		return;
> 	}
> 
> 	/*
> 	 * Remove notification.
> 	 */
> 	if (ctl->group == 0) {
> 		struct cn_ctl_entry *n;
> 		
> 		spin_lock_bh(&notify_lock);
> 		list_for_each_entry_safe(ent, n, &notify_list, notify_entry) {
> 			if (cn_ctl_msg_equals(ent->msg, ctl)) {
> 				list_del(&ent->notify_entry);
> 				kfree(ent);
> 			}
> 		}
> 		spin_unlock_bh(&notify_lock);
> 
> 		return;
> 	}
> 
> 	size += sizeof(*ent);
> 
> 	ent = kmalloc(size, GFP_ATOMIC);

Another GFP_ATOMIC :(  In what context can this function be called?

> 	{
> 		int i;
> 		struct cn_notify_req *req;

May as well move these up to the top of the function, save the ugly indent.

> 		printk("Notify group %x for idx: ", ctl->group);
> 
> 		req = (struct cn_notify_req *)ctl->data;
> 		for (i=0; i<ctl->idx_notify_num; ++i, ++req) {
> 			printk("%u-%u ", req->first, req->first+req->range-1);
> 		}

Unneeded braces.

This file is full of trailing whitespace, btw.  Please fix that up, then
find a new editor.

> 		printk("\nNotify group %x for val: ", ctl->group);
> 
> 		for (i=0; i<ctl->val_notify_num; ++i, ++req) {
> 			printk("%u-%u ", req->first, req->first+req->range-1);
> 		}

Braces.


