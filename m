Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbTDWDrM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 23:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263946AbTDWDrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 23:47:11 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:61404 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263945AbTDWDrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 23:47:10 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16038.3933.389383.172250@lepton.softprops.com>
Date: Tue, 22 Apr 2003 22:58:21 -0500
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Tom Zanussi'" <zanussi@us.ibm.com>,
       "'karim@opersys.com'" <karim@opersys.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [patch] printk subsystems
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780C263B3E@orsmsx116.jf.intel.com>
References: <A46BBDB345A7D5118EC90002A5072C780C263B3E@orsmsx116.jf.intel.com>
X-Mailer: VM(ViewMail) 7.01 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perez-Gonzalez, Inaky writes:
 > 
 > > From: Tom Zanussi [mailto:zanussi@us.ibm.com]
 > > Perez-Gonzalez, Inaky writes:
 > >  > > From: Tom Zanussi [mailto:zanussi@us.ibm.com]
 > >  > >
 > >  > > In relayfs, the event can be generated directly into the space
 > >  > > reserved for it - in fact this is exactly what LTT does.  There
 > aren't
 > >  > > two separate steps, one 'generating' the event and another copying it
 > >  > > to the relayfs buffer, if that's what you mean.
 > >  >
 > >  > In this case, what happens if the user space, through mmap, copies
 > >  > while the message is half-baked (ie, from another CPU) ... won't it
 > >  > be inconsistent?
 > > 
 > > There's a count kept, per sub-buffer, that's updated after each write.
 > > If this count doesn't match the expected size of the sub-buffer, the
 > > reader can ignore the incomplete buffer and come back to it later.
 > > The count is maintained automatically by relay_write(); if you're
 > > writing directly into the channel as LTT does though, part of the task
 > > is to call relay_commit() after the write, which updates the count and
 > > maintains consistency.
 > 
 > Hmmm, scratch, scratch ... there is something I still don't get here. 
 > I am in lockless_commit() - for what you say, and what I read, I would 
 > then expect the length of the sub-buffer would be mapped to user space, 
 > so I can memcpy out of the mmaped area and then take only the part that
 > is guaranteed to be consistent. But the atomic_add() is done on the 
 > rchan->scheme.lockless.fillcount[buffer_number]. So, I don't see how
 > that count pops out to user space, as rchan->buf to rchan->buf + rchan->
 > alloc_size is what is mapped, and rchan is a kernel-only struct that
 > is not exposed through mmap().
 > 

It 'pops' out to user space through some protocol defined between a
relayfs kernel client and the user space program.  relayfs doesn't say
anything about the protocol, but does provide the kernel client enough
information about the state of the channel via relay_info(), which
supplies among other things (these aren't the real names, they're
changed here to make things maybe a little clearer):

n_subbufs - number of sub-buffers
subbuf_size - size of each sub-bufer
subbuf_complete[] - array of booleans basically the result of 
		  fillcount[subbuf_no] == subbuf_size
subbufs_produced - by the channel
subbufs_consumed - by userspace client, maybe

This is enough information for a userspace client to figure out what
to log.  How it gets there and when is up to the client.  For
instance, the kernel client could send a signal whenever a sub-buffer
is full (which it's notified of, if it chooses to be, by a delivery
callback).  The user client could then do something like

buf = mmap(fd, n_bufs * bufsize); /* whole channel is mapped */ 

sighandler()
{
	get_channel_info_from_kernel(&info); /* ioctl/procfs/sysfs/... */
	subbufs_ready = subbufs_produced - subbufs_consumed;
	for(i=0; i<subbufs_ready; i++) {
		 subbuf_no = (subbufs_consumed + i) % n_subbufs;
		 if(!buffer_complete[subbuf_no])
			break; /* Try again next sig */
		 write(log_fd, buf + subbufno * subbuf_size, subbuf_size);
	 }
}

 > And then, once I have this, next time I read I don't want to read
 > what I already did; I guess I can advance my buf pointer to 
 > buf+real_size, but then how do I wrap around - meaning, how do I
 > detect when do I have to wrap?
 > 

Wrapping is taken care of automatically in the above code.

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

