Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263283AbTDGGf4 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 02:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263284AbTDGGf4 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 02:35:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23567 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263283AbTDGGfy (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 02:35:54 -0400
Date: Mon, 7 Apr 2003 07:47:22 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, linux-kernel@vger.kernel.org
Subject: Re: correct to set -nostdinc and then include <stdarg.h> ?
Message-ID: <20030407074722.A9367@flint.arm.linux.org.uk>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	Chris Friesen <cfriesen@nortelnetworks.com>,
	linux-kernel@vger.kernel.org
References: <3E910172.8030406@nortelnetworks.com> <23076.1049692512@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <23076.1049692512@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Mon, Apr 07, 2003 at 03:15:12PM +1000
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 03:15:12PM +1000, Keith Owens wrote:
> On Mon, 07 Apr 2003 00:41:22 -0400, 
> Chris Friesen <cfriesen@nortelnetworks.com> wrote:
> >
> >I was trying to compile 2.5.66 with gcc 3.2.2.  It dies as soon as it tries to 
> >compile init/main.c because it is unable to find "stdarg.h" which is included by 
> >"include/linux/kernel.h".

stdarg.h is part of the compiler specific includes.  We want to pick
up on these, so we use "-iwithprefix include" to add the compiler specific
includes back.

Unfortunately, there seems to be something wrong with GCC's ability to
determine where these includes really reside when GCC is installed in
a different location to the one it was configured with.  In other words,
don't do that.  Install GCC to the location where you told it to be
installed.

For instance, on a Red Hat machine, try:

# cp /usr/bin/gcc /usr/local/bin
# hash -r
# touch t.c
# gcc -nostdinc -iwithprefix include -v t.c
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
 /usr/lib/gcc-lib/i386-redhat-linux/2.96/cpp0 -lang-c -nostdinc -v -iprefix
  /usr/local/bin/../lib/gcc-lib/i386-redhat-linux/2.96/ -D__GNUC__=2
  -D__GNUC_MINOR__=96 -D__GNUC_PATCHLEVEL__=0 -D__ELF__ -Dunix -Dlinux
  -D__ELF__ -D__unix__ -D__linux__ -D__unix -D__linux -Asystem(posix)
  -D__NO_INLINE__ -Acpu(i386) -Amachine(i386) -Di386 -D__i386 -D__i386__
  -D__tune_i386__ -iwithprefix include t.c
GNU CPP version 2.96 20000731 (Red Hat Linux 7.2 2.96-112.7.2) (cpplib)
  (i386 Linux/ELF)
ignoring nonexistent directory "/usr/local/lib/gcc-lib/i386-redhat-linux/2.96/include"
#include "..." search starts here:
End of search list.
# rm /usr/local/bin/gcc
# hash -r

and note that it fails.

> Try this:

>From a quick look at the patch, doesn't this mean that we re-evaluate
the search directory each time we build the compiler?  Would it not
be better to cache the result ?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

