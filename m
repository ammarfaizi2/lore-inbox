Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbTJGVA6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 17:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbTJGVA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 17:00:58 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:46310 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262886AbTJGVAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 17:00:09 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16259.10547.72758.205812@gargle.gargle.HOWL>
Date: Tue, 7 Oct 2003 15:59:31 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] relayfs (1/4) (Documentation)
X-Mailer: VM(ViewMail) 7.01 under Emacs 20.7.2
Cc: karim@opersys.com, bob@watson.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This 4-part patch contains code for an interim version of relayfs (see
Documentation below for a description of relayfs).  This version still
needs more testing and cleanup, but it contains most of the API
changes prompted by user comments, which has resulted in a somewhat
simpler API as well as some code simplification.

Here's a summary of the major changes:

- added support for poll()
- moved some of what once was exposed in the API into an opaque reader
  object, which also simplifies relay_read() (see Reader objects in
  Documentation)
- removed buffers_full() callback (the function this performed is now
  specified as a channel attribute (see RELAY_MODE_CONTINUOUS in
  Documentation)
- removed relay_resume() (clients need to check return value of
  relay_write() to figure out if a write failed)
- removed offsets_changed() callback (now hidden in reader)
- added relay_reset() which some kernel clients sometimes may need 
- changed locking scheme to use n-buffers instead of only 2 (which
  simplifies relay_open() a bit)
- VFS readers made auto-consuming if a relay file is opened using
  O_EXCL (and a hopefully better description of what 'consuming' means
  in Documentation)
- various bug fixes

Still todo -

- resizing cleanup
- resizing of mmapped buffers
- code to allow channels to start out with static buffers


Thanks to Stephen Hemminger, Marco Cova, and Hubertus Franke for
contributing patches and pointing out problems, and to Hubertus Franke
for a lot of good ideas and for persevering through a couple of
limitations (now overcome) in the previous versions that caused some
headaches when trying to use relayfs from deep within the scheduler.

Tom


diff -urpN -X dontdiff linux-2.6.0-test6/Documentation/filesystems/relayfs.txt linux-2.6.0-test6.cur/Documentation/filesystems/relayfs.txt
--- linux-2.6.0-test6/Documentation/filesystems/relayfs.txt	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test6.cur/Documentation/filesystems/relayfs.txt	Tue Oct  7 11:52:47 2003
@@ -0,0 +1,650 @@
+
+relayfs - a high-speed data relay filesystem
+============================================
+
+relayfs is a filesystem designed to provide an efficient mechanism for
+tools and facilities to relay large amounts of data from kernel space
+to user space.
+
+The main idea behind relayfs is that every data flow is put into a
+separate "channel" and each channel is a file.  In practice, each
+channel is a separate memory buffer allocated from within kernel space
+upon channel instantiation. Software needing to relay data to user
+space would open a channel or a number of channels, depending on its
+needs, and would log data to that channel. All the buffering and
+locking mechanics are taken care of by relayfs.  The actual format and
+protocol used for each channel is up to relayfs' clients.
+
+relayfs makes no provisions for copying the same data to more than a
+single channel. This is for the clients of the relay to take care of,
+and so is any form of data filtering. The purpose is to keep relayfs
+as simple as possible.
+
+
+Usage
+=====
+
+In addition to the relayfs kernel API described below, relayfs
+implements basic file operations.  Here are the file operations that
+are available and some comments regarding their behavior:
+
+open()	 enables user to open an _existing_ channel.  If the file is
+	 opened O_EXCL, reads on the descriptor will auto-consume.
+
+mmap()	 results in channel's memory buffer being mmapped into the
+	 caller's memory space.
+
+read()	 since we are dealing with circular buffers, the user is only
+	 allowed to read forward.  Some apps may want to loop around
+	 read() waiting for incoming data - if there is no data
+	 available, read will put the reader on a wait queue until
+	 data is available.
+
+write()	 writing from user space operates exactly as relay_write() does
+	 (described below).
+
+poll()	POLLIN/POLLRDNORM/POLLOUT/POLLWRNORM/POLLERR supported.
+
+close()  decrements the channel's refcount.  When the refcount reaches
+	 0 i.e. when no process or kernel client has the file open
+	 (see relay_close() below), the channel buffer is freed.
+
+
+In order for a user application to make use of relayfs files, the
+relayfs filesystem must be mounted.  For example,
+
+	mount -t relayfs relayfs /mountpoint
+
+
+The relayfs kernel API
+======================
+
+relayfs channels are implemented as circular buffers subdivided into
+'sub-buffers'.  kernel clients write data into the channel using
+relay_write(), and are notified via a set of callbacks when
+significant events occur within the channel.  'Significant events'
+include:
+
+- a sub-buffer has been filled i.e. the current write won't fit into the
+  current sub-buffer, and a 'buffer-switch' is triggered, after which
+  the data is written into the next buffer (if the next buffer is
+  empty).  The client is notified of this condition via two callbacks,
+  one providing an opportunity to perform start-of-buffer tasks, the
+  other end-of-buffer tasks.
+
+- data is ready for the client to process.  The client can choose to
+  be notified either on a per-sub-buffer basis (bulk delivery) or
+  per-write basis (packet delivery).
+
+- the channel needs resizing, or needs to update its
+  state based on the results of the resize.  Resizing the channel is
+  up to the kernel client to actually perform.  If the channel is
+  configured for resizing, the client is notified when the unread data
+  in the channel passes a preset threshold, giving it the opportunity
+  to allocate a new channel buffer and replace the old one.
+
+Reader objects
+--------------
+
+Channel readers use an opaque rchan_reader object to read from
+channels.  For VFS readers, these objects are automatically created
+and used internally; only kernel clients that need to directly read
+from channels need to know anything about rchan_readers - others may
+skip this section.
+
+A relay channel can have any number of readers, each represented by an
+rchan_reader instance, which is used to encapsulate reader settings
+and state.  rchan_reader objects should be treated as opaque by kernel
+clients.  To create a non-VFS reader (reader objects for VFS file
+readers e.g. those opened from user space using open(2) have reader
+objects automatically created for them), call the add_rchan_reader()
+kernel API function:
+
+rchan_reader *add_rchan_reader(rchan_id, auto_consume)
+
+This function returns an rchan_reader instance if successful, which
+should then be passed to relay_read() when the kernel client is
+interested in reading from the channel.
+
+The auto_consume parameter indicates whether a read done by this
+reader will automatically 'consume' that portion of the unread channel
+buffer (see below for more details).  Currently, there can only be a
+single auto-consuming reader (and any number of additional
+non-consuming readers).  If a VFS reader has opened the channel file
+using the O_EXCL flag, that counts as one instance of an
+auto-consuming reader, and adding an auto-consuming reader from the
+kernel client in that case will fail.
+
+To close the reader, call
+
+remove_rchan_reader(reader)
+
+which will remove the reader from the list of current readers.
+
+What 'consume/consumed/bufs_consumed/bytes_consumed' means
+----------------------------------------------------------
+
+A relayfs channel is a circular buffer, which means that if there is
+no reader reading from it or a reader reading too slowly, at some
+point the channel writer will 'lap' the reader and data will be lost.
+In normal use, readers will always be able to keep up with writers and
+the buffer is thus never in danger of becoming full.  In many
+applications, it's sufficient to ensure that this is practically
+speaking always the case, by making the buffers large enough.  These
+types of applications can basically open the channel as
+RELAY_MODE_CONTINOUS (the default anyway) and not worry about the
+meaning of 'consume' and skip the rest of this section.
+
+If it's important for the application that a kernel client never allow
+writers to overwrite unread data, the channel should be opened using
+RELAY_MODE_NO_OVERWRITE and must be kept apprised of the count of
+bytes actually read by the (typically) user-space channel readers.
+This count is referred to as the 'consumed count'. If there's meant to
+be a single user-space VFS reader of the channel, which is typically
+the case, that reader will automatically update the 'consumed count'
+if the reader opens the channel file using the O_EXCL flag, which
+additionally restricts the number of consuming readers to 1.  If this
+is the usage mode, the kernel client doesn't need to worry about any
+of the relayfs functions having to do with 'bytes consumed' and can
+skip the rest of this section.  (Note that in reality, there can be
+any number of VFS readers, as long as only one of them is the
+consuming reader i.e. only one using O_EXCL).
+
+If the kernel client cannot rely on an auto-consuming reader to keep
+the 'consumed count' up-to-date, then it must do so manually, by
+making the appropriate calls to relay_buffers_consumed() or
+relay_bytes_consumed().  In most cases, this should only be necessary
+for bulk clients - almost all packet clients should be covered by
+having auto-consuming VFS readers.  For mmapped bulk clients, for
+instance, there are no auto-consuming VFS readers, so the kernel
+client needs to make the call to relay_buffers_consumed() after
+sub-buffers are read.
+
+In summary, the defaults should be sufficient for most casual
+applications such as debugging - either create a CONTINUOUS channel
+with large enough buffers and normal VFS readers, or create a
+NO_OVERWRITE channel and a single O_EXCL VFS reader (and optionally
+any number of normal VFS readers as well).
+
+Here's a summary of the API relayfs provides to in-kernel clients:
+
+int    relay_open(channel_path, bufsize, nbufs, channel_flags,
+		  channel_callbacks, start_reserve, end_reserve,
+		  rchan_start_reserve, resize_min, resize_max)
+int    relay_write(channel_id, *data_ptr, count, time_delta_offset)
+void   relay_buffers_consumed(channel_id, buffers_consumed)
+void   relay_bytes_consumed(channel_id, bytes_consumed, read_offset)
+int    relay_info(channel_id, *channel_info)
+int    relay_close(channel_id)
+rchan_reader *add_rchan_reader(channel_id, auto_consume)
+int    remove_rchan_reader(rchan_reader *reader)
+int    relay_read(reader, buf, count, wait)
+int    relay_read_last(channel_id, buf, count)
+int    relay_bytes_avail(channel_id, read_offset)
+int    relay_realloc_buffer(channel_id, bufsize, nbufs)
+int    relay_replace_buffer(channel_id)
+int    relay_reset(int rchan_id)
+
+----------
+int relay_open(channel_path, bufsize, nbufs, 
+	 channel_flags, channel_callbacks, start_reserve,
+	 end_reserve, rchan_start_reserve, resize_min, resize_max)
+
+relay_open() is used to create a new entry in relayfs.  This new entry
+is created according to channel_path.  channel_path contains the
+absolute path to the channel file on relayfs.  If, for example, the
+caller sets channel_path to "/xlog/9", a "xlog/9" entry will appear
+within relayfs automatically and the "xlog" directory will be created
+in the filesystem's root.  relayfs does not implement any policy on
+its content, except to disallow the opening of two channels using the
+same file. There are, nevertheless a set of guidelines for using
+relayfs. Basically, each facility using relayfs should use a top-level
+directory identifying it. The entry created above, for example,
+presumably belongs to the "xlog" software.
+
+The remaining parameters for relay_open() are as follows:
+
+- channel_flags - an ORed combination of attribute values controlling
+  common channel characteristics:
+
+	- logging scheme - relayfs use 2 mutually exclusive schemes
+	  for logging data to a channel.  The 'lockless scheme'
+	  reserves and writes data to a channel without the need of
+	  any type of locking on the channel.  This is the preferred
+	  scheme, but may not be available on a given architecture (it
+	  relies on the presence of a cmpxchg instruction).  It's
+	  specified by the RELAY_SCHEME_LOCKLESS flag.  The 'locking
+	  scheme' either obtains a lock on the channel for writing or
+	  disables interrupts, depending on whether the channel was
+	  opened for SMP or global usage (see below).  It's specified
+	  by the RELAY_SCHEME_LOCKING flag.  While a client may want
+	  to explicitly specify a particular scheme to use, it's more
+	  convenient to specify RELAY_SCHEME_ANY for this flag, which
+	  will allow relayfs to choose the best available scheme i.e.
+	  lockless if supported.
+
+       - overwrite mode (default is RELAY_MODE_CONTINUOUS) -
+	 If RELAY_MODE_CONTINUOUS is specified, writes to the channel
+	 will succeed regardless of whether there are up-to-date
+	 consumers or not.  If RELAY_MODE_NO_OVERWRITE is specified,
+	 the channel becomes 'full' when the total amount of buffer
+	 space unconsumed by readers equals or exceeds the total
+	 buffer size.  With the buffer in this state, writes to the
+	 buffer will fail - clients need to check the return code from
+	 relay_write() to determine if this is the case and act
+	 accordingly.
+
+       - SMP usage - this applies only when the locking scheme is in
+	 use.  If RELAY_USAGE_SMP is specified, it's assumed that the
+	 channel will be used in a per-CPU fashion and consequently,
+	 the only locking that will be done for writes is to disable
+	 local irqs.  If RELAY_USAGE_GLOBAL is specified, it's assumed
+	 that writes to the buffer can occur within any CPU context,
+	 and spinlock_irq_save will be used to lock the buffer.
+
+       - delivery mode - if RELAY_DELIVERY_BULK is specified, the
+	 client will be notified via its deliver() callback whenever a
+	 sub-buffer has been filled.  Alternatively,
+	 RELAY_DELIVERY_PACKET will cause delivery to occur after the
+	 completion of each write.  See the description of the channel
+	 callbacks below for more details.
+
+       - timestamping - if RELAY_TIMESTAMP_TSC is specified and the
+	 architecture supports it, efficient TSC 'timestamps' can be
+	 associated with each write, otherwise more expensive
+	 gettimeofday() timestamping is used.  At the beginning of
+	 each sub-buffer, a gettimeofday() timestamp and the current
+	 TSC, if supported, are read, and are passed on to the client
+	 via the buffer_start() callback.  This allows correlation of
+	 the current time with the current TSC for subsequent writes.
+	 Each subsequent write is associated with a 'time delta',
+	 which is either the current TSC, if the channel is using
+	 TSCs, or the difference between the buffer_start gettimeofday
+	 timestamp and the gettimeofday time read for the current
+	 write.  Note that relayfs never writes either a timestamp or
+	 time delta into the buffer unless explicitly asked to (see
+	 the description of relay_write() for details).
+ 
+- bufsize - the size of the 'sub-buffers' making up the circular channel
+  buffer.  For the lockless scheme, this must be a power of 2.
+
+- nbufs - the number of 'sub-buffers' making up the circular
+  channel buffer.  This must be a power of 2.
+
+  NOTE: if nbufs is 1, relayfs will bypass the normal size
+  checks and will allocate an rvmalloced buffer of size bufsize.
+  This buffer will be freed when relay_close() is called, if the channel
+  isn't still being referenced.
+
+- callbacks - a table of callback functions called when events occur
+  within the data relay that clients need to know about:
+          
+	  - int buffer_start(channel_id, current_write_pos, buffer_id,
+	    start_time, start_tsc, using_tsc) -
+
+	    called at the beginning of a new sub-buffer, the
+	    buffer_start() callback gives the client an opportunity to
+	    write data into space reserved at the beginning of a
+	    sub-buffer.  The client should only write into the buffer
+	    if it specified a value for start_reserve and/or
+	    channel_start_reserve (see below) when the channel was
+	    opened.  In the latter case, the client can determine
+	    whether to write its one-time rchan_start_reserve data by
+	    examining the value of buffer_id, which will be 0 for the
+	    first sub-buffer.  The address that the client can write
+	    to is contained in current_write_pos (the client by
+	    definition knows how much it can write i.e. the value it
+	    passed to relay_open() for start_reserve/
+	    channel_start_reserve).  start_time contains the
+	    gettimeofday() value for the start of the buffer and start
+	    TSC contains the TSC read at the same time.  The using_tsc
+	    param indicates whether or not start_tsc is valid (it
+	    wouldn't be if TSC timestamping isn't being used).
+
+	    The client should return the number of bytes it wrote to
+	    the channel, 0 if none.
+
+	  - int buffer_end(channel_id, current_write_pos, end_of_buffer,
+	    end_time, end_tsc, using_tsc)
+
+	    called at the end of a sub-buffer, the buffer_end()
+	    callback gives the client an opportunity to perform
+	    end-of-buffer processing.  Note that the current_write_pos
+	    is the position where the next write would occur, but
+	    since the current write wouldn't fit (which is the trigger
+	    for the buffer_end event), the buffer is considered full
+	    even though there may be unused space at the end.  The
+	    end_of_buffer param pointer value can be used to determine
+	    exactly the size of the unused space.  The client should
+	    only write into the buffer if it specified a value for
+	    end_reserve when the channel was opened.  If the client
+	    doesn't write anything i.e. returns 0, the unused space at
+	    the end of the sub-buffer is available via relay_info() -
+	    this data may be needed by the client later if it needs to
+	    process raw sub-buffers (an alternative would be to save
+	    the unused bytes count value in end_reserve space at the
+	    end of each sub-buffer during buffer_end processing and
+	    read it when needed at a later time.  The other
+	    alternative would be to use read(2), which makes the
+	    unused count invisible to the caller).  end_time contains
+	    the gettimeofday() value for the end of the buffer and end
+	    TSC contains the TSC read at the same time.  The using_tsc
+	    param indicates whether or not end_tsc is valid (it
+	    wouldn't be if TSC timestamping isn't being used).
+
+	    The client should return the number of bytes it wrote to
+	    the channel, 0 if none.
+
+	  - void deliver(channel_id, from, len)
+
+	    called when data is ready for the client.  This callback
+	    is used to notify a client when a sub-buffer is complete
+	    (in the case of bulk delivery) or a single write is
+	    complete (packet delivery).  A bulk delivery client might
+	    wish to then signal a daemon that a sub-buffer is ready.
+	    A packet delivery client might wish to process the packet
+	    or send it elsewhere.  The from param is a pointer to the
+	    delivered data and len specifies how many bytes are ready.
+
+	  - int needs_resize(channel_id, resize_type,
+	                     suggested_buf_size, suggested_n_bufs)
+
+	    called when a channel's buffers are in danger of becoming
+	    full i.e. the number of unread bytes in the channel passes
+	    a preset threshold, or when the current capacity of a
+	    channel's buffer is no longer needed.  Also called to
+	    notify the client when a channel's buffer has been
+	    replaced.  If resize_type is RELAY_RESIZE_EXPAND or
+	    RELAY_RESIZE_SHRINK, the kernel client should arrange to
+	    call relay_realloc_buffer() with the suggested buffer size
+	    and buffer count, which will allocate (but will not
+	    replace the old one) a new buffer of the recommended size
+	    for the channel.  Note that this function should not be
+	    called with locks held, as it may sleep, but may be called
+	    from within interrupt context - in this case the
+	    allocation will be put on a work queue.  When the
+	    allocation has completed, needs_resize() is again called,
+	    this time with a resize_type of RELAY_RESIZE_REPLACE.  The
+	    kernel client should then arrange to call
+	    relay_replace_buffer() to actually replace the old channel
+	    buffer with the newly allocated buffer.  Note that this
+	    function can be called in any context, but clients should
+	    make sure that the channel isn't currently in use, to
+	    avoid pulling out the rug from under any current users.
+	    Finally, once the buffer replacement has completed,
+	    needs_resize() is again called, this time with a
+	    resize_type of RELAY_RESIZE_REPLACED, to inform the client
+	    that the replacement is complete and additionally
+	    confirming the current sub-buffer size and number of
+	    sub-buffers.
+
+- start_reserve - the number of bytes to be reserved at the start of
+  each sub-buffer.  The client can do what it wants with this number
+  of bytes when the buffer_start() callback is invoked.  Typically
+  clients would use this to write per-sub-buffer header data.
+
+- end_reserve - the number of bytes to be reserved at the end of each
+  sub-buffer.  The client can do what it wants with this number of
+  bytes when the buffer_end() callback is invoked.  Typically clients
+  would use this to write per-sub-buffer footer data.
+
+- channel_start_reserve - the number of bytes to be reserved, in
+  addition to start_reserve, at the beginning of the first sub-buffer
+  in the channel.  The client can do what it wants with this number of
+  bytes when the buffer_start() callback is invoked.  Typically
+  clients would use this to write per-channel header data.
+
+- resize_min - if set, this signifies that the channel is
+  auto-resizeable.  The value specifies the size that the channel will
+  try to maintain as a normal working size, and that it won't go
+  below.  The client makes use of the resizing callbacks and
+  relay_realloc_buffer() and relay_replace_buffer() to actually effect
+  the resize.
+
+- resize_max - if set, this signifies that the channel is
+  auto-resizeable.  The value specifies the maximum size the channel
+  can have as a result of resizing.
+
+Upon successful completion, relay_open() returns a channel id
+to be used for all other operations with the relay. All buffers
+managed by the relay are allocated using rvmalloc/rvfree to allow
+for easy mmapping to user-space.
+
+----------
+int relay_write(channel_id, *data_ptr, count, time_delta_offset)
+
+relay_write() reserves space in the channel and writes count bytes of
+data pointed to by data_ptr to it.  Automatically performs any
+necessary locking, depending on the scheme and SMP usage in effect (no
+locking is done for the lockless scheme regardless of usage).  It
+returns the number of bytes written, or a negative number on failure.
+If time_delta_offset is >= 0, the internal time delta, the internal
+time delta calculated when the slot was reserved will be written at
+that offset.  This is the TSC or gettimeofday() delta between the
+current write and the beginning of the buffer, whichever method is
+being used by the channel.  Trying to write a count larger than the
+bufsize specified to relay_open() (taking into account the reserved
+start-of-buffer and end-of-buffer space as well) will fail.
+
+----------
+struct rchan_reader *add_rchan_reader(int rchan_id, int auto_consume)
+
+add_rchan_reader creates and initializes a non-VFS reader object for a
+channel.  An opaque rchan_reader object is returned on success, and is
+passed to relay_read() when reading the channel.  If the auto_consume
+boolean parameter is 1, the reader is defined to be auto-consuming -
+currently only one auto-consuming reader can be in effect per channel
+- if there is already an auto-consuming reader open, the call will
+fail.  VFS reader objects are automatically created when a file is
+opened using open().
+
+----------
+void remove_rchan_reader(struct rchan_reader *reader)
+
+remove_rchan_reader finds and removes the given reader from the
+channel.  This function is used only by non-VFS readers.  VFS readers
+are automatically removed when the corresponding file object is
+closed.
+
+----------
+int relay_read(reader, buf, count, wait)
+
+relay_read() attempts to read count bytes into buffer.  If there are
+fewer than count bytes available, return available.  if the read would
+cross a sub-buffer boundary, this function will only return the bytes
+available to the end of the sub-buffer; a subsequent read would get
+the remaining bytes (starting from the beginning of the buffer).
+Because we're reading from a circular buffer, if the read would wrap
+around to sub-buffer 0, offset will be reset to 0 to mark the
+beginning of the buffer.  If nothing at all is available, the caller
+will be put on a wait queue until there is.  This function takes into
+account the 'unused bytes', if any, at the end of each sub-buffer, and
+will transparently skip over them.  If buf is NULL, it will return
+the read_count without actually doing the read.
+
+----------
+int relay_read_last(channel_id, buf, count)
+
+Copies the last count bytes in the channel into the user buffer.
+Skips over unused bytes at the end of sub-buffers.  Returns # bytes
+actually read, or negative on error.
+
+----------
+int relay_bytes_avail(channel_id, read_offset)
+
+Returns the number of bytes available in the current buffer, following
+read_offset.  Note that this doesn't return the total bytes available
+in the buffer - this is enough though to know if anything is
+available.
+
+----------
+void relay_buffers_consumed(channel_id, buffers_consumed)
+
+relay_buffers_consumed() updates the channel's buffers_consumed
+counter, which is used in conjunction with its buffers_produced
+counter to determine when a buffers-full condition exists.  The count
+in the buffers_consumed param is added to the channel's
+buffers_consumed counter, which should track the actual number of
+buffers consumed by the client.  This would typically be called once
+the client had finished processing a delivered sub-buffer (bulk
+clients) or had received end-of-buffer notification (packet clients).
+If a client is operating in 'flight recorder' mode it never needs to
+call this function.  If there is an auto-consuming reader, this
+function can also be ignored. 
+
+----------
+void relay_bytes_consumed(channel_id, bytes_consumed, read_offset)
+
+In order for the relay to detect the 'buffers full' condition for a
+channel, it must be kept up-to-date with respect to the number of
+buffers consumed by the client.  If the channel is being used in a
+continuous or 'flight recorder' fashion, this function can be ignored.
+For packet clients, it makes more sense to update after each read
+rather than after each complete sub-buffer read.  The bytes_consumed
+count updates bufs_consumed when a buffer has been consumed so this
+count remains consistent.  If there is an auto-consuming reader, this
+function can also be ignored. 
+
+----------
+int relay_info(channel_id, *channel_info)
+
+relay_info() fills in an rchan_info struct with channel status and
+attribute information such as usage modes, sub-buffer size and count,
+the allocated size of the entire buffer, buffers produced and
+consumed, current buffer id, count of writes lost due to buffers full
+condition.
+
+The virtual address of the channel buffer is also available here, for
+those clients that need it.
+
+Clients may need to know how many 'unused' bytes there are at the end
+of a given sub-buffer.  This would only be the case if the client 1)
+didn't either write this count to the end of the sub-buffer or
+otherwise note it (it's available as the difference between the buffer
+end and current write pos params in the buffer_end callback) (if the
+client returned 0 from the buffer_end callback, it's assumed that this
+is indeed the case) 2) isn't using the read() system call to read the
+buffer.  In other words, if the client isn't annotating the stream and
+is reading the buffer by mmaping it, this information would be needed
+in order for the client to 'skip over' the unused bytes at the ends of
+sub-buffers.
+
+Additionally, for the lockless scheme, clients may need to know
+whether a particular sub-buffer is actually complete.  An array of
+boolean values, one per sub-buffer, contains non-zero if the buffer is
+complete, non-zero otherwise.
+
+----------
+int relay_close(channel_id)
+
+relay_close() is used to close the channel.  It finalizes the last
+sub-buffer (the one currently being written to) and marks the channel
+as finalized.  This doesn't free the channel buffer or channel data
+structure - this is handled automatically when the last reference to
+the channel is given up.
+
+----------
+int relay_realloc_buffer(channel_id, bufsize, nbufs)
+
+relay_realloc_buffer() allocates a new channel buffer using the
+specified sub-buffer size and count.  If called from within interrupt
+context, the allocation is put onto a work queue.  When the allocation
+has completed, the needs_resize() callback is called with a
+resize_type of RELAY_RESIZE_REPLACE.  This function doesn't copy the
+old buffer contents to the new buffer - see relay_replace_buffer().
+This function is called by kernel clients in response to a
+needs_resize() callback call with a resize type of RELAY_RESIZE_EXPAND
+or RELAY_RESIZE_SHRINK.  That callback also includes a suggested
+new_bufsize and new_nbufs which should be used when calling this
+function.  Returns 0 on success, or errcode if the channel is busy or
+if the allocation couldn't happen for some reason.  NOTE: should not
+be called with a lock held, as it may sleep.
+
+----------
+int relay_replace_buffer(channel_id)
+
+relay_replace_buffer() replaces the current channel buffer with the
+new buffer allocated by relay_alloc_buffer and contained in rchan.
+When the replacement is done, the needs_resize() callback is called
+with a resize_type of RELAY_RESIZE_REPLACED.  This function is called
+by kernel clients in response to a needs_resize() callback call with a
+resize type of RELAY_RESIZE_REPLACE.  Because the copy of contents
+from the old buffer into the new can result in sections of the buffer
+being rearranged, if the client is using offsets to reference
+positions within the buffer, those offsets may no longer be valid.
+The resize_offset() callback is used to deal with this situation.
+Returns 0 on success, or errcode if the channel is busy or if the
+replacement or previous allocation didn't happen for some reason.
+NOTE: This function will not sleep, so can called in any context and
+with locks held.  The client should, however, ensure that the channel
+isn't actively being read from or written to.
+
+----------
+int relay_reset(rchan_id)
+
+relay_reset() has the effect of erasing all data from the buffer and
+restarting the channel in its initial state.  The buffer itself is not
+freed, so any mappings are still in effect.  NOTE: Care should be
+taken that the channnel isn't actually being used by anything when
+this call is made.
+
+Writing directly into the channel
+=================================
+
+Using the relay_write() API function as described above is the
+preferred means of writing into a channel.  In some cases, however,
+in-kernel clients might want to write directly into a relay channel
+rather than have relay_write() copy it into the buffer on the client's
+behalf.  Clients wishing to do this should follow the model used to
+implement relay_write itself.  The general sequence is:
+
+- get a pointer to the channel via rchan_get().  This increments the
+  channel's reference count.
+- call relay_lock_channel().  This will perform the proper locking for
+  the channel given the scheme in use and the SMP usage.
+- reserve a slot in the channel via relay_reserve()
+- write directly to the reserved address
+- call relay_commit() to commit the write
+- call relay_unlock_channel()
+- call rchan_put() to release the channel reference
+
+In particular, clients should make sure they call rchan_get() and
+rchan_put() and not hold on to references to the channel pointer.
+Also, forgetting to use relay_lock_channel()/relay_unlock_channel()
+has no effect if the lockless scheme is being used, but could result
+in corrupted buffer contents if the locking scheme is used.
+
+
+Limitations
+===========
+
+Writes made via the write() system call are currently limited to 2
+pages worth of data.  There is no such limit on the in-kernel API
+function relay_write().
+
+User applications can currently only mmap the complete buffer (it
+doesn't really make sense to mmap only part of it, given its purpose).
+
+
+Latest version
+==============
+
+The latest version can be found at:
+
+http://www.opersys.com/relayfs
+
+Example relayfs clients, such as dynamic printk and the Linux Trace
+Toolkit, can also be found there.
+
+
+Credits
+=======
+
+The ideas and specs for relayfs came about as a result of discussions
+on tracing involving the following:
+
+Michel Dagenais		<michel.dagenais@polymtl.ca>
+Richard Moore		<richardj_moore@uk.ibm.com>
+Bob Wisniewski		<bob@watson.ibm.com>
+Karim Yaghmour		<karim@opersys.com>
+Tom Zanussi		<zanussi@us.ibm.com>

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

