Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbULVLqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbULVLqh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 06:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbULVLqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 06:46:35 -0500
Received: from canuck.infradead.org ([205.233.218.70]:60422 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261867AbULVLq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 06:46:29 -0500
Subject: Re: [PATCH] revert- sys_setaltroot
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20041222030304.07bb036e.akpm@osdl.org>
References: <200410261928.i9QJS7h3011015@hera.kernel.org>
	 <1103710694.6111.127.camel@localhost.localdomain>
	 <20041222030304.07bb036e.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 22 Dec 2004 11:45:22 +0000
Message-Id: <1103715922.6111.144.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-22 at 03:03 -0800, Andrew Morton wrote:
> There were security problems and suggestions that a namespace-based
> approach would be better.   umm, have a random sprinkle of emails:

Thanks.

> Begin forwarded message:
> 
> Date: Tue, 19 Oct 2004 15:32:57 -0700 (PDT)
> From: Linus Torvalds <torvalds@osdl.org>
> To: "Seth, Rohit" <rohit.seth@intel.com>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
> Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>
> Subject: RE: FW: [PATCH] Support ia32 exec domains without CONFIG_IA32_SUPPORT
> 
> 
> 
> Hmm. Do we actually want to clear the alternate root? It looks like that 
> would make altroot useless.
> 
> Who uses it? I thought it was only really used for the emulation 
> environments on sparc64 etc. And clearly now ia64. But not saving it 
> across an exec would make it useless, no?

No, clearing the altroot doesn't make it useless. If we're executing
another non-native binary, the emulator will set the altroot again. This
isn't _supposed_ to be a chroot. It's mostly to keep the dynamic linker
happy, and resetting it on exec is fine. We were doing that anyway when
it was a function of the personality, because executing new binaries
also resets the personality.

I'm using it on ppc to run i386 binaries -- it's certainly not limited
to sparc64 and ia64. 

> Begin forwarded message:
> 
> Date: Fri, 22 Oct 2004 17:28:35 -0700 (PDT)
> From: Linus Torvalds <torvalds@osdl.org>
> To: "Seth, Rohit" <rohit.seth@intel.com>
> Cc: Andrew Morton <akpm@osdl.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
> Subject: RE: FW: [PATCH] Support ia32 exec domains without CONFIG_IA32_SUPPORT
>
> On Fri, 22 Oct 2004, Seth, Rohit wrote:
> > 
> > Could you please let me know how we should proceed with this issue so
> > that emulators can seemlessly support different execution domains.
> 
> Well, my _personal_ preference by far is to use the equivalent of "chroot" 
> for the emulated environment. So whenever you hit a x86 binary, you just 
> chroot to /emul, and then you run it there.
> 
> NOTE! I say "equivalent", because you could do it by creating a separate
> namespace instead, if you wanted to - and just overmounting /lib and
> /usr/lib with the emulation environment versions in that particular
> namespace. 
> 
> Also, note the bind mounts: if you do end up having "/emul", you want to
> have the local /lib and /usr/lib be there, but the rest would be just bind
> mounts back to the original root, making things pretty similar (ie people
> would still see all their normal files in their home directories etc, it
> would be just /lib that effectively gets swapped out).

I see the point but I'm not sure I understand in detail how this can
work with namespace. It's not just /lib and /usr/lib which exist in the
altroot -- we also need certain files from /etc too, while leaving the
rest of /etc as it was. Do we have to bind-mount just those specific
files? And can we arrange for the alternate namespace to be
automatically dropped on exec() too? And can we do this without needing
the interpreter to be setuid in all cases?

> Al may have more intelligent suggestions.

Hopefully :)

-- 
dwmw2

