Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264833AbUFGQHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264833AbUFGQHo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 12:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264851AbUFGQHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 12:07:44 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:65237 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264833AbUFGQHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 12:07:31 -0400
Date: Mon, 7 Jun 2004 18:03:33 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, weigand@i1.informatik.uni-erlangen.de,
       gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
Message-ID: <20040607160333.GA3521@wohnheim.fh-wedel.de>
References: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de> <20040401220957.5f4f9ad2.ak@suse.de> <20040401163715.3592cedc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040401163715.3592cedc.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 April 2004 16:37:15 -0800, Andrew Morton wrote:
> 
> I think this will cause the inode timestamps to keep on creeping forwards.
> 
> How about in ext3_read_inode() you do:
> 
> 	inode->i_atime.tv_sec = le32_to_cpu(raw_inode->i_atime);
> 	inode->i_ctime.tv_sec = le32_to_cpu(raw_inode->i_ctime);
> 	inode->i_mtime.tv_sec = le32_to_cpu(raw_inode->i_mtime);
> -	inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec = inode->i_mtime.tv_nsec = 0;
> +	inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec = inode->i_mtime.tv_nsec = 999999999;

Coming in way too late, how about changing the other end?  Each
filesystem provides a new function that transforms high resolution
time into whatever the filesystem can store.  If the function is NULL,
we use a sane default like above.
-	inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec = inode->i_mtime.tv_nsec = 0;

If the user never sees the high resolution in the first place, we
don't need to play guessing games later, after data has been flushed
from the page cache.

Jörn

-- 
The competent programmer is fully aware of the strictly limited size of
his own skull; therefore he approaches the programming task in full
humility, and among other things he avoids clever tricks like the plague. 
-- Edsger W. Dijkstra
