Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267072AbUBRBKV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 20:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267076AbUBRBKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 20:10:21 -0500
Received: from smtp-roam.Stanford.EDU ([171.64.14.91]:15262 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S267072AbUBRBKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 20:10:09 -0500
Message-ID: <4032BB5A.7040803@myrealbox.com>
Date: Tue, 17 Feb 2004 17:09:46 -0800
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Tridgell <tridge@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: UTF-8 and case-insensitivity
References: <fa.epf5o9k.1rkudgo@ifi.uio.no> <fa.idvvhjl.1jge92d@ifi.uio.no>
In-Reply-To: <fa.idvvhjl.1jge92d@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 	int magic_open(
> 		/* Input arguments */
> 		const char *pathname,
> 		unsigned long flags,
> 		mode_t mode,
> 
> 		/* output arguments */
> 		int *fd,
> 		struct stat *st,
> 		int *successful_path_length);
> 
> ie the system call would:
> 
>  - look up as far into the pathname (using _exact_ lookup) as possible
>  - return the error code of the last failure
>  - the "flags" could be extended so that you can specify that you mustn't 
>    traverse ".." or symlinks (ie those would count as failures)
> 
> but also:
> 
>  - fill in the "struct stat" information for the last _successful_ 
>    pathname component.
>  - fill in the "fd" with a fd of the last _successful_ pathname component.
>  - tell how much of the pathname it could traverse.

Aside from just case-insensitivity, I imagine this could give lots of other 
benefits:

  - file servers that don't want to follow symlinks can do it quickly.
  - Apache could serve things like http://www.foo.com/a/b/c/d.php/e/f/g a lot 
faster.
  - a flag to avoid traversing mountpoints could help someone
  - a flag for root to see _through_ mountpoints would make it possible to clean 
up initramfs and such that got mounted over, or to do other useful and currently 
  impossible tasks.  (e.g. I could see what's under my devfs mount...)

I would be nice to see this added even if it's not the perfect solution for samba :)

BTW, here's a thought for solving samba's negative lookup problem:

int ugly_stat(char *pattern, struct stat *st, char *match_out)

Pattern would be some description of what the filename should look like. 
Something like:

- pattern is an array of slash-delimited groups of characters separated by nulls 
and terminated by two nulls.  For example, ugly_stat("F/f\0O/o\0O/o\0\0", ...) 
finds a file called foo, case-insensitively in English, while 
ugly_stat("F\0i\0l\0e\011/22/33") finds "File" followed by either 11, 22, or 33.
- the dcache problem is easy: don't use it.  All Andrew wants (I think) is proof 
that there is no such file or the name if there is one.  Samba can cache it 
itself; I don't think the kernel should involve itself in trying to cache this.
- ugly_stat does not traverse directories -- that's why the slash trick is safe.
- st gets the stat data, and match_out gets the filename if any
- if there are multiple matches, one is arbitrarily selected.

If the file-system doesn't have specific support for this, then either VFS or 
the caller could emulate it (probably VFS -- it would avoid lots of syscalls).

Would ugly_stat + magic_open be sufficient?

--Andy
