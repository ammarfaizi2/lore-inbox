Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbTKYN1W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 08:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbTKYN1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 08:27:22 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:51934 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S262540AbTKYN1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 08:27:19 -0500
Message-ID: <3FC358B5.3000501@softhome.net>
Date: Tue, 25 Nov 2003 14:27:17 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.2/2.4/2.6 VMs: do malloc() ever return NULL?
Content-Type: multipart/mixed;
 boundary="------------070701020502080301010707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070701020502080301010707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello!

   I just wondering: do last three stable branches of LK able to return 
malloc()==NULL and/or ENOMEM?

   2.2: I cannot test this stuff right now - but it was hanging hard on 
"for (;;) memset(malloc(N), 0, N);" So we do not have NULL from malloc().
   2.4: same behaviour if OOM disabled. But by default (OOM even has no 
configuration entry - so always on) it just kills offending process. No 
NULL pointer either.
   2.6: the same as 2.4 with oom killer (default conf). I have no test 
system to check 2.6. w/o oom killer.

   Resume: we malloc() never returns NULL. so man-pages are incorrect ;-)
   [ AFAIK only kmalloc(GFP_ATOMIC) can potentially return NULL - but I 
didn't yet tested my modules under memory pressure. TODO. ]

   Most interesting thing is that on 2.4 "for(;;) malloc(N)" able to 
allocate about 1.8GB of memory on system with only 256M of physical RAM. 
Laghtingly fast. Then malloc() returns NULL. Good signs.
   But as soon as I will put "memset()" -  app will be killed or box 
will go bananas. Neither of this two things are appropriate. Especially 
when applications are tuned to handle memmory allocation errors.

   Can anyone comment on this?

   Does any one has patches with replacement VM? I'm very interesting in 
knowing all aspect of VM<->block layer<->rest of the kernel integration.

   Pointers to on-line memory management algorithms will be valuable 
too, if some one knows any.

P.S. I know about linux-mm.org - out-dated, but I do read it right now. 
Any other pointers will be appreciated.
But looks like general Linux crowd is satisfied with current (and past) 
status of MM...

P.P.S. Small memory eating app is attached. lines 16 & 17 (for() loop) 
used to touch every kbyte of memory to make it really allocated.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  Because the kernel depends on it existing. "init"          |_|*|_|
  literally _is_ special from a kernel standpoint,           |_|_|*|
  because its' the "reaper of zombies" (and, may I add,      |*|*|*|
  that would be a great name for a rock band).
                                 -- Linus Torvalds

--------------070701020502080301010707
Content-Type: text/plain;
 name="malloc.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="malloc.c"


#include <stdlib.h>
#include <stdio.h>

#define CHUNK_SIZE	(1<<16)

int main()
{
	char *b;
	unsigned long sz = 0;
	for (;;) {
		fprintf(stderr, "alloc ");
		if ((b = malloc( CHUNK_SIZE ))) {
			unsigned int i;
			sz += CHUNK_SIZE;
			for (i=0; i<(CHUNK_SIZE>>10); ++i)
				b[i<<10] = '0';
		} else
			exit(1);
		fprintf(stderr, "done. [%lu%s]\n", sz>>10, "k");
	}
}


--------------070701020502080301010707--

