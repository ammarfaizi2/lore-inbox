Return-Path: <linux-kernel-owner+w=401wt.eu-S1161068AbXALVOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161068AbXALVOv (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 16:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbXALVOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 16:14:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59363 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030484AbXALVOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 16:14:49 -0500
Message-ID: <45A7FA3C.8030209@redhat.com>
Date: Fri, 12 Jan 2007 15:14:36 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext4 development <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] [RFC] remove ext3 inode from orphan list when link and
 unlink race
References: <45A7F384.3050303@redhat.com> <m34pqw0xii.fsf@bzzz.home.net>
In-Reply-To: <m34pqw0xii.fsf@bzzz.home.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
> interesting ..
> 
> I thought VFS doesn't allow concurrent operations.
> if unlink goes first, then link should wait on the
> parent's i_mutex and then found no source name.
> 
> thanks, Alex

Well... I was wondering that myself, whether this race should even
happen.  But the bottom of do_unlinkat looks like:

        mutex_unlock(&nd.dentry->d_inode->i_mutex);
        if (inode)
                iput(inode);    /* truncate the inode here */
exit1:
        path_release(&nd);
exit:
        putname(name);
        return error;

so I think it's possible that link can sneak in there & find it after
the mutex is dropped...?  Is this ok? :)  It's certainly -happening-
anyway....

-Eric
