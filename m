Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbVJ0PpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVJ0PpF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 11:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbVJ0PpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 11:45:04 -0400
Received: from xproxy.gmail.com ([66.249.82.207]:42407 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751096AbVJ0PpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 11:45:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=iISPE4w1nzPRKujLTbLFo3RQ8l0OvswbGIWH8sS2ZPjTBlVugcrqaZvg9ZG6moYHheEnt6wHUC0f0uwYLMx+jmb7KqCQpQulE3gvX9RA7c5zO/kwuTdlY2vB+kFa9E6Bm+E7Ey2C15ZpvVh65P1cEZjqX+cjSVvR6rqWWe2SUm0=
Subject: Re: 2.6.14-rc5-mm1
From: Badari Pulavarty <pbadari@gmail.com>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
In-Reply-To: <20051027152637.GC7889@plap.qlogic.org>
References: <20051024014838.0dd491bb.akpm@osdl.org>
	 <1130186927.6831.23.camel@localhost.localdomain>
	 <20051024141646.6265c0da.akpm@osdl.org>
	 <20051027152637.GC7889@plap.qlogic.org>
Content-Type: text/plain
Date: Thu, 27 Oct 2005 08:44:27 -0700
Message-Id: <1130427867.23729.73.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-27 at 08:26 -0700, Andrew Vasquez wrote:
> On Mon, 24 Oct 2005, Andrew Morton wrote:
> 
> > Badari Pulavarty <pbadari@gmail.com> wrote:
> > >
> > > On Mon, 2005-10-24 at 01:48 -0700, Andrew Morton wrote:
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc5/2.6.14-rc5-mm1/
> > > > 
> > > 
> > > I can't seem to keep my AMD64 machine up with 2.6.14-rc5-mm1.
> > > Keep running into following. qlogic driver problem ?
> > 
> > I don't know why the qlogic driver has suddenly started doing this - were
> > there any earlier messages which might tell us?  Is it possible to increase
> > the debugging level?
> > 
> > I can spot one bug in there, but the lockup is just a symptom.
> > 
> > There are no qlogic changes in 2.6.14-rc5-mm1.
> > 
> > > Thanks,
> > > Badari
> > > 
> > > NMI Watchdog detected LOCKUP on CPU 0
> > > CPU 0
> > > Modules linked in: qlogicfc qla2300 qla2200 qla2xxx firmware_class
> 
> 
> qlogicfc attaches to both 2100 and 2200 ISPs.  It seems you're then
> trying to load qla2xxx driver along with the 2300 and 2200 firmware
> loader modules.  The pci_request_regions() call during 2200 probing
> fails.

Hmm. This is happening because I have both qlogicfc and qla2200 as
modules ?

> 
> > > <ffffffff8010dd2e>{system_call+12 6}
> > 
> > qla2x00_probe_one() has called qla2x00_free_device() and
> > qla2x00_free_device() has locked up in
> > wait_for_completion(&ha->dpc_exited);
> > 
> > Presumably, ha->dpc_exited is not initialised yet.
> > 
> 
> Causing this cleanup badness.
> 
> > The first `goto probe_failed' in qla2x00_probe_one() will cause
> > qla2x00_free_device() to run wait_for_completion() against an uninitialised
> > completion struct.  Because ha->dpc_pid will be >= 0.
> > 
> > This patch might fix the lockup, but if so, qla2x00_iospace_config()
> > failed.  Please debug that a bit for us?
> 
> Badari, is there some reason you are using qlogicfc?  THe qla2xxx
> driver supports all QLogic ISP parts.

Not intentionally. I have qla2200, qla2300 cards in my machine.
I build all the qlogic drivers as modules.

I hate to admit it - but I do use modules for qlogic disks.
I can't seem to compile the qlogic drivers (2200, 2300) into the
kernel and boot without problems (consistently on all my machines 
- I run into few issues):

(1) Between kernels, sometimes probing order changes and my local
disks get probed last and screws up my boot process - I don't
think this is a qlogic problem.

(2) Sometimes, one of the driver complains something like 
"PCI region already in use" and hangs on boot.

BTW, (2) happens even if its modules and I can't boot my
machine. Sometimes I had to boot with old kernel and hide
the modules - so boot process can't find them to workaround
the problem.

Is there a "dont-load-modules" option or don't load a specific
module option on boot ?

Thanks,
Badari

