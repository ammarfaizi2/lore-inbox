Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269428AbRHQB4G>; Thu, 16 Aug 2001 21:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269421AbRHQBzq>; Thu, 16 Aug 2001 21:55:46 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:11013 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S269413AbRHQBzn>; Thu, 16 Aug 2001 21:55:43 -0400
Message-ID: <3B7C7846.FD9DEE68@zip.com.au>
Date: Thu, 16 Aug 2001 18:49:58 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Jeff Dike <jdike@karaya.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Daniel Phillips <phillips@bonn-fries.net>,
        "David S. Miller" <davem@redhat.com>, tpepper@vato.org,
        f5ibh@db0bm.ampr.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [PATCH]
In-Reply-To: <200108170146.UAA05171@ccure.karaya.com>,
		<Your message of "Fri, 17 Aug 2001 00:35:02 +0100." <5.1.0.14.2.20010817002825.00b1e4e0@pop.cus.cam.ac.uk> <5.1.0.14.2.20010817015007.045689b0@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> 
> #define min(x,y) \
>          ({ typeof(x) __x = (x); typeof(y) __y = (y); __x < __y ? __x : __y; })
> 
> int test(int a, int b, int c)
> {
>          return min(a, min(b, c));
> }

Problems occur if the caller happens to pass in variables whose
names confilct with the ones you chose in the above macro:

laptop:/home/akpm> cat t.c
#define min(x,y) \
         ({ typeof(x) __x = (x); typeof(y) __y = (y); __x < __y ? __x : __y; })

int test(int __x, int __y)
{
        return min(__x, __y);		/* sic */
}

main()
{
        printf("%d\n", test(1, 2));
        printf("%d\n", test(2, 1));
}
laptop:/home/akpm> gcc t.c
laptop:/home/akpm> ./a.out
-1073744344
1074305684


So if you replace "__x" with "__dont_use_this_identifier_its_reserved_for_min"
I don't expect anyone could sensibly complain...

-
