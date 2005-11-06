Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbVKFV5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbVKFV5A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 16:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbVKFV5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 16:57:00 -0500
Received: from cantor.suse.de ([195.135.220.2]:20168 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932258AbVKFV47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 16:56:59 -0500
From: Neil Brown <neilb@suse.de>
To: Andre Noll <maan@systemlinux.org>
Date: Mon, 7 Nov 2005 08:56:53 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17262.31781.497775.640424@cse.unsw.edu.au>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: BUG: soft lockup detected on CPU#0! (linux-2.6.14)
In-Reply-To: message from Andre Noll on Sunday November 6
References: <20051106193142.GD26862@skl-net.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday November 6, maan@systemlinux.org wrote:
> Hi
> 
> I regularly get these on the current 2.6.14 kernel under heavy load.
> Backtrace differs, but nfsd is always involved:
> 
> Nov  4 12:46:44 p133 kernel: BUG: soft lockup detected on CPU#0!

This seems to suggest that the nfsd thread is always runnable, which
implies a read-only load with everything in cache - at least for the
10 seconds leading up to each of these errors.  Is that likely?

The following patch might fix it.  Please let me know the result.

Thanks,
NeilBrown


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/svcsock.c |    1 +
 1 file changed, 1 insertion(+)

diff ./net/sunrpc/svcsock.c~current~ ./net/sunrpc/svcsock.c
--- ./net/sunrpc/svcsock.c~current~	2005-11-07 08:53:40.000000000 +1100
+++ ./net/sunrpc/svcsock.c	2005-11-07 08:53:48.000000000 +1100
@@ -1181,6 +1181,7 @@ svc_recv(struct svc_serv *serv, struct s
 	arg->tail[0].iov_len = 0;
 
 	try_to_freeze();
+	cond_resched();
 	if (signalled())
 		return -EINTR;
 
