Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932664AbVLOAUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbVLOAUe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 19:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbVLOAUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 19:20:33 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:7115 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932656AbVLOAUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 19:20:31 -0500
Message-ID: <43A0B6CA.9090200@sgi.com>
Date: Wed, 14 Dec 2005 18:20:26 -0600
From: Michael Reed <mdr@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [GIT PATCH] final SCSI fixes for 2.6.15-rc5
References: <1134604909.11150.2.camel@mulgrave>
In-Reply-To: <1134604909.11150.2.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If possible, a comment on my previous email which identified two
other issues with SCSI would be appreciated before 2.6.15 goes
final.

Thanks,
 Mike


> "Current Issues with 2.6.15-rc5" sent today:

> Hello Everyone,
> 
> I'm concerned about the stability of the fibre channel infrastructure
> in 2.6.15-rc.  There are current issues which I see effecting our (SGI's)
> customers' satisfaction.  I feel that these issues must be addressed
> prior to the release of 2.6.15.
> 
> 1 - fc transport change gets really noisy if targets disappear from
>     the fabric due to recursion on the workqueue.  I've seen recursion
>     depths > 40 and it's only really limited by the number of targets
>     on a fibre channel fabric.  It's unknown (to me) what side effects
>     this recursion might have if the number of targets is in the
>     hundreds, which is not uncommon for our customers.  James Smart
>     is aware of this and is working on a solution.
>     See my posting of 12/2/2005 and replies.
>     "2.6.15-rc4 error messages with multiple qla2300 hba ports on fabric".
> 
> 2 - qlogic fibre channel driver no longer properly handles targets coming
>     and going.  There is a race condition within the driver which can
>     result in targets being deleted yet they are present and accounted for.
>     This is a show stopper for SGI's customers.  We have to have reliable
>     target [re-]discovery.  Andrew Vasquez is aware of this issue.
>     See my posting on 12/5/2005.  "qla2x00 driver serialization issue".
> 
> In a private email, Andrew wrote:
>> > Yes, I was afraid of something like this happening (due to qla2xxx
>> > detections of ports being dropped from an interrupt context)...  Codes
>> > in qla_rscn.c already queue-up rport_adds() via the standard
>> > kernel-workqueue:
>> > 
>> > 	qla_init.c:     INIT_WORK(&fcport->rport_add_work, qla2x00_rport_add, fcport);
>> > 
>> > 	qla_rscn.c:     schedule_work(&fcport->rport_add_work);
>> > 
>> > With the additions though, I'm wondering if adding a special
>> > single-cpu qla2xxx-rport workqueue would make sense (at least we could
>> > enforce serialization).
> 
> 
> What can be done to assure fc stability in the 2.6.15 release?  It appears
> that the revision of the fc-transport from 2.6.14 has caused some
> difficulty for a current driver, and potentially the entire system.  Is
> it ready for prime time?
> 
> Mike Reed
> 


James Bottomley wrote:
> These should (hopefully) represent the last few urgent bug fixes that
> have shown up.  The fixes are available here:
> 
> master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6.git
> 
> The short changelog is:
> 
> Andrew Vasquez:
>   o qla2xxx: Correct short-WRITE status handling
>   o qla2xxx: Correct mis-handling of AENs
> 
> Brian King:
>   o fix double free of scsi request queue
> 
> Dave Boutcher:
>   o ibmvscsi kexec fix
> 
> James Bottomley:
>   o Consolidate REQ_BLOCK_PC handling path (fix ipod panic)
> 
> Jens Axboe:
>   o fix panic when ejecting ieee1394 ipod
> 
> Mark Lord:
>   o Fix incorrect pointer in megaraid.c MODE_SENSE emulation
> 
> Matthew Wilcox:
>   o Negotiate correctly with async-only devices
> 
> Michael Reed:
>   o fix OOPS due to clearing eh_action prior to aborting eh command
> 
> And the diffstat:
> 
>  drivers/scsi/ibmvscsi/ibmvscsi.h      |    2 +-
>  drivers/scsi/ibmvscsi/iseries_vscsi.c |    3 ++-
>  drivers/scsi/ibmvscsi/rpa_vscsi.c     |    8 +++++++-
>  drivers/scsi/megaraid.c               |    2 +-
>  drivers/scsi/qla2xxx/qla_def.h        |   10 +---------
>  drivers/scsi/qla2xxx/qla_init.c       |    6 +++---
>  drivers/scsi/qla2xxx/qla_isr.c        |   15 +++++++++++++++
>  drivers/scsi/scsi_error.c             |    7 ++++++-
>  drivers/scsi/scsi_lib.c               |   33 +++++++++++++++++++++------------
>  drivers/scsi/scsi_scan.c              |    1 -
>  drivers/scsi/sd.c                     |   16 +---------------
>  drivers/scsi/sr.c                     |   20 +++-----------------
>  drivers/scsi/st.c                     |   19 +------------------
>  drivers/scsi/sym53c8xx_2/sym_hipd.c   |    4 ++--
>  include/scsi/scsi_cmnd.h              |    1 +
>  15 files changed, 65 insertions(+), 82 deletions(-)
> 
> James
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
