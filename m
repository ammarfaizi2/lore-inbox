Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265711AbSKFPSz>; Wed, 6 Nov 2002 10:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265715AbSKFPSz>; Wed, 6 Nov 2002 10:18:55 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:52239 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S265711AbSKFPSx>; Wed, 6 Nov 2002 10:18:53 -0500
Message-Id: <200211061519.gA6FJXp13811@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove extern inline from quotaops.h
Date: Wed, 6 Nov 2002 18:11:19 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Marco van Wieringen <mvw@planets.elm.net>
References: <20021104141317.A29058@mookie.adilger.int>
In-Reply-To: <20021104141317.A29058@mookie.adilger.int>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 November 2002 19:13, Andreas Dilger wrote:
> We are having a strange problem with compiling ext3 code out-of-tree,
> and it is related to the fact that several functions in quotaops.h
> are declared "extern __inline__" instead of "static inline".  Is
> there a good reason to have it that way?  I thought "extern
> __inline__" was sort of frowned upon.
>
> Below is a patch to change this to "static inline".  A similar patch
> is needed for 2.5, but the file has changed significantly...

What is your gcc version?

Mine is 3.2, and it sometimes de-inline large inline functions.
That is, static inlines turn into simple static. And extern inlines
in dangling extern references, that's what bite you maybe ;)

Do not blindly fix it, think of it as a warning:
"gcc: your inline is too large"

For example,

static __inline__ int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
{
        lock_kernel();
        if (sb_any_quota_enabled(inode->i_sb)) {
                /* Used space is updated in alloc_space() */
                if (inode->i_sb->dq_op->alloc_space(inode, nr, 0) == NO_QUOTA) {
                        unlock_kernel();
                        return 1;
                }
        }
        else
                inode_add_bytes(inode, nr);
        unlock_kernel();
        return 0;
}

static __inline__ int DQUOT_ALLOC_SPACE(struct inode *inode, qsize_t nr)
{
        int ret;
        if (!(ret = DQUOT_ALLOC_SPACE_NODIRTY(inode, nr)))
                mark_inode_dirty(inode);
        return ret;
}

Don't you think DQUOT_ALLOC_SPACE is _way too large_ to inline?
Did you look at generated assembly to get a feeling of it's size?
--
vda
