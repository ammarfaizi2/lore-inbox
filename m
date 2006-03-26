Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWCZWUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWCZWUP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 17:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWCZWUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 17:20:14 -0500
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:15581 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751066AbWCZWUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 17:20:13 -0500
Date: Sun, 26 Mar 2006 17:15:50 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1
  blocks(Kernel)
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       Takashi Sato <sho@bsd.tnes.nec.co.jp>
Message-ID: <200603261719_MC3-1-BB98-9F71@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060326030114.GA2241@thunk.org>

On Sat, 25 Mar 2006 22:01:15 -0500, Theodore Ts'o wrote:

> Fix the i386 bitmap operations so they are 32-bit clean
...
> --- a/lib/ext2fs/bitops.h     Sat Mar 25 01:42:02 2006 -0500
> +++ b/lib/ext2fs/bitops.h     Sat Mar 25 13:42:45 2006 -0500
...
> @@ -155,9 +179,10 @@
>  {
>       int oldbit;
>  
> +     addr = (void *) (((unsigned char *) addr) + (nr >> 3));
>       __asm__ __volatile__("btsl %2,%1\n\tsbbl %0,%0"
>               :"=r" (oldbit),"=m" (EXT2FS_ADDR)
                                ^
  This should be "+" because that data is both read and written
by the assembler instruction.

> -             :"r" (nr));
> +             :"r" (nr & 7));
>       return oldbit;
>  }
>  
> @@ -165,9 +190,10 @@
>  {
>       int oldbit;
>  
> +     addr = (void *) (((unsigned char *) addr) + (nr >> 3));
>       __asm__ __volatile__("btrl %2,%1\n\tsbbl %0,%0"
>               :"=r" (oldbit),"=m" (EXT2FS_ADDR)
                                ^
  Same here.

> -             :"r" (nr));
> +             :"r" (nr & 7));
>       return oldbit;
>  }
 
See include/asm-i386/bitops.h where that has already been done (it's still
wrong, but less so than before.)

-- 
Chuck
"Penguins don't come from next door, they come from the Antarctic!"

