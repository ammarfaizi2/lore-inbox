Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWCTTg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWCTTg6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWCTTg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:36:57 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:41252 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964868AbWCTTgx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:36:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hLFlRlZZXT6DCJ+7ImfAaV6EQXkB8KH6ov2ELMZMge5K4ImjPC6i+RaMRMHFxpUSvOw1MYDLbCz3xB+rx8qwfhFA4H57L+Ajb4viAPMOE6J5krmk22ZIktZC+Ce33jnaQKV4BcV/SGfqw//OhSjyjV6RKDDDMQ5BT85XFsosxXo=
Message-ID: <4ae3c140603201136q7e61963dy635bb2c6047f0bc2@mail.gmail.com>
Date: Mon, 20 Mar 2006 14:36:51 -0500
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: "Theodore Ts'o" <tytso@mit.edu>, "Al Viro" <viro@ftp.linux.org.uk>,
       "Xin Zhao" <uszhaoxin@gmail.com>, mingz@ele.uri.edu,
       mikado4vn@gmail.com, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: Question regarding to store file system metadata in database
In-Reply-To: <4ae3c140603200713m24a5af0agd891a709286deb47@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ae3c140603182048k55d06d87ufc0b9f0548574090@mail.gmail.com>
	 <441CE71E.5090503@gmail.com>
	 <4ae3c140603190948s4fcd135er370a15003a0143a8@mail.gmail.com>
	 <1142791121.31358.21.camel@localhost.localdomain>
	 <4ae3c140603191011r7b68f4aale01238202656d122@mail.gmail.com>
	 <1142792787.31358.28.camel@localhost.localdomain>
	 <4ae3c140603191050k3bf7e960q9b35fe098e2fbe35@mail.gmail.com>
	 <20060319194723.GA27946@ftp.linux.org.uk>
	 <20060320130950.GA9334@thunk.org>
	 <4ae3c140603200713m24a5af0agd891a709286deb47@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK. Now I have more experimental results.

After excluding the cost of reading file list and do stat(), the
insertion rate becomes 587/sec, instead of 300/sec. The query rate is
2137/sec. I am runing mysql 4.1.11. FC4, 2.8G CPU and 1G mem.

2137/sec seems to be good enough to handle pathname to inode
resolving.  Anyone has some statistics how many file open in a busy
file system?

Xin


On 3/20/06, Xin Zhao <uszhaoxin@gmail.com> wrote:
> OK. Sorry for causing so much confusion here. I have to clarify
> several things before go further on the discussion.
>
> First, my experiment that resulted in 300 insertions/sec was set up as follows:
> 1. the testing code is written in python
> 2. I first creates a file list using "find /testdir -name "*" -print
> > filelist", and record current time after the filelist is created.
> 3. Then, I started a loop to read file pathnames line by line, for
> each line, I do stat to get inode number, then I created a record and
> insert it into database
> 4. after all records are inserted, I recorded current time again and
> computed the elapsed time used to insert all records
>
> From this setting, we can see this experiment is not very fair for
> database, because the time used to read filelist and do stat() are
> also counted database insertion time. As noted before, I did that
> experiment just to get some sense how slow a database could be. If I
> remove the file read and stat() cost, I will expect to see an
> improvement of insertion speed. I will redo the experiment and report
> the result. Still, 300/sec might be good enough to handle most
> scenarios. Yes. this might not be good enough to handle a busy web
> server, while I still doubt a web server need to open so many files
> per second. The frequently accessed files like small images are
> commonly cached instead of requiring to access file system every time.
>
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
>
> Now VM3 wants to access virtual file F. It has to determine the right
> physical copy. The right answer is F.2. But in the file system, we
> have F.1 and F.2. So some mapping mechanism must be devised. No matter
> how we manipulate the pathname of physical copies, several disk
> accesses seem to be required for a mapping operation. That is the
> reason we are considering database to store metadata.
>
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
>
> Also, I am not proposing to use db to store all metadata. As mentioned
> before, currently I am just considering to store the pathname-inode
> mapping. Other attributes like atime, ctime are stored using standard
> way. So this is essentially a layer above standard FS. Because only
> open () syscall needs to access metadata with the communication across
> kernel boundary, I am expecting a moderate performance impact. But I
> am not sure about this. Someone has any experience on that?
>
> Any further comments?
>
> Xin
>
>
> On 3/20/06, Theodore Ts'o <tytso@mit.edu> wrote:
> > On Sun, Mar 19, 2006 at 07:47:23PM +0000, Al Viro wrote:
> > > As for "more efficient"...  300 lookups per second is less than an
> > > improvement.  It's orders of magnitude worse than e.g. ext2; I don't
> > > know in which world that would be considered more efficient, but I
> > > certainly glad that I don't live there.
> >
> > There are two problems... well, more, but in the performance domain,
> > at least two issues that stick out like a sore thumb.
> >
> > The first is throughput, and as Al and others have already pointed out
> > 300 metadata operations per second is defintely nothing to write home
> > about.  The second is latency; how much *time* does it take to perform
> > an individual operations, especially if you have to do an upcall from
> > the kernel to a userspace database process, the user space process
> > then has to dick around its own general purpose,
> > non-optimized-for-a-filesystem data structures, possibly make syscalls
> > back down into the kernel only to have the data blocks pushed back up
> > into userspace, and then finally return the result of the "stat"
> > system call back to the kernel so the kernel can ship it off to the
> > original process that called stat(2).
> >
> > Even in WinFS, dropped from Microsoft Longwait, it really wasn't using
> > the database to store all metadata.  A better way of thinking about it
> > is a forcible bundling of a Microsoft's database product (European
> > regulators take note) with the OS; all of the low-level filesystem
> > operations are still being done the traditional way, and it's only
> > high level indexing operation which are being done in userspace (and
> > only in userspace).  It would be like taking the taking the locate(1)
> > userspace program and claiming it was part of the filesystem; it's
> > more about packaging than anything else.
> >
> >                                                 - Ted
> >
>
