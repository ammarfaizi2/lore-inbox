Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbUCLPWU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 10:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbUCLPWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 10:22:20 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:60905 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262190AbUCLPWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 10:22:07 -0500
To: Troy Benjegerdes <hozer@hozed.org>
Cc: linux-kernel@vger.kernel.org, infiniband-general@lists.sourceforge.net
Subject: Re: ANNOUCE: OpenIB InfiniBand software
References: <52znavp2mk.fsf@topspin.com> <52brn9wv04.fsf@topspin.com>
	<20040312033307.GA797@kalmia.hozed.org>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 12 Mar 2004 07:22:04 -0800
In-Reply-To: <20040312033307.GA797@kalmia.hozed.org>
Message-ID: <52wu5qhyzn.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 12 Mar 2004 15:22:04.0342 (UTC) FILETIME=[C626E560:01C40845]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Troy> Since the openib.org mailing lists don't seem to be alive
    Troy> yet, I'll bring this up here..

    Troy> Can we get this split out into the following components?
    Troy> * kernel level infiniband access layer
    Troy> * lowlevel hardware driver (aka mellanox driver)
    Troy> * all other 'upper layer protocols'

Right now, in the infiniband-kernel package, the Mellanox driver is
under drivers/infiniband/hw/mellanox-hca, the 'upper layer protocols'
are under drivers/infiniband/ulp, and the 'access layer' is everything
else in drivers/infiniband.  I'm not sure it's worth rolling three
packages for that split right now.

    Troy> All the existing code has big problems with how it
    Troy> interfaces to the kernel memory management.. it doesn't use
    Troy> the regular interfaces like get_user_pages, pci_map_page,
    Troy> and pci_map_sq, and goes and looks at the guts of the
    Troy> pagetables directly.

    Troy> This is either a problem with the kernel interfaces made
    Troy> available, or a design issue with the existing
    Troy> codebases. Can someone please tell me which it is?

I would say both.  Certainly the HCA driver code could have been
written much more cleanly.  However, it's not clear how the right way
to handle the memory management requirements of kernel bypass/RDMA
protocols, especially since the driver tries to support kernels all
the way back to the ancient 2.4.9 used by Red Hat AS 2.1 (which
doesn't even have get_user_pages()).

In any case, it's why I put the following items in the TODO list
of my announcement:

    * Use DMA mapping API so we work properly with non-coherent
      caches, IOMMUs etc. Add a function to get struct device * for an
      IB device so ULPs can call sync functions (embed struct device
      in struct ib_device?). (How do we handle systems with limited
      DMA mapping capacity?)

    * In Mellanox HCA driver, clean up mosal. Some obvious
      targets (there's lots more though):
          o Grunging through kernel code to find the mlock/munlock
            pointers especially has to go (mosal_mlock.c). We need to
            get VM experts from LKML to tell us how to handle memory
            translation and locking.
