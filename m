Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161363AbWKPECw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161363AbWKPECw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 23:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161354AbWKPECb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 23:02:31 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:2783 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1162234AbWKPEC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 23:02:26 -0500
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: KDB blindly reads keyboard port 
In-reply-to: Your message of "Wed, 27 Sep 2006 16:11:00 CST."
             <200609271611.00701.bjorn.helgaas@hp.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 16 Nov 2006 15:02:19 +1100
Message-ID: <23616.1163649739@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas (on Wed, 27 Sep 2006 16:11:00 -0600) wrote:
>On Tuesday 26 September 2006 20:45, Keith Owens wrote:
>> No support for legacy I/O ports could be a bigger problem than just
>> KDB.
>
>On Itanium (and I suppose on x86), ACPI theoretically tells us enough
>that we don't need to assume any legacy resources.  Of course, Linux
>doesn't listen to everything ACPI is trying to tell it.  But that's
>a Linux deficiency we should remedy.
>
>> To fix just KDB, apply this patch over kdb-v4.4-2.6.18-common-1 and
>> add 'kdb_skip_keyboard' to the boot command line on the offending
>> hardware. 
>
>This doesn't feel like the right solution.  Since firmware tells us
>whether the device is present, I think we should rely on that.  If
>you want to use the device before ACPI is initialized, *then* you
>should pass a "kdb_use_keyboard" sort of flag.

I implemented this in my kdb tree, but it has a very nasty side effect,
it stops you from debugging that part of the boot process between kdb
startup and when the i8042 is probed.  KDB starts up very early so we
can debug the boot process.  Not being able to use the PC keyboard
until later in boot is not acceptable.  People using USB keyboards
already suffer from this problem and it is very frustrating.

Adding a "kdb_use_keyboard" flag means all existing systems have to
change if they want a debugger during boot, just to workaround a few
systems that get an error when reading from non-existent legacy I/O
ports.  So I am going back to my original idea, add 'kdb_skip_keyboard'
which is only required on the problem machines.

