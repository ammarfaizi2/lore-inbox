Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266859AbUBQXUl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266866AbUBQXUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:20:40 -0500
Received: from dp.samba.org ([66.70.73.150]:50614 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266859AbUBQXUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 18:20:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16434.41376.453823.260362@samba.org>
Date: Wed, 18 Feb 2004 10:20:00 +1100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <Pine.LNX.4.58.0402170704210.2154@home.osdl.org>
References: <16433.38038.881005.468116@samba.org>
	<Pine.LNX.4.58.0402162034280.30742@home.osdl.org>
	<16433.47753.192288.493315@samba.org>
	<Pine.LNX.4.58.0402170704210.2154@home.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

 > Yes, we could add context sensitivity to the dcache with a context 
 > bitmask.
 > 
 > However, it's _not_ correct.
 > 
 > It assumes that there is only one way to do lower/upper case, which just 
 > isn't true. What about different locales that have different case rules? 
 > Your "one bit per dentry" becomes "one bit per locale per dentry". That's 
 > just horribly hard to do.

I think you're making it sound much harder than it really is.

We just add a VFS hook in the filesystems. The filesystem chooses the
encoding specific comparison function. If the filesystem doesn't
provide one then don't do case insensitivity. If the filesystem does
provide one (for example NTFS, JFS) then use it. Then all I need to do
is convince one of the filesystem maintainers to add a mount time
option to specify the case table (for example by specifying the name
of a file in the filesystem that holds it).

So, all the really ugly stuff is then in the per-filesystem code, and
all the VFS and dcache has to do is know about a single context bit
per dentry. 

 > I don't know how Windows does it, so maybe this thing is hardcoded, and 
 > you don't even want "true" case insensitivity. 

NTFS has a 128k table on disk, created at mkfs time and indexed by the
UCS2 character. The interesting thing about this table is that it
doesn't seem to vary between different locales as one might expect. I
have checked 3 locales so far (Swedish, Japanese and English) and all
have the same 128k table. I should check a few more locales to see if
it really is the same everywhere. Contact me off-list if you have a
NTFS filesystem created in a different locale and would be willing to
run a test program against it to see if the table is different from
the one we have in Samba.

There is stuff in the charset handling of every locale that does vary
in windows, but it isn't the case table, its the "valid characters"
map used to determine what characters are allowed when converting
strings into legacy multi-byte encodings. Even I don't think that the
kernel will ever have to deal with that crap unless someone is foolish
enough to port Samba into the kernel (several people have actually
done that despite the insanity of the idea, but they all did an
absolutely terrible job of it and certainly didn't take care to get
all the charset handling right).

> How "correct" is Windows?

from my rather limited point of view I always have to assume that
windows is "correct", unless I can show that its behaviour leads to
data loss, a security hole or something equally extreme.

Cheers, Tridge
