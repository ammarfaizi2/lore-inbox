Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265355AbTA1NI4>; Tue, 28 Jan 2003 08:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265378AbTA1NI4>; Tue, 28 Jan 2003 08:08:56 -0500
Received: from [198.149.18.6] ([198.149.18.6]:36561 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S265355AbTA1NIy>;
	Tue, 28 Jan 2003 08:08:54 -0500
Subject: Re: [CHECKER] 87 potential array bounds error/buffer overruns in
	2.5.53
From: Stephen Lord <lord@sgi.com>
To: Yichen Xie <yxie@cs.stanford.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mc@cs.stanford.edu
In-Reply-To: <000001c2c5a4$5c4465d0$09830c80@stanfordja31z2>
References: <000001c2c5a4$5c4465d0$09830c80@stanfordja31z2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 Jan 2003 07:16:49 -0600
Message-Id: <1043759811.1374.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-26 at 19:35, Yichen Xie wrote:
> Hi all,
> 
> Attached are 87 potential buffer overruns in 2.5.53. Most arise from
> improper bounds checks, and some might be security holes where the array
> index comes from an untrusted source (e.g. copy_from_user). In the bug
> report, "len" refers to the length of the array or buffer being
> accessed, and "off" refers to the offset/index that is being used to
> access it. (off >= len) corresponds to a buffer overrun, while (off < 0)
> signals an underrun.
> 
> As always, confirmations and comments will be appreciated.
> 
> Yichen
> 

> [BUG] what if level < 0?
> /home/yxie/linux-2.5.53/fs/xfs/xfs_bmap_btree.c:1364:xfs_bmbt_lshift:
> ERROR:BUFFER:1364:1364:Array bounds error (off < 0)
> ((*cur).bc_ptrs[level], max(off) = -1) 
> 	}
> 	if ((error = xfs_bmbt_updkey(cur, rkp, level + 1))) {
> 		XFS_BMBT_TRACE_CURSOR(cur, ERROR);
> 		return error;
> 	}
> 
> Error --->
> 	cur->bc_ptrs[level]--;
> 	XFS_BMBT_TRACE_CURSOR(cur, EXIT);
> 	*stat = 1;
> 	return 0;

Hi,

I took a look at the callers of this code, level is always being passed
in as 0 or greater. Looking at it, we should really be using an unsigned
int for this variable.

Interesting that this is the only one in the file which showed up, there
are lots of array dereferences using level as the index in this file.

Steve


