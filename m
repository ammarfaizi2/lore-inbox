Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbWHCAU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWHCAU6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 20:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWHCAU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 20:20:58 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:26548 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750847AbWHCAU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 20:20:57 -0400
Date: Wed, 2 Aug 2006 17:20:38 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk, herbert@13thfloor.at,
       hch@infradead.org
Subject: Re: [PATCH 04/28] OCFS2 is screwy
Message-ID: <20060803002038.GI29686@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20060801235240.82ADCA42@localhost.localdomain> <20060801235243.EA4890B4@localhost.localdomain> <20060802021411.GG29686@ca-server1.us.oracle.com> <1154488906.7232.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154488906.7232.20.camel@localhost.localdomain>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 08:21:46PM -0700, Dave Hansen wrote:
> Please ignore that last one.  It didn't correctly handle directories'
> with a remaining i_nlink of 2.
Oops, one more minor thing wrong with this patch:


> @@ -823,16 +835,6 @@
>  		}
>  	}
>  
> -	/* There are still a few steps left until we can consider the
> -	 * unlink to have succeeded. Save off nlink here before
> -	 * modification so we can set it back in case we hit an issue
> -	 * before commit. */
> -	saved_nlink = inode->i_nlink;
> -	if (S_ISDIR(inode->i_mode))
> -		inode->i_nlink = 0;
> -	else
> -		inode->i_nlink--;
> -
>  	status = ocfs2_request_unlink_vote(inode, dentry,
>  					   (unsigned int) inode->i_nlink);
The network request above needs to send what the new nlink will be set to.
This is so that the other nodes which have an interest in the inode can
determine whether the will need to do orphan processing on their last iput.

Really what they do is just compare against zero and mark the inode with a
flag indicating that it may have been orphaned. So we could just pass the
result of inode_is_unlinkable(), but I'd rather preserve the behavior that
we have today.

The ugly method is:

-  	status = ocfs2_request_unlink_vote(inode, dentry,
-  					   (unsigned int) inode->i_nlink);
+   	status = ocfs2_request_unlink_vote(inode, dentry,
+  		S_ISDIR(inode->i_mode) && inode->i_nlink == 2 ? 0 : inode->i_nlink - 1);

Better yet, we could store the result of the evaluation in a temporary
variable and pass that through to the request function.

Thanks,
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
