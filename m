Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269528AbUHZT5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269528AbUHZT5L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269454AbUHZTzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:55:25 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:50953 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S269533AbUHZTw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:52:27 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "John Stoffel" <stoffel@lucent.com>, Jamie Lokier <jamie@shareable.org>
Subject: Re: silent semantic changes with reiser4
Date: Thu, 26 Aug 2004 22:51:55 +0300
User-Agent: KMail/1.5.4
Cc: Rik van Riel <riel@redhat.com>, Christophe Saout <christophe@saout.de>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
References: <20040826154446.GG5733@mail.shareable.org> <20040826165351.GM5733@mail.shareable.org> <16686.15061.549250.611694@gargle.gargle.HOWL>
In-Reply-To: <16686.15061.549250.611694@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408262251.55342.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 August 2004 22:32, John Stoffel wrote:
> Jamie> Rik van Riel wrote:
> >> And if an unaware application reads the compound file
> >> and then writes it out again, does the filesystem
> >> interpret the contents and create the other streams ?
>
> Jamie> Yes, exactly that.  The streams are created on demand of
> Jamie> course, and by userspace helpers when that's appropriate which
> Jamie> I suspect it almost always is.
>
> So how would a program that converts between a JPEG file (with exif
> data) and a PNG work, such as ImageMagick?  Are we proposing to teach
> the VFS (or worse yet each filesystem) how to do this?
>
> I've been following this discussion a bit and I'm not sure that I've
> actually seen any concrete examples of where this is a *good* thing to
> have.  People talk about only having to modify 20 bytes at a time
> instead of reading and writing 1mb of data.  Isn't that what mmap()
> does?
>
> Now I can sorta understand the idea that having a directory look like
> a file is neat, and certainly simplifies some aspects, but I think
> that going all the way down to the logical conclusion here is a bit
> silly.
>
> To use the principle of blowing things up to make them very large or
> very small, what happens if I decide that the best idea is to make all
> files just be directories which contain single byte files?  Isn't that
> the logical extreme here?  So my 1mb JPEG file is not just some image
> data and header info in multiple files, but it's really just 1
> million (ok 1024 * 1024) individual files that the VFS knows how to
> put together.  Seems like the logical extreme.  Oh wait, maybe we
> should be exposing a single file per bit instead!

It is doable. It doesn't mean we shall do this.

I think some reiser4 supporters try to do too much too soon.
It is more sensible to do it in small steps.

I think we can start small and make all file metadata to be accessible
via file/meta/{uid,gid,mode,mtime,atime,...}.

Normal tools will be unable to see file/meta/ because file is not
a directory and file/ is not a directory (i.e. open(O_DIRECTORY)
will fail on them). Hardlinking to file/meta/* is not allowed.

However, file/. _is_ a directory. We can make a tar-like
tool which can do its work and save/restore metadata along with data
by just tarring/untarring file/meta/*. Notice how this 'new tar'
does not need to know about exact kind of metadata supported by fs.
You can add ACLs to the fs, and this 'new tar' will be able to save/restore
ACLs. Without any modufications.

Contrast this with existing tar which has hardcoded knowlendge about
uid,gid,mode,etc...
--
vda

