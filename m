Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131485AbRCQBwB>; Fri, 16 Mar 2001 20:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131158AbRCQBvw>; Fri, 16 Mar 2001 20:51:52 -0500
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:1428 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131063AbRCQBvg>; Fri, 16 Mar 2001 20:51:36 -0500
Message-ID: <3AB2C43C.EEFE0BAD@redhat.com>
Date: Fri, 16 Mar 2001 20:56:12 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick Mansfield <patman@sequent.com>
CC: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: scsi_scan problem.
In-Reply-To: <200103170012.f2H0C8s01133@eng2.sequent.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mansfield wrote:

> If your testing Doug's patch, it might be a good idea to run with/without
> your adapter built as a module, as the kernel is inconsistent in its setting
> of "online" in scsi.c: it sets online TRUE after an attach in
> scsi_register_device_module(), but leaves online as is after an
> attach in scsi_register_host().

Grrr...I hate these kinds of inconsistencies.  They don't belong there. 
Whether a driver is a module or compiled in should not effect whether or not
an attached device is considered valid.

> So, if the scan_scsis set online FALSE, it sometimes is set back to TRUE;
> otherwise, I don't think any other code will set online to TRUE (once it
> is set to FALSE after its scanned, no one can even open the device, not even sg).

This is the case for what I was seeing (but, all of the offline entries used
up all 40 SCSI disk structs that were available for use, so if I brought
another controller online there would be no available disk slots).

> The online = TRUE should probably be removed from scsi_register_device_module(),
> as disks with peripheral qualifier 1 (like Doug's the Clariion storage)
> ususally complain when sent a READ CAPACITY. I got such errors when running with
> a Clariion DASS (DGC RAID/DISK, scsi attached disk array).
> 
> Doug - did you try running with/without your adapter built as a module? I'd
> expect you to get a READ CAPACITY failure for each LUN with PQ 1.

All modular, but none of the disks on mine ever got the error you are
mentioning.  Could possibly be because my root disk is on an aic7xxx and the
array on a qla2x00 that I did *not* let be included in the initrd so I could
bring it up after the rest of the boot was complete.  This, of course, implies
that sd_mod was loaded well before the qla2x00 and if I read your above
comments correctly, that means it scanned the array from someplace other than
scsi_register_device_module() and hence didn't get hit by the problem you are
referring to.  In fact, I would guess the problem you are referring to only
happens when a driver module is loaded prior to sd_mod.o, and that reversing
the order will solve the problem (but, I haven't looked so I could easily be
wrong ;-)


-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
