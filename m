Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318764AbSH1MMg>; Wed, 28 Aug 2002 08:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318794AbSH1MMg>; Wed, 28 Aug 2002 08:12:36 -0400
Received: from chaos.analogic.com ([204.178.40.224]:64386 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318764AbSH1MMc>; Wed, 28 Aug 2002 08:12:32 -0400
Date: Wed, 28 Aug 2002 08:18:25 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: yodaiken@fsmlabs.com
cc: Mark Hounschell <markh@compro.net>,
       "Wessler, Siegfried" <Siegfried.Wessler@de.hbm.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: interrupt latency
In-Reply-To: <20020827145631.B877@hq.fsmlabs.com>
Message-ID: <Pine.LNX.3.95.1020828080308.14759A-101000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-2065311790-1030537105=:14759"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1678434306-2065311790-1030537105=:14759
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 27 Aug 2002 yodaiken@fsmlabs.com wrote:

> On Tue, Aug 27, 2002 at 04:44:34PM -0400, Richard B. Johnson wrote:
> > On Tue, 27 Aug 2002 yodaiken@fsmlabs.com wrote:
> > 

[SNIPPED...]B
> 
> You can do it in a tight loop. But you cannot do it otherwise.  RS232 works
> because most UARTs have fifo buffers.  Old Windows did pretty well, because
> you could grab the machine and let nothing else happen.
> 
> What makes me dubious about your claim is that it is easy to test
> and see that a single ISA operation can take 18 microseconds
> on most PC hardware.
> 
> try:
> 	cli
> 	loop:
> 		read tsc
> 		inb 
> 		read tsc
> 		compute difference
> 		print worst case every 1000000 times.
> 
> 	sti
> 
> run for an hour on a busy machine.
> 
>

No, no, no. There is no such port read that takes 18 microseconds, even
on old '386 machines with real ISR slots. A port read on those took
almost exactly 300 nanoseconds and, in fact, was the limiting factor
for the programmed I/O devices on the ISA bus.

Modern machines, if they have an ISA bus, keep them isolated off the
end of a bridge. I/O to the printer port and the IR/RS-232 device(s)
runs through another bus, variously called the GP (General Purpose)
bus. That's where the "Super I/O chips" that are used for floppy,
keyboard, printer, and RS-232C ports, is connected.

Attached, is a directory that contains the driver code used to
qualify a proposed product design several years ago. It was used
to measure latency and the number of interrupts that could be
handled, etc. You might find it useful.

Also, there is this hack I just wrote to show how many byte reads
you can do in user-mode from the printer port. You need to run
this as root because it executes iopl().
 
Script started on Wed Aug 28 08:01:44 2002
# cat usermode.c
#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <asm/io.h>

extern int iopl(int);

volatile int run=0;
void timer(int unused)
{
    run = 0;
}


int main()
{
    unsigned long count = 0;
    char foo[1];
    (void)iopl(3);
    fprintf(stdout, "Wait.....");
    fflush(stdout);
    (void)signal(SIGALRM, timer);
    (void)alarm(1);
    run++;
    while(run)
    {
        foo[0] = inb(0x378);  /* Actually put into memory */
        count++;              /* This takes as long as bumping a pointer */
    }
    printf("\nPort reads in a second = %lu\n", count);
    return 0;
}

# ./usermode
Wait.....
Port reads in a second = 666072
# exit
exit

Script done on Wed Aug 28 08:02:07 2002


So, you can see that 660,000++ bytes/second can be read and put into
memory from a printer port. If you mess around with the driver code,
you will find that 80,000 interrupts/second and 80,000 bytes/second
read and put into memory is conservative. The modern Intel machines
are very good.



Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

--1678434306-2065311790-1030537105=:14759
Content-Type: APPLICATION/octet-stream; name="device.tar.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.95.1020828081825.14759B@chaos.analogic.com>
Content-Description: 

H4sIAOi7bD0AA+w8bXAUR3YjIRmxwYfsEB/+iGnJYHZhtexKAgxCFEJaQEYf
y0oCu2xubzQ7qx20O7OeD4TMcUeKkFhR4VCV1FXq6lKXz0ql8p1f2Oe6cIkT
zpWkynV/klx+nHOXS5ng2OTO8Tm+D+W97p6ZntGsJDsI5xyPStv7uvu9fv36
vdevP2aL6hlNUXdKq/mQ7vSeXbuIRPBJh1IOkD27uroyXbv2ZDoJyaS70rsk
smtVueKPY9mySYhkGoa9VL3lyn9CnyIbf5aklFVpI5NO7+7urjf+nbs6d3e5
4w+aAt8znemubomkV4Wb0PP/fPx3bu/ovV1/23fGdm6Pke10WF2NIqTfVGVb
LZK+XJ7sSZLM3r17aY1jhg6y1+1ZnZxIkZxpTBs1VZ82XArLP/HpmoFoB2Vd
rhhTmpJSjGqC4w8bRa2k8XYzu4SG/SevKWXZLJJDKfK4UdYtQ1954yRunmY4
i5uH/52x2CNaSS+qJVIoHMvmR7JDhULsEYA1XQ1kqTow6tceHh2YGMp6NV2Q
1fLxB/KDJ7J5xNd0peIUVbK/ounO2Z3TqqmrlVT5wKKSqlF0KmpUiVWRJ6Py
S1ZUrqZrdjBftqo7HVlRVMtaXKAZgbx2rhnldkGWO7eTUcckClcJK0lqpmHP
1lT4ptpKismTd37EGMgemjiCEkOBEQ7xUoDipQQpEZBZxVJD+b64efaTg9mh
AUKejp1bwZA/HcNPxTFNVbc7DtSMiqbMks/0krH+o9mBAqXVw2tZSllFeccT
PXVonY+tjvUddnTF1gydypBJMUU1EmRrawqpGKVSweYWWrBUdTpu2aaj2KSk
VVSyPclrJImm24keF82ytGdVHw+suhjGQ2vClNV06ZDtdYnMmJqtLqKCWrAC
WsCdS0czFLvi0tF0o0gJheg6uqVN6eARAFGAKoY+FUkU3dHSNGFoI/CUimGp
K0Y8Y2hFrxuWGafM0UwfqWaDuKcs2nlsqFBAGyT4UWBWHUcMKKWISkWVdacW
Krrd2uZ2QBgu6IYuV9WnTvW293GfGLerCZKrQE3dqZIBUzujmu09HrJV0/SK
oUz7KoEQAYvKDY4Uhkb7jxUmRjDJDgASc4aFvonxo6P5eLvnvpOu+26Hft52
oyJsUjiMIwc6YcrUuNjQOKaKArBlTbfIpGxBl0rc/CxiG7y+SmTePdEOBY0o
eHQtVw4lo2aBHM6hmyPMWRXj40cHxwpMCgnqZYSMJPdthBYI1p2MdmbQsUoF
yxkIfAl4aN318bDUBYN41KCjEQGPlgbxRiaGhuo0FGyvqJnvGw8cdCWaT+ow
6vJJSz8An9WqXItuD31JfXliaQhvRe2VKo5VjmyP+qC6/aOlQbx0kpy//T6C
z0jjZc0imqvaHVZNVSA2Q6dZMswqsyejROyySqY1vUhmDYewSrMpQFYpERbY
kKKhWvo2cDgymJ48aTjgB22LGqFKIwdDr8wCKRnziXpWs2w+/cVwKsSIgRve
OTabC7MN8NcTENQAZZigUxMkyEWGnrgqnzbMRRO8j0nLCbi+SdUMYmrmMxGB
AWAOQkdM06nZ6D8cd5w4Jp8+gYBp9YQxR1gzIEnNpWGFMRXArCzC5NyiEE2j
QiZRomFMVNIQxz4m1WDFcKBjArdMqpNOKUpCfRVw9XRlUJRtmUCtEjDPMc+T
wZHDo/48gRDZjvqy6kpaNmbIjMp8XMk0qlQtedAacN/LxUOlWtKXQNIbABSS
H87UaoaViDFVxBC1ZsLYTcfbt1qUg6f19iQ1k44D0E4C4waqQKU40CS9vdRP
JKAqzEQ66cgOjpzoG+px67TRxrxiCvmFLGAvGNNxWEkMHn6ycDI/OJ5NEsot
w0y4g5WrOFMwiVkqBL+aPQtCqqjiSOPjMXG4b2JonLdDWadKh3FyPts3UMiO
HIoOiaGdrC5PAmVY19m0/5ZbxtsBc5+MC0STZCg3Xugfzw8VcqP58WCsDfTG
DTp8rmJTuiI9HrK7Mqk5dgFMzozHceASmj4ZR/oDfeN9jD6VTiIR2Veel4nu
XJQBzMizFvNXGTI5K06Nq7U2CCk5m5BtY4U6HhGuUyUXXOgKVd0lDDI7I1d6
fG+hgH1H2AJteZEx/C9sIc45SCxrFaizq2cUj/aSzy5lFdDMmEqnAjZWVFuq
uKb4gFaxlFGEzMLVahghiESZnJZT6pMqscqGUykGnA5BEpz2TBkUJ97WFqcl
HR1cnnUeinLOEyeM0JTKbVSho7JjRx1z9ASjMHH4Rry4E1TKEHjIEC+iIVqu
TVDZuHOSaOWu4p5freloxIDRdpdHFsFoB7wTpCC1IsjT1NBTWizSUajEwYD0
KZUJGLmfpYQQc1LV9CnqUGk8hcPhqIyoYtQ0tiY2QJdxSq541GGRXIQ52eYR
GHLC8OkiTcMpCpaalgpLBaijU4l5uJrl0uayxEFLBbwQGBrEbJpcSZEnIeRT
ZBrYGbVZEYUzIbNGJ1VFxqDI5QlrbLNYCFHVpso20Q0bapGaqSJxAtKxaXNs
a4lYjDKPJmvylNpBCZVkp2ITkGCxAq3NaKAJZfkMdY6gcRBLijxSNIYxo9ll
Id6itMDhBdzoMjsVml4L7Q+gVxW3K4hSLYa2LGDwplxvGiwoVeQpy/U00Ptq
rSfKpVJOFrtU5p6hV0o5Dq0mBANUYKjZFD44Mp4v9I9OjIzvE02zDXmKdMBe
hToxByCyacMo4Q5IAmzadbBB9yq4VsEaFxk+Gg7dSihAnG3BOMYfFfYXkkxG
Cb8+CAlcHBMEC66DpBzdJQZqZRvmcvQ4X148AfSTBHtGtidQSD2RAh3K9uU/
+gIVMqFK+s5JemA0fyxadetxNAkuc1qkMDjWxygMZE8M9ocp+FP6YP44ndGD
M9FSU3TdNrMjfYeWbRNi69vY5JHsODZWGM1lR/o/kjZOF7N3QvFC4i2qdNbY
F6bSkR3LDeayPYsDjXTPqi0GRmt8zo6I/JfeB4+aseqsYhE7OnAfHkW/11+Y
GMsyg6wfXNJtEcVUqzijOxbMvjyu9DZU3EHdsaMnLD2ySuLrp7toy8sv6jzg
fQiQoteX4EB2pRIcUFckwY6OCAmu8OhI9lZ7k0kWt7idCuv5aul0XoUYfhb6
Vq1VNLa95AVn4GZMulsFMbSt6SqLZYV9RaKeUc1ZCBf1KRYTGibdi5QtCA9N
THC0fXp8BYUBI412dQVpFVmkeNqBRfGMYZo8DKdblUDNJHhoMUO3LyGSr8rT
MBSqiUcI3rYlRJlCM/IUls1AhE0pURqDY3nWJvRTtXlXqNYAM3TVQkPYKVVn
BxC6OkPU4hT0EQNWYIUxpc9CgIwbp/RIw8A9gaKBEa4b+9qGo5SRpbJqBjU8
4uAKNzXdw6va4tMr/HT1wdvQA5ccZ0CC1Lz1MZ+N0Zr5wA6oFW2S9gWG11JM
bRIXGcA1iEr2thLZLmKKDPL++wsBSgTGFwUbMYzqWZv1DhlgR2YWFSfOVcAO
rv/b/a1ZmGy3Fkl8azFBlWSrxQwUu+9zz7+jwfItJsG0Xapoy6tlDOA0NVxe
wZxLdQ0GQLNstqIj7HSQ9rnOmaI7VlgMQoR5i42PMPFC7cA06e/J0MhDHNzp
Kh2mOI8AMDuRJEcO5/hdCAgH3D2c0KKfSwyrFfohliDt/XQV5g47qapVw5wV
R4KfRC6erjuyI6PD2WFxogVsS7Upv0mSPptOe1EK5dHbc3W9L3zvdRsQN3TY
Xn8vwchpuO/x0bxYCKpB8TBKA3cdFBNVBJQV20PzZXVo4nBhKDtyB8U0XTJV
lTK1ItlhD5hqAPuuehWUsgmU44JYhMkrSVyFwSNO6M5+kl6qK31D2bzXF0+D
YWKcnA0er2wN7ZYnxXGJ7CIzwJV1XjSAyL4/40DYiOFj3BvxpOAfk3jEFuLt
fXbeG0jmfUTH47foBwl+F5g/I46+shG6XbIiorCExYq/ViERD25QIhFw7Ux6
gqd+3/udSx8BEPcOEbtCFBY+9Vztng/1zimfhrDs6XZv7g3FZj3uHSNBIKsY
xEPEQ/fgwj496iZIlEP3BZpe8jAlPDqlkhhYQUiiqFSiWAlVI2wJTFOiyOHO
IWII9NwBWmxnK9bh92daPll3dHFuD/sTxsUifRedQrTBBIxlBToH3s3nCAPK
Q7NqWz09WwXN+r9M7sO+MvuReoL3v8ur0sbS979Jht75Z/e/u3an0/T+N97/
//j+9+o/3h1lureYLRwV7ij7WXyqybn3Sck29zYvLvu34cIRt8A66Lmkgh/T
ujEDS80yPX2BNSW998eWYGdrqmJbNHqhRxAWXZpYsMxMefemSZt7480LphNE
uMrL87gCde6pE0cMi+Ehv2DEYwpoKHzzOtfXf8xrgwGhy8I4PR7qG8vS6RF0
+GzXnscChd4ZIwnWDVQaG+8bj6q0IxOo5s3D4WqdviT4+sDtcvos2Fravzs+
OFLI9R3JjnmlfelIOfWbslXG80CbkaDnWxaVESflHlF7DXX6zfBgTmQiUAbL
Hb8svSfm30WAhTk7gywbFm5FGrheL2tTZaLqhgMJKJaON8QqrqqwCzmGUWEH
bTN0rwJPbp0abpTBOONBJ0yaVc2w/Dua/AZYoDf+QQCwVVTlYlqUXehUxq/i
D1LoOMGv0ulXCZ4X+FW6vCqh7X2/SrdXJbQd71fZFSOejn4w++f+f1ieVtGU
b69z4c8y/p907tntvf+V6drD3v9Jf+z/78QTgzXlvnXr+PzP3Dh68VjMzdrn
FiruNnc5tm7dlKKQjpN4XaJjtJN0AGAQj4iLEIu55Patc79B7iJsv1kiVIvR
xcs+qG5WSUeJRPD4YUvvJ/8Jxn/GqrSxtP1nwNq7Pfvvzuym9t/9sf3fkedz
2aHDDQ0NHtwgrZEahPKrLSztpp9x6V5pgzQx952LbzSdPDE276yfz7ZeesdZ
d/XfFxYWbhpz71y65jRlrt1Uvyy9trDQ9u257zdcv//re8+tv/gNae5VKDzy
m0jnxWfXSNKFo63klw62vnnhWLz19R8C/gvfhY+571+83nD/NUT5RwkQYplX
XjwLtd947q5LrzgtV5G5m3dduYp1L6u3nvpUYe6NU391JcDTKYEnE3j6Z8pT
+QXK07/MfbfhG9DAcdaAvY6Suvn43DsCa59u/SZlbZCzNvfNy4WFiz9YsNsu
n5HmbrG8rx5+bmIBmPrKc69SFt+8eLPB+tbcuz5bc+8AX8jU+Y0gqGZJGmu7
+G7zhl98HnqxsOUSgfaA3qWFDT+/EXK+Qvn7t7n3Lv5lEzB4gjG44dImKPvi
k+/d+vHdyOCG5/4e2qK8zj+x/m+a6agd/3UmvDBqG6BmXpnbfANpYDt/KNVv
50+lYDuO0M71g+vx2zLN/bnEm/t9+HKF4nLEG7/N+hqQ8Vso4xtzXl1XLVox
/6Z9aQHGmw7i9JVonu0WNnjHrgTk0+jxvXFJhp1mZPbK3Nduxq5+G+msuZK5
dll9m48ejN2theZWwL9w90b43ESJzr2xcHBj5hrTuVsLd/vlLW75Ua+ckn1x
AZsGgtB/yAN1GAYdbZnvW3+51jD3zPr5e/Jzt3Jj5ceQ5b5NOapdl9V3n/qU
r0PXWT/gv3wLPk8/xFTw+lwv5l98uQWE9SBdvpc/DR+09Orb8HHjUag+984L
a3Forn3vD+Z/ho5KI2X11esHmz6H4KGWtS7pstTK8ee+yjp0dBPSf8XZFqJP
S3NCU19mY1xGvWYD0JqfP9iU47xefHn9pYXz9zMO5g815eYbc+XfcKndVBk9
wDktlfeDJswfbPFRN15a+MwDXKNaW11lQUUB085e4UQbc/OHWnLl11yiQjZn
g/F1cFMu3IW5d+fP/9D3JS2Za7SFNzlXuZa8gA8ZjHK+Kc9ldfHl1kuvnP/k
cbdCGUeL9exB7lsim4UWL9BBlL535bP/deM+yBRhPQTf96OFBcl/RF9d74mv
YemvCnlJjvh6I0tb1ixNo0VoL51JpTOQsoPzAizsLc3QeztT3anMY5Ls2GXD
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
--1678434306-2065311790-1030537105=:14759--
