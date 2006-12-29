Return-Path: <linux-kernel-owner+w=401wt.eu-S1752426AbWL2M1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbWL2M1U (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 07:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752420AbWL2M1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 07:27:04 -0500
Received: from dea.vocord.ru ([217.67.177.50]:40726 "EHLO
	kano.factory.vocord.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752476AbWL2M0q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 07:26:46 -0500
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Jamal Hadi Salim <hadi@cyberus.ca>,
       Ingo Molnar <mingo@elte.hu>
Subject: [take30 1/9] kevent: Description.
In-Reply-To: <1167395157978@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Fri, 29 Dec 2006 15:25:57 +0300
Message-Id: <11673951573754@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Description.


diff --git a/Documentation/kevent.txt b/Documentation/kevent.txt
new file mode 100644
index 0000000..95cb36e
--- /dev/null
+++ b/Documentation/kevent.txt
@@ -0,0 +1,244 @@
+Description.
+
+int kevent_init(struct kevent_ring *ring, unsigned int ring_size, 
+	unsigned int flags);
+
+num - size of the ring buffer in events 
+ring - pointer to allocated ring buffer
+flags - various flags, see KEVENT_FLAGS_* definitions.
+
+Return value: kevent control file descriptor or negative error value.
+
+ struct kevent_ring
+ {
+   unsigned int ring_kidx, ring_over;
+   struct ukevent event[0];
+ }
+
+ring_kidx - index in the ring buffer where kernel will put new events 
+		when kevent_wait() or kevent_get_events() is called 
+ring_over - number of overflows of ring_uidx happend from the start.
+	Overflow counter is used to prevent situation when two threads 
+	are going to free the same events, but one of them was scheduled 
+	away for too long, so ring indexes were wrapped, so when that 
+	thread will be awakened, it will free not those events, which 
+	it suppose to free.
+
+Example userspace code (ring_buffer.c) can be found on project's homepage.
+
+Each kevent syscall can be so called cancellation point in glibc, i.e. when 
+thread has been cancelled in kevent syscall, thread can be safely removed 
+and no events will be lost, since each syscall (kevent_wait() or 
+kevent_get_events()) will copy event into special ring buffer, accessible 
+from other threads or even processes (if shared memory is used).
+
+When kevent is removed (not dequeued when it is ready, but just removed), 
+even if it was ready, it is not copied into ring buffer, since if it is 
+removed, no one cares about it (otherwise user would wait until it becomes 
+ready and got it through usual way using kevent_get_events() or kevent_wait()) 
+and thus no need to copy it to the ring buffer.
+
+-------------------------------------------------------------------------------
+
+
+int kevent_ctl(int fd, unsigned int cmd, unsigned int num, struct ukevent *arg);
+
+fd - is the file descriptor referring to the kevent queue to manipulate. 
+It is created by opening "/dev/kevent" char device, which is created with 
+dynamic minor number and major number assigned for misc devices. 
+
+cmd - is the requested operation. It can be one of the following:
+    KEVENT_CTL_ADD - add event notification 
+    KEVENT_CTL_REMOVE - remove event notification 
+    KEVENT_CTL_MODIFY - modify existing notification 
+    KEVENT_CTL_READY - mark existing events as ready, if number of events is zero,
+    	it just wakes up parked in syscall thread
+
+num - number of struct ukevent in the array pointed to by arg 
+arg - array of struct ukevent
+
+Return value: 
+ number of events processed or negative error value.
+
+When called, kevent_ctl will carry out the operation specified in the 
+cmd parameter.
+-------------------------------------------------------------------------------
+
+ int kevent_get_events(int ctl_fd, unsigned int min_nr, unsigned int max_nr, 
+ 		struct timespec timeout, struct ukevent *buf, unsigned flags);
+
+ctl_fd - file descriptor referring to the kevent queue 
+min_nr - minimum number of completed events that kevent_get_events will block 
+	 waiting for 
+max_nr - number of struct ukevent in buf 
+timeout - time to wait before returning less than min_nr 
+	  events. If this is -1, then wait forever. 
+buf - pointer to an array of struct ukevent. 
+flags - various flags, see KEVENT_FLAGS_* definitions.
+
+Return value:
+ number of events copied or negative error value.
+
+kevent_get_events will wait timeout milliseconds for at least min_nr completed 
+events, copying completed struct ukevents to buf and deleting any 
+KEVENT_REQ_ONESHOT event requests. In nonblocking mode it returns as many 
+events as possible, but not more than max_nr. In blocking mode it waits until 
+timeout or if at least min_nr events are ready.
+
+This function copies event into ring buffer if it was initialized, if ring buffer
+is full, KEVENT_RET_COPY_FAILED flag is set in ret_flags field.
+-------------------------------------------------------------------------------
+
+ int kevent_wait(int ctl_fd, unsigned int num, unsigned int old_uidx, 
+ 	struct timespec timeout, unsigned int flags);
+
+ctl_fd - file descriptor referring to the kevent queue 
+num - number of processed kevents 
+old_uidx - the last index user is aware of
+timeout - time to wait until there is free space in kevent queue
+flags - various flags, see KEVENT_FLAGS_* definitions.
+
+Return value:
+ number of events copied into ring buffer or negative error value.
+
+This syscall waits until either timeout expires or at least one event becomes 
+ready. It also copies events into special ring buffer. If ring buffer is full,
+it waits until there are ready events and then return.
+If kevent is one-shot kevent it is removed in this syscall.
+If kevent is edge-triggered (KEVENT_REQ_ET flag is set in 'req_flags') it is 
+requeued in this syscall for performance reasons.
+-------------------------------------------------------------------------------
+
+ int kevent_commit(int ctl_fd, unsigned int new_idx, unsigned int over);
+
+ctl_fd - file descriptor referring to the kevent queue 
+new_uidx - the last committed kevent
+over - overflow count for given $new_idx value
+
+Return value:
+ number of committed kevents or negative error value.
+
+This function commits, i.e. marks as empty, slots in the ring buffer, so
+they can be reused when userspace completes that entries processing.
+
+Overflow counter is used to prevent situation when two threads are going 
+to free the same events, but one of them was scheduled away for too long, 
+so ring indexes were wrapped, so when that thread will be awakened, it 
+will free not those events, which it suppose to free.
+
+It is possible that returned number of committed events will be smaller than
+requested number - it is possible when several threads try to commit the
+same events.
+-------------------------------------------------------------------------------
+
+The bulk of the interface is entirely done through the ukevent struct. 
+It is used to add event requests, modify existing event requests, 
+specify which event requests to remove, and return completed events.
+
+struct ukevent contains the following members:
+
+struct kevent_id id
+    Id of this request, e.g. socket number, file descriptor and so on 
+__u32 type
+    Event type, e.g. KEVENT_SOCK, KEVENT_INODE, KEVENT_TIMER and so on 
+__u32 event
+    Event itself, e.g. SOCK_ACCEPT, INODE_CREATED, TIMER_FIRED 
+__u32 req_flags
+    Per-event request flags,
+
+    KEVENT_REQ_ONESHOT
+        event will be removed when it is ready 
+
+    KEVENT_REQ_WAKEUP_ALL
+        Kevent wakes up only first thread interested in given event, 
+	or all threads if this flag is set.
+
+    KEVENT_REQ_ET
+        Edge Triggered behaviour. It is an optimisation which allows to move 
+	ready and dequeued (i.e. copied to userspace) event to move into set 
+	of interest for given storage (socket, inode and so on) again. It is 
+	very usefull for cases when the same event should be used many times 
+	(like reading from pipe). It is similar to epoll()'s EPOLLET flag. 
+
+    KEVENT_REQ_LAST_CHECK
+        if set allows to perform the last check on kevent (call appropriate 
+	callback) when kevent is marked as ready and has been removed from 
+	ready queue. If it will be confirmed that kevent is ready 
+	(k->callbacks.callback(k) returns true) then kevent will be copied 
+	to userspace, otherwise it will be requeued back to storage. 
+	Second (checking) call is performed with this bit cleared, so callback 
+	can detect when it was called from kevent_storage_ready() - bit is set, 
+	or kevent_dequeue_ready() - bit is cleared. If kevent will be requeued, 
+	bit will be set again.
+
+   KEVENT_REQ_ALWAYS_QUEUE
+        If this flag is set kevent will be queued into ready queue if it is 
+	ready at enqueue time, otherwise it will be copied back to userspace
+	and will not be queued into the storage.
+
+   KEVENT_REQ_READY
+   	If this flag is set, kevent will be marked as ready immediately at enqueue
+	time.
+
+__u32 ret_flags
+    Per-event return flags
+
+    KEVENT_RET_BROKEN
+        Kevent is broken 
+
+    KEVENT_RET_DONE
+        Kevent processing was finished successfully 
+
+    KEVENT_RET_COPY_FAILED
+        Kevent was not copied into ring buffer due to some error conditions. 
+
+__u32 ret_data
+    Event return data. Event originator fills it with anything it likes 
+    (for example timer notifications put number of milliseconds when timer 
+    has fired 
+union { __u32 user[2]; void *ptr; }
+    User's data. It is not used, just copied to/from user. The whole structure 
+    is aligned to 8 bytes already, so the last union is aligned properly. 
+
+-------------------------------------------------------------------------------
+
+Kevent waiting syscall flags.
+
+KEVENT_FLAGS_ABSTIME - provided timespec parameter contains absolute time, 
+	for example Aug 27, 2194, or time(NULL) + 10.
+
+-------------------------------------------------------------------------------
+
+Usage
+
+For KEVENT_CTL_ADD, all fields relevant to the event type must be filled 
+(id, type, event, req_flags). 
+After kevent_ctl(..., KEVENT_CTL_ADD, ...) returns each struct's ret_flags 
+should be checked to see if the event is already broken or done.
+
+For KEVENT_CTL_MODIFY, the id, req_flags, and user and event fields must be 
+set and an existing kevent request must have matching id and user fields. If 
+match is found, req_flags and event are replaced with the newly supplied 
+values and requeueing is started, so modified kevent can be checked and 
+probably marked as ready immediately. If a match can't be found, the 
+passed in ukevent's ret_flags has KEVENT_RET_BROKEN set. KEVENT_RET_DONE is 
+always set.
+
+For KEVENT_CTL_REMOVE, the id and user fields must be set and an existing 
+kevent request must have matching id and user fields. If a match is found, 
+the kevent request is removed. If a match can't be found, the passed in 
+ukevent's ret_flags has KEVENT_RET_BROKEN set. KEVENT_RET_DONE is always set.
+
+For kevent_get_events, the entire structure is returned.
+
+-------------------------------------------------------------------------------
+
+Usage cases
+
+kevent_timer
+struct ukevent should contain following fields:
+    type - KEVENT_TIMER 
+    event - KEVENT_TIMER_FIRED 
+    req_flags - KEVENT_REQ_ONESHOT if you want to fire that timer only once 
+    id.raw[0] - number of seconds after commit when this timer shout expire 
+    id.raw[0] - additional to number of seconds number of nanoseconds 

