Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbVJUMqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbVJUMqz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 08:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbVJUMqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 08:46:54 -0400
Received: from tardis.csc.ncsu.edu ([152.14.51.184]:7350 "EHLO
	tardis.csc.ncsu.edu") by vger.kernel.org with ESMTP id S964928AbVJUMqw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 08:46:52 -0400
Message-ID: <4358E339.20608@csc.ncsu.edu>
Date: Fri, 21 Oct 2005 08:46:49 -0400
From: "Vincent W. Freeh" <vin@csc.ncsu.edu>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Understanding Linux addr space, malloc, and heap
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to understand the Linux addr space.  I figured someone might 
be able to shed some light on it.  Or at least point me to some sources 
that will help.

I don't understand what is happening with malloc and the heap in my 
process. According to /proc/<pid>/maps the memory from heap to stack 
initially looks like that.  I only show the four "maps" from the heap 
and above.  (This is a slightly altered form consisting of start_addr, 
end_addr, size_in_pgs, permissions, and path_if_one):

0x08d42000 - 0x08d63000 (33 pgs) rw-p   path `[heap]'
0xb7ef8000 - 0xb7ef9000 (1 pgs) rw-p
0xb7f09000 - 0xb7f0b000 (2 pgs) rw-p
0xbfaf5000 - 0xbfb0b000 (22 pgs) rw-p   path `[stack]'

I cannot touch (rd, wr, or even mprotect) the map immediate above the 
heap--must be a sandboxing page.  Before any malloc, brk = 0x8d42000 
first page of heap.

If I malloc <= 33 pages the memory comes from the first map above and 
the brk changes as appropriate.  However, some new maps appear between 
the two above. And the 2d one above gets bigger.  However, all data 
comes from the heap.  brk remain below the top of the heap.  As shown below.

0x08d42000 - 0x08d63000 (33 pgs) ---p   path `[heap]'
0xb7d00000 - 0xb7d01000 (1 pgs) rw-p
0xb7d01000 - 0xb7d21000 (32 pgs) ---p
0xb7d21000 - 0xb7e00000 (223 pgs) ---p
0xb7ef7000 - 0xb7ef9000 (2 pgs) rw-p
0xb7f09000 - 0xb7f0b000 (2 pgs) rw-p
0xbfaf5000 - 0xbfb0b000 (22 pgs) rw-p   path `[stack]'

Now if I malloc > 33 pages, the data comes from the heap and the next 
map(s).  That is the 34th pages is 0xb7d01000, in above example.  What 
is going on?

Another thing I don't understand is that I can touch maps 3 & 4 above 
(0xb7d01000 & 0xb7d21000) both rd and wr.  However, I cannot mprotect 
the 4th map---but mprotect does not fail, just doesn't change 
permissions.  I can mprotect the 32 pages in the map 3.  This is my 
initial problem: I can only mprotect 65 pages.  The 66th page (from map 
4) silently doesn't mprotect.

Looking around at other processes, they seem very different.  Both tcsh 
and emacs (appear to) have the 1 pg sandbox just below the stack (good 
place) and much larger heaps.

First, please fix any erroneous statements/assumptions above.  Next I 
have many questions.  A few follow.

* How does the heap work?  I learned/teach that heap is a contiguous 
chunk of memory that holds dynamically-allocated memory.  Doesn't appear 
to be the case.

* Man pg says can only mprotect mmap-able pages.  But what are these? 
How can I tell?

* Why does mprotect silently fail?

* I thought brk indicated the top of the heap and that all dynamic 
memory would be between bss end and brk.  That's not true.  What is brk 
for then?

Thanks,
v.
--
Vincent (Vince) W. Freeh
Dept of Computer Science
North Carolina State University
http://www.csc.ncsu.edu/faculty/freeh
919-513-7196
