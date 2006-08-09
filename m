Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWHINmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWHINmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 09:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWHINmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 09:42:13 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:32404 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750801AbWHINmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 09:42:13 -0400
Date: Wed, 9 Aug 2006 15:42:11 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
       LKML <linux-kernel@vger.kernel.org>, Suspend2-devel@lists.suspend2.net,
       linux-pm@osdl.org, ncunningham@linuxmail.org
Subject: Re: swsusp and suspend2 like to overheat my laptop
Message-ID: <20060809134211.GA6286@rhlx01.fht-esslingen.de>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com> <Pine.LNX.4.58.0608090732100.2500@gandalf.stny.rr.com> <20060809115843.GB3747@elf.ucw.cz> <200608091415.51226.rjw@sisk.pl> <Pine.LNX.4.58.0608090913480.3560@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0608090913480.3560@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 09:16:30AM -0400, Steven Rostedt wrote:
> 
> On Wed, 9 Aug 2006, Rafael J. Wysocki wrote:
> 
> >
> > If it's a P4, we rather don't, because the ACPI tables should be above the
> > last pfn in the normal zone.  Still, Steven please send your dmesg after a
> > fresh boot.
> >
> 
> Attached is a gzipped version of my dmesg.

This one is fatal:

| ACPI: Found ECDT
| ACPI: Could not use ECDT

And you also have

| ACPI: Processor [CPU0] (supports 4 throttling states)
| ACPI: Processor [CPU1] (supports 4 throttling states)

(IOW, no C2/C3 states listed here)

The buggy ECDT table (see http://www.poupinou.org/acpi/ibm_ecdt.html)
is said to cause ACPI init to fail:
http://t2100cdt.kippona.net/tlinux/archive/linux.toshiba-dme.co.jp/ML/tlinux-users/4300/4396.html
as such it's not too astonishing that you don't have C2/C3 states, *always*
(pre-suspend and post-suspend).

However the machine should still do normal HLT idle loop which should
manage to keep it reasonably cool, right?

Given this ECDT table issue it's very possible that this is the reason for
Linux ACPI layer misbehaviour after resume.

Google "ACPI ECDT" might help, too.

In any case, you could do some kernel logging around pm_idle* in
drivers/acpi/processor_idle.c since I suspect that this is what changes
after resume to cause the idling to fail.

Andreas Mohr
