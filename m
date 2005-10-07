Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030504AbVJGQop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030504AbVJGQop (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 12:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030506AbVJGQop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 12:44:45 -0400
Received: from mail.fieldses.org ([66.93.2.214]:7360 "EHLO pickle.fieldses.org")
	by vger.kernel.org with ESMTP id S1030504AbVJGQoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 12:44:44 -0400
Date: Fri, 7 Oct 2005 12:44:35 -0400
To: Steve Dickson <SteveD@redhat.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH] kNFSD - Allowing rpc.nfsd to setting of the port, transport and version the server will use
Message-ID: <20051007164435.GC9759@fieldses.org>
References: <43469FA7.7020908@RedHat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43469FA7.7020908@RedHat.com>
User-Agent: Mutt/1.5.11
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2005 at 12:17:43PM -0400, Steve Dickson wrote:
> Here is a kernel patch that will enable the setting
> of the port knfsd will listens on, the transport knfsd
> will support and which NFS version will be advertised.
> 
> The nfs-utils patch, which is also attached, will added
> the following flags to rpc.nfsd that will enable the kernel
> functionality (Note: These patches are NOT dependent on each
> other. Meaning rpc.nfsd and knfsd will still function correctly
> if one or the other patch do or do not exist):
> 
> 
>    -N  or  --no-nfs-version vers
>         This option can be used to request that rpc.nfsd does not  offer
>         certain  versions of NFS. The current version of rpc.nfsd can
>         support both NFS version 2,3 and the newer version 4.

So the obvious question is what will happen if someone does

	rpc.nfsd -N 3

on a server supporting 2, 3, and 4.

It looks like the code in svc_create() will set pg_lovers to 2 and
pg_hivers to 4 in that case.  So if someone tries to use version 3, the
error they get back will be a somewhat contradictory "sorry, I only
support versions 2 through 4."

It seems to me that it'd be cleaner if the kernel interface only
accepted a range (e.g., "2--4" or "2--3").  Then if someone
attempted the above, they'll get an error back immediately.

Or svc_create could be adjusted to report a more conservative range
("2--2" or "4--4" instead of "2--4").

But I don't have really strong feelings about it.  Maybe we shouldn't
care enough about that case.

--b.
