Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267505AbUBSToN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 14:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267509AbUBSToN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 14:44:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:6039 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267505AbUBSToF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 14:44:05 -0500
Date: Thu, 19 Feb 2004 11:48:50 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: Jamie Lokier <jamie@shareable.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Eureka! (was Re: UTF-8 and case-insensitivity)
In-Reply-To: <20040219182948.GA3414@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
References: <Pine.LNX.4.58.0402181422180.2686@home.osdl.org>
 <Pine.LNX.4.58.0402181427230.2686@home.osdl.org> <16435.60448.70856.791580@samba.org>
 <Pine.LNX.4.58.0402181457470.18038@home.osdl.org> <16435.61622.732939.135127@samba.org>
 <Pine.LNX.4.58.0402181511420.18038@home.osdl.org> <20040219081027.GB4113@mail.shareable.org>
 <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org>
 <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, 
 I think I've got it. Here's an algorithm that will have "perfect" 
behaviour under normal circumstances as long as you've got enough memory. 

Admittedly the "you've got enough memory" part is a downside, but it's so 
_damn_ clean and simple that it is, I think, a reasonable trade-off. 
Besides, if you want good file serving numbers, you'd better have enough 
memory anyway.

Basic approach: add two bits to the VFS dentry flags. That's all that is 
needed. Then you have two new system calls:

 - set_bit_one(dirfd)
 - set_bit_two_if_one_is_set(dirfd);
 - check_or_create_name(dirfd, name, case_table_pointer, newfd);

The VFS rule is:
 - all new dentries start off with the two magic bits clear
 - whenever we shrink a dentry, we clear the two magic bits in the parent

and that is _all_ the VFS layer ever does. Even Al won't find this 
obnoxious (yeah, we might clear the bits after a timeout on things that 
need re-validation, but that's in the noise).

The "set_bit_one()" system call will set one of the magic bits (with the
dcache lock held) in the dentry that is pointed to by the file descriptor.
Nothing more.

The "set_bit_two_if_one_is_set()" system call will set the _other_ magic 
bit (with the dcache lock held) in the dentry, if the first bit is set. 
Otherwise it will just return.

Let's leave the "check_or_create_name()" thing for now, and see how we can
use this in user space (and realize that we only do this on cache failure,
so this is the "slow case"):

	set_bit_one(dir);
	lseek(dir, 0, SEEK_SET);
	while (readdir(dir, de)) {
		stat(de->d_name);
		.. might also compare the name here with whatever it is 
		   working on right now..
	}
	set_bit_two_if_one_is_set(dirfd);

Notice what the above does? After the above loop, bit two will be set IFF 
the dentry cache now contains every single name in the directory. 
Otherwise it will be clear. Bit two will basically be a "dcache complete" 
bit.

Now, let's go to "check_or_create_name()", which can thus do:

 - for each name in the dcache name list, compare the dang thing 
   without case.
 - return "lookup succeeded" (the file descriptor of the thing it 
   successfully looked up) if a match with a positive dentry occurs.
 - check bit two, return -ENOCACHE if it was clear.
 - create the new dentry with the new name and the new file descriptor 
   inode, and return success.

Notice? Basically _ZERO_ changes to the VFS layer, together with basically 
perfect hot-cache-case behaviour.

Yeah, yeah, the above is probably glossing over a lot of issues (there's a
race if somebody does both the "readdir loop" and the "create" case at the
same time, so that would need a lock around it in user space, but please
realize that the readdir loop only happens if the "check_or_create()" 
thing fails, so the readdir loop should basically never happen in the 
hot-cache case.

And the above allows perfect behaviour even for new filenames that we have 
never seen before (ie a create of a new file with a random name). At least 
as long as the dcache for that directory remains "complete" (which it will 
do, until the kernel needs to throw something out).

Am I a super-intelligent bastard, or am I a complete nincompoop? You
decide.

		Linus
