Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267544AbTAGSD4>; Tue, 7 Jan 2003 13:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267546AbTAGSD4>; Tue, 7 Jan 2003 13:03:56 -0500
Received: from nameservices.net ([208.234.25.16]:57160 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S267544AbTAGSDx>;
	Tue, 7 Jan 2003 13:03:53 -0500
Message-ID: <3E1B17DF.BCC51B3@opersys.com>
Date: Tue, 07 Jan 2003 13:09:35 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] High-speed data relay filesystem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As I mentioned earlier on this list, there is an increasing number
of facilities and tools that need to relay large amounts of data from
kernel space to user space. Up to this point, each of these has had
its own mechanism for relaying data. The following is a proposal to
implement a "high-speed data relay filesystem" (relayfs) that would
supersede the individual mechanisms. As such, things like LTT, printk,
EVLog, etc. would all use relayfs to get their data to user-space.
The use of relayfs would, for example, avoid lost printk's. It would
also result in the standardization of the way in which large amounts
of data are transferred from kernel space to user space.

The approach used here is to keep relayfs as simple as possible but
flexible enough to allow future enhancements.

The main idea behind the relayfs is that every data flow is put into
a separate "channel" and each channel is a file. In practice, each
channel is a separate memory buffer allocated from within kernel
space upon channel instantiation. Software needing to relay
data to user space would open a channel or a number of channels,
depending on its needs, and would log data to that channel. All
the buffering and locking mechanics are taken care of by the
relayfs.

Here is a summary of the API relayfs would provide within the kernel:

int  relay_open(channel_str, bufsize, nbufs, flags, callbacks)
int  relay_write(channel_handle, data_ptr, data_len)
int  relay_seek(channel_handle, int offset)
void relay_info(channel_handle, &channel_struct)
void relay_close(channel_handle)

relay_open is used to create a new entry in the relayfs. This new
entry is created according to channel_str. The channel_str contains
the absolute path to the channel file on relayfs. If, for example,
the caller sets channel_str to "/xlog/9", a "xlog/9" entry will
appear within relayfs automatically and the "xlog" directory will
be created in the filesystem's root. This one-to-one mapping
facilitates the operation of the various software using the relayfs.
relayfs does not implement any policy on its content, except to
disallow the opening of two channels using the same file. There are,
nevertheless a set of guidelines for using relayfs. Basically, each
software using relayfs should use a top-level directory identifying
it. The entry created above, for example, presumably belongs to the
"xlog" software.

The rest of the parameters for relay_open are as follows:
 
bufsize = size of 'sub-buffers' making up the circular
          channel buffer
nbufs = number of 'sub-buffers' making up the circular
          channel buffer

The flags parameter incorporates attributes controlling common data
relay characteristics such as:

BULK_DELIVERY/PACKET_DELIVERY - whether to notify clients 
      when a complete sub-buffer has been filled or 
      alternatively when any event is logged to the buffer.
LOCKLESS/LOCKING - which scheme to use for logging data 

callbacks = a table of callback functions called when
          events occur within the data relay that clients
          need to know about.  So far, we have:
          
          delivery notification - clients are notified
              whenever a buffer is complete or an event
              has been logged, according to the delivery 
              flag specified when opening the channel
              e.g. BULK/PACKET.

          end-of-buffer notification - allows clients to 
              write special end-of-buffer info into the
              buffer being completed.
          
          start-of-buffer notification - allows clients to
              write buffer-start info into the buffer being
              started.

["clients" referred to above are the in-kernel clients of relayfs]

Upon successful completion, relay_open() returns a channel handle
to be used for all other operations with the relay. All buffers
managed by the relay are allocated using rvmalloc/rvfree to allow
for easy mmapping to user-space. Should this be configurable (as a
flag to open_channel; no rvmalloc == no mmap possible)?

relay_write() and relay_close() are self-explicit. relay_seek()
enables clients to move around the buffer, forward or backwards.
Though this should not usually be utilized, it may be needed in
some cases where overwriting data is needed. relay_info() fills
the channel_struct with detailed information regarding the
channel, including the location of the memory buffers. Most
software should not need this, but this needs to be available for
software that makes unconventional use of relayed memory buffers,
such as direct writing.

The relay makes no provisions for copying the same data to more
than a single channel. This is for the clients of the relay to
take care of, and so is any form of data filtering. The purpose is
to keep the relay as simple as possible.

In addition to the API provided in the kernel, relayfs will also
need to implement the basic file operations. Here are the file
operations that should be made available and some comments regarding
their behavior:

open(): enables user to open an _existing_ channel.
read(): since we are dealing with circular buffers, the user should
only be allowed to read forward. Some apps may want to loop around
read() waiting for incoming data.
write(): writing from user space should be managed by a flag to
relay_open() and should operate very much like relay_write() does.
release(): has no effect on whether data actually gets written to the
channel.
mmap(): results in channel's memory buffer to be mmapped to the
caller's memory space.

That's it. All signaling of buffer switching should be taken care
of by the callback invoked by the relay. (The callback had been
provided when relay_open() was invoked). The actual format and
protocol used for each channel is up to relayfs' clients. Whenever
appropriate, relayfs will provide simple _generic_ mechanisms for
implementing formats and protocols.

Internally, the relay will use the locking/lockless code already
implemented in the trace subsystem provided with LTT. This also
implies that LTT will entirely rely on relayfs in the future.
They are, however, separate and will be maintained as such. In
essence, LTT will be yet another client of relayfs, as should
any other software that relays large amounts of data from kernel
space to user space, including syslog, evlog, oprofile, etc.

As suggested here, relayfs is a very simple and efficient abstraction
that will help clean up quite a few buffering schemes already
implemented by other means, each with their way of enabling user
space access to data collected in the kernel.

Comments and suggestions are welcomed,

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
