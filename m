Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbWIQUj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbWIQUj1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 16:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbWIQUj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 16:39:26 -0400
Received: from tresys.irides.com ([216.250.243.126]:28802 "HELO
	exchange.columbia.tresys.com") by vger.kernel.org with SMTP
	id S965061AbWIQUjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 16:39:25 -0400
Message-ID: <450DB274.1010404@gentoo.org>
Date: Sun, 17 Sep 2006 16:39:16 -0400
From: Joshua Brindle <method@gentoo.org>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Madore <david.madore@ens.fr>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 3/4] security: capabilities patch (version 0.4.4), part
 3/4: introduce new capabilities
References: <20060910133759.GA12086@clipper.ens.fr> <20060910134257.GC12086@clipper.ens.fr> <1157905393.23085.5.camel@localhost.localdomain> <450451DB.5040104@gentoo.org> <20060917181422.GC2225@elf.ucw.cz>
In-Reply-To: <20060917181422.GC2225@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: avast! (VPS 0637-2, 09/15/2006), Outbound message
X-Antivirus-Status: Clean
X-OriginalArrivalTime: 17 Sep 2006 20:39:25.0061 (UTC) FILETIME=[5CEE4B50:01C6DA99]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
>
>   
>>>> Introduce six new "regular" (=on-by-default) capabilities:
>>>>
>>>> * CAP_REG_FORK, CAP_REG_OPEN, CAP_REG_EXEC allow access to the
>>>>   fork(), open() and exec() syscalls,
>>>>    
>>>>         
>>> CAP_REG_EXEC seems meaningless, I can do the same with mmap by hand for
>>> most types of binary execution except setuid (which is separate it
>>> seems)
>>>
>>> Given the capability model is accepted as inferior to things like
>>> SELinux policies why do we actually want to fix this anyway. It's
>>> unfortunate we can't discard the existing capabilities model (which has
>>> flaws) as well really.
>>>       
>
>   
>> To expand on this a little, some of the capabilities you are looking to 
>> add are of very little if any use without being able to specify objects. 
>> For example, CAP_REG_OPEN is whether the process can open any file 
>> instead of specific ones. How many applications open no files whatsoever 
>> in practice? 
>>     
>
> Filters, for example. gzip -9 - and such stuff does not need to open
> any files. These should be easy to lock down, and still very useful.
>
> More applications could be made lock-down-aware, and for example ask
> master daemon to open files for them over a (already opened) socket.
>
>   
Unlikely.. As Jan pointed out in the last thread anything that links 
against glibc does a dozen opens on invocation:
[jbrindle@twoface ~]$ strace -eopen gzip -9 -   
open("/usr/lib64/fglrx/tls/x86_64/libc.so.6", O_RDONLY) = -1 ENOENT (No 
such file or directory)
open("/usr/lib64/fglrx/tls/libc.so.6", O_RDONLY) = -1 ENOENT (No such 
file or directory)
open("/usr/lib64/fglrx/x86_64/libc.so.6", O_RDONLY) = -1 ENOENT (No such 
file or directory)
open("/usr/lib64/fglrx/libc.so.6", O_RDONLY) = -1 ENOENT (No such file 
or directory)
open("/usr/lib/fglrx/tls/x86_64/libc.so.6", O_RDONLY) = -1 ENOENT (No 
such file or directory)
open("/usr/lib/fglrx/tls/libc.so.6", O_RDONLY) = -1 ENOENT (No such file 
or directory)
open("/usr/lib/fglrx/x86_64/libc.so.6", O_RDONLY) = -1 ENOENT (No such 
file or directory)
open("/usr/lib/fglrx/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or 
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
open("/lib64/libc.so.6", O_RDONLY)      = 3
gzip: compressed data not written to a terminal. Use -f to force 
compression.
For help, type: gzip -h
Process 17519 detached

this wouldn't be able to run if it couldn't open libc.so so you'd be 
limited to static binaries (with statically linked libs that don't do 
any open() calls) that don't do any kind of name resolution (ip, uid), 
have no config files, etc. very limited.. and my other point was that 
even if you did have said binary (the limitations make this very 
unlikely though) the binary could never be changed to open a file since 
it would then get all open access since capabilities are not fine grained.

The benefits of this are so minuscule and the cost is so high if you are 
ever to use it that it simply won't happen..

Joshua Brindle
