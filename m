Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129084AbRCFSXx>; Tue, 6 Mar 2001 13:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129115AbRCFSXp>; Tue, 6 Mar 2001 13:23:45 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:45728 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S131052AbRCFSXZ>; Tue, 6 Mar 2001 13:23:25 -0500
Message-Id: <l03130313b6cad51a8439@[192.168.239.101]>
In-Reply-To: <3AA51AE7.29FAC080@uni-mb.si>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 6 Mar 2001 18:23:15 +0000
To: David Balazic <david.balazic@uni-mb.si>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: scsi vs ide performance on fsync's
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Jonathan Morton (chromi@cyberspace.org) wrote :
>
>> The OS needs to know the physical act of writing data has finished
>>before
>> it tells the m/board to cut the power - period. Pathological data sets
>> included - they are the worst case which every engineer must take into
>> account. Out of interest, does Linux guarantee this, in the light of what
>> we've uncovered? If so, perhaps it could use the same technique to fix
>> fdatasync() and family...
>
>Linux currently ignores write-cache, AFAICT.
>Recently I asked a similar question , about flushing drive caches at
>shutdown :

>On Mon, Feb 19, 2001 at 01:45:57PM +0100, David Balazic wrote:

>> It is a good idea IMO to flush the write cache of storage devices
>> at shutdown and other critical moments.
>
>Not needed. All device drivers should disable write caches of
>their devices, that need another signal than switching it off by
>the power button to flush themselves.

Sounds like a sensible place to implement it - in the device driver.  I
also note the existence of an ATA flush-buffer command, which should
probably be used in sync() and family.  The call(s) to the sync() family on
shutdown should probably be performed by the filesystem itself on unmount
(or remount read-only), and if journalled filesystems need synchronisation
they should use sync() (or a more fine-grained version) themselves as
necessary.

Doesn't sound like too much of a headache to implement, to me - unless some
drives ignore the ATA FLUSH command, in which case said drives can be
considered seriously broken.  :P  I don't agree that write-caching in
itself is a bad thing, particularly given the amount of CPU overhead that
IDE drives demand while attached to the controller (orders of magnitude
higher than a good SCSI controller) - the more overhead we can hand off to
dedicated hardware, the better.  What does matter is that drives
implementing write-caching are handled in a safe and efficient manner,
especially in cases where they refuse to turn such caching off (eg. my
Seagate Barracuda *glares at drive*).

Recalling my recent comments on worst-case drive-shutdown timings, I also
remember seeing drives with 18ms *average* seek times quite recently - this
was a Quantum Bigfoot (yes, a 5.25" HD), found in a low-end Compaq desktop
- if anyone still believes Compaq makes high-quality machines for their
low-end market, they're totally mistaken.  The machine sped up quite a lot
when a new 3.5" IBM DeskStar was installed, with an 8.5ms average seek and
an almost doubling in rotational speed.  :)

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r- y+
-----END GEEK CODE BLOCK-----


