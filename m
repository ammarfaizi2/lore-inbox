Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUEQQXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUEQQXQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 12:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUEQQXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 12:23:16 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:49358 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261857AbUEQQXI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 12:23:08 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 17 May 2004 09:23:01 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Wayne Scott <wscott@bitmover.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, elenstev@mesatop.com,
       lm@bitmover.com, William Lee Irwin III <wli@holomorphy.com>,
       hugh@veritas.com, adi@bitmover.com, scole@lanl.gov,
       support@bitmover.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 1352 NUL bytes at the end of a page?
In-Reply-To: <20040517151738.GA4730@thunk.org>
Message-ID: <Pine.LNX.4.58.0405170919590.19557@bigblue.dev.mdolabs.com>
References: <200405162136.24441.elenstev@mesatop.com>
 <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org> <20040516231120.405a0d14.akpm@osdl.org>
 <20040517.085640.30175416.wscott@bitmover.com> <20040517151738.GA4730@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2004, Theodore Ts'o wrote:

> On Mon, May 17, 2004 at 08:56:40AM -0500, Wayne Scott wrote:
> > From: Andrew Morton <akpm@osdl.org>
> > > Well we can stop right there, because the only way someone can get some
> > > more non-zero user data into this page before we memset and write it is by
> > > locking the page beforehand, and block_write_full_page() has the page lock.
> > > (Or they can write stuff into it via mmap, but writing to the page outside
> > > i_size is an application bug).
> > 
> > BTW: BitKeeper never opens a writable mmap to a file.  The files are
> > read with mmap() and written by fwriting to a tmp file and then
> > renaming over the target.  And since we run on Windows, no process has
> > the file open when we are updating it.
> 
> Note though that the stdio library uses a writeable mmap to implement
> fwrite.

Strange, it uses read/write but it also opens an mmap(private and 
anonymous):


#include <stdio.h>

int main(int ac, char **av) {
	size_t rd;
	FILE *fp;
	static char buf[1024 * 64];

	fp = fopen(av[1], "r+");
	rd = fread(buf, 1, sizeof(buf), fp);
	fseek(fp, 0, SEEK_SET);
	fwrite(buf, 1, rd, fp);
	fflush(fp);
	fclose(fp);

	return 0;
}


[davide@bigblue davide]$ strace ./foo zzzzzzzzzzzzzzzzzzz
execve("./foo", ["./foo", "zzzzzzzzzzzzzzzzzzz"], [/* 30 vars */]) = 0
uname({sys="Linux", node="bigblue.dev.mdolabs.com", ...}) = 0
brk(0)                                  = 0x9cc8000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or 
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=84014, ...}) = 0
old_mmap(NULL, 84014, PROT_READ, MAP_PRIVATE, 3, 0) = 0xbf50b000
close(3)                                = 0
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\350\270"..., 
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1578228, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xbf50a000
old_mmap(0xb79000, 1281996, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 
0xb79000
old_mmap(0xcac000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0x132000) = 0xcac000
old_mmap(0xcb0000, 8140, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xcb0000
close(3)                                = 0
set_thread_area({entry_number:-1 -> 6, base_addr:0xbf50a740, 
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, 
limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0xbf50b000, 84014)               = 0
brk(0)                                  = 0x9cc8000
brk(0x9ce9000)                          = 0x9ce9000
brk(0)                                  = 0x9ce9000
open("zzzzzzzzzzzzzzzzzzz", O_RDWR)     = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=188307, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0xbf51f000
read(3, "<!DOCTYPE HTML PUBLIC \"-//IETF//"..., 65536) = 65536
_llseek(3, 0, [0], SEEK_SET)            = 0
write(3, "<!DOCTYPE HTML PUBLIC \"-//IETF//"..., 65536) = 65536
close(3)                                = 0
munmap(0xbf51f000, 4096)                = 0
exit_group(0)



- Davide

