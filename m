Return-Path: <linux-kernel-owner+w=401wt.eu-S1422819AbWLUH2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422819AbWLUH2A (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 02:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422821AbWLUH2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 02:28:00 -0500
Received: from smtp.osdl.org ([65.172.181.25]:45368 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422819AbWLUH17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 02:27:59 -0500
Date: Wed, 20 Dec 2006 23:23:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, David Wilder <dwilder@us.ibm.com>,
       Tom Zanussi <zanussi@us.ibm.com>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Relay CPU Hotplug support
Message-Id: <20061220232350.eb4b6a46.akpm@osdl.org>
In-Reply-To: <20061221003101.GA28643@Krystal>
References: <20061221003101.GA28643@Krystal>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006 19:31:01 -0500
Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:

> Hi,
> 
> Here is a patch, result of the combined work of Tom Zanussi and myself, to add
> CPU hotplug support to Relay.
> 
> ...
>
> +
> +	lock_cpu_hotplug();
> +	for_each_online_cpu(i)
> +		if (chan->buf[i])
> +			__relay_reset(chan->buf[i], 0);
> +	unlock_cpu_hotplug();

__relay_reset() runs flush_scheduled_work().  If one of the queued works
takes lock_cpu_hoplug() (and some do), thou art most deadest meat.

I think the core design problem you have here is that you are using
cpu_online_map to record the presence or absence of resources which belong
to the relay driver.  Why do that - you don't own cpu_online_map (but you
do get some notifications when it wants to change, that's all).

Perhaps a better approach would be to teach the relay driver to maintain
its own resources (already there, in chan->buf[]).  So relay.c has a record
of which per-cpu buffers are present and which are not.  That information
gets changed under a lock which the relay driver owns and controls.

You already have such a lock: relay_channels_mutex.  So some code in here
is using lock_cpu_hotplug() to protect relay's resources while other code
is using relay_channels_mutex.    Which is it?


Your proposed change apparently chooses to not release per-cpu resources on
cpu-hotunplug.  I think.  That's the sort of thing which should be
communicated in the (presently non-existent) patch changelog.

The changelog should also tell us *why* this patch was written.  Right now
it's in "why on earth should we merge this" territory.




Meanwhile, let's shrink 10% off of relay.o's .text, shall we?


--- a/kernel/relay.c~relay-remove-inlining
+++ a/kernel/relay.c
@@ -322,7 +322,7 @@ static void wakeup_readers(struct work_s
  *
  *	See relay_reset for description of effect.
  */
-static inline void __relay_reset(struct rchan_buf *buf, unsigned int init)
+static void __relay_reset(struct rchan_buf *buf, unsigned int init)
 {
 	size_t i;
 
@@ -418,7 +418,7 @@ static struct rchan_buf *relay_open_buf(
  *	The channel buffer and channel buffer data structure are then freed
  *	automatically when the last reference is given up.
  */
-static inline void relay_close_buf(struct rchan_buf *buf)
+static void relay_close_buf(struct rchan_buf *buf)
 {
 	buf->finalized = 1;
 	cancel_delayed_work(&buf->wake_readers);
@@ -426,7 +426,7 @@ static inline void relay_close_buf(struc
 	kref_put(&buf->kref, relay_remove_buf);
 }
 
-static inline void setup_callbacks(struct rchan *chan,
+static void setup_callbacks(struct rchan *chan,
 				   struct rchan_callbacks *cb)
 {
 	if (!cb) {
@@ -946,11 +946,10 @@ typedef int (*subbuf_actor_t) (size_t re
 /*
  *	relay_file_read_subbufs - read count bytes, bridging subbuf boundaries
  */
-static inline ssize_t relay_file_read_subbufs(struct file *filp,
-					      loff_t *ppos,
-					      subbuf_actor_t subbuf_actor,
-					      read_actor_t actor,
-					      read_descriptor_t *desc)
+static ssize_t relay_file_read_subbufs(struct file *filp, loff_t *ppos,
+					subbuf_actor_t subbuf_actor,
+					read_actor_t actor,
+					read_descriptor_t *desc)
 {
 	struct rchan_buf *buf = filp->private_data;
 	size_t read_start, avail;
_

