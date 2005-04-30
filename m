Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVD3Jsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVD3Jsg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 05:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVD3Jsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 05:48:36 -0400
Received: from fire.osdl.org ([65.172.181.4]:61317 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261168AbVD3Js0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 05:48:26 -0400
Date: Sat, 30 Apr 2005 02:47:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [patch] properly stop devices before poweroff
Message-Id: <20050430024748.19d44a8d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0504290734220.30771@montezuma.fsmlabs.com>
References: <20050421111346.GA21421@elf.ucw.cz>
	<20050429061825.36f98cc0.akpm@osdl.org>
	<Pine.LNX.4.61.0504290734220.30771@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
>
> On Fri, 29 Apr 2005, Andrew Morton wrote:
> 
> > Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > > 
> > > Without this patch, Linux provokes emergency disk shutdowns and
> > > similar nastiness. It was in SuSE kernels for some time, IIRC.
> > > 
> > 
> > With this patch when running `halt -p' my ia64 Tiger (using
> > tiger_defconfig) gets a stream of badnesses in iosapic_unregister_intr()
> > and then hangs up.
> > 
> > Unfortunately it all seems to happen after the serial port has been
> > disabled because nothing comes out.  I set the console to a squitty font
> > and took a piccy.  See
> > http://www.zip.com.au/~akpm/linux/patches/stuff/dsc02505.jpg
> > 
> > I guess it's an ia64 problem.  I'll leave the patch in -mm for now.
> 
> Could you cat /proc/interrupts during runtime?

           CPU0       CPU1       CPU2       CPU3       
 28:          0          0          0          0          LSAPIC  cpe_poll
 29:          0          0          0          0          LSAPIC  cmc_poll
 30:          0          0          0          0  IO-SAPIC-level  cpe_hndlr
 31:          0          0          0          0          LSAPIC  cmc_hndlr
 34:         19          0          0          0   IO-SAPIC-edge  ide0
 39:          0          0          0          0  IO-SAPIC-level  acpi
 48:        382          0          0          0  IO-SAPIC-level  eth0
 49:          0       2835          0          0  IO-SAPIC-level  ioc0
 50:          0          0         29          0  IO-SAPIC-level  ioc1
 51:          0          0          0          0  IO-SAPIC-level  uhci_hcd:usb1
 52:         51          0          0          0  IO-SAPIC-level  uhci_hcd:usb2
232:          0          0          0          0          LSAPIC  mca_rdzv
238:          0          0          0          0          LSAPIC  perfmon
239:     122785     128748     129310     130523          LSAPIC  timer
240:          0          0          0          0          LSAPIC  mca_wkup
254:         29         77        101        102          LSAPIC  IPI
ERR:          0

> It looks like the device 
> being suspended never went through pci_device_enable() (e.g. ethernet 
> interface wasn't up). It's harmless right now.

Everything's up.  Perhaps we're trying to disable devices more than once?
