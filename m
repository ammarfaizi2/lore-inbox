Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265286AbUGBBEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265286AbUGBBEY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 21:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265778AbUGBBEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 21:04:24 -0400
Received: from mail.shareable.org ([81.29.64.88]:23726 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265286AbUGBBET
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 21:04:19 -0400
Date: Fri, 2 Jul 2004 02:03:49 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Keith M. Wesolowski" <wesolows@foobazco.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org
Subject: A question about PROT_NONE on Sun4c 32-bit Sparc
Message-ID: <20040702010349.GF8950@mail.shareable.org>
References: <20040630030503.GA25149@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040630030503.GA25149@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,

David Miller suggested I ask you specifically about the Sun4 & Sun4c
32-bit Sparc ports of Linux.  He's confirmed a bug in the SRMMU 32-bit
Sparc port, and I just wanted you to confirm it isn't in the other
32-bit Sparc ports.

I would like to know if the Sun4 and Sun4c ports have the same bug.
I'm guessing not, but it's not clear to me from the code.

In linux-2.6.5/include/asm-sparc/pgtsun4.h (pgtsun4c.h is similar):

#define _SUN4C_PAGE_VALID        0x80000000
#define _SUN4C_PAGE_SILENT_READ  0x80000000   /* synonym */
#define _SUN4C_PAGE_DIRTY        0x40000000
#define _SUN4C_PAGE_SILENT_WRITE 0x40000000   /* synonym */
...
#define _SUN4C_PAGE_READ         0x00800000   /* implemented in software */
#define _SUN4C_PAGE_WRITE        0x00400000   /* implemented in software */
#define _SUN4C_PAGE_ACCESSED     0x00200000   /* implemented in software */
#define _SUN4C_PAGE_MODIFIED     0x00100000   /* implemented in software */
...
#define _SUN4C_READABLE		(_SUN4C_PAGE_READ|_SUN4C_PAGE_SILENT_READ|\
				 _SUN4C_PAGE_ACCESSED)
#define _SUN4C_WRITEABLE	(_SUN4C_PAGE_WRITE|_SUN4C_PAGE_SILENT_WRITE|\
				 _SUN4C_PAGE_MODIFIED)
...
#define SUN4C_PAGE_NONE		__pgprot(_SUN4C_PAGE_PRESENT)
#define SUN4C_PAGE_SHARED	__pgprot(_SUN4C_PAGE_PRESENT|_SUN4C_READABLE|\
					 _SUN4C_PAGE_WRITE)
#define SUN4C_PAGE_READONLY	__pgprot(_SUN4C_PAGE_PRESENT|_SUN4C_READABLE)

SUN4C_PAGE_NONE corresponds to PROT_NONE mmap memory protection.

The question is whether PROT_NONE pages are readable by the _kernel_.
I.e. whether write() would successfully read from those pages.

>From the names of the above macros, I'm guessing not.  There's nothing
to indicate that they would be.  I just wanted you to confirm, thanks.

(In the SRMMU 32-Sparc version, PROT_NONE pages _are_ readable in the
kernel, because of the way they are implemented by making them
priveleged pages.)

(By the way, as the sun4 files don't contain a definition of
_SUN4_PAGE_FILE or pgoff_to_pte, but the sun4c one do, I guess the
sun4 sub-architecture doesn't build in 2.6 but sun4c does?)

Thanks,
-- Jamie
