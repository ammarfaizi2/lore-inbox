Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265332AbTL0GOP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 01:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265334AbTL0GOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 01:14:14 -0500
Received: from user-119ahgg.biz.mindspring.com ([66.149.70.16]:36277 "EHLO
	mail.home") by vger.kernel.org with ESMTP id S265332AbTL0GOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 01:14:10 -0500
From: Eric <eric@cisu.net>
To: linux-kernel@vger.kernel.org
Subject: Bash superuser segfault and 2.6.0
Date: Sat, 27 Dec 2003 00:13:31 -0600
User-Agent: KMail/1.5.94
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200312270013.31592.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	I am posting this to lkml because this happened only after upgrading to 
2.6.0-mm1 I get strange segfaults when I am in a superuser shell whenther 
logged in through konsole, or mingetty.
	Heres what I do:
	bot403@Eric:~>su (type password)
	Eric:/home/bot403 #cd (tab) (tab)
	Segmentation Fault
	
	This is reproducible every time. However, I su to superuser, then type bash 
and get a second child shell, and I cannot reproduce a SIGSEGV very easily. 
( I believe I still can however). If i type cd(tab(tab) it doesnt crash. (as 
oppsed to cd_(tab)(tab) with a space after cd). Note: I must be UID 0 to trip 
the segfault....or its very hard to trip NOT as UID 0.
	Here is a strange output, im not sure how I got this...but I was in the 
process of trying to attach gdb to the running bash shell to give you guys 
more info in this email, It segfaulted and printed this. Sorry if I appear 
dumb, but I have no idea what spat this out or how to reproduce this.
	malloc: unknown:0: assertion botched
	realloc: called with unallocated block argument
	last command: ps $$
	Stopping myself...Aborted
Further testing reveals that my statically compiled bash binary only does this 
however the shared one that came with SuSE 8.2 doesnt..... I believe this 
might be a C library bug.... what do you guys think? I recompiled with -g and 
heres a backtrace of the sefault on my static binary. The strange thing was 
that I had no problem up until 2.6.0-mm1. Maybe a change tripped a 
compiler/library bug? Any ideas if this is kernel related or should I try the 
gnu buglists? If you have any ideas....lemme know what I need to do to debug 
this. I'd love to help.

#0  internal_malloc (n=4, file=0x8137260 "stringlist.c", line=134, flags=1)
    at malloc.c:730
#1  0x080c70a9 in sh_malloc (bytes=4, file=0x8137260 "stringlist.c", line=134)
    at malloc.c:1120
#2  0x08093848 in sh_xmalloc (bytes=4, file=0x8137260 "stringlist.c", 
line=134)
    at xmalloc.c:143
#3  0x080a515c in strlist_copy (sl=0x81a3e48) at stringlist.c:134
#4  0x08092abf in gen_action_completions (cs=0x10,
    text=0x8225018 <Address 0x8225018 out of bounds>) at pcomplete.c:757
#5  0x080907d7 in gen_compspec_completions (cs=0x818e7c8,
    cmd=0x8225008 <Address 0x8225008 out of bounds>,
    word=0x8225018 <Address 0x8225018 out of bounds>, start=0, end=3) at 
pcomplete.c:1140
#6  0x08091450 in programmable_completions (
    cmd=0x8225008 <Address 0x8225008 out of bounds>,
    word=0x8225018 <Address 0x8225018 out of bounds>, start=0, end=3, 
foundp=0xbfffe2b8)
    at pcomplete.c:1334
#7  0x08088b00 in attempt_shell_completion (
    text=0x8225018 <Address 0x8225018 out of bounds>, start=3, end=3) at 
bashline.c:988
#8  0x080ac00c in gen_completion_matches (
    text=0x8225018 <Address 0x8225018 out of bounds>, start=3, end=3,
    our_func=0x80ad420 <rl_filename_completion_function>, found_quote=0, 
quote_char=0)
    at complete.c:794
#9  0x080acfcf in rl_complete_internal (what_to_do=63) at complete.c:1486
#10 0x080a7aea in _rl_dispatch_subseq (key=9, map=0x8153c60, got_subseq=0)
    at readline.c:580
#11 0x080a78f5 in _rl_dispatch (key=9, map=0x8153c60) at readline.c:529
---Type <return> to continue, or q <return> to quit---
#12 0x080a76a5 in readline_internal_char () at readline.c:443
#13 0x080a7865 in readline_internal_charloop () at readline.c:489
#14 0x080a7890 in readline_internal () at readline.c:503
#15 0x080a73e7 in readline (prompt=0x8163e88 "Eric:/home/bot403 # ") at 
readline.c:299
#16 0x0805102c in yy_readline_get () 
at /usr/homes/chet/src/bash/src/parse.y:1108
#17 0x08051d5a in shell_getc (remove_quoted_newline=1)
    at /usr/homes/chet/src/bash/src/parse.y:1042
#18 0x0804c941 in read_token (command=135675528)
    at /usr/homes/chet/src/bash/src/parse.y:2414
#19 0x0804f2a5 in yyparse () at /usr/homes/chet/src/bash/src/parse.y:2084
#20 0x0804a9bb in read_command () at eval.c:217
#21 0x0804abab in reader_loop () at eval.c:128
#22 0x08049870 in main (argc=2, argv=0xbffff214, env=0xbffff220) at 
shell.c:680
#23 0x080c7b28 in __libc_start_main (main=0x8048640 <main>, argc=2, 
ubp_av=0xbffff214,
    init=0x80c7c90 <__libc_csu_init>, fini=0x80c7cf0 <__libc_csu_fini>, 
rtld_fini=0,
    stack_end=0x8163e88) at ../sysdeps/generic/libc-start.c:152

#gcc -v 
Reading specs from /usr/lib/gcc-lib/i486-suse-linux/3.3/specs
Configured with: ../configure --enable-threads=posix --prefix=/usr 
--with-local-prefix=/usr/local --infodir=/usr/share/info 
--mandir=/usr/share/man --libdir=/usr/lib 
--enable-languages=c,c++,f77,objc,java,ada --disable-checking --enable-libgcj 
--with-gxx-include-dir=/usr/include/g++ --with-slibdir=/lib 
--with-system-zlib --enable-shared --enable-__cxa_atexit i486-suse-linux
Thread model: posix
gcc version 3.3 20030226 (prerelease) (SuSE Linux)
#uname -a
Linux Eric 2.6.0-mm1 #2 SMP Fri Dec 26 18:54:13 CST 2003 i686 unknown unknown 
GNU/Linux

# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) MP 2000+
stepping        : 1
cpu MHz         : 1667.572
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3268.60

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) MP
stepping        : 1
cpu MHz         : 1667.572
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3325.95

-------------------------
Eric Bambach
Eric at cisu dot net
-------------------------
