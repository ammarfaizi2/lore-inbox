Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132471AbREIVIg>; Wed, 9 May 2001 17:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132482AbREIVI0>; Wed, 9 May 2001 17:08:26 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:65191 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132471AbREIVIP>;
	Wed, 9 May 2001 17:08:15 -0400
Message-ID: <3AF9B1BF.A6BCCCE2@mandrakesoft.com>
Date: Wed, 09 May 2001 17:08:15 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Roskin <proski@gnu.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch to make ymfpci legacy address 16 bits
In-Reply-To: <Pine.LNX.4.33.0105091627440.5113-100000@fonzie.nine.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Roskin wrote:
> 
> Hi, Jeff!
> 
> Thanks for your very (!!!) fast response :-)
> 
> > > http://www.red-bean.com/~proski/linux/ymfpci_pm.diff
> >
> > Why not use pci_driver::{suspend,resume} ?
> 
> I'm just a bit conservative. There are several drivers that don't use this
> mechanism, notably trident and maestro. Do you think it's safe to switch
> all sound drivers to the mechanism you are proposing?
> 
> I'm worried about a comment in maestro.c:
> 
>                 /*
>                  * we'd also like to find out about
>                  * power level changes because some biosen
>                  * do mean things to the maestro when they
>                  * change their power state.
>                  */
> 
> If we switch to pci_driver::{suspend,resume}, will it ever be possible to
> add support for any messages other than PM_SUSPEND and PM_RESUME? Probably
> yes, but only in the PCI driver dispatches them.

Basically the PCI core should implement what PM is necessary, because
eventually struct pci_driver will become a more generic struct driver. 
When that happens, drivers using pci_driver::{suspend,resume} will
automagically work under the new system.  To answer your question, the
PCI[/driver] core should support messages other than PM_{SUSPEND,RESUME}
if they need to be supported.  Right now I mostly see suspend/resume
implemented and nothing else, so that is a very straightforward
conversion to the new PCI API.

Why does maestro.c not use my suggestion?  Because it doesn't use struct
pci_driver.
Why does trident.c not use my suggestion?  Only because noone has
written and tested the patch for it yet :)  It uses struct pci_driver
and should be updated to use ::suspend/resume.

> > In ACPI land the kernel should save and restore the PCI device config
> > space and the PCI bus config space.  It is probably that similar is
> > necessary under APM.
> 
> I have never seen any sound driver doing that. I also know that PCI
> settings are saved by some BIOSes on some hardware.

That's because full PM support is still very much a work in progress :) 
The linux-pm-devel sourceforge list has carried recent discussions, as
has linux-kernel.  Patrick Mochel(sp?) @ Transmeta has posted a
hackers-only patch which incorporates my PCI PM work as well as his own
ACPI work to do suspend and resume.

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
