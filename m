Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbTI3Ria (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 13:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbTI3Ria
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 13:38:30 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:65498
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S261695AbTI3Rfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 13:35:47 -0400
Date: Tue, 30 Sep 2003 19:36:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: [BUG] 2.4.x RT signal leak with kupdated (and maybe others)
Message-ID: <20030930173651.GU17274@velociraptor.random>
References: <1064939275.673.42.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064939275.673.42.camel@gaston>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 06:27:55PM +0200, Benjamin Herrenschmidt wrote:
> Hi !
> 
> I finally figured out why on a friend machine, his nr_queued_signals is
> continuously growing until reaching nr_max_signals, thus preventing
> queuing of RT signals, for example causing do_notify_parent() to fail
> (libpthread uses sig 33 which is RTMIN+1 typically) leading to all sorts
> of zombies floating around etc...
> 
> The problem is a bug in kupdated (possibly shared by other kernel code
> manipulating a task tsk->pending.signal mask "by hand") that gets
> triggered, in this case, by the infamous noflushd, but other culprits
> are possible.
> 
> The bug is simple: the SIGSTOP sent to kupdated gets queued (allocated
> & queued actually) since we try to queue one non-RT signal nowadays.
> 
> However, when "receiving" it, kupdated will "manually" clear it from
> signal pending mask and will _not_ dequeue it. Thus, that signal will
> stay forever in kupdated signal queue, it will never be deallocated and
> nr_queued_signals will never be decreased.
> 
> Actually, further sigstops will stack there as well since kupdated is
> clearing it from tsk->pending.signal so further queuing won't "notice"
> it's already there.
> That clearing also prevents handle_stop_signal() from flushing it from
> the queue when SIGCONT is received.
> 
> The only thing I can see that could get rid of those signals  is
> flush_sigqueue(), but of course, this is never called for a kernel
> thread like kupdated.
> 
> So there is a clear bug in kupdated, I suppose the fix is to call
> something like dequeue_signal() from kupdated instead of hacking
> tsk->pending.signal. I need to test a fix before I post a patch.
> 
> Do we have a smiliar bug(s) with other bits of kernel "manipulating"
> the pending signal mask this way ? I don't know what others may do
> here, so if you know something like that, please speak up.

When I wrote the kupdate code, only the real time signals could be
queued. Now things have changed to carry the siginfo for non-RT too. The
fact we clear the pending by hand is what allows more than a RT signal
to be stacked, we shouldn't clear the bitflag unless we dequeue the
signal too. That's definitely a bug (though a minor one ;)

I sure agree it should be fixed with a dequeue_signal in kupdate.

BTW, things like this in daemonize don't protect against allocating
signals (the kernel deamon should flush_signals once in a while in the
main loop to do that):

	/* Block and flush all signals */
	sigfillset(&blocked);
	sigprocmask(SIG_BLOCK, &blocked, NULL);
	flush_signals(current);

But it's not a big problem you shouldn't send signals to daemons
anyways, only kupdate gives a semantic to signals.

I would suggest you to go ahead and cook the fix ;), thanks.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
