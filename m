Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbVCKIu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbVCKIu4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 03:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbVCKIu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 03:50:56 -0500
Received: from ozlabs.org ([203.10.76.45]:29569 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262606AbVCKIuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 03:50:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16945.23578.505529.220972@cargo.ozlabs.ibm.com>
Date: Fri, 11 Mar 2005 19:51:38 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com
Cc: anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64 NUMA memory fixup
In-Reply-To: <20050310023613.23499386.akpm@osdl.org>
References: <16942.30144.513313.26103@cargo.ozlabs.ibm.com>
	<20050310023613.23499386.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> This patch causes the non-numa G5 to oops very early in boot in
> smp_call_function().

Hmmm, the reason we are getting into smp_call_function is that we have
panicked due to not being able to allocate boot memory.  It's kind of
sad that we can't even panic successfully, although this is very
early: we haven't got through setup_arch yet.  The immediate reason
for the panic is that smp_ops is uninitialized.  We seem to be looking
at smp_ops because num_online_cpus() is not 1; I assume it is 0 at
this point.

Anyway, the ultimate reason seems to be that the numa.c code is
assuming that an address value and a size value occupy the same number
of cells.  On the G5 we have #address-cells = 2 but #size-cells = 1.
Previously this didn't matter because we used the values in lmb.memory
for the free_bootmem_node calls.  Those values are obtained in prom.c
by scanning the memory nodes, using the correct number of cells.  With
Mike's patch we rely instead on the values obtained by the numa.c
code, which uses read_cell_ul() for both address and size values, and
that just uses prom_n_size_cells() to know how many cells to parse.
It really needs to use prom_n_addr_cells() when parsing an address
value.

Paul.
