Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUDBVoN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 16:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbUDBVoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 16:44:12 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:20382
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261169AbUDBVm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 16:42:58 -0500
Date: Fri, 2 Apr 2004 23:42:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, hugh@veritas.com, vrajesh@umich.edu,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040402214258.GU21341@dualathlon.random>
References: <20040331150718.GC2143@dualathlon.random> <Pine.LNX.4.44.0403311735560.27163-100000@localhost.localdomain> <20040331172851.GJ2143@dualathlon.random> <20040401004528.GU2143@dualathlon.random> <20040331172216.4df40fb3.akpm@osdl.org> <20040401012625.GV2143@dualathlon.random> <20040331175113.27fd1d0e.akpm@osdl.org> <20040401020126.GW2143@dualathlon.random> <20040402201343.GA195@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040402201343.GA195@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 10:13:43PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > An anonymous user page meets these requirements.  A did say "anal", but
> > > rw_swap_page_sync() is a general-purpose library function and we shouldn't
> > > be making assumptions about the type of page which the caller happens to be
> > > feeding us.
> > 
> > that is a specialized backdoor to do I/O on _private_ pages, it's not a
> > general-purpose library function for doing anonymous pages
> > swapin/swapout, infact the only user is swap susped and we'd better
> > forbid swap suspend to pass anonymous pages through that interface and
> > be sure that nobody will ever attempt anything like that.
> > 
> > that interface is useful only to reach the swap device, for doing I/O on
> > private pages outside the VM, in the old days that was used to
> > read/write the swap header (again on a private page), swap suspend is
> > using it for similar reasons on _private_ pages.
> 
> Ahha, so *here* is that discussion happening. I was only seeing it at
> bugzilla, and could not make sense of it.

;)

btw, as far as I can tell I cannot see anymore VM issues with current CVS
kernel, what I get now is:

Resume Machine: resuming from /dev/sda1 
Resuming from device sda1 
Resume Machine: Signature found, resuming 
Resume Machine: Reading pagedir, Relocating pagedir.:| 
Reading image data (3420 pages): ...................................| 
Reading resume file was successful 
hdc: start_power_step(step: 0) 
hdc: completing PM request, suspend 
Waiting for DMAs to settle down... 
Freeing prev allocated pagedir 
hdc: Wakeup request inited, waiting for !BSY... 
hdc: start_power_step(step: 1000) 
hdc: completing PM request, resume 
Fixing swap signatures... scsi0:A:0:0: ahc_intr - referenced scb not valid 
during seqint 0x71 scb(1) 
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<< 
scsi0: Dumping Card State in Message-in phase, at SEQADDR 0x1a6 
Card was paused 
ACCUM = 0x0, SINDEX = 0x71, DINDEX = 0xe4, ARG_2 = 0x0 
HCNT = 0x0 SCBPTR = 0x3 
SCSIPHASE[0x8] SCSISIGI[0xe6] ERROR[0x0] SCSIBUSL[0x0] 
LASTPHASE[0xe0] SCSISEQ[0x12] SBLKCTL[0xa] SCSIRATE[0xc2] 
SEQCTL[0x10] SEQ_FLAGS[0x0] SSTAT0[0x7] SSTAT1[0x11] 
SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x8] SIMODE1[0xac] 
SXFRCTL0[0x88] DFCNTRL[0x4] DFSTATUS[0x89] 
STACK: 0xff 0x0 0x163 0x178 
SCB count = 8 
Kernel NEXTQSCB = 1 
Card NEXTQSCB = 5 
QINFIFO entries: 1 5 1 5 1 5 1 5 1 5 1 5 1 5 1 5 1 5 
Waiting Queue entries: 
Disconnected Queue entries: 2:5 1:1 0:5 
QOUTFIFO entries: 
Sequencer Free SCB List: 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 
24 25 26 27 28 29 30 31 
Sequencer SCB Info: 
  0 SCB_CONTROL[0x64] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0x5] 
  1 SCB_CONTROL[0x64] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0x1] 
  2 SCB_CONTROL[0x64] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0x5] 
  3 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0x1] 
  4 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
  5 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
  6 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
  7 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
  8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
  9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
 10 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
 16 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
 17 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
 18 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
 19 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
 20 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
 21 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
 22 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
 23 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
 24 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
 25 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
 26 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
 27 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
 28 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
 29 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
 30 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
 31 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Pending list: 
  5 SCB_CONTROL[0x60] SCB_SCSIID[0x7] SCB_LUN[0x0] 
Kernel Free SCB list: 6 2 7 0 3 4 
DevQ(0:0:0): 0 waiting 
DevQ(0:1:0): 0 waiting 
  
<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>> 
Kernel panic: for safety 
In interrupt handler - not syncing 

I believe this is fine with you, I mean, you told me this is because the
aic7xxx cannot restore, right?

the only VM pending bug right now (besides the mprotect feature request that I
already implemented at 85%) is the compound bugreport from Christoph, but to me
that sounds a kernel miscompilation, it makes no sense that PageCompound(p) ==
0 and after a nanosecond p->flags & (1<<PG_compound) == 1, and no, it's not
likely a race condition, and nothing weird like that ever happened on x86 yet,
and that's all common code (no arch details in the compound thing, infact it
must not even depend on MMU etc..).

> 
> If swsusp/pmdisk are only user of rw_swap_page_sync, perhaps it should
> be moved to power/ directory?

it's ok to leave it in page_io.c since it's generating a fake-swapcache
entry, and there are writeback details etc.. that'd better stay in the
mm layer.
