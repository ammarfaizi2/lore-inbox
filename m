Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262548AbTCRQYh>; Tue, 18 Mar 2003 11:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262551AbTCRQYg>; Tue, 18 Mar 2003 11:24:36 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:33464 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262548AbTCRQYK>;
	Tue, 18 Mar 2003 11:24:10 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15991.19081.206610.125842@lepton.softprops.com>
Date: Tue, 18 Mar 2003 10:34:17 -0600
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] relayfs, a high-speed data relay filesystem
X-Mailer: VM(ViewMail) 7.01 under Emacs 20.7.2
Cc: karim@opersys.com, bob@watson.ibm.com, richardj_moore@uk.ibm.com,
       michel.dagenais@polymtl.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A kernel patch implementing relayfs, a Linux filesystem designed to
simplify the buffering and efficient transfer of large amounts of data
from kernel to user space for those facilities that need to do such
things, is now available as:

http://www.opersys.com/ftp/pub/relayfs/patch-relayfs-2.5.65-030317.bz2

The relayfs home page, which will host the latest versions of the
above and related patches and info is:

http://www.opersys.com/relayfs

A preliminary description of the characteristics and API for relayfs
was previously posted to this list.  Here's a link to that post:

http://marc.theaimsgroup.com/?l=linux-kernel&m=104196329807755&w=2

I've included at the end of this mail the relayfs doc file
(Documentation/filesystems/relafys.txt), which describes the API in
detail, as currently implemented.

Also, the Linux Trace Toolkit has been reworked to make use of
relayfs; a preliminary kernel patch and updated user tools
are available at the LTT website, and can be used as a concrete
working example of using the API:

http://www.opersys.com/relayfs/ltt-on-relayfs.html

I've tested the relayfs code (via the updated LTT code) on my UP PII
machine and so far haven't seen any problems with it, but I still need
to do SMP testing and otherwise pound more heavily on it - I plan on
generating some benchmark data, which in addition to putting relayfs
through its paces, should give some idea of how much overhead might be
introduced by the API/implementation itself, as compared with the
benchmark data previously posted for LTT without it:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103573710926859&w=2

I wouldn't expect to see much difference, as the underlying logging
code is essentially the same.

Comments welcome.

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

---------

relayfs - a high-speed data relay filesystem
============================================

relayfs is a filesystem designed to provide an efficient mechanism for
tools and facilities to relay large amounts of data from kernel space
to user space.

The main idea behind relayfs is that every data flow is put into a
separate "channel" and each channel is a file.  In practice, each
channel is a separate memory buffer allocated from within kernel space
upon channel instantiation. Software needing to relay data to user
space would open a channel or a number of channels, depending on its
needs, and would log data to that channel. All the buffering and
locking mechanics are taken care of by relayfs.  The actual format and
protocol used for each channel is up to relayfs' clients.

relayfs makes no provisions for copying the same data to more than a
single channel. This is for the clients of the relay to take care of,
and so is any form of data filtering. The purpose is to keep relayfs
as simple as possible.


Usage
=====

In addition to the relayfs kernel API described below, relayfs
implements basic file operations.  Here are the file operations that
are available and some comments regarding their behavior:

open()	 enables user to open an _existing_ channel.

mmap()	 results in channel's memory buffer being mmapped into the
	 caller's memory space.

read()	 since we are dealing with circular buffers, the user is only
	 allowed to read forward.  Some apps may want to loop around
	 read() waiting for incoming data - if there is no data
	 available, read will put the reader on a wait queue until
	 data is available.

write()	 writing from user space operates exactly as relay_write() does
	 (described below).

close()  decrements the channel's refcount.  When the refcount reaches
	 0 i.e. when no process or kernel client has the file open
	 (see relay_close() below), the channel buffer is freed.


In order for a user application to make use of relayfs files, the
relayfs filesystem must be mounted.  For example,

	mount -t relayfs relayfs /mountpoint


The relayfs kernel API
======================

relayfs channels are implemented as circular buffers subdivided into
'sub-buffers'.  kernel clients write data into the channel using
relay_write(), and are notified via a set of callbacks when
significant events occur within the channel.  'Significant events'
include:

- a sub-buffer is full i.e. the current write won't fit into the
  current sub-buffer, and a 'buffer-switch' is triggered, after which
  the data is written into the next buffer (if the next buffer is
  empty).  The client is notified of this condition via two callbacks,
  one providing an opportunity to perform start-of-buffer tasks, the
  other end-of-buffer tasks.

- data is ready for the client to process.  The client can choose to
  be notified either on a per-sub-buffer basis (bulk delivery) or
  per-write basis (packet delivery).

- all sub-buffers are full.  The current write won't fit into the
  current sub-buffer, and the next sub-buffer is also full, thus
  writing the event would overwrite data in the next sub-buffer.  The
  client is notified of this condition and can choose to either go
  ahead and overwrite, or suspend the channel, depending on the value
  it returns.

Here's a summary of the API relayfs provides to in-kernel clients:

int    relay_open(channel_path, bufsize, nbufs, channel_flags, callbacks,
			start_reserve, end_reserve, channel_start_reserve)
int    relay_write(channel_id, *data_ptr, count, time_delta_offset)
void   relay_buffers_consumed(channel_id, buffers_consumed)
void   relay_resume(channel_id)
int    relay_info(channel_id, *channel_info)
int    relay_close(channel_id)

----------
int relay_open(channel_path, bufsize, nbufs, channel_flags, callbacks,
	 start_reserve, end_reserve, channel_start_reserve)

relay_open() is used to create a new entry in relayfs.  This new entry
is created according to channel_path.  channel_path contains the
absolute path to the channel file on relayfs.  If, for example, the
caller sets channel_path to "/xlog/9", a "xlog/9" entry will appear
within relayfs automatically and the "xlog" directory will be created
in the filesystem's root.  relayfs does not implement any policy on
its content, except to disallow the opening of two channels using the
same file. There are, nevertheless a set of guidelines for using
relayfs. Basically, each facility using relayfs should use a top-level
directory identifying it. The entry created above, for example,
presumably belongs to the "xlog" software.

The remaining parameters for relay_open() are as follows:

- channel_flags - an ORed combination of attribute values controlling
  common channel characteristics:

	- logging scheme - relayfs use 2 mutually exclusive schemes
	  for logging data to a channel.  The 'lockless scheme'
	  reserves and writes data to a channel without the need of
	  any type of locking on the channel.  This is the preferred
	  scheme, but may not be available on a given architecture (it
	  relies on the presence of a cmpxchg instruction).  It's
	  specified by the RELAY_SCHEME_LOCKLESS flag.  The 'locking
	  scheme' either obtains a lock on the channel for writing or
	  disables interrupts, depending on whether the channel was
	  opened for SMP or global usage (see below).  It's specified
	  by the RELAY_SCHEME_LOCKING flag.  While a client may want
	  to explicitly specify a particular scheme to use, it's more
	  convenient to specify RELAY_SCHEME_ANY for this flag, which
	  will allow relayfs to choose the best available scheme i.e.
	  lockless if supported.

       - SMP usage - this applies only when the locking scheme is in
	 use.  If RELAY_USAGE_SMP is specified, it's assumed that the
	 channel will be used in a per-CPU fashion and consequently,
	 the only locking that will be done for writes is to disable
	 local irqs.  If RELAY_USAGE_GLOBAL is specified, it's assumed
	 that writes to the buffer can occur within any CPU context,
	 and spinlock_irq_save will be used to lock the buffer.

       - delivery mode - if RELAY_DELIVERY_BULK is specified, the
	 client will be notified via its deliver() callback whenever a
	 sub-buffer has been filled.  Alternatively,
	 RELAY_DELIVERY_PACKET will cause delivery to occur after the
	 completion of each write.  See the description of the channel
	 callbacks below for more details.

       - timestamping - if RELAY_TIMESTAMP_TSC is specified and the
	 architecture supports it, efficient TSC 'timestamps' can be
	 associated with each write, otherwise more expensive
	 gettimeofday() timestamping is used.  At the beginning of
	 each sub-buffer, a gettimeofday() timestamp and the current
	 TSC, if supported, are read, and are passed on to the client
	 via the buffer_start() callback.  This allows correlation of
	 the current time with the current TSC for subsequent writes.
	 Each subsequent write is associated with a 'time delta',
	 which is either the current TSC, if the channel is using
	 TSCs, or the difference between the buffer_start gettimeofday
	 timestamp and the gettimeofday time read for the current
	 write.  Note that relayfs never writes either a timestamp or
	 time delta into the buffer unless explicitly asked to (see
	 the description of relay_write() for details).
 
- bufsize - the size of the 'sub-buffers' making up the circular
  channel buffer.  For the lockless scheme, this must be a power of 2.
  The locking scheme can use any size, but if RELAY_SCHEME_ANY is
  specified, a bufsize that's a power of two would ensure that either
  scheme could be used.

- nbufs - the number of 'sub-buffers' making up the circular channel
  buffer.  This must be a power of 2 for the lockless scheme, and
  exactly 2 for the locking scheme.  If RELAY_SCHEME_ANY is used and
  the locking scheme is the only one available, the number of buffers
  will be automatically set to 2, thus if this flag is used, it's a
  good idea to specify the number of buffers preferred for the
  lockless scheme, in case that's the one chosen.

- callbacks - a table of callback functions called when events occur
  within the data relay that clients need to know about:
          
	  - int buffer_start(channel_id, current_write_pos, buffer_id,
	    start_time, start_tsc, using_tsc) -

	    called at the beginning of a new sub-buffer, the
	    buffer_start() callback gives the client an opportunity to
	    write data into space reserved at the beginning of a
	    sub-buffer.  The client should only write into the buffer
	    if it specified a value for start_reserve and/or
	    channel_start_reserve (see below) when the channel was
	    opened.  In the latter case, the client can determine
	    whether to write its one-time rchan_start_reserve data by
	    examining the value of buffer_id, which will be 0 for the
	    first sub-buffer.  The address that the client can write
	    to is contained in current_write_pos (the client by
	    definition knows how much it can write i.e. the value it
	    passed to relay_open() for start_reserve/
	    channel_start_reserve).  start_time contains the
	    gettimeofday() value for the start of the buffer and start
	    TSC contains the TSC read at the same time.  The using_tsc
	    param indicates whether or not start_tsc is valid (it
	    wouldn't be if TSC timestamping isn't being used).

	    The client should return the number of bytes it wrote to
	    the channel, 0 if none.

	  - int buffer_end(channel_id, current_write_pos, end_of_buffer,
	    end_time, end_tsc, using_tsc)

	    called at the end of a sub-buffer, the buffer_end()
	    callback gives the client an opportunity to perform
	    end-of-buffer processing.  Note that the current_write_pos
	    is the position where the next write would occur, but
	    since the current write wouldn't fit (which is the trigger
	    for the buffer_end event), the buffer is considered full
	    even though there may be unused space at the end.  The
	    end_of_buffer param pointer value can be used to determine
	    exactly the size of the unused space.  The client should
	    only write into the buffer if it specified a value for
	    end_reserve when the channel was opened.  If the client
	    doesn't write anything i.e. returns 0, the unused space at
	    the end of the sub-buffer is available via relay_info() -
	    this data may be needed by the client later if it needs to
	    process raw sub-buffers (an alternative would be to save
	    the unused bytes count value in end_reserve space at the
	    end of each sub-buffer during buffer_end processing and
	    read it when needed at a later time.  The other
	    alternative would be to use read(2), which makes the
	    unused count invisible to the caller).  end_time contains
	    the gettimeofday() value for the end of the buffer and end
	    TSC contains the TSC read at the same time.  The using_tsc
	    param indicates whether or not end_tsc is valid (it
	    wouldn't be if TSC timestamping isn't being used).

	    The client should return the number of bytes it wrote to
	    the channel, 0 if none.

	  - void deliver(channel_id, from, len)

	    called when data is ready for the client.  This callback
	    is used to notify a client when a sub-buffer is complete
	    (in the case of bulk delivery) or a single write is
	    complete (packet delivery).  A bulk delivery client might
	    wish to then signal a daemon that a sub-buffer is ready.
	    A packet delivery client might wish to process the packet
	    or send it elsewhere.  The from param is a pointer to the
	    delivered data and len specifies how many bytes are ready.

	  - int buffers_full(channel_id)

	    called when a buffers-full condition is detected.  This
	    callback is used to notify a client that further writes to
	    the channel will result in unread data being overwritten.
	    The client can signal that it doesn't want this to happen
	    by returning 1, which will 'suspend' the channel.  Further
	    writes to the channel will be discarded, and the channel's
	    events_lost counter will be incremented for each discarded
	    write.  The channel can be subsequently 'resumed' by
	    calling the relay_resume() API function.  If the client
	    returns 0, writing will continue unhindered into the next
	    sub-buffer.  This 'feature' could be used to implement
	    'flight recorder' applications, for instance.

- start_reserve - the number of bytes to be reserved at the start of
  each sub-buffer.  The client can do what it wants with this number
  of bytes when the buffer_start() callback is invoked.  Typically
  clients would use this to write per-sub-buffer header data.

- end_reserve - the number of bytes to be reserved at the end of each
  sub-buffer.  The client can do what it wants with this number of
  bytes when the buffer_end() callback is invoked.  Typically clients
  would use this to write per-sub-buffer footer data.

- channel_start_reserve - the number of bytes to be reserved, in
  addition to start_reserve, at the beginning of the first sub-buffer
  in the channel.  The client can do what it wants with this number of
  bytes when the buffer_start() callback is invoked.  Typically
  clients would use this to write per-channel header data.

Upon successful completion, relay_open() returns a channel id
to be used for all other operations with the relay. All buffers
managed by the relay are allocated using rvmalloc/rvfree to allow
for easy mmapping to user-space.

----------
int relay_write(channel_id, *data_ptr, count, time_delta_offset)

relay_write() reserves space in the channel and writes count bytes of
data pointed to by data_ptr to it.  Automatically performs any
necessary locking, depending on the scheme and SMP usage in effect (no
locking is done for the lockless scheme regardless of usage).  It
returns the number of bytes written, or a negative number on failure.
If time_delta_offset is >= 0, the internal time delta, the internal
time delta calculated when the slot was reserved will be written at
that offset.  This is the TSC or gettimeofday() delta between the
current write and the beginning of the buffer, whichever method is
being used by the channel.  Trying to write a count larger than the
bufsize specified to relay_open() (taking into account the reserved
start-of-buffer and end-of-buffer space as well) will fail.

----------
void relay_buffers_consumed(channel_id, buffers_consumed)

relay_buffers_consumed() updates the channel's buffers_consumed
counter, which is used in conjunction with its buffers_produced
counter to determine when a buffers_full condition exists.  The count
in the buffers_consumed param is added to the channel's
buffers_consumed counter, which should track the actual number of
buffers consumed by the client.  This would typically be called once
the client had finished processing a delivered sub-buffer (bulk
clients) or had received end-of-buffer notification (packet clients).
If a client is operating in 'flight recorder' mode it never needs to
call this function; suspending the channel in this case would be done
by returning 1 from the next buffers_full calback, and the channel
could be subsequently resumed via relay_resume(), which automatically
'catches up' the buffers_consumed count with buffers_produced.

----------
void relay_resume(channel_id)

relay_resume() resume a suspended channel.  A channel that had a
'buffers full' condition detected for it, and was told to 'suspend'
via a non-zero buffers_full callback return value can again be written
to following this call.

----------
int relay_info(channel_id, *channel_info)

relay_info fills in an rchan_info struct with channel status and
attribute information such as usage modes, sub-buffer size and count,
the allocated size of the entire buffer, buffers produced and
consumed, current buffer id, count of writes lost due to buffers full
condition.

Clients may need to know how many 'unused' bytes there are at the end
of a given sub-buffer.  This would only be the case if the client 1)
didn't either write this count to the end of the sub-buffer or
otherwise note it (it's available as the difference between the buffer
end and current write pos params in the buffer_end callback) (if the
client returned 0 from the buffer_end callback, it's assumed that this
is indeed the case) 2) isn't using the read() system call to read the
buffer.  In other words, if the client isn't annotating the stream and
is reading the buffer by mmaping it, this information would be needed
in order for the client to 'skip over' the unused bytes at the ends of
sub-buffers.

Additionally, for the lockless scheme, clients may need to know
whether a particular sub-buffer is actually complete.  An array of
boolean values, one per sub-buffer, contains non-zero if the buffer is
complete, non-zero otherwise.

----------
int relay_close(channel_id)

relay_close is used to close the channel.  It finalizes the last
sub-buffer (the one currently being written to) and marks the channel
as finalized.  This doesn't free the channel buffer or channel data
structure - this is handled automatically when the last reference to
the channel is given up.


Writing directly into the channel
=================================

Using the relay_write() API function as described above is the
preferred means of writing into a channel.  In some cases, however,
in-kernel clients might want to write directly into a relay channel
rather than have relay_write() copy it into the buffer on the client's
behalf.  Clients wishing to do this should follow the model used to
implement relay_write itself.  The general sequence is:

- get a pointer to the channel via rchan_get().  This increments the
  channel's reference count.
- call relay_lock_channel().  This will perform the proper locking for
  the channel given the scheme in use and the SMP usage.
- reserve a slot in the channel via relay_reserve()
- write directly to the reserved address
- call relay_commit() to commit the write
- call relay_unlock_channel()
- call rchan_put() to release the channel reference

In particular, clients should make sure they call rchan_get() and
rchan_put() and not hold on to references to the channel pointer.
Also, forgetting to use relay_lock_channel()/relay_unlock_channel()
has no effect if the lockless scheme is being used, but could result
in corrupted buffer contents if the locking scheme is used.


Limitations
===========

Writes made via the write() system call are currently limited to 2
pages worth of data.  There is no such limit on the in-kernel API
function relay_write().

User applications can currently only mmap the complete buffer (it
doesn't really make sense to mmap only part of it, given its purpose).


Latest version
==============

The latest version can be found at:

http://www.opersys.com

An example relayfs client, the Linux Trace Toolkit, can also be found
there.


Credits
=======

The ideas and specs for relayfs came about as a result of discussions
on tracing involving the following:

Michel Dagenais		<michel.dagenais@polymtl.ca>
Richard Moore		<richardj_moore@uk.ibm.com>
Bob Wisniewski		<bob@watson.ibm.com>
Karim Yaghmour		<karim@opersys.com>
Tom Zanussi		<zanussi@us.ibm.com>

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

