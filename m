Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289768AbSAWK0x>; Wed, 23 Jan 2002 05:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289770AbSAWK0n>; Wed, 23 Jan 2002 05:26:43 -0500
Received: from pizda.ninka.net ([216.101.162.242]:56449 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289768AbSAWK02>;
	Wed, 23 Jan 2002 05:26:28 -0500
Date: Wed, 23 Jan 2002 02:24:41 -0800 (PST)
Message-Id: <20020123.022441.21593293.davem@redhat.com>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org, andrea@suse.de, alan@redhat.com,
        akpm@zip.com.au, vherva@niksula.hut.fi
Subject: Re: Athlon/AGP issue update
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200201231010.g0NAAuE05886@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <1011779573.9368.40.camel@inventor.gentoo.org>
	<200201231010.g0NAAuE05886@Port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
   Date: Wed, 23 Jan 2002 12:10:57 -0200

   Did AMD tell in what 4M page a cache line was speculativery read ant then 
   written? I mean, there are only a few 4M pages used by Linux, which one had 
   'cacheable' bit wrongly set? It's all we need to know now.
   
See my other email, actually it appears AMD tells us this and my
previous analysis was wrong.

   > The problem that has been experienced is caused by a speculative store
   > instruction that is not ultimately executed.  The logical address of the
   > store is through the 4MB translation to physical memory also translated
   > by GART and used by the AGP processor.
   >
   > The effect of the store is to write-allocate a cache line in the data
   > cache and fill that cache line with data from the underlying physical
   > memory. Because the line was write-allocated it is subsequently written
   > back to physical memory even though the bits have not been changed by
   > the processor.  This write-back occurs when the cache-line is
   > re-allocated based upon replacement policy and is far removed in time
   > from the point at which the bits were read.
   
He can only mean by this that there is some branch protected store
(not taken) to the 4MB linear mappings used by the kernel (starting
at PAGE_OFFSET).

But the only thing I am still confused about, is what 4MB mappings
have to do with any of this.  What I take from the description is that
the problem will still exist after 4MB mappings are disabled.  What
prevents the processor from doing the speculative store to the
cacheable mappings once 4MB pages are disabled?

At best, I bet turning off 4MB pages makes the bug less likely.
It does not eliminate the chance to hit the bug.

So what it sounds like is that if there is any cacheable mapping
_WHATSOEVER_ to physical memory accessible by the GART, the problem
can occur due to a speculative store being cancelled.

A real fix would be much more involved, therefore.

In fact, we map the GART mapped memory to the user fully cacheable.
That would have to be fixed, plus we'd need to mark non-cacheable the
linear PAGE_OFFSET mappings of the kernel (4MB or not) as well.
