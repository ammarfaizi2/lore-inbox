Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWB0Vxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWB0Vxl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 16:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWB0Vxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 16:53:41 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:50115 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S932339AbWB0Vxk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 16:53:40 -0500
Message-ID: <440374DF.8080901@namesys.com>
Date: Mon, 27 Feb 2006 13:53:35 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Marr <marr@flex.com>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: Drastic Slowdown of 'fseek()' Calls From 2.4 to 2.6 -- VMM Change?
References: <200602241522.48725.marr@flex.com> <20060224211650.569248d0.akpm@osdl.org>
In-Reply-To: <20060224211650.569248d0.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>
>runs like a dog on 2.6's reiserfs.  libc is doing a (probably) 128k read
>on every fseek.
>
>- There may be a libc stdio function which allows you to tune this
>  behaviour.
>
>- libc should probably be a bit more defensive about this anyway -
>  plainly the filesystem is being silly.
>  
>
I really thank you for isolating the problem, but I don't see how you
can do other than blame glibc for this.  The recommended IO size is only
relevant to uncached data, and glibc is using it regardless of whether
or not it is cached or uncached.   Do I misunderstand something myself here?

>- You can alter the filesystem's behaviour by mounting with the
>  `nolargeio=1' option.  That sets stat.blksize back to 4k.
>
>  This will alter the behaviour of every reiserfs filesystem in the
>  machine.  Even the already mounted ones.
>
>  `mount -o remount,nolargeio=1' can probably also be used.  But that
>  won't affect inodes which are already in cache - a umount/mount cycle may
>  be needed.
>
>  If you like, you can just mount and unmount a different reiserfs
>  filesystem to switch this reiserfs filesystem's behaviour.  IOW: the
>  reiserfs guys were lazy and went and made this a global variable :(
>
>- fseek is a pretty dumb function anyway - you're better off with
>  stateless functions like pread() - half the number of syscalls, don't
>  have to track where the file pointer is at.  I don't know if there's a
>  pread()-like function in stdio though?
>
>No happy answers there, sorry.  But a workaround.
>
>
>  
>

