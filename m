Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291969AbSBTQcp>; Wed, 20 Feb 2002 11:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291970AbSBTQcZ>; Wed, 20 Feb 2002 11:32:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44816 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291969AbSBTQcR>;
	Wed, 20 Feb 2002 11:32:17 -0500
Message-ID: <3C73CF85.E3DA3943@mandrakesoft.com>
Date: Wed, 20 Feb 2002 11:32:05 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Phillips <mikep@linuxtr.net>
CC: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] New driver 3Com 3C359 Tokenring Velocity XL
In-Reply-To: <Pine.LNX.4.10.10202181451060.4149-100000@www.linuxtr.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied to 2.4 and 2.5.  I removed the definition of
PCI_DEVICE_xxx from the top of 3c359.h...

Comments:
1) buggy use of PCI DMA API -- you should use memory returned from
pci_alloc_consistent, do not directly map memory created by
alloc_trdev() nor depend on the alignment returned by alloc_trdev()

2) support for ETHTOOL_GDRVINFO ioctl
3) support for ETHTOOL_[GS]MSGLVL ioctls... this implies that
'message_level' would only serve as a default for a value that can be
changed per-interface

4) ideally "\n" should not be in MODULE_DESCRIPTION

5) style: no need to cast to/from a void pointer, such as
	> struct xl_private *xl_priv = (struct xl_private *)dev->priv ;

6) hardcoded magic numbers for PKT_BUF_SZ limits (100 and 18000)

7) xl_probe duplicates error handling code... use the standard kernel
style of multiple goto targets, one for each needed stage of
cleanup-after-error:

	err_out3:
		pci_release_regions(pdev)
	err_out2:
		kfree(dev)
	err_out:
		return rc;

8) in  xl_hw_reset, you probably want to call yield [in 2.5] or
schedule_timeout

9) jiffies comparison bug: never directly compare jiffies, use
time_before() or time_after()

10) in xl_open, return the error value returned by request_irq, on error

11) same comment for xl_open as #7

12) xl_wait_misr_flags needs to call yield() or -something-, don't just
empty loop.  cpu_relax(), for example, if you cannot schedule...

Overall... good job, it's a readable, clean driver.

	Jeff




-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
