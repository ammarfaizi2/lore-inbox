Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130148AbQKIRRw>; Thu, 9 Nov 2000 12:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130152AbQKIRRm>; Thu, 9 Nov 2000 12:17:42 -0500
Received: from ns.caldera.de ([212.34.180.1]:39954 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130148AbQKIRRh>;
	Thu, 9 Nov 2000 12:17:37 -0500
Date: Thu, 9 Nov 2000 18:17:16 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: David Ford <david@linux.com>, LKML <linux-kernel@vger.kernel.org>,
        nils@kernelconcepts.de
Subject: Re: OOPS loading cs46xx module, test11-pre1
Message-ID: <20001109181716.A25109@caldera.de>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	David Ford <david@linux.com>, LKML <linux-kernel@vger.kernel.org>,
	nils@kernelconcepts.de
In-Reply-To: <200011091239.NAA05580@ns.caldera.de> <3A0AD8B5.9BB73A7D@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <3A0AD8B5.9BB73A7D@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Nov 09, 2000 at 12:02:45PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2000 at 12:02:45PM -0500, Jeff Garzik wrote:
> > I have an (untested) update for the cs46xx driver in Linux 2.4.
> > It includes Nils' 2.2 changes, use of initcalls (so compiled-in
> > should work) and use of the 2.4 PCI interface.
> 
> Patch Generally looks ok.  Comments:
> 
> 1) This code is weird:
> >                if (copy_to_user(buffer, dmabuf->rawbuf + swptr, cnt)) {
> >-                       if (!ret) ret = -EFAULT;
> >-                       return ret;
> >+                       if (!ret)
> >+                               ret = -EFAULT;
> >+                       break;
> >                }
> 
> If you have an error condition (ret != 0), then you should not attempt
> the copy_to_user at all.
> If you do not have an error condition, you should unconditionally assign
> -EFAULT to 'ret'.

Makes sense. But I did not change the logic at all ...
Ask the Author (Alan or Nils) what this is about.

> 2) this patch enabled cs_mmap, and removes a check for vma->vm_offset !=
> 0.  Also that is clearly 2.2.x code, simply removing the check is
> wrong.  You should replace the check with one that checks vma->vm_pgoff
> != 0.

Sorry, forgot to add this back in the patch I sent.

> 3) is there method or madness to the delay changes?  they are not
> explained, just changed...

Not shure.  This was accepted in 2.2.18pre, so it should be sane.


> 4) cs_probe is marked __init but cs_remove is marked __devexit.  on
> hotplug, cs_probe simply doesn't exist in the kernel anymore... boom.

Ok, should be fixed.

> 5) there is no need to appear zeroes to the end of these cs_pci_tbl
> entries.  Just end each with "PCI_ANY_ID,"...
> +       { PCI_VENDOR_ID_CIRRUS, 0x6001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0
> },
> +       { PCI_VENDOR_ID_CIRRUS, 0x6003, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0
> },
> +       { PCI_VENDOR_ID_CIRRUS, 0x6004, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0
> },

That's true.  But i think it looks cleaner if all members are present.

> 6) remove check for pci_present(), redundant

Lot's of pci drivers do this.  Anyway I will removed this in the next version.

> 7) use pci_module_init for hotplug. quite simply:
> 
> 	init_module() { return pci_module_init(&my_driver); }

Ok.

> of course for cs46xx, you will want to keep the version printk...
> 
> 8) xxx_MODULE_NAME was a dumb and overly-lengthy creation of mine.  Use
> instead MODNAME.

It doesn't really matter ...

	Christoph


-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
