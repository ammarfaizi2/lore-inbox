Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263162AbUEGGsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbUEGGsJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 02:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbUEGGsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 02:48:09 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:38540 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S263162AbUEGGsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 02:48:06 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Oliver Tennert <tennert@science-computing.de>
Date: Fri, 7 May 2004 16:47:56 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16539.12572.90447.543633@cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH [NFSd] NFSv3/TCP
In-Reply-To: message from Oliver Tennert on Friday May 7
References: <Pine.LNX.4.44.0405070834001.4547-100000@picard.science-computing.de>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday May 7, tennert@science-computing.de wrote:
> Hi Neil (and others),
> 
> is there any reason why current 2.4 kernels do not allow for
> NFSSVC_MAXBLKSIZE to become as large as 32k?

Yes.
At server thread creation, you need to be able to
   kmalloc(NFSSVC_MAXBLKSIZE+1024)
(or close to that) once per thread.  On most architectures this is a
high-order alloc_pages and can often fail.
Also, on every UDP write request, the server needs to 'kmalloc' a buffer
to hold the whole request (actually on every request that is
fragmented, but write is most common).  On most architectures, this
kmalloc will again require allocative several contiguous pages, which
can fail.

So this patch is only safe if you have a large-patch arch or only use
NFS over TCP.

There was once a patch floating around which allowed a larger
NFSSVC_MAXBLKSIZE on architectures with large page sizes, but it never
got properly submitted I think.


> 
> The problem is when I use NFSv3/TCP with a 2.4.25, say, on the server
> side, as well as on the client side, I am experiencing lockups when
> copying medium-sized or large files from the NFS fs to a local fs.

There must be some other cause.  Increasing the NFSSVC_MAXBLKSIZE is
just hiding a real problem I suspect.

NeilBrown
