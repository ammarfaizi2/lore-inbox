Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136720AbREAUyx>; Tue, 1 May 2001 16:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136715AbREAUyr>; Tue, 1 May 2001 16:54:47 -0400
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:44367
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S136717AbREAUyh>; Tue, 1 May 2001 16:54:37 -0400
Message-Id: <200105012052.QAA02265@localhost.localdomain>
X-Mailer: exmh version 2.1.1 10/15/1999
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Eric.Ayers@intec-telecom-systems.com, dledford@redhat.com (Doug Ledford),
        James.Bottomley@steeleye.com (James Bottomley),
        Chris.Roets@compaq.com (Roets Chris), linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: Linux Cluster using shared scsi 
In-Reply-To: Message from Alan Cox <alan@lxorguk.ukuu.org.uk> 
   of "Tue, 01 May 2001 21:38:26 BST." <E14uguj-0002KC-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 01 May 2001 16:52:31 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric.Ayers@intec-telecom-systems.com said:
> Does this package also tell the kernel to "re-establish" a reservation
> for all devices after a bus reset, or at least inform a user level
> program?  Finding out when there has been a bus reset has been a
> stumbling block for me. 

alan@lxorguk.ukuu.org.uk said:
> You cannot rely on a bus reset. Imagine hot swap disks on an FC
> fabric. I  suspect the controller itself needs to call back for
> problem events 

Essentially, there are many conditions which cause a quiet loss of a SCSI-2 
reservation.  Even in parallel SCSI: Reservations can be silently lost because 
of LUN reset, device reset or even simple powering off the device.

The way we maintain reservations for LifeKeeper is to have a user level daemon 
ping the device with a reservation command every few minutes.  If you get a 
RESERVATION_CONFLICT return you know that something else stole your 
reservation, otherwise you maintain it.  There is a window in this scheme 
where the device may be accessible by other initiators but that's the price 
you pay for using SCSI-2 reservations instead of the more cluster friendly 
SCSI-3 ones.  In a kernel scheme, you may get early notification of 
reservation loss by putting a hook into the processing of 
CHECK_CONDITION/UNIT_ATTENTION, but it won't close the window entirely.

James




