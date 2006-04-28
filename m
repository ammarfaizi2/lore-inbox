Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965147AbWD1CEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965147AbWD1CEb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 22:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbWD1CEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 22:04:31 -0400
Received: from cantor2.suse.de ([195.135.220.15]:3815 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965147AbWD1CEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 22:04:30 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 28 Apr 2006 12:04:25 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org, andrea@suse.de
Subject: [PATCH INTRO] Re: [RFC] copy_from_user races with readpage
In-Reply-To: message from Andrew Morton on Wednesday April 19
References: <200604191318.45738.mason@suse.com>
	<20060419134148.262c61cd.akpm@osdl.org>
Subject: [PATCH 000 of 2] Introduction
Message-ID: <20060428114321.21969.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday April 19, akpm@osdl.org wrote:
> Chris Mason <mason@suse.com> wrote:
> >
> > Hello everyone,
> > 
> > I've been working with IBM on a long standing bug where zeros unexpectedly pop 
> > up during a disk certification test.  We tracked it down to copy_from_user.  
....
> 
> I'd have thought that a sufficient fix would be to change
> __copy_from_user_inatomic() to not do the zeroing, then review all users to
> make sure that they cannot leak uninitialised memory.

So I'm following this up and trying to figure out how best to make this
"right".

Following are two patches.  
The first is the result of the suggested "review".
The only users of copy_from_user_inatomic that cannot safely lose the
zeroing are two separate (but similar:-() implmentations of 
  copy_from_user_iovec
These I have 'fixed'.

It is unfortunate that both chose to "know" exactly the difference between
the _inatomic and the regular versions, and call _inatomic not in atomic context.
It seems to suggest poor interface design, but I'm not sure exactly what
the poor choice is.

Also after reading this code I am very aware that on architectures that
aren't saddled with highmem (e.g. 64bit) the duplication of copy_from_user
is simply wasted icache space.  Possibly it might make sense to guard the first
_inatomic copy with "if(PageHighMem(page))" which should complie it away to
nothing when highmem isn't present.

The second patch changes __copy_from_user_inatomic to not do zeroing
in i386.  I'm quite open to the possiblity of being told that something
I did there is either very silly or very ugly or both.  However not being
very experienced in arch/asm code I'm not sure what.  Constructive
criticism very welcome.

If happiness is achieved with these patches, we then need to look at similar
patches for powerpc, mips, and sparc.

Thanks for your time.

NeilBrown


 [PATCH 001 of 2] Prepare  for __copy_from_user_inatomic to not zero missed bytes.
 [PATCH 002 of 2] Make copy_from_user_inatomic NOT zero the tail on i386
