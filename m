Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWBXUXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWBXUXK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWBXUXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:23:10 -0500
Received: from flex.com ([206.126.0.13]:28690 "EHLO flex.com")
	by vger.kernel.org with ESMTP id S932467AbWBXUXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:23:09 -0500
From: Marr <marr@flex.com>
To: linux-kernel@vger.kernel.org
Subject: Drastic Slowdown of 'fseek()' Calls From 2.4 to 2.6 -- VMM Change?
Date: Fri, 24 Feb 2006 16:22:48 -0400
User-Agent: KMail/1.7.2
X-KMail-CryptoFormat: 15
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200602241522.48725.marr@flex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

*** Please CC: me on replies -- I'm not subscribed.

Short Problem Description/Question:

When switching from kernel 2.4.31 to 2.6.13 (with everything else the same), 
there is a drastic increase in the time required to perform 'fseek()' on 
larger files (e.g. 4.3 MB, using ReiserFS [in case it matters], in my test 
case).

It seems that any seeks in a range larger than 128KB (regardless of the file 
size or the position within the file) cause the performace to drop 
precipitously. As near as I can determine, this happens because the virtual 
memory manager (VMM) in 2.6.13 is not caching the full 4.3 MB file. In fact, 
only a maximum of a 128KB segment of the file seems to be cached.

Can anyone please explain this change in behavior and/or recommend a 2.6.x VM 
setting to revert to the old (_much_ faster) 'fseek()' behavior from 2.4.x 
kernels?

-----------------------------------

More Details:

I'm running Slackware 10.2 (2.4.31 and 2.6.13 stock kernels) on a 400 MHz AMD 
K6-2 laptop with 192MB of RAM.

I have an application that does many (20,000 - 50,000) 'fseek()' calls on the 
same large file.  In 2.4.31 (and other earlier 2.4.x kernels), it runs very 
fast, even on large files (e.g. 4.3 MB).

I culled the problem down to a C code sample (see below).

Some timing tests with 20,000 'fseek()' calls:

   Kernel 2.4.31: 1st run -- 0m8.0s; 2nd run 0m0.6s;

   Kernel 2.6.13: 1st run -- 32.0s; 2nd run 29.0s;

Some timing tests with 200,000 'fseek()' calls:

   Kernel 2.4.31: 6.0s

   Kernel 2.6.13: 4m50s

Clearly, the 2.4.31 results are speedy because the whole 4MB file has been 
cached.

What I cannot figure out is this: what has changed in 2.6.x kernels to cause 
the performance to degrade so drastically?!?

Assuming it's somehow related to the 2.6.x VMM code, I've read everything I 
could in the 'usr/src/linux-2.6.13/Documentation/vm/' directory and I've run 
'vmstat' and dumped the various '/proc/sys/vm/*' settings. I've tried 
tweaking settings (some [most?] of which I don't fully understand [e.g. 
'/proc/sys/vm/lowmem_reserve_ratio']). I've tried scanning the VM code for 
clues but, not being a Virtual Memory guru, I've come up empty. I've searched 
the web and LKML to no avail.

I'm completely at a loss -- any suggestions would be much welcomed!

-----------------------------------

Here's a quick 'n' dirty test routine I wrote which demonstrates the problem 
on a 4MB file generated with this command:

   dd if=/dev/zero of=/tmp/fseek-4MB bs=1024 count=4096

Compile:

   gcc -o fseek-test fseek-test.c

Run (1st parm [required] is filename; 2nd parm [optional, 20K is default] is 
loop count):

   fseek-test /tmp/fseek-4MB 20000

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

int main (int argc, char *argv[])
{
   if (argc < 2) {
      printf("You must specify the filename!\n");
   }
   else {
      FILE *inp_fh;
      if ((inp_fh = fopen(argv[1], "rb")) == 0) {
         printf("Error ('%s') opening data file ('%s') for input!\n", 
                strerror(errno), argv[1]);
      }
      else {
         int j, pos;
         int max_calls = 20000;
         if (argc > 2) {
            max_calls = atoi(argv[2]);
            if (max_calls < 100) max_calls = 100;
            if (max_calls > 999999) max_calls = 999999;
         }
         printf("Performing %d calls to 'fseek()' on file '%s'...\n", 
                max_calls, argv[1]);
         for (j=0; j < max_calls; j++) {
            pos = (int)(((double)random() / (double)RAND_MAX) * 4000000.0);
            if (fseek(inp_fh, pos, SEEK_SET)) {
               printf("Error ('%s') seeking to position %d!\n", 
                      strerror(errno), pos);
            }
         }
         fclose(inp_fh);
      }
   }
   exit(0);
}

-----------------------------------

Any advice is much appreciated... TIA!

*** Please CC: me on replies -- I'm not subscribed.

Bill Marr
