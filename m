Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWCJBrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWCJBrf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 20:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752159AbWCJBrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 20:47:35 -0500
Received: from smtp-2.llnl.gov ([128.115.3.82]:44447 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S1751404AbWCJBre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 20:47:34 -0500
From: Dave Peterson <dsp@llnl.gov>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] EDAC: core EDAC support code
Date: Thu, 9 Mar 2006 17:46:51 -0800
User-Agent: KMail/1.5.3
Cc: Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, alan@redhat.com, gregkh@kroah.com,
       Doug Thompson <dthompson@lnxi.com>,
       bluesmoke-devel@lists.sourceforge.net
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <200603091551.25097.dsp@llnl.gov> <20060310000227.GA30236@kroah.com>
In-Reply-To: <20060310000227.GA30236@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603091746.51686.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 March 2006 16:02, Greg KH wrote:
> >     1.  /sys/devices/system/edac/mc/mc0/module_name contains two
> >         values, a module name and a version:
> >
> >             # cat /sys/devices/system/edac/mc/mc0/module_name
> >             k8_edac  Ver: 2.0.1.devel Mar  8 2006
>
> Woah.  That's what /sys/modules/ is for right?  Don't add new stuff
> please.

My apologies for my lack of familiarity with how the contents of /sys
are supposed to be laid out.  I'm just looking at what EDAC currently
does, trying to fix what's broken, and in the process learning how
sysfs is supposed to work.

> >         Here we have a whitespace-delimited list of values.  Likewise,
> >         the following files contain whitespace-delimited lists:
> >
> >             /sys/devices/system/edac/mc/mc0/edac_capability
> >             /sys/devices/system/edac/mc/mc0/edac_current_capability
>
> What exactly do they look like?

On the machine I'm currently looking at, here is what I see:

    # cd /sys/devices/system/edac/mc/mc0
    # cat edac_capability
    None SECDED S4ECD4ED
    # cat edac_current_capability
    None
    #

Although edac_current_capability is shown above as having only one
value, it could in principle contain a few values (some subset of
the values contained in edac_capability).

> >     3.  The following files contain comma-delimited lists of
> >         (vendor ID, device ID) tuples:
> >
> >             /sys/devices/system/edac/pci/pci_parity_blacklist
> >             /sys/devices/system/edac/pci/pci_parity_whitelist
>
> What exactly do they look like?

Initially, both files are empty.  If a user writes a list of values
to a file, the file will contain the values that the user wrote.  For
instance, below we create a list containing two
(vendor ID, device ID) tuples:

    # cd /sys/devices/system/edac/pci
    # cat pci_parity_blacklist

    # echo "1022:7450,1434:16a6" > pci_parity_blacklist
    # cat pci_parity_blacklist
    1022:7450,1434:16a6
    #

> >     Issue #1
> >     --------
> >     Fixing this is easy.  /sys/devices/system/edac/mc/mc0/module_name
> >     can be replaced by two separate files, one providing the name and
> >     the other providing the version:
> >
> >         /sys/devices/system/edac/mc/mc0/module_name
> >         /sys/devices/system/edac/mc/mc0/module_version
>
> No, these should just be deleted.  Use the proper MODULE_* macros for
> these if you really want to display them to users.

Ok, I'll make sure they get deleted.

> >     Issue #2
> >     --------
> >     To fix this, /sys/devices/system/edac/mc/mc0/supported_mem_type
> >     can be made into a directory containing a file representing each
> >     supported memory type.  Thus we might have the following:
> >
> >         /sys/devices/system/edac/mc/mc0/supported_mem_type
> >         /sys/devices/system/edac/mc/mc0/supported_mem_type/Unbuffered-DDR
> >         /sys/devices/system/edac/mc/mc0/supported_mem_type/Registered-DDR
> >
> >     In the above example, the files Unbuffered-DDR and Registered-DDR
> >     would each be empty in content.  The presence of each file would
> >     indicate that the memory type it represents is supported.
>
> I don't think the original file is really a big problem.

Ok, so I'll leave this as-is?

> >     Issue #3
> >     --------
> >     I am unclear about what to do here.  If the list contents were
> >     read-only, it would be relatively easy to make
> >     /sys/devices/system/edac/pci/pci_parity_whitelist into a directory
> >     containing symlinks, one for each device.  However, the user is
> >     supposed to be able to modify the list contents.  This would imply
> >     that the user creates and destroys symlinks.  Does sysfs currently
> >     support this sort of behavior?  If not, what is the preferred
> >     means for implementing a user-modifiable set of values?
>
> No it doesn't.  How big can this list get?

It depends on how many PCI devices in your machine you wish to
blacklist or whitelist.  The motivation for this feature is that
certain known badly-designed devices report an endless stream of
spurious PCI bus parity errors.  We want to skip such devices when
checking for PCI bus parity errors.

Eventually we are thinking of maintaining a master list of known
bad hardware.  The list will grow over time as users encounter
and report new instances of flaky devices.  However, the user would
not have to feed the entire list to EDAC.  I can imagine someone
writing a script that behaves as follows:

    1.  Determine the entire set of PCI devices present in the user's
        machine.
    2.  Read the set of known bad hardware from the master list and
        compute the intersection with the set of devices actually
        present in the user's machine.
    3.  Feed the result of step 2 above to EDAC.

