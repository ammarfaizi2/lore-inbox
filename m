Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbVLZIlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbVLZIlK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 03:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbVLZIlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 03:41:10 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:54042 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751050AbVLZIlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 03:41:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:message-id:from;
        b=K2PJGSfJgO9z97SpvDAWuCRCcWJUMn1zzjzCUndt7kzyZfsAVlUJo3E/b2KuqZzb41RbI0IdR81IP/33Zj0AljWlGsejChdnzEniNrq8PzH8bCMNmHHULdhC452br3NpC9+Y2ab/a4+gQ4T7CsIFhjU8TWboFk8EqbQLxTzejTQ=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: 4k stacks
Date: Mon, 26 Dec 2005 03:40:52 -0500
User-Agent: KMail/1.8.3
Cc: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0512221640490.8179@chaos.analogic.com> <200512242143.10291.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <200512260242.52379.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
In-Reply-To: <200512260242.52379.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Wy6rDIajxkw7++m"
Message-Id: <200512260340.55037.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_Wy6rDIajxkw7++m
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've modified stack.c to handle 4k stacks. It can also provide information
for 8k stacks (fwiw) by changing STACK_GRANULARITY.

It found one stack with only 756 bytes left. I hope it's just due to a
greedy boot-time function as I'm not running anything particularly exotic.
(CIFS & Reiser4). 

Unfortunately I don't have any more time to experiment: I'm leaving for
a week.

Andrew Wade

--Boundary-00=_Wy6rDIajxkw7++m
Content-Type: text/x-csrc;
  charset="koi8-r";
  name="stack.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="stack.c"

//
//  This needs the kernel stack-poison patch to run. 
//  Merry Christmas from rjohnson@analogic.com
//  Released under GPL
//  Modified by andrew.j.wade@gmail.com
//

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>

// Alignment/size of i386 stacks:
#define STACK_GRANULARITY 4096

// skip these many bytes:
#define THREAD_INFO_SIZE 52

int main()
{
    size_t i;
    int fd;
    char *buf;
    if((fd = open("/dev/mem", O_RDONLY)) < 0)
    {
        fprintf(stderr, "Can't open device file for reading\n");
        exit(EXIT_FAILURE);
    }
    if((buf = malloc(STACK_GRANULARITY)) == NULL)
    {
        fprintf(stderr, "Can't allocate memory\n");
        exit(EXIT_FAILURE);
    }

    while(read(fd, buf, STACK_GRANULARITY) == STACK_GRANULARITY)
    {
        if(buf[THREAD_INFO_SIZE] == 'Q')
        {
            for(i=THREAD_INFO_SIZE; i < STACK_GRANULARITY; i++)
                if(buf[i] != 'Q')
                     break;
            if(i > THREAD_INFO_SIZE + 4)	// Could be a word of 'QQQQ'
                printf("Available Stack bytes = %5u\n", i - THREAD_INFO_SIZE);
        }
    }
    free(buf);
    close(fd);
    return 0;
}


--Boundary-00=_Wy6rDIajxkw7++m--
