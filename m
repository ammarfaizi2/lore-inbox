Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262236AbUKKNyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbUKKNyd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 08:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbUKKNyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 08:54:33 -0500
Received: from ums.usu.ru ([194.226.236.116]:48338 "EHLO ums.usu.ru")
	by vger.kernel.org with ESMTP id S262236AbUKKNy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 08:54:29 -0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Subject: Re: [PATCH] Partitioned loop devices, support for 127 Partitions on SATA, IDE and SCSI
Date: Thu, 11 Nov 2004 18:55:06 +0500
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <419199A3.3050806@gmx.net> <cmsb12$pr1$1@sea.gmane.org> <4192F069.90209@gmx.net>
In-Reply-To: <4192F069.90209@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411111855.06266.patrakov@ums.usu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 November 2004 09:54, Carl-Daniel Hailfinger wrote:
> Alexander E. Patrakov schrieb:
> > Carl-Daniel Hailfinger wrote:
> >>Hi,
> >>
> >>having seen the problems people have when switching from traditional IDE
> >>drivers to libata if they have more than 15 partitions, I decided to do
> >>something against it. With this patch (and recreating /dev/loop* nodes)
> >>it is possible to support up to 127 partitions per loop device
> >>regardless what the underlying device supports. It works for me
> >>and has the added bonus that it will be in compatibility mode as long
> >>as you don't specify the max_part parameter.
> >
> > Why not just use EVMS? Partition code is supposed to be moved to
> > userspace anyway.
>
> Because my solution works fine with userspace partitioning code (I tested
> with partx from util-linux) and has the big advantage that partitions
> actually appear at the right place in /sys/block/loopN/loopNpM. Most
> other solutions for many partitions per device failed to make the
> relationship between parent device and partition visible in sysfs.
> I haven't checked yet how EVMS handles this. Could you post
> find /sys/block/$SOME_EVMS_DISK/ -type d
> for a normal disk which is completely managed by EVMS so I can verify
> whether that would be satisfactory. Thanks.

That is not satisfactory since this relation is not expressed in sysfs at all 
(device-mapper issue, discuss it on dm-devel if you want). EVMS is using 
normal dm devices (like LVM2 does), so, although there are subdirectories 
of /sys/block/hdc, they correspond only to normal ("obsolete", kernel-space, 
unusable together with EVMS) partitions.

patrakov@lfs:~$ find /sys/block/hdc/ -type d
/sys/block/hdc/
/sys/block/hdc/queue
/sys/block/hdc/queue/iosched
/sys/block/hdc/hdc1
/sys/block/hdc/hdc2
and so on

(The last two entries correspond to unusable devices)

Real block devices with filesystems on them devices are there:
patrakov@lfs:~$ find /sys/block/dm* -type d
/sys/block/dm-0
/sys/block/dm-1
/sys/block/dm-2
/sys/block/dm-3
/sys/block/dm-4
/sys/block/dm-5
/sys/block/dm-6
/sys/block/dm-7
/sys/block/dm-8

EVMS installation is non-intrusive if you want to use it just for loop devices 
(just enable device mapper in vanilla linux-2.6.9 and install userspace 
tools), so you can try it without any risk.

-- 
Alexander E. Patrakov
