Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbUKFACs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbUKFACs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 19:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbUKFACs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 19:02:48 -0500
Received: from 82-68-133-177.dsl.in-addr.zen.co.uk ([82.68.133.177]:55269 "EHLO
	fars-robotics.net") by vger.kernel.org with ESMTP id S261268AbUKFACf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 19:02:35 -0500
Subject: RE: Kernel 2.6.x hangs with Symbios Logic 53c1010 Ultra3 SCSI Ada pter
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Sat, 6 Nov 2004 00:02:32 -0000
Message-ID: <D5169CBBC6369D4CBFFABD7905CC9D695D31@tehran.Fars-Robotics.local>
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel 2.6.x hangs with Symbios Logic 53c1010 Ultra3 SCSI Ada pter
thread-index: AcTDdzOotnFYfFL0RrC9/Qt7zIgbgwABMLmQ
From: "Richard Waltham" <richard@fars-robotics.net>
To: "Matthew Wilcox" <matthew@wil.cx>, "SUPPORT" <support@4bridgeworks.com>
Cc: "Thomas Babut" <thomas@babut.net>, <linux-kernel@vger.kernel.org>,
       "Linux SCSI" <linux-scsi@vger.kernel.org>, <groudier@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: willy@www.linux.org.uk [mailto:willy@www.linux.org.uk] 
> 
> On Fri, Nov 05, 2004 at 04:25:03PM -0000, SUPPORT wrote:
> > I've been seeing problems with various tape drives and PPR. 
> And a SCSI 
> > 3 SE disk is interesting as well! SE and PPR don't get on too well;)
> 
> ... yes ...
> 
> I think we should *never* attempt PPR on a SE bus, even when 
> the drive supports it.  We've seen bugs in Seagate drive 
> firmware because of this, so let's stop doing it.
> 
> How does this patch (whitespace damaged, apply by hand) make 
> people feel?
> 

Good as a backup but the original PPR capability is defined in
scan_scsi.c. Shouldn't scan_scsi.c take note of the bus mode and enable
PPR capabilities accordingly? This would then cover this issue for all
relevant LLDDs wouldn't it?

> 
> > Matthew - I have attached some bits of SCSI analyser traces which I 
> > hope may be useful. An IBM SCSI 3 SE disk and a couple of LTO tape 
> > drives - IBM and HP. The HP causes severe problems as 
> modprobe hangs 
> > without the fix. I have also seen drives that do unexpected 
> disconnects if they get sent PPR.
> 
> Thanks, those are interesting.  It's good to see that we 
> really are spitting PPR out onto the wire when we shouldn't be.

And from what I've seen is the PPR negotiation keeps on being retied on
all subsequent commands. So performance really is killed by this.

> 
> > I have been toying with the idea of disabling PPR 
> capability if PPR is 
> > rejected - forcing sdev->ppr=0 in the driver when it determines PPR 
> > has been rejected - but I'm not sure that's right. There are drives 
> > which reject negotiation - legacy sync and wide at least - 
> while they 
> > are initialising but will then accept it later on.
> 
> I think disabling PPR on an SE bus should be a better fix than that.
> 

And don't forget HVD as well;)   

My main concern with my patch to scan_scsi.c was to handle SCSI 3 LVD
devices that caused problems. Scan_scsi.c sets all SCSI 3 devices as PPR
capable - SE, HVD as well as LVD. I have no issue with explicitly
disallowing PPR for SE and HVD devices. But what about SCSI 3 and LVD
devices that don't handle PPR - OK they may be broken but... For now the
patch for scan_scsi.c is a temp fix for us while we dream up something
better. It will only allow PPR with devices that advertise that they
handle DT transfers.

There is an issue that needs resolving where a drive appears to indicate
it is capable of PPR, i.e. says it is SCSI 3 + LVD, but does not
actually support PPR. Then when it receives at PPR message it causes
problems in the driver because it terminates the PPR MSG OUT early with
an unexpected phase change.

Exactly what happens then seems dependent on when the message is
aborted. You can see the differences in the analyser traces. The IBM LTO
is handled reasonably well although the driver spits out an unexpected
phase change msg, but the HP LTO really causes problems. And the disk
accepts the whole message and again causes no problems.

However currently the problem in these cases is that the PPR
capabilities bit (sdev->ppr) remains set so the next time negotiation is
attempted PPR is used again etc, etc. so the drives never negotiate to
what they are really capable of running at. This is why I mentioned
clearing sdev->ppr above. Because the capabilities determined in
scan_scsi.c indicate ppr, sync and wide and sdev->ppr remains set after
the negotiation is aborted the drives never ever successfully complete
negotiation no matter how many commands are sent as far as I can see.

Guess this boils down to three problems. 1. Make sure only drives on bus
modes capable of supporting PPR can be flagged as PPR capable. 2. Drives
that appear to support PPR (SCSI 3 + LVD) but _may be_ broken in some
way are handled by the driver without the unexpected phase changes
causing issues. And 3. What to do with drives that abort negotiation
messages, wide, sync or ppr?

1. is straight forward although there could be disagreement about where
the fix should really be. Personally, I think, this should really be
classified a general SCSI problem rather than specific to just this
driver.
2. requires modification to the handling of extended messages (or all
multi-byte messages?) so an aborted message doesn't break the driver.
This is driver specific.
3. this may be the nasty one. What do we do with negotiations that fail?
Do we keep trying the same negotiation time after time - i.e. leave it
as it is - not at all satisfactory, although I'm pretty certain I've
seen a trace from a drive that aborts negotiation until it is ready and
then accepts it later on - I really need to check this out when I'm back
in the office. Do we drop back from PPR to WIDE/SYNC? Is this better?
May be. Anything else? This again, I believe, can be classified as a
general issue rather than driver specific but may be easier to handle
within the driver. 


Richard


Richard Waltham
Bridgeworks Ltd
135 Somerford Road,
Christchurch
Dorset, BH23 3PY
England.

Tel 0870 121 0708
Fax 0870 121 0709

