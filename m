Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129681AbQLBQGQ>; Sat, 2 Dec 2000 11:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129450AbQLBQGG>; Sat, 2 Dec 2000 11:06:06 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:25107 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129681AbQLBQGB>;
	Sat, 2 Dec 2000 11:06:01 -0500
Date: Sat, 2 Dec 2000 16:35:11 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: andrewm@uow.edu.au
Cc: sct@redhat.com, viro@math.psu.edu, jonathan@daria.co.uk,
        linux-kernel@vger.kernel.org
Subject: Re: corruption
Message-ID: <20001202163511.A8170@vana.vc.cvut.cz>
In-Reply-To: <20001202161158.A475@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001202161158.A475@ppc.vc.cvut.cz>; from vandrove@vc.cvut.cz on Sat, Dec 02, 2000 at 04:11:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Andrew Morton wrote:
> > 
> > actual assertion in destroy_inode() which is a little bogus.
> > 
> > But the wierd thing is that this BUG only hit a single time,
> > after three hours of intensive testing.  If my theory is
> > right, the BUG should hit every time.   Will investigate further...
> > 
> 
> It appears that this problem is not fixed.
> 
> My destroy_inode() is now
> 
> static void destroy_inode(struct inode *inode)
> {
>         if (!list_empty(&inode->i_dirty_buffers)) {
>                 printk("&inode->i_dirty_buffers=0x%p\n", &inode->i_dirty_buffers);
>                 printk("next=0x%p\n", inode->i_dirty_buffers.next);
>                 printk("prev=0x%p\n", inode->i_dirty_buffers.prev);
>                 BUG();
>         }
>         kmem_cache_free(inode_cachep, (inode));
> }

I used do { if (inode_has_buffers(inode)) { printstate(); } kmem_cache_free.... } while (0)

and machine complained very loudly during boot...

> This is 2.4.0-test11-pre3 + list_del patch + sct's inode
> patch (buffer.c, inode.c).  x86 dual processor.  gcc 2.91.66.
> I rediffed my tree.  No rogue patches.

test12-pre3, NULL in list_del, destroy_inode as above, UP, 2.95.2

So I thought that adding fsync_inode_buffers() added into iput() just below
atomic_dec_and_lock(&inode->i_count...) would be good idea. It is not, bug
was still trigerred. So there are oopses... I removed disassembled code,
as it is same for all oopses (as my printstate dumps itself).

Before fsync_inode_buffers() it was almost same, there were also traces
through sys_close() in additon to this. But maybe that I just did not
trigger this code path during testing.

I think that buffer_insert_inode_queue and __remove_inode_queue should
also do iget() and iput(), but maybe I'm wrong.

And I have no idea why fsync_inode_buffers() does not work. I thought that
inode should not have any buffers attached after this function returns if 
inode use count was zero... Maybe it is a bit complicated when inode
is going to cease...
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz


ksymoops 2.3.4 on i686 2.4.0-test9-smp.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k none (specified)
     -l none (specified)
     -o /lib/modules/2.4.0-test12-pre3-smp/ (specified)
     -m /boot/System.map (specified)

Error (regular_file): read_ksyms stat none failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
CPU:    0
EIP:    0010:[<c010b9b5>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000202
eax: 00000001   ebx: c13fe9a0   ecx: c022ce90   edx: c13fe9b8
esi: c022f500   edi: c7d940a0   ebp: c7d69fbc   esp: c7d69f38
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 34, stackpage=c7d69000)
Stack: c7d69f3c c0140018 c01475b5 c13ffd40 c13fe9a0 c0145296 c13fe9a0 c7d68000 
       00000000 c01400b2 c13ffd40 c7d68000 08058fd0 08059930 c123d920 c13ffd40 
       c123d920 c7d12000 c7f45000 c123d920 c7f7b8c0 c7d12005 00000004 0006a272 
Call Trace: [<c0140018>] [<c01475b5>] [<c0145296>] [<c01400b2>] [<c010b513>] 
Code: 50 1e 06 50 55 57 56 52 51 53 89 e0 50 e8 a9 fe ff ff 83 c4 

>>EIP; c010b9b5 <printstate+9/2c>   <=====
Trace; c0140018 <sys_rename+154/270>
Trace; c01475b5 <iput+1a1/1b4>
Trace; c0145296 <dput+116/174>
Trace; c01400b2 <sys_rename+1ee/270>
Trace; c010b513 <system_call+33/38>
Code;  c010b9b5 <printstate+9/2c>
0000000000000000 <_EIP>:
Code;  c010b9b5 <printstate+9/2c>   <=====
   0:   50                        push   %eax   <=====
Code;  c010b9b6 <printstate+a/2c>
   1:   1e                        push   %ds
Code;  c010b9b7 <printstate+b/2c>
   2:   06                        push   %es
Code;  c010b9b8 <printstate+c/2c>
   3:   50                        push   %eax
Code;  c010b9b9 <printstate+d/2c>
   4:   55                        push   %ebp
Code;  c010b9ba <printstate+e/2c>
   5:   57                        push   %edi
Code;  c010b9bb <printstate+f/2c>
   6:   56                        push   %esi
Code;  c010b9bc <printstate+10/2c>
   7:   52                        push   %edx
Code;  c010b9bd <printstate+11/2c>
   8:   51                        push   %ecx
Code;  c010b9be <printstate+12/2c>
   9:   53                        push   %ebx
Code;  c010b9bf <printstate+13/2c>
   a:   89 e0                     mov    %esp,%eax
Code;  c010b9c1 <printstate+15/2c>
   c:   50                        push   %eax
Code;  c010b9c2 <printstate+16/2c>
   d:   e8 a9 fe ff ff            call   fffffebb <_EIP+0xfffffebb> c010b870 <show_registers+0/13c>
Code;  c010b9c7 <printstate+1b/2c>
  12:   83 c4 00                  add    $0x0,%esp

CPU:    0
EIP:    0010:[<c010b9b5>]
EFLAGS: 00000202
eax: 00000001   ebx: c7c5cb40   ecx: c022ce90   edx: c7c5cb58
esi: c022f500   edi: c7f3d4e0   ebp: c132a460   esp: c7d69f4c
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 34, stackpage=c7d69000)
Stack: c7d69f50 c0140018 c01475b5 c132a460 c7c5cb40 c0145df8 c7c5cb40 c7d68000 
       00000000 c013f110 c132a460 c132a460 c132a460 c7f45000 c7d69fa4 c013f1e7 
       c7f3d4e0 c132a460 c7d68000 08058fd0 08059930 bffffb8c c123d920 c7f7b8c0 
Call Trace: [<c0140018>] [<c01475b5>] [<c0145df8>] [<c013f110>] [<c013f1e7>] [<c010b513>] 
Code: 50 1e 06 50 55 57 56 52 51 53 89 e0 50 e8 a9 fe ff ff 83 c4 

>>EIP; c010b9b5 <printstate+9/2c>   <=====
Trace; c0140018 <sys_rename+154/270>
Trace; c01475b5 <iput+1a1/1b4>
Trace; c0145df8 <d_delete+60/a8>
Trace; c013f110 <vfs_unlink+160/190>
Trace; c013f1e7 <sys_unlink+a7/120>
Trace; c010b513 <system_call+33/38>
Code;  c010b9b5 <printstate+9/2c>

CPU:    0
EIP:    0010:[<c010b9b5>]
EFLAGS: 00000202
eax: 00000001   ebx: c7c5cb40   ecx: c022ce90   edx: c7c5cb58
esi: c022f500   edi: c7f3d4e0   ebp: c132a460   esp: c7d69f4c
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 35, stackpage=c7d69000)
Stack: c7d69f50 c0140018 c01475b5 c132a460 c7c5cb40 c0145df8 c7c5cb40 c7d68000 
       00000000 c013f110 c132a460 c132a460 c132a460 c7f45000 c7d69fa4 c013f1e7 
       c7f3d4e0 c132a460 c7d68000 08058f60 08052c71 00000000 c123d920 c7f7b8c0 
Call Trace: [<c0140018>] [<c01475b5>] [<c0145df8>] [<c013f110>] [<c013f1e7>] [<c010b513>] 
Code: 50 1e 06 50 55 57 56 52 51 53 89 e0 50 e8 a9 fe ff ff 83 c4 

>>EIP; c010b9b5 <printstate+9/2c>   <=====
Trace; c0140018 <sys_rename+154/270>
Trace; c01475b5 <iput+1a1/1b4>
Trace; c0145df8 <d_delete+60/a8>
Trace; c013f110 <vfs_unlink+160/190>
Trace; c013f1e7 <sys_unlink+a7/120>
Trace; c010b513 <system_call+33/38>
Code;  c010b9b5 <printstate+9/2c>

CPU:    0
EIP:    0010:[<c010b9b5>]
EFLAGS: 00000202
eax: 00000001   ebx: c7ad0ce0   ecx: c022ce90   edx: c7ad0cf8
esi: c022f500   edi: c7ad0e60   ebp: c7d6c3e0   esp: c7c07f4c
ds: 0018   es: 0018   ss: 0018
Process ksymoops (pid: 41, stackpage=c7c07000)
Stack: c7c07f50 c0140018 c01475b5 c7d6c3e0 c7ad0ce0 c0145df8 c7ad0ce0 c7c06000 
       00000000 c013f110 c7d6c3e0 c7d6c3e0 c7d6c3e0 c7f45000 c7c07fa4 c013f1e7 
       c7ad0e60 c7d6c3e0 c7c06000 400165a4 bffffd4c bffffc54 c7d84420 c7f7b8c0 
Call Trace: [<c0140018>] [<c01475b5>] [<c0145df8>] [<c013f110>] [<c013f1e7>] [<c010b513>] 
Code: 50 1e 06 50 55 57 56 52 51 53 89 e0 50 e8 a9 fe ff ff 83 c4 

>>EIP; c010b9b5 <printstate+9/2c>   <=====
Trace; c0140018 <sys_rename+154/270>
Trace; c01475b5 <iput+1a1/1b4>
Trace; c0145df8 <d_delete+60/a8>
Trace; c013f110 <vfs_unlink+160/190>
Trace; c013f1e7 <sys_unlink+a7/120>
Trace; c010b513 <system_call+33/38>
Code;  c010b9b5 <printstate+9/2c>

CPU:    0
EIP:    0010:[<c010b9b5>]
EFLAGS: 00000202
eax: 00000001   ebx: c7ad0ce0   ecx: c022ce90   edx: c7ad0cf8
esi: c022f500   edi: c7ad0e60   ebp: c7d844a0   esp: c7c07f4c
ds: 0018   es: 0018   ss: 0018
Process ksymoops (pid: 41, stackpage=c7c07000)
Stack: c7c07f50 c0140018 c01475b5 c7d844a0 c7ad0ce0 c0145df8 c7ad0ce0 c7c06000 
       00000000 c013f110 c7d844a0 c7d844a0 c7d844a0 c7f45000 c7c07fa4 c013f1e7 
       c7ad0e60 c7d844a0 c7c06000 400165a4 bffffd4c bffffc54 c7d84420 c7f7b8c0 
Call Trace: [<c0140018>] [<c01475b5>] [<c0145df8>] [<c013f110>] [<c013f1e7>] [<c010b513>] 
Code: 50 1e 06 50 55 57 56 52 51 53 89 e0 50 e8 a9 fe ff ff 83 c4 

>>EIP; c010b9b5 <printstate+9/2c>   <=====
Trace; c0140018 <sys_rename+154/270>
Trace; c01475b5 <iput+1a1/1b4>
Trace; c0145df8 <d_delete+60/a8>
Trace; c013f110 <vfs_unlink+160/190>
Trace; c013f1e7 <sys_unlink+a7/120>
Trace; c010b513 <system_call+33/38>
Code;  c010b9b5 <printstate+9/2c>

CPU:    0
EIP:    0010:[<c010b9b5>]
EFLAGS: 00000202
eax: 00000001   ebx: c7ad0ce0   ecx: c022ce90   edx: c7ad0cf8
esi: c022f500   edi: c7ad0e60   ebp: c7d6c560   esp: c7c07f4c
ds: 0018   es: 0018   ss: 0018
Process ksymoops (pid: 41, stackpage=c7c07000)
Stack: c7c07f50 c0140018 c01475b5 c7d6c560 c7ad0ce0 c0145df8 c7ad0ce0 c7c06000 
       00000000 c013f110 c7d6c560 c7d6c560 c7d6c560 c7f45000 c7c07fa4 c013f1e7 
       c7ad0e60 c7d6c560 c7c06000 400165a4 bffffd4c bffffc54 c7d84420 c7f7b8c0 
Call Trace: [<c0140018>] [<c01475b5>] [<c0145df8>] [<c013f110>] [<c013f1e7>] [<c010b513>] 
Code: 50 1e 06 50 55 57 56 52 51 53 89 e0 50 e8 a9 fe ff ff 83 c4 

>>EIP; c010b9b5 <printstate+9/2c>   <=====
Trace; c0140018 <sys_rename+154/270>
Trace; c01475b5 <iput+1a1/1b4>
Trace; c0145df8 <d_delete+60/a8>
Trace; c013f110 <vfs_unlink+160/190>
Trace; c013f1e7 <sys_unlink+a7/120>
Trace; c010b513 <system_call+33/38>
Code;  c010b9b5 <printstate+9/2c>

CPU:    0
EIP:    0010:[<c010b9b5>]
EFLAGS: 00000202
eax: 00000001   ebx: c7ad0b60   ecx: c022ce90   edx: c7ad0b78
esi: c022f500   edi: c7ad0e60   ebp: c7d6c660   esp: c7c07f4c
ds: 0018   es: 0018   ss: 0018
Process ksymoops (pid: 47, stackpage=c7c07000)
Stack: c7c07f50 c0140018 c01475b5 c7d6c660 c7ad0b60 c0145df8 c7ad0b60 c7c06000 
       00000000 c013f110 c7d6c660 c7d6c660 c7d6c660 c7f45000 c7c07fa4 c013f1e7 
       c7ad0e60 c7d6c660 c7c06000 400165a4 bffffd2c bffffc34 c7d84420 c7f7b8c0 
Call Trace: [<c0140018>] [<c01475b5>] [<c0145df8>] [<c013f110>] [<c013f1e7>] [<c010b513>] 
Code: 50 1e 06 50 55 57 56 52 51 53 89 e0 50 e8 a9 fe ff ff 83 c4 

>>EIP; c010b9b5 <printstate+9/2c>   <=====
Trace; c0140018 <sys_rename+154/270>
Trace; c01475b5 <iput+1a1/1b4>
Trace; c0145df8 <d_delete+60/a8>
Trace; c013f110 <vfs_unlink+160/190>
Trace; c013f1e7 <sys_unlink+a7/120>
Trace; c010b513 <system_call+33/38>
Code;  c010b9b5 <printstate+9/2c>

CPU:    0
EIP:    0010:[<c010b9b5>]
EFLAGS: 00000202
eax: 00000001   ebx: c7ad0b60   ecx: c022ce90   edx: c7ad0b78
esi: c022f500   edi: c7ad0e60   ebp: c7d846a0   esp: c7c07f4c
ds: 0018   es: 0018   ss: 0018
Process ksymoops (pid: 47, stackpage=c7c07000)
Stack: c7c07f50 c0140018 c01475b5 c7d846a0 c7ad0b60 c0145df8 c7ad0b60 c7c06000 
       00000000 c013f110 c7d846a0 c7d846a0 c7d846a0 c7f45000 c7c07fa4 c013f1e7 
       c7ad0e60 c7d846a0 c7c06000 400165a4 bffffd2c bffffc34 c7d84420 c7f7b8c0 
Call Trace: [<c0140018>] [<c01475b5>] [<c0145df8>] [<c013f110>] [<c013f1e7>] [<c010b513>] 
Code: 50 1e 06 50 55 57 56 52 51 53 89 e0 50 e8 a9 fe ff ff 83 c4 

>>EIP; c010b9b5 <printstate+9/2c>   <=====
Trace; c0140018 <sys_rename+154/270>
Trace; c01475b5 <iput+1a1/1b4>
Trace; c0145df8 <d_delete+60/a8>
Trace; c013f110 <vfs_unlink+160/190>
Trace; c013f1e7 <sys_unlink+a7/120>
Trace; c010b513 <system_call+33/38>
Code;  c010b9b5 <printstate+9/2c>

CPU:    0
EIP:    0010:[<c010b9b5>]
EFLAGS: 00000202
eax: 00000001   ebx: c7ad0b60   ecx: c022ce90   edx: c7ad0b78
esi: c022f500   edi: c7ad0e60   ebp: c7df0140   esp: c7c07f4c
ds: 0018   es: 0018   ss: 0018
Process ksymoops (pid: 47, stackpage=c7c07000)
Stack: c7c07f50 c0140018 c01475b5 c7df0140 c7ad0b60 c0145df8 c7ad0b60 c7c06000 
       00000000 c013f110 c7df0140 c7df0140 c7df0140 c7f45000 c7c07fa4 c013f1e7 
       c7ad0e60 c7df0140 c7c06000 400165a4 bffffd2c bffffc34 c7d84420 c7f7b8c0 
Call Trace: [<c0140018>] [<c01475b5>] [<c0145df8>] [<c013f110>] [<c013f1e7>] [<c010b513>] 
Code: 50 1e 06 50 55 57 56 52 51 53 89 e0 50 e8 a9 fe ff ff 83 c4 

>>EIP; c010b9b5 <printstate+9/2c>   <=====
Trace; c0140018 <sys_rename+154/270>
Trace; c01475b5 <iput+1a1/1b4>
Trace; c0145df8 <d_delete+60/a8>
Trace; c013f110 <vfs_unlink+160/190>
Trace; c013f1e7 <sys_unlink+a7/120>
Trace; c010b513 <system_call+33/38>
Code;  c010b9b5 <printstate+9/2c>

CPU:    0
EIP:    0010:[<c010b9b5>]
EFLAGS: 00000202
eax: 00000001   ebx: c7b279c0   ecx: c022ce90   edx: c7b279d8
esi: c022f500   edi: c7f3d4e0   ebp: c132a460   esp: c77abf4c
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 89, stackpage=c77ab000)
Stack: c77abf50 c0140018 c01475b5 c132a460 c7b279c0 c0145df8 c7b279c0 c77aa000 
       00000000 c013f110 c132a460 c132a460 c132a460 c7f45000 c77abfa4 c013f1e7 
       c7f3d4e0 c132a460 c77aa000 08057f60 08057fc8 00000000 c123d920 c7f7b8c0 
Call Trace: [<c0140018>] [<c01475b5>] [<c0145df8>] [<c013f110>] [<c013f1e7>] [<c010b513>] 
Code: 50 1e 06 50 55 57 56 52 51 53 89 e0 50 e8 a9 fe ff ff 83 c4 

>>EIP; c010b9b5 <printstate+9/2c>   <=====
Trace; c0140018 <sys_rename+154/270>
Trace; c01475b5 <iput+1a1/1b4>
Trace; c0145df8 <d_delete+60/a8>
Trace; c013f110 <vfs_unlink+160/190>
Trace; c013f1e7 <sys_unlink+a7/120>
Trace; c010b513 <system_call+33/38>
Code;  c010b9b5 <printstate+9/2c>

CPU:    0
EIP:    0010:[<c010b9b5>]
EFLAGS: 00000202
eax: 00000001   ebx: c78681c0   ecx: c022ce90   edx: c78681d8
esi: c022f500   edi: c7f3d4e0   ebp: c132a460   esp: c7a41f4c
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 92, stackpage=c7a41000)
Stack: c7a41f50 c0140018 c01475b5 c132a460 c78681c0 c0145df8 c78681c0 c7a40000 
       00000000 c013f110 c132a460 c132a460 c132a460 c7f45000 c7a41fa4 c013f1e7 
       c7f3d4e0 c132a460 c7a40000 08073d98 08052c71 00000000 c123d920 c7f7b8c0 
Call Trace: [<c0140018>] [<c01475b5>] [<c0145df8>] [<c013f110>] [<c013f1e7>] [<c010b513>] 
Code: 50 1e 06 50 55 57 56 52 51 53 89 e0 50 e8 a9 fe ff ff 83 c4 

>>EIP; c010b9b5 <printstate+9/2c>   <=====
Trace; c0140018 <sys_rename+154/270>
Trace; c01475b5 <iput+1a1/1b4>
Trace; c0145df8 <d_delete+60/a8>
Trace; c013f110 <vfs_unlink+160/190>
Trace; c013f1e7 <sys_unlink+a7/120>
Trace; c010b513 <system_call+33/38>
Code;  c010b9b5 <printstate+9/2c>

CPU:    0
EIP:    0010:[<c010b9b5>]
EFLAGS: 00000202
eax: 00000001   ebx: c78681c0   ecx: c022ce90   edx: c78681d8
esi: c022f500   edi: c7f3d4e0   ebp: c132a460   esp: c7a41f4c
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 92, stackpage=c7a41000)
Stack: c7a41f50 c0140018 c01475b5 c132a460 c78681c0 c0145df8 c78681c0 c7a40000 
       00000000 c013f110 c132a460 c132a460 c132a460 c7f45000 c7a41fa4 c013f1e7 
       c7f3d4e0 c132a460 c7a40000 080762e0 08052c71 00000000 c123d920 c7f7b8c0 
Call Trace: [<c0140018>] [<c01475b5>] [<c0145df8>] [<c013f110>] [<c013f1e7>] [<c010b513>] 
Code: 50 1e 06 50 55 57 56 52 51 53 89 e0 50 e8 a9 fe ff ff 83 c4 

>>EIP; c010b9b5 <printstate+9/2c>   <=====
Trace; c0140018 <sys_rename+154/270>
Trace; c01475b5 <iput+1a1/1b4>
Trace; c0145df8 <d_delete+60/a8>
Trace; c013f110 <vfs_unlink+160/190>
Trace; c013f1e7 <sys_unlink+a7/120>
Trace; c010b513 <system_call+33/38>
Code;  c010b9b5 <printstate+9/2c>

CPU:    0
EIP:    0010:[<c010b9b5>]
EFLAGS: 00000202
eax: 00000001   ebx: c76e03a0   ecx: c022ce90   edx: c76e03b8
esi: c022f500   edi: c76e0520   ebp: c76c0840   esp: c7a6ff4c
ds: 0018   es: 0018   ss: 0018
Process rm (pid: 105, stackpage=c7a6f000)
Stack: c7a6ff50 c0140018 c01475b5 c76c0840 c76e03a0 c0145df8 c76e03a0 c7a6e000 
       00000000 c013f110 c76c0840 c76c0840 c76c0840 c7f45000 c7a6ffa4 c013f1e7 
       c76e0520 c76c0840 c7a6e000 bffffec1 00000000 bffffc44 c76c08c0 c7f7b8c0 
Call Trace: [<c0140018>] [<c01475b5>] [<c0145df8>] [<c013f110>] [<c013f1e7>] [<c010b513>] 
Code: 50 1e 06 50 55 57 56 52 51 53 89 e0 50 e8 a9 fe ff ff 83 c4 

>>EIP; c010b9b5 <printstate+9/2c>   <=====
Trace; c0140018 <sys_rename+154/270>
Trace; c01475b5 <iput+1a1/1b4>
Trace; c0145df8 <d_delete+60/a8>
Trace; c013f110 <vfs_unlink+160/190>
Trace; c013f1e7 <sys_unlink+a7/120>
Trace; c010b513 <system_call+33/38>
Code;  c010b9b5 <printstate+9/2c>

CPU:    0
EIP:    0010:[<c010b9b5>]
EFLAGS: 00000202
eax: 00000001   ebx: c76154c0   ecx: c022ce90   edx: c76154d8
esi: c022f500   edi: c7f45000   ebp: c751bfa4   esp: c751bf60
ds: 0018   es: 0018   ss: 0018
Process rm (pid: 143, stackpage=c751b000)
Stack: c751bf64 c0140018 c01475b5 c77fe220 c76154c0 c0145296 c76154c0 c77fe220 
       00000000 c013ef77 c77fe220 c7ad0e60 c77fe220 c751a000 0804ec80 bffffbcc 
       bffffc34 c7d84420 c7f7b8c0 c7f45002 00000009 b23a38c3 00000010 00000000 
Call Trace: [<c0140018>] [<c01475b5>] [<c0145296>] [<c013ef77>] [<c010b513>] 
Code: 50 1e 06 50 55 57 56 52 51 53 89 e0 50 e8 a9 fe ff ff 83 c4 

>>EIP; c010b9b5 <printstate+9/2c>   <=====
Trace; c0140018 <sys_rename+154/270>
Trace; c01475b5 <iput+1a1/1b4>
Trace; c0145296 <dput+116/174>
Trace; c013ef77 <sys_rmdir+cb/104>
Trace; c010b513 <system_call+33/38>
Code;  c010b9b5 <printstate+9/2c>

CPU:    0
EIP:    0010:[<c010b9b5>]
EFLAGS: 00000202
eax: 00000001   ebx: c752fae0   ecx: c022ce90   edx: c752faf8
esi: c022f500   edi: c13fe520   ebp: c7684dc0   esp: c7529f4c
ds: 0018   es: 0018   ss: 0018
Process rm (pid: 149, stackpage=c7529000)
Stack: c7529f50 c0140018 c01475b5 c7684dc0 c752fae0 c0145df8 c752fae0 c7528000 
       00000000 c013f110 c7684dc0 c7684dc0 c7684dc0 c7f45000 c7529fa4 c013f1e7 
       c13fe520 c7684dc0 c7528000 bffffeb4 00000000 bffffc34 c7d6cf60 c7f7b8c0 
Call Trace: [<c0140018>] [<c01475b5>] [<c0145df8>] [<c013f110>] [<c013f1e7>] [<c010b513>] 
Code: 50 1e 06 50 55 57 56 52 51 53 89 e0 50 e8 a9 fe ff ff 83 c4 

>>EIP; c010b9b5 <printstate+9/2c>   <=====
Trace; c0140018 <sys_rename+154/270>
Trace; c01475b5 <iput+1a1/1b4>
Trace; c0145df8 <d_delete+60/a8>
Trace; c013f110 <vfs_unlink+160/190>
Trace; c013f1e7 <sys_unlink+a7/120>
Trace; c010b513 <system_call+33/38>
Code;  c010b9b5 <printstate+9/2c>

CPU:    0
EIP:    0010:[<c010b9b5>]
EFLAGS: 00000202
eax: 00000001   ebx: c752f7e0   ecx: c022ce90   edx: c752f7f8
esi: c022f500   edi: c13fe520   ebp: c7684c40   esp: c7529f4c
ds: 0018   es: 0018   ss: 0018
Process rm (pid: 150, stackpage=c7529000)
Stack: c7529f50 c0140018 c01475b5 c7684c40 c752f7e0 c0145df8 c752f7e0 c7528000 
       00000000 c013f110 c7684c40 c7684c40 c7684c40 c7f45000 c7529fa4 c013f1e7 
       c13fe520 c7684c40 c7528000 bffffea7 00000000 bffffc24 c7d6cf60 c7f7b8c0 
Call Trace: [<c0140018>] [<c01475b5>] [<c0145df8>] [<c013f110>] [<c013f1e7>] [<c010b513>] 
Code: 50 1e 06 50 55 57 56 52 51 53 89 e0 50 e8 a9 fe ff ff 83 c4 

>>EIP; c010b9b5 <printstate+9/2c>   <=====
Trace; c0140018 <sys_rename+154/270>
Trace; c01475b5 <iput+1a1/1b4>
Trace; c0145df8 <d_delete+60/a8>
Trace; c013f110 <vfs_unlink+160/190>
Trace; c013f1e7 <sys_unlink+a7/120>
Trace; c010b513 <system_call+33/38>
Code;  c010b9b5 <printstate+9/2c>

CPU:    0
EIP:    0010:[<c010b9b5>]
EFLAGS: 00000202
eax: 00000001   ebx: c752fde0   ecx: c022ce90   edx: c752fdf8
esi: c022f500   edi: c13fe520   ebp: c7684ec0   esp: c74edf4c
ds: 0018   es: 0018   ss: 0018
Process rm (pid: 164, stackpage=c74ed000)
Stack: c74edf50 c0140018 c01475b5 c7684ec0 c752fde0 c0145df8 c752fde0 c74ec000 
       00000000 c013f110 c7684ec0 c7684ec0 c7684ec0 c7f45000 c74edfa4 c013f1e7 
       c13fe520 c7684ec0 c74ec000 bffffec4 00000000 bffffc44 c7d6cf60 c7f7b8c0 
Call Trace: [<c0140018>] [<c01475b5>] [<c0145df8>] [<c013f110>] [<c013f1e7>] [<c010b513>] 
Code: 50 1e 06 50 55 57 56 52 51 53 89 e0 50 e8 a9 fe ff ff 83 c4 

>>EIP; c010b9b5 <printstate+9/2c>   <=====
Trace; c0140018 <sys_rename+154/270>
Trace; c01475b5 <iput+1a1/1b4>
Trace; c0145df8 <d_delete+60/a8>
Trace; c013f110 <vfs_unlink+160/190>
Trace; c013f1e7 <sys_unlink+a7/120>
Trace; c010b513 <system_call+33/38>
Code;  c010b9b5 <printstate+9/2c>

1 error issued.  Results may not be reliable.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
