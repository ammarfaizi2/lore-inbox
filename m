Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbVAPFyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbVAPFyg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 00:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVAPFyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 00:54:33 -0500
Received: from opersys.com ([64.40.108.71]:51470 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262434AbVAPFyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 00:54:19 -0500
Message-ID: <41EA0307.6020807@opersys.com>
Date: Sun, 16 Jan 2005 01:00:39 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Andi Kleen <ak@muc.de>, Nikita Danilov <nikita@clusterfs.com>,
       linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de> <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de> <41E7A7A6.3060502@opersys.com> <Pine.LNX.4.61.0501141626310.6118@scrub.home> <41E8358A.4030908@opersys.com> <Pine.LNX.4.61.0501150101010.30794@scrub.home> <41E899AC.3070705@opersys.com> <Pine.LNX.4.61.0501160245180.30794@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0501160245180.30794@scrub.home>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Roman,

Roman Zippel wrote:
> It's interesting to read more about ltt's requirements, but I still think 
> it's possible to leave this work to the relayfs layer.

Ok, I'm willing to play ball, but can you be a little bit more specific.

> Why not just move the ltt buffer management into relayfs and provide a 
> small library, which extracts the event stream again? Otherwise you have 
> to duplicate this work for every serious relayfs user anyway.

Ok, I've been meditating over what you say above for some time in order
to understand how best to follow what you are suggesting. So here's
what I've been able to come up with. Let me know if you have other
suggestions:

Drop the buffer-start/end callbacks altogether. Instead, allow user
to specify in the channel properties whether they want to have
sub-buffer delimiters. If so, relayfs would automatically prepend
and append the structures currently written by ltt:
/* Start of trace buffer information */
typedef struct _ltt_buffer_start {
	struct timeval time;	/* Time stamp of this buffer */
	u32 tsc;   		/* TSC of this buffer, if applicable */
	u32 id;			/* Unique buffer ID */
} LTT_PACKED_STRUCT ltt_buffer_start;

/* End of trace buffer information */
typedef struct _ltt_buffer_end {
	struct timeval time;	/* Time stamp of this buffer */
	u32 tsc;   		/* TSC of this buffer, if applicable */
} LTT_PACKED_STRUCT ltt_buffer_end;

This would also allow dropping the start_reserve, end_reserve, and
channel_start_reserve. The latter can be added by ltt as its first
event.

Is this what you are looking for and is there something else we should
be doing.

> Completely abstracting the buffer management would the make whole 
> interface simpler and it would be a lot easier to change without breaking 
> everything. E.g. it would be possible to use per cpu buffers and remove 
> the need for different locking mechanisms, for a good tracing mechanism 
> it's not just important that it's lockless, but also that the cpus don't 
> share cache lines in the fast path. In this regard relayfs/ltt has really 
> still too much overhead and the complex relayfs API isn't really making it 
> easy to fix this.

The per-cpu buffering issue is really specific to the client. It just
so happens that LTT creates one channel for each CPU. Not everyone
who needs to ship lots of data to user-space needs/wants one channel
per cpu. You could, for example, use a relayfs channel as a big
chunk of memory visible to both a user-space app and its kernel buddy
in order to exchange data without ever using either needing more
than one such channel for your entire subsystem.

As for lockless vs. locking there is a need for both. Not having
to get locks has obvious advantages, but if you require strict
timing you will want to use the locking scheme because its logging
time is linear (see Thomas' complaints about lockless elsewhere
in this thread, and Ingo's complaints about relayfs somewhere back
in October.)

But in trying to make things simpler, here's a reworked API:

rchan* relay_open(channel_path, mode, bufsize, nbufs);
int    relay_close(*rchan);
int    relay_reset(*rchan)
int    relay_write(*rchan, *data_ptr, count, **wrote-pos);

int    relay_info(*rchan, *channel_info)
void   relay_set_property(*rchan, property, value);
void   relay_get_property(*rchan, property, *value);

For direct writing (currently already used by ltt, for example):

char*  relay_reserve(*rchan, len, *ts, *td, *err, *interrupting)
void   relay_commit(*rchan, *from, len, reserve_code, interrupting);

These are the related macros:

#define relay_write_direct(DEST, SRC, SIZE) \
#define relay_lock_channel(RCHAN, FLAGS) \
#define relay_unlock_channel(RCHAN, FLAGS) \

As I hinted elsewhere, we would now have three modes for relayfs
channels:
- locking => relies on local_irq_save.
- lockless => relies on try_reserve/fail->retry (based on cmpxchg).
- kdebug => this is for kernel debugging.

The last one could be based on Ingo's tracing code, or any
implementation suggestions by Thomas. It wouldn't do all
the checks and provide all the capabilities of the other two
mechanisms, but would really be a hot-path logger with only
minimalistic provisions for content loss and other such things.

(note to Tom: time_delta_offset that used to be in relay_write
should be a property set using relay_set_property).

What I'm dropping for now is all the functions that allow a
subsystem to read from a channel from within the kernel. So,
for example, if you want to obtain large amounts of data from
user-space via a relayfs channel you won't be able to. Here
are the functions that would go:

rchan_reader *add_rchan_reader(channel_id, auto_consume)
int    remove_rchan_reader(rchan_reader *reader)
rchan_reader *add_map_reader(channel_id)
int    remove_map_reader(rchan_reader *reader)
int    relay_read(reader, buf, count, wait, *actual_read_offset)
void   relay_buffers_consumed(reader, buffers_consumed)
void   relay_bytes_consumed(reader, bytes_consumed, read_offset)
int    relay_bytes_avail(reader)
int    rchan_full(reader)
int    rchan_empty(reader)

We could add these at a later time when/if needed. Removing
these changes nothing for ltt.

Also, we should try to get rid of the following. They are there
for allowing dynamically-resizable buffers, but if we are to
make buffer-management opaque, then this should be done
internally (Tom: I can't remember the rationale for these. Let
me know if there's a reason why the must be kept.)

int    relay_realloc_buffer(*rchan, nbufs, async)
int    relay_replace_buffer(*rchan)

I think this is a pretty major change and simplification of the
API along the lines of what others have asked for. Let me know
what you think.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
