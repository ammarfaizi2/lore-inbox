Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbUCVEeH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 23:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbUCVEeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 23:34:07 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:39315
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261686AbUCVEeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 23:34:03 -0500
Date: Mon, 22 Mar 2004 05:34:54 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drop O_LARGEFILE from F_GETFL for POSIX compliance
Message-ID: <20040322043454.GL3649@dualathlon.random>
References: <20040322051318.597ad1f9.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040322051318.597ad1f9.ak@suse.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 05:13:18AM +0100, Andi Kleen wrote:
> 
> On 64bit architectures open() sets O_LARGEFILE implicitely. This causes the LSB
> testsuite to fail, which checks that F_GETFL only returns the flags set by 
> a previous open.
> 
> According to the POSIX standards gurus the Linux behaviour is not compliant.
> 
> This patch fixes this by just not reporting O_LARGEFILE in F_GETFL.
> 
> This has been in several shipping SuSE releases and the x86-64.org CVS
> treee for a long time, so is unlikely to break anything.
> 
> -Andi
> 
> diff -burpN -X ../KDIFX linux-2.4.26-pre5/fs/fcntl.c linux-merge/fs/fcntl.c
> --- linux-2.4.26-pre5/fs/fcntl.c	2004-01-13 10:29:17.000000000 +0100
> +++ linux-merge/fs/fcntl.c	2003-10-23 15:40:52.000000000 +0200
> @@ -271,7 +271,7 @@ static long do_fcntl(unsigned int fd, un
>  			set_close_on_exec(fd, arg&1);
>  			break;
>  		case F_GETFL:
> -			err = filp->f_flags;
> +			err = filp->f_flags & ~O_LARGEFILE;
>  			break;
>  		case F_SETFL:
>  			lock_kernel();
> -

in my 2.4 tree I have this one instead (written in oct 2002):

--- x/fs/fcntl.c.~1~	Wed Oct 16 17:26:27 2002
+++ x/fs/fcntl.c	Wed Oct 16 17:27:43 2002
@@ -277,7 +277,11 @@ static long do_fcntl(unsigned int fd, un
 			set_close_on_exec(fd, arg&1);
 			break;
 		case F_GETFL:
+#if BITS_PER_LONG != 32
+			err = filp->f_flags & ~O_LARGEFILE;
+#else
 			err = filp->f_flags;
+#endif
 			break;
 		case F_SETFL:
 			err = setfl(fd, filp, arg);


32bit archs needs to get O_LARGEFILE in return from getfl (if they set
it [it's not set implicitly in 32bit archs] they will be able to handle
it transparently in glibc too, and I believe they really want it). 64bit
archs not, hence the fix.
