Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131454AbRCQANS>; Fri, 16 Mar 2001 19:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131447AbRCQANJ>; Fri, 16 Mar 2001 19:13:09 -0500
Received: from gateway.sequent.com ([192.148.1.10]:11756 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S131440AbRCQAMx>; Fri, 16 Mar 2001 19:12:53 -0500
From: Patrick Mansfield <patman@sequent.com>
Message-Id: <200103170012.f2H0C8s01133@eng2.sequent.com>
Subject: Re: scsi_scan problem.
To: raffo@neuronet.pitt.edu (Rafael E. Herrera),
        dledford@redhat.com (Doug Ledford)
Date: Fri, 16 Mar 101 16:12:03 -0800 (PST)
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <3AB29636.64C90827@neuronet.pitt.edu> from "Rafael E. Herrera" at Mar 16, 2001 05:39:50 PM
X-Mailer: ELM [version 2.5 PL0b2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I applied the first hunk to version 2.4.3-pre4, as by email with Doug.
> The output for the scsi devices follows and is identical with and
> without the patch. Maybe someone can explain the meaning of the illegal
> requests at the end. Nevertheless, I can use the drive fine.
> 

If your testing Doug's patch, it might be a good idea to run with/without 
your adapter built as a module, as the kernel is inconsistent in its setting
of "online" in scsi.c: it sets online TRUE after an attach in 
scsi_register_device_module(), but leaves online as is after an
attach in scsi_register_host(). 

So, if the scan_scsis set online FALSE, it sometimes is set back to TRUE;
otherwise, I don't think any other code will set online to TRUE (once it
is set to FALSE after its scanned, no one can even open the device, not even sg).

The online = TRUE should probably be removed from scsi_register_device_module(),
as disks with peripheral qualifier 1 (like Doug's the Clariion storage)
ususally complain when sent a READ CAPACITY. I got such errors when running with
a Clariion DASS (DGC RAID/DISK, scsi attached disk array).

Doug - did you try running with/without your adapter built as a module? I'd
expect you to get a READ CAPACITY failure for each LUN with PQ 1.

-- Patrick Mansfield
