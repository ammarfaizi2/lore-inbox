Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263232AbUDPOtO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 10:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263240AbUDPOtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 10:49:14 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:4869 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263232AbUDPOtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 10:49:10 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: poor sata performance on 2.6
Date: Fri, 16 Apr 2004 17:48:38 +0300
User-Agent: KMail/1.5.4
Cc: Konstantin Sobolev <kos@supportwizard.com>,
       Justin Cormack <justin@street-vision.com>,
       Ryan Geoffrey Bourgeois <rgb005@latech.edu>,
       Kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
References: <200404150236.05894.kos@supportwizard.com> <200404152030.51052.vda@port.imtp.ilyichevsk.odessa.ua> <407F315E.2000809@pobox.com>
In-Reply-To: <407F315E.2000809@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404161748.38958.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 April 2004 04:05, Jeff Garzik wrote:
> Denis Vlasenko wrote:
> > On Thursday 15 April 2004 17:48, Konstantin Sobolev wrote:
> >>On Thursday 15 April 2004 18:33, Justin Cormack wrote:
> >>>On Thu, 2004-04-15 at 15:26, Konstantin Sobolev wrote:
> >>>>On Thursday 15 April 2004 18:00, Justin Cormack wrote:
> >>>>>hmm, odd. I get 50MB/s or so from normal (7200, 8MB cache) WD disks,
> >>>>>and Seagate from the same controller. Can you send lspci,
> >>>>>/proc/interrupts and dmesg...
> >>>>
> >>>>Attached are files for 2.6.5-mm5 with highmem, ACPI and APIC turned
> >>>>off.
> >>>
> >>>ah. Make a filesystem on it and mount it and try again. I see you have
> >>>no partition table and so probably no filesystem. This means the block
> >>>size is set to default 512byte not 4k which makes disk operations slow.
> >>>Any filesystem should default to block size of 4k, eg ext2.
> >>
> >>Very interesting!
> >>created partition table,
> >>kos sata # mkfs.ext2 /dev/sda1
> >>[..skipped..]
> >>kos mnt # cd /
> >>kos / # mkdir wd
> >>kos / # mount /dev/sda1 /wd
> >>kos / # hdparm -t -a8192 /dev/sda
> >>
> >>/dev/sda:
> >> setting fs readahead to 8192
> >> readahead    = 8192 (on)
> >> Timing buffered disk reads:   82 MB in  3.03 seconds =  27.02 MB/sec
> >>
> >>kos / # mount | grep sda
> >>/dev/sda1 on /wd type ext2 (rw)
> >>kos / # hdparm -t -a8192 /dev/sda
> >>
> >>/dev/sda:
> >> setting fs readahead to 8192
> >> readahead    = 8192 (on)
> >> Timing buffered disk reads:  206 MB in  3.02 seconds =  68.15 MB/sec
> >>kos / # hdparm -t -a8192 /dev/sda
> >>
> >>/dev/sda:
> >> setting fs readahead to 8192
> >> readahead    = 8192 (on)
> >> Timing buffered disk reads:  206 MB in  3.02 seconds =  68.18 MB/sec
> >>
> >>So first time it gave the same loosy 27 MB/s and subsequent tests give
> >>pretty good 68 MB/s! Why?
> >
> > Time to CC ide/libata/block layer folks
> >
> > Jeff Garzik <jgarzik@pobox.com>
> > 	libata man
>
> It seems like the situation is already resolved, to me.
>
> When you mount a filesystem, it changes the default block size (512 or
> 1024) to the filesystem block size, normally 4096.  This would certainly
> increase the throughput.

Yes, this works.

But if one uses unpartitioned disk, why does (s)he need to
do some blocksize tricks before hdparm starts to measure good performance?
I think that in this case block layer can coalesce small read requests
into large ones regardless of block size.

Konstantin, does dd give you the same behaviour as hdparm?
--
vda

