Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267720AbUIAHXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267720AbUIAHXw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 03:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267689AbUIAHXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 03:23:52 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:20359 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267628AbUIAHWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 03:22:53 -0400
Message-ID: <413578C9.8020305@namesys.com>
Date: Wed, 01 Sep 2004 00:22:49 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@ucw.cz>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl> <41352279.7020307@slaphack.com> <41356321.4030307@namesys.com> <Pine.LNX.4.58.0408312259180.2295@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408312259180.2295@ppc970.osdl.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Tue, 31 Aug 2004, Hans Reiser wrote:
>  
>
>>You are saying, 1-2% simpler and better, no biggie, why work so hard to 
>>get it?
>>
>>And we are saying, 1-2% simpler and better, times thousands of 
>>applications, wow! That's a lot!
>>    
>>
>
>But would thousands care? Seriously?
>  
>
>For example, you could make just _one_ program support "openat()", and 
>you'd get most of the advantages, with no possibility of _breaking_ any of 
>thousands of applications..
>
>I know, you've ignored the "runat" program (which is just a wrapper around
>the openat() system call), but it _has_ been mentioned several times in 
>this thread. Yes, you'd type a bit more to do
>
>	runat file ls -l
>
>instead of
>
>	ls -l file/
>
>but at least the openat/runat approach also works for directories, which 
>does actually make it a lot more _generic_ than the "show in the regular 
>filespace" approach. No special cases.
>  
>
So you are saying I can do runat emacs my-compound-document/stream-name? 
and in place of CTRL-X CTRL-F to open a file in emacs I type what to 
open an attribute?

I think it does not work Linus....


>So your comparison isn't valid, because you're ignoring the people who
>shout "runat" at you. You've also not ever actually answered about the
>problems about directories with attributes.
>  
>
Which problem specifically? I will list them and hope I don't miss what 
you want addressed. I won't claim to be sure I have the right answers 
for all of these (because VFS has not been my interest in the past), but 
these look feasible to me.;-)

Cycle detection:

We should either 1) make hard links only link to the file aspect of the 
file-directory duality, and persons who want to link to the directory 
aspect must use symlinks (best short term answer), or 2) ask Alexander 
Smith to help us with applying his cycle detection algorithm and gain 
the benefit of being able to hard link to directories (if it works well, 
best long term answer).

Ambiguity:

Linus said:

 - how do you handle the ambiguity of
	//attr/usr/bin/emacs/icon
   (is that the "icon" attribute on "/usr/bin/emacs", or is it perhaps the 
   "emacs/icon" attribute on "/usr/bin").

If you want to avoid crowding the namespace with some piece of meta 
information that you want to be applicable to both directories and the 
files in them, and also widely used enough that you care about crowding 
the namespace, and unambiguous as to what level in the hierarchy it 
metas, then you put it into the metas subdirectory. There is no 
principled difference between a file that is a child of a directory and 
an attribute. The ambiguity is inherent in hiearchical semantics I 
think, and whether or not you have attributes you have this type of 
ambiguity.

Thus, you have either:

/usr/bin/metas/emacs/icon

or /usr/bin/emacs/metas/icon

and these are easily distinguished and unambiguous. This makes metas a 
reserved keyword, and there was a long discussion about whether to use 
"metas" or "..metas" as the reserved subdirectory name which I can 
summarize for you on request. There is also "pseudos", which contains 
files implementing special methods of special plugins. Feel free to 
invent more reserved subdirectories as needed, or to argue for fewer.


Seeing two trees, one with attrs and one without:

Linus said:

If you open a filename in some "secondary" tree (be it /proc or //attr or 
whatever) based on the filename in the primary one, you have two issues 
that you need to work out:

 - how do you handle a name change in the primary tree at the same time as 
   lookup
 - how do you handle the ambiguity of
	//attr/usr/bin/emacs/icon
   (is that the "icon" attribute on "/usr/bin/emacs", or is it perhaps the 
   "emacs/icon" attribute on "/usr/bin").

The ambiguity can be handled by saying that attributes only have one
component (ie only the _last_ component of a lookup is the attribute
name). But the race between primary tree and secondary tree cannot be
handled in a normal name-space.

Are you sure that you have to have two trees in order to see two trees? 
That is, can you not refuse to follow or see a link depending on whether 
some flag is set and what the type of the link is?

Locking: 

Linus said:

let's say that you have filename "a" hard-linked to filename "b", 
and you have a directory structure of streams under there. So you have

	a/file1
	a/dir1/file2
	a/dir2/file3

and (through the hard-link with "b") you have aliases of all these same 
names available as "b/file1", "b/dir1/file2" etc).

Now, imagine that you have two processes doing

	mv a/dir1 a/dir2/newdir

and

	mv b/dir2 b/dir1/newdir

at the same time. Both of them MUST NOT SUCCEED, for pretty obvious 
reasons (you'd have moved two directories within each other, and now 
neither would be accessible any more).

How do you handle locking for this situation?

  

(Here is where my knowledge of VFS is shakiest.)  Making "hard links only link to the file aspect of the file-directory duality, and persons who want to link to the directory aspect must use symlinks" seems to solve this.  If we want to use the Alexander Smith solution to cycle detection, and allow hard links to directories, then we must make sure that for the hard linked entity, there is a single lock for it somewhere (e.g. the directory inode) that can be taken.  If you create two dentries for the same object, then flag the dentries as needing to lock a lock in their shared inode and not in the dentry.  If you don't want to read in the inode from disk to do that, then create a pointer to a lock shared by them both.

Linus, is this a start on solving some of the issues?  

