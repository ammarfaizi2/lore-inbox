Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129391AbQK1Ul1>; Tue, 28 Nov 2000 15:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129414AbQK1UlS>; Tue, 28 Nov 2000 15:41:18 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:56076 "EHLO zikova.cvut.cz")
        by vger.kernel.org with ESMTP id <S129391AbQK1UlG>;
        Tue, 28 Nov 2000 15:41:06 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Alexander Viro <viro@math.psu.edu>
Date: Tue, 28 Nov 2000 21:10:36 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.4.0-test11 ext2 fs corruption
CC: linux-kernel@vger.kernel.org, tytso@valinux.com
X-mailer: Pegasus Mail v3.40
Message-ID: <E2BA5DE1AE9@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Nov 00 at 15:02, Alexander Viro wrote:
> On Tue, 28 Nov 2000, Petr Vandrovec wrote:
> 
> > Hi Al,
> >   during weekend I was uncompressing XFree (Debian's 4.0.1-7) at home,
> > with 2.4.0-test11 running on Celeron 300A, 128MB RAM, SMP kernel on up.
> > It failed to compile lbxproxy/di/main.c. After some investigation I found
> > that they were overwritten by some source font data. fsck did not reveal
> > any croslinked clusters, nothing. Filesystem itself uses 4KB clusters.
> > 
> >   Today I found some spare time and investigated it further. There is
> > same data contents in:
> > 
> > programs/lbxproxy/di/init.c 0-8720  fonts/bdf/75dpi/lubR24.bdf  0x5000-0x7210
> >                  lbxfuncs.c 0x0000-0x0EC0           lubR24.bdf  0x8000-0x8EC0
> >                             0x0EC1-0x0FFF                      zero
> >                             0x1000-0x5ABC           lutBS08.bdf 0x0000-0x4ABC
> >                             0x5ABD-0x5FFF                      zero
> >                             0x6000-0x92C1           lutBS10.bdf 0x0000-0x32C1
> >                  lbxutil.c  0x0000-0x1E27           lutBS10.bdf 0x4000-0x5E27
> >                             0x1E28-0x1FFF                      zero
> >                             0x2000-0x3452           lutBS12.bdf 0x0000-0x1452   
> >                  main.c     0-4614                  lutBS12.bdf 0x2000-0x3206
> >                  options.c  0x0000-0x222E           lutBS12.bdf 0x4000-0x622E
> >                             0x222F-0x2FFF                      zero
> >                             0x3000-0x4E30           lutBS14.bdf 0x0000-0x1E30
> >                  pm.c       0-11706                 lutBS14.bdf 0x2000-0x4DA8
> >              (blocks 722433-722459)                (blocks 558899-~558927)
> >              
> > Other files are intouch. As you can see, somewhat disk blocks
> > ended somewhere else than they should in addition to correct place.
> > I also found that data after end of file in di/*.c files are not
> > cleared, so maybe that ide driver did a mistake? But I was not able
> > to find how to convert either block address, or LBA adress, or CHS
> > address (drive uses 839/240/63, but I hope that it runs in LBA) to
> > get 558899 from 722433 or vice versa.
> 
> Erm... Do you mean that you've got a 1-1 correspondence in data between these
> two ranges? Then it looks like something way below the fs level... Weird.
> Could you verify it with dd?

Yes, it is identical copy. But I do not think that hdd can write same
data into two places with one command...

vana:/# dd if=/dev/hdd1 bs=4096 count=27 skip=722433 | md5sum
27+0 records in
27+0 records out
613de4a7ea664ce34b2a9ec8203de0f4
vana:/# dd if=/dev/hdd1 bs=4096 count=27 skip=558899 | md5sum
27+0 records in
27+0 records out
613de4a7ea664ce34b2a9ec8203de0f4
vana:/#

I found match by searching of contents of init.c in other files.

It is just these 27 blocks; blocks before and after range differs.
                                        Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
