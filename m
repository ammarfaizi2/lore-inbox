Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131482AbRACNcF>; Wed, 3 Jan 2001 08:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131654AbRACNbz>; Wed, 3 Jan 2001 08:31:55 -0500
Received: from Cantor.suse.de ([194.112.123.193]:6919 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131642AbRACNbr>;
	Wed, 3 Jan 2001 08:31:47 -0500
Date: Wed, 3 Jan 2001 14:01:16 +0100
From: Andi Kleen <ak@suse.de>
To: "Jorge L. deLyra" <delyra@latt.if.usp.br>
Cc: Andi Kleen <ak@suse.de>, Neil Brown <neilb@cse.unsw.edu.au>,
        Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        Frank.Olsen@stonesoft.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Bugs in knfsd -- Problem re-exporting an NFS share
Message-ID: <20010103140116.A32638@gruyere.muc.suse.de>
In-Reply-To: <20010103130624.A31209@gruyere.muc.suse.de> <Pine.LNX.3.96.1010103102308.21599A-100000@latt.if.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1010103102308.21599A-100000@latt.if.usp.br>; from delyra@latt.if.usp.br on Wed, Jan 03, 2001 at 10:49:54AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2001 at 10:49:54AM -0200, Jorge L. deLyra wrote:
> > That's a bit surprising that you have so many problems with unfsd, I know
> > lots of installations where it is (still) used successfully in its limits.
> > I did recently some mainteance work on it to fix it for reiserfs.
> 
> Well, let me qualify that better. The problems were not really bad before
> 2.2.18. There where none in 2.0, by the way, as far as I remember. They
> first showed up when we switched to 2.2, and were more frequent at the
> beginning. When we got to 2.2.17 we had pretty much forgotten about them.
> We have NFS exports on many machines around here and it only happened in
> some, so it is difficult to pinpoint the problem. We were never quite sure
> whether the problem was on the server or client, sometimes it looked one
> way, sometimes another. Once there was a certain directory such that an ls
> -lR on it was sure-fire to give an I/O error message and hang the mount.
> Moving the contents to another directory and deleting the first one solved
> it, don't ask me why. Very often a way to produce the problem was to sit
> at the mount point and do a find for something. When a hang was produced,
> you had to kill autofs, unmount by hand, maybe killing a few programs in
> order not to get "busy" messages. Then just mount it again and it's OK.
> Note that neither killing and restarting the server nor rebooting the
> client seemed necessary. You just had to unmount and remount.

You probably had a inode namespace collision. unfsd encodes the dev_t in the 
upper in ext2 unused bits of the inode to be able to export multiple file systems in 
a single export (knfsd dropped that broken feature) That sometimes fails, yielding
duplicate inode numbers. When the collision happens for objects with different
types (e.g. directory and file) then the client detects it immediately when 
the other object is still in its inode cache and marks the inode bad, giving
these EIOs. Newer unfsd has various tuning options to avoid these collisions,
but it does not always work. It depends on the actual device numbers and inode
used so could suddenly appear on a system update.

> 
> > (when you ignore locking and NFS over TCP ATM) All you need is to forward
> > UDP packets. This can either be done by a normal user space daemon that
> > uses portmap and just sends the packets out again, or alternatively by using
> > UDP masquerading and appropiate routes on the internal boxes.
> > Only forwarding packets is very different from full reexport support in knfsd
> > and much simpler.
> 
> Well, I hope some solution is found, since this is an important feature.
> It would be nicer in knfsd, I think, but if that proves unpractical for
> some reason, your packet filter/forwarder might just be the answer.

It is impractical in knfsd for NFS for most other network file systems (especially
those that have "artificial" inode numbers like smbfs). knfsd over FAT or amiga ffs
is probably a problem too. 

Your problem case really sounds like you just need a proxy.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
