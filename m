Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265636AbUBKPVs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 10:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265684AbUBKPVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 10:21:47 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4996 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265636AbUBKPVo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 10:21:44 -0500
Date: Wed, 11 Feb 2004 10:23:38 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: wdebruij@dds.nl
cc: sting sting <zstingx@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: printk and long long 
In-Reply-To: <1076506513.402a2f9120fb8@webmail.dds.nl>
Message-ID: <Pine.LNX.4.53.0402111021160.18798@chaos>
References: <Sea2-F7mFkwDjKqc3eQ0001c385@hotmail.com> <1076506513.402a2f9120fb8@webmail.dds.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Feb 2004 wdebruij@dds.nl wrote:

> how about simply using a shift to output two regular longs, i.e.
>
> printk("%ld%ld",loff_t >> (sizeof(long) * 8), loff_t << sizeof(long) * 8 >>
> sizeof(long) * 8);
>
> perhaps you could even place this ghastly code in a macro if you have to access
> it often (so that you don't have to look at it :)?
>
> I know it's not pretty, but at least the %ld is considered standard printf
> functionality. I don't think %lld (even if it is implemented in some printf
> derivates) can be considered portable.
>
> Willem
> Citeren sting sting <zstingx@hotmail.com>:
>
> > Hello,
> > I am trying to perfrom printk with a variable of type long long.
> > (loff_t is that type and it is long long , as can be seen in
> > posix+types.h).
> > what is the format string for such a type ?
> > I had tried %lld" but it gace wrpng results.
> > regards,
> > sting

This is probably portable. I could do it much simpler in
assembly but it wouldn't be portable.

Printing both unsigned long long and signed long long.




#include <stdio.h>

unsigned long long tester0 = 12345678901234567890ULL;
unsigned long long tester1 = 0xffffffffffffffff;


char *ulltoa(char *buf, unsigned long long val)
{
    char tmp[0x20];
    char *cp = tmp;
    char *rp = buf;
    do {
            *cp++ = (char) (val%10ULL) + '0';
            val /= 10ULL;
       } while (val);
    do {
           *buf++ = *(--cp);
       } while (cp != tmp);
    *buf = 0x00;
    return rp;
}

char *lltoa(char *buf, long long val)
{
   char *cp = buf;
   if(val < 0) {
        *cp++ = (char) '-';
        val = ~val + 1LL;
   }
   (void) ulltoa(cp, (unsigned long)val);
   return buf;
}

int main()
{
    char buf[0x100];

    printf("%llu\n", 0ULL);
    printf("%llu\n", tester0);
    printf("%llu\n", tester1);
    printf("%s\n", ulltoa(buf, 0ULL));
    printf("%s\n", ulltoa(buf, tester0));
    printf("%s\n", ulltoa(buf, tester1));
    printf("%s\n", lltoa(buf, tester1));

    return 0;
}



Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


