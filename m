Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267542AbUH1Sqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267542AbUH1Sqq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 14:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267522AbUH1Sqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 14:46:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:25284 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267517AbUH1Sqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 14:46:40 -0400
Date: Sat, 28 Aug 2004 11:44:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Helge Hafting <helgehaf@aitel.hist.no>, Rik van Riel <riel@redhat.com>,
       Spam <spam@tnonline.net>, Jamie Lokier <jamie@shareable.org>,
       Hans Reiser <reiser@namesys.com>, David Masover <ninja@slaphack.com>,
       Diego Calleja <diegocg@teleline.es>, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       hch@lst.de, linux-fsdevel@vger.kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040828182954.GJ21964@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0408281132480.2295@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com>
 <Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org> <20040828170515.GB24868@hh.idb.hist.no>
 <Pine.LNX.4.58.0408281038510.2295@ppc970.osdl.org>
 <20040828182954.GJ21964@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 28 Aug 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> What would your openat() produce?  Normal struct file?  Then what's going
> to be its vfsmount/dentry and what will they be attached to?

Normal file descriptor, exactly like "open()".

And it's going to have all the same vfsmount/dentry thing it would have if 
you looked it up the whole way. I don't understand your question..

Ignore the O_XATTR thing for a while, and assume it's just a convenient
combination of "fchdir + open" (plus "fchdir back" of course, but that's 
beside the point - openat() doesn't ever really change cwd).

Going back to O_XATTR: that would end up doing the "special vfsmount"  
magic at the beginning of the lookup. If the dentry you started with
wasn't marked D_HYBRID, it would just return -ENOTDIR.

So we could do openat() _without_ any of the lookup_mnt() etc special 
cases. This interface is independent of whether we want to expose the 
attributes through a normal lookup - we can do either, both, or neither as 
we choose.

The nice thing about "openat()" is
 - people can definitely find uses for it even without attributes. 
 - it's "portable". Well, at least somebody else does the same thing, 
   which is nice for user-space developers. You don't use a Linux-only 
   interface, you use a Linux/Solaris one, which makes a lot of people a 
   lot more happy.

Remember, portability has always been very important to Linux, and
Linux-only features while nice are certainly not as nice as features you
can also find in other places.

NIH is a disease.

		Linus
