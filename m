Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268537AbUIQH4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268537AbUIQH4c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 03:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268540AbUIQH4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 03:56:32 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:43691 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S268537AbUIQH4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 03:56:23 -0400
Date: Fri, 17 Sep 2004 09:55:41 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Paul Jackson <pj@sgi.com>
cc: Simon Derr <Simon.Derr@bull.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] cpusets: fix race in cpuset_add_file()
In-Reply-To: <20040917002232.7b4135f5.pj@sgi.com>
Message-ID: <Pine.LNX.4.61.0409170932170.5423@openx3.frec.bull.fr>
References: <20040916012913.8592.85271.16927@sam.engr.sgi.com>
 <Pine.LNX.4.61.0409161548040.5423@openx3.frec.bull.fr> <20040916075501.20c3ee45.pj@sgi.com>
 <Pine.LNX.4.61.0409161715550.5423@openx3.frec.bull.fr> <20040917002232.7b4135f5.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2004, Paul Jackson wrote:

> You can continue to ignore this patch, Andrew.  I'm still thinking it
> through with Simon.
>
> Here's another possible way to skin this cat, Simon.
>
> Instead of adding an inode lock, how about just extending the cpuset_sem
> window.  If we hold cpuset_sem for the entire cpuset_mkdir() operation,
> then no other cpuset_mkdir can overlap, and there should be no
> confused overlapping directory creations.
>
no - the inode lock is necessary.

don't let my second mail with the deadlock example confuse you : the 
original problem (i.e the problem my patch fixes) is a race between a 
cpuset mkdir() and another operation in the newly created directory, for 
instance just `ls'.

the race is:

mkdir a/b			|	ls a/b/cpus
 				|
cpuset_add_file(b, "cpus")	|	vfs_stat()
  cpuset_get_dentry(b, "cpus")	|	 user_path_walk()
   lookup_hash(b, "cpus")	|	  path_lookup()
    cached_lookup(b, "cpus")	|	   link_path_walk()
    d_alloc(b, "cpus")		|	    do_lookup()
 				|	     real_lookup()
 				|	      down(b->i_sem);
 				|	      d_lookup(b, "cpus");
 				|	      d_alloc(b, "cpus");



The result is that `ls' and `mkdir' both create a dentry for a/b/cpus, and 
the dentry created by `ls' is bogus since it does not point to the cpuset 
data.

The proper way to prevent this is to lock the i_sem of directory b.
This can be done in cpuset_populate_dir(), in cpuset_add_file(), or 
cpuset_get_dentry().

The similar piece of code in sysfs does it in add_file().

If your are not convinced try the following script.
Without my patch it triggers the bug in a few seconds.

 	Simon.



#! /bin/bash

a()
{
 	name=$1
 	echo dir is  /dev/cpuset/$name
 	while :; do
 		mkdir /dev/cpuset/$name
 		if ! test -r /dev/cpuset/$name/cpus; then
 			echo missing /dev/cpuset/$name/cpus
 			exit 1
 		fi
 		rmdir /dev/cpuset/$name
 	done
}

b()
{
 	name=$1
 	while :; do
 		test -r /dev/cpuset/$name/cpus
 	done
}

p=$$

b $p &
a $p
