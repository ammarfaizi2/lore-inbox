Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbVJ0P0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbVJ0P0p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 11:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVJ0P0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 11:26:44 -0400
Received: from pat.qlogic.com ([198.70.193.2]:15989 "EHLO avexch01.qlogic.com")
	by vger.kernel.org with ESMTP id S1751080AbVJ0P0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 11:26:43 -0400
Date: Thu, 27 Oct 2005 08:26:37 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Badari Pulavarty <pbadari@gmail.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.14-rc5-mm1
Message-ID: <20051027152637.GC7889@plap.qlogic.org>
References: <20051024014838.0dd491bb.akpm@osdl.org> <1130186927.6831.23.camel@localhost.localdomain> <20051024141646.6265c0da.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051024141646.6265c0da.akpm@osdl.org>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.9i
X-OriginalArrivalTime: 27 Oct 2005 15:26:37.0868 (UTC) FILETIME=[D28F26C0:01C5DB0A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2005, Andrew Morton wrote:

> Badari Pulavarty <pbadari@gmail.com> wrote:
> >
> > On Mon, 2005-10-24 at 01:48 -0700, Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc5/2.6.14-rc5-mm1/
> > > 
> > 
> > I can't seem to keep my AMD64 machine up with 2.6.14-rc5-mm1.
> > Keep running into following. qlogic driver problem ?
> 
> I don't know why the qlogic driver has suddenly started doing this - were
> there any earlier messages which might tell us?  Is it possible to increase
> the debugging level?
> 
> I can spot one bug in there, but the lockup is just a symptom.
> 
> There are no qlogic changes in 2.6.14-rc5-mm1.
> 
> > Thanks,
> > Badari
> > 
> > NMI Watchdog detected LOCKUP on CPU 0
> > CPU 0
> > Modules linked in: qlogicfc qla2300 qla2200 qla2xxx firmware_class


qlogicfc attaches to both 2100 and 2200 ISPs.  It seems you're then
trying to load qla2xxx driver along with the 2300 and 2200 firmware
loader modules.  The pci_request_regions() call during 2200 probing
fails.

> > <ffffffff8010dd2e>{system_call+12 6}
> 
> qla2x00_probe_one() has called qla2x00_free_device() and
> qla2x00_free_device() has locked up in
> wait_for_completion(&ha->dpc_exited);
> 
> Presumably, ha->dpc_exited is not initialised yet.
> 

Causing this cleanup badness.

> The first `goto probe_failed' in qla2x00_probe_one() will cause
> qla2x00_free_device() to run wait_for_completion() against an uninitialised
> completion struct.  Because ha->dpc_pid will be >= 0.
> 
> This patch might fix the lockup, but if so, qla2x00_iospace_config()
> failed.  Please debug that a bit for us?

Badari, is there some reason you are using qlogicfc?  THe qla2xxx
driver supports all QLogic ISP parts.

> Andrew, this driver should be converted to use the kthread API - using
> kill_proc() from within a driver to terminate a kernel thread is kinda
> gross.

I'll look into this as well

Thanks,
Andrew Vasquez
