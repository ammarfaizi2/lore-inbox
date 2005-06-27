Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbVF0XKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbVF0XKm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 19:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbVF0XHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 19:07:33 -0400
Received: from smtpout.mac.com ([17.250.248.85]:36552 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262101AbVF0XEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 19:04:13 -0400
In-Reply-To: <42C06D59.2090200@slaphack.com>
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu> <42BF667C.50606@slaphack.com> <5284F665-873C-45B7-8DDB-5F475F2CE399@mac.com> <42BF7167.80201@slaphack.com> <EC02A684-815A-4DF8-B5C1-9029FE45E187@mac.com> <42C06D59.2090200@slaphack.com>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CD59AE36-FD15-4A4C-9E1D-AB2F8B52D653@mac.com>
Cc: Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: reiser4 plugins
Date: Mon, 27 Jun 2005 19:03:24 -0400
To: David Masover <ninja@slaphack.com>
X-Mailer: Apple Mail (2.730)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 27, 2005, at 17:19:21, David Masover wrote:
>> Precisely.  Come back when you have a good sturdy set of  
>> arguments.  See
>> the FUSE project (Also discussed in this thread), for better ideas  
>> on  how
>> to add strange filesystem semantics.
>
> If I didn't care about performance.  I will read up on how FUSE works,
> though, to see if there's anything in the _kernel_ code that would be
> useful.

A number of projects do their performance critical things in userspace,
including real-time audio and video editing.  The kernel is *NOT* for
performance-critical things, unless they cannot be done efficiently in
userspace.  It is for _security_critical_ and _stability_critical_  
things,
and even then, some of those are pushed to userspace as well.

>> NOTE:  Even the FUSE project,  which
>> is in _userspace_ (as opposed to the massive kernelspace mess of   
>> reiser4),
>> is taking a lot of flak for changing UNIX semantics, so I see no  
>> reason
>> why Reiser4 should be special.
>
> Right.  Kernel people hate change.  Got it.
>
> No, seriously, I have to respect the history involved, which is why  
> I'm
> not pretending to know more than I do.

There is a good reason to hate change (at least without thorough  
evidence
to back it up).  Even small changes can break things in subtle ways.   
Big
changes can tend to wreak kernel-global (and even userspace-global)  
havoc.

>> Ok, good.  That's one of the first issues.  A _lot_ of applications
>> would get themselves thoroughly confused at that '...' interface, not
>> to  mention a lot of sysadmins :-D.
>>
>
> Not as much as you think.  Unless a lot of applications can't handle
> opening or saving files that have '...' in the pathname?

If those files are as special as you lead me to believe, even a simple
"tar -cjvf foo.tar.bz2 foo" would break horribly, because it would  
tar up
all sorts of strange special files that shouldn't be included.  Worse,
when I untar that archive on the filesystem, it will overwrite those  
files,
which probably should be overwritten even less than they should be  
stored
in an archive.

> The sysadmin problem doesn't worry me so much.

Personally, I know several sysadmins who, never having heard of Reiser4
but using it anyways, would get scared when all of the '...' directories
started showing up, thinking that some cracker had gotten a module  
loaded
in their kernel.  If you can, please avoid overloading existing  
semantics
in filesystems.  You can either claim that your filesystem is POSIXy,
(similar to ext3, xfs, etc), or you can claim that it's not  
compatible by
design (AFS, Coda) or you can claim that it's a completely virtualized
interface (procfs, sysfs, CKRM fs, etc) and doesn't care about POSIX in
any case.  Reiser4 definitely isn't the third, but neither is it  
either of
the first two, because it would break standard operations.

> Agreed.  I don't know enough about VFS to propose one, though.  I  
> think
> others are working on that, finally.

When the VFS work gets done, this discussion can move on, otherwise, we
are stuck at an impasse.

> Not too much, I hope.
>
> Although being able to use different keys on a per-file basis would be
> nice.  I'm not sure if that would work in the existing system.  Not to
> mention that keys would also be handlable with '...', if/when it  
> happens.

I think the '...' is just a bad idea in general, because it breaks tar
and such.  An interface like this might be simpler to design and use:

# mkdir /attr
# mount -t attrfs attrfs /attr

/attr/fd/$FD_NUM              == '...' directory for a filedescriptor
/attr/fs/$DEV_NUM/$INODE_NUM  == '...' directory for an inode

It would be usable from a shell with a simple "getattrpath" command
which returns "fs/$DEV_NUM/$INODE_NUM" by stat-ing any given path.

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.
  -- C.A.R. Hoare

