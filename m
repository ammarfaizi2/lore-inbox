Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317793AbSHZCF5>; Sun, 25 Aug 2002 22:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317799AbSHZCF5>; Sun, 25 Aug 2002 22:05:57 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:44002 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317793AbSHZCF4>; Sun, 25 Aug 2002 22:05:56 -0400
Date: Sun, 25 Aug 2002 19:08:59 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Steven Cole <elenstev@mesatop.com>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: MM patches against 2.5.31
Message-ID: <17830228.1030302537@[10.10.2.3]>
In-Reply-To: <3D698F4E.93A3DDA2@zip.com.au>
References: <3D698F4E.93A3DDA2@zip.com.au>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > kjournald: page allocation failure. order:0, mode:0x0
>> 
>> I've seen this before, but am curious how we ever passed
>> a gfpmask (aka mode) of 0 to __alloc_pages? Can't see anywhere
>> that does this?
> 
> Could be anywhere, really.  A network interrupt doing GFP_ATOMIC
> while kjournald is executing.  A radix-tree node allocation 
> on the add-to-swap path perhaps.  (The swapout failure messages
> aren't supposed to come out, but mempool_alloc() stomps on the
> caller's setting of PF_NOWARN.)
> 
> Or:
> 
> mnm:/usr/src/25> grep -r GFP_ATOMIC drivers/scsi/*.c | wc -l
>      89

No, GFP_ATOMIC is not 0:

#define __GFP_HIGH  0x20    /* Should access emergency pools? */
#define GFP_ATOMIC  (__GFP_HIGH)

Looking at all the options:

#define __GFP_WAIT  0x10    /* Can wait and reschedule? */
#define __GFP_HIGH  0x20    /* Should access emergency pools? */
#define __GFP_IO    0x40    /* Can start low memory physical IO? */
#define __GFP_HIGHIO    0x80    /* Can start high mem physical IO? */
#define __GFP_FS    0x100   /* Can call down to low-level FS? */

What worries me is that 0 seems to mean "you can't do anything
to try and free it, but you can't access the emergency pools either".
Seems doomed to failure to me. And the standard sets we have are

#define GFP_NOHIGHIO    (             __GFP_WAIT | __GFP_IO)
#define GFP_NOIO    (             __GFP_WAIT)
#define GFP_NOFS    (             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO)
#define GFP_ATOMIC  (__GFP_HIGH)
#define GFP_USER    (             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
#define GFP_HIGHUSER    (             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS | __GFP_HIGHMEM)
#define GFP_KERNEL  (             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
#define GFP_NFS     (             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
#define GFP_KSWAPD  (             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)

So I think someone's screwed something up, and this is accidental.
Or I'm just totally misunderstanding this, which is perfectly 
possible.

M.

