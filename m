Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131193AbQLUXJF>; Thu, 21 Dec 2000 18:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131257AbQLUXIz>; Thu, 21 Dec 2000 18:08:55 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:61772
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S131193AbQLUXIi>; Thu, 21 Dec 2000 18:08:38 -0500
Date: Thu, 21 Dec 2000 23:38:05 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: Cleanup (PCI API and general) of drivers/net/rcpci.c (240t13p3)
Message-ID: <20001221233805.E611@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This is the final version of my rcpci45.c patch. It is somewhat more
ambitious than the last one (which only cleaned up the PCI API), so 
I would appreciate feedback since I don't know half of what I am doing 
(questions galore below). It features:

o Conversion to new PCI API.
o Removal of a bunch of #ifdef DEBUG around printk statements in favor 
  of a dprintk define (dependent on DEBUG).
o All printk now have a proper KERN_* message prefix.
o Consolidation of device information into struct net_device where
  possible. This gave rise to some data structure (see below) and 
  function parameter cleanup.
o Removal of 32 adapters limit (see also questions).
o Conversion of for-loops used for delays into udelay() calls (see
  also questions).
o Conversion of return cases with resource deallocation to do to 
  'goto err_out' constructs.
o General cleanup.

Because of its larger scope the patch's size have also increased to
the point where it is not suited for posting to lkml. It can be down-
loaded from www.jaquet.dk/kernel/patches/rcpci.patch.gz (~22 Kb).
(Most of the diff is trivial stuff.)

I would also like to note that if my patch is accepted the patch size
increase of running an 'indent -kr -i8' on the files is minimal (and 
would be nice). It is currently indented with four spaces (except the
places where I slipped and used the standard eight).

It would be really nice if somebody could test this patch on appro-
priate hardware since I do not own one of these cards.



Data structure reorganization:

The current driver uses two static index arrays to point to a device's
Driver Private Area and PCI Adapter Block, respectively. These blocks
(structs) were located in one large kmalloced memory block allocated
during init and accessed by offsets. The remaining part of this block
was used for message buffers for the device.

My patch makes these three areas be seperate kmalloced areas and uses
the net_device->priv pointer to keep track of the relevant data
structures for the given device. Thus the two static arrays can be
done away with since the net_device->priv pointer is at hand all places
where we need it. From this a number of simple cleanups then present
themselves.

(I have tried to keep the above desciption short since it might not
be of interest to many. Detail level and (perhaps) readability has
suffered as a result. Please comment if you would like more details.)


Questions for the maintainers, should they read this (does anyone
know their email addresses?) (others should feel free to chip in):

o The driver currently allocates irqs during its initialization
  instead of postponing it until it is opened for use. Is there
  a reason for this?

o You write that the private message buffer (referenced by
  pDpa->PLanApiPA) should be at least 16Kb but you never seem
  to check for the actual size of the allocated memory anywhere.
  Am I missing something or are you operating on assumptions
  here? 


General questions about PCI and mmio stuff:

o The current driver uses two static arrays to keep track of
  device instances. I have eliminated these arrays in my patch.
  Is there some limitation in the pci interface that requires
  me to check for/limit the number of adapters (besides sanity
  checks)?

o I use kmalloc without being totally familiar with the GFP_*
  flags. Could somybody please shortly descibe their use so I
  can check I haven't messed up? In particular, there is a
  requirement for a message buffer that 'must be in locked pages'
  and 'long word aligned'. The current drivers uses  GFP_DMA | 
  GFP_KERNEL|GFP_ATOMIC for this buffer (and some extra stuff
  for the alignment requirements. More about this below). Do 
  we need all these? I have limited myself to GFP_DMA|GFP_KERNEL 
  but really have no clue...

o The current code uses a '+0xff) & ~0xff)'-thingie to align
  the message buffer for 'long word alignment'. Is there another
  (nicer) way to do this? Or is this the recommended way?

o I have replaced a lot of 'for(i=0;i<1000;i++) ;' loops used to
  delay repeated PCI bus access with udelay(10), a value I randomly
  picked. Could anyone comment on this value?

o The current driver ioremaps 64K of PCI address space. This
  seems to be (judging from the way it is written in the code)
  set to twice the memory reserved for the private message
  buffer. Is this the correct way to do this or is there a
  better way to determine the size of ioremaps? (I guess I
  show my ignorance here...) My patch uses pci_resources_len
  but this seems ... too easy?


General questions:

o If p32 is defined as a 'volatile PU32' is it necessary to use
  the cast (volatile PU32) when assigning to it? Isn't '(PU32)'
  enough?


-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

I've always found profanity to be refuge of the inarticulate motherfucker.
  --Anonymous
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
