Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129097AbQKXC5C>; Thu, 23 Nov 2000 21:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129153AbQKXC4m>; Thu, 23 Nov 2000 21:56:42 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:59920 "HELO
        note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
        id <S129097AbQKXC4f>; Thu, 23 Nov 2000 21:56:35 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Chip Salzenberg <chip@valinux.com>
Date: Fri, 24 Nov 2000 12:34:53 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14877.50621.10445.237897@notabene.cse.unsw.edu.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, nfs@lists.sourceforge.net
Subject: Re: [PATCH] 2.2.18: d_move() with self-root dentries (Dentry Corruption!)
In-Reply-To: message from Chip Salzenberg on Tuesday November 21
In-Reply-To: <20001121011744.A2147@valinux.com>
        <20001121101836.C7075@valinux.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
        LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
        8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday November 21, chip@valinux.com wrote:
> This may be 2.2.18 material after all....  I wrote last night:
> > Making nfsd's d_splice() compensate for d_move's limitations is not
> > only a kludge, but also it harder to keep nfsd correct.
> > someday, nfsd may not be the only creator of this kind of dentry.
> 
> Sure enough, there is just such a bug *already* in nfsd.  Nfsd's
> cleanup after d_move is incomplete: It handles one of the dentries
> being parentless, but not the other one.  This bug *will* cause dentry
> corruption.[1]  It may well be what's been causing the hangs that my
> recent patches seem to have fixed.
> 
> Therefore, in the mainline kernel, we need either the below patch to
> d_move (along with a trivial simplifcation of nfsd's use of it), or an
> expansion of the kludge in nfsd.  You can guess which one I favor....
> 
> [1] The bug can only show up when reconstructing pruned dentries, and
>     only under a specific pattern of client requests, so it's not
>     surprising that it is rarely observed in the wild.

Hi Chip,
 I am trying to understand what might be going on and why this fix
 might be needed, and I'm not making much progress.

 You suggest that d_move (or it's caller) must be able to deal with
 the target being an "root" dentry (x->d_parent == x). However I
 cannot see that this could possibly happen.

 (looking at 2.2.18pre21 which should be much the same as any othe
 2.2 knfsd..)

 The only place that knfsd calls d_move is in d_splice.
 Here the "dentry" argument is "target" (just to confuse the innocent)
 and this is almost certainly an "root" entry passed in from "splice".
 However the "target" argument is "tdentry" which was just created
 with d_alloc which has given a parent which is certainly non-NULL,
 otherwise we would have an oops much earlier.
 So the parent of the "target" is "parent", which is certainly
 different from "tdentry", so d_move is *not* being asked to
 move something onto a "root" dentry, so the change is not needed.
 

 Did I miss something in the above, or can you in some other way
 convince me that d_move needs to handle is_root targets.

Thanks,
NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
