Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262364AbSJOFK1>; Tue, 15 Oct 2002 01:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262365AbSJOFK1>; Tue, 15 Oct 2002 01:10:27 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:47755 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262364AbSJOFKX>; Tue, 15 Oct 2002 01:10:23 -0400
From: "David Stevens" <dlstevens@us.ibm.com>
Importance: Normal
Sensitivity: 
Subject: [PATCH] Re: [PATCH] async poll for 2.5
To: jgmyers@netscape.com (John Myers)
Cc: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       Ben LaHaise <bcrl@redhat.com>, David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF3A9B0975.898CCB55-ON88256C53.00196AF8@boulder.ibm.com>
Date: Mon, 14 Oct 2002 22:15:48 -0700
X-MIMETrack: Serialize by Router on D03NM035/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 10/14/2002 11:15:58 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


John Myers wrote:
>Shailabh Nagar wrote:
>
>> Thepatch has been tested on 2.5.41 using simple poll tests.
>
>Your patch has numerous races, a kiocb leak, and incorrectly calls
>aio_complete() upon cancellation.  Please see the patch I sent to
>linux-aio@kvack.org on September 29.

John,
      As you are aware, but some on the list may not be, the bugs
you mentioned were in the original 2.4.19 code. The patch was just
a port of that code as it was, but it didn't include the fixes you
submitted on Sep. 29th.
      I've looked at the patch to Ben's code you submitted on Sep 29th,
and I've incorporated the async_poll-relevant portions in the patch below,
relative to 2.5.42. This patch also includes the EAGAIN fix Mingming Cao
posted earlier
today.

                                    +-DLS

diff -ruN linux-2.5.42/fs/aio.c linux-2.5.42AIO/fs/aio.c
--- linux-2.5.42/fs/aio.c     Fri Oct 11 21:22:07 2002
+++ linux-2.5.42AIO/fs/aio.c  Mon Oct 14 19:39:31 2002
@@ -63,6 +63,8 @@

 static void aio_kick_handler(void *);

+int async_poll(struct kiocb *iocb, int events);
+
 /* aio_setup
  *   Creates the slab caches used by the aio routines, panic on
  *   failure as this is done early during the boot sequence.
@@ -414,9 +416,9 @@
            req->ki_user_obj = NULL;
            req->ki_ctx = ctx;
            req->ki_users = 1;
+           okay = 1;
      } else {
            kmem_cache_free(kiocb_cachep, req);
-           okay = 1;
      }
      kunmap_atomic(ring, KM_USER0);
      spin_unlock_irq(&ctx->ctx_lock);
@@ -992,6 +994,19 @@
      return -EINVAL;
 }

+ssize_t generic_aio_poll(struct file *file, struct kiocb *req, struct iocb *iocb)
+{
+     unsigned events = iocb->aio_buf;
+
+     /* Did the user set any bits they weren't supposed to? (The
+      * above is actually a cast.
+      */
+     if (unlikely(events != iocb->aio_buf))
+           return -EINVAL;
+
+     return async_poll(req, events);
+}
+
 static int FASTCALL(io_submit_one(struct kioctx *ctx, struct iocb *user_iocb,
                          struct iocb *iocb));
 static int io_submit_one(struct kioctx *ctx, struct iocb *user_iocb,
@@ -1078,6 +1093,9 @@
            if (file->f_op->aio_fsync)
                  ret = file->f_op->aio_fsync(req, 0);
            break;
+     case IOCB_CMD_POLL:
+           ret = generic_aio_poll(file, req, iocb);
+           break;
      default:
            dprintk("EINVAL: io_submit: no operation provided\n");
            ret = -EINVAL;
diff -ruN linux-2.5.42/fs/select.c linux-2.5.42AIO/fs/select.c
--- linux-2.5.42/fs/select.c  Fri Oct 11 21:21:04 2002
+++ linux-2.5.42AIO/fs/select.c     Mon Oct 14 19:37:40 2002
@@ -20,6 +20,8 @@
 #include <linux/personality.h> /* for STICKY_TIMEOUTS */
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/aio.h>
+#include <linux/init.h>

 #include <asm/uaccess.h>

@@ -27,19 +29,34 @@
 #define DEFAULT_POLLMASK (POLLIN | POLLOUT | POLLRDNORM | POLLWRNORM)

 struct poll_table_entry {
-     struct file * filp;
      wait_queue_t wait;
      wait_queue_head_t * wait_address;
+     struct file * filp;
+     poll_table *p;
 };

 struct poll_table_page {
+     unsigned long size;
      struct poll_table_page * next;
      struct poll_table_entry * entry;
      struct poll_table_entry entries[0];
 };

 #define POLL_TABLE_FULL(table) \
-     ((unsigned long)((table)->entry+1) > PAGE_SIZE + (unsigned long)(table))
+     ((unsigned long)((table)->entry+1) > \
+      (table)->size + (unsigned long)(table))
+
+/* async poll uses only one entry per poll table as it is linked to an iocb */
+typedef struct async_poll_table_struct {
+     poll_table        pt;
+     int               events;           /* event mask for async poll */
+     int               wake;
+     long              sync;
+     struct poll_table_page  pt_page;    /* one poll table page hdr */
+     struct poll_table_entry entries[1]; /* space for a single entry */
+} async_poll_table;
+
+static kmem_cache_t *async_poll_table_cache;

 /*
  * Ok, Peter made a complicated, but straightforward multiple_wait() function.
@@ -53,8 +70,7 @@
  * as all select/poll functions have to call it to add an entry to the
  * poll table.
  */
-
-void poll_freewait(poll_table* pt)
+void __poll_freewait(poll_table* pt, wait_queue_t *wait)
 {
      struct poll_table_page * p = pt->table;
      while (p) {
@@ -62,15 +78,140 @@
            struct poll_table_page *old;

            entry = p->entry;
+           if (entry == p->entries) /* may happen with async poll */
+                 break;
            do {
                  entry--;
-                 remove_wait_queue(entry->wait_address,&entry->wait);
+                 if (wait != &entry->wait)
+                       remove_wait_queue(entry->wait_address,&entry->wait);
+                 else
+                       __remove_wait_queue(entry->wait_address,&entry->wait);
                  fput(entry->filp);
            } while (entry > p->entries);
            old = p;
            p = p->next;
-           free_page((unsigned long) old);
+           if (old->size == PAGE_SIZE)
+                 free_page((unsigned long) old);
+     }
+     if (pt->iocb)
+           kmem_cache_free(async_poll_table_cache, pt);
+}
+
+void poll_freewait(poll_table* pt)
+{
+     __poll_freewait(pt, NULL);
+}
+
+void async_poll_complete(void *data)
+{
+     async_poll_table *pasync = data;
+     poll_table *p = data;
+     struct kiocb      *iocb = p->iocb;
+     unsigned int      mask;
+
+     pasync->wake = 0;
+     wmb();
+     do {
+           mask = iocb->ki_filp->f_op->poll(iocb->ki_filp, p);
+           mask &= pasync->events | POLLERR | POLLHUP;
+           if (mask) {
+                 poll_table *p2 = xchg(&iocb->ki_data, NULL);
+                 if (p2) {
+                       poll_freewait(p2);
+                       aio_complete(iocb, mask, 0);
+                 }
+                 return;
+           }
+           pasync->sync = 0;
+           wmb();
+     } while (pasync->wake);
+}
+
+static int async_poll_waiter(wait_queue_t *wait, unsigned mode, int sync)
+{
+     struct poll_table_entry *entry = (struct poll_table_entry *)wait;
+     async_poll_table *pasync = (async_poll_table *)(entry->p);
+     struct kiocb      *iocb;
+     unsigned int      mask;
+
+     iocb = pasync->pt.iocb;
+     mask = iocb->ki_filp->f_op->poll(iocb->ki_filp, NULL);
+     mask &= pasync->events | POLLERR | POLLHUP;
+     if (mask) {
+           poll_table *p2 = xchg(&iocb->ki_data, NULL);
+           if (p2) {
+                 __poll_freewait(p2, wait);
+                 aio_complete(iocb, mask, 0);
+                 return 1;
+           }
      }
+     return 0;
+}
+
+int async_poll_cancel(struct kiocb *iocb, struct io_event *res)
+{
+     poll_table *p;
+
+     p = xchg(&iocb->ki_data, NULL);
+     aio_put_req(iocb);
+     if (p) {
+           poll_freewait(p);
+           /*
+            * Since poll_freewait() locks the wait queue, we know that
+            * async_poll_waiter() is either not going to be run or has
+            * finished all its work.
+            */
+           aio_put_req(iocb);
+           return 0;
+     }
+     return -EAGAIN;
+}
+
+int async_poll(struct kiocb *iocb, int events)
+{
+     unsigned int mask;
+     async_poll_table *pasync;
+     poll_table *p;
+
+     /* Fast path */
+     if (iocb->ki_filp->f_op && iocb->ki_filp->f_op->poll) {
+           mask = iocb->ki_filp->f_op->poll(iocb->ki_filp, NULL);
+           mask &= events | POLLERR | POLLHUP;
+           if (mask & events)
+                 return events;
+     }
+
+     pasync = kmem_cache_alloc(async_poll_table_cache, SLAB_KERNEL);
+     if (!pasync)
+           return -ENOMEM;
+
+     p = (poll_table *)pasync;
+     poll_initwait(p);
+     p->iocb = iocb;
+     pasync->wake = 0;
+     pasync->sync = 0;
+     pasync->events = events;
+     pasync->pt_page.entry = pasync->pt_page.entries;
+     pasync->pt_page.size = sizeof(pasync->pt_page) + sizeof(pasync->entries);
+     pasync->pt_page.next = 0;
+     p->table = &pasync->pt_page;
+
+     iocb->ki_data = p;
+     iocb->ki_users++;
+     wmb();
+
+     mask = DEFAULT_POLLMASK;
+     if (iocb->ki_filp->f_op && iocb->ki_filp->f_op->poll)
+           mask = iocb->ki_filp->f_op->poll(iocb->ki_filp, p);
+     mask &= events | POLLERR | POLLHUP;
+     if (mask && xchg(&iocb->ki_data, NULL)) {
+           poll_freewait(p);
+           aio_complete(iocb, mask, 0);
+     }
+
+     iocb->ki_cancel = async_poll_cancel;
+     aio_put_req(iocb);
+     return -EIOCBQUEUED;
 }

 void __pollwait(struct file * filp, wait_queue_head_t * wait_address, poll_table *p)
@@ -86,6 +227,7 @@
                  __set_current_state(TASK_RUNNING);
                  return;
            }
+           new_table->size = PAGE_SIZE;
            new_table->entry = new_table->entries;
            new_table->next = table;
            p->table = new_table;
@@ -99,7 +241,11 @@
            get_file(filp);
            entry->filp = filp;
            entry->wait_address = wait_address;
-           init_waitqueue_entry(&entry->wait, current);
+           entry->p = p;
+           if (p->iocb) /* async poll */
+                 init_waitqueue_func_entry(&entry->wait, async_poll_waiter);
+           else
+                 init_waitqueue_entry(&entry->wait, current);
            add_wait_queue(wait_address,&entry->wait);
      }
 }
@@ -495,3 +641,14 @@
      poll_freewait(&table);
      return err;
 }
+
+static int __init async_poll_init(void)
+{
+     async_poll_table_cache = kmem_cache_create("async poll table",
+                        sizeof(async_poll_table), 0, 0, NULL, NULL);
+     if (!async_poll_table_cache)
+           panic("unable to alloc poll_table_cache");
+     return 0;
+}
+
+module_init(async_poll_init);
diff -ruN linux-2.5.42/include/linux/aio.h linux-2.5.42AIO/include/linux/aio.h
--- linux-2.5.42/include/linux/aio.h      Fri Oct 11 21:21:04 2002
+++ linux-2.5.42AIO/include/linux/aio.h   Mon Oct 14 15:35:11 2002
@@ -59,6 +59,7 @@
      struct list_head  ki_list;    /* the aio core uses this
                                     * for cancellation */

+     void              *ki_data;   /* for use by the the file */
      void              *ki_user_obj;     /* pointer to userland's iocb */
      __u64             ki_user_data;     /* user's data for completion */
      loff_t                  ki_pos;
diff -ruN linux-2.5.42/include/linux/aio_abi.h linux-2.5.42AIO/include/linux/aio_abi.h
--- linux-2.5.42/include/linux/aio_abi.h  Fri Oct 11 21:21:33 2002
+++ linux-2.5.42AIO/include/linux/aio_abi.h     Mon Oct 14 15:27:15 2002
@@ -40,6 +40,7 @@
       * IOCB_CMD_PREADX = 4,
       * IOCB_CMD_POLL = 5,
       */
+     IOCB_CMD_POLL = 5,
      IOCB_CMD_NOOP = 6,
 };

diff -ruN linux-2.5.42/include/linux/poll.h linux-2.5.42AIO/include/linux/poll.h
--- linux-2.5.42/include/linux/poll.h     Fri Oct 11 21:22:07 2002
+++ linux-2.5.42AIO/include/linux/poll.h  Mon Oct 14 15:27:15 2002
@@ -9,12 +9,14 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <asm/uaccess.h>
+#include <linux/workqueue.h>

 struct poll_table_page;

 typedef struct poll_table_struct {
-     int error;
-     struct poll_table_page * table;
+     int               error;
+     struct poll_table_page  *table;
+     struct kiocb            *iocb;            /* iocb for async poll */
 } poll_table;

 extern void __pollwait(struct file * filp, wait_queue_head_t * wait_address, poll_table *p);
@@ -29,6 +31,7 @@
 {
      pt->error = 0;
      pt->table = NULL;
+     pt->iocb = NULL;
 }
 extern void poll_freewait(poll_table* pt);





