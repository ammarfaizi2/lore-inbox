Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268260AbUH2Wh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268260AbUH2Wh2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 18:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268352AbUH2Wh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 18:37:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:60589 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268260AbUH2Wh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 18:37:26 -0400
Date: Sun, 29 Aug 2004 15:37:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Grzegorz Kulewski <kangur@polcom.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <Pine.LNX.4.60.0408300009001.10533@alpha.polcom.net>
Message-ID: <Pine.LNX.4.58.0408291523130.2295@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com>
 <412F7D63.4000109@namesys.com> <20040827230857.69340aec.pj@sgi.com>
 <20040829150231.GE9471@alias> <4132205A.9080505@namesys.com>
 <20040829183629.GP21964@parcelfarce.linux.theplanet.co.uk>
 <20040829185744.GQ21964@parcelfarce.linux.theplanet.co.uk> <41323751.5000607@namesys.com>
 <20040829212700.GA16297@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0408291431070.2295@ppc970.osdl.org>
 <Pine.LNX.4.60.0408300009001.10533@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



[ Linux-kernel cc'd, because I don't think the question is stupid, and I 
  can't even fully answer the kNFSd thing other than point to it as a
  problem. ]

On Mon, 30 Aug 2004, Grzegorz Kulewski wrote:
> 
> Sorry if my qestion is stupid, but why can't we deal with (hard)links to 
> directories in (nearly) same way we deal with bind mounts (= making 
> exactly one object representing target and only referencing to it)?

On a VFS level we could, these days, I think. But realize that bind mounts
and the vfsmounts are pretty recent things.

We don't have any filesystems that support the notion, though, and we 
don't have any interfaces for the filesystem to tell us about it right 
now. The VFS layer could try to figure it out on its own from aliasing 
information, so the latter may be a non-issue, but the former is why 
nobody does it.

And even if Linux _these days_ could handle hardlinked directories, the
fact is that they would cause slightly more memory usage (due to the
vfsmounts), and that nobody else can handle such filesystems - including
older versions of Linux. So nobody would likely use the feature (not to
mention that nobody is even really asking for it ;).

And the lack of filesystem support is not theoretical. It's not easy to 
just retrofit directory hardlinks on a UNIX filesystem. The ".." entry 
actually exists on _disk_ on traditional unix filesystems, and with 
hardlinks on directories, that's a real problem. A hardlinked directory 
has multiple parents.

Also, while the VFS layer no longer cares (to it, ".." is purely virtual,
and it never uses it), the NFS export routines still do actually want to
get the on-disk parent. A filesystem that can't do that may be unable to
be exported with full semantics (ie you might get ESTALE errors after
server reboots, although you'd have to ask somebody with more kNFSd
knowledge than me on exactly why that is the case ;)

			Linus
