Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265050AbUELNhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265050AbUELNhK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 09:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbUELNfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 09:35:22 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:46492 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265050AbUELNeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 09:34:36 -0400
Subject: Re: ffs() (was: [Linux-NTFS-Dev] SOLVED - Re: PROBLEM: compiling
	NTFS write support)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Szakacsits Szabolcs <szaka@sienet.hu>, andrea.fracasso@infoware-srl.com
Cc: lkml <linux-kernel@vger.kernel.org>,
       ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>
In-Reply-To: <1084368557.16624.35.camel@imp.csi.cam.ac.uk>
References: <Pine.LNX.4.21.0405121449120.12270-100000@mlf.linux.rulez.org>
	 <1084368557.16624.35.camel@imp.csi.cam.ac.uk>
Content-Type: text/plain
Organization: University of Cambridge Computing Service
Message-Id: <1084368854.16624.41.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 12 May 2004 14:34:15 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-12 at 14:29, Anton Altaparmakov wrote:
> On Wed, 2004-05-12 at 13:58, Szakacsits Szabolcs wrote:
> > On Wed, 12 May 2004, Anton Altaparmakov wrote:
> > > On Wed, 2004-05-12 at 12:56, andrea.fracasso@infoware-srl.com wrote:
> > > > > On Wed, 2004-05-12 at 11:14, andrea.fracasso@infoware-srl.com wrote:
> > > > >> Hi, I have found a problem compiling te source of kernel 2.6.6, if I
> > > > >> enable NTFS write support when i run "make" i get this error:
> > > > >>
> > > > >> ....
> > > > >>   CC      fs/ntfs/inode.o
> > > > >>   CC      fs/ntfs/logfile.o
> > > > >> {standard input}: Assembler messages:
> > > > >> {standard input}:683: Error: suffix or operands invalid for `bsf'
> > > > >> make[2]: *** [fs/ntfs/logfile.o] Error 1
> > > > >> make[1]: *** [fs/ntfs] Error 2
> > > > >> make: *** [fs] Error 2
> > > > >>
> > > > >> my kernel version is:
> > > > >> Linux version 2.6.5-AS1500 (root@ntb-gozzolox) (gcc version 3.3.2
> > > > >> 20031022
> > > > >> (Red Hat Linux 3.3.2-1)) #3 Thu Apr 15 10:13:11 CEST 2004
> > > > 
> > > > The binutils ver is:
> > > > binutils-2.14.90.0.6-4
> > > 
> > > This happens because gcc (wrongly!) optimizes a variable into a constant
> > > and then ffs() fails to assemble because the bsfl instruction is only
> > > allowed with memory operands and not constants.
> > 
> > IMHO this should be worked around (fixed) in the inlined __asm__ ffs. Does
> > it happen only on Opteron or on other platforms as well?
> 
> Seems to be opteron only so far.  Obviously gcc on the opteron must be
> 'better' at optimizing...  I imagine the below would work:
> 
> --- bklinux-2.6/include/asm-x86_64/bitops.h.old	2004-05-12
> 14:22:16.370662976 +0100
> +++ bklinux-2.6/include/asm-x86_64/bitops.h	2004-05-12
> 14:23:17.800324248 +0100
> @@ -452,7 +452,7 @@ static inline int sched_find_first_bit(c
>   * the libc and compiler builtin ffs routines, therefore
>   * differs in spirit from the above ffz (man ffs).
>   */
> -static __inline__ int ffs(int x)
> +static __inline__ int mem_ffs(int x)
>  {
>  	int r;
>  
> @@ -462,6 +462,8 @@ static __inline__ int ffs(int x)
>  	return r+1;
>  }
>  
> +#define ffs(x) 	(__builtin_constant_p(x) ? generic_ffs(x) : mem_ffs(x))
> +
>  /**
>   * hweightN - returns the hamming weight of a N-bit word
>   * @x: the word to weigh
> 
> But what is to say that the next gcc version in i386 won't have the same
> problem?  We would really need to do this on all arch who use an
> instruction which is not capable of working on constants.  asm-i386
> would be a prime candidate.
> 
> Andrea, could you test the above change instead of the one to logfile.c
> as well and let us know if it worked?

Actually don't worry.  As was just pointed out to me the fault is
actually with the ffs() assembler on x86_64...  I will send a patch for
that to Linus/Andrew/Andi in a second.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ &
http://www-stu.christs.cam.ac.uk/~aia21/


