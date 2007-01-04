Return-Path: <linux-kernel-owner+w=401wt.eu-S964899AbXADPQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbXADPQ3 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 10:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbXADPQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 10:16:28 -0500
Received: from hera.kernel.org ([140.211.167.34]:45840 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964890AbXADPQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 10:16:27 -0500
From: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: /usr/include/*/acpi.h
Date: Thu, 4 Jan 2007 10:15:45 -0500
User-Agent: KMail/1.9.5
Cc: Thorsten Kukuk <kukuk@suse.de>, Thomas Renninger <trenn@suse.de>,
       linux-acpi@vger.kernel.org, pbaudis@suse.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200701031552.37919.lenb@kernel.org> <20070104104945.GA31430@suse.de> <459CDEB0.5040302@linux.intel.com>
In-Reply-To: <459CDEB0.5040302@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701041015.45525.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>> Why do the following files appear in OpenSuse 10.2?
> >>>
> >>> $ find /usr/include -name '*acpi*'
> >>> /usr/include/asm/acpi.h
> >>> /usr/include/asm-x86_64/acpi.h
> >>> /usr/include/asm-i386/acpi.h
> >>> /usr/include/linux/acpi.h
> >>> /usr/include/linux/pci-acpi.h
> >>>
> >>> They are not present on a Fedora Core 6 system.
> >>>       
> >> No idea. I never used them and I don't know any user space tool using
> >> them.
> >>
> >>  What is the reason you ask this for, do you get name clashes with other
> >>  programs, should they get reverted for cleanup reasons?

Cleanup reasons.
I want to know what the constraints are for who sees what header.

Right now we have some issues with all kinds of ACPICA core-internal stuff being
exported to the rest of the kernel.  Makes sense to think about what is
exported to user-space while thinking about it -- and I just happened
to notice that OS and FC are different here.

> > This header files are part of the linux kernel, and thus of course
> > available in /usr/include/{asm,linux}.

So you pick up all of the kernel include/linux and include/asm*?
(but exclude include/acpi/, which is as much a kernel header as the above)

What in user-space looks at linux/*.h and what kind of stuff should we
be exporting there -- or not exporting there?

linux/acpi.h has its entire contents inside #ifdef CONFIG_ACPI
and Fedora Core ships without it -- so it seems a pretty safe bet that
if anything in user-space is using it, then it must be pretty obscure.
ACPI is, after-all, a kernel/BIOS interface -- and to the extent that we expose
it to user-space we have certainly failed to abstract it.

I don't see any harm in user-space seeing linux/acpi.h, but I also see no benefit.
We could delete it, but we could not delete the asm/acpi.h files which
are equally useless to user-space.

I'm thinking that we should move the core internal stuff (most of include/acpi/)
under drivers/acpi where only the core can see it. (2.4 did it this way, as so
lots of drivers in 2.6) Perhaps linux/acpi.h should be the place where non-core
parts of the Linux kernel pick up what they need to know to talk to the ACPI sub-system.

Unclear what to do about visibility to user-space.
I don't see us wanting to export anything, so the goal is to not pollute user-space
as cleanly as possible.

-Len
