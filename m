Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWFRSdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWFRSdW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 14:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWFRSdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 14:33:22 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35770 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751212AbWFRSdV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 14:33:21 -0400
Date: Sun, 18 Jun 2006 19:33:20 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       herbert@13thfloor.at
Subject: Re: [RFC][PATCH 03/20] Add vfsmount writer count
Message-ID: <20060618183320.GZ27946@ftp.linux.org.uk>
References: <20060616231213.D4C5D6AF@localhost.localdomain> <20060616231215.09D54036@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060616231215.09D54036@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2006 at 04:12:15PM -0700, Dave Hansen wrote:
> +/*
> + * Must be called under write lock on mnt->mnt_sb->s_umount,
> + * this prevents concurrent decrements which could make the
> + * value -1, and test in mnt_want_write() wrongly succeed
> + */
> +static inline int mnt_make_readonly(struct vfsmount *mnt)
> +{
> +	if (!atomic_dec_and_test(&mnt->mnt_writers)) {
> +		atomic_inc(&mnt->mnt_writers);
> +		return -EBUSY;
> +	}
> +	return 0;
> +}

Check in faccessat() could get screwed by that, if you just lose the
race with final writer going away.  Then mnt_make_readonly() will 
fail (as it should) and access(2) give -EROFS.
