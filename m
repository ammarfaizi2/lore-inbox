Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266771AbUBQXnU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266775AbUBQXnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:43:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:32194 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266771AbUBQXnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 18:43:10 -0500
Date: Tue, 17 Feb 2004 15:43:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: tridge@samba.org
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <16434.41376.453823.260362@samba.org>
Message-ID: <Pine.LNX.4.58.0402171531570.2154@home.osdl.org>
References: <16433.38038.881005.468116@samba.org> <Pine.LNX.4.58.0402162034280.30742@home.osdl.org>
 <16433.47753.192288.493315@samba.org> <Pine.LNX.4.58.0402170704210.2154@home.osdl.org>
 <16434.41376.453823.260362@samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Feb 2004 tridge@samba.org wrote:
> 
> I think you're making it sound much harder than it really is.

I think I'm just making the mistake of assuming that anybody would care to 
do it "right", while everybody really only cares to get it be compatible 
with Windows.

For example, if you only want to be compatible with Windows, you don't 
have to worry about UCS-4, you only have the UCS-2 part, which means that 
you can do a silly array-lookup based thing or something.

> We just add a VFS hook in the filesystems. The filesystem chooses the
> encoding specific comparison function. If the filesystem doesn't
> provide one then don't do case insensitivity. If the filesystem does
> provide one (for example NTFS, JFS) then use it. Then all I need to do
> is convince one of the filesystem maintainers to add a mount time
> option to specify the case table (for example by specifying the name
> of a file in the filesystem that holds it).

Ugh. What a horrible kludge, and it won't work without "preparing" the 
filesystem at mount-time. I'd much rather leave the translation table in 
user space, and just give it as an argument to the "look up case 
insensitive" special thing.

That would mean that we can hold the directory semaphore over the whole 
thing, which would simplify _my_ kludge, since there would be no need to 
worry about user space having separate stages.

The hard part would be negative dentries. We'd have to invalidate all
"case-insensitive" negative dentries when creating any new file in a
directory, and that would be something the generic VFS layer would have to 
know about, and that might be unacceptable to Al.

		Linus
