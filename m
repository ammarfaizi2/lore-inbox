Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbTJFTZP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 15:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbTJFTZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 15:25:14 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:26821 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S261159AbTJFTZC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 15:25:02 -0400
Date: Tue, 7 Oct 2003 00:57:13 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Maneesh Soni <maneesh@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Greg KH <gregkh@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/6] Backing Store for sysfs
Message-ID: <20031006192713.GE1788@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20031006085915.GE4220@in.ibm.com> <Pine.LNX.4.44.0310061123110.985-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310061123110.985-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 11:44:14AM -0700, Patrick Mochel wrote:
> First off, I'm not philosophically opposed to the concept of reducing 
> sysfs and kobject memory usage. I think it can be gracefully done, though 
> I don't think this is quite the solution, and I don't have one myself.. 

Let's look at it this way - unless you find a way to save sizeof(struct dentry)
+ sizeof(struct inode) in every kobject/attr etc., there is no
way you can beat ageing of dentries/inodes.

> Now, you would really only problems when you have a large number of
> devices and a limited amount of a Lowmem. I.e. it's only a problem on
> large systems with 32-bit processors. And, the traditional arguments
> against this situation is to a) use and promote 64-bit platforms and b)
> that if you have that many devices, you (or your customers) can surely
> afford enough memory to make the sysfs footprint a non-issue.

That is not a very realistic argument, ia32 customers will likely
run systems with large number of disks and will have lowmem problem.
Besides that think about the added complexity of lookups due to
all those pinned dentries forever residing in dentry hash table.

> 
> Concerning the patch, I really don't like it. I look at the kobject and 
> sysfs code with the assumption in my mind that the objects are already too 
> large and the code more complex than it should be. Adding to this is not 
> the right approach, just as a general rule of thumb. 
> 
> Also, I don't think that increasing the co-dependency bewteen the kobject
> and sysfs hierarchies is the right thing to do. They each have one pointer
> back to the corresponding location in the other tree, which is about as
> lightweight as you can get. Adding more only increases bloat for kobjects 
> that are not represented in sysfs, and increases the total overhead of the 
> entire system. 

I don't see how you can claim that the total overhead of the entire
system is high. See Christian's numbers. The point here is pretty
straightforward -

sysfs currently uses dentries to represent filesystem hierarchy.
We want to create the dentries on the fly and age them out.
So, we can no longer use dentries to represent filesystem hierarchy.
Now, *something* has to represent the actual filesystem
hierarchy, so that dentries/inodes can be created on a lookup
miss based on that. So, what do you do here ? kobject and
its associates already represent most of the information necessary
for a backing store. Maneesh just added a little more to complete
what is equivalent of a on-disk filesystem. This allows vfs to
create dentries and inodes on the fly and age later on. Granted
that there are probably ugliness in the design to be sorted out
and it may have taken kobjects in a slightly different direction
than earlier, but it is not that odd when you look at it
from the VFS point of view.

> 
> You can also use the assumption that an attribute group exists for all the 
> kobjects in a kset, and that a kobject knows what kset it belongs to. And
> that eventually, all attributes should be added as part of an attribute 
> group..

As I said before, no matter how much you save on kobjects and attrs,
I can't see how you can account for ageing of dentries and inodes.
Please look at it from the VFS angle and see if there is a better
way to represent kobjects/attrs in order to create dentries/inodes
on demand and age later.

Thanks
Dipankar
