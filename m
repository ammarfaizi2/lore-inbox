Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261792AbSJEAEV>; Fri, 4 Oct 2002 20:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261811AbSJEAEV>; Fri, 4 Oct 2002 20:04:21 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56324 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261792AbSJEAEQ>; Fri, 4 Oct 2002 20:04:16 -0400
Date: Fri, 4 Oct 2002 17:11:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
cc: Andrew Morton <akpm@digeo.com>, Janet Morgan <janetmor@us.ibm.com>,
       Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] direct-IO API change
In-Reply-To: <200210042356.g94NujG24693@eng2.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0210041704110.2993-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Oct 2002, Badari Pulavarty wrote:
> 
> Only issue would be the alignment restriction on blockdev versus raw device.

Hmm.. We might want to revert the stuff that made the default block device 
alignment be the maximal possible, and instead make the default be the 
minimum possible.

The offending code is the "while"-loop in bd_set_size(). Just removing 
that should make the default size be the minimal one (ie hardsect_size).

It _used_ to make sense to try to maximize the block-size, since it had a
noticeable impact on performance whether we did 8 512-byte requests or
just 1 4kB request. However, all the bio changes have likely made that a
non-issue, since Andrew's code ends up doing things directly one page at a
time _anyway_.

Of course, mounting a filesystem on the device will override the default 
anyway, so this by no means will guarantee that direct access will always 
have the minimal alignment restrictions, but once you've mounted a 4kB 
blocksize filesystem on that device I think you might as well do 4kB 
chunks even if you open it through the device interface, no?

			Linus

