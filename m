Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287407AbSACWND>; Thu, 3 Jan 2002 17:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288332AbSACWMw>; Thu, 3 Jan 2002 17:12:52 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:478 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S287420AbSACWLj>;
	Thu, 3 Jan 2002 17:11:39 -0500
Date: Thu, 3 Jan 2002 17:11:37 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: State of the new config & build system 
In-Reply-To: <21246.1010094652@ocs3.intra.ocs.com.au>
Message-ID: <Pine.GSO.4.21.0201031653420.23693-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Jan 2002, Keith Owens wrote:

> * Mount COW layer over clean tree.
> * Edit a file, writing to the COW layer.
> * Build the kernel.
> * Decide that you don't want the change, delete the COW version,
>   exposing the original version of the file, timestamp goes backwards.

ITYM "creating a whiteout entry".  unlink() on unionfs doesn't expose
the underlying object.

It looks so:

	* each directory in covering layer has a flag (is_transparent)
	* all children of non-transparent directory are non-transparent
	* lookup in non-transparent directory is a usual lookup in covering
layer.
	* lookup in transparent directory
		lookup in covering layer
		if found an object -> return it
		else if found whiteout -> no entry
		else
			do lookup in covered
			if not found -> no entry
			else if found is a directory
				create a directory in covering
				mark it transparent
				return new directory
			else -> return what we found
	* mkdir creates non-transparent directories
	* unlink and rmdir leave whiteout entry
	* attempt to modify file copies it into covering and modifies that copy.

That gives you real copy-on-write semantics - when you remove object it
stays removed; rm -rf foo && mkdir foo gives you an empty directory, etc.
rename() support is messy - especially when it comes to renaming directories
(if it was transparent you need to copy the entire subtree to covering layer).

Whiteouts are usually represented as directory entries with no inode and
type of entry being DT_WHT (14).  Adding support of these beasts into
ext2 is ~ 10 lines of patch.

