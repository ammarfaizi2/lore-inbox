Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbVADCvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbVADCvm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 21:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVADCvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 21:51:42 -0500
Received: from dp.samba.org ([66.70.73.150]:7867 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261975AbVADCvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 21:51:37 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16858.1074.740440.917427@samba.org>
Date: Tue, 4 Jan 2005 13:49:22 +1100
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: aia21@cantab.net, samba-technical@lists.samba.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ntfs-dev@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       sfrench@samba.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: FAT, NTFS, CIFS and DOS attributes
In-Reply-To: <AA7F1C76-5DF7-11D9-B689-000393ACC76E@mac.com>
References: <41D9C635.1090703@zytor.com>
	<16857.56805.501880.446082@samba.org>
	<41D9E3AA.5050903@zytor.com>
	<16857.59946.683684.231658@samba.org>
	<41D9EDF6.1060600@zytor.com>
	<16857.62250.259275.305392@samba.org>
	<41D9F65E.3030301@zytor.com>
	<16857.63978.65838.823252@samba.org>
	<AA7F1C76-5DF7-11D9-B689-000393ACC76E@mac.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle,

 > IMHO, it would be really nice (Although I realize this would be a
 > humongous task) if there was a "Linux" ACL system supported by the
 > VFS that is backwards compatible with UNIX perms, POSIX ACLs, and
 > NTFS ACLs

The problem is that apps/users that care about posix ACLs and NT ACLs
tend to care about them being _exactly_ right, so half baked mappings
between the different systems don't really help much. We have learnt
this the hard way in Samba3, where we attempt to map NT ACLs to posix
ACLs on the fly, and we get a never ending stream of bug reports that
NT ACLs aren't working as expected for windows users. Thats why I
stuck the full NT ACL in an xattr for Samba4.

The plan for mapping between the systems in Samba4 goes like this:

 - when a NT ACL is needed for access control, or the client asks for
   the ACL via a query file info call, smbd first looks in the NTACL
   xattr. If it finds it then all is well with the world.

 - if the NTACL xattr isn't there, then it produces one using an
   approximate mapping. The mapping for mode_t is in the function
   pvfs_default_acl() in pvfs_acl.c. The mapping when there is an
   existing posix ACL isn't done yet (we have a mapping for that in
   Samba3, but it will be a bit different in Samba4).

 - if its a file/directory create, then it also obeys the inheritance
   rules, pulling the NTACL from the parent using the above method
   then applying to the child.

I also plan to catch the posix ACL set call in the Samba LSM module,
and wipe the NTACL when that happens. In that case the NTACL will be
overridden by the new posix ACL.

Similarly, when a posix application asks to read the posix ACL, then a
reverse mapping would be supplied if there is a current NT ACL on the
file.

The important thing is that if your file access is either only from
unix apps that know about posix ACLs or only from windows apps that
know about NT ACLs, then you need to provide perfect lossless storage
of those native ACLs for those applications. It is only when you get a
transition from one scheme to the other on the one file that a mapping
should happen.

Cheers, Tridge
