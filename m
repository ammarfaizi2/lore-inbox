Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbTIWOoL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 10:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbTIWOoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 10:44:11 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:42947
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S261316AbTIWOoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 10:44:07 -0400
Date: Tue, 23 Sep 2003 16:44:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: log-buf-len dynamic
Message-ID: <20030923144435.GC23111@velociraptor.random>
References: <20030922194833.GA2732@velociraptor.random> <20030923042855.GF589@alpha.home.local> <20030923124951.GB23111@velociraptor.random> <20030923140647.GB3113@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923140647.GB3113@alpha.home.local>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 04:06:47PM +0200, Willy Tarreau wrote:
> Hi Andrea,
>  
> > The point here is that the default must work for 99% of the userbase.
> > Either that or the default is totally broken.
> 
> You're only thinking about what distro vendors should do. If all kernels should
> suit their needs, then there would not be any config anymore, and everyone
> would have the same kernel with the same wagon of command line arguments.

this is actually not true. Many options are way too costly to recompile
every time, or to keep enabled at runtime, it can't be the case for this
one. My own self compiled kernel has a very stripped down .config, it's
not like a distro kernel with everything included.

> I said I agree on the dynamic advantage. BTW, you didn't reply me about what
> the statically allocated 64 kB became with your patch. Will this memory be

the 64k are wasted only when you use the option, if you need more than
64k it's unlikely you care about 64k lost. But I'm ok to fix it, it just
looks a low priority to fix. Also since you will never use this option
anyways since you don't like adding parameters to the kernel, then you
don't care about fixing it either, you simply want the additional config
option on top of this.

My whole argument is that being able to do it dynamic is an order of
magnitude more important than being able to do it statically, no matter
the command line argument and no matter ther 64k lost. You must agree
with that. the amount of userbase is just not comparable.

> wasted forever or is there a way to free it ? If I want to pre-allocate it
> dynamically with alloc_space() as you did, what can I use to free it ? is
> kfree() the right thing ?

we should simply allocate it from the bootmem pool, it's trivial to
change it so the 64k aren't lost.

Not sure what I should do, personally I consider the additional .config
option as configuration pollution, but since you care that much I can
also change my patch not to reject yours, and to allow the two things to
coexist, but I don't think it's really needed. I believe people should
be forced to use the kernel params, and it's much more manageable to
know all the kernels behave the same if no param is passed (otherwise
you have to check the System.map to see how big the buffer is, to know
if this was the right or wrong kernel during your remote maintainance,
either that or you should check /proc/config.gz if you have it). It's
just a mess if each kernel with the same revision number behaves
differently, everything becomes less and less predictable. The number of
System.map checks increases and increases before I can identify what
kernel is that. Is there anybody else that has opinions on the matter?

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
