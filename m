Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271374AbTHMVUI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 17:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275606AbTHMVUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 17:20:08 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:49363 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S271374AbTHMVTi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 17:19:38 -0400
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: C99 Initialisers
References: <jFFu.7t8.15@gated-at.bofh.it> <jLKX.4KI.13@gated-at.bofh.it>
	<jRnj.2dx.11@gated-at.bofh.it> <jRwZ.2kJ.15@gated-at.bofh.it>
	<jRQi.2zQ.5@gated-at.bofh.it> <jRZY.2Hw.5@gated-at.bofh.it>
	<jS9J.2Np.5@gated-at.bofh.it> <jUbt.57S.7@gated-at.bofh.it>
	<jUuT.5kZ.13@gated-at.bofh.it> <k13k.22O.3@gated-at.bofh.it>
	<k7Lq.7Gr.7@gated-at.bofh.it>
From: junkio@cox.net
Date: Wed, 13 Aug 2003 14:19:36 -0700
In-Reply-To: <k7Lq.7Gr.7@gated-at.bofh.it> (Greg KH's message of "Wed, 13
 Aug 2003 19:40:08 +0200")
Message-ID: <7v7k5hw907.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "GKH" == Greg KH <greg@kroah.com> writes:

GKH> How about this patch?  If you like it I'll add the pci.h change to the
GKH> tree and let you take the tg3.c part.

Two comments:

GKH> ...
GKH> +	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5704S) },
GKH> +	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5702A3) },
GKH> +	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5703A3) },
GKH> ...

GKH> +#define PCI_DEVICE(vend,dev) \
GKH> +	.vendor = (vend), .device = (dev), \
GKH> +	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
 
 (1) If .subvendor and .subdevice are always PCI_ANY_ID, are
     there any reason to keep them in the structure in the first
     place?  I imagine there are some devices but not in the
     tg3_pci_tbl list that need to have different values there,
     but if that is the case we may want to generalize the macro
     PCI_DEVICE like this:

        #define PCI_DEVICE(vend, dev) \
            PCI_DEVICE_WITH_SUB(vend, dev, PCI_ANY_ID, PCI_ANY_ID)
        #define PCI_DEVICE_WITH_SUB(vend, dev, subv, subd) \
         .vendor = (vend), \
         .device = (dev), \
         .subvendor = (subv), \
         .subdevice = (subd)

 (2) PCI_VENDOR_ID_ and PCI_DEVICE_ID_ seem to be common prefix,
     so how about doing something like this?

     #define PCI_DEVICE(vend,dev) \
         .vendor = (PCI_VENDOR_ID_ ## vend), \
         .device = (PCI_DEVICE_ID_ ## dev), \
         .subvendor = PCI_ANY_ID, \
         .subdevice = PCI_ANY_ID

     Then the table becomes much shorter:

     static struct pci_device_id tg3_pci_tbl[] = {
     ...
       { PCI_DEVICE(BROADCOM, TIGON3_5700) },
       { PCI_DEVICE(BROADCOM, TIGON3_5701) },
     ...


    PCI_DEVICE_ID_xxx definitions for some devices that
    currently lack them need to be added, of course,
    e.g. SYSKONNECT 0x4400.

