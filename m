Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269301AbUJWBGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269301AbUJWBGr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 21:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269774AbUJWBDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 21:03:24 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:22741 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S269301AbUJWA7V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:59:21 -0400
From: David Lang <david.lang@digitalinsight.com>
To: =?iso-8859-1?Q?Kristian_S=F8rensen?= <ks@cs.aau.dk>
Cc: linux-kernel@vger.kernel.org, umbrella@cs.aau.dk
Date: Fri, 22 Oct 2004 17:51:04 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: Gigantic memory leak in linux-2.6.[789]!
In-Reply-To: <200410221613.35913.ks@cs.aau.dk>
Message-ID: <Pine.LNX.4.60.0410221743590.20604@dlang.diginsite.com>
References: <200410221613.35913.ks@cs.aau.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004, Kristian Sørensen wrote:

> Hi all!
>
> After some more testing after the previous post of the OOPS in
> generic_delete_inode, we have now found a gigantic memory leak in Linux 2.6.
> [789]. The scenario is the same:
<SNIP>
> When the loop has completed, the system use 124 MB memory more _each_ time....
> so it is pretty easy to make a denial-of-service attack :-(
>
> We have tried the same test on a RHEL WS 3 host (running a RedHat 2.4 kernel)
> - and there is no problem.
>
>
> Any deas?
>
> --
> Kristian Sørensen
> - The Umbrella Project
>  http://umbrella.sourceforge.net

This is a common mistake that many people make when first looking at the 
Linux stats.

Linux starts off with most of the memory free, but rapidly uses it up. it 
keeps a small amount (a few megs) free at all times, but for the rest 
counts of freeing memory (possibly by swapping) when a new program asks 
for memory and there is less then the minimum amount left free.

It does this becouse there is a chance that the memory will be re-used (in 
your example where you were untaring the kernel source there is a chance 
that someone else would be reading that source and if they did it would 
already be in memory and not have to be re-read from disk) and becouse 
there is a chance that nothing will ever need to use that memory before 
the computer is shut off so it would be a waste of time to do the free 
(which includes zeroing out the memory, not just marking it as available).

This puts the cost of zeroing out and freeing memory on new programs that 
are allocating memory, which tends to scatter the work over time rather 
then having a large burst of work kick in when a program exits (it seems 
odd to think that if a large computer exits the machine would be pegged 
for a little while while it frees up and zeros the memory, not exactly 
what you would expect when you killed a program :-)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
