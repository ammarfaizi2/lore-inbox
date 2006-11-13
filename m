Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751676AbWKMIwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbWKMIwc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 03:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752125AbWKMIwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 03:52:32 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:42880 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751036AbWKMIwb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 03:52:31 -0500
Date: Mon, 13 Nov 2006 08:52:23 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: David Miller <davem@davemloft.net>
Cc: kenneth.w.chen@intel.com, akpm@osdl.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [patch] fix up generic csum_ipv6_magic function prototype
Message-ID: <20061113085223.GR29920@ftp.linux.org.uk>
References: <000301c703a3$0eedb340$ff0da8c0@amr.corp.intel.com> <20061108.230059.57444310.davem@davemloft.net> <20061109072216.GL29920@ftp.linux.org.uk> <20061108.235548.12921799.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108.235548.12921799.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 11:55:48PM -0800, David Miller wrote:
> From: Al Viro <viro@ftp.linux.org.uk>
> Date: Thu, 9 Nov 2006 07:22:16 +0000
> 
> > I haven't touch that argument yet; if there's an agreement as to what should
> > we switch to, I'll do that.  So... does everyone agree that u32 is the way
> > to go?
> 
> I definitely do.

OK.  While we are at it, let's really sanitize the prototypes for that zoo.

General notes:

* I've added two types for checksums (__sum16 == checksum, __wsum == wide
unfolded checksum).  Those are fairly obvious.

* We have a bloody mess of what we do with pointers to data being checksumed -
char *, unsigned char *, __user and const used inconsistently.  I'm converting
them all to pointers to (qualified) void, with const and __user where needed.

* struct in6_addr * in csum_ipv6_magic() should be pointer to const.

* IPv4 addresses should be passed as __be32.

* length in csum_ipv6_magic() should be u32.

After doing the above we have the following:

Consistent on all platforms:
__sum16 ip_fast_csum(const void *, unsigned int);
__sum16 ip_compute_csum(const void *, int);
__sum16 csum_fold(__wsum);
__wsum csum_partial_copy_from_user(const void __user *, void *, int, __wsum, int *);
__wsum csum_partial_copy_nocheck(const void *, void *, int, __wsum);
__wsum csum_and_copy_to_user(const void *, void *, int, __wsum, int *);
__sum16 csum_ipv6_magic(struct in6_addr *, struct in6_addr *, __u32, unsigned short, __wsum);

Platform-dependent:
__wsum csum_partial(const void *, T, __wsum);
On amd64 and uml/amd64 we have T = unsigned int, everywhere else it's int.
__wsum csum_tcpudp_nofold(__be32, __be32, T1, T2, __wsum);
On arm/arm26: T1 = unsigned short, T2 = unsigned int.
On sparc/sparc64: T1 = unsigned int, T2 = unsigned short.
Everywhere else: T1 = T2 = unsigned short.
__sum16 csum_tcpudp_magic(__be32, __be32, unsigned short, T, __wsum);
On arm/arm26 T is unsigned int, elsewhere it's unsigned short.


The first question is in the types we are using for length.  OK,
csum_tcpudp_...() is a special case; there we want u16 and unless
there's a reason _not_ to do so on sparc, I'd rather convert it
to the same thing.

Another special case is ip_fast_csum() (length in 32bit words, never more
than 15, actually; existing code happily breaks for (never passed) large
values).

The rest is a mess and should clearly be the same type.  Do we want it
to be signed?  Several architectures do have checks for the bit 31 being
set and demonstrate bloody odd behaviour in such cases.

Incidentally, WTF is
define SK_CS_CALCULATE_CHECKSUM
#ifndef CONFIG_X86_64
#define SkCsCalculateChecksum(p,l)      ((~ip_compute_csum(p, l)) & 0xffff)
#else
#define SkCsCalculateChecksum(p,l)      ((~ip_fast_csum(p, l)) & 0xffff)   
#endif
in ./drivers/net/sk98lin/h/skdrv1st.h?  I don't see any callers of that
beast, anyway, but I'd really love to know who'd written it in the
first place; the meaning of the second argument is different in those
two...

The next question: csum_tcpudp_...() 'proto' argument.  What do we want
there?  u8?  u16?  u32?  It always fits in u8 and many architectures
rely on it never exceeding 255.  It's always constant, BTW...

csum_partial_copy_fromuser():  Can die, only 3 targets have its rudiment
and nothing in the tree uses it.  ACK?

csum_partial_copy().  Rare alias for csum_partial_copy_nocheck().  Can die;
all instances simply should be renamed to csum_partial_copy_nocheck.  ACK?
