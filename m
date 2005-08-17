Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbVHQFdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbVHQFdK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 01:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbVHQFdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 01:33:09 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:62585 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1750860AbVHQFdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 01:33:08 -0400
X-IronPort-AV: i="3.96,115,1122872400"; 
   d="scan'208"; a="280576955:sNHT34331520"
Date: Wed, 17 Aug 2005 00:33:00 -0500
From: Matt Domsch <Matt_Domsch@Dell.com>
To: Michael_E_Brown@Dell.com
Cc: greg@kroah.com, mrmacman_g4@mac.com, linux-kernel@vger.kernel.org,
       Douglas_Warzecha@Dell.com, Chris Wedgwood <cw@f00f.org>,
       Nathan Lutchansky <lutchann@litech.org>, Valdis.Kletnieks@vt.edu,
       Andrey Panin <pazke@donpac.ru>, Andi Kleen <ak@suse.de>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support
Message-ID: <20050817053259.GA24060@lists.us.dell.com>
References: <4277B1B44843BA48B0173B5B0A0DED43528193@ausx3mps301.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4277B1B44843BA48B0173B5B0A0DED43528193@ausx3mps301.aus.amer.dell.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 06:47:45PM -0500, Michael_E_Brown@Dell.com wrote:
> > From: Greg KH [mailto:greg@kroah.com] 
> > > And just to re-iterate one more time, we can already directly hook 
> > > into
> > > hardware from userspace without any kernel auditing. We are 
> > just trying 
> > > to set this out on the table for everybody to see.
> > 
> > So, this whole driver is not needed at all?  It can all be 
> > done from userspace?  If so, then this shouldn't be added to 
> > the kernel tree.
> 
> Several reasons:
> 
> A) Auditability: we don't do "secret" SMI calls behind people's backs.
> This is an issue for some of our larger customers. This also provides a
> legitimate reason that I can use to justify to management publicly
> documenting the rest of the SMI calls that are not in use by our
> software. Things like: "Hey, SomeBigDellCustomer wants to know what Dell
> is doing with the open source dcdbas driver and all of the other SMI
> function docs" pull a lot of weight.
> 
> B) Safety: It is easier to provide a single API with well defined
> semantics so there are no race conditions when multiple programs try to
> do SMI at the same time. SMI from userspace can be tricky, and I want to
> make it easy to get right. Things like finding an usused BIOS reserved
> area and coordinating access between multiple programs can be difficult.
> Additionally, finding an area large enough to hold everything for the
> larger SMI calls is tricky (ie. depends on which system, BIOS memory
> layout, etc. Very difficult to safely code for and mostly not worth the
> effort if we can get this driver in).
> 
> C) host control actions need to happen in kernel at shutdown, so that
> part of the driver needs to be in the kernel. (this part isn't the part
> that provides generic SMI stuff to userspace)

Indeed, at least a little bit of kernel help is necessary for
allocating coherent physical memory blocks below 4GB for SMI use, and
is the best place to synchronize multiple users of those memory
blocks.  It need not offer much in the kernel, but it need offer at
least that much.  How much more appears to be the subject of the
debate now.

First, let me thank everyone for their time reviewing the code and
providing food for thought.  I value your input greatly.


I've been looking at the suggesions about putting more of the
functionality currently handled in userspace by libsmbios into the
kernel.  It's definitely possible, but I don't like it.  In order of operations:

1) SMBIOS/DMI table parsing for OEM-specific data blocks.  The present
   arch/i386/kernel/dmi_scan.c saves the normally useful information,
   but not OEM-specific data blocks, and the scanning and storing
   functions are all __init.  It could be extended to save more data
   (mostly unused though), or to obtain it again at runtime if needed
   (remove __init), on behalf of the driver.  libsmbios does this
   already without kernel driver help thanks to /dev/mem.

2) Token Discovery.  Many of the tokens don't exist on any given
   system.  For the ones mapped in CMOS, the SMBIOS tables tell you
   which ones exist.  For those mapped by SMIs, there's no structure
   that tells you it exists - you must try it and find out.  This
   would involve an awful lot of SMI calls at driver init time, to do
   discovery and not export files for nonexistent functions, when in
   practice most of the calls won't ever be used.  You could skip the
   discovery and export all the functions as files, many of which
   would be useless on any given platform, and have those return
   -ENOTSUP.  I'd prefer to have a userspace tool show the list of
   potential calls, and return akin to -ENOTSUP when any given call is
   tried but isn't available on that system.  libsmbios does this
   already.

3) Reading/writing the values behind the CMOS/SMI tokens (BIOS F2
   screen for example) requires that the tokens be exported first,
   ideally via sysfs.  In SMBIOS tables, the tokens are identified by
   a number, not by a human-readable string, which is what you'd want
   when naming the entries in sysfs.  The values for each token also
   aren't kept in human-readable strings, but in scalar values.  To be
   useful, you'd need a mapping of token number to name, and token
   value to value name.  You'd need to know the input validation
   routine for each token.  And you'd need to extend this list any
   time a new token is added to any BIOS.  One *could* use the
   request_firmware() to load in a table of these mappings from
   userspace, such that the mapping could be easily extended from
   userspace over time without having to change the driver regularly.
   Alternately, one could follow the PCI new_ids or SCSI
   /proc/scsi/device_info method of adding new token mappings on the
   fly.  libsmbios already provides a mechanism to do this in
   userspace, and it's extensible (edit and load a new config file at
   runtime) in a similar fashion.


So it's not impossible, but it seems like it's adding a whole lot of
code to the kernel, just to properly find and export the tokens.


I heard some fair suggestions:

1) check DMI_SYS_VENDOR and DMI_PRODUCT_NAME at init time to limit the
   driver to work on Dell systems (or those systems which are OEMd
   from Dell).

2) Require the userspace tool to be root to use the interface.  I had
   mentioned this to Doug already, gregkh did as well, and Doug agreed
   to make that change.

3) export appropriate functionality via hwmon.  No problem
   conceptually there.


Some unfair suggestions:

1) this is a SMI hook for userspace.  Sure it is, but root in
   userspace can generate all the SMIs it wants completely independent
   of the kernel to do evil things.  To do things right requires a
   little kernel help as noted above.  The root application requires a
   good bit of trust, but we trust root an awful lot already.  This
   isn't a new capability we're giving root through the kernel module,
   it's a safer capability.

2) if it's exported via sysfs, then userspace tools become easier.
   Yes, this is true, when the information in the kernel is best
   represented and easy to export via sysfs.  In this case though, the
   kernel need not know about the whole token list and which ones work
   on any given platform, what their value mappings are, and what
   their input validation routines must be.  That's complexity best
   left to a trusted root userspace app.


I really see this kernel module as a pass-through mechanism to talk
with hardware in its native language (even if you disagree with the
language).  This is conceptually similar to how SCSI Generic (either
/dev/sg or ioctl(SG_IO)) works (userspace passes in preformated SCSI
CDBs and gets back the resultant CDBs and extended sense data).  The
sg driver doesn't look at the data being passed down to any great
extent.  It doesn't validate that the command will make sense to the
end device.  It *has* validated that the device it's talking to is a
SCSI device (fair suggestion #1 above) before doing so.  But there
isn't a sysfs file for every possible command you can send to each
device.  Userspace tools that care about any given command implement
such.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
