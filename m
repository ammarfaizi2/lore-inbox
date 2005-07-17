Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVGQJBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVGQJBk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 05:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVGQJBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 05:01:40 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:12488 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261221AbVGQJBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 05:01:39 -0400
Date: Sun, 17 Jul 2005 11:01:37 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, karim@opersys.com, varap@us.ibm.com,
       richardj_moore@uk.ibm.com, relayfs-devel@lists.sourceforge.net
Subject: [PATCH] Re: relayfs documentation sucks?
Message-ID: <20050717090137.GB5161@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Tom Zanussi <zanussi@us.ibm.com>, linux-kernel@vger.kernel.org,
	karim@opersys.com, varap@us.ibm.com, richardj_moore@uk.ibm.com,
	relayfs-devel@lists.sourceforge.net
References: <17107.6290.734560.231978@tut.ibm.com> <20050716210759.GA1850@outpost.ds9a.nl> <17113.38067.551471.862551@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17113.38067.551471.862551@tut.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2005 at 06:13:55PM -0500, Tom Zanussi wrote:

> relayfs itself only provides the buffering and file operations along
> with the kernel API for clients as documented in
> Documentation/filesystems/relayfs.txt.  Applications still need some
> kind of communication between the kernel and user space in order to
> know when data is ready and how much is ready - the relay-apps stuff
> tries to make this easy to do by allowing clients to ignore all those
> details.  It happens to use netlink for this, but clients can use
> whatever they want to do this communication.

Ok - that is good to know. What is missing from relayfs.txt is a demarcation
of which system does what.

As I see it there are three things currently:

1) Basic relayfs facilities, which only stuff data into N sub-buffers per
CPU, but also offer a set of functions that could be called via userspace
over some sort of communication channel.

2) klog which is a thin wrapper over relay_write

3) relay-app.h which lives in the kernel and communicates with librelay.c in
user space, providing that communication.

Is this correct?

> Then just run the kleak app, and when it finishes, you should have a
> set of files, cpu0l...cpuX in your current directory containing all
> the data you've logged.

I've changed the fprintf(stderr, "netlink send error") to perror("netlink
send error") and now it prints 'Connection refused', which makes heaps of
sense since I did not use relay-app.h, but wrote directly to the channel.

>  > 2) What kind of messages do I need to send/receive?
> 
> Basically, the daemon needs to know, for a given per-cpu buffer, how
> many sub-buffers have been produced and consumed, in order to know
> which sections of the mmapped buffer to read.  It also needs to notify

I currently just write away without any userspace component, except that I
mmap the entire relayfs file in which I see the four configured sub-buffers.
I guess that in override mode that would work? 

> The format is whatever the client writes into it - relayfs itself
> doesn't impose any format at all.  The client doesn't need librelay.c
> to read the data itself - librelay.c is for managing the daemon side
> of the application and writing ready data to disk as it becomes
> available.  It doesn't know anything about the actual data being written.

Ok - so there is nothing in there except n stretches of data, and some
padding? Each write is either IN a sub-buffer or not at all, it doesn't span
sub-buffers?

>  > 4) What are the semantics for reading from that file?
> 
> The file is a buffer broken up into sub-buffers.  The client reads the
> sub-buffers it knows are ready directly from the mmapped buffer.
> The file can only be mmap()ed - there is no read() available.

Indeed. So the idea is to wait for a ringbuffer to become 'full', read it,
and wait for the next one to become full?

> BTW, there's also documentation in relay-app.h, don't know if you saw
> that.

Yes - but it only makes sense after the 'separation of powers' within
relayfs is clear. relayfs.txt talks rather cavalierly of 'clients' and
'calls' but does not make clear this client lives in userspace and can't
just call kernel functions.

Please consider the patch below. I'm not 100% sure if everything is correct,
but I'd love to know.

I'm wondering how relayfs could be operated safely in overwrite mode, btw -
who's to say the kernel might not have zoomed past my sub-buffer once I'm
notified of the crossing? The padding data I receive might be outdated by
then. Sounds racey.

In fact, it appears this might even happen in non-overwrite mode.

diff -urBb -X linux-2.6.13-rc3-mm1/Documentation/dontdiff linux-2.6.13-rc3-mm1/Documentation/filesystems/relayfs.txt linux-2.6.13-rc3-mm1-ahu/Documentation/filesystems/relayfs.txt
--- linux-2.6.13-rc3-mm1/Documentation/filesystems/relayfs.txt	2005-07-17 11:00:48.000638680 +0200
+++ linux-2.6.13-rc3-mm1-ahu/Documentation/filesystems/relayfs.txt	2005-07-17 10:58:21.634889656 +0200
@@ -23,6 +23,46 @@
 the function parameters are documented along with the functions in the
 filesystem code - please see that for details.
 
+Semantics
+=========
+
+Each relayfs channel has one buffer per CPU, each buffer has one or
+more sub-buffers. Messages are written to the first sub-buffer until it
+is too full to contain a new message, in which case it it is written to
+the next (if available). At this point, userspace can be notified so it
+empties the first ringbuffer, while the kernel continues writing to the
+next.
+
+If notified that a sub-buffer is full, the kernel knows how many bytes
+of it are padding, ie, unused. Userspace can use this knowledge to copy
+only valid data.
+
+After copying, userspace can notify the kernel that a sub-channel has
+been consumed.
+
+relayfs can operate in a mode where it will overwrite data not yet
+collected by userspace, and not wait for it to consume it.
+
+relayfs itself does not provide for communication of such data between
+userspace and kernel, allowing the kernel side to remain simple and not
+impose a single interface on userspace. It does provide a separate
+helper though, described below.
+
+Klog, relay-app & librelay
+==========================
+
+relayfs itself is ready to use, but to make things easier, two
+additional systems are provided. Klog is a simple wrapper to make
+sending data to a channel simpler. relay-app is the kernel counterpart
+of userspace librelay.c, combined these two files provide glue to
+easily stream data, without having to bother with housekeeping.
+
+It is possible to use relayfs without relay-app & librelay, but you'll
+have to implement communication between userspace and kernel, allowing
+both to convey the state of buffers (full, empty, amount of padding).
+
+Klog, relay-app and librelay can be found on
+http://relayfs.sourceforge.net
 
 The relayfs user space API
 ==========================
@@ -34,7 +74,8 @@
 open()	 enables user to open an _existing_ buffer.
 
 mmap()	 results in channel buffer being mapped into the caller's
-	 memory space.
+	 memory space. Note that you can't do a partial mmap - you must
+	 map the entire file, which is NRBUF * SUBBUFSIZE. 
 
 poll()	 POLLIN/POLLRDNORM/POLLERR supported.  User applications are
 	 notified when sub-buffer boundaries are crossed.
@@ -70,6 +109,9 @@
     relayfs_create_dir(name, parent)
     relayfs_remove_dir(dentry)
     relay_commit(buf, reserved, count)
+
+  channel management typically called on instigation of userspace:
+
     relay_subbufs_consumed(chan, cpu, subbufs_consumed)
 
   write functions:
@@ -86,10 +128,9 @@
     buf_unmapped(buf, filp)
     buf_full(buf, subbuf_idx)
 
-
-A relayfs channel is made of up one or more per-cpu channel buffers,
-each implemented as a circular buffer subdivided into one or more
-sub-buffers.
+As explained above, a relayfs channel is made of up one or more per-cpu
+channel buffers, each implemented as a circular buffer subdivided into
+one or more sub-buffers.
 
 relay_open() is used to create a channel, along with its per-cpu
 channel buffers.  Each channel buffer will have an associated file
@@ -123,24 +164,25 @@
 data regardless of whether it's actually been consumed.  In
 no-overwrite mode, writes will fail i.e. data will be lost, if the
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
+sub-buffers in the channel.  
+
+In this mode, the userspace client is reponsible for notifying relayfs when
+sub-buffers have been consumed via relay_subbufs_consumed().  A full buffer
+will become 'unfull' and logging will continue once the client calls
+relay_subbufs_consumed().  When a buffer becomes full, the buf_full()
+callback is invoked to notify the client.  In both modes, the subbuf_start()
+callback will notify the client whenever a sub-buffer boundary is crossed. 
+
+This can be used to write header information into the new sub-buffer or fill
+in header information reserved in the previous sub-buffer.  One piece of
+information that's useful to save in a reserved header slot is the number of
+bytes of 'padding' for a sub-buffer, which is the amount of unused space at
+the end of a sub-buffer.  The padding count for each sub-buffer is contained
+in an array in the rchan_buf struct passed into the subbuf_start() callback:
+rchan_buf->padding[prev_subbuf_idx] can be used to to get the padding for
+the just-finished sub-buffer. subbuf_start() is also called for the first
+sub-buffer in each channel buffer when the channel is created.  The mode is
+specified to relay_open() using the overwrite parameter.
 
 kernel clients write data into the current cpu's channel buffer using
 relay_write() or __relay_write().  relay_write() is the main logging


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
