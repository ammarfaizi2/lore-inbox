Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbVDRP5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbVDRP5T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 11:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVDRP5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 11:57:19 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:39664 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262109AbVDRP5J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 11:57:09 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16995.55497.569295.838562@tut.ibm.com>
Date: Mon, 18 Apr 2005 10:56:57 -0500
To: Kingsley Cheung <kingsley@aurema.com>
Cc: Tom Zanussi <zanussi@us.ibm.com>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Relayfs Question: Use of relay_reset().  Potential race?
In-Reply-To: <20050418012951.GC4846@aurema.com>
References: <20050323090254.GA10630@aurema.com>
	<20050418012951.GC4846@aurema.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kingsley Cheung writes:
 > On Wed, Mar 23, 2005 at 08:02:54PM +1100, kingsley@aurema.com wrote:
 > > Hi 
 > > 
 > > I'm using relayfs to relay data from a kernel module to user space on
 > > a SuSE 2.6.5 kernel.  I'm not absolutely sure what version of relayfs
 > > has been back ported to it.
 > 
 > Hi Tom,
 > 
 > Could you please have a look at the following use of relay_reset() in
 > a kernel module as follows (compiled against pre-redux relayfs):
 > 
 > static int
 > exec_fileop_notify(int rchan_id, struct file *filp, enum relay_fileop op)
 > {
 >         if (unlikely(rchan_id != exec_cid)) {
 >                 printk(KERN_ERR "%s - bad file number\n", __FUNCTION__);
 >                 return -EBADF;
 >         }
 > 
 >         switch (op) {
 >         case RELAY_FILE_OPEN:
 >                 atomic_inc(&exec_client_cnt);
 >                 break;
 >         case RELAY_FILE_CLOSE:
 >                 if (atomic_dec_and_test(&exec_client_cnt) == 0)
 >                         relay_reset(exec_cid); <---
 >                 break;
 >         default:
 >                 /* do nothing */
 >                 break;
 >         }
 > 
 >         return 0;
 > }
 > 
 > Is that legitimate?  The reason I ask is because I've been seeing

Yes, you should be able to reset the channel here, since at that point
it's been closed.

 > garbled oopses with keventd and I've narrowed it to two things:
 > 
 > 1) Inadequate locking on my part in the kernel module, which I have
 > addressed separately.
 > 
 > 2) A race with relay_reset() and keventd, which is probably of
 > interest to you if you're still maintaining the pre-redux patches.
 > 
 > The race is due to the use of INIT_WORK in _reset_relay():
 > 
 > INIT_WORK(&rchan->wake_readers, NULL, NULL);
 > INIT_WORK(&rchan->wake_writers, NULL, NULL);
 > 
 > However, at the time relay_reset() is called, it is possible that
 > these work structures are still being used by keventd when under heavy
 > loads.  The workaround I've used to fix this is to call
 > flush_scheduled_work() before calling reset_relay() in the kernel
 > module.  Perhaps that needs to be called in relay_reset() or
 > _relay_reset()?

Yes, flush_scheduled_work() should probably be called from
__relay_reset() - thanks for catching this and suggesting the fix.
BTW, I've updated the old relayfs patch with your previous fixes and
ported it to 2.6.11 - it hasn't appeared yet on the opersys website,
so let me know if you want it and I'll send it, or I can just send you
a new version after I make these changes...

 > 
 > As well I'm not sure about the uses of INIT_WORK in
 > _relay_realloc_buffer() and relay_release() - perhaps they need
 > attention too.  I understand, however, that flush_schedule_work()

I'll take a look at this too - looks like there might be a potential
problem if a channel was closed while a resize was in progress.  I
don't think anyone's ever actually used resizing, but it should be
fixed nonetheless.

Thanks,

Tom


