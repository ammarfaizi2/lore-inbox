Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161062AbWGNLA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161062AbWGNLA5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 07:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161076AbWGNLA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 07:00:57 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:60779 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161062AbWGNLA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 07:00:57 -0400
Subject: Re: sparse warnings for variable length arrays
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Dave Jones <davej@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060713170127.GI12807@redhat.com>
References: <20060713085808.GA9566@osiris.boeblingen.de.ibm.com>
	 <20060713170127.GI12807@redhat.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Fri, 14 Jul 2006 13:00:58 +0200
Message-Id: <1152874858.7522.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 13:01 -0400, Dave Jones wrote:
> On Thu, Jul 13, 2006 at 10:58:08AM +0200, Heiko Carstens wrote:
>  > Hi all,
>  > 
>  > in include/asm-s390/bitops.h we have several typedefs:
>  > 
>  > typedef struct { long _[__BITOPS_WORDS(size)]; } addrtype;
>  > 
>  > sparse warns about these with "error: bad constant expression".
>  > Is there any way to tell sparse to be quiet? __force doesn't seem to work.
> 
> In many cases, these turn up as on-stack variables.  It'd be
> nice if sparse could figure out the maximum potential bound
> and warn appropriately if they could reach $BIGSIZE.

The reason why I introduced the typedef was a bug that had its cause in
an on-stack bit field (actually is has been a single unsigned long) that
was passed to one of find_bit functions. The old find_bit inlines did
not tell the compiler that the content of the on-stack bit field is
accessed, just the address to it was passed and ther has been a "memory"
clobber. The "memory" clobber works fine with bit fields that are not on
the stack, it forces the compiler to write everything to memory before
calling the inline. For on-stack bit fields things look different, the
old inline did not inform the compiler that the content of the local
variable is accessed, only the address of a local variable is needed. If
no other code in the scope of the local variable accesses the content of
the bitfield the surprising conclusion of gcc is that since nobody
accesses the content it can remove the initialization of it and the
stack slot for it as well. gcc just passed the inline an address
pointing to nothing.

In short, we need the typedef (or something equivalent). Sparse reports
a false positive.

> For non-stack vars, it's less of an issue of course.

Even for non-stack variables the typedef makes sense. By telling the
compiler exactly what is accessed by the inline you don't need the
"memory" clobber anymore. The inlines of the s390 find_xxx_bit functions
do not have it. That allows the compiler to optimize a little bit
better.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


