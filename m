Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279257AbRKFNAg>; Tue, 6 Nov 2001 08:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279229AbRKFNA1>; Tue, 6 Nov 2001 08:00:27 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:37130 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S279180AbRKFNAK>; Tue, 6 Nov 2001 08:00:10 -0500
Date: Tue, 6 Nov 2001 09:40:51 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: out_of_memory() heuristic broken for different mem configurations
Message-ID: <Pine.LNX.4.21.0111060928010.9782-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi people,

While testing 2.4.14 VM on the 16GB machine testbox I've been able to
make the OOM killer not trigger correctly. The same usual workload: lots
of fillmem processes. 

Looking at out_of_memory() I've found out that we will only kill a task if
we happen to call out_of_memory() ten times in one second. 

That is completly variable on the system load: Taking into account that we
have we lots of processes inside try_to_free_pages() and the LRU list is
insanely HUGE (almost all pages were on the inactive list), I think this
"ten times in one second" just does not work.
 
Well, yes, its seems to be just a wrong magic number for this
setup/workload.

Linus, any suggestion to "fix" that ? 

/proc tunable (eeek) ? 


vmstat output:

13  7  2 3812816   2884    228   7648  42 28454    58 28430  295  1070   0 70  30
10 12  2 3880664   2640    204   7644  24 27754    28 27766  277 14650   0 92   8
17  5  1 3943404   2964    228   7656  22 31258    38 31276  303 10067   0 80  20
18  3  1 3998948   2708    220   7652  32 19434    46 19422  224   857   0 83  17

(end of swap)

23  1  1 4032960   2892    232   7648  16 24246    22 24252  235   997 0 72  28
22  1  1 4032960   2872    232   7648   0   0     0     0  106    13   0 99   0
23  0  2 4032960   2764    232   7648   0   0     0     0  116    11   0 100   0
21  0  1 4032960   2856    232   7648   0   0     0     0  122    45   0 100   0
21  0  1 4032960   2848    232   7648   0   0     0     0  117    21   0 100   0
21  0  1 4032960   2588    232   7648  38   0    38     0  118    41   0 100 0
21  0  1 4032960   2584    232   7648   0   0     0     0  123    10   0 100   0


