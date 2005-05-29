Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVE2Uwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVE2Uwz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 16:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVE2Uwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 16:52:55 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:14758 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261436AbVE2UwN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 16:52:13 -0400
Subject: Re: [PROBLEM] Machine Freezes while Running Crossover Office
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pekka Enberg <penberg@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0505291143350.10545@ppc970.osdl.org>
References: <1117291619.9665.6.camel@localhost>
	 <Pine.LNX.4.58.0505291059540.10545@ppc970.osdl.org>
	 <84144f0205052911202863ecd5@mail.gmail.com>
	 <Pine.LNX.4.58.0505291143350.10545@ppc970.osdl.org>
Date: Sun, 29 May 2005 23:49:24 +0300
Message-Id: <1117399764.9619.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sun, 2005-05-29 at 11:49 -0700, Linus Torvalds wrote:
> I suspect that the _real_ change is that the pipe can now fill up with
> sixteen times more data (ie 64kB of data in one read() or write()  
> operation rather than 4kB), and that as a result Crossover may be doing a
> lot bigger requests to the X server too.
> 
> Alternatively, it's possible that Crossover has taken mouse focus (does 
> the mouse move around while the machine is "frozen"?) and Crossover itself 
> is confused by the bigger buffers and pauses due to some bug while it is 
> holding on to the mouse focus - making the system unusable. It's probably 
> some race that triggers this (getting data at the right speed), and 
> tracing it just changes timing enough that you won't see it.
> 
> (Btw, if you didn't already, I'd suggest forcing strace output to a file,
> not the screen, since that at least changes timings and X interactions
> _less_)
> 
> The pipe_poll() thing was possibly true even before - if the two main
> processes are communicating over a pipe, it's quite possible that
> pipe_poll() ends up being the most common op by far. See if the poll 
> timeout changes (or is zero).

The mouse cursor does not move and the screen does not refresh. The
machine locks up completely for few seconds (actually more like 5-10 s)
and then the system comes back up (after which it can be used normally).
I cannot even switch virtual consoles. Please note that I can
immediately reproduce the problem again as many times as I want by doing
the test scenario.

Forcing strace to output to a file does not change anything. I still
cannot reproduce the problem. I've included lsof output, oprofile, and
snippet of strace for a run where I am doing the same test scenario but
failing to reproduce the bug. The real strace is quite large (4 MBs for
five to ten seconds of running application) but the bits I have included
here seem to repeat itself. I am tracing the process that actually runs
WINWORD.EXE.

Is it possible that your changes for pipes to fill up to 64 KB confuses
pipe_poll and friends? The funny thing is that when I am stracing (and
thus not hitting the problem), I do not see _any_ calls to sys_poll but
when I _do_ hit the bug, pipe_poll clearly shows up in oprofile. Also,
don't ptrace calls use signals? I can see plenty of paths in the pipe
code doing signal_pending() and exiting when the condition is true.

			Pekka

COMMAND    PID    USER   FD   TYPE     DEVICE    SIZE    NODE NAME
wine-prel 9368 penberg  cwd    DIR        3,3    4096  311341 /home/penberg
wine-prel 9368 penberg  rtd    DIR        3,3    4096       2 /
wine-prel 9368 penberg  txt    REG        3,3    9076 1881956 /opt/cxoffice/bin/wine-preloader
wine-prel 9368 penberg  mem    REG        3,3         1867306 /home/penberg/.cxoffice/dotwine/fake_windows/Program (stat: No such file or directory)
wine-prel 9368 penberg  mem    REG        3,3 2779548  366172 /home/penberg/.cxoffice/dotwine/fake_windows/Windows/System/msi.dll
wine-prel 9368 penberg  mem    REG        3,3         1086080 /home/penberg/.cxoffice/dotwine/fake_windows/Program (stat: No such file or directory)
wine-prel 9368 penberg  mem    REG        3,3         1086064 /home/penberg/.cxoffice/dotwine/fake_windows/Program (stat: No such file or directory)
wine-prel 9368 penberg  mem    REG        3,3  421888 1772930 /home/penberg/.cxoffice/dotwine/fake_windows/Windows/System/RICHED20.DLL
wine-prel 9368 penberg  mem    REG        3,3         1866707 /home/penberg/.cxoffice/dotwine/fake_windows/Program (stat: No such file or directory)
wine-prel 9368 penberg  mem    REG        3,3         1866785 /home/penberg/.cxoffice/dotwine/fake_windows/Program (stat: No such file or directory)
wine-prel 9368 penberg  mem    REG        3,3   18192  366453 /home/penberg/.cxoffice/dotwine/fake_windows/Windows/System/sage.dll
wine-prel 9368 penberg  mem    REG        3,3  614672  366194 /home/penberg/.cxoffice/dotwine/fake_windows/Windows/System/OLEAUT32.DLL
wine-prel 9368 penberg  mem    REG        3,3  775952  366234 /home/penberg/.cxoffice/dotwine/fake_windows/Windows/System/ole32.dll
wine-prel 9368 penberg  DEL    REG        3,3         3093908 /tmp/.wine-1000/server-5962d/anonmap.ZEpqO4
wine-prel 9368 penberg  mem    REG        3,3  321296  366240 /home/penberg/.cxoffice/dotwine/fake_windows/Windows/System/rpcrt4.dll
wine-prel 9368 penberg  mem    REG        3,3  391168  364896 /home/penberg/.cxoffice/dotwine/fake_windows/Windows/System/SHLWAPI.DLL
wine-prel 9368 penberg  mem    REG        3,3  456388 1898134 /opt/cxoffice/lib/wine/ntdll.dll.so
wine-prel 9368 penberg  mem    REG        3,3    6472 1881957 /opt/cxoffice/bin/wine-pthread
wine-prel 9368 penberg  mem    REG        0,0               0 [heap] (stat: No such file or directory)
wine-prel 9368 penberg  mem    REG        3,3  257636 1086001 /home/penberg/.cxoffice/dotwine/fake_windows/Windows/Fonts/Tahoma.TTF
wine-prel 9368 penberg  mem    REG        3,3  333900 2852689 /usr/share/fonts/corefonts/timesbd.ttf
wine-prel 9368 penberg  mem    REG        3,3  142312 1898158 /opt/cxoffice/lib/wine/msacm32.dll.so
wine-prel 9368 penberg  mem    REG        3,3  249028 1898044 /opt/cxoffice/lib/wine/wineoss.drv.so
wine-prel 9368 penberg  mem    REG        3,3  468580 1898059 /opt/cxoffice/lib/wine/winmm.dll.so
wine-prel 9368 penberg  mem    REG        3,3  105944 1898076 /opt/cxoffice/lib/wine/version.dll.so
wine-prel 9368 penberg  mem    REG        3,3    6528 1079723 /home/penberg/.cxoffice/dotwine/fake_windows/Windows/Fonts/wine_vgasys.fon
wine-prel 9368 penberg  mem    REG        3,3  286620 2208495 /usr/share/fonts/corefonts/arialbd.ttf
wine-prel 9368 penberg  mem    REG        3,3  305220 1898064 /opt/cxoffice/lib/wine/winedos.dll.so
wine-prel 9368 penberg  mem    REG        3,3  275572 2208494 /usr/share/fonts/corefonts/arial.ttf
wine-prel 9368 penberg  mem    REG        3,3  302688 2208501 /usr/share/fonts/corefonts/cour.ttf
wine-prel 9368 penberg  mem    REG        3,3   63684 1085990 /home/penberg/.cxoffice/dotwine/fake_windows/Windows/Fonts/VeraIt.ttf
wine-prel 9368 penberg  DEL    REG        3,3         3093919 /tmp/.wine-1000/server-5962d/anonmap.5J7DDs
wine-prel 9368 penberg  mem    REG        3,3   98272 1898049 /opt/cxoffice/lib/wine/msacm.drv.so
wine-prel 9368 penberg  mem    REG        3,3  252384 1086000 /home/penberg/.cxoffice/dotwine/fake_windows/Windows/Fonts/TahomaBD.TTF
wine-prel 9368 penberg  DEL    REG        3,3         3093917 /tmp/.wine-1000/server-5962d/anonmap.O8NFES
wine-prel 9368 penberg  DEL    REG        3,3         3093915 /tmp/.wine-1000/server-5962d/anonmap.rddWfB
wine-prel 9368 penberg  mem    REG        3,3   85416 1898050 /opt/cxoffice/lib/wine/midimap.drv.so
wine-prel 9368 penberg  mem    REG        3,3   93156 1898165 /opt/cxoffice/lib/wine/lz32.dll.so
wine-prel 9368 penberg  DEL    REG        3,3         3093918 /tmp/.wine-1000/server-5962d/anonmap.CWi6XR
wine-prel 9368 penberg  mem    REG        3,3   20112 1081110 /home/penberg/.cxoffice/dotwine/fake_windows/Windows/Fonts/wine_sserife.fon
wine-prel 9368 penberg  mem    REG        3,3  330412 2852688 /usr/share/fonts/corefonts/times.ttf
wine-prel 9368 penberg  DEL    REG        3,3         3093916 /tmp/.wine-1000/server-5962d/anonmap.tvXNbP
wine-prel 9368 penberg  DEL    REG        3,3         3093913 /tmp/.wine-1000/server-5962d/anonmap.6SK7BF
wine-prel 9368 penberg  DEL    REG        3,3         3093911 /tmp/.wine-1000/server-5962d/anonmap.0kzLDZ
wine-prel 9368 penberg  mem    REG        3,3         1086139 /home/penberg/.cxoffice/dotwine/fake_windows/Program (stat: No such file or directory)
wine-prel 9368 penberg  DEL    REG        3,3         3093909 /tmp/.wine-1000/server-5962d/anonmap.UpYvef
wine-prel 9368 penberg  mem    REG        3,3         1086147 /home/penberg/.cxoffice/dotwine/fake_windows/Program (stat: No such file or directory)
wine-prel 9368 penberg  mem    REG        3,3 1075024  932291 /usr/lib/libcrypto.so.0.9.7
wine-prel 9368 penberg  mem    REG        3,3  197760  967730 /usr/lib/libssl.so.0.9.7
wine-prel 9368 penberg  mem    REG        3,3  467516 1898062 /opt/cxoffice/lib/wine/wineps.dll.so
wine-prel 9368 penberg  DEL    REG        0,7          983066 /SYSV00000000
wine-prel 9368 penberg  DEL    REG        0,7          950300 /SYSV00000000
wine-prel 9368 penberg  mem    REG        3,3  114100 1407967 /usr/lib/libcups.so.2
wine-prel 9368 penberg  DEL    REG        3,3         3093914 /tmp/.wine-1000/server-5962d/anonmap.ifO9K1
wine-prel 9368 penberg  mem    REG        3,3  122084 1898176 /opt/cxoffice/lib/wine/imm32.dll.so
wine-prel 9368 penberg  mem    REG        3,3  142134 1948180 /usr/lib/X11/locale/lib/common/ximcp.so.2
wine-prel 9368 penberg  mem    REG        3,3  543927 2110396 /usr/lib/opengl/xorg-x11/lib/libGL.so.1.2
wine-prel 9368 penberg  mem    REG        3,3  937728 1833443 /usr/lib/libX11.so.6.2
wine-prel 9368 penberg  mem    REG        3,3  494724 1898026 /opt/cxoffice/lib/wine/x11drv.dll.so
wine-prel 9368 penberg  mem    REG        3,3  130732 1145690 /usr/lib/libexpat.so.0.5.0
wine-prel 9368 penberg  mem    REG        3,3  552344 1015017 /usr/lib/libfreetype.so.6.3.7
wine-prel 9368 penberg  mem    REG        3,3  152672 1804882 /usr/lib/libfontconfig.so.1.0.4
wine-prel 9368 penberg  mem    REG        3,3   98982 1833580 /usr/lib/libICE.so.6.3
wine-prel 9368 penberg  mem    REG        3,3   65928 2192834 /lib/libz.so.1.2.2
wine-prel 9368 penberg  mem    REG        3,3   37056 1249025 /usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.4/libgcc_s.so.1
wine-prel 9368 penberg  mem    REG        3,3    9780 3402055 /usr/lib/gconv/ISO8859-15.so
wine-prel 9368 penberg  mem    REG        3,3  445516 1898034 /opt/cxoffice/lib/libcxfreetype.so.6.3.7
wine-prel 9368 penberg  mem    REG        3,3  143932 1898039 /opt/cxoffice/lib/wine/winspool.drv.so
wine-prel 9368 penberg  mem    REG        3,3  633124 1898218 /opt/cxoffice/lib/wine/comctl32.dll.so
wine-prel 9368 penberg  mem    REG        3,3  266293  366272 /home/penberg/.cxoffice/dotwine/fake_windows/Windows/System/MSVCRT.DLL
wine-prel 9368 penberg  mem    REG        3,3  575428 1898099 /opt/cxoffice/lib/wine/shell32.dll.so
wine-prel 9368 penberg  mem    REG        3,3  911140 1898086 /opt/cxoffice/lib/wine/user32.dll.so
wine-prel 9368 penberg  mem    REG        3,3  451236 1898186 /opt/cxoffice/lib/wine/gdi32.dll.so
wine-prel 9368 penberg  mem    REG        3,3  201604 1898231 /opt/cxoffice/lib/wine/advapi32.dll.so
wine-prel 9368 penberg  mem    REG        3,3   21544  278085 /usr/lib/gconv/gconv-modules.cache
wine-prel 9368 penberg  mem    REG        3,3   35170 1833584 /usr/lib/libXrender.so.1.2.2
wine-prel 9368 penberg  mem    REG        3,3   41579 1833612 /usr/lib/libXcursor.so.1.0.2
wine-prel 9368 penberg  mem    REG        3,3  178728 2882009 /usr/lib/locale/fi_FI@euro/LC_CTYPE
wine-prel 9368 penberg  mem    REG        3,3 1073956 1898173 /opt/cxoffice/lib/wine/kernel32.dll.so
wine-prel 9368 penberg  mem    REG        3,3   19005 1833471 /usr/lib/libXxf86vm.so.1.0
wine-prel 9368 penberg  mem    REG        3,3   35136 3304756 /lib/libnss_compat-2.3.5.so
wine-prel 9368 penberg  mem    REG        3,3   65868 1833600 /usr/lib/libXext.so.6.4
wine-prel 9368 penberg  mem    REG        3,3   37964 1833530 /usr/lib/libSM.so.6.0
wine-prel 9368 penberg  mem    REG        3,3  165848 2665726 /lib/tls/libm-2.3.5.so
wine-prel 9368 penberg  mem    REG        3,3   12586 1948177 /usr/lib/X11/locale/lib/common/xlcDef.so.2
wine-prel 9368 penberg  mem    REG        3,3   84024 3304441 /lib/libnsl-2.3.5.so
wine-prel 9368 penberg  mem    REG        3,3  994768 1897964 /opt/cxoffice/lib/libwine_unicode.so.1
wine-prel 9368 penberg  DEL    REG        3,3         3093907 /tmp/.wine-1000/server-5962d/anonmap.873qK8
wine-prel 9368 penberg  mem    REG        3,3   47760 3304426 /lib/libnss_files-2.3.5.so
wine-prel 9368 penberg  mem    REG        3,3   10672 3304415 /lib/libdl-2.3.5.so
wine-prel 9368 penberg  mem    REG        3,3 1302712 2668469 /lib/tls/libc-2.3.5.so
wine-prel 9368 penberg  mem    REG        3,3  166679 2569324 /lib/tls/libpthread-2.3.5.so
wine-prel 9368 penberg  mem    REG        3,3   39772 3304442 /lib/libnss_nis-2.3.5.so
wine-prel 9368 penberg  mem    REG        3,3   22556 1897963 /opt/cxoffice/lib/libwine.so.1
wine-prel 9368 penberg  mem    REG        3,3   94932 3304229 /lib/ld-2.3.5.so
wine-prel 9368 penberg    0u   CHR      136,0               2 /dev/pts/0
wine-prel 9368 penberg    1u   CHR      136,0               2 /dev/pts/0
wine-prel 9368 penberg    2u   CHR      136,0               2 /dev/pts/0
wine-prel 9368 penberg    3u  unix 0xd16a2980           16826 socket
wine-prel 9368 penberg    4w  FIFO        0,5           16828 pipe
wine-prel 9368 penberg    5r  FIFO        0,5           16829 pipe
wine-prel 9368 penberg    6u   REG        3,3    1024 3093919 /tmp/.wine-1000/server-5962d/anonmap.5J7DDs (deleted)
wine-prel 9368 penberg    7r  FIFO        0,5           16830 pipe
wine-prel 9368 penberg    8w  FIFO        0,5           16830 pipe
wine-prel 9368 penberg    9u  unix 0xd16a2380           16838 socket
wine-prel 9368 penberg   10u  unix 0xcbd7ee00           16840 socket
wine-prel 9368 penberg   11u   CHR      136,0               2 /dev/pts/0
wine-prel 9368 penberg   12u   CHR      136,0               2 /dev/pts/0
wine-prel 9368 penberg   13u   CHR      136,0               2 /dev/pts/0
wine-prel 9368 penberg   14u   REG        3,3  126972 3093909 /tmp/.wine-1000/server-5962d/anonmap.UpYvef (deleted)
wine-prel 9368 penberg   15u   REG        3,3       4 3093910 /tmp/.wine-1000/server-5962d/anonmap.e1t1BA (deleted)
wine-prel 9368 penberg   16u   REG        3,3  126972 3093911 /tmp/.wine-1000/server-5962d/anonmap.0kzLDZ (deleted)
wine-prel 9368 penberg   17u   REG        3,3    1024 3093913 /tmp/.wine-1000/server-5962d/anonmap.6SK7BF (deleted)
wine-prel 9368 penberg   18u   REG        3,3    1024 3093914 /tmp/.wine-1000/server-5962d/anonmap.ifO9K1 (deleted)
wine-prel 9368 penberg   19u   REG        3,3   27648 2131469 /home/penberg/.cxoffice/dotwine/fake_windows/Windows/Application Data/Microsoft/Mallit/Normal.dot
wine-prel 9368 penberg   20u   REG        3,3    1024 3093913 /tmp/.wine-1000/server-5962d/anonmap.6SK7BF (deleted)
wine-prel 9368 penberg   21u   REG        3,3     364 3093916 /tmp/.wine-1000/server-5962d/anonmap.tvXNbP (deleted)
wine-prel 9368 penberg   22u   REG        3,3  126972 3093917 /tmp/.wine-1000/server-5962d/anonmap.O8NFES (deleted)
wine-prel 9368 penberg   23u   REG        3,3    1024 3093918 /tmp/.wine-1000/server-5962d/anonmap.CWi6XR (deleted)
wine-prel 9368 penberg   24r   REG        3,3   20480  331083 /home/penberg/anna/Annan ammattiraportti.doc
wine-prel 9368 penberg   25u   REG        3,3       4 3093915 /tmp/.wine-1000/server-5962d/anonmap.rddWfB (deleted)
wine-prel 9368 penberg   26r   REG        3,3  751534 1867273 /home/penberg/.cxoffice/dotwine/fake_windows/Program Files/Common Files/Microsoft Shared/Proof/MSSP_FI.LEX
wine-prel 9368 penberg   41r   DIR        3,3    4096  311341 /home/penberg


CPU: CPU with timer interrupt, speed 0 MHz (estimated)
Profiling through timer interrupt
samples  %        symbol name
980      13.3953  default_idle
682       9.3220  schedule
253       3.4582  do_notify_parent_cldstop
218       2.9798  sysenter_past_esp
206       2.8157  try_to_wake_up
187       2.5560  fget_light
159       2.1733  dnotify_parent
155       2.1186  do_wait
154       2.1050  sys_rt_sigprocmask
145       1.9820  generic_file_buffered_write
143       1.9546  sys_ptrace
115       1.5719  fget
111       1.5172  sock_poll
111       1.5172  walk_page_buffers
110       1.5036  find_vma
105       1.4352  __copy_from_user_ll
99        1.3532  __wake_up
99        1.3532  find_lock_page
99        1.3532  rw_verify_area
98        1.3395  pipe_poll
97        1.3259  ext3_prepare_write
96        1.3122  unix_poll
89        1.2165  wait_task_stopped
85        1.1618  __generic_file_aio_write_nolock
85        1.1618  ext3_get_inode_block
77        1.0525  start_this_handle
73        0.9978  remove_wait_queue
66        0.9021  __mark_inode_dirty
65        0.8885  journal_add_journal_head
63        0.8611  copy_from_user
60        0.8201  kmem_cache_alloc
58        0.7928  balance_dirty_pages_ratelimited
57        0.7791  sigprocmask
54        0.7381  sys_poll
53        0.7244  access_process_vm
52        0.7108  __block_commit_write
52        0.7108  sys_write
51        0.6971  ptrace_check_attach
47        0.6424  do_pollfd
47        0.6424  pipe_writev
46        0.6288  current_fs_time
46        0.6288  kmem_cache_free
46        0.6288  ptrace_notify
44        0.6014  __find_get_block
44        0.6014  find_pid
43        0.5878  mark_page_accessed
38        0.5194  bit_waitqueue
37        0.5057  __copy_to_user_ll
34        0.4647  __follow_page
34        0.4647  ext3_ordered_commit_write
34        0.4647  inode_update_time
33        0.4511  add_wait_queue
32        0.4374  ptrace_stop
30        0.4101  __alloc_pages
29        0.3964  get_task_mm
28        0.3827  do_poll
28        0.3827  handle_IRQ_event
28        0.3827  wake_up_bit
27        0.3691  __block_prepare_write
27        0.3691  mmput
27        0.3691  new_handle
26        0.3554  journal_stop
26        0.3554  resume_userspace
26        0.3554  update_atime
25        0.3417  getreg
23        0.3144  __kmalloc
23        0.3144  pipe_readv
22        0.3007  ext3_do_update_inode
21        0.2870  get_user_pages
21        0.2870  vfs_read
20        0.2734  __wake_up_bit
20        0.2734  find_task_by_pid_type
19        0.2597  sys_wait4
18        0.2460  kfree
17        0.2324  delay_tsc
15        0.2050  ext3_journal_start_sb
15        0.2050  ide_do_request
15        0.2050  vfs_write
14        0.1914  do_wp_page
14        0.1914  eligible_child
14        0.1914  ext3_file_write
14        0.1914  sched_clock
13        0.1777  kill_fasync
13        0.1777  sys_gettimeofday
13        0.1777  sys_read
12        0.1640  find_extend_vma
11        0.1504  generic_file_aio_write
11        0.1504  prep_new_page
10        0.1367  __mod_timer
10        0.1367  do_readv_writev
10        0.1367  fput
10        0.1367  free_pages
10        0.1367  get_offset_tsc
10        0.1367  journal_dirty_data
9         0.1230  __copy_user_zeroing_intel
9         0.1230  __put_user_4
9         0.1230  do_get_write_access
9         0.1230  do_gettimeofday
9         0.1230  do_select
9         0.1230  do_sync_write
9         0.1230  ext3_mark_inode_dirty
9         0.1230  free_hot_cold_page
9         0.1230  page_waitqueue
8         0.1093  buffered_rmqueue
8         0.1093  find_get_page
8         0.1093  generic_commit_write
8         0.1093  journal_dirty_metadata
8         0.1093  normal_poll
8         0.1093  profile_hit
8         0.1093  schedule_timeout
8         0.1093  unlock_buffer
7         0.0957  do_syscall_trace
7         0.0957  ext3_dirty_inode
7         0.0957  follow_page
6         0.0820  cond_resched_lock
6         0.0820  copy_to_user
6         0.0820  do_page_fault
6         0.0820  ext3_writepage_trans_blocks
6         0.0820  free_hot_page
6         0.0820  journal_get_write_access
6         0.0820  mark_buffer_dirty
6         0.0820  tty_ldisc_deref
6         0.0820  unix_stream_sendmsg
5         0.0683  __journal_file_buffer
5         0.0683  ext3_reserve_inode_write
5         0.0683  input_event
5         0.0683  journal_blocks_per_page
5         0.0683  max_select_fd
5         0.0683  poll_freewait
4         0.0547  __get_free_pages
4         0.0547  __link_path_walk
4         0.0547  __log_space_left
4         0.0547  __mod_page_state
4         0.0547  __pollwait
4         0.0547  anon_pipe_buf_release
4         0.0547  ext3_journal_dirty_data
4         0.0547  ext3_new_inode
4         0.0547  journal_cancel_revoke
4         0.0547  journal_start
4         0.0547  pool_find_page
4         0.0547  syscall_trace_entry
4         0.0547  unix_peer_get
4         0.0547  unix_stream_recvmsg
4         0.0547  unlock_page
4         0.0547  work_resched
3         0.0410  __d_lookup
3         0.0410  __ext3_get_inode_loc
3         0.0410  __ext3_journal_stop
3         0.0410  __pagevec_lru_add
3         0.0410  bad_range
3         0.0410  block_prepare_write
3         0.0410  cond_resched
3         0.0410  do_ioctl
3         0.0410  do_no_page
3         0.0410  ext3_get_block_handle
3         0.0410  ext3_get_inode_loc
3         0.0410  ext3_test_allocatable
3         0.0410  journal_put_journal_head
3         0.0410  sock_alloc_send_pskb
3         0.0410  sock_def_readable
3         0.0410  sock_wfree
3         0.0410  tty_paranoia_check
3         0.0410  unix_write_space
2         0.0273  __insert_inode_hash
2         0.0273  activate_page
2         0.0273  alloc_skb
2         0.0273  anon_pipe_buf_map
2         0.0273  con_chars_in_buffer
2         0.0273  convert_fxsr_to_user
2         0.0273  do_mmap_pgoff
2         0.0273  dput
2         0.0273  ext3_get_block
2         0.0273  ext3_new_block
2         0.0273  find_next_usable_block
2         0.0273  get_signal_to_deliver
2         0.0273  group_send_sig_info
2         0.0273  handle_signal
2         0.0273  kfree_skbmem
2         0.0273  kref_put
2         0.0273  math_state_restore
2         0.0273  setup_frame
2         0.0273  skb_release_data
2         0.0273  sock_aio_read
2         0.0273  sock_aio_write
2         0.0273  sock_ioctl
2         0.0273  sys_ioctl
2         0.0273  sys_writev
2         0.0273  syscall_exit_work
2         0.0273  tty_poll
2         0.0273  unix_ioctl
2         0.0273  vfs_writev
2         0.0273  zone_watermark_ok
1         0.0137  __copy_user_intel
1         0.0137  __find_get_block_slow
1         0.0137  __fput
1         0.0137  __free_pages
1         0.0137  __getblk
1         0.0137  __set_page_dirty_nobuffers
1         0.0137  account
1         0.0137  add_dirent_to_buf
1         0.0137  add_input_randomness
1         0.0137  con_write_room
1         0.0137  copy_mm
1         0.0137  copy_pte_range
1         0.0137  copy_strings
1         0.0137  create_empty_buffers
1         0.0137  del_timer
1         0.0137  device_not_available
1         0.0137  do_setitimer
1         0.0137  ext3_find_goal
1         0.0137  ext3_get_branch
1         0.0137  ext3_getblk
1         0.0137  ext3_mark_iloc_dirty
1         0.0137  ext3_truncate
1         0.0137  follow_mount
1         0.0137  generic_file_llseek
1         0.0137  ide_outb
1         0.0137  ide_outl
1         0.0137  ide_wait_stat
1         0.0137  init_fpu
1         0.0137  journal_get_undo_access
1         0.0137  kcalloc
1         0.0137  kmem_getpages
1         0.0137  load_elf_binary
1         0.0137  lookup_create
1         0.0137  lookup_hash
1         0.0137  memcpy_fromiovec
1         0.0137  memcpy_toiovec
1         0.0137  path_lookup
1         0.0137  pipe_write
1         0.0137  randomize_stack_top
1         0.0137  read_block_bitmap
1         0.0137  remove_vm_struct
1         0.0137  restore_fpu
1         0.0137  restore_i387_fxsave
1         0.0137  save_i387
1         0.0137  sock_alloc_send_skb
1         0.0137  sock_readv_writev
1         0.0137  sock_sendmsg
1         0.0137  strncpy_from_user
1         0.0137  sys_close
1         0.0137  sys_fcntl64
1         0.0137  sys_futex
1         0.0137  sys_newuname
1         0.0137  sys_sched_yield
1         0.0137  sys_select
1         0.0137  tty_ldisc_try
1         0.0137  vfs_ioctl
1         0.0137  wake_up_process
1         0.0137  zone_statistics


read(7, "X\371\303\177\1\0\0\0", 8)     = 8
ioctl(10, FIONREAD, [1280])             = 0
read(10, "\fHy\16\320\0 \3\0\0\0\0f\2\5\0\4\0`\10\3\0\0\0\377\377"..., 1280) = 1280
rt_sigprocmask(SIG_BLOCK, [HUP INT USR1 USR2 ALRM CHLD IO], [], 8) = 0
write(4, "\222\0\0\0\0\0\0\0\0\0\0\0v\0\1\0\1\0\0\0\0\0\0\0\0\0\0"..., 64) = 64
read(5, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 64) = 64
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [HUP INT USR1 USR2 ALRM CHLD IO], [], 8) = 0
write(4, "\214\0\0\0\0\0\0\0|\0\0\0v\0\1\0\0\0\0\0\0\0\0\0\0\0\0"..., 64) = 64
read(5, "\0\0\0\0\10\0\0\0\2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 64) = 64
read(5, "\214\0\1\0\212\0\1\0", 8)      = 8
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [HUP INT USR1 USR2 ALRM CHLD IO], [], 8) = 0
write(4, "\222\0\0\0\0\0\0\0\0\0\0\0\214\0\1\0\1\0\0\0\0\0\0\0\0"..., 64) = 64
read(5, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 64) = 64
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [HUP INT USR1 USR2 ALRM CHLD IO], [], 8) = 0
write(4, "\214\0\0\0\0\0\0\0|\0\0\0\214\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 64) = 64
read(5, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 64) = 64
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [HUP INT USR1 USR2 ALRM CHLD IO], [], 8) = 0
write(4, "\214\0\0\0\0\0\0\0|\0\0\0\214\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 64) = 64
read(5, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 64) = 64
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [HUP INT USR1 USR2 ALRM CHLD IO], [], 8) = 0
write(4, "\214\0\0\0\0\0\0\0|\0\0\0v\0\1\0\0\0\0\0\0\0\0\0\0\0\0"..., 64) = 64
read(5, "\0\0\0\0\10\0\0\0\2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 64) = 64
read(5, "\214\0\1\0\212\0\1\0", 8)      = 8
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [HUP INT USR1 USR2 ALRM CHLD IO], [], 8) = 0
write(4, "\214\0\0\0\0\0\0\0|\0\0\0\214\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 64) = 64
read(5, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 64) = 64
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [HUP INT USR1 USR2 ALRM CHLD IO], [], 8) = 0
write(4, "\214\0\0\0\0\0\0\0|\0\0\0v\0\1\0\0\0\0\0\0\0\0\0\0\0\0"..., 64) = 64



