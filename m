Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270257AbRIJKRC>; Mon, 10 Sep 2001 06:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270381AbRIJKQw>; Mon, 10 Sep 2001 06:16:52 -0400
Received: from mons.uio.no ([129.240.130.14]:38304 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S270257AbRIJKQn>;
	Mon, 10 Sep 2001 06:16:43 -0400
To: Olivier Molteni <olivier@molteni.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Francis Galiegue <fg@mandrakesoft.com>
Subject: Re: Oops NFS Locking in 2.4.x
In-Reply-To: <3B9C0D36.3EA20B24@molteni.net>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 10 Sep 2001 12:16:55 +0200
In-Reply-To: Olivier Molteni's message of "Mon, 10 Sep 2001 02:45:42 +0200"
Message-ID: <shsae03fizs.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Olivier Molteni <olivier@molteni.net> writes:


     > Unable to handle kernel NULL pointer dereference at virtual
     > address 00000000 c013d6e7 *pde = 00000000 Oops: 0000 CPU: 0
     > EIP: 0010:[<c013d6e7>] Using defaults from ksymoops -t
     > elf32-i386 -a i386 EFLAGS: 00010296 eax: 00000000 ebx: 00000000
     > ecx: 00000000 edx: f7d77960 esi: 00000004 edi: 00000001 ebp:
     > bfffdb2c esp: c626ff74 ds: 0018 es: 0018 ss: 0018 Process
     > cyrdeliver (pid: 15652, stackpage=c626f000) Stack: f7d77960
     > ed00eac0 c013f048 f7d77960 00000000 ecc895c0 00000000 c012e3f5
     >        ecc895c0 ed00eac0 00000000 ecc895c0 00000000 ecc895c0
     >        bfffbb2c
     > c012e447
     >        ecc895c0 ed00eac0 c626e000 c0106d2b 00000004 00000004
     >        bfffcb2c
     > bfffbb2c Call Trace: [<c013f048>] [<c012e3f5>] [<c012e447>]
     > [<c0106d2b>] Code: 8b 03 89 02 c7 03 00 00 00 00 8b 56 04 8b 43
     > 04 89 50 04 89

    >>> EIP; c013d6e7 <locks_delete_lock+b/e8> <=====
     > Trace; c013f048 <locks_remove_posix+58/6c> Trace; c012e3f5
     > <filp_close+55/64> Trace; c012e447 <sys_close+43/54> Trace;
     > c0106d2b <system_call+33/38> Code; c013d6e7
     > <locks_delete_lock+b/e8> 00000000 <_EIP>: Code; c013d6e7
     > <locks_delete_lock+b/e8> <=====
     >    0: 8b 03 mov (%ebx),%eax <=====
     > Code; c013d6e9 <locks_delete_lock+d/e8>
     >    2: 89 02 mov %eax,(%edx)
     > Code; c013d6eb <locks_delete_lock+f/e8>
     >    4: c7 03 00 00 00 00 movl $0x0,(%ebx)
     > Code; c013d6f1 <locks_delete_lock+15/e8>
     >    a: 8b 56 04 mov 0x4(%esi),%edx
     > Code; c013d6f4 <locks_delete_lock+18/e8>
     >    d: 8b 43 04 mov 0x4(%ebx),%eax
     > Code; c013d6f7 <locks_delete_lock+1b/e8>
     >   10: 89 50 04 mov %edx,0x4(%eax)
     > Code; c013d6fa <locks_delete_lock+1e/e8>
     >   13: 89 00 mov %eax,(%eax)


Looks like 2 processes are trying to free the same lock. The problem
is that both processes can call filp_close() at the same
time (by calling sys_close()).

The bug boils down to:

   -  locks_unlock_delete() assumes that the BKL (kernel_lock()) is
      sufficient to protect against *thisfl_p from disappearing
      beneath it due to some second process.
BUT
   -  The call to lock() in locks_unlock_delete() sleeps when the
      underlying filesystem is NFS, hence 2 processes can race despite
      the BKL assumption.

Cheers,
   Trond
