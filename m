Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264847AbRFZBqt>; Mon, 25 Jun 2001 21:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264851AbRFZBqj>; Mon, 25 Jun 2001 21:46:39 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:49866 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S264847AbRFZBq3>; Mon, 25 Jun 2001 21:46:29 -0400
Date: Tue, 26 Jun 2001 10:46:19 +0900
Message-ID: <ithkj9n8.wl@nisaaru.open.nm.fujitsu.co.jp>
From: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
To: Gav <gavbaker@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ac17 "kernel BUG at slab.c:1244!" 
In-Reply-To: <01062215014300.01814@box.penguin.power>
In-Reply-To: <01062215014300.01814@box.penguin.power>
User-Agent: Wanderlust/2.5.8 (Smooth) EMY/1.13.9 (Art is long, life is
 short) SLIM/1.14.7 (=?ISO-2022-JP?B?GyRCPHIwZjpMTD4bKEI=?=) APEL/10.3 MULE
 XEmacs/21.2 (beta46) (Urania) (i386-kondara-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

At Fri, 22 Jun 2001 15:01:43 +0000,
Gav wrote:
> 
> This second one was immediately after rebooting, and hard locked at getty.
> 
> kernel BUG at slab.c:1244!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0126850>]
> EFLAGS: 00010082
> eax: 0000001b   ebx: c187f788   ecx: 00000001   edx: 00002704
> esi: dfa5c000   edi: dfa5c9aa   ebp: 00012800   esp: da801e2c
> ds: 0018   es: 0018   ss: 0018
> Process mingetty (pid: 811, stackpage=da801000)
> Stack: c023d5c5 000004dc dfa5c000 00001000 dfa5c9aa 00000246 00000007 00000001
>        dfa5c000 c0230b4a c030a2e0 00000006 00000406 00000000 c01931dd 00000c3c
>        00000007 00000406 c0193e48 c198df88 00000005 00000000 00000000 dfa5d000
> Call Trace: [<c0230b4a>] [<c01931dd>] [<c0193e48>] [<c0126d9c>] [<c019485e>]
>    [<c012e932>] [<c010fd26>] [<c012eac6>] [<c012db40>] [<c012da69>] 
> [<c0137c5a>]
>    [<c012dd43>] [<c0106ca7>]
>  
> Code: 0f 0b 5d 8b 6b 10 58 81 e5 00 04 00 00 74 4b b8 a5 c2 0f 17
> 
> >>EIP; c0126850 <kmalloc+140/1e0>   <=====
> Trace; c0230b4a <_mmx_memcpy+fa/260>
> Trace; c01931dd <parport_pc_unregister_port+a5d/b90>
> Trace; c0193e48 <tty_hung_up_p+588/1d30>
> Trace; c0126d9c <kfree+1ec/290>
> Trace; c019485e <tty_hung_up_p+f9e/1d30>
> Trace; c012e932 <default_llseek+952/9c0>
> Trace; c010fd26 <do_BUG+246/740>
> Trace; c012eac6 <unregister_chrdev+96/a0>
> Trace; c012db40 <dentry_open+c0/140>
> Trace; c012da69 <filp_open+49/60>
> Trace; c0137c5a <getname+5a/a0>
> Trace; c012dd43 <get_unused_fd+183/220>
> Trace; c0106ca7 <__up_wakeup+10fb/23f4>
> Code;  c0126850 <kmalloc+140/1e0>
> 00000000 <_EIP>:
> Code;  c0126850 <kmalloc+140/1e0>   <=====
>    0:   0f 0b                     ud2a      <=====
> Code;  c0126852 <kmalloc+142/1e0>
>    2:   5d                        pop    %ebp
> Code;  c0126853 <kmalloc+143/1e0>
>    3:   8b 6b 10                  mov    0x10(%ebx),%ebp
> Code;  c0126856 <kmalloc+146/1e0>
>    6:   58                        pop    %eax
> Code;  c0126857 <kmalloc+147/1e0>
>    7:   81 e5 00 04 00 00         and    $0x400,%ebp
> Code;  c012685d <kmalloc+14d/1e0>
>    d:   74 4b                     je     5a <_EIP+0x5a> c01268aa 
> <kmalloc+19a/1e0>
> Code;  c012685f <kmalloc+14f/1e0>
>    f:   b8 a5 c2 0f 17            mov    $0x170fc2a5,%eax
> 
> 
> 1 warning and 1 error issued.  Results may not be reliable.
> 
> This kernel was built with gcc 2.96 on an Athlon 1.33Ghz.
> 
> Hope this is usefull,
> 

I found a bug of release_mem() in tty_io.c and it may cause this
oops. release_mem() frees the memory of tty_struct, but does not
reset tty_files field of tty_struct. So, when fput() was called,
it changes tty_files of already freed tty_struct.



diff -r -u linux.org/drivers/char/tty_io.c linux/drivers/char/tty_io.c
--- linux.org/drivers/char/tty_io.c	Tue Jun 26 09:46:07 2001
+++ linux/drivers/char/tty_io.c	Tue Jun 26 10:00:24 2001
@@ -1024,6 +1024,7 @@
 		}
 		o_tty->magic = 0;
 		(*o_tty->driver.refcount)--;
+		list_del(&o_tty->tty_files);
 		free_tty_struct(o_tty);
 	}
 
@@ -1035,6 +1036,7 @@
 	}
 	tty->magic = 0;
 	(*tty->driver.refcount)--;
+	list_del(&tty->tty_files);
 	free_tty_struct(tty);
 }
 

