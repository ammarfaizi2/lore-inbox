Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315416AbSFXXeb>; Mon, 24 Jun 2002 19:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315417AbSFXXea>; Mon, 24 Jun 2002 19:34:30 -0400
Received: from mail4.home.nl ([213.51.129.228]:56719 "EHLO mail4.home.nl")
	by vger.kernel.org with ESMTP id <S315416AbSFXXe2>;
	Mon, 24 Jun 2002 19:34:28 -0400
From: Frank van de Pol <fvdpol@home.nl>
Date: Tue, 25 Jun 2002 01:34:06 +0200
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: "Salvatore D'Angelo" <dangelo.sasaman@tiscalinet.it>,
       Chris McDonald <chris@cs.uwa.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: gettimeofday problem
Message-ID: <20020624233406.GA18854@idefix.fvdpol.home.nl>
References: <3D16F252.90309@tiscalinet.it> <Pine.LNX.3.95.1020624153816.15499A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1020624153816.15499A-100000@chaos.analogic.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.18 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Richard,

I gave your test program a try, and the problem is reproducably triggered:


frank@idefix:~/projects$ ./tod
Failed after 2008
a = 1024961239107823, b = 1024961238254652
frank@idefix:~/projects$ ./tod
Failed after 1394
a = 1024961252215231, b = 1024961239964379
frank@idefix:~/projects$ ./tod
Failed after 110179
a = 1024961241574880, b = 1024961241573638
frank@idefix:~/projects$ ./tod
Failed after 4891
a = 1024961242145265, b = 1024961242144027
frank@idefix:~/projects$ ./tod
Failed after 45008
a = 1024961243210834, b = 1024961242943904
frank@idefix:~/projects$ ./tod
Failed after 6695
a = 1024961243405068, b = 1024961243403828
frank@idefix:~/projects$ ./tod
Failed after 1487
a = 1024961244216903, b = 1024961244093738
frank@idefix:~/projects$ ./tod
Failed after 3275
a = 1024961245674712, b = 1024961245673487
frank@idefix:~/projects$ ./tod
Failed after 42122
a = 1024961259065626, b = 1024961246333377
frank@idefix:~/projects$ ./tod
Failed after 425
a = 1024961253600435, b = 1024961252652402
frank@idefix:~/projects$


Possibly it might have to do with the fact that my machine is an SMP box
(dual pentium II)

$ uname -a

Linux idefix 2.4.18 #3 SMP Sat Apr 20 14:35:58 CEST 2002 i686 unknown

In fact it is almost symmetrical (one CPU seems to be faster than the other,
eventhough they are running at the same clock speed).

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 3
model name      : Pentium II (Klamath)
stepping        : 4
cpu MHz         : 333.225
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov mmx
bogomips        : 665.19

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 333.225
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx
bogomips        : 748.74





On Mon, Jun 24, 2002 at 03:44:02PM -0400, Richard B. Johnson wrote:
> On Mon, 24 Jun 2002, Salvatore D'Angelo wrote:
> 
> > In this piece of code I convert seconds and microseconds in 
> > milliseconds. I think the problem is not in my code, in fact I wrote the 
> > following piece of code in Java, and it does not work too. In the for 
> > loop the 90% of times b > a while for 10% of times not.
> > 
> >     class Prova {
> >           public static void main(....) {
> >                for (;;) {
> >                     long a = System.currentTimeMillis();
> >                     long b = System.currentTimeMillis();
> > 
> >                     if (a > b) {
> >                          System.out.println("Wrong!!!!!!!!!!!!!");
> >                     }
> >                }
> >           }
> >     }
> > 
> > 
> 
> This has been running since I first read your mail about 10:00 this
> morning. The kernel is 2.4.18
> 
> #include <stdio.h>
> #include <sys/time.h>
> #define MICRO 1000000
> #define ULL unsigned long long
> int main(void);
> static ULL tim(void);
> 
> static ULL tim()
> {
>     struct timeval t;
>     (void)gettimeofday(&t, NULL);
>     return (ULL)t.tv_sec * MICRO + (ULL)t.tv_usec;
> }
> int main()
> {
>     ULL a, b, cnt;
>     for(cnt=0;;cnt++)
>     {
>         a = tim();
>         b = tim();
>         if(b < a)
>             break;
>     }
>     printf("Failed after %llu\n", cnt);
>     printf("a = %llu, b = %llu\n", a, b);
>     return 0;
> }
> 
> It seems to work fine. That said, I didn't use your code or check
> for the possibility of a sign-change miscompare. I just made sure
> I don't have any by using unsigned stuff. You may want to try
> this code to see if you have a compiler (or coding) problem.
> 
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
> 
>                  Windows-2000/Professional isn't.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
+---- --- -- -  -   -    - 
| Frank van de Pol                  -o)    A-L-S-A
| FvdPol@home.nl                    /\\  Sounds good!
| http://www.alsa-project.org      _\_v
| Linux - Why use Windows if we have doors available?
