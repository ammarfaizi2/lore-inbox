Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbTJFSt3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 14:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbTJFSt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 14:49:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:46786 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261871AbTJFSt0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 14:49:26 -0400
Date: Mon, 6 Oct 2003 11:44:14 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@localhost.localdomain
To: Maneesh Soni <maneesh@in.ibm.com>
cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Greg KH <gregkh@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [RFC 0/6] Backing Store for sysfs
In-Reply-To: <20031006085915.GE4220@in.ibm.com>
Message-ID: <Pine.LNX.4.44.0310061123110.985-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The following patch set(mailed separately) provides a prototype for a backing 
> store mechanism for sysfs. Currently sysfs pins all its dentries and inodes in 
> memory there by wasting kernel lowmem even when it is not mounted. 
> 
> With this patch set we create sysfs dentry whenever it is required like 
> other real filesystems and, age and free it as per the dcache rules. We
> now save significant amount of Lowmem by avoiding un-necessary pinning. 
> The following numbers were on a 2-way system with 6 disks and 2 NICs with 
> about 1028 dentries. The numbers are just indicative as they are system
> wide collected from /proc and are not exclusively for sysfs.

No thanks. 

First off, I'm not philosophically opposed to the concept of reducing 
sysfs and kobject memory usage. I think it can be gracefully done, though 
I don't think this is quite the solution, and I don't have one myself.. 

Now, you would really only problems when you have a large number of
devices and a limited amount of a Lowmem. I.e. it's only a problem on
large systems with 32-bit processors. And, the traditional arguments
against this situation is to a) use and promote 64-bit platforms and b)
that if you have that many devices, you (or your customers) can surely
afford enough memory to make the sysfs footprint a non-issue.

Concerning the patch, I really don't like it. I look at the kobject and 
sysfs code with the assumption in my mind that the objects are already too 
large and the code more complex than it should be. Adding to this is not 
the right approach, just as a general rule of thumb. 

Also, I don't think that increasing the co-dependency bewteen the kobject
and sysfs hierarchies is the right thing to do. They each have one pointer
back to the corresponding location in the other tree, which is about as
lightweight as you can get. Adding more only increases bloat for kobjects 
that are not represented in sysfs, and increases the total overhead of the 
entire system. 

As I said before, I don't know the right solution, but the directions to 
look in are related to attribute groups. Attributes definitely consume the 
most amount of memory (as opposed to the kobject hierachy), so delaying 
their creation would help, hopefully without making the interface too 
awkward. 

You can also use the assumption that an attribute group exists for all the 
kobjects in a kset, and that a kobject knows what kset it belongs to. And
that eventually, all attributes should be added as part of an attribute 
group..


	Pat



