Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWEDMi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWEDMi7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 08:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWEDMi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 08:38:59 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:54481 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932294AbWEDMi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 08:38:58 -0400
Message-ID: <346744728.01465@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 4 May 2006 20:12:12 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Linda Walsh <lkml@tlinx.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] kernel facilities for cache prefetching
Message-ID: <20060504121212.GA6008@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Linda Walsh <lkml@tlinx.org>, linux-kernel@vger.kernel.org
References: <346556235.24875@ustc.edu.cn> <44592491.4060503@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44592491.4060503@tlinx.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2006 at 02:45:53PM -0700, Linda Walsh wrote:
>    1. As you mention; reading files "sequentially" through the file
> system is "bad" for several reasons.  Areas of interest:
>    a) don't go through the file system.  Don't waste time doing
> directory lookups and following file-allocation maps;  Instead,
> use raw-disk i/o and read sectors in using device & block number.

Sorry, it does not fit in the linux's cache model.

>    b) Be "dynamic"; "Trace" (record (dev&blockno/range) blocks
> starting ASAP after system boot and continuing for some "configurable"
> number of seconds past reaching the desired "run-level" (coinciding with
> initial disk quiescence).  Save as "configurable" (~6-8?) number of
> traces to allow finding the common initial subset of blocks needed.

It is a alternative way of doing the same job: more precise, with more
complexity and more overhead.  However the 'blockno' way is not so
tasteful.

>    c) Allow specification of max# of blocks and max number of "sections"
> (discontiguous areas on disk);

Good point, will do it in my work.

>    d) "Ideally", would have a way to "defrag" the common set of blocks.
> I.e. -- moving the needed blocks from potentially disparate areas of
> files into 1 or 2 contiguous areas, hopefully near the beginning of
> the disk (or partition(s)).
>    That's the area of "boot" pre-caching.

I guess poor man's defrag would be good enough for the seeking storm.

> Next is doing something similar for "application" starts.  Start tracing
> when an application is loaded & observe what blocks are requested for
> that app for the first 20 ("configurable") seconds of execution.  Store
> traces on a per-application basis.  Again, it would be ideal if the
> different files (blocks, really), needed by an application could be
> grouped so that sequentially needed disk-blocks are stored sequentially
> on disk (this _could_ imply the containing files are not contiguous).
> 
> Essentially, one wants to do for applications, the same thing one does
> for booting.  On small applications, the benefit would likely be negligible,
> but on loading a large app like a windowing system, IDE, or database app,
> multiple configuration files could be read into the cache in one large
> read.
> 
>    That's "application" pre-caching.

Yes, it is a planned feature, will do it.

>    A third area -- that can't be easily done in the kernel, but would
> require a higher skill level on the part of application and library
> developers, is to move towards using "delay-loaded" libraries.  In
> Windows, it seems common among system libraries to use this feature. 
> An obvious benefit -- if certain features of a program are not used,
> the associated libraries are never loaded.  Not loading unneeded parts
> of a program should speed up initial application load time, significantly.

Linux already does lazy loading for linked libs. The only one pitfall
is that /lib/ld-linux.so.2 seems to touch the first 512B data of every
libs before doing mmap():

% strace date
execve("/bin/date", ["date"], [/* 41 vars */]) = 0
uname({sys="Linux", node="lark", ...})  = 0
brk(0)                                  = 0x8053000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f0e000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f0d000
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=77643, ...}) = 0
mmap2(NULL, 77643, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7efa000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)

open("/lib/tls/librt.so.1", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\35\0\000"..., 512) = 512
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~HERE~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fstat64(3, {st_mode=S_IFREG|0644, st_size=30612, ...}) = 0
mmap2(NULL, 29264, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7ef2000
mmap2(0xb7ef8000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6) = 0xb7ef8000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)

open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260O\1"..., 512) = 512
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~HERE~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fstat64(3, {st_mode=S_IFREG|0755, st_size=1270928, ...}) = 0
mmap2(NULL, 1276892, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7dba000
mmap2(0xb7ee8000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x12e) = 0xb7ee8000
mmap2(0xb7ef0000, 7132, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7ef0000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)

open("/lib/tls/libpthread.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340G\0"..., 512) = 512
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~HERE~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fstat64(3, {st_mode=S_IFREG|0755, st_size=85770, ...}) = 0
mmap2(NULL, 70104, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7da8000
mmap2(0xb7db6000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd) = 0xb7db6000
mmap2(0xb7db8000, 4568, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7db8000
close(3)                                = 0

They can lead to more seeks, and also disturb the readahead logic much.

Wu
