Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUGXQHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUGXQHi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 12:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUGXQHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 12:07:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:31171 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261239AbUGXQHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 12:07:35 -0400
Subject: Re: device_suspend() levels [was Re: [patch] ACPI work on aic7xxx]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Bryant <nbryant@optonline.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <410280E9.5040001@optonline.net>
References: <40FD38A0.3000603@optonline.net>
	 <20040720155928.GC10921@atrey.karlin.mff.cuni.cz>
	 <40FD4CFA.6070603@optonline.net>
	 <20040720174611.GI10921@atrey.karlin.mff.cuni.cz>
	 <40FD6002.4070206@optonline.net> <1090347939.1993.7.camel@gaston>
	 <40FD65C2.7060408@optonline.net> <1090350609.2003.9.camel@gaston>
	 <40FD82B1.8030704@optonline.net> <1090356079.1993.12.camel@gaston>
	 <40FD85A3.2060502@optonline.net> <1090357324.1993.15.camel@gaston>
	 <410280E9.5040001@optonline.net>
Content-Type: text/plain
Message-Id: <1090684826.1963.6.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 24 Jul 2004 12:00:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-24 at 11:31, Nathan Bryant wrote:
> Benjamin Herrenschmidt wrote:
> 
> >save_state is a nonsense, didn't we kill it ? 

sysfs only takes care about the bus hierarchy as far as suspend/resume
is concerned (which is the only sane way to do it imho)

> queue quiescing must be
> >done by the upper level, which is a bit nasty with things like md &
> >multipath... basically, the low level driver must have a way to notify
> >it's functional parent (as opposed to it's bus parent) that it's going
> >to sleep, and any path using this low level driver must then be
> >quiesced, the parent must resume only when all the drivers it relies
> >on are back up.
> >
> Isn't sysfs supposed to take care of this for us? IOW, I shouldn't have 
> to call up to the SCSI midlayer from pcidev->suspend in order to notify 
> it of a suspend, the midlayer should call the driver before we ever try 
> to suspend. This may become important some day when the upper layers 
> need to decide which order to bring pci devices down

No, the ordering cannot be dictated by the upper layer, but by the
physical bus hierarchy. The low level driver gets the suspend callback
and need to notify the parent. The md/multipath must keep track that one
of the device it relies on is going away and thus block the queues.

That is at least for machine suspend/resume.

> Looking in /sys/devices shows that sysfs already knows that 'host0' is a 
> child of a SCSI PCI device.

Yes, but the PM herarchy is the bus hierarchy, I don't see a simple way
of going through both in this case ...

> $ ls 
> /sys/devices/pci0000\:00/0000\:00\:1e.0/0000\:02\:02.0/host0/0\:0\:0\:0/
> block   detach_state    model  queue_depth  rev         state    type
> delete  device_blocked  power  rescan       scsi_level  timeout  vendor
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

