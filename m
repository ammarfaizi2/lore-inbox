Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933071AbWKWNDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933071AbWKWNDm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 08:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933634AbWKWNDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 08:03:42 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:46969 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S933071AbWKWNDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 08:03:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hbv1eZsaDUsWrVo+1LisvlQQwumumkpKjoCW7FKHXeqcQZhqlLI/WCYmLpnPsgluhYx5mCwbKqfu58k4VM3qtKbk5p/S5r345mbF0vAJkQn0xxU7eKXnRqJ5P9QF39uKebYeAh3pyNTBFJHQW78TMMDEpnVzrr1U3wIRgQ7GV2E=
Message-ID: <f36b08ee0611230503q763e03edge12a5e4d0d8b5ed5@mail.gmail.com>
Date: Thu, 23 Nov 2006 15:03:40 +0200
From: "Yakov Lerner" <iler.ml@gmail.com>
To: "Xavier Bestel" <xavier.bestel@free.fr>
Subject: Re: coping with swap-exhaustion in 2.4.33-4
Cc: Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1164285412.13074.131.camel@frg-rhel40-em64t-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f36b08ee0611230430k9b2b625qc8d1b93031e09d14@mail.gmail.com>
	 <1164285412.13074.131.camel@frg-rhel40-em64t-03>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/06, Xavier Bestel <xavier.bestel@free.fr> wrote:
> On Thu, 2006-11-23 at 14:30 +0200, Yakov Lerner wrote:
> >     Where can I read anything about how kernel is supposed to
> > react to the 'swap-full' condition ? We have troubles on the
> > production machine which routinely arrives to the swap-full state
> > no matter how I increase the swap, because user proceses multi-fork
> > and then want to allocate a lot of virtual memory.
>
> Did you disable memory overcommit ?

The /proc/sys/vm/overcommit_memory is 0 (the default is 0, no ?)

This is test program, memstress.c. We make sure we touch all allocated chunks.

#include <stdio.h>
#include <stdlib.h>
#include <poll.h>
#include <string.h>


int main(int argc, char **argv) {
    char *p;
    int size = 10*1024*1024;
    int k;
    int bypass_prompt = 0;
    int mb = 0;
    int bytes = 0;

    printf("Warning this allocation test may kill your computer by
exhausting the swap+memory\n");
    if( argc > 1 && 0 == strcmp("-f", argv[1])) {
        bypass_prompt = 1;
    }
    if(!bypass_prompt) {
        printf("Press Enter to proceed, or Ctrl-C to cancel; or use -f
option to bypass the prompt\n");
        getchar();
    }


    for(k=0; ; k++)  {
        p = malloc(size);
        if(p) {
            memset(p, 0xff, size );
            bytes += size;
            printf("%d mb\n", bytes / (1024*1024) );
        }
        poll(0,0, 1);
    }
}
