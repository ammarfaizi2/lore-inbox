Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274956AbTHACzY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 22:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274957AbTHACzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 22:55:24 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:1752 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S274956AbTHACzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 22:55:20 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Steve Dickson <SteveD@redhat.com>
Date: Fri, 1 Aug 2003 12:55:02 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16169.54918.472349.928145@gargle.gargle.HOWL>
Cc: nfs@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>,
       Chip Salzenberg <chip@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: nfs-utils-1.0.5 is not backwards compatible with 2.4
In-Reply-To: message from Steve Dickson on Thursday July 31
References: <3F294DE3.9020304@RedHat.com>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday July 31, SteveD@redhat.com wrote:
> 
> 
> Hey Neil,
> 
> It seems in nfs-utils-1.05 (actually it happen in 1.0.4)
> the NFSEXP_CROSSMNT define was changed to 0x4000 and the
> NFSEXP_NOHIDE define (which is not supported in 2.4) took
> over the 0x0200 bit.. This breaks backwards compatibly with
> 1.0.3 and the 2.4 kernels...
> 
> So could please add this patch that simply switchs the bits
> so NFSEXP_CROSSMNT stays the same and the new NFSEXP_NOHIDE define
> gets the higher bit?

I'll tell you the full story and let you suggest what, if any, source
code changes are really needed.

Once upon a time (2.2 era) there was this export flag called
NFSEXP_CROSSMNT and "crossmnt" which was un-implemented.  I guess it
was a hang over from the user-space nfsd and was probably meant to say
"mount points in this filesystem can be crossed".   But as there was
no code and no documentation, one couldn't be sure. 

In the kernel nfs server at the time, the concept of "crossmnt" was
effectively unimplementable (due the the way the export table was set
up and the way file handles were managed).
A closely related concept was implementable.  This concept is given
the name "nohide" in Irix and possibly others.  This is a flag set on
the child filesystem (rather than the parent) and says that the child
should not be 'hiden' when the mountpoint in the parent is accessed.

So, I used the NFSEXP_CROSSMNT flag to implement nohide (it was one of
my earliest nfsd patches I think) and told nfs-utils that it could use
the name "nohide" to refer to this new flag.

So for sometime, NFSEXP_CROSSMNT, "nohide", 0x0200 meant
"this child filesystem should be visible from the parent".

Possibly this was a mistake.  Possibly I should have used a different
flag or at least changed the name, but I didn't.

As part of the substatial rewrite that went into 2.6, it is possible
to implement "crossmnt" type semantics sensibly.  When a mountpoint is
'crossed' (by a LOOKUP operation) the kernel can ask user-space to
provide export information for that filesystem and act according to
the response. (This is not completely implemented in nfs-utils 1.0.5,
though it should work to some extent.  I hope to figure out the
remaining details and get it working before 1.1.0).

So I needed a new flag, and chose 0x4000.  This flag can be set on the
parent and says that all mount points should be crossed (if possible).

The most obvious name for this flag was NFSEXP_CROSSMNT which was
currently inuse as a misnomer for the nohide option.
So I renamed the old NFSEXP_CROSSMNT to NFSEXP_NOHIDE, both in
nfs-utils and in the kernel.
I then added the new flags 0x4000 named NFSEXP_CROSSMNT with the
textual representation "crossmnt".

As far as I can tell, the only incompatability that this will cause is
if some code outside of the kernel and outside of nfs-utils uses the
header files from either the kernel or nfs-utils.  Such code will get
a new value for NFSEXP_CROSSMNT if it changes it's header files.   I
don't know if there is any such code, but if there is  I apoligise for
breaking it and suggest that the best fix is to not use the header
file it was using but it explicitly include the values for NFSEXP_* in
that code.

Let me know if there is some issue that this does not sufficiently
clear up.

NeilBrown


> 
> --- support/include/nfs/export.h.diff   Mon Jul 14 18:14:01 2003
> +++ support/include/nfs/export.h        Thu Jul 31 11:58:05 2003
> @@ -20,11 +20,11 @@
> #define NFSEXP_UIDMAP          0x0040
> #define NFSEXP_KERBEROS                0x0080          /* not available */
> #define NFSEXP_SUNSECURE       0x0100
> -#define NFSEXP_NOHIDE          0x0200
> +#define NFSEXP_CROSSMNT                0x0200
> #define NFSEXP_NOSUBTREECHECK  0x0400
> #define NFSEXP_NOAUTHNLM       0x0800
> #define NFSEXP_FSID            0x2000
> -#define        NFSEXP_CROSSMNT         0x4000
> +#define        NFSEXP_NOHIDE           0x4000
> #define NFSEXP_NOACL           0x8000 /* reserved for possible ACL
> related use */
> #define NFSEXP_ALLFLAGS                0xFFFF
> 
> 
> SteveD.
> 
> 
