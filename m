Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277512AbRJZD4C>; Thu, 25 Oct 2001 23:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277509AbRJZDzw>; Thu, 25 Oct 2001 23:55:52 -0400
Received: from theuw.net ([209.23.48.158]:38082 "HELO narboza.theuw.net")
	by vger.kernel.org with SMTP id <S277435AbRJZDzf>;
	Thu, 25 Oct 2001 23:55:35 -0400
Date: Thu, 25 Oct 2001 23:56:10 -0400 (EDT)
From: <lung@theuw.net>
To: Andre Hedrick <andre@aslab.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Repeatable File Corruption (ECS K7S5A w/SIS735)
In-Reply-To: <Pine.LNX.4.10.10110251924180.456-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.33.0110252352580.4445-100000@narboza.theuw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just tried 2.4.10-ac12 with no solution.  The same file corruption still
exists.

Not that it's relevant, but I was unable to get any of the 2.4.12 -ac
patches to compile:

make[3]: Entering directory `/usr/src/kernel-source-2.4.12/fs/partitions'
gcc -D__KERNEL__ -I/usr/src/kernel-source-2.4.12/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4     -DEXPORT_SYMTAB -c msdos.c
msdos.c: In function `handle_ide_mess':
msdos.c:550: warning: implicit declaration of function `invalidate_bdev'
msdos.c:551: structure has no member named `bd_inode'
make[3]: *** [msdos.o] Error 1

# gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011006 (Debian prerelease)




On Thu, 25 Oct 2001, Andre Hedrick wrote:

>
> Greetings dan,
>
> Well no kidding !!!
> Just maybe it is the VM layer getting it wrong again.
> Please try an -ac kernel and see if it still exist.
>
> As most know that there are corrections there that have not been accepted
> into the main tree ..... OUCH that hurts ....
>
> Cheers,
>
> On Thu, 25 Oct 2001, dan wrote:
>
> >
> > ===== SUMMARY
> >
> > I have found a file corruption issue when writing files seemingly related
> > to my new motherboard.
> >
> >
> > ===== HARDWARE
> >
> >   It is repeatable and verified on other boards of the same model.  This
> > just started happening when I upgraded the system.  The following is a
> > link to the ECS K7S5A board in question, the SIS735 chipset, and a
> > hardware description:
> >
> >   http://www.ecsusa.com/ecsusa/www.ecs.com.tw/products/k7s5a.htm
> >   http://www.sis.com/products/chipsets/oa/socketa/735.htm
> >
> >   ECS K7S5A motherboard
> >   AMD 1.4Ghz Tbird
> >   2x256Mb Micron DDR PC2100
> >   hda: ST36421A, ATA DISK drive
> >   hdb: QUANTUM FIREBALLP LM10.2, ATA DISK drive
> >   hdc: IC35L060AVER07-0, ATA DISK drive
> >
> >
> > ===== DESCRIPTION
> >
> > The bug was first noticed when running a game server that verifies client
> > map files with the server map files.  Some of the maps, no matter what I
> > did, were always different, causing the server to reject clients.  Using
> > the commands md5sum and cmp, I noticed that each time I copied a new file
> > into place, it was slightly different:
> >
> >   $ cp de_aztec.bsp de_aztec.bsp2
> >   $ cmp de_aztec.bsp de_aztec.bsp2
> >   de_aztec.bsp de_aztec.bsp2 differ: char 2287174, line 6590
> >   $ md5sum de_aztec.bsp de_aztec.bsp2
> >   c138a969edf84abcfc5fe4b4b2a2c5ed  de_aztec.bsp
> >   36b5bdd244d69a8d0fb3c81ba25e1df1  de_aztec.bsp2
> >
> > Not only that, every copy is different from every other copy:
> >
> >   $ cp de_aztec.bsp de_aztec.bsp3
> >   $ cp de_aztec.bsp de_aztec.bsp4
> >   $ cp de_aztec.bsp de_aztec.bsp5
> >   $ md5sum de_aztec.bsp de_aztec.bsp?
> >   c138a969edf84abcfc5fe4b4b2a2c5ed  de_aztec.bsp
> >   fe858630be18e37eba8ea73a6be941c9  de_aztec.bsp2
> >   87bd1ad8b0ff2c58ebff5372f865fa35  de_aztec.bsp3
> >   7cffbffca0600c80e6cae336f52c885b  de_aztec.bsp4
> >   91287ef7c8eb047d8f305315b4e0ce55  de_aztec.bsp5
> >
> > It does not seem to be an issue with reading from the drive because the
> > md5sum of the original file is always the same.
> >
> > This is repeatable with any command that will write a file out including
> > tar, rsync, and ftp.  If I move the file within the partition, there is no
> > corruption.  Copying the file one character at a time works.
> >
> > This does not happen with every file on the drive.  In fact, out of the
> > 1400 files related to the server, I only found a few dozen that I could
> > repeat this issue with.  I also have complaints from other users of the
> > system of files being corrupt and have found a number myself.
> >
> > I have repeated this with the following:
> >
> >   Duplicate systems (I have 5)
> >   Multiple hard drives (IBM, Quantum, Seagate)
> >   Different filesystems on multiple drives (reiserfs, ext2)
> >   With and without different drivers in the kernel (IDE chipset support)
> >   Kernels 2.4.10 through 2.4.13
> >   Drives running at different speeds  (ATA-100, 66, 33)
> >   Slow processor (AMD 1.2GHz Tbird)
> >
> >
> > ===== WORKAROUND
> >
> > The problem only went away when I replaced the motherboard.  I also
> > haven't had any file corruption issues running Windows2000 on the same
> > hardware with the same files.  I moved all of the hardware in the original
> > system to a new motherboard (ASUS A7A266)  and the problem went away.
> >
> > I have CC'd the IDE chipset maintainer because I can only assume it might
> > be related.
> >
> > Thank you for fighting through this email, I know it was long and boring.
> >
> >
> > dan
> >
>
> Andre Hedrick
> CTO ASL, Inc.
> Linux ATA Development
> -----------------------------------------------------------------------------
> ASL, Inc.                                     Tel: (510) 857-0055 x103
> 38875 Cherry Street                           Fax: (510) 857-0010
> Newark, CA 94560                              Web: www.aslab.com
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

