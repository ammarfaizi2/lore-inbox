Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129459AbQKIRdO>; Thu, 9 Nov 2000 12:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129551AbQKIRdD>; Thu, 9 Nov 2000 12:33:03 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:17932 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129501AbQKIRc6>;
	Thu, 9 Nov 2000 12:32:58 -0500
Message-ID: <3A0ADFA7.516C7F0@mandrakesoft.com>
Date: Thu, 09 Nov 2000 12:32:23 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@caldera.de>
CC: David Ford <david@linux.com>, LKML <linux-kernel@vger.kernel.org>,
        nils@kernelconcepts.de
Subject: Re: OOPS loading cs46xx module, test11-pre1
In-Reply-To: <200011091239.NAA05580@ns.caldera.de> <3A0AD8B5.9BB73A7D@mandrakesoft.com> <20001109181716.A25109@caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> On Thu, Nov 09, 2000 at 12:02:45PM -0500, Jeff Garzik wrote:
> > > I have an (untested) update for the cs46xx driver in Linux 2.4.
> > > It includes Nils' 2.2 changes, use of initcalls (so compiled-in
> > > should work) and use of the 2.4 PCI interface.
> >
> > Patch Generally looks ok.  Comments:
> >
> > 1) This code is weird:
> > >                if (copy_to_user(buffer, dmabuf->rawbuf + swptr, cnt)) {
> > >-                       if (!ret) ret = -EFAULT;
> > >-                       return ret;
> > >+                       if (!ret)
> > >+                               ret = -EFAULT;
> > >+                       break;
> > >                }
> >
> > If you have an error condition (ret != 0), then you should not attempt
> > the copy_to_user at all.
> > If you do not have an error condition, you should unconditionally assign
> > -EFAULT to 'ret'.
> 
> Makes sense. But I did not change the logic at all ...
> Ask the Author (Alan or Nils) what this is about.

Now that I have looked at the code around it, it looks ok.  It returns
the bytes copied to userspace so far, like a good read function should.

> > 6) remove check for pci_present(), redundant
> 
> Lot's of pci drivers do this.  Anyway I will removed this in the next version.

It's been redundant since the 2.1.x days, maybe even before that.  There
-might- be a rare case where a driver really needs to check for the
presence of a PCI BIOS.  Maybe.  But for all cases where you have

	if (!pci_present()) probe_pci=0;
	/* ... */
	if (probe_pci) {
		pci_register_driver(...)
			or
		pdev = pci_find_device(...);
	}

you can remove the pci_present check.  All PCI probe functions return
sane values in the absence of PCI support (or PCI devices).

> > of course for cs46xx, you will want to keep the version printk...
> > 
> > 8) xxx_MODULE_NAME was a dumb and overly-lengthy creation of mine.  Use
> > instead MODNAME.
> 
> It doesn't really matter ...

besides perpetuating a bad idea, that is.

	Jeff


-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
