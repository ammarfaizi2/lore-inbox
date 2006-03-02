Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbWCBXDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWCBXDz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 18:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWCBXDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 18:03:55 -0500
Received: from sdcrelbas03.europe.hp.net ([15.203.169.189]:30678 "EHLO
	sdcrelbas03.sdc.hp.com") by vger.kernel.org with ESMTP
	id S1751032AbWCBXDx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 18:03:53 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: sg regression in 2.6.16-rc5
Date: Thu, 2 Mar 2006 23:04:08 -0000
Message-ID: <085C28F775E1B74F82122EF0975E6E76045F0360@sdcexc02.emea.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: sg regression in 2.6.16-rc5
Thread-Index: AcY+P+rG2FpZIMiGTkaD+9QveqLOEQACchCA
From: "Falkinder, David Malcolm" <david.falkinder@hp.com>
To: "Linus Torvalds" <torvalds@osdl.org>, "Douglas Gilbert" <dougg@torque.net>
Cc: "Kai Makisara" <Kai.Makisara@kolumbus.fi>,
       "Matthias Andree" <matthias.andree@gmx.de>,
       "Mark Rustad" <mrustad@mac.com>, <linux-scsi@vger.kernel.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Dewar, Charles David" <dave.dewar@hp.com>
X-OriginalArrivalTime: 02 Mar 2006 23:03:47.0698 (UTC) FILETIME=[900F8D20:01C63E4D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

I contacted Doug off-list, and he asked me to express my concerns here.

Whilst a Linux advocate, I work cross platform, and have but a shallow
knowledge of the kernel, so apologies in advance for any technical
inaccuracies, or misunderstandings ...

Essentially what I conveyed to Doug was :

I guess, I'm not fully aware of the implications of what is being
discussed as there appears to essentially be two implementations of the
SG_IO IOCtl - namely the one in the sg driver, and the one in the block
layer.

One of the key drivers for us using Linux is the ability to do a 16Mb
contiguous single transfer.
i.e. WRITE(6) with 0xFF 0xFF 0xFF as the transfer length. Often we use
patterns like (2^n)-1, 2^n, (2^n)+1, to thoroughly test the SCSI bus, so
ALL transfer sizes are needed.

Certainly a 1Mb limit would be useless, as would 4Mb.

To achieve our goal of 16Mb all we've had to do to date is recompile the
kernel having set SG_SCATTER_SZ to (64 * 4096).

Whilst it would be great to just use a vanilla kernel, this is a
relatively trivial patch to meet our needs. I'd hate to think at any
point anything would be done to move away from this. Certainly we'd have
to either find another proprietary solution, or freeze our Linux
implementation indefinitely. Neither a particularly attractive solution.

-------

I (obviously) support your wish to fix broken code. In my technical
naivety in this area, I obviously can't comment on the ramifications of
a fix/non fix situation other than pertaining directly to the large
transfer situation. However it's obvious we ( and I'm sure others ) are
at the moment exploiting this "defect". I guess I feel to be hearing a
lot of discussion regarding the fix, so it's obviously contentious, and
it's agreed it will effectively reduce large transfer functionality of
the kernel; what I am not hearing is a timeline for restoring that
functionality. Personally I'd be happy to "miss out" on a couple of
kernel releases, if I was confident functionality would be restored.
What does worry me is the potential for this fix to be applied, and the
functionality I need not be restored. For example the SG_IO IoCtl in the
block layer was obviously a laudable project, yet to date does not
provide all the features offered by the SG driver [ that I need at least
].

Can I request therefore, that unless the fix can be extended to retain
the large transfer functionality, or a suitable timeline for it's
restoration be resolved; that the patch not be applied.

Many thanks,

	Best Wishes,

	|\
	|/ave




-----Original Message-----
From: linux-scsi-owner@vger.kernel.org
[mailto:linux-scsi-owner@vger.kernel.org] On Behalf Of Linus Torvalds
Sent: 02 March 2006 21:25
To: Douglas Gilbert
Cc: Kai Makisara; Matthias Andree; Mark Rustad;
linux-scsi@vger.kernel.org; Linux Kernel Mailing List
Subject: Re: sg regression in 2.6.16-rc5



On Thu, 2 Mar 2006, Douglas Gilbert wrote:
> 
> As more information has come to light, the worst case "big transfer" 
> of a single SCSI command through sg (and st I suspect) is 512 KB **. 
> With full coalescing that figure goes up to 4 MB **. I am also aware 
> that some users increase SG_SCATTER_SZ in the sg driver to get larger 
> "big transfer"s than sg's current limit of (8MB - 32KB) **.
> That facility has now gone (i.e. upping SG_SCATTER_SZ will have no 
> effect) with no replacement mechanism.
> 
> So I'll add my vote to "revert this change before lk 2.6.16"
> with a view to applying it after some solution to the "big transfer" 
> problem is found.

Considering that the old code was apparently known-broken due to not
honoring the use_clustering flag, I would say that the more likely thing
is that very few people use sg in the first place, and we should wait
and see what the reaction is to actually fixing a real bug.

Doing more than page-sized transfers can be hard/impossible in
virtualized environments, for example.

In contrast, upping the limits should be fairly easy, I assume. Same
goes for if some driver disables clustering even though it shouldn't.
No?

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org More majordomo info
at  http://vger.kernel.org/majordomo-info.html
