Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264379AbUEEJtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264379AbUEEJtj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 05:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbUEEJtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 05:49:39 -0400
Received: from tor.morecom.no ([64.28.24.90]:4358 "EHLO tor.morecom.no")
	by vger.kernel.org with ESMTP id S264379AbUEEJtM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 05:49:12 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: BUGREPORT: Error in scheduling for System V semaphores on 2.6.5
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Wed, 5 May 2004 11:49:10 +0200
Message-ID: <40FB8221D224C44393B0549DDB7A5CE8378BF9@tor.lokal.lan>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: BUGREPORT: Error in scheduling for System V semaphores on 2.6.5
Thread-Index: AcQyhjc5jiw+uJoZQpOVWIguZ8r8Fg==
From: =?iso-8859-1?Q?Eirik_Nordbr=F8den?= <eirik.nordbroden@morecom.no>
To: <mingo@elte.hu>, <rml@tech9.net>
Cc: <linux-kernel@vger.kernel.org>,
       =?iso-8859-1?Q?B=E5rd_Laukvik?= <bard.laukvik@morecom.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PS I am not on any list, please CC me on any response.


[1.] One line summary of the problem:  

Error in scheduling for System V semaphores
  
[2.] Full description of the problem/report:

Three threads:

HP - high priority
MP - medium priority
LP - low priority

All with scheduling policy SCHED_FIFO.

All threads operates on a System V semaphore with binary behaviour.

Sequence:

1) Thread LP waits for semaphore => Thread LP gets semaphore and is running.
2) Thread HP is started and waits for semaphore => Thread HP is blocked and thread LP is running.
3) Thread MP is started and waits for semaphore => Thread MP is blocked and thread LP is running.
4) Thread LP signals semaphore => Thread HP gets semaphore and is running.
5) Thread HP signals semaphore => Thread MP gets semaphore, but thread HP is still running.
6) Thread HP waits for semaphore => Thread HP is blocked and thread MP starts running.
7) Thread MP signals semaphore => Thread HP gets semaphore and is running.
etc.

Step 5 introduces an erroneous behaviour. Thread MP should not get the semaphore until it is scheduled for running. Thread HP is still running and should get the semaphore in step 6.

This works fine for POSIX semaphores on same platform.

It also works correctly for System V semaphores on kernel release 2.4.22 with NPTL 
(Linux version 2.4.22-1.2115.nptl (bhcompile@daffy.perf.redhat.com) (gcc version 3.2.3 20030422 (Red Hat Linux 3.2.3-6)) #1 Wed Oct 29 15:42:51 EST 2003).

[3.] Keywords (i.e., modules, networking, kernel):

Semaphores System V, threads, ipc

[4.] Kernel version (from /proc/version):

Linux version 2.6.5 (eno@gyda.lokal.lan) (gcc version 3.3.2 20040119 (Red Hat Linux 3.3.2-7)) #1 Fri Apr 30 13:28:37 CEST 2004

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
NA

[6.] A small shell script or example program which triggers the
     problem (if possible)
We do not have a simple program that shows the problem.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux axxEdge_21 2.6.5 #1 Fri Apr 30 13:28:37 CEST 2004 ppc unknown
 
Gnu C                  command
ver_linux: ld: command not found
ver_linux: fdformat: command not found
mount: invalid option -- -
mount: invalid option -- e
mount: invalid option -- s
mount: invalid option -- i
mount                  /dev/hda1 on / type ext2 (rw)
mount                  /proc on /proc type proc (rw)
mount                  /sys on /sys type sysfs (rw)
mount                  /dev/shm on /dev/shm type tmpfs (rw)
mount                  /tmpfs on /tmp type tmpfs (rw)
mount                  gyda:/home on /mnt/gyda/home type nfs (rw,v3,rsize=8192,wsize=8192,hard,udp,nolock,addr=gyda)
mount                  gyda:/opt on /mnt/gyda/opt type nfs (rw,v3,rsize=8192,wsize=8192,hard,udp,nolock,addr=gyda)
mount                  bla:/home on /mnt/bla/home type nfs (rw,v3,rsize=8192,wsize=8192,hard,udp,nolock,addr=bla)
module-init-tools      found
ver_linux: ldd: command not found
Linux C Library        rwxr.xr.x    1 513      524            54 Apr  4 03:37 Lindent
Linux C Library        xr.x    1 513      524           962 Apr  4 03:38 MAKEDEV.ide
Linux C Library        xr.x    1 513      524          3562 Apr  4 03:38 MAKEDEV.snd
Linux C Library        r..    1 513      524           950 Apr  4 03:37 Makefile
Linux C Library        .    1 513      524         12415 Apr  4 03:37 Makefile.build
Linux C Library        .    1 513      524          1959 Apr  4 03:36 Makefile.clean
Linux C Library        .    1 513      524         11054 Apr  4 03:37 Makefile.lib
Linux C Library        .    1 513      524          1109 Apr  4 03:37 Makefile.modinst
Linux C Library        .    1 513      524          2144 Apr  4 03:37 Makefile.modpost
Linux C Library        .    1 513      524          7896 Apr  4 03:36 README.Menuconfig
Linux C Library        drwxrwxr-x    2 513      524          4096 Apr 30 11:17 basic.drwxrwxr.x    2 513      524          4096 Apr 30 11:17 basic
Linux C Library        .rwxrwxr.x    1 513      524         11807 Apr 30 11:17 bin2c
Linux C Library        .    1 513      524           702 Apr  4 03:37 bin2c.c
Linux C Library        .    1 513      524          4017 Apr  4 03:37 binoffset.c
Linux C Library        xr.x    1 513      524          1726 Apr  4 03:37 checkconfig.pl
Linux C Library        xr.x    1 513      524           529 Apr  4 03:36 checkincludes.pl
Linux C Library        xr.x    1 513      524          1905 Apr  4 03:36 checkversion.pl
Linux C Library        .rwxrwxr.x    1 513      524         15873 Apr 30 11:17 conmakehash
Linux C Library        .    1 513      524          6121 Apr  4 03:36 conmakehash.c
Linux C Library        .    1 513      524           168 Apr 30 11:17 elfconfig.h
Linux C Library        .    1 513      524            54 Apr  4 03:38 empty.c
Linux C Library        .    1 513      524           905 Apr 30 11:17 empty.o
Linux C Library        xr.x    1 513      524          1278 Apr  4 03:37 extract.ikconfig
Linux C Library        .    1 513      524          9255 Apr  4 03:37 file2alias.c
Linux C Library        .    1 513      524          6672 Apr 30 11:17 file2alias.o
Linux C Library            1 513      524           338 Apr  4 03:38 gcc.version.sh
Linux C Library        drwxrwxr-x    2 513      524          4096 Apr 30 11:17 genksyms.drwxrwxr.x    2 513      524          4096 Apr 30 11:17 genksyms
Linux C Library        .rwxrwxr.x    1 513      524         14494 Apr 30 11:17 kallsyms
Linux C Library        .    1 513      524          3200 Apr  4 03:38 kallsyms.c
Linux C Library        drwxrwxr-x    2 513      524          4096 Apr 30 11:17 kconfig.drwxrwxr.x    2 513      524          4096 Apr 30 11:17 kconfig
Linux C Library        xr.x    1 513      524         47689 Apr  4 03:36 kernel.doc
Linux C Library        drwxrwxr-x    2 513      524          4096 Apr  4 03:36 ksymoops.drwxrwxr.x    2 513      524          4096 Apr  4 03:36 ksymoops
Linux C Library        drwxrwxr-x    2 513      524          4096 Apr  4 03:38 lxdialog.drwxrwxr.x    2 513      524          4096 Apr  4 03:38 lxdialog
Linux C Library        rwxr.xr.x    1 513      524           941 Apr  4 03:38 makelst
Linux C Library        rwxr.xr.x    1 513      524          4451 Apr  4 03:37 makeman
Linux C Library        .rwxrwxr.x    1 513      524         12726 Apr 30 11:17 mk_elfconfig
Linux C Library        .    1 513      524          1437 Apr  4 03:38 mk_elfconfig.c
Linux C Library        rwxr.xr.x    1 513      524          2143 Apr  4 03:38 mkcompile_h
Linux C Library        rwxr.xr.x    1 513      524          2394 Apr  4 03:36 mkconfigs
Linux C Library        rwxr.xr.x    1 513      524          2406 Apr  4 03:36 mkspec
Linux C Library        xr.x    1 513      524           293 Apr  4 03:37 mkuboot.sh
Linux C Library        r..    1 513      524            74 Apr  4 03:37 mkversion
Linux C Library        .rwxrwxr.x    1 513      524         30462 Apr 30 11:17 modpost
Linux C Library        .    1 513      524         13366 Apr  4 03:36 modpost.c
Linux C Library        .    1 513      524          2197 Apr  4 03:36 modpost.h
Linux C Library        .    1 513      524          8464 Apr 30 11:17 modpost.o
Linux C Library        xr.x    1 513      524          5943 Apr  4 03:36 patch.kernel
Linux C Library        .rwxrwxr.x    1 513      524         19997 Apr 30 11:17 pnmtologo
Linux C Library        .    1 513      524         11935 Apr  4 03:36 pnmtologo.c
Linux C Library        xr.x    1 513      524          2599 Apr  4 03:37 split.man
Linux C Library        .    1 513      524         12925 Apr  4 03:37 sumversion.c
Linux C Library        .    1 513      524          7312 Apr 30 11:17 sumversion.o
Linux C Library        rwxr.xr.x    1 513      524          2866 Apr  4 03:37 ver_linux
ver_linux: ldd: command not found
Procps                 Command
Kbd                    command
Sh-utils               --v
Modules Loaded         

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
cpu             : 82xx
core clock      : 264 MHz
CPM  clock      : 198 MHz
bus  clock      : 66 MHz
revision        : 16.20 (pvr 8081 1014)
bogomips        : 175.10
vendor          : AXXESSIT
machine         : AXXEDGE

[7.3.] Module information (from /proc/modules):
NA

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
NA

[7.5.] PCI information ('lspci -vvv' as root)
NA

[7.6.] SCSI information (from /proc/scsi/scsi)
NA

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
NA

[X.] Other notes, patches, fixes, workarounds:


___________________________________________________________

Eirik Nordbrøden           Telephone     (+47) 90 17 47 89
moreCom A/S                Switchboard   (+47) 90 06 44 44
Tønne Huitfeldts plass 2   Fax.          (+47) 69 18 81 19
N-1767 Halden              Home          (+47) 69 18 78 99
Norway

Email: mailto:eirik.nordbroden@moreCom.no
WWW:   http://www.moreCom.no/
___________________________________________________________
 
