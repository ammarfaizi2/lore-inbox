Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVGVUoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVGVUoq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 16:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVGVUof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 16:44:35 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:53942 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261386AbVGVUnz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 16:43:55 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17121.23168.541515.259702@tut.ibm.com>
Date: Fri, 22 Jul 2005 15:43:44 -0500
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Karim Yaghmour <karim@opersys.com>,
       Steven Rostedt <rostedt@goodmis.org>, richardj_moore@uk.ibm.com,
       varap@us.ibm.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Merging relayfs?
In-Reply-To: <17115.53671.326542.392470@tut.ibm.com>
References: <17107.6290.734560.231978@tut.ibm.com>
	<20050712022537.GA26128@infradead.org>
	<20050711193409.043ecb14.akpm@osdl.org>
	<Pine.LNX.4.61.0507131809120.3743@scrub.home>
	<17110.32325.532858.79690@tut.ibm.com>
	<Pine.LNX.4.61.0507171551390.3728@scrub.home>
	<17114.32450.420164.971783@tut.ibm.com>
	<1121694275.12862.23.camel@localhost.localdomain>
	<Pine.LNX.4.61.0507181607410.3743@scrub.home>
	<42DBBD69.3030300@opersys.com>
	<Pine.LNX.4.61.0507181706430.3728@scrub.home>
	<17115.53671.326542.392470@tut.ibm.com>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Zanussi writes:
 > 
 > OK, if we got rid of the padding counts and commit counts and let the
 > client manage those, we can simplify the buffer switch slow path and
 > make the API simpler in the process.  Here's a first proposal for
 > doing that - I won't know until I actually do it what snags I may run
 > into, but if this looks like the right direction to go, I'll go ahead
 > with it...
 > 

And here's a patch to update the Documentation...


diff -urpN -X dontdiff linux-2.6.13-rc3-mm1/Documentation/filesystems/relayfs.txt linux-2.6.13-rc3-mm1-cur/Documentation/filesystems/relayfs.txt
--- linux-2.6.13-rc3-mm1/Documentation/filesystems/relayfs.txt	2005-07-16 11:47:32.000000000 -0500
+++ linux-2.6.13-rc3-mm1-cur/Documentation/filesystems/relayfs.txt	2005-07-23 12:50:46.000000000 -0500
@@ -23,6 +23,47 @@ This document provides an overview of th
 the function parameters are documented along with the functions in the
 filesystem code - please see that for details.
 
+Semantics
+=========
+
+Each relayfs channel has one buffer per CPU, each buffer has one or
+more sub-buffers. Messages are written to the first sub-buffer until
+it is too full to contain a new message, in which case it it is
+written to the next (if available).  Messages are never split across
+sub-buffers.  At this point, userspace can be notified so it empties
+the first sub-buffer, while the kernel continues writing to the next.
+
+When notified that a sub-buffer is full, the kernel knows how many
+bytes of it are padding i.e. unused.  Userspace can use this knowledge
+to copy only valid data.
+
+After copying it, userspace can notify the kernel that a sub-buffer
+has been consumed.
+
+relayfs can operate in a mode where it will overwrite data not yet
+collected by userspace, and not wait for it to consume it.
+
+relayfs itself does not provide for communication of such data between
+userspace and kernel, allowing the kernel side to remain simple and not
+impose a single interface on userspace. It does provide a separate
+helper though, described below.
+
+klog, relay-app & librelay
+==========================
+
+relayfs itself is ready to use, but to make things easier, two
+additional systems are provided. klog is a simple wrapper to make
+sending data to a channel simpler, regardless of whether a channel to
+write to exists or not.  relay-app is the kernel counterpart of
+userspace librelay.c, combined these two files provide glue to easily
+stream data, without having to bother with housekeeping.
+
+It is possible to use relayfs without relay-app & librelay, but you'll
+have to implement communication between userspace and kernel, allowing
+both to convey the state of buffers (full, empty, amount of padding).
+
+klog, relay-app and librelay can be found in the relay-apps tarball on
+http://relayfs.sourceforge.net
 
 The relayfs user space API
 ==========================
@@ -34,7 +75,8 @@ available and some comments regarding th
 open()	 enables user to open an _existing_ buffer.
 
 mmap()	 results in channel buffer being mapped into the caller's
-	 memory space.
+	 memory space. Note that you can't do a partial mmap - you must
+	 map the entire file, which is NRBUF * SUBBUFSIZE. 
 
 poll()	 POLLIN/POLLRDNORM/POLLERR supported.  User applications are
 	 notified when sub-buffer boundaries are crossed.
@@ -63,13 +105,15 @@ Here's a summary of the API relayfs prov
   channel management functions:
 
     relay_open(base_filename, parent, subbuf_size, n_subbufs,
-               overwrite, callbacks)
+               callbacks)
     relay_close(chan)
     relay_flush(chan)
     relay_reset(chan)
     relayfs_create_dir(name, parent)
     relayfs_remove_dir(dentry)
-    relay_commit(buf, reserved, count)
+
+  channel management typically called on instigation of userspace:
+
     relay_subbufs_consumed(chan, cpu, subbufs_consumed)
 
   write functions:
@@ -77,19 +121,22 @@ Here's a summary of the API relayfs prov
     relay_write(chan, data, length)
     __relay_write(chan, data, length)
     relay_reserve(chan, length)
+    __relay_reserve(buf, length)
 
   callbacks:
 
-    subbuf_start(buf, subbuf, prev_subbuf_idx, prev_subbuf)
-    deliver(buf, subbuf_idx, subbuf)
+    subbuf_start(buf, subbuf, prev_subbuf, prev_padding)
     buf_mapped(buf, filp)
     buf_unmapped(buf, filp)
-    buf_full(buf, subbuf_idx)
 
+  helper functions:
+
+    relay_buf_full(buf)
+    subbuf_start_reserve(buf, length)
 
-A relayfs channel is made of up one or more per-cpu channel buffers,
-each implemented as a circular buffer subdivided into one or more
-sub-buffers.
+
+Creating a channel
+------------------
 
 relay_open() is used to create a channel, along with its per-cpu
 channel buffers.  Each channel buffer will have an associated file
@@ -117,30 +164,106 @@ though, it's safe to assume that having 
 idea - you're guaranteed to either overwrite data or lose events
 depending on the channel mode being used.
 
-relayfs channels can be opened in either of two modes - 'overwrite' or
-'no-overwrite'.  In overwrite mode, writes continuously cycle around
-the buffer and will never fail, but will unconditionally overwrite old
-data regardless of whether it's actually been consumed.  In
-no-overwrite mode, writes will fail i.e. data will be lost, if the
+Channel 'modes'
+---------------
+
+relayfs channels can be used in either of two modes - 'overwrite' or
+'no-overwrite'.  The mode is entirely determined by the implementation
+of the subbuf_start() callback, as described below.  In 'overwrite'
+mode, also known as 'flight recorder' mode, writes continuously cycle
+around the buffer and will never fail, but will unconditionally
+overwrite old data regardless of whether it's actually been consumed.
+In no-overwrite mode, writes will fail i.e. data will be lost, if the
 number of unconsumed sub-buffers equals the total number of
-sub-buffers in the channel.  In this mode, the client is reponsible
-for notifying relayfs when sub-buffers have been consumed via
-relay_subbufs_consumed().  A full buffer will become 'unfull' and
-logging will continue once the client calls relay_subbufs_consumed()
-again.  When a buffer becomes full, the buf_full() callback is invoked
-to notify the client.  In both modes, the subbuf_start() callback will
-notify the client whenever a sub-buffer boundary is crossed.  This can
-be used to write header information into the new sub-buffer or fill in
-header information reserved in the previous sub-buffer.  One piece of
-information that's useful to save in a reserved header slot is the
-number of bytes of 'padding' for a sub-buffer, which is the amount of
-unused space at the end of a sub-buffer.  The padding count for each
-sub-buffer is contained in an array in the rchan_buf struct passed
-into the subbuf_start() callback: rchan_buf->padding[prev_subbuf_idx]
-can be used to to get the padding for the just-finished sub-buffer.
-subbuf_start() is also called for the first sub-buffer in each channel
-buffer when the channel is created.  The mode is specified to
-relay_open() using the overwrite parameter.
+sub-buffers in the channel.  It should be clear that if there is no
+consumer or if the consumer can't consume sub-buffers fast enought,
+data will be lost in either case; the only difference is whether data
+is lost from the beginning or the end of a buffer.
+
+As explained above, a relayfs channel is made of up one or more
+per-cpu channel buffers, each implemented as a circular buffer
+subdivided into one or more sub-buffers.  Messages are written into
+the current sub-buffer of the channel's current per-cpu buffer via the
+write functions described below.  Whenever a message can't fit into
+the current sub-buffer, because there's no room left for it, the
+client is notified via the subbuf_start() callback that a switch to a
+new sub-buffer is about to occur.  The client uses this callback to 1)
+initialize the next sub-buffer if appropriate 2) finalize the previous
+sub-buffer if appropriate and 3) return a boolean value indicating
+whether or not to actually go ahead with the sub-buffer switch.
+
+To implement 'no-overwrite' mode, the userspace client would provide
+an implementation of the subbuf_start() callback something like the
+following:
+
+static int subbuf_start(struct rchan_buf *buf,
+                        void *subbuf,
+			void *prev_subbuf,
+			unsigned int prev_padding)
+{
+	if (relay_buf_full(buf))
+		return 0;
+
+	if (prev_subbuf)
+		*((unsigned *)prev_subbuf) = prev_padding;
+
+	subbuf_start_reserve(buf, sizeof(unsigned int));
+
+	return 1;
+}
+
+If the current buffer is full i.e. all sub-buffers remain unconsumed,
+the callback returns 0 to indicate that the buffer switch should not
+occur yet i.e. until the consumer has had a chance to read the current
+set of ready sub-buffers.  For the relay_buf_full() function to make
+sense, the consumer is reponsible for notifying relayfs when
+sub-buffers have been consumed via relay_subbufs_consumed().  Any
+subsequent attempts to write into the buffer will again invoke the
+subbuf_start() callback with the same parameters; only when the
+consumer has consumed one or more of the ready sub-buffers will
+relay_buf_full() return 0, in which case the buffer switch can
+continue.
+
+The implementation of the subbuf_start() callback for 'overwrite' mode
+would be very similar:
+
+static int subbuf_start(struct rchan_buf *buf,
+                        void *subbuf,
+			void *prev_subbuf,
+			unsigned int prev_padding)
+{
+	if (prev_subbuf)
+		*((unsigned *)prev_subbuf) = prev_padding;
+
+	subbuf_start_reserve(buf, sizeof(unsigned int));
+
+	return 1;
+}
+
+In this case, the relay_buf_full() check is meaningless and the
+callback always returns 1, causing the buffer switch to occur
+unconditionally.  It's also meaningless for the client to use the
+relay_subbufs_consumed() function in this mode, as it's never
+consulted.
+
+Header information can be reserved at the beginning of each sub-buffer
+by calling the subbuf_start_reserve() helper function from within the
+subbuf_start() callback.  This reserved area can be used to store
+whatever information the client wants.  In the example above, room is
+reserved in each sub-buffer to store the padding count for that
+sub-buffer.  This is filled in for the previous sub-buffer in the
+subbuf_start() implementation; the padding value for the previous
+sub-buffer is passed into the subbuf_start() callback along with a
+pointer to the previous sub-buffer, since the padding value isn't
+known until a sub-buffer is filled.  The subbuf_start() callback is
+also called for the first sub-buffer when the channel is opened, to
+give the client a chance to reserve space in it.  In this case the
+previous sub-buffer pointer passed into the callback will be NULL, so
+the client should check the value of the prev_subbuf pointer before
+writing into the previous sub-buffer.
+
+Writing to a channel
+--------------------
 
 kernel clients write data into the current cpu's channel buffer using
 relay_write() or __relay_write().  relay_write() is the main logging
@@ -151,22 +274,31 @@ __relay_write(), which only disables pre
 don't return a value, so you can't determine whether or not they
 failed - the assumption is that you wouldn't want to check a return
 value in the fast logging path anyway, and that they'll always succeed
-unless the buffer is full and in no-overwrite mode, in which case
-you'll be notified via the buf_full() callback.
+unless the buffer is full and no-overwrite mode is being used, in
+which case you can detect a failed write in the subbuf_start()
+callback by calling the relay_buf_full() helper function.
 
 relay_reserve() is used to reserve a slot in a channel buffer which
 can be written to later.  This would typically be used in applications
 that need to write directly into a channel buffer without having to
 stage data in a temporary buffer beforehand.  Because the actual write
 may not happen immediately after the slot is reserved, applications
-using relay_reserve() can call relay_commit() to notify relayfs when
-the slot has actually been written.  When all the reserved slots have
-been committed, the deliver() callback is invoked to notify the client
-that a guaranteed full sub-buffer has been produced.  Because the
-write is under control of the client and is separated from the
-reserve, relay_reserve() doesn't protect the buffer at all - it's up
-to the client to provide the appropriate synchronization when using
-relay_reserve().
+using relay_reserve() can keep a count of the number of bytes actually
+written, either in space reserved in the sub-buffers themselves or as
+a separate array.  See the 'reserve' example in the relay-apps tarball
+at http://relayfs.sourceforge.net for an example of how this can be
+done.  Because the write is under control of the client and is
+separated from the reserve, relay_reserve() doesn't protect the buffer
+at all - it's up to the client to provide the appropriate
+synchronization when using relay_reserve().
+
+relay_reserve() uses __relay_reserve() to actually do the reservation;
+__relay_reserve() is also available to clients - in some cases for
+more efficiency, it may be more efficient for the client to direcly
+access the buffer when maintaining commit counts, for example.
+
+Closing a channel
+-----------------
 
 The client calls relay_close() when it's finished using the channel.
 The channel and its associated buffers are destroyed when there are no
@@ -175,6 +307,9 @@ forces a sub-buffer switch on all the ch
 to finalize and process the last sub-buffers before the channel is
 closed.
 
+Misc
+----
+
 Some applications may want to keep a channel around and re-use it
 rather than open and close a new channel for each use.  relay_reset()
 can be used for this purpose - it resets a channel to its initial


