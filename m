Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWJMRXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWJMRXR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 13:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWJMRXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 13:23:17 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:14270 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1751402AbWJMRXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 13:23:16 -0400
Date: Fri, 13 Oct 2006 13:23:04 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Erez Zadok <ezk@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, mhalcrow@us.ibm.com,
       phillip@hellewell.homeip.net
Subject: Re: Re: [RFC/PATCH 1/2] stackfs: generic functions for obtaining hidden object
Message-ID: <20061013172304.GE3936@filer.fsl.cs.sunysb.edu>
References: <Pine.LNX.4.64.0610131615370.563@sbz-30.cs.Helsinki.FI> <200610131543.k9DFh05m016578@agora.fsl.cs.sunysb.edu> <84144f020610130923q28d816ddl388484421e23ba91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020610130923q28d816ddl388484421e23ba91@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 07:23:36PM +0300, Pekka Enberg wrote:
> On 10/13/06, Erez Zadok <ezk@cs.sunysb.edu> wrote:
> >I think we should do it right the first time (i.e., now :-)
> 
> I would much rather merge it now (assuming I didn't break ecryptfs)
> and have you unionfs developers fix it later :-).

Thanks :) As they say, it's the thought that counts, isn't it? ;)

> On 10/13/06, Erez Zadok <ezk@cs.sunysb.edu> wrote:
> >Why not make it something more dynamic, such as a mount-time option per sb?
> >Even at 8, you waste most of that space for non-fan-out stackable file
> >systems such as ecryptfs; and those unionfs users who want more, will have
> >to _recompile_ the code.
> 
> Yes, we discussed this with Jeff already. For unionfs, we must make it
> more dynamic. However, using slab unconditionally makes it totally
> unacceptable for ecryptfs. Therefore, we need a small static array
> that should satisfy most user (I think we can drop the static array
> size to three):

Nice, 3 pointers to inodes, and one to inode* = 4 pointers total, 128/256
bit struct on i386/x86_64.

> struct stackfs_inode_info {
>    struct inode **hidden_inodes;
>    struct inode *static_inodes[3];
> };
> 
> Initially, hidden_inodes can point to static_inodes which we can the
> replace with a dynamic array if required.

Hrm. You can have static store inodes {0,1,2} and the dynamic {3,4,5,...}
(this is what unionfs used to do - inline objects for performance). The
other way can be static array is ignored if dynamic array exists. In which
case, you effectively have {} in static, and {0,1,2,3,4,5,...} in dynamic. I
guess you could justify the wasting of the static array by arguing that if
the number of branches is << than number of static array elements, but I'm
afraid that that won't be the case most of the time.

> Btw, we probably want to do krealloc() for that in the slab allocator.

krealloc should be trivial to do (if the new size <= size of current slab,
do nothing, else alloc from a larger one).

Josef "Jeff" Sipek.

-- 
We have joy, we have fun, we have Linux on a Sun...
