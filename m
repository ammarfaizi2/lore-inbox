Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWE3Qwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWE3Qwd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 12:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWE3Qwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 12:52:33 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:58238 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932325AbWE3Qwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 12:52:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DiwRRghilvkGHIDh/Z1PvJXoYFFghr0Br5zKXPo5v+92IpWdN/mMcOiFdRUPjjaaiRRCMqZjCR0hdl4XzQvEnbpJRf/PLpSmhnoZwWXili8Yvy7IDWN13ddD2Joq8FTIBPWh/QrfPKZinGzgLCcPL7bzszioNpMni0f51BwQcsc=
Message-ID: <9e4733910605300952v1cf56beasc2a907cc77b8a09f@mail.gmail.com>
Date: Tue, 30 May 2006 12:52:31 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Greg KH" <gregkh@suse.de>
Subject: Re: searching for pci busses
Cc: "Jeff Garzik" <jgarzik@pobox.com>, "Greg KH" <greg@kroah.com>,
       "Jiri Slaby" <jirislaby@gmail.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20060530163821.GC7146@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4478DCF1.8080608@gmail.com> <20060529214753.GD10875@kroah.com>
	 <447B6ECB.9080207@pobox.com> <20060530163821.GC7146@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/06, Greg KH <gregkh@suse.de> wrote:
> On Mon, May 29, 2006 at 05:59:39PM -0400, Jeff Garzik wrote:
> > Greg KH wrote:
> > >On Sun, May 28, 2006 at 01:12:26AM +0159, Jiri Slaby wrote:
> > >>Hello,
> > >>
> > >>I want to ask, if there is any function to call (as we debated with
> > >>Jeff), which
> > >>does something like this:
> > >>1) I have some vendor/device ids in table
> > >>2) I want to traverse raws of the table and compare to system devices,
> > >>and if
> > >>found, stop and return pci_dev struct (or raw in the table).
> > >
> > >What's wrong with pci_match_id()?
> > >
> > >Or just using the pci_register_driver() function properly, which handles
> > >all of this logic for you?
> >
> > These aren't PCI devices proper.  These are embedded non-PCI devices,
> > which must search for an unrelated PCI device to figure out what type of
> > platform they are on.
>
> Ok, then use pci_match_id() or pci_get_device().

This is how DRM does it...

        for (i = 0; driver->pci_driver.id_table[i].vendor != 0; i++) {
                pid = (struct pci_device_id *)&driver->pci_driver.id_table[i];

                pdev = NULL;
                /* pass back in pdev to account for multiple identical cards */
                while ((pdev =
                        pci_get_subsys(pid->vendor, pid->device, pid->subvendor,
                                       pid->subdevice, pdev)) != NULL) {
                        /* stealth mode requires a manual probe */
                        pci_dev_get(pdev);
                        drm_get_dev(pdev, pid, driver);
                }
        }
        return 0;


-- 
Jon Smirl
jonsmirl@gmail.com
