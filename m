Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWCVPVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWCVPVs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWCVPVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:21:48 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:47998 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751299AbWCVPVq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:21:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YI6bpvPtf8kfJif+OlQr+q4b8sYAfglFvxSUIrjHv5xR1oCQ7SKKhyr+4jKiqpedRjBSjH7kHvmtXCS0SqUd7LuSEjzkZUyNjixeqMa/S1zDYr6nKgWvo6RxGQrWoToJUhU5FF0klBkXFTbsCJGeRNC57T6iqjN4U4D594hk36Q=
Message-ID: <4ae3c140603220721g277cf757i5e6b2bfd6f92c662@mail.gmail.com>
Date: Wed, 22 Mar 2006 10:21:42 -0500
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: Question regarding to store file system metadata in database
Cc: "Theodore Ts'o" <tytso@mit.edu>, "Al Viro" <viro@ftp.linux.org.uk>,
       mingz@ele.uri.edu, mikado4vn@gmail.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, zhaoxin@eecs.umich.edu
In-Reply-To: <20060321200513.GC3931@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ae3c140603182048k55d06d87ufc0b9f0548574090@mail.gmail.com>
	 <4ae3c140603190948s4fcd135er370a15003a0143a8@mail.gmail.com>
	 <1142791121.31358.21.camel@localhost.localdomain>
	 <4ae3c140603191011r7b68f4aale01238202656d122@mail.gmail.com>
	 <1142792787.31358.28.camel@localhost.localdomain>
	 <4ae3c140603191050k3bf7e960q9b35fe098e2fbe35@mail.gmail.com>
	 <20060319194723.GA27946@ftp.linux.org.uk>
	 <20060320130950.GA9334@thunk.org>
	 <4ae3c140603200713m24a5af0agd891a709286deb47@mail.gmail.com>
	 <20060321200513.GC3931@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many thanks for so many helpful comments!

First of all, the reason I kept arguing is to ask for more reasonable
arguments on this idea. This idea may not be good enough, but worth
thinking, I think. Actually, even myself is still hesitate to use
database to store pathname-inode mapping. I just want to get more
ideas or solid data from you guys to convince myself that database is
not a good idea.  I don't really want to spend several months and end
up with a slow file system. ;-) Now I think I am pretty much
convinced. :)

AI raised a good question on how our system handles rename. Our
current approach is very simple. We first determine whether the
requesting VM owns the physical copy corresponding to virtual file
FOO. If it does, we just go ahead renaming this physical copy as a
regular file system; otherwise, we have to create a "special" symbolic
link with the modified name, say "BAR", as the private copy of this
VM.  The link "BAR" points to the original physical copy. In the
future, when this VM access file BAR, it will get a symbolic link
which directs this VM to the right data blocks. The reason we say
"special symbolic link" is that we don't regard this symbolic link as
a real symbolic link. It is just used to point to the physical copy. A
special flag in inode will indicate that this symbolic link is
special. Thus, to guest VMs,  BAR still looks like a normal file
instead of a symbolic link. This helps avoid confusion.

Ted and Pavel pointed out two alternatives that can potential achieve
the same goal. Both devicemapper and ext3cow allow users to build
snapshot of file system. We can then start from the snapshot to
leverage COW technique to allow users to modify certain files. I do
know these two systems before. However, these two system only work
when one copy (version) is needed at a time. For example, ext3cow can
keep multiple versions of a file. One version is the latest version
while the rest are kept with epoch number. When one needs to access
past version, he or she needs to point out which version is desired.
This solution does not directly apply to our scenario. In our
scenario, multiple VMs may need to access a virtual file FOO. As
different VMs are allowed to own their private copies, multiple
physical copies of FOO may exist simultaneously. A better way to map
virtual pathname to right physical copy for a VM is needed.

Now let's talk about devicemapper, actually several other block level
versioning systems like Venti also use similar solution. They build
read-only snapshot and do COW on that snapshot when some files need to
be changed. Actually VMWare already uses similar way to support fast
clone and data sharing of VMs. There are several problems for this
solution. First, if multiple VMs share one block device and do
copy-on-write on this device, after several updates in those VMs, we
will end up with a splitted storage system. To evaluate the extent, we
ran VMWare and  installed a standard distribution of Windows XP on a
virtual machine, took a snapshot, installed all of the recommended
updates, and then took another snapshot to see the amount of data that
had been modified. After installing all the patches, we found that
VMWare had allocated 3.5 GB of disk space in addition to the data that
it read from the parent snapshot. If one hundred virtual machines were
cloned after running all the updates, the extra 3.5 GB would be a
one-time cost. If they were cloned before, however, then one hundred
times as much space, 350 GB, would be required to store the same data.

Another problem for block level sharing is the difficulty of garbage
collection. Consider block A is used by file FOO and shared by VM1 and
VM2. Now VM1 and VM2 wants to delete file FOO, they will simply modify
the block bitmap (assuming they use ext3) to release block A. However,
we have no way to connect the block bitmap update with the release of
block A. Then block A will never be reused even if it is not used by
any VM.

Hardlink is of course another potential approach. But it also need
extension to map (virtual path, VMID) to (physical path). Using some
special naming mechanism is not good enough as several VMs could share
the same physical copy. One possibility is to keep a private directory
tree for each VM. All files on this directory tree are hardlinks.
However, if VM2 inherits VM1's file system, we would have to create
hardlinks for all files in VM1's file system. This could be a problem.
Moreover, creating private dir tree for for all VMs will imcrease
dentry space significantly and reduce the effectiveness of dcache. I
don't know the extent though. Last, hardlinks have some restrictions.
For example, a hardlink must reside on the same device as the target
file. one can not create hardlink  for directories in many OS. These
restrictions will be another problem.

Xin

On 3/21/06, Pavel Machek <pavel@suse.cz> wrote:
> Hi!
>
> > Second, I might want to give the background on which we are
> > considering the possibility of storing metadata in database. We are
> > currently developing a file system that allows multiple virtual
> > machines to share base software environment. With our current design,
> > a new VM can be deployed in several seconds by inheriting the file
> > system of an existing VM. If a VM is to modify a shared file, the file
> > system will do copy-on-write to gernerate a private copy for this VM.
> > Thus, there could be multiple physical copies for a virtual pathname.
> > Even more complicated, a physical copy could be shared by arbitrary
> > subset of VMs.  Now let's consider how to support this using regular
> > file system. You  can treat VMs as clients or users of a standard
> > linux.  Consider the following scenario: VM2 inherit VM1's file
> > system. The physical copy for virtual file F is F.1. Then, it modified
> > file F and get its private copy F.2. Now VM3 inherit VM2's file
> > system. The inherit graph is as follow:
> > VM1-->VM2-->VM3
> >
> > Now VM3 wants to access virtual file F. It has to determine the right
> > physical copy. The right answer is F.2. But in the file system, we
> > have F.1 and F.2. So some mapping mechanism must be devised. No matter
> > how we manipulate the pathname of physical copies, several disk
> > accesses seem to be required for a mapping operation. That is the
> > reason we are considering database to store metadata.
>
> Hardlinks? ext3cow (google it)?
>                                                                 Pavel
>
> --
> Picture of sleeping (Linux) penguin wanted...
>
