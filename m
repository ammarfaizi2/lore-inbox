Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWAWNde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWAWNde (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 08:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWAWNde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 08:33:34 -0500
Received: from smtpout.mac.com ([17.250.248.84]:54231 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751446AbWAWNdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 08:33:33 -0500
In-Reply-To: <20060123072447.GA8785@thunk.org>
References: <43D3295E.8040702@comcast.net> <20060122093144.GA7127@thunk.org> <43D3D4DF.2000503@comcast.net> <20060122210238.GA28980@thunk.org> <4D75B95E-2595-4B60-91B3-28AD469C3D39@mac.com> <20060123072447.GA8785@thunk.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <536E71BF-44FF-430C-8C19-F06526F0C78D@mac.com>
Cc: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: soft update vs journaling?
Date: Mon, 23 Jan 2006 08:33:20 -0500
To: "Theodore Ts'o" <tytso@mit.edu>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 23, 2006, at 02:24, Theodore Ts'o wrote:
> Hot-shrinking a filesystem is certainly possible for any  
> filesystem, but the problem is how many filesystem data structures  
> you have to walk in order to find all the owner of all of the  
> blocks that you have to relocate.  That generally isn't a RAM  
> overhead problem, but the fact that in general, most filesystems  
> don't have an efficient way to answer the question, "who owns this  
> arbitrary disk block?"  Having extents means you have a slightly  
> more efficient encoding system, but it still is the case that you  
> have to check potentially every file in the filesystem to see if it  
> is the owner of one of the disk blocks that needs to be moved when  
> you are shrinking the filesystem.

The way that I'm considering implementing this is by intentionally  
fragmenting the allocation bitmap, catalog file, etc, such that each  
1/8 or so of the disk contains its own allocation bitmap describing  
its contents, its own set of files or directories, etc.  The  
allocator would largely try to keep individual btree fragments  
cohesive, such that one of the 1/8th divisions of the disk would only  
have pertinent data for itself.  The idea would be that when trying  
to look up an allocation block, in the common case you need only  
parse a much smaller subsection of the disk structures.

> And the only use for such a [reverse-mapping] data structure would  
> be to make shrinking a filesystem more efficient.

Not entirely true.  I _believe_ you could use such data structures to  
make the allocation algorithm much more robust against fragmentation  
if you record the right kind of information.

Cheers,
Kyle Moffett

--
If you don't believe that a case based on [nothing] could potentially  
drag on in court for _years_, then you have no business playing with  
the legal system at all.
   -- Rob Landley



