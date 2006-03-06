Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWCFHbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWCFHbZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 02:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbWCFHbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 02:31:25 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:31915 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750972AbWCFHbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 02:31:25 -0500
Date: Mon, 6 Mar 2006 09:31:22 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Phillip Susi <psusi@cfl.rr.com>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] udf: fix uid/gid options and add uid/gid=ignore and
 forget options
In-Reply-To: <440B8C16.4050008@cfl.rr.com>
Message-ID: <Pine.LNX.4.58.0603060924450.11070@sbz-30.cs.Helsinki.FI>
References: <4409EB37.5050308@cfl.rr.com> <84144f020603051122k33872fa7p1e7baebcc2b67cda@mail.gmail.com>
 <440B8C16.4050008@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillip,

On Sun, 5 Mar 2006, Phillip Susi wrote:
> My bad, I meant to remove those ifs, not just prepend them with an else.  Try
> this one:
> 
> c8393f6e4fe6159fd916f3c68091e76bbfdc5fd8
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index 395e582..49aeac3 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -1045,10 +1045,12 @@ static void udf_fill_inode(struct inode        }
> 
>        inode->i_uid = le32_to_cpu(fe->uid);
> -      if ( inode->i_uid == -1 ) inode->i_uid = UDF_SB(inode->i_sb)->s_uid;
> +      if ( inode->i_uid == -1 || UDF_QUERY_FLAG(inode->i_sb,
> UDF_FLAG_UID_IGNORE) )
> +        inode->i_uid = UDF_SB(inode->i_sb)->s_uid;

Formatting.

>        inode->i_gid = le32_to_cpu(fe->gid);
> -      if ( inode->i_gid == -1 ) inode->i_gid = UDF_SB(inode->i_sb)->s_gid;
> +      if ( inode->i_gid == -1 || UDF_QUERY_FLAG(inode->i_sb,
> UDF_FLAG_GID_IGNORE) )
> +        inode->i_gid = UDF_SB(inode->i_sb)->s_gid;

Same here.

>        inode->i_nlink = le16_to_cpu(fe->fileLinkCount);
>        if (!inode->i_nlink)
> @@ -1335,11 +1337,13 @@ udf_update_inode(struct inode *inode, in
>        return err;
>        }
> 
> -      if (inode->i_uid != UDF_SB(inode->i_sb)->s_uid)
> -      fe->uid = cpu_to_le32(inode->i_uid);
> -
> -      if (inode->i_gid != UDF_SB(inode->i_sb)->s_gid)
> -      fe->gid = cpu_to_le32(inode->i_gid);
> +      if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_UID_FORGET))
> +        fe->uid = cpu_to_le32(-1);
> +      else fe->uid = cpu_to_le32(inode->i_uid);

This is better, but if id was -1 on disk, we're overriding it unless the 
forget mount option was specified. Do we want that? I think my patch is a 
better fix (if it works anyway) and yours should be on top of that. Did 
you have the chance to test it?

Also, formatting is, wrong, just make it

	if (forget)
		fe->uid = ...;
	else
		fe->uid = ...;

> +      if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_GID_FORGET))
> +        fe->gid = cpu_to_le32(-1);
> +      else fe->gid = cpu_to_le32(inode->i_gid);
> 
>        udfperms =      ((inode->i_mode & S_IRWXO)     ) |
>        ((inode->i_mode & S_IRWXG) << 2) |

Same here.

Please document the new mount options in Documentation/filesystems/udf.txt.

			Pekka
