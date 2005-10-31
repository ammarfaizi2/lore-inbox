Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbVJaKlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbVJaKlq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 05:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbVJaKlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 05:41:46 -0500
Received: from cantor2.suse.de ([195.135.220.15]:32956 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932262AbVJaKlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 05:41:45 -0500
From: Neil Brown <neilb@suse.de>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Date: Mon, 31 Oct 2005 21:41:39 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17253.62691.329651.957821@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH against 2.6.14] truncate() or ftruncate shouldn't
	change mtime if size doesn't change.
In-Reply-To: message from Anton Altaparmakov on Monday October 31
References: <20051031173358.9566.patches@notabene>
	<1051031063444.9586@suse.de>
	<20051030234837.36c7a249.akpm@osdl.org>
	<1130752124.7504.13.camel@imp.csi.cam.ac.uk>
	<1130753819.7504.21.camel@imp.csi.cam.ac.uk>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday October 31, aia21@cam.ac.uk wrote:
> 
> In may_open() only truncate when O_TRUNC is set and the file size is not
> zero.

No, this is wrong.  open( ..,O_TRUNC) needs to update the mtime, even
if the file is already size==0.

What started me looking at this is that open( O_TRUNC) over NFS
*doesn't* update the mtime on an empty file, which is inconsistent
with local file systems, and dis-obeys SUS:

http://www.opengroup.org/onlinepubs/007908799/xsh/open.html
 
   "If O_TRUNC is set and the file did previously exist, upon
   successful completion, open() will mark for update the st_ctime and
   st_mtime fields of the file. "

So we DO NOT want this change to may_open (and we DO want a different
change in NFS which I have asked Trond to submit... To be honest, this
first came up a couple of months ago, and Trond suggested a patch
then, but it didn't get any further.  I'm just trying to make sure the
important bits do make it into the kernel..
 http://lkml.org/lkml/2005/8/31/134
)

NeilBrown



> --- linux-2.6/fs/namei.c.old	2005-10-31 09:28:38.000000000 +0000
> +++ linux-2.6/fs/namei.c	2005-10-31 09:30:39.000000000 +0000
> @@ -1447,7 +1447,7 @@ int may_open(struct nameidata *nd, int a
>  	if (error)
>  		return error;
>  
> -	if (flag & O_TRUNC) {
> +	if (flag & O_TRUNC && i_size_read(inode)) {
>  		error = get_write_access(inode);
>  		if (error)
>  			return error;
> 
