Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264888AbSLGXVp>; Sat, 7 Dec 2002 18:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264889AbSLGXVp>; Sat, 7 Dec 2002 18:21:45 -0500
Received: from packet.digeo.com ([12.110.80.53]:42207 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264888AbSLGXVo>;
	Sat, 7 Dec 2002 18:21:44 -0500
Message-ID: <3DF2844C.F9216283@digeo.com>
Date: Sat, 07 Dec 2002 15:29:16 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [RFC][PATCH] net drivers and cache alignment
References: <3DF2781D.3030209@pobox.com> <20021207.144004.45605764.davem@redhat.com> <3DF27EE7.4010508@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Dec 2002 23:29:17.0171 (UTC) FILETIME=[75D7DC30:01C29E48]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> David S. Miller wrote:
> > Can't the cacheline_aligned attribute be applied to individual
> > struct members?  I remember doing this for thread_struct on
> > sparc ages ago.
> 
> Looks like it from the 2.4 processor.h code.
> 
> Attached is cut #2.  Thanks for all the near-instant feedback so far :)
>   Andrew, does the attached still need padding on SMP?

It needs padding _only_ on SMP.  ____cacheline_aligned_in_smp.

#define offsetof(t, m)  ((int)(&((t *)0)->m))

struct foo {
        int a;
        int b __attribute__((__aligned__(1024)));
        int c;
} foo;

main()
{
        printf("%d\n", sizeof(struct foo));
        printf("%d\n", offsetof(struct foo, a));
        printf("%d\n", offsetof(struct foo, b));
        printf("%d\n", offsetof(struct foo, c));
}

./a.out
2048
0
1024
1028

So your patch will do what you want it to do.  You should just tag the
first member of a group with ____cacheline_aligned_in_smp, and keep an
eye on things with offsetof().

Not sure why sizeof() returned 2048 though.
