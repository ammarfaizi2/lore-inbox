Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbUJZLGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbUJZLGa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 07:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbUJZLGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 07:06:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34763 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262221AbUJZLGM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 07:06:12 -0400
Date: Tue, 26 Oct 2004 06:32:54 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Andrei A. Voropaev" <av@simcon-mt.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cyclades.h in 2.6.9 use __iomem but don't include compiler.h
Message-ID: <20041026083254.GB24462@logos.cnet>
References: <20041025154645.GB1105@avorop.local> <20041025195342.GC23133@logos.cnet> <20041026063233.GA7598@avorop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026063233.GA7598@avorop.local>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 08:32:33AM +0200, Andrei A. Voropaev wrote:
> On Mon, Oct 25, 2004 at 05:53:43PM -0200, Marcelo Tosatti wrote:
> > On Mon, Oct 25, 2004 at 05:46:45PM +0200, Andrei A. Voropaev wrote:
> > > Hi!
> > > 
> > > I'm not sure if this is a bug or a feature. But in 2.6.9 cyclades.h have
> > > different definition for struct cyclades_card. This definition uses
> > > __iomem attribute which is defined in linux/compiler.h. This is not
> > > included in cyclades.h, which leads to compilation problems for
> > > util-linux package.
> > 
> > Hi Andrei,
> > 
> > cyclades.h should not do business with util-linux, only
> > the driver itself (cyclades.c) and the userspace configuration 
> > utility (which now includes should linux/compiler.h accordingly 
> > to define __iomem to NULL).
> 
> Well. All I know is that util-linux has cytune utility that does not
> compile with 2.6.9 kernel headers. But compiles with older ones.

Ah, that was news to me! 

I didnt knew the existant of such tool. Pardon me.

> > What is the complete error message, and why is util-linux 
> > including cyclades.h?
> > 
> 
> Here's the error message.
> 
> cc -O2 -fomit-frame-pointer -I../lib -Wall  -Wstrict-prototypes -DNCH=1   -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\" -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\" -DLOCALEDIR=\"/usr/share/locale\" -O2 -c cytune.c -o cytune.o
> cytune.c:58:86: linux/tqueue.h: No such file or directory
> In file included from cytune.c:61:
> /usr/include/linux/cyclades.h:514: error: variable or field `__iomem' declared void
> /usr/include/linux/cyclades.h:514: error: parse error before '*' token
> /usr/include/linux/cyclades.h:515: error: parse error before '*' token
> /usr/include/linux/cyclades.h:528: error: parse error before '}' token
> make[1]: *** [cytune.o] Error 1
> make[1]: Leaving directory `/tools/src/util-linux-2.12b/sys-utils'
> make: *** [all] Error 1
> 
> The first problem with linux/tqueue.h happens because during config it
> tries to do it with only cyclades.h and fails on __iomem. So it decides
> to include tqueue.h. Only to make things worse.
> 
> Here's the patch that I had to apply.

That works.

Can you send this patch to the util-linux maintainer?

> diff -ur util-linux-2.12b/configure util-linux-2.12b-adj/configure
> --- util-linux-2.12b/configure  2004-08-25 02:32:19.000000000 +0200
> +++ util-linux-2.12b-adj/configure      2004-10-25 19:43:29.259856848 +0200
> @@ -367,6 +367,7 @@
>  #
>  echo "
>  #include <sys/types.h>
> +#include <linux/compiler.h>
>  #include <linux/cyclades.h>
>  int main(){ exit(0); }
>  " > conftest.c
> diff -ur util-linux-2.12b/sys-utils/cytune.c util-linux-2.12b-adj/sys-utils/cytune.c
> --- util-linux-2.12b/sys-utils/cytune.c 2002-03-09 00:04:30.000000000 +0100
> +++ util-linux-2.12b-adj/sys-utils/cytune.c     2004-10-25 19:44:27.892943264 +0200
> @@ -58,6 +58,7 @@
>  #include <linux/tqueue.h>      /* required for old kernels (for struct tq_struct) */
>                                 /* compilation errors on other kernels */
>  #endif
> +#include <linux/compiler.h>
>  #include <linux/cyclades.h>
>  
>  #if 0
