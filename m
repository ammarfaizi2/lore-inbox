Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWBNCk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWBNCk4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 21:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWBNCk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 21:40:56 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:28093 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750956AbWBNCkz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 21:40:55 -0500
Date: Tue, 14 Feb 2006 02:40:49 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 7/8] don't mangle INQUIRY if cmddt or evpd bits are set
Message-ID: <20060214024049.GB27946@ftp.linux.org.uk>
References: <E1F6vyJ-00009k-3Z@ZenIV.linux.org.uk> <43EA7226.60306@s5r6.in-berlin.de> <20060208230559.GK27946@ftp.linux.org.uk> <43F0B1AB.6010708@s5r6.in-berlin.de> <20060213181839.GA27946@ftp.linux.org.uk> <43F0EBE1.8000001@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F0EBE1.8000001@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 09:28:17PM +0100, Stefan Richter wrote:
> Al Viro wrote:
> >On Mon, Feb 13, 2006 at 05:19:55PM +0100, Stefan Richter wrote:
> >>BTW, a Prolific based enclosure indeed seems to be unable to handle
> >>CD-ROMs after scsiinfo treatment. An enclosure based on an old
> >>revision of TI StorageLynx apparently causes mode_sense -> check
> >>condition/ unit attention loops when scsiinfo tries to access some
> >>mode page.
> >
> >The former is best treated by using the hardware in question as a pissuary,
> >to make sure that its contents matches the quality of design.
> 
> I have got the impression that most of IEEE 1394a/ USB 2.0 combo bridges 
> on the market are now based on Prolific chips.

Unfortunately.  Finding OXFW911-based ones for about the same price is still
not hard...

> Some more findings:
>  - The TI StorageLynx based bridge reports device type 0 (TYPE_DISK).
>    The problem occurs apparently with page 4 and page 8. Sbp2 has a
>    fix since yesterday which sets the skip_ms_page_8 flag.

That's going to cause fun problems on reboot if it actually has write-behind
cache...

>    http://marc.theaimsgroup.com/?l=linux1394-devel&m=113969287630893
>  - Another bridge made by the same manufacturer but based on TI
>    StorageLynx revision A features the same MODE SENSE bug. This bridge
>    reports type 14 (TYPE_RBC).

Pardon?  If it's type 14, we won't issue MODE SENSE for page 8 and will
go for page 6 instead...

>  - I tested a tenth bridge now, based on Initio INIC-2430F. The bridge
>    reports TYPE_DISK and seems to support all pages which scsiinfo is
>    interested in. Sd_mod is a different story: After sd_mod accesses
>    page 8, the kernel panics. (This is discussed in another thread. The
>    mentioned sbp2 patch catches this bridge as a skip_ms_page_8
>    candidate too, thus avoids the panic. I will eventually check what
>    sd_mod is doing; the sbp2 patch is not the real fix.)

sd_mod issues MODE SENSE from sd_read_cache_size() and does that twice -
once for minimal length to get the length device wants to give and then
for actual length.

> Of course sg does not care for any black list flags (like sd_mod and 
> sr_mod do), but considering the nature of the bugs and anticipated usage 
> of affected devices, there is hardly a reason for further safeguards in 
> sbp2, let alone sg.

Maybe, maybe not.  Note that e.g. aforementioned INQUIRY bug in pl3507 is
triggered by dmraid, which works via SG_IO, just as scsiinfo.  And unlike
scsiinfo it's run from /etc/rc.sysinit on current FC4...
