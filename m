Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbVCBKJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbVCBKJO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 05:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVCBKJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 05:09:14 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:49952 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262250AbVCBKJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 05:09:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=AzcNSal/JQcbhF65d4HOEFDnc+tNphh3LHFeo+fxU4aVSZtnMWCWsk9Iwy0069gKxdZ4B+R/m0SsWoZEBMXdZGBKAeu9ilkqwXY611uLeswfiMN05FGATqoXpnuq6Vsam3e2ntbJHkOrA9sWHu7b/JBgr8y6EIayuwzi4PzrDR8=
Message-ID: <58cb370e050302020950da588a@mail.gmail.com>
Date: Wed, 2 Mar 2005 11:09:02 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch ide-dev 8/9] make ide_task_ioctl() use REQ_DRIVE_TASKFILE
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <42255878.7080908@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.GSO.4.58.0502241547400.13534@mion.elka.pw.edu.pl>
	 <200502271731.29448.bzolnier@elka.pw.edu.pl>
	 <422337A1.4060806@gmail.com>
	 <200502281714.55960.bzolnier@elka.pw.edu.pl>
	 <20050301042116.GA9001@htj.dyndns.org>
	 <58cb370e05030100424d98c85c@mail.gmail.com>
	 <20050301092914.GA14007@htj.dyndns.org>
	 <58cb370e05030101592a46c258@mail.gmail.com>
	 <42255878.7080908@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Mar 2005 01:08:56 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Yes but it seems that you've assumed that ioctl == flagged taskfile
> > and fs/internal == normal taskfile which is _not_ what I aim for.
> >
> > I want fully-flagged taskfile handling like flagged_taskfile() and "hot path"
> > simpler taskfile handling like do_rw_taskfile() (at least for now - we can
> > remove "hot path" later) where both can be used for fs/internal/ioctl requests
> > (depending on the flags).
> 
> There is no effective difference in performance between
> 
>         writeb()
>         writeb()
>         writeb()
>         writeb()
> 
> and
> 
>         if (bit 1)
>                 writeb()
>         if (bit 2)
>                 writeb()
>         if (bit 3)
>                 writeb()
>         if (bit 4)
>                 writeb()
> 
> The cost of a repeated bit test on the same unsigned long is _zero_.
> It's already in L1 cache.  The I/Os are slow, and adding bit tests will

certainly it is not _zero_ ;-)

I agree that it is negligible compared to the cost of I/O

> not measurably decrease performance.  (this is the reason why I do not
> object to using ioread32() and iowrite32()...  it just adds a simple test)
> 
> Plus, it is better to have a single path for all taskfiles, to ensure
> that the path is well-tested.
> 
> libata's ->tf_load() and ->tf_read() hooks should be updated to use the
> more fine-grained flags that Tejun is proposing.
> 
> Note that on SATA, this is largely irrelevant.  The functions
> ata_tf_read() and ata_tf_load() should be updated for flagged taskfiles,
> because these will be used with PATA drivers.
> 
> The hooks implemented in individual SATA drivers will not be updated.
> The reason is that SATA transmits an entire copy of the taskfile to/from
> the device all at once, in the form of a Frame Information Structure
> (FIS) -- essentially a SATA packet.

agreed

Tejun, one-path approach for IDE driver is fine with me
