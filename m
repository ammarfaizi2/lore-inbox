Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUCZIMs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 03:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263925AbUCZIMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 03:12:48 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:43209 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263978AbUCZIMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 03:12:45 -0500
Date: Thu, 25 Mar 2004 23:14:12 -0800
From: Paul Jackson <pj@sgi.com>
To: Keith Owens <kaos@sgi.com>
Cc: wli@holomorphy.com, colpatch@us.ibm.com, linux-kernel@vger.kernel.org,
       mbligh@aracnet.com, akpm@osdl.org, haveblue@us.ibm.com
Subject: Re: [PATCH] nodemask_t x86_64 changes [5/7]
Message-Id: <20040325231412.2a3d1c15.pj@sgi.com>
In-Reply-To: <6562.1080277594@kao2.melbourne.sgi.com>
References: <20040323201101.3427494c.pj@sgi.com>
	<6562.1080277594@kao2.melbourne.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> CPU_MASK_ALL ...

Yup - now you tell me ... ;).

I just got done figuring it out in a slightly variant way ... ('nbits'
is NR_CPUS or similar):

#define MASK_LAST_WORD(nbits)                                           \
(                                                                       \
        ((nbits) % BITS_PER_LONG) ?                                     \
                (1<<((nbits) % BITS_PER_LONG))-1 : ~0UL                 \
)

#define MASK_ALL(nbits)                                                 \
{ {                                                                     \
        [0 ... BITS_TO_LONGS(nbits)-1] = ~0UL,                          \
        [BITS_TO_LONGS(nbits)-1] = MASK_LAST_WORD(nbits)                \
} }

This way overwrites the last word of the mask, first putting ~0UL
in all words, then however many bits are needed in the last word.

Does your way work if NR_CPUS is less than BITS_PER_LONG?
Won't gcc complain upon seeing something like, for say
NR_CPUS = 4 on a 32 bit system:

   { [ 0 ... -1 ] = ~0UL, ~0UL << 28 }

with the errors and warnings:

  error: empty index range in initializer
  warning: excess elements in struct initializer

and shouldn't the last word be inverted: ~(~0UL << NR_CPUS_UNDEF) ?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
