Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267364AbTBFR14>; Thu, 6 Feb 2003 12:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267365AbTBFR14>; Thu, 6 Feb 2003 12:27:56 -0500
Received: from phobos.hpl.hp.com ([192.6.19.124]:27612 "EHLO phobos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S267364AbTBFR1z>;
	Thu, 6 Feb 2003 12:27:55 -0500
Date: Thu, 6 Feb 2003 09:27:59 -0800
To: Jouni Malinen <jkmaline@cc.hut.fi>
Cc: joshk@triplehelix.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5 kernel + hostap_cs + X11 = scheduling while atomic
Message-ID: <20030206172759.GC17785@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030205073637.GA10725@saltbox.argot.org> <20030206052849.GA1540@jm.kir.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030206052849.GA1540@jm.kir.nu>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 09:28:49PM -0800, Jouni Malinen wrote:
> On Tue, Feb 04, 2003 at 11:36:37PM -0800, Joshua Kwan wrote:
> 
> > However, a combination of running said kernel, hostap_cs, and X11 produces
> > this nasty infinite string of errors:
> > 
> > bad: scheduling while atomic!
> > Call Trace:
> 
> >  [<d2948a30>] hfa384x_get_rid+0x36/0x2d6b7606 [hostap_cs]
> 
> That will sleep, so it better not be called while in interrupt context
> or apparently also, while atomic with preemptive kernels(?).
> 
> >  [<d29388b5>] hostap_get_wireless_stats+0xa6/0x2d6c77f1 [hostap]
> 
> That's the dev->get_wireless_stats handler. I have assumed that it is
> allowed to sleep there, but apparently that is not the case with Linux
> 2.5.x (at least with CONFIG_PREEMPT). I added a workaround for this into
> Host AP CVS, but you will not get signal quality statistics in that
> case. I'll do a proper fix if that function is indeed not allowed to
> sleep (e.g., by collecting the statistics before and just copying the
> values here).
> 
> Jean, do you have a comment on this? This happens, e.g., when executing
> 'cat /proc/net/wireless':
> 
> >  [<c0168f45>] seq_printf+0x45/0x56
> >  [<c02bd9b6>] wireless_seq_show+0xd6/0xf7
> >  [<c0141dd5>] do_mmap_pgoff+0x40e/0x6dc
> >  [<c0168a56>] seq_read+0x1c9/0x2ee
> >  [<c014d20f>] vfs_read+0xbc/0x127
> >  [<c014d496>] sys_read+0x3e/0x55
> >  [<c01093cb>] syscall_call+0x7/0xb

	I had an argument with David a few month ago on the subject
(you can ask him how it ended). I believe that it's not a good
practice to "schedule" in any of the ioctl, and that seem to also
apply to get_wireless_stats. On the other hand, you can perfectly take
a spinlock, disable irq and do your job.
	For the ioctl, on the way down you grab the rtnetlink
semaphore, which mean that all ioctl and rtnetlink operation will be
blocked until you return. That's the reason I deprecated the old
APLIST ioctl and designed the SCAN support as a *pair* of ioctl (+ an
event).
	For get_wireless_stats, check what I did in Orinoco. I
basically get (under spinlock) the stuff I can get immediately (RSSI),
start a request for the counters and return the result of the
*previous* request. That's the best I can think, because I don't want
to run permanently a thread that poll the counters and this way the
counter polling rate is adapted to what the user so.
	Note that in your case, the issue is slightly different. I
believe that the probability of having the BAD busy is not that
high. In that case, just return the last polled value, and set the
updated flag to 0 (now you understand why there is an updated flag).

> Jouni Malinen                                            PGP id EFC895FA

	Have fun...

	Jean
