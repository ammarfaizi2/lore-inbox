Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316235AbSHAR6C>; Thu, 1 Aug 2002 13:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316289AbSHAR6C>; Thu, 1 Aug 2002 13:58:02 -0400
Received: from [195.223.140.120] ([195.223.140.120]:47668 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316235AbSHAR6A>; Thu, 1 Aug 2002 13:58:00 -0400
Date: Thu, 1 Aug 2002 20:01:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc4aa1
Message-ID: <20020801180105.GD1141@dualathlon.random>
References: <20020801055124.GB1132@dualathlon.random> <20020801141703.GT1132@dualathlon.random> <20020801142623.GA4606@junk.cps.unizar.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020801142623.GA4606@junk.cps.unizar.es>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 04:26:23PM +0200, J.A. Magallon wrote:
> 
> On 20020801 Andrea Arcangeli wrote:
> > On Thu, Aug 01, 2002 at 07:51:24AM +0200, Andrea Arcangeli wrote:
> > > This may be the last update for a week (unless there's a quick bug to
> > > fix before next morning :). I wanted to ship async-io and largepage
> > 
> > I would like to thank Randy Hron for reproducing this problem so
> > quickly with the ltp testsuite:
> > 
> > >>EIP; 80132cc2 <shmem_writepage+22/130>   <=====
> > 
> 
> Can be related to this (which I get on every shm related op, like a pipe in
> bzip2 -cd | patch -p1 ):
> 
> kernel BUG at page_alloc.c:98!
> invalid operand: 0000 2.4.19-rc5-jam0 #1 SMP Thu Aug 1 12:28:09 CEST 2002
			^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ I love it :)
> CPU:    0
> EIP:    0010:[__free_pages_ok+87/752]    Tainted: P 
> EIP:    0010:[<8013d227>]    Tainted: P 
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00210286
> eax: 00000000   ebx: 81128b10   ecx: 81128b10   edx: 00000000
> esi: 8631fe74   edi: 00000000   ebp: 00000000   esp: 874e1f08
> ds: 0018   es: 0018   ss: 0018
> Process bonobo-moniker- (pid: 2103, stackpage=874e1000)
> Stack: 00000000 8631fee4 8631fee8 00000115 00000000 00000000 8631fdc0 00000115 
>        00000115 00000000 8631fdc0 80141c8b 874e1f3c 81128b10 2b331000 00000000 
>        00000000 00001000 80141d6b 86fcb660 86fcb680 874e1f60 00000115 00000eeb 
> Call Trace:    [do_shmem_file_read+299/432] [shmem_file_read+91/128] [sys_read+150/272] [system_call+51/56]
> Call Trace:    [<80141c8b>] [<80141d6b>] [<801454b6>] [<80108e4b>]
> Code: 0f 0b 62 00 7d 55 27 80 8b 0d 10 50 32 80 89 d8 29 c8 69 c0 
> 
> 
> >>EIP; 8013d227 <__free_pages_ok+57/2f0>   <=====

this is another issue, here the fix:

--- 2.4.19rc5aa1/mm/shmem.c.~1~	Thu Aug  1 17:04:45 2002
+++ 2.4.19rc5aa1/mm/shmem.c	Thu Aug  1 19:56:38 2002
@@ -1178,8 +1178,6 @@ static void do_shmem_file_read(struct fi
 			__free_page(page);
 		else
 			page_cache_release(page);
-	
-		page_cache_release(page);
 	}
 
 	*ppos = ((loff_t) index << page_shift) + offset;

Andrea
