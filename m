Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbWC0Tzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWC0Tzs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 14:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWC0Tzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 14:55:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12418 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751032AbWC0Tzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 14:55:47 -0500
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: cascardo@minaslivre.org
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger@clusterfs.com>,
       Takashi Sato <sho@bsd.tnes.nec.co.jp>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       Laurent Vivier <Laurent.Vivier@bull.net>, ams@gnu.org,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20060325145139.GA5606@cascardo.localdomain>
References: <02bc01c648f2$bd35e830$4168010a@bsd.tnes.nec.co.jp>
	 <20060316183549.GK30801@schatzie.adilger.int>
	 <20060316212632.GA21004@thunk.org>
	 <20060316225913.GV30801@schatzie.adilger.int>
	 <20060318170729.GI21232@thunk.org>
	 <20060320063633.GC30801@schatzie.adilger.int>
	 <1142894283.21593.59.camel@orbit.scot.redhat.com>
	 <20060320234829.GJ6199@schatzie.adilger.int>
	 <1142960722.3443.24.camel@orbit.scot.redhat.com>
	 <20060321183822.GC11447@thunk.org>
	 <20060325145139.GA5606@cascardo.localdomain>
Content-Type: text/plain
Date: Mon, 27 Mar 2006 14:55:01 -0500
Message-Id: <1143489301.15697.9.camel@orbit.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2006-03-25 at 11:51 -0300, cascardo@minaslivre.org wrote:

> Regarding compatibility, there are plans to support xattr in Hurd and
> use them for these fields, translator and author. (I can't recall what
> i_mode_high is used for.) With respect to that, I'd appreciate if
> there is a recommendation to every ext2 implementation (not only
> Linux) that supports xattr, to support gnu.translator and gnu.author
> (I'll check about the i_mode_high and post about it asap.). 

What do you mean by "support", exactly?

There are 3 different bits of xattr design which matter here.  There's
the namespace exported to users via the *attr syscalls; there's the
encoding used on disk for those different namespaces; and there's the
exact semantics surrounding interpretation of the xattr contents.

Now, a non-Hurd system is not going to have any use for the gnu.* xattr
semantics, as translator is a Hurd-specific concept.  The user "gnu.*"
namespace is easy enough to teach to Linux: to simply reserve that
namespace, without actually implementing any part of it, I think it be
sufficient simply to claim the name in include/linux/xattr.h.

For ext2/3, though, the key is how to store gnu.* on disk.  Right now
the different namespaces that ext* stores on disk are enumerated in

	fs/ext[23]/xattr.h

which, for ext2, currently contains:

        /* Name indexes */
        /* Name indexes */
        #define EXT2_XATTR_INDEX_USER			1
        #define EXT2_XATTR_INDEX_POSIX_ACL_ACCESS	2
        #define EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT	3
        #define EXT2_XATTR_INDEX_TRUSTED		4
        #define	EXT2_XATTR_INDEX_LUSTRE			5
        #define EXT2_XATTR_INDEX_SECURITY	        6

If you want to reserve a new semantically-significant portion of the
namespace for use in the Hurd by gnu.* xattrs, then you'd need to submit
an authoritative Linux patch to register a new name index on ext2;
reservation of such an xattr namespace index is in effect an on-disk
format decision so needs to be agreed between implementations.

> Regarding userland tools, it would be wise if they would still support
> old format filesystems, including those with fs creator set to
> Hurd. That would include supporting the oob block for translator when
> counting used/free blocks and other operations like copying a file
> using debugfs, for example.

Certainly; I don't think anybody is arguing against that, and I regard
such backwards compatibility as an absolute requirement.

--Stephen


