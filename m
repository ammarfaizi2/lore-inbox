Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267023AbSL3SOO>; Mon, 30 Dec 2002 13:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267026AbSL3SON>; Mon, 30 Dec 2002 13:14:13 -0500
Received: from [217.13.199.129] ([217.13.199.129]:5566 "EHLO
	server1.netdiscount.de") by vger.kernel.org with ESMTP
	id <S267023AbSL3SNs>; Mon, 30 Dec 2002 13:13:48 -0500
Date: Mon, 30 Dec 2002 19:22:09 +0100
From: Christian Leber <christian@leber.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021230182209.GA3981@core.home>
References: <200212090830.gB98USW05593@flux.loup.net> <at2l1t$g5n$1@penguin.transmeta.com> <20021209193649.GC10316@suse.de> <at2rv7$fkr$1@cesium.transmeta.com> <20021228203706.GD1258@niksula.cs.hut.fi> <20021229020510.GA22540@core.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20021229020510.GA22540@core.home>
User-Agent: Mutt/1.4i
X-Accept-Language: de en
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2002 at 03:05:10AM +0100, Christian Leber wrote:

> > Now that Linus has killed the dragon and everybody seems happy with the
> > shiny new SYSENTER code, let just add one more stupid question to this
> > thread: has anyone made benchmarks on SYSCALL/SYSENTER/INT80 on Athlon? Is
> > SYSCALL worth doing separately for Athlon (and perhaps Hammer/32-bit mode)?
> 
> Yes, the output of the programm Linus posted is on a Duron 750 with
> 2.5.53 like this:
> 
> igor3:~# ./a.out
> 187.894946 cycles  (call 0xffffe000)
> 299.155075 cycles  (int 80)
> (cycles per getpid() call)

Damn, false lines, this where numbers from 2.5.52-bk2+sysenter-patch.

But now the right and interesting lines:

2.5.53:
igor3:~# ./a.out
166.283549 cycles
278.461609 cycles

2.5.53-bk5:
igor3:~# ./a.out
150.895348 cycles
279.441955 cycles

The question is: are the numbers correct?
(I don't know if the TSC thing is actually right)

And why have int 80 also gotten faster?


Is this a valid testprogramm to find out how long a system call takes?
igor3:~# cat sysc.c 
#define rdtscl(low) \
__asm__ __volatile__ ("rdtsc" : "=a" (low) : : "edx")

int getpiddd()
{
        int i=0; return i+10;
}

int main(int argc, char **argv) {
        long a,b,c,d;
        int i1,i2,i3;

        rdtscl(a);
        i1 = getpiddd(); //just to see how long a simple function takes
        rdtscl(b);
        i2 = getpid();
        rdtscl(c);
        i3 = getpid();
        rdtscl(d);
        printf("function call: %lu first: %lu second: %lu cycles\n",b-a,c-b,d-c);
        return 0;
}

I link it against a slightly modified (1 line of code) dietlibc:
igor3:~# dietlibc-0.22/bin-i386/diet gcc sysc.c
igor3:~# ./a.out 
function call: 42 first: 1821 second: 169 cycles

I heard that there are serious problems involved with TSC, therefore I
don't know if the numbers are correct/make seens.


Christian Leber

-- 
  "Omnis enim res, quae dando non deficit, dum habetur et non datur,
   nondum habetur, quomodo habenda est."       (Aurelius Augustinus)
  Translation: <http://gnuhh.org/work/fsf-europe/augustinus.html>
