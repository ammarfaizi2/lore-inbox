Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315568AbSEIAI3>; Wed, 8 May 2002 20:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315569AbSEIAI2>; Wed, 8 May 2002 20:08:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24580 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315568AbSEIAI2>;
	Wed, 8 May 2002 20:08:28 -0400
Message-ID: <3CD9BDBC.A5B52E8C@zip.com.au>
Date: Wed, 08 May 2002 17:07:24 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Reading page from given block device
In-Reply-To: <20020508204809.GA2300@elf.ucw.cz> <3CD996E5.BFB5CF9E@zip.com.au> <20020508225603.GA11842@atrey.karlin.mff.cuni.cz> <3CD9AE15.114D13E3@zip.com.au> <20020508231520.GC11842@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> ...
> Second try:
> 
> c0134a28 -- __getblk
>             __get_hash_table

hmm.  It looks like your blockdev may have the wrong
blocksize in bd_inode->i_blkbits, and __get_hash_table
cannot find the 4k block against the 1k blocksize device.
It keeps returning zero.

The new pagecache-based __get_hash_table uses bd_inode->i_blkbits
to go from a block number to a pagecache index.  That works
fine when called via the official `bread()' function, but 
probably your __bread() approach has confused it.

Try running set_blocksize(bdev, PAGE_SIZE) before calling
__bread().  


-
