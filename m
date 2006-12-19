Return-Path: <linux-kernel-owner+w=401wt.eu-S932813AbWLSMjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932813AbWLSMjs (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 07:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932817AbWLSMjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 07:39:48 -0500
Received: from brick.kernel.dk ([62.242.22.158]:6575 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932813AbWLSMjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 07:39:48 -0500
Date: Tue, 19 Dec 2006 13:41:30 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Hancock <hancockr@shaw.ca>
Subject: Re: Linux 2.6.20-rc1
Message-ID: <20061219124130.GN5010@kernel.dk>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <200612142144.26023.s0348365@sms.ed.ac.uk> <4581C73F.6060707@garzik.org> <200612142233.10584.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612142233.10584.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14 2006, Alistair John Strachan wrote:
> On Thursday 14 December 2006 21:50, Jeff Garzik wrote:
> > Alistair John Strachan wrote:
> > > Before I proceed with the horrors of an -rc1 bisection, could somebody
> > > send me the ADMA patches so I can eliminate those first?
> >
> > Run
> >
> > 	git-whatchanged drivers/ata/sata_nv.c
> >
> > and that will give you a list of recent changes.  To obtain the "diff
> > -u" patch for a single commit, run
> >
> > 	git-diff-tree -p $SHA_HASH > /tmp/patch
> 
> I used a variation on this:
> 
> 	git-whatchanged -p v2.6.19.. drivers/ata/sata_nv.c >sata_nv
> 
> Reverted it (against v2.6.20-rc1), compiled that kernel, no dice.
> 
> [root] 22:32 [~] hddtemp /dev/sda
> /dev/sda: ATA WDC WD2500KS-00M: S.M.A.R.T. not available
> 
> I'll start the bisection.

Just noticed that most of the mails I wrote on this thread were
apparently without linux-kernel cc'ed (dunno who removed the cc). So
I'll write a small summary - the problem is that hddtemp includes some
fragile code to check the sense info, and this commit:

http://git.kernel.dk/?p=linux-2.6-block.git;a=commit;h=f38621b3109068adc8430bc2d170ccea59df4261

broke it. hddtemp expects 14, but it now sees 12. IMHO hddtemp is buggy
and should be fixed, the best option is simply to kill the sense checks
as I think they have little (if any) value. Patch below for that.

So the problem was never the SG_IO changes, the fact that somebody
noticed the same thing in bugzilla for a 2.6.19-rc6-mm kernel backs that
up.

--- hddtemp-0.3-beta15/src/satacmds.c~	2006-12-19 12:01:10.000000000 +0100
+++ hddtemp-0.3-beta15/src/satacmds.c	2006-12-19 12:01:27.000000000 +0100
@@ -54,7 +54,6 @@
   unsigned char cdb[16];
   unsigned char sense[32];
   int dxfer_direction;
-  int ret;
   
   memset(cdb, 0, sizeof(cdb));
   cdb[0] = ATA_16;
@@ -78,13 +77,7 @@
     cdb[6] = cmd[1];
   cdb[14] = cmd[0];
 
-  ret = scsi_SG_IO(device, cdb, sizeof(cdb), buffer, cmd[3] * 512, sense, sizeof(sense), dxfer_direction);
- 
-  /* Verify SATA magics */
-  if (sense[0] != 0x72 || sense[7] != 0x0e || sense[9] != 0x0e || sense[10] != 0x00)
-    return 1;		  
-  else 
-    return ret;
+  return scsi_SG_IO(device, cdb, sizeof(cdb), buffer, cmd[3] * 512, sense, sizeof(sense), dxfer_direction);
 }
 
 void sata_fixstring(unsigned char *s, int bytecount)

-- 
Jens Axboe

