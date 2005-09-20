Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbVITH15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbVITH15 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 03:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932759AbVITH15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 03:27:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37045 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932755AbVITH14
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 03:27:56 -0400
Date: Tue, 20 Sep 2005 08:27:55 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Ram <linuxram@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       miklos@szeredi.hu, mike@waychison.com, bfields@fieldses.org,
       serue@us.ibm.com
Subject: Re: [RFC PATCH 6/10] vfs: shared subtree aware move mounts
Message-ID: <20050920072755.GJ7992@ftp.linux.org.uk>
References: <20050916182620.GA28504@RAM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050916182620.GA28504@RAM>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 11:26:20AM -0700, Ram wrote:
> Patch that help move a mount tree to a different mountpoint. The tree can
> contain any combination of shared/slave/private/unclonable mounts.

OK, that answers the question about MS_MOVE...  Please, add brute-force
"we don't allow it other than in trivial case" *before* the previous
patch, replacing it with the right thing here.

BTW, I suspect that a look at operations on ->mnt_list and friends you
have in the entire thing would bring several inlined helpers covering
most of the instances; there's definitely too much raw list_add(), etc.
instances in the current code.

> +/*
> + * return 1 if the mount tree contains a unclonable mount
> + */
> +static inline int tree_contains_unclone(struct vfsmount *mnt)
> +{
> +	struct vfsmount *p;
> +	for (p = mnt; p; p = next_mnt(p, mnt)) {
> +		if (IS_MNT_UNCLONABLE(p))
> +			return 1;
> +	}
> +	return 0;
> +}

FWIW, such helpers should probably go in the same place where you
introduce unclonable - they won't complicate earlier patch and will
be in place there and they won't clutter this one anymore.
