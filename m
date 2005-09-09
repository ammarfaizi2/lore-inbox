Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbVIIKmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbVIIKmX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 06:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbVIIKmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 06:42:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14723 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030221AbVIIKmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 06:42:22 -0400
Date: Fri, 9 Sep 2005 03:41:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: mbligh@mbligh.org, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: 2.6.13-mm2
Message-Id: <20050909034153.51203f9e.akpm@osdl.org>
In-Reply-To: <20050909003947.GE19913@wotan.suse.de>
References: <20050908053042.6e05882f.akpm@osdl.org>
	<73450000.1126189801@[10.10.2.4]>
	<20050909003947.GE19913@wotan.suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
>  > arch/x86_64/pci/built-in.o(.init.text+0xa88): In function `pci_acpi_scan_root':
>  > : undefined reference to `pxm_to_node'
>  > make: *** [.tmp_vmlinux1] Error 1
>  > 09/08/05-06:52:31 Build the kernel. Failed rc = 2
>  > 09/08/05-06:52:31 build: kernel build Failed rc = 1
>  > 09/08/05-06:52:31 command complete: (2) rc=126
>  > Failed and terminated the run
> 
>  I tried the config in my (non mm) tree and it compiled just fine.

You must have mucked it up.

>  Must be some bad interaction with another patch in -mm* or a bad 
>  merge.

Nope.

>  The original patch that introduces it is
>  ftp://ftp.firstfloor.org/pub/ak/x86_64/x86_64-2.6.13-1/patches/pci-pxm
> 
>  pxm_to_node for x86-64 is supposed to be declared in arch/x86_64/mm/srat.c

pxm_to_node is *defined* in arch/x86_64/mm/srat.c, which is enabled by
CONFIG_ACPI_NUMA.

pxm_to_node is declared in include/asm-x86_64/numa.h

pxm_to_node is referenced in arch/i386/pci/acpi.c, under CONFIG_NUMA.

Consequently CONFIG_ACPI_NUMA=n, CONFIG_NUMA=y will fail to link.

Also x86 compilation of arch/i386/pci/acpi.c with CONFIG_NUMA=y will
generate an `implicit declaration of function' warning and will fail to
link.



Also, x86_64-srat-overlap-error.patch adds this forward decl in
arch/x86_64/mm/srat.c:

int node_to_pxm(int n);

Please, either give it static scope or, if it really needs global scope (it
doesn't), put the declaration in the right place?
