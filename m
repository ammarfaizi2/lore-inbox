Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277136AbRJHVL2>; Mon, 8 Oct 2001 17:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277135AbRJHVLU>; Mon, 8 Oct 2001 17:11:20 -0400
Received: from postfix2-2.free.fr ([213.228.0.140]:787 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S277136AbRJHVLG> convert rfc822-to-8bit; Mon, 8 Oct 2001 17:11:06 -0400
Date: Mon, 8 Oct 2001 23:06:02 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jes Sorensen <jes@sunsite.dk>, <paulus@samba.org>,
        "David S. Miller" <davem@redhat.com>, <linuxopinion@yahoo.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: how to get virtual address from dma address 
In-Reply-To: <200110072302.f97N2GX03070@localhost.localdomain>
Message-ID: <20011008223556.C1745-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Oct 2001, James Bottomley wrote:

> groudier@free.fr said:
> > No problem. Here is the FULL simple code from SYM-2 driver that
> > perform the reverse mapping (it is mostly the same in sym53c8xx):
>
> Well, since this piece of code isn't in the current kernel,

It cames from sym53c8xx. Wheel didn't get reinvented here.

> it makes it more
> difficult, but it looks to me like there's an internal ccb structure in the
> driver that would contain pointers to the scsi command pointer, the dsa
> structure and various other things.  The dsa structure is the chip's internal
> representation of an outstanding command.  When a command is completed, you
> get a dma address of the dsa pointer back from the chip, so you do the
> sym_ccb_from_dsa() conversion to get the ccb and from that you get the virtual

Is ncr_ccb_from_dsa() in sym53c8xx.

> address of the dsa structure because you need to collect completion
> information about the command before sending it back into the mid-layer.
>
> The way you do this is to walk a list of ccb structures hashed on the dsa
> pointer for efficient reverse lookup until you find the ccb of the returning
> dsa.

Correct. :)

> It's certainly a valid thing to do, I've done it before myself.  However, an
> equally valid way of processing a returning dsa is to embed a pointer to the
> ccb structure in the dsa structure.  Then to get back to the ccb you simply
> dereference the dsa structure.  The catch now is that I need the virtual
> address of the dsa pointer.  If I had the API I could do this.  How
> efficiently?  well on the x86 it's a simple bit flip to get the virtual
> address and away I go. The cost is O(1).

Compared to other load involving an IO, the current driver hash load is
_negligible_. The DSA value is returned by the SCSI scripts that runs in
the chip hardware. Dereferencing this value looks brain-damage to me. I
_do_ want to _reliably_ catch situations where this value is just bogus,
whatever it is due to a hardware failure or a driver bug.

> On the most opaque DMA hardware, the
> mappings would have to be stored separately in a hash table.  The cost of
> doing the lookup is O(number of pages registered for this device) which, since
> I would expect to pack a few dsa structures per page is less than O(total dsa
> structures).

In my taste and in the context of sym* drivers, you suggestion is a wrong
solution to a simple problem. OTOH, the optimization it provides is not
worthwhile here.

> Your method, providing only outstanding dsa structures are hashed, has an
> efficiency O(total outstanding commands).

All data structures (for simplicity) are hashed in 256 buckets.
The hash, despite it is simplistic, is tricky enough to give good results.
It is based on the fact that all driver internal data structures are
naturally aligned and the following simple alchemy from my own does the
trick:

#define CCB_HASH_CODE(dsa)	\
	(((dsa) >> (_LGRU16_(sizeof(struct sym_ccb)))) & CCB_HASH_MASK)

You are not required to understand how it works, but please donnot send
inaccurate statements to the list.

> So, for the worst case DMA hardware the two methods are very comparable (you
> can probably get each to beat the other by judicious tuning of the hash bucket
> size).  For the best case DMA hardware, my lookup is O(1) which is hard for a
> hash lookup to beat.

It just gives a different service that the one I want for the driver and
does try to optimize code that does not need to be faster.

> So, in summary we have two methods, each of which could beat the other under
> optimal hardware conditions.  Which should be used?  well that's up to the
> choice of the device driver writer.
>
> My point here is that there isn't a choice any more because the API to do DMA
> to virtual address mappings is gone.  What I've done is proposed a replacement
> API that will have no impact on a device driver writer who doesn't want to use
> it.
>
> The fact that you wouldn't use it is irrelevant to the argument, since I've no
> wish to force you to.  However, I do want the the freedom to write my drivers
> according to my choice of method.
>
> So the outstanding point of debate still remains:  what is wrong with the
> proposed API?  The arguments I've heard so far are:
>
> - It might be misused [true but not relevant].
> - It would bloat the kernel [Actually, it would be implemented as #defines
> like the standard dma APIs, so would only bloat the kernel for hardware that
> has no window into the IOMMU]
> - You can do the same thing differently [true, but you cannot do it as
> efficiently on optimal dma hardware].

I donnot decide of anything regarding kernel APIs. If you think your
proposal of this new API is good then just send a patch to Linus and if it
gets accepted, then you win.
OTOH, I would not lose anything. :)

  Gérard.

