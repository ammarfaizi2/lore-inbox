Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265311AbUBPCy1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 21:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265315AbUBPCy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 21:54:27 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:46245 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265311AbUBPCyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 21:54:24 -0500
Subject: Re: dm-crypt using kthread (was: Oopsing cryptoapi (or loop
	device?) on 2.6.*)
From: Christophe Saout <christophe@saout.de>
To: Andrew Morton <akpm@osdl.org>
Cc: hch@infradead.org, thornber@redhat.com, mikenc@us.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040215180736.4743f4ee.akpm@osdl.org>
References: <402A4B52.1080800@centrum.cz>
	 <1076866470.20140.13.camel@leto.cs.pocnet.net>
	 <20040215180226.A8426@infradead.org>
	 <1076870572.20140.16.camel@leto.cs.pocnet.net>
	 <20040215185331.A8719@infradead.org>
	 <1076873760.21477.8.camel@leto.cs.pocnet.net>
	 <20040215194633.A8948@infradead.org>
	 <20040216014433.GA5430@leto.cs.pocnet.net>
	 <20040215180736.4743f4ee.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1076900039.5601.36.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 03:53:59 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[shoot me, I forgot the Cc's the first time]

> > +	/*
> > +	 * Tell VM to act less aggressively and fail earlier.
> > +	 * This is not necessary but increases throughput.
> > +	 * FIXME: Is this really intelligent?
> > +	 */
> > +	current->flags &= ~PF_MEMALLOC;
> 
> This is a bit peculiar.  Is it still the case that it increases throughput?

Were there changes to the VM?

> How come?

I'm not exactly sure either. But this is what I suspected:

The VM wants to write out some pages. dm-crypt wants to allocate buffers
and starts digging into the reservers because PF_MEMALLOC is set which
causes some sort of low-memory condition.

If PF_MEMALLOC is dropped here the VM can just drop some cache pages in
order to allocate buffers.

If there wasn't a lot of free (unused) memory the machine often started
writing out data when I tried to write a lot of data using dd. The
seeking killed performance, just for the first seconds though.

It's not really important, I can drop that.

> Should restore PF_MEMALLOC here.

Right...

> > +		set_task_state(current, TASK_INTERRUPTIBLE);
> > +		while (!(bio = kcryptd_get_bios())) {
> > +			schedule();
> > +			if (signal_pending(current))
> > +				return 0;
> > +		}
> 
> This will turn into a busy-loop, because schedule() sets current->state to
> TASK_RUNNING.  You need to move the set_task_state(current,
> TASK_INTERRUPTIBLE); inside the loop.

Right again. I changed that several times. It shouldn't happen that
schedule returns but there's not data available, but ok. I changed the
while to an if and call kcryptd_get_bios after schedule().

> Why is this code mucking with signals?

For thread termination, that's what kthread does. The other kthread
users are doing this too. I changed the for(;;) back to a while
(!signal_pending(current)) since I killed the inner while loop.

> Perhaps a call to blk_congestion_wait() would be appropriate here.

Huh? Why that? This is the path for reads.

> sprintf("%02x")?

Ok. :)


