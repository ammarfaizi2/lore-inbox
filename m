Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276633AbRJGXDN>; Sun, 7 Oct 2001 19:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276634AbRJGXDC>; Sun, 7 Oct 2001 19:03:02 -0400
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:20303
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S276633AbRJGXCp>; Sun, 7 Oct 2001 19:02:45 -0400
Message-Id: <200110072302.f97N2GX03070@localhost.localdomain>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jes Sorensen <jes@sunsite.dk>, paulus@samba.org,
        "David S. Miller" <davem@redhat.com>, linuxopinion@yahoo.com,
        linux-kernel@vger.kernel.org
Subject: Re: how to get virtual address from dma address 
In-Reply-To: Message from =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr> 
   of "Sun, 07 Oct 2001 20:24:26 +0200." <20011007195159.D1867-100000@gerard> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 07 Oct 2001 18:02:15 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

groudier@free.fr said:
> No problem. Here is the FULL simple code from SYM-2 driver that
> perform the reverse mapping (it is mostly the same in sym53c8xx): 

Well, since this piece of code isn't in the current kernel, it makes it more 
difficult, but it looks to me like there's an internal ccb structure in the 
driver that would contain pointers to the scsi command pointer, the dsa 
structure and various other things.  The dsa structure is the chip's internal 
representation of an outstanding command.  When a command is completed, you 
get a dma address of the dsa pointer back from the chip, so you do the 
sym_ccb_from_dsa() conversion to get the ccb and from that you get the virtual 
address of the dsa structure because you need to collect completion 
information about the command before sending it back into the mid-layer.

The way you do this is to walk a list of ccb structures hashed on the dsa 
pointer for efficient reverse lookup until you find the ccb of the returning 
dsa.

It's certainly a valid thing to do, I've done it before myself.  However, an 
equally valid way of processing a returning dsa is to embed a pointer to the 
ccb structure in the dsa structure.  Then to get back to the ccb you simply 
dereference the dsa structure.  The catch now is that I need the virtual 
address of the dsa pointer.  If I had the API I could do this.  How 
efficiently?  well on the x86 it's a simple bit flip to get the virtual 
address and away I go. The cost is O(1).  On the most opaque DMA hardware, the 
mappings would have to be stored separately in a hash table.  The cost of 
doing the lookup is O(number of pages registered for this device) which, since 
I would expect to pack a few dsa structures per page is less than O(total dsa 
structures).

Your method, providing only outstanding dsa structures are hashed, has an 
efficiency O(total outstanding commands).

So, for the worst case DMA hardware the two methods are very comparable (you 
can probably get each to beat the other by judicious tuning of the hash bucket 
size).  For the best case DMA hardware, my lookup is O(1) which is hard for a 
hash lookup to beat.

So, in summary we have two methods, each of which could beat the other under 
optimal hardware conditions.  Which should be used?  well that's up to the 
choice of the device driver writer.

My point here is that there isn't a choice any more because the API to do DMA 
to virtual address mappings is gone.  What I've done is proposed a replacement 
API that will have no impact on a device driver writer who doesn't want to use 
it.

The fact that you wouldn't use it is irrelevant to the argument, since I've no 
wish to force you to.  However, I do want the the freedom to write my drivers 
according to my choice of method.

So the outstanding point of debate still remains:  what is wrong with the 
proposed API?  The arguments I've heard so far are:

- It might be misused [true but not relevant].
- It would bloat the kernel [Actually, it would be implemented as #defines 
like the standard dma APIs, so would only bloat the kernel for hardware that 
has no window into the IOMMU]
- You can do the same thing differently [true, but you cannot do it as 
efficiently on optimal dma hardware].

James Bottomley


