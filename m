Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267312AbSLRShD>; Wed, 18 Dec 2002 13:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267279AbSLRShD>; Wed, 18 Dec 2002 13:37:03 -0500
Received: from jdi.jdimedia.nl ([212.204.192.51]:49039 "EHLO jdi.jdimedia.nl")
	by vger.kernel.org with ESMTP id <S267312AbSLRShB>;
	Wed, 18 Dec 2002 13:37:01 -0500
Date: Wed, 18 Dec 2002 19:45:00 +0100 (CET)
From: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
X-X-Sender: igmar@jdi.jdimedia.nl
To: linux-kernel@vger.kernel.org
Subject: Invalidate: busy buffer + MD RAID 1
Message-ID: <Pine.LNX.4.44.0212181905500.4421-100000@jdi.jdimedia.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I get a 'invalidate: busy buffer' about 20 times at reboot. Only at 
reboot however.

Setup :

linux-2.4.19 + grsecurity-1.9.7d + acl+xattr 0.8.53 + freeswan (inc. aes 
and that kind of stuff)

The machine (Compaq ML350) has 2 scsi devices (sda, sdb) and a RAID 1 
setup :

md0 : sda1 + sdb1
md1 : sda3 + sdb3
swap is done on sda2 + sdb2, using default prio's.

Triggering the 'invalidate: busy buffer' is easiest done by letting squid 
create it's cache dirs and then rebooting.

No data corruption is occuring (at last not any that a force fsck can 
detect), but I removed the RAID1 setup to make sure I sleep well tonight 
:)

Looking at the md.c code, line 1708 :

    ITERATE_RDEV(mddev,rdev,tmp) {
        if (rdev->faulty)
            continue;
        invalidate_device(rdev->dev, 1);
        if (get_hardsect_size(rdev->dev)
            > md_hardsect_sizes[mdidx(mddev)])
            md_hardsect_sizes[mdidx(mddev)] =
                get_hardsect_size(rdev->dev);
    }

Looks like it is invalidating the underlying devices (sda[13], sdb[13] in 
my case.

Since my RAID array doesn't get screwed I suspect that the md code does 
the above again on a do_md_stop(), but I can't find it.

Anyone got any comments on this ?? 



	Regards,


		Igmar


Please CC all responses.



-- 

Igmar Palsenberg
JDI Media Solutions

Helhoek 30
6923PE Groessen
Tel: +31 (0)316 - 596695
Fax: +31 (0)316 - 596699
The Netherlands

mailto: i.palsenberg@jdimedia.nl
PGP/GPG key : http://www.jdimedia.nl/formulier/pgp/igmar

