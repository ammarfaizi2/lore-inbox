Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269392AbTGOSby (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 14:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269414AbTGOSby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 14:31:54 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:31917 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269392AbTGOSbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 14:31:52 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16148.19417.800465.402070@gargle.gargle.HOWL>
Date: Tue, 15 Jul 2003 13:45:45 -0500
To: Gianni Tedesco <gianni@scaramanga.co.uk>
Cc: Tom Zanussi <zanussi@us.ibm.com>, linux-kernel@vger.kernel.org,
       karim@opersys.com, bob@watson.ibm.com
Subject: Re: [RFC][PATCH 0/5] relayfs
In-Reply-To: <1058287227.377.17.camel@sherbert>
References: <16148.6807.578262.720332@gargle.gargle.HOWL>
	<1058282847.375.3.camel@sherbert>
	<16148.9560.602996.872584@gargle.gargle.HOWL>
	<1058287227.377.17.camel@sherbert>
X-Mailer: VM(ViewMail) 7.01 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gianni Tedesco writes:
 > On Tue, 2003-07-15 at 17:01, Tom Zanussi wrote:
 > >  > 
 > >  > Could this be used to replace mmap() packet socket, how does it compare?
 > > 
 > > I think so - you could send high volumes of packet traffic to a bulk
 > > relayfs channel and read it from the mmap'ed relayfs file in user
 > > space.  The Linux Trace Toolkit does the same thing with large volumes
 > > of trace data - you could look at that code as an example
 > > (http://www.opersys.com/relayfs/ltt-on-relayfs.html).
 > 
 > What are the semantics of the mmap'ing the buffer? With mmaped packet
 > socket the userspace (read-side) requires no sys-calls apart from when
 > the buffer is empty, it then uses poll(2) to sleep until something new
 > is put in the buffer. Can relayfs do a similar thing? poll is not
 > mentioned in the docs...

Just thinking a bit more about implementing poll() - that part should
be pretty simple, but how does the read-side know how much to read,
unless it's reading fixed-size blocks?  To do that without using a
system call or IOCTL or sysfs file, you could reserve a part of the
channel or a part of each sub-buffer (relayfs channels are subdivided
into a number of sub-buffers) for info the read-side would need in
order to read what's ready.  The rchan_start_reserve, start_reserve,
and end_reserve parameters to relay_open() are used for this purpose.
The one complication here is that if an event won't fit into the
current sub-buffer, the remainder will be filled with filler, and the
event will be put into the following sub-buffer.  The amount of filler
is available from within the buffer_end() callback, and this value
should also be part of the data the read-side would need in order to
process the event.  The size lost to filler shouldn't be an issue if
you use a large enough sub-buffer size and should be pretty easy to
account for in your user-side application.

LTT makes use of all of the above, but as a 'bulk' client, meaning it
processes complete sub-buffers, doesn't need to be super-efficient on
sub-buffer boundaries, and can get away with using a signal/syscall
protocol.  dynamic printk, another relayfs client, is a 'packet'
client, meaning its readers are notified after each completed write,
but its userspace app (klogd) basically loops on read(2).  What I
think you want is to be a 'packet' client, and to implement your
protocol using space reserved within the mmapped buffer.  I think
relayfs has all the elements you'd need to do this pretty easily, with
the exception of the poll(2) support, which is at the top of my todo
list.

Hope this helps,

Tom

 > 
 > Thanks.
 > 
 > -- 
 > // Gianni Tedesco (gianni at scaramanga dot co dot uk)
 > lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
 > 8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D
 > 

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

