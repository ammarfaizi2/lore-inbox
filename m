Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289234AbSAGPcV>; Mon, 7 Jan 2002 10:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289239AbSAGPcN>; Mon, 7 Jan 2002 10:32:13 -0500
Received: from [195.66.192.167] ([195.66.192.167]:8971 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S289234AbSAGPb6>; Mon, 7 Jan 2002 10:31:58 -0500
Message-Id: <200201071530.g07FU2E07077@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: "vda@port.imtp.ilyichevsk.odessa.ua" 
	<vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: christian e <cej@ti.com>, Rik van Riel <riel@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: swapping,any updates ?? Just wasted money on mem upgrade performance still suck :-(
Date: Mon, 7 Jan 2002 17:30:04 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3C386DC9.307@ti.com>
In-Reply-To: <3C386DC9.307@ti.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 January 2002 13:31, christian e wrote:
> You might remember I had issues with massive swapping and wanted to know
> whether I can control the amount of cache and buffers and so on. Well I
> thought a mem upgrade would do the trick ,but no :-(

You have to face it: Linus will never accept VM subsystem with lots on tuning 
knobs. It just won't happen. Fixing VM behavior is the only way. It has to 
work satisfactorily _without_ tuning.

> Not easy to explain to my boss that it still crawls with 512 MB mem and
> that's the max limit in this laptop..Anyone found any solutions ?? Check
> this out:
>
>   top -bn 1|head -n 30

Can you send full top output along with /proc/meminfo and /proc/slabinfo?
Last time you had mighty X (>100MB) too listed there...

>   16:25:46 up  2:56,  4 users,  load average: 0.50, 0.46, 0.43
> 79 processes: 77 sleeping, 2 running, 0 zombie, 0 stopped
> CPU states:   9.8% user,   8.5% system,   0.0% nice,  81.7% idle
> Mem:    513692K total,   512072K used,     1620K free,    21564K buffers
> Swap:   248968K total,    60180K used,   188788K free,   323668K cached
>
>    PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
>    950 ce        14   0  150M 150M  149M R    18.2 29.9  13:01 vmware
>   1146 ce        17   0  1000  996   772 R     7.3  0.1   0:00 top
>    952 ce         9   0 42572 9528  8268 S     0.9  1.8   0:12 vmware-mks

Well, vmware uses binary-only kernel module, can you confirm bad behaviour 
without vmware?

> it just caches like crazy and things start to crawl cause its
> swapping.More than 300 MB of cache what on earth is being cached ?? I
> can't stand ths anymore I guess I'll have to back down to 2.2 again,but
> that'll have other downsides :-(  *sigh*
> I'm willing to help as much as I can with this I don't want to give up
> on Linux just like that.

You may try -aa and Rik's VM.
I'm CC'ing them, maybe they are interested...

I use a proggy below to flush caches. It triggers OOM condition. But before 
it gets OOM-killed, it forces kernel to discard excessive caches. At least it 
has to work that way, but it isn't (on stock kernel), which confirms your 
observation that kernel is over-reluctant to flush caches.

#include <stdlib.h>
int main() {
    void *p;
    unsigned size = 1<<20;
    unsigned long total=0;
    while(size) {
        p = malloc(size);
        if(!p) size>>=1;
        else {
            memset(p, 0x77, size);
            total+=size;
            printf("Allocated %9u bytes, %12lu total\n",size,total);
        }
    }
    return 0;
}

How2use:
* do repeatedly:
  * top c b n 1 >topN (N=1,2,3,4,...)
  * same for 'cat /proc/meminfo' and 'cat /proc/slabinfo'
  * ./oom_trigger (will(should be) oom killed)
* try to figure out what cache isn't freed as it should :-)

To get clearer picture I do 
* killall5 -15; sleep 3; killall5 -9 several times
first, but that will ruin your test case it seems.

Anyway, if you'll spot something unusual in those debug printouts,
please inform lkml
--
vda
