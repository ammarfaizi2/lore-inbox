Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263728AbTKAHTN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 02:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263732AbTKAHTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 02:19:13 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:17681 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S263728AbTKAHTL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 02:19:11 -0500
Date: Sat, 1 Nov 2003 08:19:07 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Anthony DiSante <orders@nodivisions.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Audio skips when RAM is ~full
Message-ID: <20031101071907.GA6300@alpha.home.local>
References: <3FA34523.30902@nodivisions.com> <20031101062050.GA13731@alpha.home.local> <3FA353E4.60906@nodivisions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA353E4.60906@nodivisions.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 01, 2003 at 01:34:12AM -0500, Anthony DiSante wrote:
> >2) you can try to preload your file into the cache just before playing it :
> >   cp $file /dev/null ; mpg321 $file
> 
> But wouldn't "cp $file /tmp/ramdisk0; mpg321 /tmp/ramdisk0/$file" 
> accomplish the same thing?  (I've done that.)

It's different because you need to reserve a fixed amount of ram for the
ramdisk while I was only using the caching features of the kernel as a
fast read-ahead mechanism. But I agree with you that the result should be
the same.

> Actually, I don't scan the disk to find random albums; I have a text file 
> that contains a list of every album's full path, and I pick a random line 
> from that file.  So only the selected album's directory gets scanned.  And 
> the mp3 partition is mounted read-only (I should have mentioned that 
> before), so the atimes shouldn't be getting written as it is.

OK, so it's not a disk IO problem at all. It's really related to the sound
driver it seems. Now that you say it, I remember having noticed skips on
my laptop with a via 82cxxx chip after tens of minutes playing. At first
I thought it was related to other activity on the system, but it did exactly
what you describe, play seconds 1, 2, then 5 without a hole between them.
There may be a problem with the way the audio buffer gets allocated or freed.

> So I'm guessing that there isn't actually a way to manually move 
> buffer-data out of RAM?

Yes, there is. I have a quick'n'dirty program which does exactly that.
Basically, you tell it how many kB you want to free, then it allocates
and uses that amount of memory, frees it and exits. Buffered data gets
flushed very quickly. I sometimes give it a try before starting to work
on large kernel trees, because it helps the entire directories to fit in
cache.

Here it is if you're interested. Don't start it without an argument, it
will try to allocate 4G !

Regards,
Willy

---
#include <stdio.h>

main(int argc, char **argv) {
  unsigned long int i,k=0, max;
  char *p;

  if (argc>1)
      max=atol(argv[1]);
  else
      max=0xffffffff;

  printf("Freeing %lu kB ram\n",max);
  while (((p=(char *)malloc(1048576))!=NULL) && (k+1024<=max)) {
    for (i=0;i<256;p[4096*i++]=0);
    k+=1024;
    fprintf(stderr,"\r%d kB allocated",k);
  }
  while (((p=(char *)malloc(65536))!=NULL) && (k+64<=max)) {
    for (i=0;i<16;p[4096*i++]=0);
    k+=64;
    fprintf(stderr,"\r%d kB allocated",k);
  }
  while (((p=(char *)malloc(1024))!=NULL) && (k+1<=max)) {
    for (i=0;i<16;p[64*i++]=0);
    k+=1;
    fprintf(stderr,"\r%d kB allocated",k);
  }
  fprintf(stderr,"\nMemory freed.\n");
  exit(0);
}

