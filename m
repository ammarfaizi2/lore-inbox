Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267317AbUHIWXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267317AbUHIWXJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 18:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267318AbUHIWXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 18:23:09 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:36860 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267317AbUHIWUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 18:20:41 -0400
Date: Mon, 9 Aug 2004 17:19:36 -0500
From: Maneesh Soni <maneesh@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: sysfs patches in -mm create bad permissions
Message-ID: <20040809221936.GB1556@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040809214533.GA31505@smop.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809214533.GA31505@smop.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 10:45:33PM +0100, Adrian Bridgett wrote:
> Thanks to GregKH for looking at this too. 
> 
> Odd one this.  It seems like whoever looks at some files in /sys first, owns
> them.  e.g I just created a new user fred, rebooted.  Then "find /sys -user
> fred" shows loads of files.  Permissions are 644 and so the owner is
> important.
> 
> In particular, "echo -n disk > /sys/power/state" will cause the machine to
> suspend to disk (hence the security tag).
> 
> Found when I suddenly thought, "hang on, shouldn't I be root" :-)
> 
> Results so far:
> 
> 2.6.8-rc2-mm1 - bad
> 2.6.8-rc2 - okay
> 2.6.8-rc3 - okay
> 2.6.8-rc3-mm1 - bad
> 

I did see this problem like this

-bash-2.05b$ ls -l /sys/class/net/eth0/tx_queue_len
-rw-r--r--    1 maneesh  maneesh         0 Aug 10 07:54 /sys/class/net/eth0/tx_queue_len

but when I tried to write something to this file as normal user, I did see EPERM and
file contents are not changed. It could be different in the case you mentioned. I am
updating the backing store patch set and should fix this problem in the new version.

====================================================================================
-bash-2.05b$ strace echo "2000" > tx_queue_len
execve("/bin/echo", ["echo", "2000"], [/* 24 vars */]) = 0
uname({sys="Linux", node="llm05.in.ibm.com", ...}) = 0
brk(0)                                  = 0x804c000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=83810, ...}) = 0
old_mmap(NULL, 83810, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40016000
close(3)                                = 0
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360W\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1539996, ...}) = 0
old_mmap(0x42000000, 1267276, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x42000000
old_mmap(0x42130000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x130000) = 0x42130000
old_mmap(0x42133000, 9804, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x42133000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4002b000
set_thread_area({entry_number:-1 -> 6, base_addr:0x4002b4e0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0x40016000, 83810)               = 0
brk(0)                                  = 0x804c000
brk(0x804d000)                          = 0x804d000
brk(0)                                  = 0x804d000
open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=31387184, ...}) = 0
mmap2(NULL, 2097152, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4002c000
close(3)                                = 0
fstat64(1, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4022c000
write(1, "2000\n", 5)                   = -1 EPERM (Operation not permitted)
close(1)                                = 0
munmap(0x4022c000, 4096)                = 0

..
..
..
====================================================================================

The files are getting created by current->uid & current->gid and has to be 
created using the root uid, gid. 

Viro, is there any standard way of doing this, or shall I just do 
i_uid = i_gid = 0;

Maneesh


-- 
Maneesh Soni
Linux Technology Center, 
IBM Austin
email: maneesh@in.ibm.com
Phone: 1-512-838-1896 Fax: 
T/L : 6781896
