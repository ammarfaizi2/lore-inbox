Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752085AbWCJACm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbWCJACm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbWCJACm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:02:42 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:8406 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1752085AbWCJACl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:02:41 -0500
Date: Thu, 9 Mar 2006 16:02:27 -0800
From: Greg KH <greg@kroah.com>
To: Dave Peterson <dsp@llnl.gov>
Cc: Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, alan@redhat.com, gregkh@kroah.com,
       Doug Thompson <dthompson@lnxi.com>,
       bluesmoke-devel@lists.sourceforge.net
Subject: Re: [PATCH] EDAC: core EDAC support code
Message-ID: <20060310000227.GA30236@kroah.com>
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <200603070903.19226.dsp@llnl.gov> <1141758219.3048.10.camel@laptopd505.fenrus.org> <200603091551.25097.dsp@llnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603091551.25097.dsp@llnl.gov>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 03:51:25PM -0800, Dave Peterson wrote:
> On Tuesday 07 March 2006 11:03, Arjan van de Ven wrote:
> > afaics it is a list of pci devices. these should just be symlinks to the
> > sysfs resource of these pci devices instead, not a flat table file.
> 
> Ok, I'm looking at the EDAC sysfs interface.  I see the following
> issues concerning the "one value per file" rule:
> 
>     1.  /sys/devices/system/edac/mc/mc0/module_name contains two
>         values, a module name and a version:
> 
>             # cat /sys/devices/system/edac/mc/mc0/module_name
>             k8_edac  Ver: 2.0.1.devel Mar  8 2006

Woah.  That's what /sys/modules/ is for right?  Don't add new stuff
please.

>     2.  /sys/devices/system/edac/mc/mc0/supported_mem_type contains
>         the following on the machine I am looking at:
> 
>             # cat /sys/devices/system/edac/mc/mc0/supported_mem_type
>             Unbuffered-DDR Registered-DDR
>             #
> 
>         Here we have a whitespace-delimited list of values.  Likewise,
>         the following files contain whitespace-delimited lists:
> 
>             /sys/devices/system/edac/mc/mc0/edac_capability
>             /sys/devices/system/edac/mc/mc0/edac_current_capability

What exactly do they look like?

>     3.  The following files contain comma-delimited lists of
>         (vendor ID, device ID) tuples:
> 
>             /sys/devices/system/edac/pci/pci_parity_blacklist
>             /sys/devices/system/edac/pci/pci_parity_whitelist

What exactly do they look like?

>         I assume this is what Arjan is referring to.
>         Documentation/drivers/edac/edac.txt gives the following
>         description of how the whitelist functions:
> 
>             This control file allows for an explicit list of PCI
>             devices to be scanned for parity errors. Only devices
>             found on this list will be examined.  The list is a line
>             of hexadecimel VENDOR and DEVICE ID tuples:
> 
>             1022:7450,1434:16a6
> 
>             One or more can be inserted, seperated by a comma.
>             To write the above list doing the following as one
>             command line:
> 
>             echo "1022:7450,1434:16a6"
>                     > /sys/devices/system/edac/pci/pci_parity_whitelist
> 
>             To display what the whitelist is, simply 'cat' the same
>             file.
> 
> Looking at the current EDAC implementation, these are all of the
> "one value per file" issues I see.  If anyone sees any others I
> missed, please let me know.  Here are my thoughts on each:
> 
>     Issue #1
>     --------
>     Fixing this is easy.  /sys/devices/system/edac/mc/mc0/module_name
>     can be replaced by two separate files, one providing the name and
>     the other providing the version:
> 
>         /sys/devices/system/edac/mc/mc0/module_name
>         /sys/devices/system/edac/mc/mc0/module_version

No, these should just be deleted.  Use the proper MODULE_* macros for
these if you really want to display them to users.

>     Issue #2
>     --------
>     To fix this, /sys/devices/system/edac/mc/mc0/supported_mem_type
>     can be made into a directory containing a file representing each
>     supported memory type.  Thus we might have the following:
> 
>         /sys/devices/system/edac/mc/mc0/supported_mem_type
>         /sys/devices/system/edac/mc/mc0/supported_mem_type/Unbuffered-DDR
>         /sys/devices/system/edac/mc/mc0/supported_mem_type/Registered-DDR
> 
>     In the above example, the files Unbuffered-DDR and Registered-DDR
>     would each be empty in content.  The presence of each file would
>     indicate that the memory type it represents is supported.

I don't think the original file is really a big problem.

>     Issue #3
>     --------
>     I am unclear about what to do here.  If the list contents were
>     read-only, it would be relatively easy to make
>     /sys/devices/system/edac/pci/pci_parity_whitelist into a directory
>     containing symlinks, one for each device.  However, the user is
>     supposed to be able to modify the list contents.  This would imply
>     that the user creates and destroys symlinks.  Does sysfs currently
>     support this sort of behavior?  If not, what is the preferred
>     means for implementing a user-modifiable set of values?

No it doesn't.  How big can this list get?

thanks,

greg k-h
