Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264531AbUFEHMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbUFEHMn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 03:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUFEHMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 03:12:43 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:3500 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264540AbUFEHMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 03:12:31 -0400
Subject: Too much error in __const_udelay() ?
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: george anzinger <george@mvista.com>, Dominik Brodowski <linux@brodo.de>,
       greg kh <greg@kroah.com>, Chris McDermott <lcm@us.ibm.com>
Content-Type: multipart/mixed; boundary="=-H9K60xAwcVFQULTzdsr6"
Message-Id: <1086419565.2234.133.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 05 Jun 2004 00:12:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-H9K60xAwcVFQULTzdsr6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

[Resending due to lkml bouncing me for having html attachments]

Hey all,
	I've been hunting a bug on one of our systems and it seems to closely
resemble the __delay() issues we saw w/ the ACPI PM time source. 

Earlier when implementing the ACPI PM time source, we found that we
couldn't use the actual ACPI PM time source for the __delay function, or
else various subsystems would break. I chalked it up to the 8Mhz counter
being too low res for some callers of delay(), causing the waits to be
far too long. We backed off to just using the TSC for delay() and things
seemed to get better.

However I've started to see some problems w/ 2.6 and USB on x440/x445s,
both of which use the 100Mhz cyclone time source. Further digging has
pointed to the fact that certain important udelay()s in the USB
subsystem aren't actually waiting long enough. 

So far I've narrowed it down to the scaled math bits in 
__const_udelay() causing too much error for loops_per_jiffy values
around the 100,000 level the cyclone timesource uses. 

To demonstrate this, I wrote the attached demo app using the
__const_udelay code.  For those not wanting to run it themselves, its
output (for HZ=1000) looks like:

  1 usec: LPJ:  100000 __udelay:     0 vs my_udelay:   100
  1 usec: LPJ: 1500000 __udelay:  1000 vs my_udelay:  1500

  2 usec: LPJ:  100000 __udelay:     0 vs my_udelay:   200
  2 usec: LPJ: 1500000 __udelay:  2000 vs my_udelay:  3000

  5 usec: LPJ:  100000 __udelay:     0 vs my_udelay:   500
  5 usec: LPJ: 1500000 __udelay:  7000 vs my_udelay:  7500

 10 usec: LPJ:  100000 __udelay:     0 vs my_udelay:  1000
 10 usec: LPJ: 1500000 __udelay: 14000 vs my_udelay: 15000

 20 usec: LPJ:  100000 __udelay:  1000 vs my_udelay:  2000
 20 usec: LPJ: 1500000 __udelay: 29000 vs my_udelay: 30000

 50 usec: LPJ:  100000 __udelay:  4000 vs my_udelay:  5000
 50 usec: LPJ: 1500000 __udelay: 74000 vs my_udelay: 75000

100 usec: LPJ:  100000 __udelay:  9000 vs my_udelay: 10000
100 usec: LPJ: 1500000 __udelay: 149000 vs my_udelay: 150000



Here you can see __udelay() fails to be even close to accurate until
~50usec and returns zero for values less then 20usec.

I then went and measured the same udelay() values via rdtsc in the
kernel for both the cyclone based delay() as well as the tsc based
delay. The results are attached in the html file. You'll notice this
closely matches the results from the demo app.

This issue hasn't bitten me before w/ 2.4 because (as you can show w/
the demo app) __const_udelay() is more accurate w/ HZ=100. 

I tried replacing __const_udelay w/ my_delay() but it didn't boot
(overflow issues, I'm guessing). 

So I'm no math wiz. What's the proper fix here? 

thanks
-john

--=-H9K60xAwcVFQULTzdsr6
Content-Disposition: attachment; filename=test.c
Content-Type: text/x-c; name=test.c; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#include <stdio.h>

#define MILLION 1000000
#define HZ 1000


unsigned long tsc_freq = 1500000000UL;
unsigned long cyclone_freq = 100000000UL;
unsigned long tsc_lpj = 1500000000UL/HZ;
unsigned long cyclone_lpj = 100000000UL/HZ;
unsigned long LPJ;

unsigned long  __delay(unsigned long loops)
{
	return loops;
}

unsigned long  __const_udelay(unsigned long xloops)
{
	int d0;
	__asm__("mull %0"
		:"=d" (xloops), "=&a" (d0)
		:"1" (xloops),"0" (LPJ));
        return __delay(xloops * HZ);
}

unsigned long  my_udelay(unsigned long usec)
{
	unsigned long cyc_per_usec = (LPJ*HZ)/MILLION;
	return __delay(usec*cyc_per_usec);
}


unsigned long __udelay(unsigned long usecs)
{
	return __const_udelay(usecs * 0x000010c6);  /* 2**32 / 1000000 */
}

unsigned long __ndelay(unsigned long nsecs)
{
	return __const_udelay(nsecs * 0x00005);  /* 2**32 / 1000000000 (rounded up) */
}


int main(void)
{
	unsigned long time[7] = {1,2,5,10,20,50,100};
	int i;
	
	for(i=0;i < 7; i++){
		LPJ=cyclone_lpj;
		printf("%3i usec: LPJ: %7lu __udelay: %5lu vs my_udelay: %5lu\n", 
					time[i], LPJ, __udelay(time[i]), my_udelay(time[i]));
		LPJ=tsc_lpj;
		printf("%3i usec: LPJ: %lu __udelay: %5lu vs my_udelay: %5lu\n", 
					time[i], LPJ, __udelay(time[i]), my_udelay(time[i]));
		printf("\n");
	}

	return 0;
}	

--=-H9K60xAwcVFQULTzdsr6
Content-Disposition: attachment; filename=delay-differences.html.gz
Content-Type: application/x-gzip; name=delay-differences.html.gz
Content-Transfer-Encoding: base64

H4sICExlwUAAA2RlbGF5LWRpZmZlcmVuY2VzLmh0bWwA7Vxbb5tIFH6Of8WUvrTSAnOBARybh3V6
k7JtlHW12qeIwMRGi8ELk6Te1f73Hew0ldsGU/t47FrOQyLAOffznZlzxvSenX0YDP+8eIXeDn87
Rxcffz1/N0CGadt/sIFtnw3PFg8cC9v2q/dG5+TEGEs57dr2/f29dc+sohzZw0v78tXAHMtJ5mC7
kmUaSyuRiRF2evXN+o+IkrBz0pOpzEQ4jK4zUfXsxVWnNxEyQjVdU/x9m971jUGRS5FLczibCgPF
i6u+IcUnadcUT1E8jspKyP6tvDF9oyb9zDSR8ebq4vzjm3fvr15/uLyqRTeQaSoOlZxlAklF7oFK
XFXqv6RE/3ZObhR98yaapNmsq5jdlqkoTzv/dWTyzdOxyO6ETOPoF1RFeWVWokxv6s/G0VSmRd72
HxYfqtJ/RBcRZyrVnVosM8rSUd5FmbiRNdWePRdcKWAvLNi7LpKZ+jMNe7I2IopFllXTKE7zUd/A
xvx6GiXJ/JrVHniQLPx9LIQkPfvzdacny/pXgtCcSd8wQuWSZPnedRT/NSqL2zzpPh8MXqufU3Rd
lIkoTVlMu3Kc5qgqsjRBz/H85/FxrcP3nsNwgacSF7Uh875BDYTu5o5QJAspi4m68XBdK2U0Mvzi
WIKVX1cKEM/irMjFVSKyaPbi5f7Y5vPjMh2NWzty6Z4uI66OOLQ/Zt2JhYxQVvH+hZjuQLUXiNcE
e+088pT5fwTzdNzbPIe/IvTzKviV79fzsxHOcwjJdCLQi9tKxC9bxM5cuE2Ch2zOxAgpBBEXggjB
IPqAUHEBqLQIQoLxioA+Bs8xeFYGT4sCdjCAffAKft+ZW95wbRila4tAqcu3Lkad19jXwoYBIGIL
No4ObYiHPR3O4cSnjrZYbAJUxj3fX5HPu8oUQl0tsUUDHT73qL99lyujOdTRwYcGVAvAEOwyb/th
0CZXnIByf92SpaMmNRQd7MOsFkGcrmwZcIAgrelA4LWiw5f3JWsT4oRDpkUzdLOlTNe7l3IgCrIR
MgpRCBW6MgKyMyMu9WEUwyDVS2nmUq5pd+XiL1Zcq0v0A/3Zp0OrngPMZ2LbD+IggAkaMDowIQNG
hwcMBF45gVzJNYOiz3cHikApDwaKQFh2BMWfddUHtVqDwTcGVKSVXiCLNYVvMMtQ7riQ+/kVAEd3
BnDUgQkox4MJKJg99RHg1ge4hTy7bsZuIoUCN8D2z9OSQLdkmzhp1IlAIGgrnbiLNbHixIPsaq+O
zmbAp0s9ji0A/kbp40Iu7Zu8ArMqbsMJtlXbGNQwhaeV+WBKUyv7wRavzfLHxfRxE3ucGh+QgkDn
mCZpfuw17QEduA68vl7T1ivz9ntNMNNPwK0YzPwSbECpdSvWMGFcG96iT1o6AyCnWuAGjGCtJpD9
DdjJEt2tpt310veu1XSwA0boExZbnTB+K350N9LTS+fcgilM2CEWEFi6xALqqFOYSQH3CIhqLiFc
2zkKToIlM+pdyLk+hQksxoB6zzTAMBKpfPcCmAhlGDsMhpRPKIzJ2yEe9psPjR3m7vzgFYQrX6j+
+tSedHMt5kGegG7sfVpM7fk593Sxc/XNXywQKG7FilgE8sBvYwvZsQjEKhiksRsQSxUXZyl89m02
YmHXCRhjmmZxFmUO15ZQjuVzTPXlL1bWhFilthvVWljbZMZVaeX7VI8h233LTpnaf5RnUens+Ws2
wvXfuEFbvXEDiBlbh5n98E4Re/Gulv8B/KXG5hRGAAA=

--=-H9K60xAwcVFQULTzdsr6--

