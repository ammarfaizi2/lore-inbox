Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbTD3WJw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 18:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbTD3WJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 18:09:51 -0400
Received: from granite.he.net ([216.218.226.66]:17157 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262479AbTD3WJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 18:09:44 -0400
Date: Wed, 30 Apr 2003 15:24:07 -0700
From: Greg KH <greg@kroah.com>
To: Matt Domsch <Matt_Domsch@Dell.com>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org, jgarzik@redhat.com
Subject: Re: [RFC][PATCH] Dynamic PCI Device IDs
Message-ID: <20030430222407.GB25006@kroah.com>
References: <Pine.LNX.4.44.0304301640450.8917-100000@humbolt.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304301640450.8917-100000@humbolt.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First off, nice idea, but I think the implementation needs a bit of
work.

On Wed, Apr 30, 2003 at 04:45:14PM -0500, Matt Domsch wrote:
>   
>   One may read the new_id file, which by default returns:
>   $ cat new_id
>   echo vendor device subvendor subdevice class classmask
>   where each field is a 32-bit value in ABCD (hex) format (no leading 0x).
>   Pass only as many fields as you need to override the defaults below.
>   Default vendor, device, subvendor, and subdevice fields
>   are set to FFFFFFFF (PCI_ANY_ID).
>   Default class and classmask fields are set to 0.

Ick, don't put help files within the kernel image.  Didn't you take them
all out for the edd patch a while ago?  :)

Just make it a write only file.

>   One can then cause the driver to probe for devices again.
>   echo 1 > probe_it

Why wouldn't the writing to the new_id file cause the probe to happen
immediatly?  Why wait?  So I think we can get rid of that file.

Also, do we really need to keep a list of id's visible to userspace (the
"0" file above?  We currently don't do that for the "static ids" (yeah I
know they are easily extracted from the module image...)

>   Individual device drivers may override the behavior of the new_id
>   file, for instance, if they need to also pass driver-specific
>   information.  Likewise, reading the individual dynamic ID files
>   can be overridden by the driver.

Why would a driver want to override these behaviors?

>   This also adds an existance test field to struct driver_attribute,
>   necessary because we only want the probe_it file to appear iff
>   struct pci_driver->probe is non-NULL.

Is that the exists() callback?  Is it really needed?  Can't the pci core
do this without needing to push that logic into the driver core?  After
all, it knows if the pci_driver->probe() call is non-NULL, the driver
core doesn't.

Also, we really need a generic way to easily create subdirectories
within the driver model, to keep you from having to dive down into
kobjects and the mess, like you had to do here.  Pat's said he will work
on this next, once he emerges from his OLS paper writing hole, and
there's even a bug assigned to him for this:
	http://bugme.osdl.org/show_bug.cgi?id=650
Once that is in, this patch should clean up a whole lot.  I'd recommend
waiting for that (or if you want to tackle it, please do) before
applying something like your patch.

Sound ok?

thanks,

greg k-h
