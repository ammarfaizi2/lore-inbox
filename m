Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVGRN2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVGRN2Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 09:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVGRN2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 09:28:24 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:58857 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261317AbVGRN2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 09:28:22 -0400
Subject: Re: [PATCH] Re: relayfs documentation sucks?
From: Steven Rostedt <rostedt@goodmis.org>
To: bert hubert <bert.hubert@netherlabs.nl>
Cc: relayfs-devel@lists.sourceforge.net, richardj_moore@uk.ibm.com,
       varap@us.ibm.com, karim@opersys.com, linux-kernel@vger.kernel.org,
       Tom Zanussi <zanussi@us.ibm.com>
In-Reply-To: <20050717194558.GC27353@outpost.ds9a.nl>
References: <17107.6290.734560.231978@tut.ibm.com>
	 <20050716210759.GA1850@outpost.ds9a.nl>
	 <17113.38067.551471.862551@tut.ibm.com>
	 <20050717090137.GB5161@outpost.ds9a.nl>
	 <17114.31916.451621.501383@tut.ibm.com>
	 <20050717194558.GC27353@outpost.ds9a.nl>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 18 Jul 2005 09:27:54 -0400
Message-Id: <1121693274.12862.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-17 at 21:45 +0200, bert hubert wrote:
> On Sun, Jul 17, 2005 at 10:43:40AM -0500, Tom Zanussi wrote:
> 
> > It is racey - in this mode, there's nothing to keep the kernel from
> > writing as much as it wants before the user side has a chance to read
> > any of it.  The only way this can be used safely is to make sure the
> > kernel side isn't writing anything when the client is reading.  This
> > would be typical of a flight-recording usage i.e. kernel writes a
> > bunch of data continuously, then stops and allows the client to read
> > whatever's in there.
> 
> Or by numbering entries written out, when in flight-recording mode you
> wouldn't want to block the kernel.

Exactly!  I've written a logging device to record data in the kernel
that a printk can't help with.  I've used this in debugging inturrupts,
the scheduler, and high speed network packets. Where a printk to a
serial would just slow things down, and going to the network is too
expensive, and complex if you happen to be debugging the network. This
tool is called logdev (http://www.kihontech.com/logdev) and uses a ring
buffer that is like the relayfs overwrite mode. It can do printk like
records and when something goes wrong, I dump the buffer to the serial.
Or I have a user space program reading it from a device. I don't care
about anything that happened earlier, I want to only know what happened
up to the point I dumped the buffer.  Lately, I've been usuing this with
Ingo's RT patch, and when the system locks up, I dump the buffer, and it
shows quite nicely where the lockup occurred, and why.

With Tom's help, I also have a version that uses relayfs as a backend in
overwrite mode.  It's still a work in progress (so no web site yet!)
since there's some issues of using a singe buffer for multiple CPUs.
This helps in debugging race conditions since you need to see how events
interleave.

> 
> >  > In fact, it appears this might even happen in non-overwrite mode.
> > 
> > It shouldn't ever be able to happen in non-overwrite mode - if it
> > did, it would be a bug.  Can you be more specific as to how you see
> > this happening in this mode?
> 
> Yeah - you're right. The misunderstanding is because in both cases
> (overwrite and non-overwrite) data is lost, except that in one case you lose
> old data, and in the other new data.
> 
> It might be a good idea to document this as well.
> 
> Btw, I've already uncovered interesting things using relayfs, but I still
> don't see the case for having it merged :-)

The reason I would like to see this merged, so kernel hackers don't need
to constantly write there own logging buffers everytime you need to
debug a complex area of the kernel.

-- Steve


