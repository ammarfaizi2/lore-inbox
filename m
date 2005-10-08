Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbVJHPD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVJHPD1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 11:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbVJHPD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 11:03:27 -0400
Received: from xproxy.gmail.com ([66.249.82.204]:7476 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932150AbVJHPD1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 11:03:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S8mqEkfQA69j4RoTD0ptGD+/s3XCBpKrYOeD5gU5qlXGJjRkkO9pwC6Yu5lhcoDZskhBZc2TxeCEkwA9SLsNKy13VzofAShcFr23CxedCmblGG94nVekZL3fpxqd2f0ey+4Z/rlTbvsK7BAT5ElaNcXl9zDk5iDHZWAUHsFn/s4=
Message-ID: <4ae3c140510080803x5e58e637u1ea91683628cbf67@mail.gmail.com>
Date: Sat, 8 Oct 2005 11:03:26 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
Reply-To: Xin Zhao <uszhaoxin@gmail.com>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: why is NFS performance poor when decompress linux kernel
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4ae3c140510080735q5842d686u2f023b47f7930586@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ae3c140510072139n68b9b2eeyc0a400be32d958fe@mail.gmail.com>
	 <1128751189.17981.62.camel@mindpipe>
	 <20051008071936.GF22601@alpha.home.local>
	 <4ae3c140510080735q5842d686u2f023b47f7930586@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW: where did you see that stat is called before each write? can you
point out the code or function that does this? I might want to look
into the source code to see whether we can improve it.

Thanks,

Xin

On 10/8/05, Xin Zhao <uszhaoxin@gmail.com> wrote:
> I think the stat might be one reason. cuz when I do 'nfsstat', I
> noticed that "getattr" and "setattr" are executed about 40000 times
> while other operations are executed for less than 10000 times. That
> gave me a feeling that some optimization can be considered to reduce
> the getattr and setattr requests.
>
> async and sync options affect write performance on large files more
> significantly. But decompress kernel involves a lot of small files.
> Because nfs will force data sync to disk before file close. async and
> sync do not behave quite different.
>
> Anyone has exeprience with NFS4? I don't know whether it improves in this parts
>
> Xin
>
> On 10/8/05, Willy Tarreau <willy@w.ods.org> wrote:
> > Hi,
> >
> > On Sat, Oct 08, 2005 at 01:59:48AM -0400, Lee Revell wrote:
> > > On Sat, 2005-10-08 at 00:39 -0400, Xin Zhao wrote:
> > > > I noticed that when doing large file copy or linux kernel compilation
> > > > in a NFS direcotry, the performance is not bad compared to local disk
> > > > filesystem such as ext2. However, if I do linux kernel tarball
> > > > decompression on a NFS directory, the performance is much worse than
> > > > local disk filesystem (over 3 times slower). Anybody know the reason?
> > >
> > > Because NFS requires all writes to be synchronous by default, and
> > > uncompressing the kernel is the most write intensive of those three
> > > operations.  Mount with the async option and the performance should be
> > > closer to a local disk.  Obviously this is more dangerous.
> >
> > I don't agree with you, Lee. My NFS is mounted with async by default,
> > and what takes the most time when extracting a kernel archive is that
> > tar does a stat() on every file before writing it. And THAT stat()
> > prevents writes from being buffered. A better solution might be to
> > process several files in parallel (multi-process/multi-thread).
> > Perhaps a project for a new tar ?
> >
> > Just for a test, I tried extracting multiple files in parallel. The
> > method is completely crappy, but I could saturate my NFS server this
> > way :
> >
> > $ tar ztf /tmp/linux-2.6.9.tar.gz >/tmp/file-list
> > $ sed -n '1~4p' < /tmp/file-list >/tmp/file-list1
> > $ sed -n '2~4p' < /tmp/file-list >/tmp/file-list2
> > $ sed -n '3~4p' < /tmp/file-list >/tmp/file-list3
> > $ sed -n '4~4p' < /tmp/file-list >/tmp/file-list4
> >
> > $ tar zxf /tmp/linux-2.6.9.tar.gz -T /tmp/file-list1 & tar zxf /tmp/linux-2.6.9.tar.gz -T /tmp/file-list2 & tar zxf /tmp/linux-2.6.9.tar.gz -T /tmp/file-list3 & tar zxf /tmp/linux-2.6.9.tar.gz -T /tmp/file-list4 & wait
> >
> > OK, it finally took more time, although the server was saturated (maybe
> > it crawled under seeks at the end, I did not check). This may constitute
> > a starting point for people having more time to research in this area.
> >
> > > Lee
> >
> > Cheers,
> > Willy
> >
> >
>
