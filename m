Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265271AbUGCVps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265271AbUGCVps (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 17:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265275AbUGCVps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 17:45:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:8347 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265271AbUGCVpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 17:45:44 -0400
Date: Sat, 3 Jul 2004 14:45:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Hellwig <hch@lst.de>
cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: current BK compilation failure on ppc32
In-Reply-To: <20040703185606.GA4718@lst.de>
Message-ID: <Pine.LNX.4.58.0407031439240.15998@ppc970.osdl.org>
References: <20040703185606.GA4718@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Jul 2004, Christoph Hellwig wrote:
> 
> kernel/power/smp.c seems to be inherently swsusp-specific but is
> compiled for CONFIG_PM. (Same seems to be true for amny other files
> in kernel/power/, but as they compile it only causes bloat..)
> 
> 
> --- 1.10/kernel/power/Makefile	2004-07-02 07:23:47 +02:00
> +++ edited/kernel/power/Makefile	2004-07-03 22:07:29 +02:00
> @@ -1,5 +1,7 @@
>  obj-y				:= main.o process.o console.o pm.o
> +ifeq ($(CONFIG_SOFTWARE_SUSPEND), y)
>  obj-$(CONFIG_SMP)		+= smp.o
> +endif

Don't do it like that.

Instead, do something like

	smp-power-$(CONFIG_SMP)	+= smp.o
	obj-$(CONFIG_SOFTWARE_SUSPEND) += $(smp-power-y)

which not only is shorter, but gets a _lot_ more readable after a while.

It's also extremely useful for constructs like "include this file X is
either 'y' or 'm'". From fs/Makefile:

	..

	nfsd-$(CONFIG_NFSD)             := nfsctl.o
	obj-y                           += $(nfsd-y) $(nfsd-m)

	..

which just means that "nfsctl.o" will be compiled in if nfsd is 
compiled-in or a module.

You can make pretty complex decision trees this way - much more readably 
than by explicit comparisons.

		Linus
