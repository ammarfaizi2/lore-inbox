Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVCGK26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVCGK26 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 05:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVCGK26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 05:28:58 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:4039 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261737AbVCGK2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 05:28:51 -0500
Date: Mon, 7 Mar 2005 03:28:46 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: "Edgar, Bob" <Bob.Edgar@commerzbankib.com>
Cc: "'Jesper Juhl'" <juhl-lkml@dif.dk>, Steve French <sfrench@us.ibm.com>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Luca Tettamanti <kronos@kronoz.cjb.net>,
       samba-technical <samba-technical@lists.samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Domen Puncer <domen@coderock.org>
Subject: Re: [PATCH] whitespace cleanups for fs/cifs/file.c
Message-ID: <20050307102846.GF27352@schnapps.adilger.int>
Mail-Followup-To: "Edgar, Bob" <Bob.Edgar@commerzbankib.com>,
	'Jesper Juhl' <juhl-lkml@dif.dk>, Steve French <sfrench@us.ibm.com>,
	=?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	Luca Tettamanti <kronos@kronoz.cjb.net>,
	samba-technical <samba-technical@lists.samba.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Domen Puncer <domen@coderock.org>
References: <9D248E1E43ABD411A9B600508BAF6E9B0C737269@xmx7fraib.fra.ib.commerzbank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9D248E1E43ABD411A9B600508BAF6E9B0C737269@xmx7fraib.fra.ib.commerzbank.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 07, 2005  10:26 +0100, Edgar, Bob wrote:
> I lurk on the list and didn't comment last time but there is one aspect
> of this patch that I think is "bad" style. The function declaration should
> not be on the same line with the type. Why? Try to find the file where a
> function is defined instead of used. If you grep "^funcname" you'll find
> it quite simply. The same is true in YFE (mine being vi) /^funcname gets
> me there in one shot.
> 
> This may not seem an important thing but when you are coming into a
> project cold and don't know how anything works or where it lives it
> can be very important. Consider trying to find where some common
> function from a library is defined in a project with sever 1000 files.

Tags is your friend.  See "make tags" (for vim) or "make TAGS" (for *emacs).
This is far more efficient than "grep -r ^funcname linux" if you don't even
know what file a function/struct is defined in.  Use CTRL-] to jump to the
function/struct under the cursor and CTRL-T to pop back out.


Ironically, the whitespace patch gets the small things right, but misses
on the big readability issues, such as cifs_open() being 220 lines long
and having a _really_ hard time staying inside 80 columns because of so
many levels of nested conditionals.

Judicious use of gotos and some helper functions would help a lot
here (e.g.  after CIFSSMBOpen() "if (rc) { ... goto out; }" and
"if (!file->private_data) goto out;", would avoid indenting the rest
of the function 16 columns.  Adding a couple helper functions like
"cifs_convert_flags()" to return desiredAccess and disposition, and
"cifs_init_private_data()" to allocate ->private_data and initialize
the masses of fields would be good.

Is it possible that pCifsInode can ever be NULL???  Similarly, "if (buf)"
on line 196 is needless, as it has already been checked on line 153
(and we abort in that case).  Also, kfree() can handle NULL pointers.

Cheers, Andreas
--
Andreas Dilger
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/

