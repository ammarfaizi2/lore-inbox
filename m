Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264670AbUE0PFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264670AbUE0PFV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 11:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264625AbUE0PFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 11:05:21 -0400
Received: from h001061b078fa.ne.client2.attbi.com ([24.91.86.110]:28804 "EHLO
	linuxfarms.com") by vger.kernel.org with ESMTP id S264673AbUE0PFG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 11:05:06 -0400
Date: Thu, 27 May 2004 11:05:29 -0400 (EDT)
From: Arthur Perry <kernel@linuxfarms.com>
X-X-Sender: kernel@tiamat.perryconsulting.net
To: linux-kernel@vger.kernel.org
Subject: Re: GART error 11 (fwd)
Message-ID: <Pine.LNX.4.58.0405271103350.18743@tiamat.perryconsulting.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a posting that I dropped off in RedHat's amd64-list.
It is a kernel related issue, so if anybody has any insight or opinion of
proper implementation here, please jump in!

Thanks.

Arthur Perry
Lead Linux Developer / Linux Systems Architect
Validation, CSU Celestica
Sair/Linux Gnu Certified Professional
Providing professional Linux solutions for 7+ years

---------- Forwarded message ----------
Date: Thu, 27 May 2004 11:02:10 -0400 (EDT)
From: Arthur Perry <amd64@linuxfarms.com>
To: amd64-list@redhat.com
Cc: kernel@linuxfarms.com
Subject: Re: GART error 11

Hi Dave,

I am getting the same problem here, not only with RedHat's 2.4.21-9.0.1EL kernel, but also with SuSE Enterprise 8.0.
What I have found is that RedHat has AGP support built into the kernel, and is not a module that can be loaded/unloaded.
If your server does not have an AGP bus (as most servers do not), obviously the driver shouldn't do anything.
However, this is not the case.

After some test, it appears that the errors go away if you recompile the kernel without AGP support.

Here is my proposed "root cause":
If you boot the stock RedHat kernel, you will find that the GART ARPERTURE CONTROL REGISTER (function 3, offset 0x90) is enabled.
If you do not have an AGP bus, this does not make sense to set up and configure.
The errors that you see are captured by the Machine Check Architecture (MCA).
The Northbridge portion is responsible for capturing these specific errors, and its global enable is in the MCG_CTL register located at MSR 0x017b.
Your BIOS will be the one who enables this. You may even have an option for enabling or disabling the MCA.
You also can set this in userspace.
Anyways, I digress..

The object here is to not set up the GART if you do not have an AGP bus.
If the AGP driver is built into the kernel, this whole portion should be skipped. Not just the initialization of the particular AGP bus. This register (function 3, offset 0x90) should not be configured.

What I am going to do is test to see if this problem manifests itself with the mainline Linux code. If it does not appear, then I know there just may be a patch that has not been incorperated into the mainline distributions.
This can be easily fixed.
If it still exists, then I know that it is a implemenation issue that exists in the mainline kernel, and this is why all distributions would be affected.

The question really comes down to:
Is this problem an oversight of the distributors (silly! the agp driver should not be built into the kernel for server use!)
or
Kernel code implementation? (well, if no agp bus is present, then let's not go and set up the GART, right?)



Thoughts?


Best Regards,
Art Perry




On Wed, Nov 12, 2003 at 11:44:48AM -0500, Owen Scott Medd wrote:
 > We've just put RHEL3 AS on a newisys 2100 dual opteron (246 cpus) with
 > 16GB of PC2100 memory, a megaraid controller and the internal mptfusion
 > controller.  Every so often, seemingly coincident with I/O load on the
 > megaraid controller, we get the following error:
 >
 >    Northbridge status a40000000005001b
 >    GART error 11
 >    Lost an northbridge error
 >    NB error address 00000000fbf60000
 >    Error uncorrected
 >
 > The disk writes *appear* okay (we haven't found any errors so far) but
 > I'm not sure what these mean.

These are machine check exceptions. Typically hardware errors.
Run memtest, check cooling, PSU etc..

		Dave


-- 
AMD64-list mailing list
AMD64-list@xxxxxxxxxx
https://www.redhat.com/mailman/listinfo/amd64-list

