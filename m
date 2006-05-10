Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWEJKQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWEJKQN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 06:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWEJKQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 06:16:13 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:61633 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S964884AbWEJKQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 06:16:12 -0400
Message-ID: <4461BD6C.7020509@vc.cvut.cz>
Date: Wed, 10 May 2006 12:16:12 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] matroxfb_maven gcc 4.1 warning fix
References: <200605100256.k4A2u2wo031725@dwalker1.mvista.com>
In-Reply-To: <200605100256.k4A2u2wo031725@dwalker1.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> It looks possible that the PLL and clock functions might get into a condition
> when these stack variables would get used/returned with uninitialized
> data . So it needs further review ..

May I veto this?  Please fix gcc instead, it does its analysis incorrectly.
matroxfb_PLL_mavenclock either returns 0, or initializes all arguments it gets (if
not, then please show me code path which returns non-zero and does not set
h2/post/in/feed).  And matroxfb_mavenclock either returns EINVAL, or sets *post.
And a,b & h2 are used in maven_find_exact_clocks() are used only if
matroxfb_mavenclock returned 0 - and in this case a,b & h2 were always set.

						Thanks,
							Petr Vandrovec


> Fixes the following warning,
> 
> drivers/video/matrox/matroxfb_maven.c: In function 'maven_out_compute':
> drivers/video/matrox/matroxfb_maven.c:287: warning: 'p' may be used uninitialized in this function
> drivers/video/matrox/matroxfb_maven.c:718: warning: 'h2' may be used uninitialized in this function
> drivers/video/matrox/matroxfb_maven.c:718: warning: 'b' may be used uninitialized in this function
> drivers/video/matrox/matroxfb_maven.c:718: warning: 'a' may be used uninitialized in this function

P.S.: It is off-topic for LKML, but this one is my favorite, it comes from
ncpfs I maintain...

vana:/usr/src/hg/ncpfs/lib# cat test.c
#include <pthread.h>
#include <stdio.h>

pthread_mutex_t nds_ring_lock;

extern int test(void);

static int __NWCCGetServerAddressPtr(int* count) {
         if (test()) {
                 return 1;
         }
         *count = 0;
         return 0;
}

void NWDXFindConnection(void) {
         int connaddresses;
         int err2;

         pthread_mutex_lock(&nds_ring_lock);
         err2 = __NWCCGetServerAddressPtr(&connaddresses);
         pthread_mutex_unlock(&nds_ring_lock);
         if (err2)
                 return;
         printf("ConnAddress is uninitialized? %u\n", connaddresses);
}


vana:/usr/src/hg/ncpfs/lib# gcc -v -O2 -W -c test.c
Using built-in specs.
Target: i486-linux-gnu
Configured with: ../src/configure -v --enable-languages=c,c++,java,f95,objc,ada,treelang --prefix=/usr --enable-shared --with-system-zlib --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --enable-nls --program-suffix=-4.0 --enable-__cxa_atexit --enable-clocale=gnu --enable-libstdcxx-debug --enable-java-awt=gtk-default --enable-gtk-cairo --with-java-home=/usr/lib/jvm/java-1.4.2-gcj-4.0-1.4.2.0/jre --enable-mpfr --disable-werror --with-tune=i686 --enable-checking=release i486-linux-gnu
Thread model: posix
...
gcc version 4.0.4 20060422 (prerelease) (Debian 4.0.3-2)
GNU C version 4.0.4 20060422 (prerelease) (Debian 4.0.3-2) (i486-linux-gnu)
         compiled by GNU C version 4.0.4 20060422 (prerelease) (Debian 4.0.3-2).
GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
test.c: In function 'NWDXFindConnection':
test.c:17: warning: 'connaddresses' may be used uninitialized in this function

