Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263961AbTDIXnl (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 19:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263968AbTDIXnk (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 19:43:40 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:62341 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263961AbTDIXnh (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 19:43:37 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: davidm@hpl.hp.com
Date: Thu, 10 Apr 2003 09:48:37 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16020.45397.938754.806118@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFSD binary compatibility breakage
In-Reply-To: message from David Mosberger on Tuesday April 8
References: <200304090542.h395gHF5004000@napali.hpl.hp.com>
X-Mailer: VM 7.13 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday April 8, davidm@napali.hpl.hp.com wrote:
> Neil,
> 
> The removal of "struct nfsctl_uidmap" from "nfsctl_fdparm" broke
> binary compatiblity on 64-bit platforms (strictly speaking: on all
> platforms with alignof(void *) > alignof(int)).  The problem is that
> nfsctl_uidmap contained a "char *", which forced the alignment of the
> entire union to be 64 bits.  With the removal of the uidmap, the
> required alignment drops to 32 bits.  Since the first member is only
> 32 bits in size, this breaks compatibility with user-space.  Patch
> below fixes the problem.

Hmm... just another reason to get rid of these binary interfaces!  I
plan to rip them all out in 2.7.1.  But for now I'll try to keep them
going as best I can.  Thanks for the patch.

NeilBrown

> 
> Thanks,
> 
> 	--david
> 
> ===== include/linux/nfsd/syscall.h 1.4 vs edited =====
> --- 1.4/include/linux/nfsd/syscall.h	Sun Mar 23 14:35:20 2003
> +++ edited/include/linux/nfsd/syscall.h	Tue Apr  8 22:36:59 2003
> @@ -91,6 +91,13 @@
>  		struct nfsctl_export	u_export;
>  		struct nfsctl_fdparm	u_getfd;
>  		struct nfsctl_fsparm	u_getfs;
> +		/*
> +		 * The following dummy member is needed to preserve binary compatibility
> +		 * on platforms where alignof(void*)>alignof(int).  It's needed because
> +		 * this union used to contain a member (u_umap) which contained a
> +		 * pointer.
> +		 */
> +		void *u_ptr;
>  	} u;
>  #define ca_svc		u.u_svc
>  #define ca_client	u.u_client
