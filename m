Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262317AbSJEMc4>; Sat, 5 Oct 2002 08:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262318AbSJEMcz>; Sat, 5 Oct 2002 08:32:55 -0400
Received: from fep07-0.kolumbus.fi ([193.229.0.51]:48759 "EHLO
	fep07-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id <S262317AbSJEMcz>; Sat, 5 Oct 2002 08:32:55 -0400
Date: Sat, 5 Oct 2002 15:38:29 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI st tape wrong minor in 2.5.40 with devfs
In-Reply-To: <Pine.BSF.4.44.0210051147090.39858-100000@e0-0.zab2.int.zabbadoz.net>
Message-ID: <Pine.LNX.4.44.0210051530430.5824-100000@kai.makisara.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Oct 2002, Bjoern A. Zeeb wrote:

> Hi,
>
> I see a problem with recent 2.5 kernels and SCSI st and devfs.
>
You probably can see it also with driverfs :-(

> As you can see from the output down under the minors are off by 4.
>
The device registration was moved outside the st_dev_arr_lock spinlock but
it seems that I was a bit careless, after all. The driverfs/devicefs
registration loop contains the following lines:

            tpnt->driverfs_dev_r[mode].driver_data =
                        (void *)(long)__mkdev(MAJOR_NR, i + (mode << 5));

            tpnt->de_r[mode] =
                devfs_register (SDp->de, name, DEVFS_FL_DEFAULT,
                                MAJOR_NR, i + (mode << 5),
                                S_IFCHR | S_IRUGO | S_IWUGO,

(two of each type)

In the original location i did contain the device number but here it
contains 4 (from the latest loop). The fix seems to be to replace i by
dev_num but I have not yet tested it.

Thanks for reporting the bug.

--
Kai


