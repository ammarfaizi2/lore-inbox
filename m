Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313300AbSDLBif>; Thu, 11 Apr 2002 21:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313302AbSDLBie>; Thu, 11 Apr 2002 21:38:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49680 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313300AbSDLBie>; Thu, 11 Apr 2002 21:38:34 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [prepatch] address_space-based writeback
Date: Fri, 12 Apr 2002 01:37:27 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a95don$m5p$1@penguin.transmeta.com>
In-Reply-To: <3CB4203D.C3BE7298@zip.com.au> <20020410221211.GA6076@ravel.coda.cs.cmu.edu> <5.1.0.14.2.20020410235415.03d41d00@pop.cus.cam.ac.uk> <5.1.0.14.2.20020412015633.01f1f3c0@pop.cus.cam.ac.uk>
X-Trace: palladium.transmeta.com 1018575500 27878 127.0.0.1 (12 Apr 2002 01:38:20 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 12 Apr 2002 01:38:20 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <5.1.0.14.2.20020412015633.01f1f3c0@pop.cus.cam.ac.uk>,
Anton Altaparmakov  <aia21@cam.ac.uk> wrote:
>At 21:20 11/04/02, Linus Torvalds wrote:
>>
>>It's not Andrew who is assuming anything: it _is_. Look at <linux/fs.h>,
>>and notice the
>>
>>         struct inode            *host;
>>
>>part.
>
>Yes I know that. Why not extend address spaces beyond being just inode 
>caches? An address space with its mapping is a very useful generic data 
>cache object.

Sure it is. And at worst you'll just have to have a dummy inode to
attach to it.

Could we split up just the important fields and create a new level of
abstraction? Sure.  But since there are no major users, and since it
would make the common case less readable, there simply isn't any point. 

Over-abstraction is a real problem - it makes the code less obvious, and
if there is no real gain from it then over-abstracting things is a bad
thing. 

>Just a very basic example: Inode 0 on ntfs is a file named $MFT. It 
>contains two data parts: one containing the actual on-disk inode metadata 
>and one containing the inode allocation bitmap. At the moment I have placed 
>the inode metadata in the "normal" inode address_space mapping and of 
>course ->host points back to inode 0. But for the inode allocation bitmap I 
>set ->host to the current ntfs_volume structure instead and I am at present 
>using a special readpage function to access this address space.

Why not just allocate a separate per-volume "bitmap" inode? It makes
sense, and means that you can then use all the generic routines to let
it be automatically written back to disk etc. 

Also, don't you get the "ntfs_volume" simply through "inode->i_sb"? It
looks like you're just trying to save off the same piece of information
that you already have in another place. Redundancy isn't a virtue.

>The mere fact that the VM requires to know the size of the data in an 
>address space just indicates to me that struct address_space ought to 
>contain a size field in it.

It doesn't "require" it - in the sense that you can certainly use
address spaces without using those routines that assume that it has an
inode.  It just means that you don't get the advantage of the
higher-level concepts. 

>So while something should be fixed I think it is the kernel and not ntfs. (-;

There are a few fundamental concepts in UNIX, and one of them is
"everything is a file".

And like it or not, the Linux concept of a file _requires_ an inode (it
also requires a dentry to describe the path to that inode, and it
requires the "struct file" itself). 

The notion of "struct inode" as the lowest level of generic IO entity is
very basic in the whole design of Linux.  If you try to avoid it, you're
most likely doing something wrong.  You think your special case is
somehow independent and more important than one of the basic building
blocks of the whole system. 

			Linus
