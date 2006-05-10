Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWEJFQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWEJFQl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 01:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWEJFQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 01:16:41 -0400
Received: from lixom.net ([66.141.50.11]:34763 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S964785AbWEJFQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 01:16:40 -0400
Date: Wed, 10 May 2006 00:16:50 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
Message-ID: <20060510051649.GD1794@lixom.net>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060126
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 02:03:59PM +1000, Paul Mackerras wrote:
> With this patch, 64-bit powerpc uses __thread for per-cpu variables.

Nice! I like the way you hid the slb functions so they can't ever be
called by mistake from C code. :-)

This patch a ppc64_defconfig vmlinux a bit (with the other two percpu
patches):

olof@quad:~/work/linux/powerpc $ ls -l vmlinux.pre vmlinux
-rwxr-xr-x 1 olof olof 10290928 2006-05-09 23:48 vmlinux.pre
-rwxr-xr-x 1 olof olof 10307499 2006-05-09 23:50 vmlinux
olof@quad:~/work/linux/powerpc $ size vmlinux.pre vmlinux
   text    data     bss     dec     hex filename
5554034 2404256  480472 8438762  80c3ea vmlinux.pre
5578866 2384944  498848 8462658  812142 vmlinux

Looks like alot of the text growth is from the added mfsprg3 instructions:

$ objdump -d vmlinux.pre | egrep mfsprg.\*,3\$ | wc -l
26
$ objdump -d vmlinux | egrep mfsprg.\*,3\$ | wc -l
5134

... so, as the PACA gets deprecated, the bloat will go away again.

> The motivation for doing this is that getting the address of a per-cpu
> variable currently requires two loads (one to get our per-cpu offset
> and one to get the address of the variable in the .data.percpu
> section) plus an add.  With __thread we can get the address of our
> copy of a per-cpu variable with just an add (r13 plus a constant).

It would be interesting to see benchmarks of how much it improves
things. I guess it doesn't really get interesting until after the paca
gets removed though, due to the added mfsprg's.


-Olof
