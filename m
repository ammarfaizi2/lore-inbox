Return-Path: <linux-kernel-owner+w=401wt.eu-S932122AbXAFThR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbXAFThR (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 14:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbXAFThQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 14:37:16 -0500
Received: from 1wt.eu ([62.212.114.60]:1791 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932082AbXAFThP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 14:37:15 -0500
Date: Sat, 6 Jan 2007 20:35:10 +0100
From: Willy Tarreau <w@1wt.eu>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, "J.H." <warthog9@kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>, webmaster@kernel.org
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
Message-ID: <20070106193510.GA32245@1wt.eu>
References: <20061214223718.GA3816@elf.ucw.cz> <20061216094421.416a271e.randy.dunlap@oracle.com> <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain> <20061219063413.GI24090@1wt.eu> <1166511171.26330.120.camel@localhost.localdomain> <20070106103331.48150aed.randy.dunlap@oracle.com> <459FF60D.7080901@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459FF60D.7080901@zytor.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2007 at 11:18:37AM -0800, H. Peter Anvin wrote:
> Randy Dunlap wrote:
> >
> >>>BTW, yesterday my 2.4 patches were not published, but I noticed that
> >>>they were not even signed not bziped on hera. At first I simply thought
> >>>it was related, but right now I have a doubt. Maybe the automatic script
> >>>has been temporarily been disabled on hera too ?
> >>The script that deals with the uploads also deals with the packaging -
> >>so yes the problem is related.
> >
> >and with the finger_banner and version info on www.kernel.org page?
> 
> Yes, they're all connected.
> 
> The load on *both* machines were up above the 300s yesterday, probably 
> due to the release of a new Knoppix DVD.

I have one trivial idea : would it help to use 2 addresses to server data,
one for pure kernel usage (eg: git, rsync) and one with other stuff such
as DVDs, but with a low limit on the number of concurrent connections ?

> The most fundamental problem seems to be that I can't tell currnt Linux 
> kernels that the dcache/icache is precious, and that it's way too eager 
> to dump dcache and icache in favour of data blocks.  If I could do that, 
> this problem would be much, much smaller.

I often have this problem on some of my machines after slocate runs.
Everything is consumed in dcache/icache and no data blocks are cacheable
anymore. I never found a way to tell the kernel to assign a higher prio
to data than to [di]cache. To remedy this, I wrote this stupid program that
I run when I need to free memory. It does simply allocate the memory size
I ask, which causes a flush of the [di]caches, and when it exits, this
memory is usable again for data blocks. 

I'm not sure it would be easy to automatically run such a thing, but
maybe it could sometimes help when the [id]caches are too fat.

Willy

#include <stdio.h>
main(int argc, char **argv) {
  unsigned long int i,k=0, max;
  char *p;

  max = (argc>1) ? atol(argv[1]) : 102400; // default to 100 MB
  printf("Allocating %lu kB...\n",max);
  while (((p=(char *)malloc(1048576))!=NULL) && (k+1024<=max)) {
    for (i=0;i<256;p[4096*i++]=0); /* mark block dirty */
    k+=1024;
    fprintf(stderr,"\r%d kB allocated",k);
  }
  fprintf(stderr,"\nMemory freed.\n");
  exit(0);
}

