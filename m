Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266100AbSLTW3z>; Fri, 20 Dec 2002 17:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266200AbSLTW3z>; Fri, 20 Dec 2002 17:29:55 -0500
Received: from smtp07.iddeo.es ([62.81.186.17]:39163 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id <S266100AbSLTW3w>;
	Fri, 20 Dec 2002 17:29:52 -0500
Date: Fri, 20 Dec 2002 23:37:54 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-aa and LARGE Squid process -> SIGSEGV
Message-ID: <20021220223754.GA10139@werewolf.able.es>
References: <20021220114837.GC13591@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021220114837.GC13591@charite.de>; from Ralf.Hildebrandt@charite.de on Fri, Dec 20, 2002 at 12:48:37 +0100
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.12.20 Ralf Hildebrandt wrote:
>Hi!
[real problem snipped]
>
>Then we wrote a program which allocates large amounts of memory:
>
>--- snip ---
>#include <stdlib.h>
>#include <stdio.h>
>
>main(){
>  char *buf;
>  long c;
>  FILE *fp;
>
>  fp = fopen("/dev/null","a");
>  while(1){
>    buf = (char *)malloc(100000000);
>    c = random();
>    if (c > 100000000)
>      continue;
>    fprintf(fp,"%c",buf[c]);
>    printf("hier\n");
>  }
>}
>--- snip ---
>
>And we found that this program will be killed with a SIGSEGV as well.
>

Normal. You are running OOM. Look at what you do:

    while (1)
    {
         malloc(much mem)
         // do not free the mem !!!!
    }

So in a couple steps you are OOM.

I suppose what you want to do is

    buf = malloc(...)
    while (1)
        touch random page

But...you 'touch' is read-only (the printf), so the page will never
really be allocated. Try with this:

#include <stdlib.h>

// 4Gb
#define SZ 4*1024*1024*1024

main(){
    char *buf;

    buf = malloc(SZ);
    if (!buf)
    {
        perror("bad try");
        exit(1);
    }
    while(1){
        buf[random()%SZ] = 0;
    }
}

Ah, with 2Gb of ram you will need to compile with 3Gb userspace,
to let a one only process allocate a chunk of mem that does not fit
into core memory. Or, easier, run several instances...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-jam2 (gcc 3.2 (Mandrake Linux 9.1 3.2-4mdk))
