Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWCSSuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWCSSuZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 13:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWCSSuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 13:50:24 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:25398 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932166AbWCSSuX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 13:50:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y+TDw5DPPWnX563ryiRT3eqWkBsZQmF+Vyc+OjlCmrV2eqtEUACo8lOcgrsalwNQti4y4VUHg/HQbBMkyNGrLlKKATQMezK2pQnxAQ9Yv75QCA4gTpFGuMfJDrijv+jC+az6LW8r/FWal4lWOghJ4JGl2UiiITbGJMjXnYyzJt8=
Message-ID: <4ae3c140603191050k3bf7e960q9b35fe098e2fbe35@mail.gmail.com>
Date: Sun, 19 Mar 2006 13:50:22 -0500
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: mingz@ele.uri.edu
Subject: Re: Question regarding to store file system metadata in database
Cc: mikado4vn@gmail.com, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1142792787.31358.28.camel@localhost.localdomain>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree that people always want to access metadata faster. But if a
system seldom need to do pathname-to-inode translation for over 300
times per second, even one can access do this translation for over
thousands times per second, the difference on file system performance
could be very small. Plus, I have no real data on how many times a
busy email server open files, but I really doubt it really needs to
open files 300 times/second.

Anybody know how fast a file system can do pathname-to-inode
translation? I know the performance value could vary according to
different access pattern and the size of dentry cache. But an average
value should bu sufficient in our informal discussion.

Last, database-based file system is not so complex. As first step, I
am just proposing to store pathanem-to-inode number in database. So it
is basically a simple table. We don't really need any fancy features
provided by db system. That's why I said a reduced  db system is
enough. So the only difference betwen db-based file system and a
regular one is that regular file system use directory file to store
entries, but db-based file system use database to achieve the same
goal. Looks like db will be a more efficient way. ;-)

Xin

On 3/19/06, Ming Zhang <mingz@ele.uri.edu> wrote:
> no. i have no such statistics. also people always want it to be faster,
> so it is never enough.
>
> from another point of view, if such fs is used by a mail server, large #
> of file create/close/modify will be vital for it. 300/s is not enough
> for a busy mail server of course.
>
> database based file system will be useful for archiving. for heavy
> online use? not sure.
>
> also will a database based fs too be too complex while all benefits
> brought by db can be brought by add-on utilities? find and grep do not
> fit u bill?
>
> ming
>
> On Sun, 2006-03-19 at 13:11 -0500, Xin Zhao wrote:
> > Do you have any statistics on how many metadata accesses are required
> > for a heavy load file system?  I don't have on in hand, but
> > intuitively I think 300 per second should be enough. If storing
> > metadata in database will not hit the file system performance, plus
> > database allows flexible file searching, the database-based file
> > system might not be a bad idea. :)
> >
> > Xin
> >
> > On 3/19/06, Ming Zhang <mingz@ele.uri.edu> wrote:
> > > database can reside on a raw block device.
> > >
> > > but 300 metadata iops is not that fast. ;)
> > >
> > > ming
> > >
> > > On Sun, 2006-03-19 at 12:48 -0500, Xin Zhao wrote:
> > > > well, the database could reside on another file system. So the
> > > > database based file system could be a secondary file system but
> > > > provide more features and  better performance. I am not saying that
> > > > database-based file system must be the only filesystem on the system.
> > > >
> > > > On 3/19/06, Mikado <mikado4vn@gmail.com> wrote:
> > > > > -----BEGIN PGP SIGNED MESSAGE-----
> > > > > Hash: SHA1
> > > > >
> > > > > Where is that database located, on other filesystem or on database-based
> > > > > filesystem?
> > > > >
> > > > > Xin Zhao wrote:
> > > > > > I was wondering why only few file system uses database to store file
> > > > > > system metadata. Here, metadata primarily refers to directory entries.
> > > > > > For example, one can setup a database to store file pathname, its
> > > > > > inode number, and some extended attribution. File pathname can be used
> > > > > > as primary key. As such, we can achieve pathname to inode mapping as
> > > > > > well as many other features such as fast search and extended file
> > > > > > attribute management. In contrast, storing file system entries in
> > > > > > directory files may result in slow dentry search. I guess that's why
> > > > > > ReiserFS and some other file systems proposed to use B+ tree like
> > > > > > strucutre to manage file entries. But why not simple use database to
> > > > > > provide the same feature? DB has been heavily optimized to provide
> > > > > > fast search and should be good at managing metadata.
> > > > > >
> > > > > >  I guess one concern about this idea is  performance impact caused by
> > > > > > database system. I ran a test on a mysql database: I inserted about
> > > > > > 1.2 million such kind of records into an initially empty mysql
> > > > > > database. Average insertion rate is about 300 entries per second,
> > > > > > which is fast enough to handle normal file system burden, I think.  I
> > > > > > haven't try the query speed, but I believe it should be fast enough
> > > > > > too (maybe I am wrong, if so, please point that out.).
> > > > > >
> > > > > > Then I am a little curious why only few people use database to store
> > > > > > file system metadata, although I know WinFS plans to use database to
> > > > > > manage metadata. I guess one reason is that it is difficult for kernel
> > > > > > based file system driver to access database. But this could be
> > > > > > addressed by using efficient kernel/user communication mechanism.
> > > > > > Another reason could be the worry about database system. If database
> > > > > > system crashes, file system will stop functioning too. However, the
> > > > > > feature needed by file system is really a small part of database
> > > > > > system, A reduced database system should be sufficient to provide this
> > > > > > feature and be stable enough to support a file system.
> > > > > >
> > > > > > Can someone point out more issues that could become obstables to using
> > > > > > database to manage metadata for a file system?
> > > > > >
> > > > > > Many thanks!
> > > > > > Xin
> > > > > > -
> > > > > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > > > > the body of a message to majordomo@vger.kernel.org
> > > > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > > > Please read the FAQ at  http://www.tux.org/lkml/
> > > > > >
> > > > > -----BEGIN PGP SIGNATURE-----
> > > > > Version: GnuPG v1.4.2.1 (GNU/Linux)
> > > > > Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
> > > > >
> > > > > iD8DBQFEHOceNWc9T2Wr2JcRAsKKAJ9t1fRZ1xczAaeruDUqTNeLMcGuiwCfeTNt
> > > > > 31pFUK79Q7BE1AptbmNqr9Q=
> > > > > =LbiF
> > > > > -----END PGP SIGNATURE-----
> > > > >
> > > > -
> > > > To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >
> > >
>
>
