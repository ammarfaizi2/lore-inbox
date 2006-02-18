Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWBRAJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWBRAJl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 19:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWBRAJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:09:40 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:26848
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750926AbWBRAJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:09:40 -0500
Date: Fri, 17 Feb 2006 16:09:21 -0800
From: Greg KH <gregkh@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>, david-b@pacbell.net
Cc: LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com,
       Paul Bristow <paul@paulbristow.net>, mpm@selenic.com,
       B.Zolnierkiewicz@elka.pw.edu.pl, dtor_core@ameritech.net, kkeil@suse.de,
       linux-dvb-maintainer@linuxtv.org, philb@gnu.org, dwmw2@infradead.org
Subject: Re: kbuild: Section mismatch warnings
Message-ID: <20060218000921.GA15894@suse.de>
References: <20060217214855.GA5563@mars.ravnborg.org> <20060217224702.GA25761@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060217224702.GA25761@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 11:47:02PM +0100, Sam Ravnborg wrote:
> Background:
> I have introduced a build-time check for section mismatch and it showed
> up a great number of warnings.
> Below is the result of the run on a 2.6.16-rc1 tree (which my kbuild
> tree is based upon) based on a 'make allmodconfig'
> 
> 159 warnings in 49 different modules
> 
> I have included the obvious candidates for the modules in to: but some
> are for sure missing and some may be wrong.
> 
> WARNING: drivers/usb/gadget/g_ether.o - Section mismatch: reference to .init.text from .data between 'eth_driver' (at offset 0x10) and 'stringtab'
> WARNING: drivers/usb/gadget/g_file_storage.o - Section mismatch: reference to .init.text from .data between 'fsg_driver' (at offset 0x10) and 'stringtab'
> WARNING: drivers/usb/gadget/g_serial.o - Section mismatch: reference to .init.text from .text between 'gs_bind' (at offset 0x50) and '.text.lock.serial'
> WARNING: drivers/usb/gadget/g_serial.o - Section mismatch: reference to .init.text from .text between 'gs_bind' (at offset 0x5f) and '.text.lock.serial'
> WARNING: drivers/usb/gadget/g_serial.o - Section mismatch: reference to .init.text from .text between 'gs_bind' (at offset 0x88) and '.text.lock.serial'
> WARNING: drivers/usb/gadget/g_serial.o - Section mismatch: reference to .init.text from .text between 'gs_bind' (at offset 0xba) and '.text.lock.serial'
> WARNING: drivers/usb/gadget/g_zero.o - Section mismatch: reference to .init.text from .text between 'zero_bind' (at offset 0x11) and 'zero_suspend'
> WARNING: drivers/usb/gadget/g_zero.o - Section mismatch: reference to .init.text from .text between 'zero_bind' (at offset 0x20) and 'zero_suspend'
> WARNING: drivers/usb/gadget/g_zero.o - Section mismatch: reference to .init.text from .text between 'zero_bind' (at offset 0x68) and 'zero_suspend'

David, these all look like they are due to the calls in the
drivers/usb/gadget/epautoconf.c file from functions within the gadget
drivers.  It looks like it's all safe, but can you verify that the bind
callback is finished before module_init() exits?

And if so, we should mark the bind functions __init also, to prevent
this from being flagged in the future.

> WARNING: drivers/usb/host/isp116x-hcd.o - Section mismatch: reference to .init.text from .data between '' (at offset 0x0) and 'isp116x_hc_driver'

This looks like the isp116x_remove function just needs to get the looney
__init_or_module marking of of it.  Again, David, do you agree?

thanks,

greg k-h
