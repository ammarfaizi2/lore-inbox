Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266846AbUHTNSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266846AbUHTNSf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 09:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266896AbUHTNSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 09:18:35 -0400
Received: from herkules.viasys.com ([194.100.28.129]:37816 "HELO
	mail.viasys.com") by vger.kernel.org with SMTP id S266846AbUHTNSa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 09:18:30 -0400
Date: Fri, 20 Aug 2004 16:18:25 +0300
From: Ville Herva <vherva@viasys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: petr@vandrovec.name, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm2 breaks vmware
Message-ID: <20040820131825.GI23741@viasys.com>
Reply-To: vherva@viasys.com
References: <20040820104230.GH23741@viasys.com> <20040820035142.3bcdb1cb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820035142.3bcdb1cb.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux herkules.viasys.com 2.4.27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 03:51:42AM -0700, you [Andrew Morton] wrote:
> Ville Herva <vherva@viasys.com> wrote:
> >
> > Andrew, I know you are not interested in closed source vmware, I'm just
> > blatantly Cc'ing you in case you would have some suggestion of the top of
> > your head. As stuff slowly trickles from -mm to mainline, this could
> > eventually end up biting more people.
> > 
> > In short, there are two (afaict) separate problem:
> > 
> > (1) vmmon.ko gives this:
> > 
> > 	vmmon: Your kernel is br0ken. get_user_pages(current, current->mm, b7dd1000, 1, 1, 0, &page, NULL) returned -14.
> > 	vmmon: I'll try accessing page tables directly, but you should know that your
> > 	vmmon: kernel is br0ken and you should uninstall all additional patches you
> > 	vmmon: have installed!
> > 	vmmon: FYI, copy_from_user(b7dd1000) returns 0 (if not 0 maybe your kernel is not br0ken)
> > 
> > (2) vmware fails to start any guest os, telling it cannot allocate memory:
> > 
> > 	VMX|[msg.msg.noMem] Cannot allocate memory.
> > 
> > 
> > (1) happened with 2.6.6-mm4 and with 2.6.8.1-mm2.
> > (2) only happened with 2.6.8.1-mm2 (with 2.6.6-mm4 vmware worked despite
> > the warning.)
> 
> Try -mm3, please.  It'll have the same problem.

I can try. I'm a bit confused what I should learn from trying -mm3 -- it
doesn't have any big changes on this area, right?
 
> > So I backed out these patches from 2.6.8.1-mm2:
> > 
> > 	flexible-mmap-2.6.7-mm3-A8.patch
> > 	flex-mmap-for-ppc64.patch
> > 	flex-mmap-for-s390x.patch
> > 	sysctl-tunable-for-flexmmap.patch
> 
> These have all been lumped together in mm3.
> 
> Try setting /proc/sys/vm/legacy_va_layout to 1

As I said, backing these out did not cure (2) (vmware failing to allocate
memory). And as Arjan said, flex-mmap is in Fedora kernels, and they have no
problems. 

Also, flex-mmap has been introduced after 2.6.6-mm4, right? That would mean
it can't explain (1) ("get_user_pages() returns -EFAULT even though
copy_from_user() return 0")

That would mean (1) is cured by reversing get_user_pages-latency-fix.patch,
increase-mlock-limit-to-32k.patch or mlock-as-user-for-268-rc2-mm2.patch.

> > 	get_user_pages-latency-fix.patch
> 
> It won't be this.
> 
> > 	increase-mlock-limit-to-32k.patch
> > 	mlock-as-user-for-268-rc2-mm2.patch
> 
> Unlikely to be these.

But what can explain (1), then? flex-mmap is not in 2.6.6-mm4, still it
gives that warning.

I just noticed I had missed get_user_pages-handle-VM_IO.patch - I'll try
backing that out first. I'll report back if I find anything interesting 
with different patch mixtures.

> > After this, problem (1) went away for 2.6.8.1-mm2, but problem (2) remained.
> 
> Try setting /proc/sys/vm/overcommit_memory to 1

Forgot to tell: problem (2) (vmware failing to allocate memory) is
consistent with 2.6.8.1-mm2 even when I try to configure the guest os to use
8MB memory. 128MB or 256MB is no problem with 2.6.8.1 mainline and it as
/proc/sys/vm/overcommit_memory set to 0. (I have 512MB of RAM and 512MB of
swap.)
 
> Maybe Peter could take a look sometime?

I already harrashed him, but I couldn't tell off the top of his head.
 
> > Could get_user_pages-latency-fix.patch explain (1)? My kernel expertise is
> > not sufficient to tell.
> 
> Doubtful.

Ok.



-- v -- 

v@iki.fi

