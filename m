Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbUB1H3a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 02:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbUB1H3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 02:29:30 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:62380
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262941AbUB1H31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 02:29:27 -0500
Date: Sat, 28 Feb 2004 08:29:26 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040228072926.GR8834@dualathlon.random>
References: <20040227173250.GC8834@dualathlon.random> <Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com> <20040227122936.4c1be1fd.akpm@osdl.org> <20040227211548.GI8834@dualathlon.random> <162060000.1077919387@flay> <20040228023236.GL8834@dualathlon.random> <469160000.1077948622@[10.10.2.4]> <20040228064352.GP8834@dualathlon.random> <474350000.1077951643@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <474350000.1077951643@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 11:00:44PM -0800, Martin J. Bligh wrote:
> > The last issue that we may run into are apps assuming the stack is at 3G
> > fixed, some jvm assumed that, but they should be fixed by now (at the
> > very least it's not hard at all to fix those).
> 
> All the potential solutions we're discussing hit that problem so I don't
> see it matters much which one we choose ;-)

I agree, I thought about it too, but I didn't mention that since
theoretically 4:4 has a chance to start with a stack at 3G and to depend
on the userspace startup to relocate it at 4G ;). x86-64 does something
like that to guarantee 100% compatibility.

> > It also depends on the performance difference if this is worthwhile, if
> > the difference isn't very significant 4:4 will be certainly prefereable
> > so you can also allocate 4G in the same task for apps not using syscalls
> > or page faults or flood of network irqs.
> 
> There are some things that may well help here: one is vsyscall gettimeofday,
> which will fix up the worst of the issues (the 30% figure you mentioned
> to me in Ottowa), the other is NAPI, which would help with the network
> stuff.

I think it's very fair to benchmark vsyscalls with 2.5:1.5 vs vsyscalls
with 4:4.

However remeber you said you want a generic kernel for 64G right? Not
all userspaces will use vsyscalls, and it's not just one app using
gettimeofday. As of today no production userspace uses vgettimeofday in
x86 yet. I mean, we can tell people to always use vsyscalls with the 4:4
kernel and it's acceptable, but it's not as generic as 2.5:1.5.

> Bill had a patch to allocate mmaps, etc down from the top of memory and
> thus elimininate TASK_UNMAPPED_BASE, and shift the stack back into the
> empty hole from 0-128MB of memory where it belongs (according to the spec).
> Getting rid of those two problems gives us back a little more userspace 
> as well. 
> 
> Unfortunately it does seem to break some userspace apps making stupid 
> assumptions, but if we have a neat way to mark the binaries (Andi was
> talking about personalities or something), we could at least get the
> big mem hogs to do that (databases, java, etc).

I read something about this issue. I agree it must be definitely marked.
apps may very well make assumptions about that space being empty below
128m and overwrite it with a mmap() (mmap will just silent overwrite),
and I'm unsure if we can claim that to be an userspace bug..., I guess
most people will blame the kernel ;)

Now that x86 is dying it probably don't worth to mark the binaries, the
few apps needing this should relocate the stack by hand and setup the
growsdown bitflag. plus they should lower mapped base by hand with the
/proc tweak like we do in 2.4.

I agree having the stack growsdown at 128 is the best for the db setup,
but I doubt we can make it generic and automatic for all apps. Also it's
not the stack really the problem in terms of genericity, infact with
recursive algos the stack may need to grow a lot, and having it at 128m
could segfault. As for mapped-base the space between 128 and 1G may as
well be assumpd empty by the apps, so relocation is possible on demand
by the app. I doubt we can do better than the above without taking risks ;)

> I have a copy of Bill's patch in my tree if you want to take a look:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/patches/2.6.3/2.6.3-mjb1/410-topdown

thanks for the pointer.

> 
> That might make your 2.5/1.5 proposal more feasible with less loss of
> userspace.

Yes. I was sort of assuming that we would use the mapped-base tweak for
achieving that, the relocation of the stack is a good idea, and it's
doable all in userspace (though it's not generic/automatic).

thanks.
