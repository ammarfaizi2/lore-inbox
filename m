Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbVBQNFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVBQNFO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 08:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVBQNFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 08:05:13 -0500
Received: from alog0254.analogic.com ([208.224.222.30]:7040 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262147AbVBQNFA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 08:05:00 -0500
Date: Thu, 17 Feb 2005 08:04:13 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Davide Rossetti <davide.rossetti@roma1.infn.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: rmmod while module is in use
In-Reply-To: <4214926B.3030707@roma1.infn.it>
Message-ID: <Pine.LNX.4.61.0502170757150.15033@chaos.analogic.com>
References: <4214926B.3030707@roma1.infn.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2005, Davide Rossetti wrote:

> maybe RTFM...
> a module:
> - char device driver for..
> - a PCI device
>
> any clue as to how to protect from module unloading while there is still some 
> process opening it??? have I to sleep in the remove_one() pci driver function 
> till last process closes its file descriptor???
>

The kernel code is supposed to prevent module removal when it
is still in use. Have you discovered a bug where the kernel
will allow unloading when it's still being used???

There used to be MOD_INC_USE_COUNT and MOD_DEC_USE_COUNT
macros to be using in open() and close(). However their
use has been depreciated in favor of some internal kernel
magic. So, unless you have discovered a bug, your code
doesn't have to worry anymore.

> static void __devexit apedev_remove_one(struct pci_dev *pdev)
> {
>   ApeDev* apedev = pci_get_drvdata(pdev);
>
>   if(test_bit(APEDEV_FLAG_OPEN, &apedev->flags)) {
>       PERROR("still open flag on!!! (flags=0x%08x)\n", apedev->flags);
>
>       // sleep here till it gets closed...
>
>   }
>   ...
> }
>
> static struct pci_driver apedev_driver = {
>   .name     =  DEVNAME,
>   .id_table =  apedev_pci_tbl,
>   .probe    =  apedev_init_one,
>   .remove   =  __devexit_p(apedev_remove_one),
> };
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
