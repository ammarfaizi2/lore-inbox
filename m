Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbVFWNqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVFWNqI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 09:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbVFWNqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 09:46:08 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:65259 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262216AbVFWNol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 09:44:41 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
From: Mark Williamson <mark.williamson@cl.cam.ac.uk>
To: "Ian Pratt" <m+Ian.Pratt@cl.cam.ac.uk>
Subject: Re: -mm -> 2.6.13 merge status
Date: Thu, 23 Jun 2005 14:37:10 +0100
User-Agent: KMail/1.8
Cc: "Carsten Otte" <cotte.de@gmail.com>, "Chris Wright" <chrisw@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Jeff Garzik" <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org, ian.pratt@cl.cam.ac.uk
References: <A95E2296287EAD4EB592B5DEEFCE0E9D28236E@liverpoolst.ad.cl.cam.ac.uk>
In-Reply-To: <A95E2296287EAD4EB592B5DEEFCE0E9D28236E@liverpoolst.ad.cl.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506231437.12046.mark.williamson@cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Xen is making similar noises w.r.t. using kexec for
> >
> > flexible bootloader.
> >
> > Oh cool, then we should look at what they're doing instead of
> > reinventing the wheel. Any pointer we can follow, or person
> > we would contact?

Right now, that would be me (hello!).

All going well - I should have Xen guests kexec-ing properly in the next day 
or so.  All the machinery is in place, so it's just a question of doing some 
plumbing.  nb. this is a separate issue to kexecing the whole host, which 
I'll probably look at later.

Carsten: can you tell me what you were planning for your bootloader?  Also, if 
you could point me at any docs regarding your current / proposed boot 
sequence that'd be really interesting.

Regarding our kexec-based bootloader:
* We call running virtual machines "domains".
* Under Xen, guests get built using a kernel specified in domain 0's (the 
"host") filesystem.  That implies that the user of the guest domain can't 
choose their kernel.
* To fix this we now have a bootloader than runs in domain 0, which can poke 
around in the guest's filesystem, find a menu.lst / grub.conf, then load the 
appropriate kernel.
* This provides the functionality the user wants but implies that programs in 
dom0 have to access the guest filesystem, which could be malicious.  We'd 
rather not have programs in dom0 trusting guests.
* The proposed solution is to initially run a "bootloader kernel", with a 
bootloader app on an initrd.  This will run in the guest itself, so all the 
filesystem accesses occur in an unprivileged virtual machine.
* The bootloader will cause a kexec to the new kernel.
* This fixes the isolation problem and immediately allows us to support all 
the random filesystems Linux supports ;-)

My current plan is that the bootloader app will act much like Grub and use 
Grub's config files.  It'll also be possible to use something more 
heavyweight, such as XenoBoot 
(http://www.cl.cam.ac.uk/Research/SRG/netos/xeno/xenoboot/).  It's possible 
that XenoBoot has some code we could use in the bootloader - I haven't 
looked.

Feel free to mail me offline.  If our goals are compatible, it'd be good to 
work together on this.

Cheers,
Mark
