Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbUJZQkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbUJZQkf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 12:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbUJZQkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 12:40:35 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:8051 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261331AbUJZQkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 12:40:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=tGPKKScu6guWB+tgJNaFoScurdb1Vzj+Rxjr6tXQ0px2a9mamqalKZ2dslJJ27wVaH4DAtsTgE6fxCCNBo2ar9bsX0tHqV2EzHhQv6iO2KmdwaGgycS2+yiggCiNmYD1fEywIDhhM45KFcOrZUemPXWoAGmf9JSjjNFcQh29mE8=
Message-ID: <58cb370e041026094016ac67d0@mail.gmail.com>
Date: Tue, 26 Oct 2004 18:40:09 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: 2.6.9-mm1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <417E71C1.1080400@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041022032039.730eb226.akpm@osdl.org> <417D7EB9.4090800@osdl.org>
	 <20041025155626.11b9f3ab.akpm@osdl.org> <417D88BB.70907@osdl.org>
	 <20041025164743.0af550ce.akpm@osdl.org> <417D8DFF.1060104@osdl.org>
	 <Pine.GSO.4.58.0410260319100.17615@mion.elka.pw.edu.pl>
	 <417DBEC1.5000701@osdl.org> <417E71C1.1080400@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004 08:48:17 -0700, Randy.Dunlap <rddunlap@osdl.org> wrote:
> 
> >>>>> Yes, that gets further.   :(
> >>>>> Maybe I'll just (try) apply the kexec patch to a vanilla kernel.
> >>
> >>
> >>
> >> IDE PIO changes are the part of a vanilla kernel.
> >>
> >> If vanilla kernel (+akpm's fix) works OK then
> >> this bug is not mine fault. :)
> >>
> >>
> >>>> I doubt if it'll help much.  It looks like IDE PIO got badly broken.
> >>
> >>
> >>
> >> Weird, this code was in -mm for over a month.
> >>
> >>
> >>>> That's something we have to fix - could you work with Bart on it
> >>>> please?
> >>>
> >>>
> >>> Sure.  Bart?
> >>
> >>
> >>
> >> I need more data, IDE PIO works fine here.
> >>
> >>
> >>>> How come your disks are running in PIO mode anyway?
> >>
> >>
> >>
> >> Maybe disks are runing in DMA mode but some application
> >> triggers PIO access (IDENTIFY command, S.M.A.R.T. etc.)...
> >>
> >>
> >>> No idea.
> >
> >
> > Andrew made me look.  Duh.  It's because I'm booting with
> > ide=nodma.
> >
> > So Bart, can you check the noautodma=1 code path?
> > And I'll test it again on Tuesday without using ide=nodma.
> 
> Booting 2.6.9-mm1 without using "ide=nodma" works well for me.
> No other kernel changes.

I audited the code and only found the unrelated bug in
/proc/ide/hd?/smart_thresholds, fix below...

--- ide-disk.c.orig	2004-10-26 15:50:51.000000000 +0200
+++ ide-disk.c	2004-10-26 18:34:50.736448416 +0200
@@ -977,6 +977,7 @@
 	args.tfRegister[IDE_HCYL_OFFSET]	= SMART_HCYL_PASS;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SMART;
 	args.command_type			= IDE_DRIVE_TASK_IN;
+	args.data_phase				= TASKFILE_IN;
 	args.handler				= &task_in_intr;
 	(void) smart_enable(drive);
 	return ide_raw_taskfile(drive, &args, buf);

I tried reproducing the OOPS but I couldn't.  Little bird tells me that
this bug is SMP and/or highmem specific (I don't have such hardware).

Randy, could you "ide=nodma" with 2.6.10-rc1 (+akpm's fix) and 2.6.9?

Cheers,
Bartlomiej
