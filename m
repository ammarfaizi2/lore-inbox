Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317096AbSGNUfM>; Sun, 14 Jul 2002 16:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317102AbSGNUfL>; Sun, 14 Jul 2002 16:35:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3135 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S317096AbSGNUfI>; Sun, 14 Jul 2002 16:35:08 -0400
To: Ishikawa <ishikawa@yk.rim.or.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: boot time memory region recognition and clearing.
References: <3D303700.5030002@yk.rim.or.jp>
	<m14rf2ra95.fsf@frodo.biederman.org> <3D319AEA.10F6611D@yk.rim.or.jp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Jul 2002 14:26:37 -0600
In-Reply-To: <3D319AEA.10F6611D@yk.rim.or.jp>
Message-ID: <m1u1n2oy2q.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ishikawa <ishikawa@yk.rim.or.jp> writes:

> "Eric W. Biederman" wrote:
> 
> > Note.  The hardware ECC support in memtest86 3.0
> > is limited, so I would check to make certain your chipset
> > is supported..
> > 
> 
> Well,  I read controller.c source file, and
> found that amd751 is supported according to the info
> in AMD751 documentation.
> (This is the same documentatin I used when I hacked
> early ecc.c source file.)
> 
> I ran memtest v3 on the motherboard, and
> it didn't find any errors when I ran it overnight.

I wasn't able to verify it so the AMD751 was disabled by default.
> 
> > Your objective is misguided.  Even with a bios that
> > is slightly buggy in initializing the ECC bits, what you want is
> > scrubbing.  Then if the error disappears after 5 minutes of uptime
> > you can ignore it.  
> 
> I see. Then the problem would boil down whether
> AMD751 supports scrubbingat the hardware level.
> It reports that it saw correctable single bit error,
> and I take it to mean that the chip itself
> has fixed the single bit error.
> Am I too optimistic to expect this?

The single bit error has been corrected in only one direction,
in the data going to the cpu.  The data remaining in memory
was not corrected.

> The problem, though, is this.
> According to the AMD751 documentation, we
> can clear the memory error info in the chip register,
> by writing to a certain location of the PCI space.
> However, when one error get reported on my motherboard,
> it would NOT go away and I think there is something amiss
> about this.

That the location is frequently read and there is no hardware
scrubbing (writing the correct value back to ram).

> I am not sure if the AMD doc is correct about this now.
> from controller.c of memtest86.
> 
>                 /* Clear the error status */
>                 pci_conf_write(ctrl.bus, ctrl.dev, ctrl.fn, 0x58, 2, 0);
> 
> >From locally hacked ecc.c:
>              /*
>                  * clear error flag bits that were set by writing 0 to
> them
>                  * we hope the error was a fluke or something :)
>                  */
>                 /* int value = eccstat & 0xFCFF; */
>                 /* pci_write_config_word(bridge, 0x58, value); */
>                 pci_write_config_byte(bridge, 0x58, 0x0);
>                 pci_write_config_byte(bridge, 0x59, 0x0);

Both of which match.

> BTW, I tried both the byte and word write to 0x58, but
> it never seemd to clear the error status.
> (It is possible that the error is real, but again
> the error is reported always in the first bank even if
> I rotate the memry sticks...)

Sounds like a questionable bit of documentation.
 
> > And if it comes back you know you really have
> > something to worry about.  At least for single bit errors this should
> > fix the whole problem with something that is useful for other
> > purposes.
> > 
> > Eric
> 
> Thank you for your feedback. I noticed that you 
> contributed to linuxBIOS and memtest86.
> Please keep the good work going!

Hopefully we can get the problems well enough understood in the community
that we can actually get some of this code fixed up and working well.

Eric
