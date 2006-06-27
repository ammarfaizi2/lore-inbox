Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWF0MTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWF0MTl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWF0MTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:19:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:14853 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932335AbWF0MTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:19:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BrRqNZhnUPEYMJFTVoA7KffGEmaDCXVMYiM5XVT0lhM8pJ171WiG8qDF5bPlAWs0pcNAPlGBjguhf1gwgc0EeHM4QSiJUiCUjn6HDp/51IVglETUJmYmh8PbRn4DUI/Ri7gbLJu2cWSYobxwBmh+NA7NxOujoyjGsPH/kEYKpGQ=
Message-ID: <625fc13d0606270519wc506fsa7b1c7e55044ec78@mail.gmail.com>
Date: Tue, 27 Jun 2006 07:19:37 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Greg KH" <gregkh@suse.de>
Subject: Re: pciehp borkage.
Cc: "Dave Jones" <davej@redhat.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060627042750.GA1768@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060627033749.GB26575@redhat.com> <20060627042750.GA1768@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/06, Greg KH <gregkh@suse.de> wrote:
> On Mon, Jun 26, 2006 at 11:37:49PM -0400, Dave Jones wrote:
> > My head hurts..
> >
> > drivers/pci/pcie/Kconfig ..
> >
> > config HOTPLUG_PCI_PCIE
> >     tristate "PCI Express Hotplug driver"
> >     depends on HOTPLUG_PCI && PCIEPORTBUS && (BROKEN || ACPI)
> >
> >
> >
> > but drivers/pci/hotplug/Makefile has..
> >
> > pciehp-objs     :=  pciehp_core.o   \
> >                 pciehp_ctrl.o   \
> >                 pciehp_pci.o    \
> >                 pciehp_hpc.o
> >
> > So it gets built regardless of the option, which leaves ppc (among others)
> > totally busted..
>
> Yes, this driver does have issues on ppc, see the archives for Anton
> trying to fix it up to get it to build.  But as ppc currently doesn't
> _have_ pci express hotplug hardware it really doesn't matter much :)
>
> > In file included from include/acpi/platform/acenv.h:140,
> >                  from include/acpi/acpi.h:54,
> >                  from drivers/pci/hotplug/pciehp_hpc.c:41:
> > include/acpi/platform/aclinux.h:59:22: error: asm/acpi.h: No such file or directory
> > In file included from include/acpi/acpi.h:55,
> >                  from drivers/pci/hotplug/pciehp_hpc.c:41:
> > include/acpi/actypes.h:129: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'UINT64'
> > include/acpi/actypes.h:130: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'INT64'
> > make[3]: *** [drivers/pci/hotplug/pciehp_hpc.o] Error 1
> > make[2]: *** [drivers/pci/hotplug] Error 2
> > make[1]: *** [drivers/pci] Error 2
> >
> >
> > Should that Makefile be more along the lines of..
> >
> > pciehp-$(CONFIG_PCI_PCIE)     :=  pciehp_core.o   \
> >                 pciehp_ctrl.o   \
> >                 pciehp_pci.o    \
> >                 pciehp_hpc.o
> >
> > perhaps ?
>
> No, look up a bit higher:
>         obj-$(CONFIG_HOTPLUG_PCI_PCIE)          += pciehp.o
>
> which will build pciehp or not.  Just don't enable the option for now
> on ppc please.  Until people sanitize the ACPI headers for non-acpi
> arches (which is currently underway...)

Would it be sane to make the Kconfig refuse to enable the option for
archs that this is known to be broken on?

josh
