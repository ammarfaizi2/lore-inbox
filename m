Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263574AbUESK6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbUESK6b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 06:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbUESK6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 06:58:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60805 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263574AbUESK63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 06:58:29 -0400
Date: Wed, 19 May 2004 06:58:06 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: sendfile -EOVERFLOW on AMD64
Message-ID: <20040519105805.GK30909@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <1XuW9-3G0-23@gated-at.bofh.it> <m3d650wys1.fsf@averell.firstfloor.org> <20040519103855.GF18896@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040519103855.GF18896@fi.muni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 12:38:56PM +0200, Jan Kasprzak wrote:
> Andi Kleen wrote:
> : Jan Kasprzak <kas@informatics.muni.cz> writes:
> : >
> : > The image (FC2-i386-DVD.iso) has 4370640896 bytes. The FTP server is native
> : > x86_64 binary, not a 32-bit one.
> : 
> : sys_sendfile limits itself dumbly to 2GB even on 64bit architectures.
> : This patch should fix it on x86-64, although other 64bit ports may 
> : need a similar patch. Just removing the limit in read_write 
> : is not easy, because it would need fixes in all the 32bit emulation
> : layers.
> : 
> 	It partly helped, thanks. But there is still one more problem
> - it looks like sendfile() returns 32-bit value instead of 64-bit.
> My debug info looks like this:
> 
> sendfile(offset=0, count=4370640896)
>     = -767073160, offset=3527894136
> 
> where I do
> 
> 	long val = sendfile(...); printf(...%ld..., val);

What filesystem you're using?
For XFS I'd expect this:
STATIC ssize_t
linvfs_sendfile(
        struct file             *filp,
        loff_t                  *ppos,
        size_t                  count,
        read_actor_t            actor,
        void                    *target)
{
        vnode_t                 *vp = LINVFS_GET_VP(filp->f_dentry->d_inode);
        int                     error;

        VOP_SENDFILE(vp, filp, ppos, 0, count, actor, target, NULL, error);
        return error;
}

(note error is int, not ssize_t), but I don't see anything obvious
for other filesystems.

	Jakub
