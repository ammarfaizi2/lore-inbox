Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbTDROvs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 10:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTDROvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 10:51:48 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:21179 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263055AbTDROvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 10:51:47 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16031.42850.146902.895382@lepton.softprops.com>
Date: Fri, 18 Apr 2003 02:21:06 -0500
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'karim@opersys.com'" <karim@opersys.com>,
       "'Martin Hicks'" <mort@wildopensource.com>,
       "'Daniel Stekloff'" <dsteklof@us.ibm.com>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Randy.Dunlap'" <rddunlap@osdl.org>, "'hpa@zytor.com'" <hpa@zytor.com>,
       "'pavel@ucw.cz'" <pavel@ucw.cz>,
       "'jes@wildopensource.com'" <jes@wildopensource.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'wildos@sgi.com'" <wildos@sgi.com>,
       "'Tom Zanussi'" <zanussi@us.ibm.com>
Subject: RE: [patch] printk subsystems
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780C2630D5@orsmsx116.jf.intel.com>
References: <A46BBDB345A7D5118EC90002A5072C780C2630D5@orsmsx116.jf.intel.com>
X-Mailer: VM(ViewMail) 7.01 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perez-Gonzalez, Inaky writes:
 > 
 > 
 > 
 > Well, the total overhead for queuing an event is strictly O(1),
 > bar the acquisition of the queue's semaphore in the middle [I
 > still hadn't time to finish this and post it, btw]. I think it
 > is pretty scalable assuming you don't have the whole system 
 > delivering to a single queue.
 > 
 > Total is four lines if I unfold __kue_queue(), and the list_add_tail()
 > is not that complex. That's versus relay_write(), that I think is the
 > equivalent function [bar the extra goodies] is more complex
 > [disclaimer: this is just looking over the 030317 patch's shoulder,
 > I am in kind of a rush - feel free to correct me here].
 > 

It seems to me that when comparing apples to apples, namely
considering the complete lifecycle of an event, kue and relayfs are
very similar wrt performance and memory usage; whether kue is
scaleable or not I couldn't say, but we've previously published
benchmarks for LTT on this list showing that the relayfs logging code
(the same as that used by LTT) scales very well to logging millions
upon millions of events with low overhead.  

While kue_send_event() in itself is very simple and efficient, it's
only part of the story, the other parts being the copy_to_user() that
must be done to get each event to user space and the subsequent
bookeeping necessary to remove it from the queue and make destructor
calls.  Only if we include all of the above is relayfs' relay_write()
equivalent - once relay_write() returns, that's the end of the story
as far as that event is concerned - at that point the data is directly
available to a client that has the buffer mmapped, and nothing more
remains to be done.  So yes, relay_write() is more complex code-wise
because it's doing more.  As far as algorithmic complexity goes, the
time to log an event via relay_write() is also pretty much constant,
the only variables being that it may take more than one iteration to
reserve a slot in case of a reserve collision with another writer,
which should happen fairly rarely, and the fact that if a given event
is the last event in a buffer, the end-of-buffer slow path is
triggered, which is also relatively speaking a rare occurrence.
Actually, the time it takes to memcpy the event into the relayfs
buffer should also be factored in, as it depends on the size of the
event.  While kue can avoid this kernel-side copy, it's not possible
for it to avoid the copy_to_user() since its design precludes mmapping
the kernel data.  Again, six of one, half dozen of another.  kue looks
like a nice elegant way of logging small bits of data and I'm sure it
has its advantages, though I think the same thing could be
accomplished in a slightly different way with a relayfs channel.

Anyway, to address the original topic, I'm working on a drop-in
replacement of printk that replaces the static printk buffer with a
dynamically resizeable relayfs channel (a new relayfs capability that
will be available to all relayfs clients).  In addition to being
resizeable manually (probably via commands to the syslog system call),
it will also have an 'auto-resize' capability that allows the printk
channel to adapt to printk traffic levels - increase as necessary when
an overflow condition is detected, and fall back to a more reasonable
level when the excess capacity is no longer needed.  Init-time printks
will still use the static printk buffer, but because the static buffer
is marked as __initdata, it can be made large enough to handle lots of
init-time data, all of which is atomically copied over to the the
dynamic relayfs channel before init data is discarded.  Once klogd has
logged all the init data then present in the temporarily enlarged
relay channel, the channel would then resize itself to to a normal
working size.  Hopefully this will solve the problem of lost printks
both at boot-time and during normal operation and isn't a stopgap
measure.

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

