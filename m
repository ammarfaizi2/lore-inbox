Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262457AbVBXTXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbVBXTXL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 14:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbVBXTXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 14:23:11 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:47278 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262457AbVBXTWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 14:22:50 -0500
Subject: Re: [PATCH] A new entry for /proc
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton OSDL <akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 24 Feb 2005 13:56:19 -0500
Message-Id: <1109271379.5125.180.camel@cube>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[quoting various people...]

> Here is a new entry developed for /proc that prints for each process
> memory area (VMA) the size of rss. The maps from original kernel is   
> able to present the virtual size for each vma, but not the physical   
> size (rss). This entry can provide an additional information for tools
> that analyze the memory consumption. You can know the physical memory
> size of each library used by a process and also the executable file.
>
> Take a look the output:
> # cat /proc/877/smaps 
> 08048000-08132000 r-xp  /usr/bin/xmms
> Size:     936 kB
> Rss:     788 kB 
> 08132000-0813a000 rw-p  /usr/bin/xmms
> Size:      32 kB
> Rss:      32 kB 
> 0813a000-081dd000 rw-p
> Size:     652 kB
> Rss:     616 kB

The most important thing about a /proc file format is that it has
a documented means of being extended in the future. Without such
documentation, it is impossible to write a reliable parser.

The "Name: value" stuff is rather slow. Right now procps (ps, top, etc.)
is using a perfect hash function to parse the /proc/*/status files.
("man gperf") This is just plain gross, but needed for decent performance.

Extending the /proc/*/maps file might be possible. It is commonly used
by debuggers I think, so you'd better at least verify that gdb is OK.
The procps "pmap" tool uses it too. To satisfy the procps parser:

a. no more than 31 flags
b. no '/' prior to the filename
c. nothing after the filename
d. no new fields inserted prior to the inode number

> If there were a use for it, that use might want to distinguish between
> the "shared rss" of pagecache pages from a file, and the "anon rss" of
> private pages copied from file or originally zero - would need to get
> the struct page and check PageAnon.  And might want to count swap
> entries too.  Hard to say without real uses in mind.
...
> It's a mixture of two different styles, the /proc/<pid>/maps
> many-hex-fields one-vma-per-line style and the /proc/meminfo
> one-decimal-kB-per-line style.  I think it would be better following
> the /proc/<pid>/maps style, but replacing the major,minor,ino fields
> by size and rss (anon_rss? swap?) fields (decimal kB? I suppose so).

The more info the better. See the pmap "-x" option, currently missing
some data that the kernel does not supply. There are numerous other     
pmap options that are completely unimplemented because of the lack of   
info. See the Solaris 10 man page for pmap, available on Sun's web site.


