Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130227AbRBZObJ>; Mon, 26 Feb 2001 09:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130219AbRBZO27>; Mon, 26 Feb 2001 09:28:59 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130226AbRBZO2k>;
	Mon, 26 Feb 2001 09:28:40 -0500
Date: Mon, 26 Feb 2001 14:05:04 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200102261305.OAA04955.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, Holger.Smolinski@de.ibm.com, dwguest@win.tue.nl,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] partitions/ibm.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From Holger.Smolinski@de.ibm.com Mon Feb 26 12:10:59 2001

    Andries, others,
    Thanks for hacking through the code of fs/partitions/ibm.c.
    Your patch does not work at all because you are relying on the
    data in the part component of the hd structure, which does not
    hold the geometry data of the disk but the data of the partitions
    on that disk.

Hmm. To me "geometry" means things with sectors, heads and cylinders -
something you do not need at all. You only need to know whether you
have to read sector 1 or 2 from this disk.

    Besides that, exactly these data are to be set up
    by the code in fs/partitions/ibm.c.

No.
ibm_partition() is called from check_partition(), which does
	first_sector = hd->part[MINOR(dev)].start_sect;
and then calls ibm_partition() with first_sector as third parameter.
Clearly, this assumes that hd->part[MINOR(dev)].start_sect
has a value already.

The "start" field of the struct returned by HDIO_GETGEO does not
tell us where the partition table lives.
It tells us where the partition starts. Maybe there is no table.
For an entire disk the answer will be zero.

Thus, I think the present setup of ibm_partition() is broken.
(If I have a disk with ibm partition, then it seems right now
it cannot be moved to some ide or scsi machine because the
information you want is returned only by the
	device->discipline->fill_geometry()
call in dasd.c, and not by the HDIO_GETGEO of any other driver.)

Andries


[And, of course, similarly, these fill_geometry() routines are broken.]

