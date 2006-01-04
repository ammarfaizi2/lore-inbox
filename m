Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWADXpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWADXpr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 18:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWADXpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 18:45:47 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:33489 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750743AbWADXpq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 18:45:46 -0500
Message-ID: <43BC5E15.207@austin.ibm.com>
Date: Wed, 04 Jan 2006 17:45:25 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Al Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>
Subject: Re: [patch 00/21] mutex subsystem, -V14
References: <20060104144151.GA27646@elte.hu>
In-Reply-To: <20060104144151.GA27646@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> this is version 14 of the generic mutex subsystem, against v2.6.15.
> 
> The patch-queue consists of 21 patches, which can also be downloaded 
> from:
> 
>   http://redhat.com/~mingo/generic-mutex-subsystem/
> 

Took a glance at this on ppc64.  Would it be useful if I contributed an arch 
specific version like arm has?  We'll either need an arch specific version or 
have the generic changed.

Anyway, here is some disassembly of some of the code generated with my comments:

c00000000049bf9c <.mutex_lock>:
c00000000049bf9c:       7c 00 06 ac     eieio
c00000000049bfa0:       7d 20 18 28     lwarx   r9,r0,r3
c00000000049bfa4:       31 29 ff ff     addic   r9,r9,-1
c00000000049bfa8:       7d 20 19 2d     stwcx.  r9,r0,r3
c00000000049bfac:       40 c2 ff f4     bne+    c00000000049bfa0 <.mutex_lock+0x4>
c00000000049bfb0:       4c 00 01 2c     isync
c00000000049bfb4:       7d 20 4b 78     mr      r0,r9
c00000000049bfb8:       78 09 0f e3     rldicl. r9,r0,33,63
c00000000049bfbc:       4d 82 00 20     beqlr
c00000000049bfc0:       4b ff ff 58     b       c00000000049bf18 
<.__mutex_lock_noinline>

The eieio is completly unnecessary, it got picked up from atomic_dec_return 
(Anton, why is there an eieio at the start of atomic_dec_return in the first 
place?).

Ignore the + on the bne, the disassembler is wrong, it is really a -

c00000000049bfc4 <.mutex_unlock>:
c00000000049bfc4:       7c 00 06 ac     eieio
c00000000049bfc8:       7d 20 18 28     lwarx   r9,r0,r3
c00000000049bfcc:       31 29 00 01     addic   r9,r9,1
c00000000049bfd0:       7d 20 19 2d     stwcx.  r9,r0,r3
c00000000049bfd4:       40 c2 ff f4     bne+    c00000000049bfc8 <.mutex_unlock+0x4>
c00000000049bfd8:       4c 00 01 2c     isync
c00000000049bfdc:       7d 20 07 b4     extsw   r0,r9
c00000000049bfe0:       2c 00 00 00     cmpwi   r0,0
c00000000049bfe4:       4d 81 00 20     bgtlr
c00000000049bfe8:       4b ff ff 40     b       c00000000049bf28 
<.__mutex_unlock_noinline>

That eieio should be an lwsync to avoid data corruption.  And I think the isync 
is superfluous.

Ditto the disassembler being wrong about the + vs -.
