Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030574AbWCTWxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030574AbWCTWxN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030578AbWCTWxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:53:13 -0500
Received: from pproxy.gmail.com ([64.233.166.181]:15856 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030574AbWCTWxL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:53:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n/CG6egRRSoiSyUmWaWPpYpvGLmx6LIgEpj6kujaHD1mlvdSIb6gCtncBOCzYBVLEt/Zspx78WsX5ClXE0oIrdBEG00KG1tbzXAyEsrghWV9Ly42zNukMkQBdd6xwR5kIP6Tf/HI6zFwqCoREUznPDBR9nSF50vVd179ksXk7nI=
Message-ID: <4ae3c140603201453p113c8c11h3029d1d55d209e27@mail.gmail.com>
Date: Mon, 20 Mar 2006 17:53:08 -0500
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: "Al Viro" <viro@ftp.linux.org.uk>
Subject: Re: Question regarding to store file system metadata in database
Cc: "Theodore Ts'o" <tytso@mit.edu>, mingz@ele.uri.edu, mikado4vn@gmail.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060320195858.GD27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <441CE71E.5090503@gmail.com>
	 <1142791121.31358.21.camel@localhost.localdomain>
	 <4ae3c140603191011r7b68f4aale01238202656d122@mail.gmail.com>
	 <1142792787.31358.28.camel@localhost.localdomain>
	 <4ae3c140603191050k3bf7e960q9b35fe098e2fbe35@mail.gmail.com>
	 <20060319194723.GA27946@ftp.linux.org.uk>
	 <20060320130950.GA9334@thunk.org>
	 <4ae3c140603200713m24a5af0agd891a709286deb47@mail.gmail.com>
	 <4ae3c140603201136q7e61963dy635bb2c6047f0bc2@mail.gmail.com>
	 <20060320195858.GD27946@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently this comparison is not 100% fair. In my experiment, I
randomly pick pathname from 1.2 million path names to resolve the
inode number. But in your "cp -rl linux2.6 foo1" experiment, you
essentially did directory entry lookup sequentially, which maximize
the possible performance. If you do the same thing in a random
fashion, you will probably get much worse performance. As I said
before, I totally agree that 2000/sec is slow. But the point here is
whether 2000/sec is enough for most scenarios?

I am not saying existing FS implementation is not efficient. I agreed
that file system has been fully optimized. What I want to say is to
support complex mapping in the system I described before, we might
need some extension on existing file systems. Question is what is the
best extension. Consider how to allow user a, b to share physical copy
f.1, while allowing user c to use private copy f.2? The virtual
pathname to physical pathname should be transparent to end users. That
is, all the users should be able to access right file copies using
virtual path "f". The file system should be able to tell the different
identity and return the data from the right physical copy. That's what
we want to do. But it is hard to achieve without some extension. :)

Xin

On 3/20/06, Al Viro <viro@ftp.linux.org.uk> wrote:
> On Mon, Mar 20, 2006 at 02:36:51PM -0500, Xin Zhao wrote:
> > OK. Now I have more experimental results.
> >
> > After excluding the cost of reading file list and do stat(), the
> > insertion rate becomes 587/sec, instead of 300/sec. The query rate is
> > 2137/sec. I am runing mysql 4.1.11. FC4, 2.8G CPU and 1G mem.
> >
> > 2137/sec seems to be good enough to handle pathname to inode
> > resolving.  Anyone has some statistics how many file open in a busy
> > file system?
>
> This is still ridiculously slow.  From cold cache (i.e. with a lot of IO)
> cp -rl linux-2.6 foo1 gives 1.2s here.  That's at least about 50000
> operations.  On slower CPU, BTW, with half of the RAM you have.
>
> Moreover,
> al@duke:~/linux$ time mv foo1 foo2
>
> real    0m0.002s
> user    0m0.000s
> sys     0m0.001s
>
> Now, try _that_ on your setup.  If you are using entire pathname as key,
> you are FUBAR - updating key in 20-odd thousand of records is going to
> _hurt_.  If you are splitting the pathname into components, you've just
> reproduced fs directory structure and had shown that your fs layout
> is too fscking slow.  Not to mention the fun with symlink implementation,
> or handling mountpoints.
>
> You are at least an order of magnitude off by performance (more, actually)
> and I still don't see any reason for what you are trying to do.
>
