Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbUK3ROQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbUK3ROQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 12:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUK3ROO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 12:14:14 -0500
Received: from smtp07.auna.com ([62.81.186.17]:63405 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S262211AbUK3RMr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 12:12:47 -0500
Date: Tue, 30 Nov 2004 17:12:45 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: cdrecord dev=ATA cannont scanbus as non-root
To: linux-kernel@vger.kernel.org
References: <1101763996l.13519l.0l@werewolf.able.es>
	<Pine.LNX.4.53.0411292246310.15146@yvahk01.tjqt.qr>
	<1101765555l.13519l.1l@werewolf.able.es> <20041130071638.GC10450@suse.de>
In-Reply-To: <20041130071638.GC10450@suse.de> (from axboe@suse.de on Tue Nov
	30 08:16:39 2004)
X-Mailer: Balsa 2.2.6
Message-Id: <1101834765l.8903l.4l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.11.30, Jens Axboe wrote:
> On Mon, Nov 29 2004, J.A. Magallon wrote:
> > dev=ATAPI uses ide-scsi interface, through /dev/sgX. And:
> > 
> > > scsibus: -1 target: -1 lun: -1
> > > Warning: Using ATA Packet interface.
> > > Warning: The related Linux kernel interface code seems to be unmaintained.
> > > Warning: There is absolutely NO DMA, operations thus are slow.
> > 
> > dev=ATA uses direct IDE burning. Try that as root. In my box, as root:
> 
> Oh no, not this again... Please check the facts: the ATAPI method uses
> the SG_IO ioctl, which is direct-to-device. It does _not_ go through
> /dev/sgX, unless you actually give /dev/sgX as the device name. It has
> nothing to do with ide-scsi. Period.
> 
> ATA uses CDROM_SEND_PACKET. This has nothing to do with direct IDE
> burning, it's a crippled interface from the CDROM layer that should not
> be used for anything.  scsi-linux-ata.c should be ripped from the
> cdrecord sources, or at least cdrecord should _never_ select that
> transport for 2.6 kernels. For 2.4 you are far better off using
> ide-scsi.
> 
> > The scan through ATA lasts much less than with ATAPI, and you can burn with
> > dev=ATA:1,0,0 or dev=/dev/burner, which is the new recommended way.
> 
> No! ATAPI is the recommended way.
> 

Ahh, I think I found the problem....

I tried scanning with dev=ATAPI, and cdrecord did not found anything.
Then I tried in my home box, and it found the burner.
The problem is that in the 'strange' box the burner is hdh, and the
hard drive for system is hde. The previous IDE channels are unused
(an on-board promise with ide[01], hd[abcd]).
I use udev, so there is no hd[a-d] nodes on /dev. And cdrecord
_EXITS_ as soon as it founds a non-existent device !!!

With a quick'n'dirty hack (ln -s hde hd[abcdfg]), cdrecord finally
got the list:

nada:~> cdrecord dev=ATAPI -scanbus
Cdrecord-Clone 2.01-dvd (i686-pc-linux-gnu) Copyright (C) 1995-2004 J�g Schilling
Note: This version is an unofficial (modified) version with DVD support
Note: and therefore may have bugs that are not present in the original.
Note: Please send bug reports or support requests to <warly@mandrakesoft.com>.
Note: The author of cdrecord should not be bothered with problems in this version.
scsidev: 'ATAPI'
devname: 'ATAPI'
scsibus: -2 target: -2 lun: -2
Warning: Using ATA Packet interface.
Warning: The related Linux kernel interface code seems to be unmaintained.
Warning: There is absolutely NO DMA, operations thus are slow.
Using libscg version 'schily-0.8'.
scsibus0:
        0,0,0     0) *
        0,1,0     1) 'HL-DT-ST' 'DVDRAM GSA-4040B' 'A300' Removable CD-ROM
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *

I will try to look at the cdrecord sources and make a real patch...
I suppose cdrecord will have a bugzilla or mailing list.

Many things will have to change with udev ;)

Thanks for your time and explanations.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-rc2-jam3 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1


