Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129105AbQKIREB>; Thu, 9 Nov 2000 12:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129239AbQKIRDl>; Thu, 9 Nov 2000 12:03:41 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:21259 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129181AbQKIRDV>;
	Thu, 9 Nov 2000 12:03:21 -0500
Message-ID: <3A0AD8B5.9BB73A7D@mandrakesoft.com>
Date: Thu, 09 Nov 2000 12:02:45 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@caldera.de>
CC: David Ford <david@linux.com>, LKML <linux-kernel@vger.kernel.org>,
        nils@kernelconcepts.de
Subject: Re: OOPS loading cs46xx module, test11-pre1
In-Reply-To: <200011091239.NAA05580@ns.caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have an (untested) update for the cs46xx driver in Linux 2.4.
> It includes Nils' 2.2 changes, use of initcalls (so compiled-in
> should work) and use of the 2.4 PCI interface.

Patch Generally looks ok.  Comments:

1) This code is weird:
>                if (copy_to_user(buffer, dmabuf->rawbuf + swptr, cnt)) {
>-                       if (!ret) ret = -EFAULT;
>-                       return ret;
>+                       if (!ret)
>+                               ret = -EFAULT;
>+                       break;
>                }

If you have an error condition (ret != 0), then you should not attempt
the copy_to_user at all.
If you do not have an error condition, you should unconditionally assign
-EFAULT to 'ret'.

There is code like this around calls to copy_{to,from}_user and
signal_pending that I see at a quick glance.


2) this patch enabled cs_mmap, and removes a check for vma->vm_offset !=
0.  Also that is clearly 2.2.x code, simply removing the check is
wrong.  You should replace the check with one that checks vma->vm_pgoff
!= 0.

3) is there method or madness to the delay changes?  they are not
explained, just changed...

4) cs_probe is marked __init but cs_remove is marked __devexit.  on
hotplug, cs_probe simply doesn't exist in the kernel anymore... boom.

5) there is no need to appear zeroes to the end of these cs_pci_tbl
entries.  Just end each with "PCI_ANY_ID,"...
+       { PCI_VENDOR_ID_CIRRUS, 0x6001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0
},
+       { PCI_VENDOR_ID_CIRRUS, 0x6003, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0
},
+       { PCI_VENDOR_ID_CIRRUS, 0x6004, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0
},

6) remove check for pci_present(), redundant

7) use pci_module_init for hotplug. quite simply:

	init_module() { return pci_module_init(&my_driver); }

of course for cs46xx, you will want to keep the version printk...

8) xxx_MODULE_NAME was a dumb and overly-lengthy creation of mine.  Use
instead MODNAME.


-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
