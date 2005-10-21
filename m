Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbVJUNpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbVJUNpJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 09:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbVJUNpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 09:45:09 -0400
Received: from tardis.csc.ncsu.edu ([152.14.51.184]:21659 "EHLO
	tardis.csc.ncsu.edu") by vger.kernel.org with ESMTP id S964949AbVJUNpI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 09:45:08 -0400
Message-ID: <4358F0E3.6050405@csc.ncsu.edu>
Date: Fri, 21 Oct 2005 09:45:07 -0400
From: "Vincent W. Freeh" <vin@csc.ncsu.edu>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Understanding Linux addr space, malloc, and heap
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your quick response.  It basically confirmed that I observed 
what I thought I did.  However, I am no closer to solving my problem.  I 
cannot mprotect data that I malloc beyond the first 65 pages.  Why is 
that?  Can that be fixed?  Second, why does mprotect silently fail?  I 
could live with it failing--but I cannot deal with a call the "works" 
but doesn't work.

Thanks,
vince.

-----------
Subject	Re: Understanding Linux addr space, malloc, and heap
From	Arjan van de Ven <>
Date	Fri, 21 Oct 2005 15:00:02 +0200

On Fri, 2005-10-21 at 08:46 -0400, Vincent W. Freeh wrote:
 > I am trying to understand the Linux addr space.  I figured someone might
 > be able to shed some light on it.  Or at least point me to some sources
 > that will help.
 >
 > I don't understand what is happening with malloc and the heap in my
 > process. According to /proc/<pid>/maps the memory from heap to stack
 > initially looks like that.  I only show the four "maps" from the heap
 > and above.  (This is a slightly altered form consisting of start_addr,
 > end_addr, size_in_pgs, permissions, and path_if_one):
 >
 > 0x08d42000 - 0x08d63000 (33 pgs) rw-p   path `[heap]'
 > 0xb7ef8000 - 0xb7ef9000 (1 pgs) rw-p
 > 0xb7f09000 - 0xb7f0b000 (2 pgs) rw-p
 > 0xbfaf5000 - 0xbfb0b000 (22 pgs) rw-p   path `[stack]'
 >
 > First, please fix any erroneous statements/assumptions above.  Next I
 > have many questions.  A few follow.
 >
 > * How does the heap work?  I learned/teach that heap is a contiguous
 > chunk of memory that holds dynamically-allocated memory.  Doesn't appear
 > to be the case.

that's the old school 1970's stuff

the "heap" is still brk in linux, however there is no 1:1 relation
between heap and malloc. malloc in glibc is implemented both using brk
and mmap, depending on the size of your allocation.


 >
 > * Man pg says can only mprotect mmap-able pages.  But what are these?
 > How can I tell?

you need to mmap these yourself to be sure.. eg you cannot mprotect the
output of malloc, at least not reliably. Only of mmap.

 >
 > * Why does mprotect silently fail?

no it has sideeffects; eg it most likely affects more memory than just
your malloc()'d part


 > * I thought brk indicated the top of the heap and that all dynamic
 > memory would be between bss end and brk.  That's not true.  What is brk
 > for then?

see definition of heap vs malloc above


