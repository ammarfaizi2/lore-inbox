Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWDYRwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWDYRwB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 13:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWDYRwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 13:52:01 -0400
Received: from silver.veritas.com ([143.127.12.111]:50738 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750718AbWDYRwA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 13:52:00 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.04,154,1144047600"; 
   d="scan'208"; a="37597681:sNHT25600504"
Date: Tue, 25 Apr 2006 18:51:55 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: David Wilk <davidwilk@gmail.com>
cc: Chris Wright <chrisw@sous-sol.org>, Greg KH <greg@kroah.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, stable@kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [stable] 2.6.16.6 breaks java... sort of
In-Reply-To: <a4403ff60604241359q408a6ea7je620cb05d3dafe8@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0604251827330.8535@blonde.wat.veritas.com>
References: <a4403ff60604191152u5a71e70fr9f54c104a654fc99@mail.gmail.com> 
 <20060419192803.GA19852@kroah.com>  <Pine.LNX.4.64.0604192046590.17491@blonde.wat.veritas.com>
  <Pine.LNX.4.64.0604201706540.14395@blonde.wat.veritas.com> 
 <a4403ff60604211208gf64dfe2v7282a493f4853c@mail.gmail.com> 
 <20060421192743.GH3061@sorel.sous-sol.org> 
 <a4403ff60604211456j46a2f69fw39606ffec42ec95d@mail.gmail.com> 
 <Pine.LNX.4.64.0604231312450.2515@blonde.wat.veritas.com>
 <a4403ff60604241359q408a6ea7je620cb05d3dafe8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Apr 2006 17:51:59.0311 (UTC) FILETIME=[F34CBDF0:01C66890]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2006, David Wilk wrote:
> On 4/23/06, Hugh Dickins <hugh@veritas.com> wrote:
> 
> I think this trace was taken while java was doing exactly what it was
> doing before.  I actually restarted java many, many times with
> 2.6.16.9 and watched in amazement as it failed each and every time,
> with the exact same error message.  This is tomcat, specifically, and
> it would die immediately after startup and it was started the exact
> same way with the init script.  So, yeah, I think this trace is
> representative.  I have no idea why it doesn't contain what you would
> consider relevant.  I'm no programmer, unfortunately.  However, I
> would like to help out any way that I can.

Thanks for the clarification.  But I remain utterly perplexed.

I've installed JRE and JDK 1.5 in 1GB box here, I've installed
Tomcat 5.0.28, I've inserted the options from your strace (notably
the -Xmx768m) in my catalina.sh, yet I see no such problem with 2.6.16.9.

> > > mmap2(NULL, 872415232, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) = -1 ENOMEM (Cannot allocate memory)
> > > write(1, "Error occurred during initializa"..., 43) = 43
> > > write(1, "Could not reserve enough space f"..., 46) = 46
> > > write(1, "\n", 1)                       = 1
> > > unlink("/tmp/hsperfdata_tomcat/12273")  = 0
> > > write(2, "Could not create the Java virtua"..., 43) = 43
> >
> > To judge by this trace, I'd have to say that your problem has
> > nothing whatever to do with the shm/mprotect fix in 2.6.16.6,
> > and we've no evidence yet to complicate that fix.  Interestingly,
> > nobody else has so far reported any problem with it.
> 
> bizaar.  I must say that this patch 'fixing' the problem just cannot
> be coincidental.  Tomcat will never start without it, and never fails
> with it.

Bizarre indeed.  But at least you've rechecked and banished my doubts.

> > Judging by the mmap addresses throughout the trace (top down, from
> > 0x37f2e000), it looks like you've got CONFIG_VMSPLIT_1G (not a good
> > choice for a box with only 1G of RAM: whereas CONFIG_VMSPLIT_3G_OPT
> > would maximize your userspace while avoiding the need for HIGHMEM);
> > and with the above 832M mmap, the remaining hole in user address
> > space is just too small to hold it.
> 
> well, this is just a test box for a system we deploy on a dual-cpu
> server with 4GB of ram.
> 
> can you describe the CONFIG_VMSPLIT_3G_OPT and how I might find it in
> 'make menuconfig'?  is it the second option (3G/1G user/kernel)?  I"ve

The second one, that's _OPT, yes, which just shaves a little off the
3GB userspace, to avoid the need for HIGHMEM.

> got the first option selected which is 3G/1G user/kernel as well, but
> different somehow.  As this is new to 2.6.16, I'm not familiar with

The first one, this is the traditional layout, the one least likely to
give you any compatibility troubles, so please do stick with it for now.

> the options.  Perhaps my 1GB workstations would benefit from this
> second 3G/1G option?

They would, a little.  Whether it's noticeable, I don't know.
You might prefer to keep a similar configuration for all your
machines.  While we're investigating this particular mystery,
I'd prefer you to stick with what you've got.

> > But that leaves me quite unable to explain why you should have
> > thought the shm/mprotect patch responsible, and why you should
> > find the more complicated version works.  Stack randomization
> > changes the numbers a little, but I think not enough to explain
> > how it sometimes could fit 832M in there, sometimes not.

Clearly I was entirely wrong to accuse you of the wrong VMSPLIT.
Yet I still can't see how either shm or mprotect write is involved.

My latest guess is that whereas my "ulimit -s" shows 8192, yours
will show something much higher, but not "unlimited".   And that
high stack rlimit is pushing the roof of your userspace down, to
the point where the -Xmx868m mapping barely fits.

But though fiddling with my "ulimit -s" does change the layout,
I've not yet been able to reproduce your failure.  And this has
nothing whatever to do with the shm/mprotect issue or patch.

> Unfortunately I cannot speculate as to the cause, but experimentally
> (anecdotally anyway) the patch is 100% effective.
> >
> > Tell me I'm talking nonsense and we'll have another go:
> > I guess adding some printks on top of the "replacement"
> > patch, so it can tell us when it's having an effect.
> 
> I'd never accuse you of nonsense, but I cannot refute the evidence. ; )
> 
> if there is anything else you would like me todo to try to squeeze
> more data from this thing, please let me know.

Well, I guess I'd like to see what "ulimit -a" and "ulimit -H -a"
show on your machine (it's really "ulimit -s" I'm interested in,
but we might as well see the whole lot).  And the output from
"cat /proc/$(pidof java)/maps" while you've got Tomcat running
successfully.  And what is your distro?

But it seems unlikely that any of this information will help me to
make that strange leap from my patches to your experience of them.

Hugh
