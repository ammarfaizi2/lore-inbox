Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317392AbSGYGti>; Thu, 25 Jul 2002 02:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317470AbSGYGti>; Thu, 25 Jul 2002 02:49:38 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:13811 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317392AbSGYGth>; Thu, 25 Jul 2002 02:49:37 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 25 Jul 2002 00:51:09 -0600
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Header files and the kernel ABI
Message-ID: <20020725065109.GO574@clusterfs.com>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
References: <aho5ql$9ja$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aho5ql$9ja$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 24, 2002  23:28 -0700, H. Peter Anvin wrote:
> It seems to me that a reasonable solution for how to do this is not
> for user space to use kernel headers, but for user space and the
> kernel to share a set of common ABI description files[1].  These files
> should be highly stylized, and only describe things visible to user
> space.  Furthermore, if they introduce types, they should use the
> already-established __kernel_ namespace, and of course __s* and __u*
> could be used for specific types.
> 
> I would like to propose that these files be set up in the #include
> namespace as <linux/abi/*>, with <linux/abi/arch/*> for any
> architecture-specific support files (I do believe, however, that those
> files should only be included by files in the linux/abi/ root.  This
> probably would be a symlink to ../asm/abi in the kernel sources,
> unless we change the kernel include layout.)  The linux/ namespace is
> universally reserved for the kernel, and unlike <abi/*> I don't know
> of any potential conflicts.  I was considered <kabi/*>, but it seems
> cleaner to use existing namespace.

I had thought on this briefly in the past, and my take would be for these
ABI definition files to live directly in /usr/include/linux for user space
(just as glibc puts its own sanitized copy of the kernel headers there)
and the appropriate ABI headers are included as needed from the kernel.

The kernel side would be something like <linux/scsi.h> includes
<linux/abi/scsi.h> or whatever, but in the future this can be included
directly as needed throughout the kernel.  The existing kernel
<linux/*.h> headers would also have extra kernel-specific data in them.

The same could be done with the user-space headers, but I think that
is missing the point that the linux/abi/*.h headers should define _all_
of the abi, so we may as well just use that directly.

Essentially "all" this would mean is that we take the existing headers,
remove everything which is inside #ifdef __KERNEL__ (and all of the
other kernel-specific non-abi headers that are included) and we are
done.  The kernel header now holds only things that were inside the
#ifdef __KERNEL__ (or should have been), and #include <linux/abi/foo.h>.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

