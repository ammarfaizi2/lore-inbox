Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbTEMOmx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 10:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbTEMOmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 10:42:53 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:21915
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261260AbTEMOmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 10:42:49 -0400
Subject: Re: 2.6 must-fix list, v2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030512155511.21fb1652.akpm@digeo.com>
References: <20030512155417.67a9fdec.akpm@digeo.com>
	 <20030512155511.21fb1652.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052834227.432.30.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 May 2003 14:57:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-12 at 23:55, Andrew Morton wrote:
> 
> - IDE tcq. Either kill it or fix it. Not a "big todo", as such.
> 

There are lots of other IDE bugs that wont go away until the taskfile
stuff is included, the locking bugs that allow any user to hang the IDE
layer in 2.5, and some other updates are forward ported. Bart is making
amazing progress.

> - Lots of drivers don't compile, others do but don't work.

True of char, scsi and others. I'd like to propose that we don't treat
drivers that need porting as a 2.6test showstopper. In fact its going to
be a lot easier to fix them once someone can port them knowing the core
code is frozen. 

drivers/pci

Some cardbus crashes the system
Hotplug locking is hosed

drivers/pcmcia
Most drivers crash the system on eject randomly with timer bugs. I think
after RML's stuff is in most of the pcmcia/cardbus ones go except the
locking disaster

> - davej: NFS seems to have a really bad time for some people.  (Including
>   myself on one testbox).  The common factor seems to be a high spec client
>   torturing an underpowered NFS server with lots of IO.  (fsx/fsstress etc
>   show this up).  Lots of "NFS server cheating" messages get dumped, and a
>   whole lot of bogus packets start appearing.  They look severely corrupted,
>   (they even crashed ethereal once 8-)

Lots of recent 2.4 NFS fixes in the client especially want forward
porting

> - Alan: 32bit uid support is *still* broken for process accounting.
> 
>   (Test case?)

Create a 32bit uid, turn accounting on. Shock horror it doesnt work
because the field is 16bit. We need an acct structure flag day for 2.6
IMHO


> - Proper user level no overcommit also requires a root margin adding

I've played with this a bit, it turns out to be suprisingly trivial

> Not-ready features and speedups
> ===============================
> 

> - 32bit quota needs a lot more testing but may work now

Seems to work in 2.4-ac at the moment 8)

> - ES7000 wants merging (now we are all happy with it).  That shouldn't be a
>   big problem.

In 2.5.6x-ac - just worked.

> drivers
> =======
> 
> - Alan: PCI random reordering from 2.4 to 2.5 isnt understood yet (might be
>   fixed now?)

FIXED

> - Lots of network drivers don't even build

Mostly fixed

> drivers/acpi/
> -------------
> 
> - davej: ACPI has a number of failures right now.  There are a number of
>   entries in bugzilla which could all be the same bug.  It manifests as a
>   "network card doesn't recieve packets" booting with 'acpi=off noapic' fixes
>   it.

VIA APIC stuff is one bit of this, there are also some other reports
that were caused by ACPI not setting level v edge trigger some times

> drivers/block/
> --------------
> 
> - Alan: Partition handling is hosed for DM users.  (I have some partly
>   debugged patches in the -ac tree, but Andries objects to them and I think
>   his user knows magic options hack is unacceptable too.  Mostly this is
>   figuring out the right answer)

"FIXED" - We've established the device mapper can do the translation.
Its a chunk of work for vendors but its doable

> - Floppy is almost unusably buggy still

Seems to be working for me now as of 2.5.69-ac1


> drivers/char/
> -------------
> 
> - Alan: Multiple serious bugs in the DRI drivers (most now with patches
>   thankfully).  "The badness I know about is almost entirely IRQ mishandling.
>    DRI failing to mask PCI irqs on exit paths."

Linus has been updating DRI stuff since then so may be sorted

> drivers/ide/
> ------------
> 
>   (Alan)
> 
> - IDE requires bio walking

Bartlomiej has IDE multisector working

> - IDE PIO has occasional unexplained PIO disk eating reports

Seems ok in 2.5.69-ac

> - IDE has multiple zillions of races/hangs in 2.5 still

The wonder Bart is currently redoing ide setup which is the big mess
left and has tackled taskfile block I/O already.

> - IDE eats disks with HPT372N on 2.5.x

Fixed for 2.4.x now - can be ported easily. This has folded into
"forward port IDE driver fixes from 2.4"

> - IDE needs significant reworking to handle Simplex right

Some old draft patches from Torben exist for the beginnings of
this.

> arch/i386/
> ----------
> 
> - 2.5.x won't boot on some 440GX

Problem understood now, feasible fix in 2.4/2.4-ac. (440GX has two IRQ
routers, we use the $PIR table with the PIIX, but the 440GX doesnt use
the PIIX for its IRQ routing). Fall back to BIOS for 440GX works and
Intel concurs.

> - 2.5.x doesn't handle VIA APIC right yet - dont know why

1. We must write the PCI_INTERRUPT_LINE, 2. We have quirk handlers that
seem to trash it.

> - ACPI needs the relax patches merging to work on lots of laptops

Working in 2.4.21-ac, Toshiba cheap laptops now run a treat. Forward
port looks like a patch command


Other items:

PC9800 is not fully merged - most of this I think is 2.7 stuff but a few
bits might be 2.6 candidate

SH3/SH3-64 need resynching, as do some other ports. No impact on
mainstream platforms hopefully


