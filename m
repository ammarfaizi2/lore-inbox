Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbVADAuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbVADAuG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 19:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVADAqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 19:46:48 -0500
Received: from dp.samba.org ([66.70.73.150]:9671 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261975AbVADAly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 19:41:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16857.58819.311223.845400@samba.org>
Date: Tue, 4 Jan 2005 11:39:31 +1100
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Michael B Allen <mba2000@ioplex.com>, sfrench@samba.org,
       linux-ntfs-dev@lists.sourceforge.net, samba-technical@lists.samba.org,
       aia21@cantab.net, hirofumi@mail.parknet.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FAT, NTFS, CIFS and DOS attributes
In-Reply-To: <41D9E23A.4010608@zytor.com>
References: <41D9C635.1090703@zytor.com>
	<54479.199.43.32.68.1104794772.squirrel@li4-142.members.linode.com>
	<41D9D65D.7050001@zytor.com>
	<16857.57572.25294.431752@samba.org>
	<41D9E23A.4010608@zytor.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Right, it's the "design is broken so everything ends up in user.*". 
 > Now, I clearly dislike the StudlyCaps used here, but if it's already 
 > deployed it's probably too late to fix this :(

Samba4 is only deployed by a very few brave sites (such as my wifes
server) who all know that things might change in non-compatible
ways. Still, I'd want a slightly stronger reason than dislike of
studly caps to change it :-)

 > Does Samba have any way do deal with VFAT short names?

Samba doesn't take advantage of the fact that VFAT can store short
names directly in the filesystem, and instead deals with short names
completely in userspace using a hash based name mangling scheme. It
treats VFAT as just another unix filesystem. People who want to deploy
a serious Samba server tend to want journaling, ACLs etc, so VFAT
isn't a candidate.

I currently don't store short file names in xattrs for Samba4 as there
has just no advantage to doing so. Without a "open by xattr contents"
call that doesn't have to scan the entire directory it is much more
efficient to store the 8.3 names in user-space where we can look them
up more efficiently. The scheme we use is to store a cache of
8.3->longname mappings, and when we get a 8.3 name that isn't in cache
we fall back to a directory scan, re-forming the 8.3 name using a hash
for each directory entry.

I'm also much less concerned about 8.3 names these days than I was a
few years ago, as the number of applications that need them is rapidly
dropping. There are some obvious exceptions (such as the idiotic API calls
that cmd.exe uses to implement "del *.*"), but we have worked out ways
to cope with those in a reasonable manner.

Cheers, Tridge
