Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155265AbQAaIkd>; Mon, 31 Jan 2000 03:40:33 -0500
Received: by vger.rutgers.edu id <S155117AbQAaIkP>; Mon, 31 Jan 2000 03:40:15 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:4116 "EHLO smtp1.cern.ch") by vger.rutgers.edu with ESMTP id <S155340AbQAaIjK>; Mon, 31 Jan 2000 03:39:10 -0500
To: Jakub Jelinek <jakub@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, rmk@arm.linux.org.uk, linux-kernel@vger.rutgers.edu
Subject: Re: DMA changes in 2.3.41 - how the f* do I get this working on ARM?
References: <200001300006.AAA02084@raistlin.arm.linux.org.uk> <200001302211.OAA03036@pizda.ninka.net> <d3oga2r22z.fsf@lxplus011.cern.ch> <20000131124552.I948@mff.cuni.cz>
From: Jes Sorensen <Jes.Sorensen@cern.ch>
Date: 31 Jan 2000 13:48:47 +0100
In-Reply-To: Jakub Jelinek's message of "Mon, 31 Jan 2000 12:45:52 +0100"
Message-ID: <d37lgqquds.fsf@lxplus011.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-kernel@vger.rutgers.edu

>>>>> "Jakub" == Jakub Jelinek <jakub@redhat.com> writes:

>>  Hmmm ok I just noticed this and I haven't read that DMA mapping
>> document yet. I'll have to look at it to see how it affects PCI
>> devices that are 64 bit address capable.

Jakub> The whole interface is currently for SAC. For using DAC, you
Jakub> need arch details how to build the DAC address (e.g. on
Jakub> UltraSPARC you usually want 0xfffc in bits 63:50 to set DMA
Jakub> bypass) and it really depends if it is a gain or lose (with SAC
Jakub> and dynamic mapping, you can manage to collapse a bunch of sg
Jakub> chunks into one sg entry, while with DAC you cannot. Also, with
Jakub> SAC on sparc64 PCI chips you can specify whether you want
Jakub> streaming mode or not, while with bypass it is always
Jakub> consistent if I remember well - the cacheability is determined
Jakub> from the physical address though). On the other side with DAC
Jakub> you save filling up the IOPTEs and clearing them after.

Sure for 32 bit cards thats true, however DACs should theoretically
allow us to DMA into the 36 bit address space on the x86 boxes?
However, I was actually mainly thinking about 64 bit PCI cards,
there's a fair amount of them out now and it would be nice to support
it properly on hardware that has 64 bit PCI slots.

>>  The one thing for the m68k is that we have very few machines with
>> PCI, though we still suffer a lot from the DMA coherency problem on
>> the busses we do have.

Jakub> The API is pci_* because it takes a struct pci_dev *. SBUS has
Jakub> identical API with sbus_* which takes struct sbus_dev *.  The
Jakub> goal is to merge all bus device structures into struct pci_dev
Jakub> (but keeping as much as possible bus specific things in
Jakub> sysdata) and call it a generic hardware device structure. Then
Jakub> all those interfaces can be merged, its just the changes need
Jakub> to be incremental (Linus did not like introducing device_t type
Jakub> and casting struct pci_dev etc. structures to it and back so it
Jakub> got removed from the patch).

Long term merge to a generic device interface sounds good to me. The
DMA mappings document got as far as the printer now, next step will be
to read it.

>>  The place where this is a real problem is in drivers where data is
>> shared between the adapter and the host CPU, for instance the
>> 53c7xx driver. On the m68k we currently use a
>> kernel_set_cachemode() function to change the caching of the page
>> allocated for the shared structures, but thats a pretty non
>> portable way of doing it. I would like to see something a
>> get_free_cachecoherent_page() interface instead, what do you think
>> of that?

Jakub> Why cannot you do this in pci_alloc_consistent?

Because the machine in question doesn't have the slightest idea what
PCI means ;-) But yes, I will look at the new PCI interface and see if
we can use that.

Jes

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
