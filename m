Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268410AbUH3BnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268410AbUH3BnX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 21:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268415AbUH3BnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 21:43:23 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:58761 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S268410AbUH3BnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 21:43:20 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@osdl.org>
Date: Mon, 30 Aug 2004 11:43:05 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16690.34345.865445.560298@cse.unsw.edu.au>
Cc: Grzegorz Kulewski <kangur@polcom.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: message from Linus Torvalds on Sunday August 29
References: <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com>
	<412F7D63.4000109@namesys.com>
	<20040827230857.69340aec.pj@sgi.com>
	<20040829150231.GE9471@alias>
	<4132205A.9080505@namesys.com>
	<20040829183629.GP21964@parcelfarce.linux.theplanet.co.uk>
	<20040829185744.GQ21964@parcelfarce.linux.theplanet.co.uk>
	<41323751.5000607@namesys.com>
	<20040829212700.GA16297@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.58.0408291431070.2295@ppc970.osdl.org>
	<Pine.LNX.4.60.0408300009001.10533@alpha.polcom.net>
	<Pine.LNX.4.58.0408291523130.2295@ppc970.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday August 29, torvalds@osdl.org wrote:
> 
> Also, while the VFS layer no longer cares (to it, ".." is purely virtual,
> and it never uses it), the NFS export routines still do actually want to
> get the on-disk parent. A filesystem that can't do that may be unable to
> be exported with full semantics (ie you might get ESTALE errors after
> server reboots, although you'd have to ask somebody with more kNFSd
> knowledge than me on exactly why that is the case ;)
> 

The VFS requires all directories to have full paths from the
filesystem root in the dcache.  This is needed for loop detection when
renaming directories.

suppose and NFS client: (UPPERCASE words refer to file handles)
 Says "lookup ROOT 'a'" and gets A  (file handle for /a)
 Says "lookup A 'b'" and gets B     (file handle for /a/b)
 waits for /a and /a/b to be flushed from the dcache
 Says "RENAME ROOT 'a' to B 'z'"    (i.e. asks for /a to be moved to /a/b/c)

how can the VFS detect that that is not allowed?  It needs to know
that B is a subdirectory of /a.  The complete path cannot fit in
filehandle, so to needs to be computed by repeated lookup of "..",
which must be on disk.


Even without that, storing ".." on disk makes lots of sense for
fsck-like tools.

NeilBrown
