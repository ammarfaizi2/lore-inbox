Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262559AbVAPSTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbVAPSTH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 13:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVAPSTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 13:19:07 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:18148 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262559AbVAPSS6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 13:18:58 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16874.47855.427013.376104@tut.ibm.com>
Date: Sun, 16 Jan 2005 13:05:19 -0600
To: karim@opersys.com
Cc: Roman Zippel <zippel@linux-m68k.org>, Andi Kleen <ak@muc.de>,
       Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org,
       Tom Zanussi <zanussi@us.ibm.com>, frankeh@watson.ibm.com
Subject: Re: 2.6.11-rc1-mm1
In-Reply-To: <41EA0307.6020807@opersys.com>
References: <20050114002352.5a038710.akpm@osdl.org>
	<m1zmzcpfca.fsf@muc.de>
	<m17jmg2tm8.fsf@clusterfs.com>
	<20050114103836.GA71397@muc.de>
	<41E7A7A6.3060502@opersys.com>
	<Pine.LNX.4.61.0501141626310.6118@scrub.home>
	<41E8358A.4030908@opersys.com>
	<Pine.LNX.4.61.0501150101010.30794@scrub.home>
	<41E899AC.3070705@opersys.com>
	<Pine.LNX.4.61.0501160245180.30794@scrub.home>
	<41EA0307.6020807@opersys.com>
X-Mailer: VM 7.18 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour writes:
 > 
 > What I'm dropping for now is all the functions that allow a
 > subsystem to read from a channel from within the kernel. So,
 > for example, if you want to obtain large amounts of data from
 > user-space via a relayfs channel you won't be able to. Here
 > are the functions that would go:
 > 
 > rchan_reader *add_rchan_reader(channel_id, auto_consume)
 > int    remove_rchan_reader(rchan_reader *reader)
 > rchan_reader *add_map_reader(channel_id)
 > int    remove_map_reader(rchan_reader *reader)
 > int    relay_read(reader, buf, count, wait, *actual_read_offset)
 > void   relay_buffers_consumed(reader, buffers_consumed)
 > void   relay_bytes_consumed(reader, bytes_consumed, read_offset)
 > int    relay_bytes_avail(reader)
 > int    rchan_full(reader)
 > int    rchan_empty(reader)
 > 
 > We could add these at a later time when/if needed. Removing
 > these changes nothing for ltt.

One of the things that uses these functions to read from a channel
from within the kernel is the relayfs code that implements read(2), so
taking them away means you wouldn't be able to use read() on a relayfs
file.  That wouldn't matter for ltt since it mmaps the file, but there
are existing users of relayfs that do use relayfs this way.  In fact,
most of the bug reports I've gotten are from people using it in this
mode.  That doesn't mean though that it's necessarily the right thing
for relayfs or these users to be doing if they have suitable
alternatives for passing lower-volume messages in this way.  As others
have mentioned, that seems to be the major question - should relayfs
concentrate on being solely a high-speed data relay mechanism or
should it try to be more, as it currently is implemented?  If the
former, then I wonder if you need a filesystem at all - all you have
is a collection of mmappable buffers and the only thing the filesystem
provides is the namespace.  Removing read()/write() and filesystem
support would of course greatly simplify the code; I'd like to hear
from any existing users though and see what they'd be missing.

ltt would still need at least relay_buffers_consumed() though.  This
is used to support the 'no-overwrite' option, which means that when
the buffers are full i.e. the daemon has fallen behind and needs to
catch up, channel writing is 'suspended' until it catches up.

 > 
 > Also, we should try to get rid of the following. They are there
 > for allowing dynamically-resizable buffers, but if we are to
 > make buffer-management opaque, then this should be done
 > internally (Tom: I can't remember the rationale for these. Let
 > me know if there's a reason why the must be kept.)
 > 
 > int    relay_realloc_buffer(*rchan, nbufs, async)
 > int    relay_replace_buffer(*rchan)

relay_realloc_buffer actually does the work of allocating the new
buffer space for used for resizing, and since it can sleep, it's done
in the background using a work queue.  When everything's ready, the
channel buffer can then be replaced, thus relay_replace_buffer().

The only user of channel resizing that I know of is the 'dynamically
resizeable printk replacement' I posted awhile back, and that
apparently doesn't have any users, so I'd be happy to get rid of all
the resizing code.

Tom

 > 
 > I think this is a pretty major change and simplification of the
 > API along the lines of what others have asked for. Let me know
 > what you think.
 > 
 > Karim
 > -- 
 > Author, Speaker, Developer, Consultant
 > Pushing Embedded and Real-Time Linux Systems Beyond the Limits
 > http://www.opersys.com || karim@opersys.com || 1-866-677-4546

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

