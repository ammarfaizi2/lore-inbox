Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262298AbTCHXNR>; Sat, 8 Mar 2003 18:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262303AbTCHXNR>; Sat, 8 Mar 2003 18:13:17 -0500
Received: from mailhost.tue.nl ([131.155.2.4]:23051 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S262298AbTCHXNP>;
	Sat, 8 Mar 2003 18:13:15 -0500
Date: Sun, 9 Mar 2003 00:23:51 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Harald.Schaefer@gls-germany.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Thomas.Mieslinger@gls-germany.com, linux-kernel@vger.kernel.org,
       aeb@cwi.nl
Subject: Re: ide-problem still with 2.4.21-pre5-ac1
Message-ID: <20030308232351.GA3462@win.tue.nl>
References: <OFA9D69D12.A2BE6A15-ONC1256CE1.00344A6F-C1256CE1.0039609A@LocalDomain> <Pine.LNX.3.96.1030308172559.4525D-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030308172559.4525D-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 05:28:10PM -0500, Bill Davidsen wrote:
> On Thu, 6 Mar 2003 Harald.Schaefer@gls-germany.com wrote:
> 
> >  *    1. CHS value set by user       (whatever user sets will be trusted)
> >  *    2. LBA value from target drive (require new ATA feature)
> >  *    3. LBA value from system BIOS  (new one is OK, old one may break)
> >  *    4. CHS value from system BIOS  (traditional style)
> > 
> > I think that the priority of LBA from BIOS has to be raised to 2 and the
> > priority of LBA from drive should be lowered to 3.
> > The mapping-problem only appreared with very new drives in some
> > brand-computers using a 240-head mapping from the bios.
> 
> I think the chances of a drive knowing its own correct LBA info is far
> better than the BIOS getting it right. Many BIOS versions don't understand
> large drives.

Maybe time for some preaching again.

The above sounds like nonsense,
"its own correct LBA info" does not refer to anything.

A disk that is less than twelve years old does not have a geometry.
All disks that can handle LBA (that is, all disks less than
twelve years old) use LBA under Linux.
Thus, the disk has nothing to tell use except for its total capacity.

Some silly legacy stuff is interested in a geometry.
It does not exist, but everybody can invent something,
Why would one do such a silly thing? Well, the DOS-type partition
table has fields that are expressed in terms of cyl/heads/secs,
and these are used by DOS. If one really uses DOS on the same
disk, then one needs the BIOS values, since DOS uses the BIOS.

On a Linux-only system there is never any problem, provided
one can boot. Don't panic if some ancient fdisk version
mumbles about unexpected things. 

Usually people that complain only think they have a problem,
while in fact all is well. Or they have a problem: the BIOS
cannot handle the disk and does not boot, but that is not a
Linux problem.

Now what about Harald.Schaefer's problem? I asked Google
for his complaint and find

"We create fdisk partitions with linux and run later DOS
from one of these partitions. DOS gets confused about the
linux mapping of the partition that is different from the
BIOS supplied values."

Now guessing what the BIOS will do is a black art,
and if "kernel 2.2.22 was running fine" it was lucky.
I see that 2.4.21-pre5 overrides in many cases what
the BIOS said, so it will be lucky less often.
But one can always specify an explicit geometry to fdisk.
(And find out what to say by inspecting the BIOS setup
screen under "autodetecting hard disks".)

Finally, on the shown hdparm output:

---------------------------------------------------------------------------
and a bad disk, which is recognized with "bit shift"-mapping from the BIOS:

hdparm -i /dev/hda
 Model=Maxtor 6E040L0, FwRev=NAR61590, SerialNo=E11G00EE
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=78165360

hdparm -I /dev/hda
 CurCHS=65535/1/63, CurSects=4128705, LBA=yes, LBAsects=78165360

another disk that doesn't work

hdparm -i /dev/hda
 Model=FUJITSU MHR2030AT, FwRev=53BB, SerialNo=NJ36T2813MYW
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 CurCHS=17475/15/63, CurSects=16513875, LBA=yes, LBAsects=58605120

hdparm -I /dev/hda
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 CurCHS=65535/1/63, CurSects=4128705, LBA=yes, LBAsects=58605120
---------------------------------------------------------------------------

Really strange values, as if someone wanted to force a H=255.
Must read current 2.4 source some time. What does hdparm say
under 2.2.22?

Andries


