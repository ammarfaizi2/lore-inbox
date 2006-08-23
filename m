Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWHWMvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWHWMvJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 08:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWHWMvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 08:51:09 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:8401 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S932449AbWHWMvG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 08:51:06 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [take13 1/3] kevent: Core files.
Date: Wed, 23 Aug 2006 14:51:06 +0200
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>
References: <11563322971212@2ka.mipt.ru>
In-Reply-To: <11563322971212@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608231451.07499.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again Evgeniy I really begin to like kevent :)

On Wednesday 23 August 2006 13:24, Evgeniy Polyakov wrote:
+struct kevent
+{
+       /* Used for kevent freeing.*/
+       struct rcu_head         rcu_head;
+       struct ukevent          event;
+       /* This lock protects ukevent manipulations, e.g. ret_flags changes. 
*/
+       spinlock_t              ulock;
+
+       /* Entry of user's queue. */
+       struct list_head        kevent_entry;
+       /* Entry of origin's queue. */
+       struct list_head        storage_entry;
+       /* Entry of user's ready. */
+       struct list_head        ready_entry;
+
+       u32                     flags;
+
+       /* User who requested this kevent. */
+       struct kevent_user      *user;
+       /* Kevent container. */
+       struct kevent_storage   *st;
+
+       struct kevent_callbacks callbacks;
+
+       /* Private data for different storages. 
+        * poll()/select storage has a list of wait_queue_t containers 
+        * for each ->poll() { poll_wait()' } here.
+        */
+       void                    *priv;
+};

I wonder if you can reorder fields in this structure, so that 'read mostly' 
fields are grouped together, maybe in a different cache line.
This should help reduce false sharing in SMP.
read mostly fields are (but you know better than me) : callbacks, rcu_head, 
priv, user, event, ...


+#define KEVENT_MAX_EVENTS      4096

Could you please tell me (Forgive me if you already clarified this point) , 
what happens if the number of queued events reaches this value ?


+int kevent_init(struct kevent *k)
+{
+       spin_lock_init(&k->ulock);
+       k->flags = 0;
+
+       if (unlikely(k->event.type >= KEVENT_MAX))
+               return kevent_break(k);
+

As long you are sure we cannot call kevent_enqueue()/kevent_dequeue() after a 
failed kevent_init() it should be fine.

+int kevent_add_callbacks(const struct kevent_callbacks *cb, int pos)
+{
+       struct kevent_callbacks *p;
+       
+       if (pos >= KEVENT_MAX)
+               return -EINVAL;

if a negative pos is used here we might crash. KEVENT_MAX is a signed too, so 
the compare is done on signed values.
If we consider callers always give a sane value, the test can be suppressed.
If we consider callers may be wrong, then we must do a correct test.
If you dont want to change function prototype, then change the test to :

if ((unsigned)pos >= KEVENT_MAX)
              return -EINVAL;

Some people on lkml will prefer:
if (pos < 0 || pos >= KEVENT_MAX)
	return -EINVAL;
or
#define KEVENT_MAX 6U /* unsigned constant */

+static kmem_cache_t *kevent_cache;

You probably want to add __read_mostly here to avoid false sharing.

+static kmem_cache_t *kevent_cache __read_mostly;

Same for other caches :
+static kmem_cache_t *kevent_poll_container_cache;
+static kmem_cache_t *kevent_poll_priv_cache;


About the hash table :

+struct kevent_user
+{
+       struct list_head        kevent_list[KEVENT_HASH_MASK+1];
+       spinlock_t              kevent_lock;

epoll used to use a hash table too (its size was configurable at init time), 
and was converted to a RB-tree for good reasons...(avoid a user to allocate a 
big hash table in pinned memory and DOS)
Are you sure a process handling one million sockets will succeed using kevent 
instead of epoll ?

Do you have a pointer to sample source code using mmap()/kevent interface ? 
It's not clear to me how we can use it (and notice that a full wrap occured, 
user app could miss x*KEVENT_MAX_EVENTS events ?). Do we still must use a 
syscall to dequeue events ?

In particular you state sizeof(mukevent) is 40, while its 12:

+/*
+ * Note that kevents does not exactly fill the page (each mukevent is 40 
bytes),
+ * so we reuse 4 bytes at the begining of the first page to store index.
+ * Take that into account if you want to change size of struct ukevent.
+ */

+struct mukevent
+{
+       struct kevent_id        id;  /* size()=8 */
+       __u32                   ret_flags; /* size()=4 */
+};



Thank you
Eric
