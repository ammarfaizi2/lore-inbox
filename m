Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbWFTV76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWFTV76 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWFTV76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:59:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55488 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751022AbWFTV75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:59:57 -0400
Date: Tue, 20 Jun 2006 15:03:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Isaacson <adi@hexapodia.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc[56]-mm*: pcmcia "I/O resource not free"
Message-Id: <20060620150317.746372c5.akpm@osdl.org>
In-Reply-To: <20060620211723.GA28016@hexapodia.org>
References: <20060615162859.GA1520@hexapodia.org>
	<20060617100327.e752b89a.akpm@osdl.org>
	<20060620211723.GA28016@hexapodia.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson <adi@hexapodia.org> wrote:
>
> On Sat, Jun 17, 2006 at 10:03:27AM -0700, Andrew Morton wrote:
> > > The PCMCIA slot on my Thinkpad X40 stopped working sometime between
> > > 2.6.17-rc4-mm3 and 2.6.17-rc5-mm3, and is still not working as of
> > > 2.6.17-rc6-mm2.
> [snip]
> > > -Probing IDE interface ide2...
> > > -hde: CF Card, CFA DISK drive
> > > -PM: Adding info for No Bus:ide2
> > > -hdf: probing with STATUS(0x50) instead of ALTSTATUS(0x0a)
> > > +ide2: I/O resource 0xF8A8A00E-0xF8A8A00E not free.
> > > +ide2: ports already in use, skipping probe
> > > +ide2: I/O resource 0xF8A8A01E-0xF8A8A01E not free.
> > > +ide2: ports already in use, skipping probe
> > > +ide2: I/O resource 0xF8A8A00E-0xF8A8A00E not free.
> > > +ide2: ports already in use, skipping probe
> > 
> > hm.   I don't know who to blame for this yet ;)
> > 
> > The contents of /proc/ioports on both kernels might be useful.  Let's see
> > which device+driver is already using those ports, and whether the older
> > kenrel uses the same addresses.
> 
> In further testing, -rc6 is fine while -rc6-mm2 fails.

OK.

> Under 2.6.17-rc6 (after having inserted and removed the card, but that
> doesn't seem to make much difference) I have
> 
> 0000-001f : dma1
> ...

I should have said iomem, not ioports.  But you have it there on those very
detailed web pages.  There's nothing at 0xF8A8Axxx in either kernel.

> The diff between -rc6 and -rc6-mm2 shows that they have the same ioport
> assignment (there's only a textual diff due to ACPI string changes).

yep.  The only reelvant diff in the rc6 versus rc6-mm2 /proc/iomem is:

@@ -29,7 +29,6 @@
   d0220000-d0220fff : 0000:02:02.0
     d0220000-d0220fff : ipw2200
   d0221000-d02210ff : 0000:02:00.1
-  d1200000-d1200fff : pcmcia_socket0
   d2000000-d3ffffff : PCI CardBus #03
 e0000000-e7ffffff : 0000:00:02.0
 e8000000-efffffff : 0000:00:02.1

whch is to be expected if you removed the card.


> I've put just about everything you could want to know about the two
> kernels at
> http://web.hexapodia.org/~adi/bobble/bobble_2.6.17-rc6_20060620093733/
> and
> http://web.hexapodia.org/~adi/bobble/bobble_2.6.17-rc6-mm2_20060620094254/
> 

It's strange (to me) that IDE is requesting a single-byte memory region. 
Possibly we've broken the resource.c code such that it has some off-by-one
and is now rejecting single-byte requests.

If you're keen , the place to poke around is in
kernel/resource.c:__request_region().   Here's a starting patch:


--- a/kernel/resource.c~a
+++ a/kernel/resource.c
@@ -501,6 +501,10 @@ struct resource * __request_region(struc
 			conflict = __request_resource(parent, res);
 			if (!conflict)
 				break;
+			printk("conflict: %s[%Lx->%Lx]\n",
+				conflict->name,
+				(unsigned long long)conflict->start,
+				(unsigned long long)conflict->end);
 			if (conflict != parent) {
 				parent = conflict;
 				if (!(conflict->flags & IORESOURCE_BUSY))
_

Which should tell us what we're allegedly conflicting with.




Then again, perhaps IDE is broken (as well?), because you don't have any
single-byte iomem regions in your 2.6.17-rc6 /proc/iomem.  It would be
interesting to run this patch in both 2.6.17-rc6 and in 2.6.17-rc6-mm2, see
what it says:

diff -puN drivers/ide/ide.c~a drivers/ide/ide.c
--- 25/drivers/ide/ide.c~a	Tue Jun 20 15:01:32 2006
+++ 25-akpm/drivers/ide/ide.c	Tue Jun 20 15:02:15 2006
@@ -364,6 +364,10 @@ static struct resource* hwif_request_reg
 {
 	struct resource *res = request_region(addr, num, hwif->name);
 
+	if (num == 1) {
+		printk("%s: single-byte request\n", __FUNCTION__);
+		dump_stack();
+	}
 	if (!res)
 		printk(KERN_ERR "%s: I/O resource 0x%lX-0x%lX not free.\n",
 				hwif->name, addr, addr+num-1);
_

