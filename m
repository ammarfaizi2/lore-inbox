Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292848AbSCJFmk>; Sun, 10 Mar 2002 00:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292866AbSCJFmb>; Sun, 10 Mar 2002 00:42:31 -0500
Received: from gear.torque.net ([204.138.244.1]:35844 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S292848AbSCJFmM>;
	Sun, 10 Mar 2002 00:42:12 -0500
Message-ID: <3C8AEDFC.502CAD04@torque.net>
Date: Sun, 10 Mar 2002 00:24:12 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.6-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Jeremy Higdon <jeremy@classic.engr.sgi.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
In-Reply-To: <200202281536.g1SFaqF02079@localhost.localdomain> <E16heCm-0000Q5-00@starship.berlin> <10203032021.ZM443706@classic.engr.sgi.com> <E16hl4R-0000Zx-00@starship.berlin> <phillips@bonn-fries.net> <10203032209.ZM424559@classic.engr.sgi.com> <20020304165216.A1444@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" wrote:
> 
> Hi,
> 
> On Sun, Mar 03, 2002 at 10:09:35PM -0800, Jeremy Higdon wrote:
> 
> > > WCE is per-command?  And 0 means no caching, so the command must complete
> > > when the data is on the media?
> >
> > My reading is that WCE==1 means that the command is complete when the
> > data is in the drive buffer.
> 
> Even if WCE is enabled in the caching mode page, we can still set FUA
> (Force Unit Access) in individual write commands to force platter
> completion before commands complete.
> 
> Of course, it's a good question whether this is honoured properly on
> all drives.
> 
> FUA is not available on WRITE6, only WRITE10 or WRITE12 commands.

Stephen,
FUA is also available on WRITE16. The same FUA support pattern
applies to the READ6,10,12 and 16 series. Interestingly if a
WRITE10 is called with FUA==0 followed by a READ10 with FUA=1
on the same block(s) then the READ causes the a flush from the
cache to the platter (if it hasn't already been done). [It
would be pretty ugly otherwise :-)]

Also SYNCHRONIZE CACHE(10) allows a range of blocks to be sent
to the platter but the size of the range is limited to 2**16 - 1
blocks which is probably too small to be useful. If the
"number of blocks" field is set to 0 then the whole disk cache
is flushed to the platter. There is a SYNCHRONIZE CACHE(16)
defined in recent sbc2 drafts that allows a 32 bit range
but it is unlikely to appear on any disk any time soon. There
is also an "Immed"-iate bit on these sync_cache commands
that may be of interest. When set this bit instructs the
target to respond with a good status immediately on receipt
of the command (and thus before the dirty blocks of the disk 
cache are flushed to the platter).

Doug Gilbert

