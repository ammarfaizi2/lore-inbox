Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281805AbRLRMTl>; Tue, 18 Dec 2001 07:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281818AbRLRMTc>; Tue, 18 Dec 2001 07:19:32 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:12743 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S281805AbRLRMT1>; Tue, 18 Dec 2001 07:19:27 -0500
Date: Tue, 18 Dec 2001 14:18:58 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Samuli Suonpaa <suonpaa@iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.16: Out of memory - when still more than 100MB free
Message-ID: <20011218141858.O12063@niksula.cs.hut.fi>
In-Reply-To: <87elltwmgz.fsf@puck.erasmus.jurri.net> <Pine.LNX.4.21.0112171909320.3767-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0112171909320.3767-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Mon, Dec 17, 2001 at 07:10:54PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 07:10:54PM -0200, you [Marcelo Tosatti] claimed:
> 
> 
> On 17 Dec 2001, Samuli Suonpaa wrote:
> 
> > I've got VMWare killed a couple of times mysteriously. 
> > 
> > I've got 256MB memory and no swap on my laptop running 2.4.16 and for
> > some reason VMWare has got killed with the following syslog
> > information:
> > 
> > Dec 17 23:33:23 puck kernel: Out of Memory: Killed process 28803 (vmware).
> > Dec 17 23:33:35 puck kernel: Out of Memory: Killed process 28804 (vmware).
> > Dec 17 23:33:37 puck kernel: /dev/vmmon: Vmx86_ReleaseVM: unlocked pages: 75286, unlocked dirty pages: 51084
> 
> Samuli, 
> 
> The problem is that buffer/cache/{i,d}cache pages are not getting freed
> easily, and instead the kernel swapouts anonymous memory.
> 
> Could you please try 2.4.17-rc1 and tell me if it makes a difference for
> you ? 

See my report on what happens on a 2GB box with .16 or .17rc1. Buffers are
still not released as they should.

http://marc.theaimsgroup.com/?l=linux-kernel&m=100849985518543&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=100857274818037&w=2

Perhaps someone could test on x86 with less memory (I can do that later, but
right now I don't have any throw-away box with a recent kernel on it). On ia64
with 2GB+256MB swap this results in OOM when trying to allocate and use
1.7GB, albeit the real mem usage (-buffers) is less than 200MB. 

Basically the test is

fill cache 

 find / -type f -exec cat {} \; > /dev/null
 updatedb     

then run this with suitable argument:

#include <stdio.h>
#include <stdlib.h>

#define BKSP "\010\010\010\010\010\010"

int main(int argc, char** argv)
{
    unsigned long megs = 512;
    unsigned long size, i;
    unsigned char* buf;
    if (argc > 1) megs = atol(argv[1]);
    size = megs * 1024 * 1024;
    
    fprintf(stderr, "Allocating %lu megs...\n\n      ", megs);
    buf = malloc(size);
    if (!buf)
    {
         fprintf(stderr, "malloc(%lu", size);
         perror(")");
         exit(-1);
    }
    
    for (i = 0; i < size; i++)
    {
         buf[i] = 42;
         
         if ((i + 1) % (1024 * 1024) == 0) 
             fprintf(stderr, BKSP "%4uMB", (i + 1) / 1024 / 1024);
    }
    
    fprintf(stderr, "\n Success.\n");
    
    return 1;
}


-- v --

v@iki.fi
