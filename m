Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbTJENBM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 09:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263105AbTJENBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 09:01:12 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:27652 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S263102AbTJENBJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 09:01:09 -0400
Date: Sun, 5 Oct 2003 15:00:44 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: andersen@codepoet.org, linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: iproute2 not compiling anymore
Message-ID: <20031005130044.GA8861@pcw.home.local>
References: <Pine.LNX.4.44.0310050940160.27815-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310050940160.27815-100000@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, all,

On Sun, Oct 05, 2003 at 09:42:30AM -0300, Marcelo Tosatti wrote:
> In previous messages you said iproute used to compile on "olders" 2.4.x 
> kernel but doesnt compile anymore on recent 2.4. Is that information 
> correct ? 
> 
> Can you tell me in more detail what is failing?

Just tested, and I confirm this too :

gcc -D_GNU_SOURCE -O2 -Wstrict-prototypes -Wall -g -I../include-glibc -I/usr/include/db3 -include ../include-glibc/glibc-bugs.h -I/
sr/src/linux/include -I../include -DRESOLVE_HOSTNAMES   -c -o ip.o ip.c
In file included from ../include-glibc/netinet/in.h:7,
                 from ip.c:23:
/usr/src/linux/include/linux/in.h:141: field `gr_group' has incomplete type
/usr/src/linux/include/linux/in.h:147: field `gsr_group' has incomplete type
/usr/src/linux/include/linux/in.h:148: field `gsr_source' has incomplete type
/usr/src/linux/include/linux/in.h:154: field `gf_group' has incomplete type
/usr/src/linux/include/linux/in.h:157: field `gf_slist' has incomplete type
make[1]: *** [ip.o] Error 1
make[1]: Leaving directory `/data/src/net/ip-routing/iproute2-2.4.7-020116/ip'
make: *** [all] Error 2

These fields are of type 'struct sockaddr_storage' :

struct group_source_req
{
        __u32                   gsr_interface;  /* interface index */
        struct sockaddr_storage gsr_group;      /* group address */
        struct sockaddr_storage gsr_source;     /* source address */
};

But sockaddr_storage is defined in socket.h within such a #if :

#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)

So it is clear that compiling with such headers on a recent libc outside the
kernel may fail. I don't know what changed exactly, the #if or
sockaddr_storage declaration.

BTW, wouldn't it be interesting to have some sort of way to bypass these
checks when we know that we want to compile against kernel headers ? I
encountered the case for arptables a few weeks ago. I find it very dirty to
add -D__KERNEL__ to user-space makefiles, and I don't find it logical to rebuild
a libc with pre-release kernel headers either.

So perhaps something like this would be useful for a limited set of userspace
programs :
  #if defined(__KERNEL__) || defined(REALLY_USE_KHDR) || !defined(__GLIBC__)...

Then, the affected programs could simply add a '#define REALLY_USE_KHDR' line
before including particular headers.

Any ideas ?
Willy

