Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277272AbRJJP3J>; Wed, 10 Oct 2001 11:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277273AbRJJP3A>; Wed, 10 Oct 2001 11:29:00 -0400
Received: from host115.express.visi.com ([209.98.212.115]:44165 "EHLO skuld.wk")
	by vger.kernel.org with ESMTP id <S277272AbRJJP2l>;
	Wed, 10 Oct 2001 11:28:41 -0400
To: linux-kernel@vger.kernel.org
Cc: debian-user@lists.debian.org
Subject: Problems with NFS between IRIX Server and Linux client
Date: Wed, 10 Oct 2001 10:26:02 -0500
From: "Chad C. Walstrom" <chewie@wookimus.net>
Message-Id: <20011010152602.E11EE184B3@skuld.wk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK.  Strange problem here with NFS that has been experienced on both
Debian machines and Red Hat machines.  I believe the problem ties in
to NFS support in the Linux kernel, but I could be entirely wrong.

Scenario: Serving a filesystem from IRIX 6.5 host.  Accessing it with
a Linux 2.4.9 Debian Woody machine.  Directory content listings and
directory info are not consistently reported to the client.

Symptoms: For directories with #files approx > 200, filename
completion in bash does not work, many applications do not show files
in the directory.

I cannot pinpoint the number of files that throws it off.  In a test
directory, I've created a number of files by looping through a bash
script:

    for i in $(seq 1 200) ; do touch $i ; done

With 200 files, I was able to type 'ls 1<tab>' and get the familiar:

    "Display all 111 possibilities? (y or n)"

When I up'd the sequence to 210 it worked, 220, it did not.  From 220
files, I started to delete one file at a time until filename
completion started to work.  By 180, I could still not get a filename
completion.  I increased the number of files I removed by blocks of
ten.  At 159 files in the directory, I got that familiar list of files
that would complete 'ls 1<tab>'.  I would have expected the filename
completion to start working again at 200 files, but this is what
is happening.

nfsstat(1) of the nfs-common package reports no calls to nfs v2.
The client stats are as follows:

Client rpc stats:
calls      retrans    authrefrsh
251193     2          0       

Client nfs v3:
null       getattr    setattr    lookup     access     readlink   
0       0% 339     0% 4941    1% 192725 77% 719     0% 13      0% 
read       write      create     mkdir      symlink    mknod      
10893   4% 16079   6% 3119    1% 2       0% 3       0% 0       0% 
remove     rmdir      rename     link       readdir    readdirplus
2715    1% 1       0% 2425    0% 223     0% 1632    0% 0       0% 
fsstat     fsinfo     pathconf   commit     
11      0% 11      0% 0       0% 13222   5% 

The IRIX Server reported the following:

Server RPC:
calls      badcalls   nullrecv   badlen     xdrcall    duphits
dupage
88596597   0          7661399    0          0          2186
557.33  

Server NFS V3:
calls        badcalls     
51031056     0            
null         getattr      setattr      lookup       access       readlink     
52998  0%    1394893  2%  827158  1%   19540449 38% 1294352  2%  50714 0%    
read         write        create       mkdir        symlink      mknod        
6306234 12%  7379734 14%  504682  0%   8581  0%     4185  0%     1  0%        
remove       rmdir        rename       link         readdir    readdir+     
458294  0%   5198  0%     132737  0%   33172  0%    390736  0% 105473  0%   
fsstat       fsinfo       pathconf     commit       
5377509 10%  4612155  9%  12342  0%    2539452  4%  

An strace of scan(1) from nmh to two different directories shows the
contrasting ipc calls:

Calling "scan +inbox":

    brk(0x809c000)                          = 0x809c000
    stat64(0x8097690, 0xbfffd21c)           = 0 
    access("/home/chad/Mail/inbox", W_OK)   = 0
    SYS_199(0x401940b8, 0x2, 0x40194e00, 0x40191ed0, 0x8098118) = 713
    ipc_subcall(0x3, 0x80987c8, 0x2000, 0x2) = 2672
    ipc_subcall(0x3, 0x80987c8, 0x2000, 0x2) = 0
    close(3)                                = 0
    open("/home/chad/Mail/inbox/.mh_sequences", O_RDONLY) = 3
    .
    .
    .

Calling "scan +ima/cron/2001-10":

    brk(0x809c000)                          = 0x809c000
    stat64(0x8097698, 0xbfffd20c)           = 0
    access("/home/chad/Mail/ima/cron/2001-10", W_OK) = 0
    SYS_199(0x401940b8, 0x2, 0x40194e00, 0x40191ed0, 0x8098118) = 713
    ipc_subcall(0x3, 0x80987c8, 0x2000, 0x2) = 8184
    close(3)                                = 0
    writev(2, [{"scan", 4}, {": ", 2}, {"no messages in ima/cron/2001-10",
    31}, {"\n", 1}], 4scan: no messages in ima/cron/2001-10
    ) = 38
    _exit(1)                                = ?

I know this isn't a whole lot to go on, but if I could get a direction
to start looking, I would really appreciate it.

--
Chad Walstrom <chewie@wookimus.net>                 | a.k.a. ^chewie
http://www.wookimus.net/                            | s.k.a. gunnarr
Key fingerprint = B4AB D627 9CBD 687E 7A31  1950 0CC7 0B18 206C 5AFD
