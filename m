Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbUKFD77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbUKFD77 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 22:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbUKFD77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 22:59:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34785 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261309AbUKFD7w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 22:59:52 -0500
Date: Sat, 6 Nov 2004 03:59:51 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Richard Waltham <richard@fars-robotics.net>
Cc: Matthew Wilcox <matthew@wil.cx>, SUPPORT <support@4bridgeworks.com>,
       Thomas Babut <thomas@babut.net>, linux-kernel@vger.kernel.org,
       Linux SCSI <linux-scsi@vger.kernel.org>, groudier@free.fr
Subject: Re: Kernel 2.6.x hangs with Symbios Logic 53c1010 Ultra3 SCSI Ada pter
Message-ID: <20041106035951.GC24690@parcelfarce.linux.theplanet.co.uk>
References: <D5169CBBC6369D4CBFFABD7905CC9D695D31@tehran.Fars-Robotics.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D5169CBBC6369D4CBFFABD7905CC9D695D31@tehran.Fars-Robotics.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 12:02:32AM -0000, Richard Waltham wrote:
> Good as a backup but the original PPR capability is defined in
> scan_scsi.c. Shouldn't scan_scsi.c take note of the bus mode and enable
> PPR capabilities accordingly? This would then cover this issue for all
> relevant LLDDs wouldn't it?

scan_scsi.c doesn't know what mode the bus is in.  scan_scsi.c doesn't
even know whether the bus is SPI, FC, iSCSI, SAS or SATA.

> > Thanks, those are interesting.  It's good to see that we 
> > really are spitting PPR out onto the wire when we shouldn't be.
> 
> And from what I've seen is the PPR negotiation keeps on being retied on
> all subsequent commands. So performance really is killed by this.

Yes, we'll do that as long as the device target parameters differ from
the achieved parameters.

> > I think disabling PPR on an SE bus should be a better fix than that.
> 
> And don't forget HVD as well;)   

Yes, I thought about HVD and decided that I wanted to code the check
against LVD rather than against SE ;-)

> My main concern with my patch to scan_scsi.c was to handle SCSI 3 LVD
> devices that caused problems. Scan_scsi.c sets all SCSI 3 devices as PPR
> capable - SE, HVD as well as LVD. I have no issue with explicitly
> disallowing PPR for SE and HVD devices. But what about SCSI 3 and LVD
> devices that don't handle PPR - OK they may be broken but...

I've got some devices that fail PPR when the bus is in SE mode but
work fine when the bus is in LVD mode.  So this patch certainly fixes
those problems.  THe question is whether there exist devices that:

 - Claim to be SCSI3 compliant
 - Fail PPR when on an LVD bus

> There is an issue that needs resolving where a drive appears to indicate
> it is capable of PPR, i.e. says it is SCSI 3 + LVD, but does not
> actually support PPR. Then when it receives at PPR message it causes
> problems in the driver because it terminates the PPR MSG OUT early with
> an unexpected phase change.

I think those devices need blacklisting.  Either that, or we need to do
DV in non-approved ways.  Perhaps start with SDTR+WDTR.  If we get up
to Fast-40, then try PPR.  I suspect James has Opinions on this though ;-)

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
