Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310549AbSCPUFb>; Sat, 16 Mar 2002 15:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310560AbSCPUFW>; Sat, 16 Mar 2002 15:05:22 -0500
Received: from ns.suse.de ([213.95.15.193]:36872 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310549AbSCPUFF>;
	Sat, 16 Mar 2002 15:05:05 -0500
Date: Sat, 16 Mar 2002 21:05:04 +0100
From: Andi Kleen <ak@suse.de>
To: yodaiken@fsmlabs.com
Cc: Andi Kleen <ak@suse.de>, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020316210504.A24097@wotan.suse.de>
In-Reply-To: <20020316113536.A19495@hq.fsmlabs.com.suse.lists.linux.kernel> <Pine.LNX.4.33.0203161037160.31913-100000@penguin.transmeta.com.suse.lists.linux.kernel> <20020316115726.B19495@hq.fsmlabs.com.suse.lists.linux.kernel> <p73g0301f79.fsf@oldwotan.suse.de> <20020316125711.B20436@hq.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020316125711.B20436@hq.fsmlabs.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 12:57:11PM -0700, yodaiken@fsmlabs.com wrote:
> On Sat, Mar 16, 2002 at 08:32:26PM +0100, Andi Kleen wrote:
> > x86-64 aka AMD Hammer does hardware (or more likely microcode) search of 
> > page tables.
> > It has a 4 level page table with 4K pages. Generic Linux MM code only sees
> > the first slot in 4th level page limit user space to 512GB with 3 levels. 
> 
> What about 2M pages?

They are not supported for user space, but used in private mappings
for kernel text and direct memory mappings. Generic code never sees them.

That will hopefully change eventually because 2M pages are a bit help for
a lot of applications that are limited by TLB thrashing, but needs some 
thinking on how to avoid the fragmentation trap (e.g. I'm considering
to add a highmem zone again just for that and use rmap with targetted
physical freeing to allocating them) 

> 
> > Direct mappings and kernel mappings are handled specially by architecture 
> > specific code outside that first slot.
> > 
> > The CPU itself has I/D TLBs split into L1 and L2.
> 
> There was something in some AMD doc about preventing tlbflush on process
> switch - through a context like thing perhaps? Any idea?

There are global pages which are normally not flushed over context switch.
That is used for all kernel mappings. 

There is also some optimization in the CPU that tries to do a selective
flush only when you reload CR3, but as far as I can see doesn't help
for the Linux context switch. It only works around broken TLB flushing
algorithms in some Windows version.

-Andi
