Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWHWIvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWHWIvh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWHWIvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:51:37 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:54207 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S964791AbWHWIvg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:51:36 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [take12 1/3] kevent: Core files.
Date: Wed, 23 Aug 2006 10:51:36 +0200
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>
References: <115615558935@2ka.mipt.ru>
In-Reply-To: <115615558935@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608231051.37089.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Evgeniy

I have one comment/suggestion (minor detail, your work is very good)

I suggest to add one item in kevent_registered_callbacks[], so that 
kevent_registered_callbacks[KEVENT_MAX] is valid and can act as a fallback.

In kevent_add_callbacks() you could replace the eventual NULL pointers by 
kevent_break() in 
kevent_registered_callbacks[pos].{callback, enqueue, dequeue}
like :

+int kevent_add_callbacks(const struct kevent_callbacks *cb, unsigned int pos)
+{
+	struct kevent_callbacks *p = &kevent_registered_callbacks[pos];
+       if (pos >= KEVENT_MAX)
+               return -EINVAL;
+      p->enqueue = (cb->enqueue) ? cb->enqueue : kevent_break;
+      p->dequeue = (cb->dequeue) ? cb->dequeue : kevent_break;
+      p->callback = (cb->callback) ? cb->callback : kevent_break;
+       printk(KERN_INFO "KEVENT: Added callbacks for type %u.\n", pos);
+       return 0;
+}

(I also added a const qualifier in first function argument, and unsigned int 
pos so that the "if (pos >= KEVENT_MAX)" test catches 'negative' values)

Then you change kevent_break() to return -EINVAL instead of 0.

+int kevent_break(struct kevent *k)
+{
+       unsigned long flags;
+
+       spin_lock_irqsave(&k->ulock, flags);
+       k->event.ret_flags |= KEVENT_RET_BROKEN;
+       spin_unlock_irqrestore(&k->ulock, flags);
+       return -EINVAL;
+}

Then avoid the tests in kevent_enqueue()

+int kevent_enqueue(struct kevent *k)
+{
+       return k->callbacks.enqueue(k);
+}

And avoid the tests in  kevent_dequeue()

+int kevent_dequeue(struct kevent *k)
+{
+       return k->callbacks.dequeue(k);
+}

And change kevent_init() to

+int kevent_init(struct kevent *k)
+{
+       spin_lock_init(&k->ulock);
+       k->flags = 0;
+
+       if (unlikely(k->event.type >= KEVENT_MAX))
+               k->event.type = KEVENT_MAX;
+	 
+
+       k->callbacks = kevent_registered_callbacks[k->event.type];
+       if (unlikely(k->callbacks.callback == kevent_break))
+               return kevent_break(k);
+
+       return 0;
+}



Eric Dumazet
