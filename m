Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262300AbVEYMPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbVEYMPj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 08:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbVEYMPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 08:15:38 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:35276 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262300AbVEYMPH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 08:15:07 -0400
References: <200505232225.j4NMPte1029529@ms-smtp-02-eri0.texas.rr.com>
            <84144f0205052400113c6f40fc@mail.gmail.com>
            <a4e6962a0505241208214a200f@mail.gmail.com>
            <1116996843.9580.8.camel@localhost>
            <a4e6962a0505250455605faec9@mail.gmail.com>
In-Reply-To: <a4e6962a0505250455605faec9@mail.gmail.com>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Pekka Enberg <penberg@gmail.com>, linux-kernel@vger.kernel.org,
       v9fs-developer@lists.sourceforge.net,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org
Subject: Re: v9fs: VFS superblock operations (2.0-rc6)
Date: Wed, 25 May 2005 15:15:05 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42946C49.00007170@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

On Wed, 2005-05-25 at 06:55 -0500, Eric Van Hensbergen wrote:
> Well, I'm not using slabs as a custom allocator just to track leaks. 
> I'm using them for two specific structures which end up getting
> allocated and freed quite often (which is what I thought slab
> allocators were for).  The two structures I'm slab allocating are the
> directory structure (which has a fixed size), and the packet structure
> (which has a fixed size per session, and may grow or shrink based on
> protocol negotiation/command-line options).  I use the find_slab
> routine to see if there is a slab (that I created) that already
> matches the protocol negotiated size so I don't create a
> slab-per-session unnecessarily. 
> 
> Is this not the right way to use slabs?  Should I just be using
> kmalloc/kcalloc? (Is that what you mean by drop the custom allocator?)

You can create your own slab for known fixed-size objects (your
directory structure). Look at other filesystems for an example. They
usually create a cache for their inode_info structs. 

The problem with your approach on packet structure slab is that we
potentially get slabs with little or no activity. You would have to
write custom code to tear down unused slabs but now you've got something
that clearly does not belong in filesystem code. So yes, I think you'd
be better of using kmalloc()/kcalloc() for your packet structures. 

                       Pekka 

