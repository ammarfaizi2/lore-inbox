Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWG2VlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWG2VlI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 17:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWG2VlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 17:41:08 -0400
Received: from rune.pobox.com ([208.210.124.79]:26761 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S932245AbWG2VlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 17:41:07 -0400
Date: Sat, 29 Jul 2006 16:40:31 -0500
From: Nathan Lynch <ntl@pobox.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm][resend] Disable CPU hotplug during suspend
Message-ID: <20060729214031.GP19076@localdomain>
References: <200607281015.30048.rjw@sisk.pl> <200607282115.45407.rjw@sisk.pl> <20060728224028.GK19076@localdomain> <200607291418.32366.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607291418.32366.rjw@sisk.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> On Saturday 29 July 2006 00:40, Nathan Lynch wrote:
> 
> > But maybe I'm misunderstanding the motivation for using cpu 0 here.  I
> > had assumed it was because on i386 (and others?) the BSP can't be
> > offlined.  Is there some other reason?
> 
> Yes.
> 
> First, the arch-dependent suspend code assumes implicitly that it will be
> running on the BSP, so some strange things may happen if it doesn't.
> 
> Second, we have to make sure that this function will always leaves the
> same CPU online.  It's a bit difficult to explain, but I'll do my best.
> Suppose that disable_nonboot_cpus() exits running on CPU1, assuming it's
> possible.  Then the system memory state saved in the suspend image will
> reflect this situation.  Now the resume code will almost certainly run on the
> BSP (say it's CPU0), but when the system memory is restored from the suspend
> image the kernel will think it's running on CPU1.
> 
> In the last patch I send yesterday I made disable_nonboot_cpus() check if the
> first present CPU, first_cpu(cpu_present_map), is online, try to bring it up
> if not and migrate itself to it before the loop over all online CPUs is run.
> 
> I think that's general enough.

I see, thanks for the explanation.

It doesn't look like SMP swsusp would work reliably on platforms where
there's a possibility of the cpu maps in the resume and saved images
not matching (e.g. ppc64 logical partitions, where cpu 0 could be
removed before suspending).  But I guess that's largely a theoretical
concern at this time. ;)

