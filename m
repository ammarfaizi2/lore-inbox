Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbTFGSzc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 14:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbTFGSzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 14:55:31 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:42219
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S263375AbTFGSz2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 14:55:28 -0400
Date: Sat, 7 Jun 2003 15:09:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [PATCH] ethtool_ops
Message-ID: <20030607190904.GA3346@gtf.org>
References: <C6F5CF431189FA4CBAEC9E7DD5441E010107D8CD@orsmsx402.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E010107D8CD@orsmsx402.jf.intel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 06, 2003 at 01:17:46PM -0700, Feldman, Scott wrote:
> > Right now, each network driver which supports the ethtool 
> > ioctl has its own implementation of everything from decoding 
> > which ethtool ioctl it is, copying data to and from 
> > userspace, marshalling and unmarshalling data from ethtool 
> > packets, etc.  The current setup makes it impossible to use 
> > alternative interfaces to get at the same data (eg sysfs) and 
> > it's not exactly typesafe.
> 
> This is really cool!  Thanks for doing this Matthew.

Indeed.  :)


> Some questions:
> 
> * On get_gregs, for example, would it make sense to ->get_drvinfo
>   so you'll know regdump_len and therefore can kmalloc an ethtool_regs
>   with enough space to pass to ->get_regs?  Keep the kmalloc and
>   kfree together.  Same for self_test, get_strings, and get_stats.
>   For get_strings, size = max{n_stats, testinfo_len)*sizeof(u64).

Yes, absolutely.

There is a bug in some of the arch ioctl32 translation layers
that just assumes the ethtool output can fit inside a single page.
Prior to Matthew's work, the ioctl32 layer needed to directly issue
ETHTOOL_GDRVINFO ioctl to obtain this information.  Now, the ioctl32
layer can directly call ->get_drvinfo.  This is what the drvinfo
information is designed to be used for.

Hooks being able to call ->get_drvinfo (and perhaps a couple others)
is an important and useful attribute.


> * If the above is done, can we have one function type for the
> ethtool_ops
>   functions?  int f(struct netdev *, struct ethtool_cmd *).  The 
>   drawback is the driver needs to cast to the specific ethtool_* struct.

I disagree:  prefer the increased type checking and lack of type
casting.  We already have net/core/ethtool.c having a separate call-it
function for each hook... and each of those functions needs to know
the specific subcommand struct type _anyway_ to copy in the struct
from userspace, so let's go ahead and propagate the type information.

Typically in Linux we want to preserve as much type information as
possible.  Less work for the compiler, less potential aliasing problems,
and discourages type mistakes in the low-level driver.


> * Can we get an HAVE_ETHTOOL_OPS defined in netdevice.h to support
>   backward compat?

heh, I suggested this independently, too.

	Jeff



