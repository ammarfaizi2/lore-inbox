Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269002AbTCDCSQ>; Mon, 3 Mar 2003 21:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269003AbTCDCSQ>; Mon, 3 Mar 2003 21:18:16 -0500
Received: from tiger.cellmail.com ([199.4.110.40]:6272 "EHLO mail.mercnet.pt")
	by vger.kernel.org with ESMTP id <S269002AbTCDCSM>;
	Mon, 3 Mar 2003 21:18:12 -0500
From: sampo@symlabs.com
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org, dev@symlabs.com
Subject: Oops in rpc_depopulate (rpciod), using CFS on linux-2.5.63
Date: Tue, 04 Mar 2003 02:29:37 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.3E640F91.000002D1@mail.mercnet.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Sony Vaio Picturebook C1-MSX laptop. I am running
Linux-2.5.63 with some patches for Speedtouch 330 ADSL (not active
during oops). The system is based originally on RedHat 7.3, but has
been heavily hacked since. The kernel is compiled for uniprocessor
Crusoe without preemption and with Longrun and power management using
ACPI. It is moderately modularized with USB (not loaded at the
moment), PCMCIA (not loaded at the moment), and 8139too ethernet
active at the moment. 

The oops happens after I have mounted and cattach'd a cryptographic
filesystem (based on CFS-1.4.0.beta2) when I am running an I/O
intensive DirectoryScript program inside a directory that is on this
file system. There is no other NFS activity going on. The cryptographic
directory resides on a reiserfs partition on the local IDE disk. 

The problem appears to be reproducible. I can send you the
DirectoryScript executable and script that allows reproduction, but
lets see first if we can resolve this without resorting to such
an extreme. I have successfully compiled DirectoryScript, a 70000 line
C/C++ program, inside this same cryptographic file system directory
and I have successfully run one of the test suites which includes
over 240 test scripts (roughly equal in complexity to equivalent
sized perl test suite). Thus I don't think the CFS is in general
flakey, but when I try to run one of my other DirectoryScript
test suites, the oops happens every single time. 

The oops did not appear to happen under 2.5.62, though I have
rather limited experience under 2.5.62 and CFS. The oops
does not happen if I run the test suite outside the cryptographic
filesystem directory. My theory is that the oops is related
to kernel NFS code. The CFS should not be relevant as it
is pure userland NFS server. 

After the oops machine remains marginally usable. For example
I was able to run over ssh dmesg to capture the oops and I
am able to issue reboot command, though the reboot does not
complete. SysRq-SUB works and reboots the machine ok. 

======================== 

ksymoops 2.4.8 on i686 2.5.63.  Options used
    -V (default)
    -k /proc/ksyms (default)
    -l /proc/modules (default)
    -o /lib/modules/2.5.63/ (default)
    -m /s/linux-2.5.63/System.map (specified) 

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Reading Oops report from the terminal
Unable to handle kernel NULL pointer dereference at virtual address 0000006c
c0281c69
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c0281c69>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292
eax: ce2f3f1c   ebx: c9a37720   ecx: 0000006c   edx: ce2f3f1c
esi: 00000000   edi: ce33edc0   ebp: 00000000   esp: ce2f3f0c
ds: 007b   es: 007b   ss: 0068
Stack: c9a37720 00000000 ce33edc0 ce2f3f3c ce2f3f1c ce2f3f1c c0282139 
c9a37720
      ca48ed60 c13a6f3c 00000000 c13a6ee0 ce3db8e0 ceffa860 c13a6f3c 
00000000
      c027a801 00000010 00000001 c0275ec3 ca48edf4 ca48ed60 c0275f32 
ca48ed60
Call Trace: [<c0282139>]  [<c027a801>]  [<c0275ec3>]  [<c0275f32>]  
[<c0279d0b>]
 [<c02797d9>]  [<c0117126>]  [<c02798f3>]  [<c027a07f>]  [<c0279ff0>]  
[<c01171
8e>]  [<c01071cd>]
Code: ff 4d 6c 0f 88 c8 08 00 00 8b 4c 24 1c 8b 59 38 83 c1 38 8b 


>>EIP; c0281c69 <rpc_depopulate+1f/e2>   <=====

Trace; c0282139 <rpc_rmdir+5c/8d>
Trace; c027a801 <rpcauth_destroy+36/3b>
Trace; c0275ec3 <rpc_destroy_client+46/6d>
Trace; c0275f32 <rpc_release_client+48/4d>
Trace; c0279d0b <rpc_release_task+16c/18d>
Trace; c02797d9 <__rpc_execute+2d5/2e2>
Trace; c0117126 <schedule+241/2a9>
Trace; c02798f3 <__rpc_schedule+a2/103>
Trace; c027a07f <rpciod+8f/1d0>
Trace; c0279ff0 <rpciod+0/1d0>
Trace; c011718e <default_wake_function+0/1b>
Trace; c01071cd <kernel_thread_helper+5/b> 

Code;  c0281c69 <rpc_depopulate+1f/e2>
00000000 <_EIP>:
Code;  c0281c69 <rpc_depopulate+1f/e2>   <=====
  0:   ff 4d 6c                  decl   0x6c(%ebp)   <=====
Code;  c0281c6c <rpc_depopulate+22/e2>
  3:   0f 88 c8 08 00 00         js     8d1 <_EIP+0x8d1> c028253a 
<.text.lock.r
pc_pipe+a0/122>
Code;  c0281c72 <rpc_depopulate+28/e2>
  9:   8b 4c 24 1c               mov    0x1c(%esp,1),%ecx
Code;  c0281c76 <rpc_depopulate+2c/e2>
  d:   8b 59 38                  mov    0x38(%ecx),%ebx
Code;  c0281c79 <rpc_depopulate+2f/e2>
 10:   83 c1 38                  add    $0x38,%ecx
Code;  c0281c7c <rpc_depopulate+32/e2>
 13:   8b 00                     mov    (%eax),%eax 


1 error issued.  Results may not be reliable. 

======================== 

gdb /s/linux-2.5.63/vmlinux
disassemble rpc_depopulate 

Dump of assembler code for function rpc_depopulate:
0xc0281c4a <rpc_depopulate>:    sub    $0x8,%esp
0xc0281c4d <rpc_depopulate+3>:  push   %ebp
0xc0281c4e <rpc_depopulate+4>:  push   %edi
0xc0281c4f <rpc_depopulate+5>:  push   %esi
0xc0281c50 <rpc_depopulate+6>:  push   %ebx
0xc0281c51 <rpc_depopulate+7>:  mov    0x1c(%esp,1),%eax
0xc0281c55 <rpc_depopulate+11>: mov    0x14(%eax),%ebp
0xc0281c58 <rpc_depopulate+14>: lea    0x10(%esp,1),%eax
0xc0281c5c <rpc_depopulate+18>: mov    %eax,%edx
0xc0281c5e <rpc_depopulate+20>: mov    %eax,0x10(%esp,1)
0xc0281c62 <rpc_depopulate+24>: mov    %edx,0x14(%esp,1)
0xc0281c66 <rpc_depopulate+28>: lea    0x6c(%ebp),%ecx
0xc0281c69 <rpc_depopulate+31>: decl   0x6c(%ebp)     ; <==== EIP HERE
0xc0281c6c <rpc_depopulate+34>: js     0xc028253a <.text.lock.rpc_pipe+160>
0xc0281c72 <rpc_depopulate+40>: mov    0x1c(%esp,1),%ecx
0xc0281c76 <rpc_depopulate+44>: mov    0x38(%ecx),%ebx
0xc0281c79 <rpc_depopulate+47>: add    $0x38,%ecx
0xc0281c7c <rpc_depopulate+50>: mov    (%ebx),%edi
0xc0281c7e <rpc_depopulate+52>: cmp    %ecx,%ebx
0xc0281c80 <rpc_depopulate+54>: je     0xc0281cca <rpc_depopulate+128>
0xc0281c82 <rpc_depopulate+56>: lea    0xffffffd0(%ebx),%esi
0xc0281c85 <rpc_depopulate+59>: testb  $0x10,0xffffffd4(%ebx)
0xc0281c89 <rpc_depopulate+63>: jne    0xc0281cbb <rpc_depopulate+113>
0xc0281c8b <rpc_depopulate+65>: push   %esi
0xc0281c8c <rpc_depopulate+66>: call   0xc01517aa <dget_locked>
0xc0281c91 <rpc_depopulate+71>: orb    $0x10,0xffffffd4(%ebx)
0xc0281c95 <rpc_depopulate+75>: lea    0x20(%esi),%ecx
0xc0281c98 <rpc_depopulate+78>: mov    0x4(%ecx),%edx
0xc0281c9b <rpc_depopulate+81>: mov    0xfffffff0(%ebx),%eax
0xc0281c9e <rpc_depopulate+84>: add    $0x4,%esp
0xc0281ca1 <rpc_depopulate+87>: mov    %edx,0x4(%eax)
0xc0281ca4 <rpc_depopulate+90>: mov    %eax,(%edx)
0xc0281ca6 <rpc_depopulate+92>: mov    0x10(%esp,1),%eax
0xc0281caa <rpc_depopulate+96>: mov    %ecx,0x4(%eax)
0xc0281cad <rpc_depopulate+99>: mov    %eax,0xfffffff0(%ebx)
0xc0281cb0 <rpc_depopulate+102>:        lea    0x10(%esp,1),%eax
0xc0281cb4 <rpc_depopulate+106>:        mov    %eax,0x4(%ecx)
0xc0281cb7 <rpc_depopulate+109>:        mov    %ecx,0x10(%esp,1)
0xc0281cbb <rpc_depopulate+113>:        mov    %edi,%ebx
0xc0281cbd <rpc_depopulate+115>:        mov    (%ebx),%edi
0xc0281cbf <rpc_depopulate+117>:        mov    0x1c(%esp,1),%eax
0xc0281cc3 <rpc_depopulate+121>:        add    $0x38,%eax
0xc0281cc6 <rpc_depopulate+124>:        cmp    %eax,%ebx
0xc0281cc8 <rpc_depopulate+126>:        jne    0xc0281c82 
<rpc_depopulate+56>
0xc0281cca <rpc_depopulate+128>:        lea    0x6c(%ebp),%ebx
0xc0281ccd <rpc_depopulate+131>:        lea    0x10(%esp,1),%ecx
0xc0281cd1 <rpc_depopulate+135>:        cmp    %ecx,0x10(%esp,1)
0xc0281cd5 <rpc_depopulate+139>:        je     0xc0281d1a 
<rpc_depopulate+208>
0xc0281cd7 <rpc_depopulate+141>:        mov    0x10(%esp,1),%ecx
0xc0281cdb <rpc_depopulate+145>:        lea    0xffffffe0(%ecx),%esi
0xc0281cde <rpc_depopulate+148>:        mov    0x4(%ecx),%edx
0xc0281ce1 <rpc_depopulate+151>:        mov    (%ecx),%eax
0xc0281ce3 <rpc_depopulate+153>:        orb    $0x10,0xffffffe4(%ecx)
0xc0281ce7 <rpc_depopulate+157>:        mov    %edx,0x4(%eax)
0xc0281cea <rpc_depopulate+160>:        mov    %eax,(%edx)
0xc0281cec <rpc_depopulate+162>:        cmpl   $0x0,0xfffffff4(%ecx)
0xc0281cf0 <rpc_depopulate+166>:        je     0xc0281d07 
<rpc_depopulate+189>
0xc0281cf2 <rpc_depopulate+168>:        push   $0x0
0xc0281cf4 <rpc_depopulate+170>:        mov    0xfffffff4(%ecx),%eax
0xc0281cf7 <rpc_depopulate+173>:        push   %eax
0xc0281cf8 <rpc_depopulate+174>:        call   0xc028169b 
<rpc_inode_setowner>
0xc0281cfd <rpc_depopulate+179>:        push   %esi
0xc0281cfe <rpc_depopulate+180>:        push   %ebp
0xc0281cff <rpc_depopulate+181>:        call   0xc0157617 <simple_unlink>
0xc0281d04 <rpc_depopulate+186>:        add    $0x10,%esp
0xc0281d07 <rpc_depopulate+189>:        push   %esi
0xc0281d08 <rpc_depopulate+190>:        call   0xc015164b <dput>
0xc0281d0d <rpc_depopulate+195>:        add    $0x4,%esp
0xc0281d10 <rpc_depopulate+198>:        lea    0x10(%esp,1),%eax
0xc0281d14 <rpc_depopulate+202>:        cmp    %eax,0x10(%esp,1)
0xc0281d18 <rpc_depopulate+206>:        jne    0xc0281cd7 
<rpc_depopulate+141>
0xc0281d1a <rpc_depopulate+208>:        mov    %ebx,%ecx
0xc0281d1c <rpc_depopulate+210>:        incl   0x6c(%ebp)
0xc0281d1f <rpc_depopulate+213>:        jle    0xc0282544 
<.text.lock.rpc_pipe+170>
0xc0281d25 <rpc_depopulate+219>:        pop    %ebx
0xc0281d26 <rpc_depopulate+220>:        pop    %esi
0xc0281d27 <rpc_depopulate+221>:        pop    %edi
0xc0281d28 <rpc_depopulate+222>:        pop    %ebp
0xc0281d29 <rpc_depopulate+223>:        pop    %ecx
0xc0281d2a <rpc_depopulate+224>:        pop    %edx
0xc0281d2b <rpc_depopulate+225>:        ret 

================== 

Thus it appears that the ebp is the NULL pointer. From net/sunrpc/rpc_pipe.c
we learn that this code is already suspect. Time has come to fix this :-)
As can be seen from the disassy, there is a decrement followed by branch
to subroutine near where the problem happens. Unfortunately the source has
a lot of macros so something might be hidden. I suspect the `js' corresponds
to either the down() or the spinlock(). I'd bet on the former. This
would appear to mean that the parent->d_inode might be NULL. parent
comes from rpc_rmdir() where it is obtained from some sort of hash and this
is where I give up as I don't know where the hash might get populated. 

/*
* FIXME: This probably has races.
*/
static void
rpc_depopulate(struct dentry *parent)
{
	struct inode *dir = parent->d_inode;
	LIST_HEAD(head);
	struct list_head *pos, *next;
	struct dentry *dentry; 

	down(&dir->i_sem);         /* <=== EIP HERE?!? */
	spin_lock(&dcache_lock);
	list_for_each_safe(pos, next, &parent->d_subdirs) {
		dentry = list_entry(pos, struct dentry, d_child);
		if (!d_unhashed(dentry)) {
			dget_locked(dentry);
			__d_drop(dentry);
			list_add(&dentry->d_hash, &head);
		}
	}
	spin_unlock(&dcache_lock);
	while (!list_empty(&head)) {
		dentry = list_entry(head.next, struct dentry, d_hash);
		/* Private list, so no dcache_lock needed and use __d_drop */
		__d_drop(dentry);
		if (dentry->d_inode) {
			rpc_inode_setowner(dentry->d_inode, NULL);
			simple_unlink(dir, dentry);
		}
		dput(dentry);
	}
	up(&dir->i_sem);
} 

===================== 

Curiously enough, to my knowledge the test suite does not
attempt to perform any rmdir operations. Perhaps the rmdir
is something that CFS performs internally? 

Let me know if I can be of any further assistance. If you need to
reproduce this, I can send you the DirectoryScript Proxy executable
and the script that trigger this, or I can give you ssh access to
my laptop so you can take a peek. 

 --Sampo 

P.S. I am not on linux-kernel, so please Cc everything directly to me.
.........................................................................
: Sampo Kellomaki    -    Chief Architect : => DirectoryScript Proxy <= :
: CTO, Symlabs, Inc.      www.symlabs.com :    Customize directories    :
: M: +351-918.731.007 F: +351-214.222.637 :    LDAP SOAP Liberty SIP    :
:.........................................:.............................:
