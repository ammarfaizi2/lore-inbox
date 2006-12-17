Return-Path: <linux-kernel-owner+w=401wt.eu-S1752191AbWLQHsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbWLQHsZ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 02:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbWLQHsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 02:48:25 -0500
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:43775 "EHLO
	liaag1ad.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752191AbWLQHsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 02:48:24 -0500
Date: Sun, 17 Dec 2006 02:43:35 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.18.5 usb/sysfs bug.
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Message-ID: <200612170245_MC3-1-D556-211B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20061216141828.GA23368@redhat.com>

On Sat, 16 Dec 2006 09:18:28 -0500, Dave Jones wrote:

>  > That's strange.  Remove_files called sysfs_hash_and_remove()
>  > with dir==0xfffffff3 (-13 decimal.)
> 
> Hmm, That's -EACCESS.  Something not checking a return code at a lower
> level maybe ?

In fs/sysfs/group.c:

void sysfs_remove_group(struct kobject * kobj,
                        const struct attribute_group * grp)
{
        struct dentry * dir;

        if (grp->name)
                dir = lookup_one_len(grp->name, kobj->dentry,
                                strlen(grp->name));
        else
                dir = dget(kobj->dentry);

        remove_files(dir,grp);
        if (grp->name)
                sysfs_remove_subdir(dir);
        /* release the ref. taken in this routine */
        dput(dir);
}

'dir' is being used without checking whether lookup_one_len()
succeeded.

> It's odd that something disconnects during boot, as nothing gets plugged.

Sometimes notebooks have USB devices built-in and they get treated
as if they were hotplugged.

-- 
MBTI: IXTP

