Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268034AbUIGMiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268034AbUIGMiE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 08:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268035AbUIGMf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 08:35:59 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:13200 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S267988AbUIGMeE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 08:34:04 -0400
Date: Tue, 7 Sep 2004 14:33:46 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1183150024.20040907143346@tnonline.net>
To: Christer Weinigel <christer@weinigel.se>
CC: David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Tonnerre <tonnerre@thundrix.ch>, Linus Torvalds <torvalds@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <m3d60yjnt7.fsf@zoo.weinigel.se>
References: <200409070206.i8726vrG006493@localhost.localdomain>
 <413D4C18.6090501@slaphack.com> <m3d60yjnt7.fsf@zoo.weinigel.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> David Masover <ninja@slaphack.com> writes:

>> |>Second, there are quite a few things which I might want to do, which can
>> |>be done with this interface and without patching programs,
>> | Such as?
>> They've been mentioned.

>> | Haven't seen any that made sense to me, sorry.
>> Sorry if they don't make sense to you, but I don't feel like discussing
>> them now.  Either you get it or you don't, either you agree or you
>> don't.  Read the archives.

> Great argument.  Not.  There has been so much shit thrown around here
> so that it's impossible to keep track of all examples.

> Could you please try summarize a few of the arguments that you find
> especially compelling?  This thread has gotten very confused since
> there are a bunch of different subjects all being intermixed here.

  Indeed. We are discussion changes to the heart of Linux. It is bound
  to get a little heated :/

> What are we discussing?

> 1. Do we want support for named streams?

>    I belive the answer is yes, since both NTFS and HFS (that's the
>    MacOS filesystem, isn't it?) supports streams we want Linux to
>    support this if possible.

>    Anyone disagreeing?

     No :)
     
> 2. How do we want to expose named streams?

>    One suggestion is file-as-directory in some form.

>    Another suggestion made is to expose named streams somewhere under
>    /proc/self/fd.

>    Yet another suggestion is to use the openat(3) API from solaris.

>    Some filesystems exposes extra data in a special directory in the
>    same directory as the file, such as netapps .snapshot directories
>    or the extra directories that netatalk expects.  This has the
>    advantage that it even works on non-named stream capable
>    filesystems, but it has a lot of problems too.

>    Linux already has limited support for names streams via the xattr
>    interface, but it's not a good interface for people wanting to
>    have large files as named streams.

> 4. What belongs in the generic VFS, what belongs in Reiser4?

>    Some things reiser4 do, such as files-as-directories need changes
>    to the VFS because it breaks assumptions that the VFS makes
>    (i.e. a deadlock or an oops when doing a hard link out of one).

>    Some other things reiser4 can do would be better if they were in
>    the VFS since other filesystems might want to support the same
>    functionality. 

>    Or Linux may not support some of the things reiserfs at all.

> 5. What belongs in the kernel, what belongs in userspace?

>    This is mostly what I have been trying to argue about.

> So, to try to summarize my opinion, regarding file-as-directory, I
> belive it's fatally flawed because it breaks a lot of assumptions that
> existing code make.  One example of an application that will break is
> a web server that tries to filter out accesses to "bad" files,
> files-as-directories suddenly means that part of those files will be
> accessible (and there are a _lot_ of CERT reports on just this kind of
> problems with Windows web servers due to access to named streams not
> being restricted or ways to access files with non-canonical names that
> also managed to bypass access restrictions).

  But restrictions could be controlled. But exactly how depends on
  what solution for named streams is chosen. For example, there might
  be separate permissions for named streams other than the main
  stream.

> Files-as-directories also does not give us named streams on
> directories.  The suggestion to have dir/metas access the named
> streams means that if someone already has a file named metas in a
> directory that file will be lost.  (Does anyone remember the
> discussions about the linux kernel having a directory named "core" and
> the problems this caused for some people?)

  Yes, reserved keywords needs to be chosen very carefully if they are
  used. Other examples here has been ..metas or ...

> All this suggests to me that named streams must live in another
> namespace than the normal one.  To me, openat(3) seems like a good
> choice for an API and it has the advantage that someone else, Solaris,
> already has implemented it.

> Additionally, files-as-directores does not solve the problem of 
> "cp a b" losing named streams.  There is curently no copyfile syscall
> in the Linux kernel, "cp a b" essentially does "cat a >b".  So unless
> cp is modified we don't gain anything.  If cp is modified to know
> about named streams, it really does not matter if named streams are
> accessed as file-as-directories, via openat(3) or via a shared library
> with some other interface.

  One suggestion is missed. It is to provide system calls for copy.
  That would also solve the problem. Named streams and metas would
  then be handled correctly. It also allows further changes to
  filesystems without having to patch applications yet again.

  A copy system call would also be large beneficial for networked
  filesystems (NFS, Samba, etc) as data wouldn't have to be
  transferred over the network and back.

> Regarding the kernel or userspace discussion.  In my opinion anything
> that can be done in user space should be done in userspace.  If the
> performance sucks, or it has security problems, or needs caching that
> cant be solved in userspace it can be moved to the kernel, but in that
> case the smallest and cleanest API possible should be implemented.

  Yes. I agree. I do not think most people arguing for plugins or
  usage for named streams actually wanted to put everything in the
  kernel, but rather to have a kernel interface to which user-level
  modules, plugins and applications could work.

> If, for historical reasons, an API must be in the kernel, there is not
> much we can do about it either.  It'll have to stay there, but we can
> avoid making the same mistakes again.

> So, for all the examples of the kernel having plugins that
> automatically lets an application see a tar-file as a directory, I
> really, really don't belive this belongs in the kernel.  First of all,
> this is the file-as-directory discussion again, I belive it is a
> mistake to expose the contents as a directory on top of the file
> because it breaks a lot of assumptions that unix programs make.

> It's much better to expose the contents at another place in the
> filesystem by doing a temporary mount of the file with the proper
> filesystem.  As Pavel Machek pointed out, this has the problem of who
> cleans up the mount if the application crashes.  One way to handle
> this could be something like this:

>     mount -t tarfs -o loop bar.tar /tmp/bar-fabb50509
>     chdir /tmp/bar-fabb50509
>     umount -f /tmp/bar-fabb50509

> This will require the ability to unmount busy filesystems (but I
> belive Alexander Viro already has implemented the infrastructure
> needed for this).

> Or for files that we don't have a real filesystem driver (or on other
> systems where userspace mounts are not allowed), we could just unpack
> the contents into /tmp.  For cleanup we could let whatever cleans up
> /tmp anyways handle it, or have a cache daemon that keeps track of
> untarred directories and removes them after a while.

  But now, as you said, we are not talking about named streams, but
  about a specic type of plugin and its implications.

  Can we make a plugin infrastructure that will let user-space plugins
  to be loaded for certain directories or files? If we can, then it
  would present a much cleaner and easier way for the user to access
  data he wants. In this particular example it was a tar file.

> Another way is to completely forget about presenting the contents of a
> tar file as a real files, and just use a shared library to get at the
> contents (now we just have to convince everyone to use the shared
> library).  This would also be portable to other systems.

  Yes. If it was possible. I do honestly think it will be easier and
  less man hour work to create a run-time loadable user-space plugin
  interface than to convince thousands of application developers to
  use this shared library.
  
> If we do this right, it could all be hidden in a shared library, and
> if the system below it supports more advanced features, it can use it.

> Regarding the "I want a realtime index of all files".  I belive that a
> notifier that can tell me when a file has been changed and a userspace
> daemon ought to handle most of the cases that have been mentioned.

  We have FAM (File Alteration Monitor) that notifies applications of
  changes to files they are interested in.

  http://oss.sgi.com/projects/fam/

> The suggested problems of not getting an up to date query response can
> be handled by just asking the daemon "are you done with indexing yet".
> The design of such a daemon and the support it needs from the kernel
> can definitely be discussed.  But to put the indexer itself in the
> kernel sounds like a bad idea.  Even adding an API to query the
> indexer into the kernel sounds pointless, why do that instead of just
> opening a Unix socket to the indexer and asking it directly?

  I think that we do not need a indexer with Reiser4 anyway. It is
  already a database that could be queried directly. There shouldn't
  be any need to build a database on top of Reiser4 (like the
  updatedb) that holds the same information already existing in
  Reiser4.

  Now, it is just a matter of having an interface to query the Reiser4
  db. One of the suggested ways were through meta-data. For example:

  ls -l ..metas/keyword/.pdf

  ~S
  
>   /Christer


