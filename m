Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbULACCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbULACCw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 21:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbULACCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 21:02:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9666 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261158AbULACCY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 21:02:24 -0500
Date: Wed, 1 Dec 2004 02:02:19 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Alexandre Oliva <aoliva@redhat.com>,
       dhowells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: cdrom.h (was Re: [RFC] Splitting kernel headers...)
Message-ID: <20041201020219.GB5752@parcelfarce.linux.theplanet.co.uk>
References: <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br> <8219.1101828816@redhat.com> <Pine.LNX.4.58.0411300744120.22796@ppc970.osdl.org> <ormzwzrrmy.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411301249590.22796@ppc970.osdl.org> <orekibrpmn.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411301423030.22796@ppc970.osdl.org> <1101854061.4574.4.camel@localhost.localdomain> <Pine.LNX.4.58.0411301447570.22796@ppc970.osdl.org> <1101858657.4574.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101858657.4574.33.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 11:50:56PM +0000, David Woodhouse wrote:
> Now, there are cases (like _perhaps_ byteorder.h) where we should
> probably allow this kind of 'abuse' to continue because it's fairly
> harmless and it does actually _work_.

OK, time for my pet peeve: linux/cdrom.h.

#include <asm/byteorder.h>

[...]

/* for CDROM_PACKET_COMMAND ioctl */
struct cdrom_generic_command
{
[...]
        struct request_sense    __user *sense;
[...]
}

struct request_sense {
#if defined(__BIG_ENDIAN_BITFIELD)
        __u8 valid              : 1;
        __u8 error_code         : 7;
#elif defined(__LITTLE_ENDIAN_BITFIELD)
        __u8 error_code         : 7;
        __u8 valid              : 1;
#endif
        __u8 segment_number;
[...]
}

At least one architecture's asm/byteorder.h has been C++-incompatible
in the past (I forget what; it was 2 years ago that I cared about it).
So to fix this, we need a asm-*/user/byteorder.h that only describes
the endianness.  Except ... what about mips/mipsel?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
