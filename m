Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbVLAMjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVLAMjv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 07:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbVLAMjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 07:39:51 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:50118 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932192AbVLAMju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 07:39:50 -0500
Date: Thu, 1 Dec 2005 13:39:53 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Takashi Sato <sho@bsd.tnes.nec.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: stat64 for over 2TB file returned invalid st_blocks
Message-ID: <20051201123953.GA24519@wohnheim.fh-wedel.de>
References: <01e901c5f66e$d4551b70$4168010a@bsd.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01e901c5f66e$d4551b70$4168010a@bsd.tnes.nec.co.jp>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 December 2005 21:00:26 +0900, Takashi Sato wrote:
> 
> I found a problem at stat64 on 32bit architecture.
> 
> When I called stat64 for a file which is larger than 2TB, stat64
> returned an invalid number of blocks at st_blocks on 32bit
> architecture, although it returned a valid number of blocks on 64bit
> architecture(ia64).

My take was to simply hold a u64 in the fs-private inode structure and
use ULONG_MAX for inode->i_blocks in case of an overflow.  Also has
the nice advantage of working with fs-sized blocks, not 512-byte ones:
	inode->i_blocks = ULONG_MAX;
	if (li->li_blocks<<3 < ULONG_MAX)
		inode->i_blocks = li->li_blocks<<3;

That said, your solution appears to be much better, as long as it
doesnt subtly break binary compatibility.

Jörn

-- 
ticks = jiffies;
while (ticks == jiffies);
ticks = jiffies;
-- /usr/src/linux/init/main.c
