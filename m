Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbSKZXjG>; Tue, 26 Nov 2002 18:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262881AbSKZXjG>; Tue, 26 Nov 2002 18:39:06 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:11278
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S262528AbSKZXjD>; Tue, 26 Nov 2002 18:39:03 -0500
Subject: htree+NFS (NFS client bug?)
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Ext2 devel <ext2-devel@lists.sourceforge.net>,
       NFS maillist <nfs@lists.sourceforge.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1038354285.1302.144.camel@sherkaner.pao.digeo.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 26 Nov 2002 15:44:46 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having problems with exporting htree ext3 filesystems over NFS. 
Quite often, if a program on the client side is reading a directory it
will simply stop and consume a vast amount of memory.  It seems that the
readdir never terminates, and endlessly returns the same dir entries
again and again.

This seems to be happening entirely on the NFS client side; after the
initial readdir and a couple of getattrs, there's no further network
traffic.

It looks to me like some sort of problem managing the NFS readdir
cookies, but it isn't clear to me whether this is the NFS server/ext3
generating bad cookies, or the NFS client handling them wrongly.

Both the client and server machines are running 2.4.20-rc1, with Ted's
extfs-update-2.4.20-rc1 patch (dating from Nov 8th or so).  Is there a
more up to date patch?

This is the network traffic:

# tcpdump -s1500 -vvv -ieth0 host server and port 2049
tcpdump: listening on eth0
15:13:39.784538 client.3095412229 > server.nfs: 140 lookup fh Unknown/1 "coregrind-" (DF) (ttl 64, id 0, len 168)
15:13:39.784814 server.nfs > client.3095412229: reply ok 128 lookup fh Unknown/1 DIR 40775 ids 1043/1043 sz 12288 nlink 3 rdev ffffffff fsid 301 nodeid 47976 a/m/ctime 1038043539.000000 1038351994.000000 1038351994.000000  (DF) (ttl 64, id 0, len 156)
15:13:39.785247 client.3112189445 > server.nfs: 124 getattr fh Unknown/1 (DF) (ttl 64, id 0, len 152)
15:13:39.785434 server.nfs > client.3112189445: reply ok 96 getattr DIR 40775 ids 1043/1043 sz 12288  (DF) (ttl 64, id 0, len 124)
15:13:39.785938 client.3128966661 > server.nfs: 132 readdir fh Unknown/1 4096 bytes @ 0 (DF) (ttl 64, id 0, len 160)
15:13:39.786939 server.nfs > client.3128966661: reply ok 1472 readdir offset 1 size 293238  eof (frag 48814:1480@0+) (ttl 64, len 1500)
15:14:50.727869 client.3246407173 > server.nfs: 116 getattr fh 0,1/16777984 (DF) (ttl 64, id 0, len 144)
15:14:50.728127 server.nfs > client.3246407173: reply ok 96 getattr DIR 40755 ids 0/0 sz 4096  (DF) (ttl 64, id 0, len 124)

For this command:
$ strace -s1500 ls -f .
execve("/bin/ls", ["ls", "-f", "."], [/* 122 vars */]) = 0
[...]
lstat64(".", {st_mode=S_IFDIR|0775, st_size=12288, ...}) = 0
open("/dev/null", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 3
fstat64(3, {st_mode=S_IFDIR|0775, st_size=12288, ...}) = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
getdents64(3, /* 94 entries */, 4096)   = 4096
brk(0x8059000)                          = 0x8059000
getdents64(3, /* 13 entries */, 4096)   = 496
brk(0x805f000)                          = 0x805f000
getdents64(3, /* 94 entries */, 4096)   = 4096
brk(0x806b000)                          = 0x806b000
getdents64(3, /* 13 entries */, 4096)   = 496
getdents64(3, /* 94 entries */, 4096)   = 4096
getdents64(3, /* 13 entries */, 4096)   = 496
getdents64(3, /* 94 entries */, 4096)   = 4096
brk(0x8082000)                          = 0x8082000
getdents64(3, /* 13 entries */, 4096)   = 496
getdents64(3, /* 94 entries */, 4096)   = 4096
getdents64(3, /* 13 entries */, 4096)   = 496
getdents64(3, /* 94 entries */, 4096)   = 4096
getdents64(3, /* 13 entries */, 4096)   = 496
getdents64(3, /* 94 entries */, 4096)   = 4096
getdents64(3, /* 13 entries */, 4096)   = 496
getdents64(3, /* 94 entries */, 4096)   = 4096
[...]

A simple program which does an opendir/while(readdir != NULL)/closedir
loop shows this:
$ readdir .
name=".", ino=293238
name="..", ino=298200
name="vg_symtypes.h~", ino=163580
name="vg_include.h", ino=163476
name=".deps", ino=293390
name="vg_to_ucode.c~47-chained-bb", ino=293901
name="vg_from_ucode.c~47-chained-bb", ino=293896
name="vg_memory.c", ino=293462
name="vg_symtypes.c~", ino=163620
name="vg_constants.h~48-chained-indirect", ino=293925
name="valgrind", ino=293394
name="vg_needs.c", ino=293431
name="vg_from_ucode.i", ino=293860
name="vg_symtypes.h~44-symbolic-addr", ino=293651
name="vg_libpthread.c~11-timedwait-rel", ino=293628
name="vg_libpthread_unimp.c", ino=293999
name="vg_constants.h~47-chained-bb", ino=293904
name="vg_libpthread.c~03-accept-nonblock", ino=293652
name="vg_transtab.c~47-chained-bb", ino=293900
name="vg_include.h~48-chained-indirect", ino=293939
name="vg_symtypes.c~44-symbolic-addr", ino=293639
name="vg_main.c~14-hg-mmap-magic-virgin", ino=293941
name="vg_symtab2-test.c", ino=293903
name="vg_startup.S", ino=298417
name="vg_main.c~51-kill-inceip", ino=294086
name="vg_default.c", ino=293439
name="vg_translate.c~01-partial-mul", ino=293615
name="vg_dispatch.S~48-chained-indirect", ino=293856
name="vg_scheduler.c~47-chained-bb", ino=293890
name="vg_clientfuncs.c", ino=298391
name="Makefile.in", ino=298437
name="gmon.out", ino=293911
name="vg_main.c~47-chained-bb", ino=293897
name="vg_procselfmaps.c", ino=298414
name="vg_symtab2.h", ino=163541
name="vg_main.c~48-chained-indirect", ino=293946
name="vg_translate.c~51-kill-inceip", ino=294087
name="vg_symtypes.h", ino=163543
name="vg_symtab_stabs.c", ino=163530
name="dosyms", ino=298389
name="vg_constants.h", ino=163142
name="vg_demangle.c", ino=298395
name="vg_messages.c", ino=293882
name="vg_include.h~50-fast-cond", ino=294050
name="vg_to_ucode.c", ino=163552
name="Makefile~", ino=293393
name="vg_symtab2.c~44-symbolic-addr", ino=293650
name="vg_dispatch.S~47-chained-bb", ino=293878
name="vg_libpthread.c", ino=163595
name="vg_kerneliface.h", ino=163597
name="vg_from_ucode.c~48-chained-indirect", ino=293880
name="vg_from_ucode.c", ino=163451
name="vg_from_ucode.c~49-no-inceip", ino=294060
name="vg_malloc2.c", ino=163531
name="vg_instrument.c", ino=298403
name="vg_signals.c~28-sigtrap", ino=293637
name="vg_main.c.rej", ino=163538
name="vg_symtab2-test", ino=293691
name="vg_errcontext.c", ino=163586
name="vg_translate.c", ino=163539
name="vg_symtypes.c", ino=163647
name="out.pid11357", ino=293908
name="vg_execontext.c", ino=293436
name="Makefile", ino=293504
name="vg_main.c", ino=163523
name="vg_errcontext.c~47-chained-bb", ino=293898
name="vg_signals.c", ino=163536
name="vg_symtab2.c~offset-dehack", ino=293949
name="vg_from_ucode.c~01-partial-mul", ino=293605
name="Makefile.am~44-symbolic-addr", ino=293671
name="vg_main.c.orig", ino=163519
name="vg_symtab2.c", ino=163599
name="vg_kerneliface.h~28-sigtrap", ino=293638
name="vg_ldt.c", ino=298405
name="vg_from_ucode.c~00-lazy-fp", ino=293269
name="vg_transtab.c", ino=163622
name="vg_mylibc.c~12-vgprof", ino=293636
name="vg_from_ucode.c~50-fast-cond", ino=293862
name="vg_symtab2.h~44-symbolic-addr", ino=293851
name="vg_symtab_dwarf.c~44-symbolic-addr", ino=293858
name="vg_unsafe.h", ino=298424
name="vg_include.h~51-kill-inceip", ino=294052
name="vg_symtab_stabs.c~44-symbolic-addr", ino=293842
name="vg_mylibc.c", ino=163177
name="vg_dummy_profile.c", ino=298397
name="vg_main.c~50-fast-cond", ino=293956
name="vg_mylibc.c~09-rdtsc-calibration", ino=293625
name="vg_include.h~47-chained-bb", ino=293879
name="vg_translate.c~47-chained-bb", ino=293894
name="vg_libpthread.c~46-fix-writeable_or_erring-proto", ino=293863
name="vg_syscall.S", ino=298419
name="vg_from_ucode.c~51-kill-inceip", ino=294051
name="vg_mylibc.c~28-sigtrap", ino=298763
name="vg_dispatch.S", ino=163511
name="vg_symtab_dwarf.c", ino=163448
name="vg_intercept.c", ino=293614
name="vg_symtab_stabs.c~", ino=163548
name="vg_clientmalloc.c", ino=298392
name="vg_valgrinq_dummy.c", ino=298425
name="vg_scheduler.c", ino=163617
name="vg_to_ucode.c~01-partial-mul", ino=293607
name="Makefile.am", ino=163594
name="vg_helpers.S", ino=298401
name="out.pid11334", ino=293907
name="vg_syscalls.c", ino=293575
name="valgrind.in", ino=298390
name="vg_libpthread.vs", ino=298407
name=".", ino=293238
name="..", ino=298200
name="vg_symtypes.h~", ino=163580
name="vg_include.h", ino=163476
name=".deps", ino=293390
name="vg_to_ucode.c~47-chained-bb", ino=293901
name="vg_from_ucode.c~47-chained-bb", ino=293896
name="vg_memory.c", ino=293462
name="vg_symtypes.c~", ino=163620
name="vg_constants.h~48-chained-indirect", ino=293925
name="valgrind", ino=293394
name="vg_needs.c", ino=293431
name="vg_from_ucode.i", ino=293860
name="vg_symtypes.h~44-symbolic-addr", ino=293651
name="vg_libpthread.c~11-timedwait-rel", ino=293628
name="vg_libpthread_unimp.c", ino=293999
name="vg_constants.h~47-chained-bb", ino=293904
name="vg_libpthread.c~03-accept-nonblock", ino=293652
name="vg_transtab.c~47-chained-bb", ino=293900
name="vg_include.h~48-chained-indirect", ino=293939
name="vg_symtypes.c~44-symbolic-addr", ino=293639
name="vg_main.c~14-hg-mmap-magic-virgin", ino=293941
name="vg_symtab2-test.c", ino=293903
name="vg_startup.S", ino=298417
name="vg_main.c~51-kill-inceip", ino=294086
name="vg_default.c", ino=293439
name="vg_translate.c~01-partial-mul", ino=293615
name="vg_dispatch.S~48-chained-indirect", ino=293856
name="vg_scheduler.c~47-chained-bb", ino=293890
name="vg_clientfuncs.c", ino=298391
name="Makefile.in", ino=298437
name="gmon.out", ino=293911
name="vg_main.c~47-chained-bb", ino=293897
name="vg_procselfmaps.c", ino=298414
name="vg_symtab2.h", ino=163541
name="vg_main.c~48-chained-indirect", ino=293946
name="vg_translate.c~51-kill-inceip", ino=294087
name="vg_symtypes.h", ino=163543
name="vg_symtab_stabs.c", ino=163530
name="dosyms", ino=298389
name="vg_constants.h", ino=163142
name="vg_demangle.c", ino=298395
name="vg_messages.c", ino=293882
name="vg_include.h~50-fast-cond", ino=294050
name="vg_to_ucode.c", ino=163552
name="Makefile~", ino=293393
name="vg_symtab2.c~44-symbolic-addr", ino=293650
name="vg_dispatch.S~47-chained-bb", ino=293878
name="vg_libpthread.c", ino=163595
name="vg_kerneliface.h", ino=163597
name="vg_from_ucode.c~48-chained-indirect", ino=293880
name="vg_from_ucode.c", ino=163451
name="vg_from_ucode.c~49-no-inceip", ino=294060
name="vg_malloc2.c", ino=163531
name="vg_instrument.c", ino=298403
name="vg_signals.c~28-sigtrap", ino=293637
name="vg_main.c.rej", ino=163538
name="vg_symtab2-test", ino=293691
name="vg_errcontext.c", ino=163586
name="vg_translate.c", ino=163539
name="vg_symtypes.c", ino=163647
name="out.pid11357", ino=293908
name="vg_execontext.c", ino=293436
name="Makefile", ino=293504
name="vg_main.c", ino=163523
name="vg_errcontext.c~47-chained-bb", ino=293898
name="vg_signals.c", ino=163536
name="vg_symtab2.c~offset-dehack", ino=293949
name="vg_from_ucode.c~01-partial-mul", ino=293605
name="Makefile.am~44-symbolic-addr", ino=293671
name="vg_main.c.orig", ino=163519
name="vg_symtab2.c", ino=163599
name="vg_kerneliface.h~28-sigtrap", ino=293638
name="vg_ldt.c", ino=298405
name="vg_from_ucode.c~00-lazy-fp", ino=293269
name="vg_transtab.c", ino=163622
name="vg_mylibc.c~12-vgprof", ino=293636
name="vg_from_ucode.c~50-fast-cond", ino=293862
name="vg_symtab2.h~44-symbolic-addr", ino=293851
name="vg_symtab_dwarf.c~44-symbolic-addr", ino=293858
name="vg_unsafe.h", ino=298424
name="vg_include.h~51-kill-inceip", ino=294052
name="vg_symtab_stabs.c~44-symbolic-addr", ino=293842
name="vg_mylibc.c", ino=163177
name="vg_dummy_profile.c", ino=298397
name="vg_main.c~50-fast-cond", ino=293956
name="vg_mylibc.c~09-rdtsc-calibration", ino=293625
name="vg_include.h~47-chained-bb", ino=293879
name="vg_translate.c~47-chained-bb", ino=293894
name="vg_libpthread.c~46-fix-writeable_or_erring-proto", ino=293863
name="vg_syscall.S", ino=298419
name="vg_from_ucode.c~51-kill-inceip", ino=294051
name="vg_mylibc.c~28-sigtrap", ino=298763
[...etc...]


	J

