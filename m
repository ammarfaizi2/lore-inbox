Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135268AbRDVTop>; Sun, 22 Apr 2001 15:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136277AbRDVTog>; Sun, 22 Apr 2001 15:44:36 -0400
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:43282 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S135268AbRDVToZ>; Sun, 22 Apr 2001 15:44:25 -0400
X-Face: 6=pZ4hVbjN:C?j1$h/-bi4:F%*~B#Rxb$[0%!{5NK"dE:_QRAM]Dzl=$yMu%Rh4xCSm/#>!
 $n%@SHJ](K<taDos\M;zw#b7gIc01F@'f{.guD~];wV{#\SX0YlGR6fREpYY>FJKL,uF\=G=bRJQC$
 ?+Dlxu*pj.Z,-GK<~y7sd/l*PN\]>}<oCe5vw:p#\Gsv#E(:`3Jl2*()0,/H
To: linux-kernel@vger.kernel.org
Cc: linux@irb.cs.uni-dortmund.de, linuxadm@amaunet.cs.uni-dortmund.de
Subject: 2.2.19: inconsistency between sys_utime and sys_utimes
From: Kai.Grossjohann@CS.Uni-Dortmund.DE (Kai =?iso-8859-1?q?Gro=DFjohann?=)
Date: 22 Apr 2001 21:44:21 +0200
Message-ID: <vafwv8c1zze.fsf@lucy.cs.uni-dortmund.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.103
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In fs/open.c I see the following code in sys_utime in case the struct
utimbuf * is NULL:

		if (current->fsuid != inode->i_uid &&
		    (error = permission(inode,MAY_WRITE)) != 0)
			goto dput_and_out;

In sys_utimes, there is a similar piece of code in case the struct
timeval * is NULL:

		if ((error = permission(inode,MAY_WRITE)) != 0)
			goto dput_and_out;

Is this intentional?

I'm very much a newbie with respect to the kernel internals, but I
observe the following behavior: calling `touch' on my own file on an
NFS mounted directory works nicely.  However, if I don't own the file,
only have write permissions to it and the containing directory due to
being in the right group and the file (and directory) having g+w
permissions, then I see this:

/----
| grossjoh@lucy> strace touch xxirql.bbl
| execve("/usr/bin/touch", ["touch", "xxirql.bbl"], [/* 86 vars */]) = 0
| brk(0)                                  = 0x804e5c8
| open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
| open("/usr/sw/pilot/null.0/lib/i686/mmx/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
| stat("/usr/sw/pilot/null.0/lib/i686/mmx", 0xbfffe6e4) = -1 ENOENT (No such file or directory)
| open("/usr/sw/pilot/null.0/lib/i686/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
| stat("/usr/sw/pilot/null.0/lib/i686", 0xbfffe6e4) = -1 ENOENT (No such file or directory)
| open("/usr/sw/pilot/null.0/lib/mmx/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
| stat("/usr/sw/pilot/null.0/lib/mmx", 0xbfffe6e4) = -1 ENOENT (No such file or directory)
| open("/usr/sw/pilot/null.0/lib/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
| stat("/usr/sw/pilot/null.0/lib", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
| open("i686/mmx/libc.so.6", O_RDONLY)    = -1 ENOENT (No such file or directory)
| open("i686/libc.so.6", O_RDONLY)        = -1 ENOENT (No such file or directory)
| open("mmx/libc.so.6", O_RDONLY)         = -1 ENOENT (No such file or directory)
| open("libc.so.6", O_RDONLY)             = -1 ENOENT (No such file or directory)
| open("/etc/ld.so.cache", O_RDONLY)      = 3
| fstat(3, {st_mode=S_IFREG|0644, st_size=24988, ...}) = 0
| old_mmap(NULL, 24988, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000
| close(3)                                = 0
| open("/lib/libc.so.6", O_RDONLY)        = 3
| fstat(3, {st_mode=S_IFREG|0755, st_size=887712, ...}) = 0
| read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\244\213"..., 4096) = 4096
| old_mmap(NULL, 902044, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4001b000
| mprotect(0x400f0000, 29596, PROT_NONE)  = 0
| old_mmap(0x400f0000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xd4000) = 0x400f0000
| old_mmap(0x400f4000, 13212, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x400f4000
| close(3)                                = 0
| old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x400f8000
| munmap(0x40014000, 24988)               = 0
| getpid()                                = 25522
| brk(0)                                  = 0x804e5c8
| brk(0x804e600)                          = 0x804e600
| brk(0x804f000)                          = 0x804f000
| open("xxirql.bbl", O_WRONLY|O_CREAT|0x8000, 0666) = 3
| close(3)                                = 0
| utime("xxirql.bbl", NULL)               = -1 EPERM (Operation not permitted)
| write(2, "touch: ", 7touch: )                  = 7
| write(2, "xxirql.bbl", 10xxirql.bbl)              = 10
| write(2, ": Operation not permitted", 25: Operation not permitted) = 25
| write(2, "\n", 1
| )                       = 1
| _exit(1)                                = ?
\----

Note how utime tells me the operation is not permitted, yet:

/----
| grossjoh@lucy> ls -ld . xxirql.bbl
| drwxrws---    4 fuhr     crew         1024 Apr 20 19:08 .
| -rw-rw----    1 fuhr     crew         5081 Mar 30 16:42 xxirql.bbl
| grossjoh@lucy> groups
| crew dialout floppy medoc cyclades mind teaching exam secware system software cvs_rcp ncstrl bibdb research wwwadm carmen daffodil
\----

... I can write to the file because I'm in the right group.

This behavior seems counter-intuitive.

Thanks,
kai
-- 
The passive voice should never be used.
