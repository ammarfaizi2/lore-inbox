Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264901AbSLGXal>; Sat, 7 Dec 2002 18:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264915AbSLGXal>; Sat, 7 Dec 2002 18:30:41 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:37106 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S264901AbSLGXae>;
	Sat, 7 Dec 2002 18:30:34 -0500
Date: Sun, 8 Dec 2002 00:37:46 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@digeo.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [RFC][PATCH] net drivers and cache alignment
Message-ID: <20021207233745.GE3183@werewolf.able.es>
References: <3DF2781D.3030209@pobox.com> <20021207.144004.45605764.davem@redhat.com> <3DF27EE7.4010508@pobox.com> <3DF2844C.F9216283@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3DF2844C.F9216283@digeo.com>; from akpm@digeo.com on Sun, Dec 08, 2002 at 00:29:16 +0100
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.12.08 Andrew Morton wrote:
>Jeff Garzik wrote:
>> 
>> David S. Miller wrote:
>> > Can't the cacheline_aligned attribute be applied to individual
>> > struct members?  I remember doing this for thread_struct on
>> > sparc ages ago.
>> 
>> Looks like it from the 2.4 processor.h code.
>> 
>> Attached is cut #2.  Thanks for all the near-instant feedback so far :)
>>   Andrew, does the attached still need padding on SMP?
>

What do you all think about this:

#include <stdio.h>

#define CACHE_LINE_SIZE 128
#define ____cacheline_aligned __attribute__((__aligned__(CACHE_LINE_SIZE)))

#define __cacheline_start   struct { } ____cacheline_aligned;

#define offsetof(t, m)  ((int)(&((t *)0)->m))

struct S {
    __cacheline_start

    int x;

    __cacheline_start

    int y;
    int z;
};

int main()
{
    struct S s;

    printf("%d\n",sizeof(struct S));
    printf("%d\n",offsetof(struct S,x));
    printf("%d\n",offsetof(struct S,y));
    printf("%d\n",offsetof(struct S,z));
}

werewolf:~> vi kk.c
werewolf:~> kk
256
0
128
132

So you don't have to modify any field, just put __cacheline_start where
needed ? (and does not add any extra sizeof(int) overhead).

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-jam1 (gcc 3.2 (Mandrake Linux 9.1 3.2-4mdk))
