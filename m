Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290755AbSBFTN2>; Wed, 6 Feb 2002 14:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290756AbSBFTNZ>; Wed, 6 Feb 2002 14:13:25 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:33391 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S290755AbSBFTNF>; Wed, 6 Feb 2002 14:13:05 -0500
Date: Wed, 6 Feb 2002 14:13:04 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: zaitcev@redhat.com
Subject: The IBM order relaxation patch
Message-ID: <20020206141304.A9349@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I had a look at an IBM patch, which is described thus:

  - Order 2 allocation relief

  Symptom:  Under stress and after long uptimes of a 64 bit system
            the error message "__alloc_pages: 2-order allocation failed."
            appears and either the fork of a new process fails or an
            active process dies.

  Problem:  The order 2 allocation problem is based in the size of the
            region and segement tables as defined by the zSeries
            architecture. A full region or segment table in 64 bit mode
            takes 16 KB of contigous real memory. The page allocation
            routines do not guarantee that a higher order allocation
            will succeed due to memory fragmentation.

  Solution: The order 2 allocation fix is supposed to reduce the number
            of order 2 allocations for the region and segment tables to
            a minimum. To do so it uses a feature of the architecture
            that allows to create incomplete region and segment tables.
            In almost all cases a process does not need full region or
            segment tables. If a full region or segment table is needed
            it is reallocated to the full size.

  This patch is very s/390 specific and breaks all other architectures.
  <<they meant "zSeries specific", surely --zaitcev>>

It's a stupid question, but: why can we not simply
wait until a desired unfragmented memory area is available,
with a GPF flag? What they describe does not happen in an
interrupt context, so we can sleep.

And another one: why not to increase a kernel-visible or "soft"
page size to 16KB for zSeries? It's a 64 bits platform. There
will be some increase in fragmentation, but nobody measured it.
Perhaps it's not going to be severe. It may even improve paging
efficiency.

-- Pete

P.S. The patch itself is at:
 http://www10.software.ibm.com/developerworks/opensource/linux390/alpha_src/linux-2.4.7-order2-3.tar.gz
