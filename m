Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314067AbSEFCFt>; Sun, 5 May 2002 22:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314068AbSEFCFs>; Sun, 5 May 2002 22:05:48 -0400
Received: from [195.223.140.120] ([195.223.140.120]:17200 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314067AbSEFCFp>; Sun, 5 May 2002 22:05:45 -0400
Date: Mon, 6 May 2002 04:06:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Russell King <rmk@arm.linux.org.uk>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020506040622.J6712@dualathlon.random>
In-Reply-To: <20020502180632.I11414@dualathlon.random> <E174XFK-0004CJ-00@starship> <20020506034218.H6712@dualathlon.random> <E174Xc6-0004CU-00@starship>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nmemrqcdn5VTmUEE"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 06, 2002 at 03:48:30AM +0200, Daniel Phillips wrote:
> On Monday 06 May 2002 03:42, Andrea Arcangeli wrote:
> > On Mon, May 06, 2002 at 03:24:58AM +0200, Daniel Phillips wrote:
> > > What do you mean by 'implement a static view of them'?
> > 
> > See the attached email. assuming chunks of 256M ram every 1G, 1G phys
> > goes at 3G+256M virt, 2G goes at 3G+512M etc...
> 
> So, __va(0x40000000) = 0xc0000000, and __va(0x80000000) = 0, i.e., not a kernel

I said page_address() not necessairly __va. Assume the arch specify
WANT_PAGE_VIRTUAL because such a page_address wouldn't be that cheap
anyways, see my discussion with William as reference.

> address at all, because with config_discontigmem __va is a simple linear
> relation.  What do you do about that?

You can implement __va as you want, it doesn't need ot be a simple
linear relation (see also the attached email from Roman), but regardless
what matters really is page_address and virt_to_page, not only __va,
just initialize page->virtual to the static kernel window at boot time
using the proper virtual address and you won't run into __va (or let the
arch code specify page_address if CONFIG_DISCONTIGMEM is defined, this
would require a two liner to mm.h). this also is been just discussed
some day ago with William, see the other attached email.

Andrea

--nmemrqcdn5VTmUEE
Content-Type: message/rfc822
Content-Disposition: inline

Date: Thu, 2 May 2002 20:41:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502204136.M11414@dualathlon.random>
In-Reply-To: <20020502180632.I11414@dualathlon.random> <3972036796.1020330599@[10.10.2.3]> <20020502184037.J11414@dualathlon.random> <20020502171655.GJ32767@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020502171655.GJ32767@holomorphy.com>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc

On Thu, May 02, 2002 at 10:16:55AM -0700, William Lee Irwin III wrote:
> On Thu, May 02, 2002 at 09:10:00AM -0700, Martin J. Bligh wrote:
> >> Even with 64 bit DMA, the real problem is breaking the assumption
> >> that mem between 0 and 896Mb phys maps 1-1 onto kernel space.
> >> That's 90% of the difficulty of what Dan's doing anyway, as I
> >> see it.
> 
> On Thu, May 02, 2002 at 06:40:37PM +0200, Andrea Arcangeli wrote:
> > control on virt_to_page, pci_map_single, __va.  Actually it may be as
> > well cleaner to just let the arch define page_address() when
> > discontigmem is enabled (instead of hacking on top of __va), that's a
> > few liner. (the only true limit you have is on the phys ram above 4G,
> > that cannot definitely go into zone-normal regardless if it belongs to a
> > direct mapping or not because of pci32 API)
> > Andrea
> 
> Being unable to have any ZONE_NORMAL above 4GB allows no change at all.

No change if your first node maps the whole first 4G of physical address
space, but in such case nonlinear cannot help you in any way anyways.
The fact you can make no change at all has only to do with the fact
GFP_KERNEL must return memory accessible from a pci32 device.

I think most configurations have more than one node mapped into the
first 4G, and so in those configurations you can do changes and spread
the direct mapping across all the nodes mapped in the first 4G phys.

the fact you can or you can't have something to change with discontigmem
or nonlinear, it's all about pci32.

> 32-bit PCI is not used on NUMA-Q AFAIK.

but can you plugin 32bit pci hardware into your 64bit-pci slots, right?
If not, and if you're also sure the linux drivers for your hardware are all
64bit-pci capable then you can do the changes regardless of the 4G
limit, in such case you can spread the direct mapping all over the whole
64G physical ram, whereever you want, no 4G constraint anymore.

> 
> So long as zones are physically contiguous and __va() does what its

zones remains physically contigous, it's the virtual address returned by
page_address that changes. Also the kmap header will need some
modification, you should always check for PageHIGHMEM in all places to
know if you must kmap or not, that's a few liner.

> name implies, page_address() should operate properly aside from the
> sizeof(phys_addr) > sizeof(unsigned long) overflow issue (which I
> believe was recently resolved; if not I will do so myself shortly).
> With SGI's discontigmem, one would need an UNMAP_NR_DENSE() as the
> position in mem_map array does not describe the offset into the region
> of physical memory occupied by the zone. UNMAP_NR_DENSE() may be
> expensive enough architectures using MAP_NR_DENSE() may be better off
> using ARCH_WANT_VIRTUAL, as page_address() is a common operation. If

Yes, as alternative to moving page_address to the arch code, you can set
WANT_PAGE_VIRTUAL since as you say such a function is going to be more
expensive, (if it's only a few instructions you can instead consider
moving page_address in the arch code as said in the previous email
instead of hacking on __va).

> space conservation is as important a consideration for stability as it
> is on architectures with severely limited kernel virtual address spaces,
> it may be preferable to implement such despite the computational expense.
> iSeries will likely have physically discontiguous zones and so it won't
> be able to use an address calculation based page_address() either.

If you need to support an huge number of discontigous zones then I'm the
first to agree you want nonlinear instead of discontigmem, I wasn't
aware that such an hardware that normally needs to support hundred or
thousand of discontigmem zones exists, for it discontigmem is
prohibitive due the O(N) complexity of some code path. That's not the
case for NUMA-Q though that also needs the different pgdat structures
for the numa optimizations anyways (and still to me a phys memory
partitioned with hundred discontigous zones looks like an harddisk
partitioned in hundred of different blkdevs).

BTW, about the pgdat loops optimizations, you misunderstood what I meant
in some previous email, with "removing them" I didn't meant to remove
them in the discontigmem case, that would had to be done case by case,
with removing them I meant to remove them only for mainline 2.4.19-pre7
when kernel is compiled for x86 target like 99% of userbase uses it. A
discontigmem using nonlinear also doesn't need to loop. It's a 1 branch
removal optimization (doesn't decrease the complexity of the algorithm
for discontigmem enabled). It's all in function of #ifndef CONFIG_DISCONTIGMEM.
Dropping the loop when discontigmem is enabled is much more interesting
optimization of course.

Andrea

--nmemrqcdn5VTmUEE
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <zippel@linux-m68k.org>
Received: from Hermes.suse.de (Hermes.suse.de [10.10.96.4])
	by Wotan.suse.de (Postfix) with ESMTP id E2DDDB3D35
	for <andrea@wotan.suse.de>; Thu,  2 May 2002 21:40:53 +0200 (CEST)
Received: by Hermes.suse.de (Postfix)
	id DE6F7D82F; Thu,  2 May 2002 21:40:53 +0200 (MEST)
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by Hermes.suse.de (Postfix) with ESMTP id D81D9D81F
	for <andrea@suse.de>; Thu,  2 May 2002 21:40:53 +0200 (MEST)
Received: from smtpzilla2.xs4all.nl (smtpzilla2.xs4all.nl [194.109.127.138])
	by Cantor.suse.de (Postfix) with ESMTP id B43EA1EFD7
	for <andrea@suse.de>; Thu,  2 May 2002 21:40:53 +0200 (MEST)
Received: from scrub.xs4all.nl (scrub.xs4all.nl [194.109.195.176])
	by smtpzilla2.xs4all.nl (8.12.0/8.12.0) with ESMTP id g42JenMj080071;
	Thu, 2 May 2002 21:40:49 +0200 (CEST)
Received: from spit.local
	([192.168.3.2] helo=linux-m68k.org ident=roman)
	by scrub.xs4all.nl with esmtp (Exim 3.35 #1 (Debian))
	id 173MRd-0002CK-00; Thu, 02 May 2002 21:40:49 +0200
Sender: roman@xs4all.nl
Message-ID: <3CD19640.3B85BF76@linux-m68k.org>
Date: Thu, 02 May 2002 21:40:48 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Andrea Arcangeli <andrea@suse.de>,
	Ralf Baechle <ralf@uni-koblenz.de>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: discontiguous memory platforms
In-Reply-To: <Pine.LNX.4.21.0205021539460.23113-100000@serv> <E172yOR-00026G-00@starship> <3CD184BB.ED7F349F@linux-m68k.org> <E173LNK-00027F-00@starship>
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
Content-Transfer-Encoding: 7bit

Daniel Phillips wrote:

> Patching the kernel how, and where?

Check for example in asm-ppc/page.h the __va/__pa functions.

> > Anyway, I agree with Andrea, that another mapping isn't really needed.
> > Clever use of the mmu should give you almost the same result.
> 
> We *are* making clever use of the mmu in config_nonlinear, it is doing the
> nonlinear kernel virtual mapping for us.  Did you have something more clever
> in mind?

I mean to map the memory where you need it. The physical<->virtual
mapping won't be one to one, but you won't need another abstraction and
the current vm is already basically able to handle it.

bye, Roman

--nmemrqcdn5VTmUEE--
