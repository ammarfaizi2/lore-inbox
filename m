Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133047AbRAJQ6i>; Wed, 10 Jan 2001 11:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133048AbRAJQ62>; Wed, 10 Jan 2001 11:58:28 -0500
Received: from hermes.mixx.net ([212.84.196.2]:3850 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S133047AbRAJQ6R>;
	Wed, 10 Jan 2001 11:58:17 -0500
Message-ID: <3A5C93E9.A96EF8AE@innominate.de>
Date: Wed, 10 Jan 2001 17:55:05 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hindley <mh15@st-andrews.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 kernel paging error
In-Reply-To: <l03130302b681de2fd7a0@[138.251.135.28]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hindley wrote:
> I am running 2.4.0 final. I got the following failed paging request which
> produced a complete freeze.
> 
> As you can see it was precipitated by cron starting to run some
> housekeeping stuff overnight.
> 
> Has anyone else had prblems?

It looks real.  It was executing this line of clear_inode in fs/inode.c:

380         if (inode->i_sb && inode->i_sb->s_op && inode->i_sb->s_op->clear_inode)
                                                                     ^^^^^^^^^^^^^
                                           and it blew up here ----->

Seemingly, the page the inode's sb->super_block_operations lives on was freed 
between the test of i_sb->s_op and ->s_op->clear_inode.  This gets out of my 
territory.  Other than SMP, I don't see how this can happen.  I reformatted 
your oops (gack, too many timestamps) and provided a disassembly....

Unable to handle kernel paging request at virtual address c4870840
printing eip:
c013d747
*pde = 03d61063
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[clear_inode+159/216]
EFLAGS: 00010282
eax: c4870820   ebx: c338f4a0   ecx: c338f4a8   edx: c1169fa4
esi: c1169fa4   edi: c1dccde8   ebp: c1169fac   esp: c1169f78
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 3, stackpage=c1169000)
Stack: c338f4a0 c013d7bf c338f4a0 c1dccc08 c1dccc00 c013d9c2 c1169fa4 000000ee
       00000004 00000000 000003b3 c2c8fde8 c3e38bc8 00000000 c013d9f1 00000000
       c0126453 00000006 00000004 00000006 00000004 00010f00 c01d32d7 c1168239
Call Trace: [dispose_list+63/88] [prune_icache+234/248] [shrink_icache_memory+33/48] 
            [do_try_to_free_pages+91/128] [kswapd+116/272] [kernel_thread+40/56]
Code: 8b 40 20 85 c0 74 06 53 ff d0 83 c4 04 8b 83 e0 00 00 00 85
 0:   8b 40 20                  mov    0x20(%eax),%eax
 3:   85 c0                     test   %eax,%eax
 5:   74 06                     je     d <_EIP+0xd> 0000000d Before first symbol
 7:   53                        push   %ebx
 8:   ff d0                     call   *%eax
 a:   83 c4 04                  add    $0x4,%esp
 d:   8b 83 e0 00 00 00         mov    0xe0(%ebx),%eax
13:   85 00                     test   %eax,(%eax)                                                                                          

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
