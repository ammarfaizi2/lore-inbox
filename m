Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030548AbWCTWTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030548AbWCTWTU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWCTWTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:19:19 -0500
Received: from thunk.org ([69.25.196.29]:28376 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751220AbWCTWTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:19:18 -0500
Date: Mon, 20 Mar 2006 17:19:11 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, mingz@ele.uri.edu, mikado4vn@gmail.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: Question regarding to store file system metadata in database
Message-ID: <20060320221911.GB11447@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Xin Zhao <uszhaoxin@gmail.com>, Al Viro <viro@ftp.linux.org.uk>,
	mingz@ele.uri.edu, mikado4vn@gmail.com,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
References: <4ae3c140603182048k55d06d87ufc0b9f0548574090@mail.gmail.com> <441CE71E.5090503@gmail.com> <4ae3c140603190948s4fcd135er370a15003a0143a8@mail.gmail.com> <1142791121.31358.21.camel@localhost.localdomain> <4ae3c140603191011r7b68f4aale01238202656d122@mail.gmail.com> <1142792787.31358.28.camel@localhost.localdomain> <4ae3c140603191050k3bf7e960q9b35fe098e2fbe35@mail.gmail.com> <20060319194723.GA27946@ftp.linux.org.uk> <20060320130950.GA9334@thunk.org> <4ae3c140603200713m24a5af0agd891a709286deb47@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c140603200713m24a5af0agd891a709286deb47@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 10:13:43AM -0500, Xin Zhao wrote:
> Second, I might want to give the background on which we are
> considering the possibility of storing metadata in database. We are
> currently developing a file system that allows multiple virtual
> machines to share base software environment. With our current design,
> a new VM can be deployed in several seconds by inheriting the file
> system of an existing VM. If a VM is to modify a shared file, the file
> system will do copy-on-write to gernerate a private copy for this VM.
> Thus, there could be multiple physical copies for a virtual pathname.
> Even more complicated, a physical copy could be shared by arbitrary
> subset of VMs.  Now let's consider how to support this using regular
> file system. You  can treat VMs as clients or users of a standard
> linux.  Consider the following scenario: VM2 inherit VM1's file
> system. The physical copy for virtual file F is F.1. Then, it modified
> file F and get its private copy F.2. Now VM3 inherit VM2's file
> system. The inherit graph is as follow:
> VM1-->VM2-->VM3

Why not leverage devicemapper, and implement muliple hierarchical
copy-on-write snapshots at the block device level?  It would be much
easier....  

> We do know many file systems already use db like technique to index
> metadata. For example B tree used by ReiserFS and HTree used by Ext3.
> But they do not provide the feature we need. This at least exposes one
> fundamental limit: they do not support easy extension on metadata. So
> at least some extension must be made to make the mapping efficient. So
> we thought "since they are using db like technique, why not simply use
> DB? " At least a DB makes it simple to extend metadata of a file
> system. For example, in our case, we might also want to add hash value
> of file content into a file's metadata. This allows us to merge
> several files with identical contents into one for disk space saving,
> which is important in our scenario since we assume that many VMs uses
> identical software environment.

Why not use a DB?  Because most databases's are big and bloated and
not something you want to have in the kernel (not even Hans Reiser was
crazy enough to propose stuffing an SQL interpreter into the kernel :-)
--- and if you put the generic database (complete with SQL interpreter
and all the rest) in userspace, doing upcalls into userspace, and then
having to have the database interpret the SQL query, etc., takes time.

If you don't care about performance, by all means, try using FUSE and
implementing a user-space filesystem.  It will be slow as all get-out,
but maybe it won't matter for your application.

> Also, I am not proposing to use db to store all metadata. As mentioned
> before, currently I am just considering to store the pathname-inode
> mapping. Other attributes like atime, ctime are stored using standard
> way. So this is essentially a layer above standard FS. Because only
> open () syscall needs to access metadata with the communication across
> kernel boundary, I am expecting a moderate performance impact. But I
> am not sure about this. Someone has any experience on that?

That won't be just open(), but stat(), readdir(), unlink(), rename(),
etc.  It's all going to depend on your workload and how much
filesystem access it requires.  It certainly won't be a general
purpose solution, and for some workloads it will be disaterously slow.
But hey, if you don't believe me, go ahead try implementing it.....

						- Ted
