Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311211AbSCPX5l>; Sat, 16 Mar 2002 18:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311212AbSCPX5V>; Sat, 16 Mar 2002 18:57:21 -0500
Received: from NEVYN.RES.CMU.EDU ([128.2.145.6]:40832 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S311211AbSCPX5S>;
	Sat, 16 Mar 2002 18:57:18 -0500
Date: Sat, 16 Mar 2002 18:54:43 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Paul Menage <pmenage@ensim.com>
Cc: Paul Gortmaker <p_gortmaker@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Speedup SMP kernel on UP box
Message-ID: <20020316185443.A2171@nevyn.them.org>
Mail-Followup-To: Paul Menage <pmenage@ensim.com>,
	Paul Gortmaker <p_gortmaker@yahoo.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <0C01A29FBAE24448A792F5C68F5EA47D238DE0@nasdaq.ms.ensim.com> <E16mNjq-0002xW-00@pmenage-dt.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16mNjq-0002xW-00@pmenage-dt.ensim.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 03:37:26PM -0800, Paul Menage wrote:
> In article <0C01A29FBAE24448A792F5C68F5EA47D238DE0@nasdaq.ms.ensim.com>,
> you write:
> >@@ -9,9 +9,15 @@
> >  */
> > 
> > #ifdef CONFIG_SMP
> >-#define LOCK "lock ; "
> >+#define LOCK "\n1:\tlock ; "
> >+#define LOCK_ADDR	"\n" \
> >+			".section .lock.init,\"a\"\n\t" \
> >+			".align 4\n\t" \
> >+			".long 1b\n" \
> >+			".previous\n"
> 
> 
> Why not do:
> 
> #define LOCK "1: lock ; \n" \
> 	 	".section .lock.init,\"a\"\n" \
> 		".align 4\n"\
> 		".long 1b\n"\
> 		".previous\n" 
> 
> Then you don't need the LOCK_ADDR macro, so most of atomic.h can be
> left as is. The assembler doesn't seem to care that there's a section
> change between the lock prefix and the instruction that it's locking.

Local labels work forwards as well as backwards:

 #define LOCK 
 	 	".section .lock.init,\"a\"\n" \
 		".align 4\n"\
 		".long 1f\n"\
 		".previous\n" 
		"1: lock ; \n"

I recommend not using "1" for your label, though, because probably
other bits of code that use locks have local loops in them.  It's to be
expected... just pick a less common number.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
