Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWFTQZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWFTQZF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWFTQZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:25:04 -0400
Received: from mx1.mail.ru ([194.67.23.121]:24160 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S1751368AbWFTQZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:25:03 -0400
Date: Tue, 20 Jun 2006 20:30:31 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5]: ufs: missed brelse and wrong baseblk
Message-ID: <20060620163031.GA17675@rain.homenetwork>
Mail-Followup-To: Al Viro <viro@ftp.linux.org.uk>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <20060617101403.GA22098@rain.homenetwork> <20060618162054.GW27946@ftp.linux.org.uk> <20060618175045.GX27946@ftp.linux.org.uk> <20060619064721.GA6106@rain.homenetwork> <20060619073229.GI27946@ftp.linux.org.uk> <20060619131750.GA14770@rain.homenetwork> <20060619182833.GJ27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619182833.GJ27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 07:28:33PM +0100, Al Viro wrote:
> But now we have the buffer_heads on page 0 in the state inconsistent with
> the reality - basically, fs/buffer.c helpers will assume that they are
> _still_ in the second state (known to be in hole), while in the reality
> they should be either in the first or in the third one (mapped to known
> disk block or not known).
> 
> It's not a fundamental problem; 
And if we'll write after that to 0th page,
data with size <=page size, we can get garbage(not zeroes) 
on the rest of page.

Definitely, after block allocation, 
we should touch pages from inode cache,
which belongs to block except current page.

>however, it does mean that using these
> helpers means using library functions in situation they'd never been designed
> for.  IOW, you need very careful analysis of the assumptions made by
> the entire bunch and, quite possibly, need versions modified for UFS.
May be there is some incomprehension here,
this series and all other my patches in -mm related to UFS
is not introduced write support for UFS, they fixes
bugs similar to which you point out in black corners 
of the existing implementation.

Note: almost all such bugs related to 
touch blockdev's cache instead of inode's cache, and working
with blockdev's buffer cache without take into consideration
that it's also page cache).

-- 
/Evgeniy

