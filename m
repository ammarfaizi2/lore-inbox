Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276982AbRKSJuY>; Mon, 19 Nov 2001 04:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277012AbRKSJuF>; Mon, 19 Nov 2001 04:50:05 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:41718 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S276982AbRKSJuD>;
	Mon, 19 Nov 2001 04:50:03 -0500
Date: Mon, 19 Nov 2001 02:48:56 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Michael Peddemors <michael@wizard.ca>, linux-kernel@vger.kernel.org
Subject: Re: Current Max Swap size? Performance issues
Message-ID: <20011119024856.E1308@lynx.no>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Michael Peddemors <michael@wizard.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <1005948151.10803.18.camel@mistress> <20011116163346.L1308@lynx.no> <m1itc88ue5.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <m1itc88ue5.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sat, Nov 17, 2001 at 11:28:50PM -0700
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 17, 2001  23:28 -0700, Eric W. Biederman wrote:
> Andreas Dilger <adilger@turbolabs.com> writes:
> > > 2 GIG swap partition (Is this still the limit?)
> > 
> > Yes, still the limit.  It turns out that this is not an on-disk format
> > limit, but rather an in-memory structure limit, in case you cared.  For
> > non-x86 platforms, there is a different limit.
> 
> Where?  The limit should be about 64GB or so on x86.  If it isn't it should
> be just a couple of lines to change it.  Or is the limit the vmalloc
> of the swap_map?

In my mm/swapfile.c code, I added comments about this, when I was adding
support for LABELs in swapfiles.  The new swapfile limits say:

/* The new swap format has a page count and a list of page
 * numbers which overlap bad blocks on disk.  We are limited
 * to 2^32 pages by the on-disk format (info.last_page and
 * page numbers in badpages are both unsigned ints, 16TiB for
 * 4kiB pages).  We are also limited by SWP_ENTRY() which
 * varies by architecture (64GiB for ia32).
 */
maxpages = SWP_OFFSET(SWP_ENTRY(0,~0UL)) - 1;

and include/asm-i386/pgtable.h has:
#define SWP_TYPE(x)		(((x).val >> 1) & 0x3f)
#define SWP_OFFSET(x)		((x).val >> 8)
#define SWP_ENTRY(type, offset) ((swp_entry_t){((type) << 1) | ((offset) << 8)})


So, we are limited to 2^24 pages of swap from a single swapfile, and 4kB
pages (2^12), so 2^36 bytes of swap, which would be 64GB per swapfile.

Hmm, this means I don't know where the 2GB limit comes from.  If we look
at the vmalloc of maxpages, we have 2x maxpages, so 2^25, or 32MB allocated
for a 64GB swapfile.  I don't know if that would be a problem.  For a 
2GB swapfile, that would only be 1MB for the swap_map allocation.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

