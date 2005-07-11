Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262539AbVGKT6C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbVGKT6C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 15:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbVGKTwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 15:52:31 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:44296 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S262527AbVGKTvs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 15:51:48 -0400
Message-ID: <42D2DB99.9050307@slaphack.com>
Date: Mon, 11 Jul 2005 15:50:33 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: Hans Reiser <reiser@namesys.com>, Hubert Chan <hubert@uhoreg.ca>,
       Ross Biro <ross.biro@gmail.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: reiser4 plugins
References: <hubert@uhoreg.ca>	<200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>	<87hdfgvqvl.fsf@evinrude.uhoreg.ca>	<8783be6605062914341bcff7cb@mail.gmail.com>	<878y0svj1h.fsf@evinrude.uhoreg.ca> <42C4F97B.1080803@slaphack.com> <87ll4lynky.fsf@evinrude.uhoreg.ca> <42CB0328.3070706@namesys.com> <42CB07EB.4000605@slaphack.com> <42CB0ED7.8070501@namesys.com> <42CB1128.6000000@slaphack.com> <42CB1C20.3030204@namesys.com> <42CB22A6.40306@namesys.com> <42CBE426.9080106@slaphack.com> <42D1F06C.9010905@stesmi.com>
In-Reply-To: <42D1F06C.9010905@stesmi.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Smietanowski wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
>>Ok, still haven't heard much discussion of metafs vs file-as-directory,
>>but it seems like it'd be easier in metafs.
> 
> 
> Why not implement it inside the directory containg the file ?
> 
> Ie the metadata for /home/stesmi/foo is in /home/stesmi/.meta/foo
> 
> This should be suit both camps I'd think?

You still need to figure out the parent of "foo", which isn't 
necessarily easy, especially considering that even if we store a link to 
the parent, it will be inside the metadata.  Then you have a 
chicken-and-egg situation.

Both camps seem to want to allow easy access to the metadata of a file, 
whether we're given that file as an inode or as a pathname.  That's why 
I suggested /meta/vfs and /meta/inode -- sometimes I want to look up a 
file by name, and sometimes by inode, but either way, I should be able 
to get its metadata.

> I mean, editing something is easy and you don't have to "know" how
> to navigate /meta

But then you have to "know" how to navigate .meta, and more importantly, 
how to find .meta

> and you don't have the clash of files vs metadata
> (is /meta/vfs/home/stesmi/foo a file or an attribute called foo of
> the dir stesmi ?).

So, how do I get metadata of a directory?  If the metadata for /home/me 
is in /home/.meta/me, and the metadata for /home is in /.meta/home, then 
where is the metadata for / ?

> /home/stesmi/foo <- dir
> /home/stesmi/.meta/foo <- "dir" containing all metadata
> /home/stesmi/.meta/foo/attrib <- some attribute called attrib
> /home/stesmi/foo/bar <- file
> /home/stesmi/foo/.meta/bar <- "dir" containg all metadata
> /home/stesmi/foo/.meta/bar/attrib <- some attribute called attrib

[...]

> If this has already been taken up, I must've missed it.

It looks a lot like how I suggested we resolve the ambiguity within 
/meta/vfs, only I called it '...' instead of '.meta'.

Either way, the major challenge to this method is not so much whether 
it'd work, but how to choose a suitable delimiter?  The delimiter must 
be standard if we're going to have apps develop for it, and it must not 
be used in the name of any existing file or directory.

I had a long essay here on how '.meta' breaks every recursive operation 
on directories (rm -rf, tar, mkisofs), but I deleted it when I 
remembered that I played around with the alpha/beta reiser4 which had a 
'metas' dir that did the same thing, but was hidden from the normal 
directory listing.  'cd metas' worked, 'ls metas' worked, but 'ls' 
showed no directory called 'metas'.

I don't *think* there are any apps that will break if you tell them to 
open a path that doesn't exist in a directory listing.  That is, typing 
'vim /home/metas/acl' should always let me edit the acl on /home, and 
vim should never complain about how /home/metas doesn't show up in 
/home.  A program would have to be pretty retarded to fail on something 
like that.

But, we have to support some pretty retarded programs.  That is why I 
like /meta -- the default view is a completely POSIX-compliant tree that 
works with tar, and even the /meta view is POSIX-compliant, even if it'd 
be a bad idea to tar it.  Then we don't have to worry at all about 
stupid programs.

How much should we be worrying about this particular brand of stupidity? 
  And what's a good delimiter?


-- 
No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.323 / Virus Database: 267.8.12/46 - Release Date: 7/11/2005

