Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbQLBE07>; Fri, 1 Dec 2000 23:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129415AbQLBE0s>; Fri, 1 Dec 2000 23:26:48 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:58844 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129408AbQLBE0e>; Fri, 1 Dec 2000 23:26:34 -0500
Message-ID: <3A2873A1.3EFEA29@uow.edu.au>
Date: Sat, 02 Dec 2000 14:59:30 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test12-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Alexander Viro <viro@math.psu.edu>, Jonathan Hudson <jonathan@daria.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <b09.3a269edc.6bd12@trespassersw.daria.co.uk> <Pine.GSO.4.21.0011301400290.20801-100000@weyl.math.psu.edu> <3A26C82D.26267202@uow.edu.au>,
		<3A26C82D.26267202@uow.edu.au>; from andrewm@uow.edu.au on Fri, Dec 01, 2000 at 08:35:41AM +1100 <20001201141659.A4562@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" wrote:
> 
> Hi,
> 
> On Fri, Dec 01, 2000 at 08:35:41AM +1100, Andrew Morton wrote:
> >
> > I bet this'll catch it:
> >
> >  static __inline__ void list_del(struct list_head *entry)
> >  {
> >       __list_del(entry->prev, entry->next);
> > +     entry->next = entry->prev = 0;
> >  }
> 
> No, because the buffer hash list is never referenced unless
> buffer->b_inode is non-null, so we can't ever do a double-list_del on
> the buffer.
> 
> The patch below should fix it.  It has been sent to Linus.  The
> important part is the first hunk of the inode.c diff.

Testing test11-pre3 with your inode.c patch and the above list_del
patch.  x86 dual processor, IDE.  Same workload as before, except
I cut out misc001 (and the machine recovered almost immediately
when I killed everything!  Need more testing to characterise this).

kernel BUG at inode.c:83!  The trace is below.  Now, this was 
probably triggered by my list_del change.  If so it means
that we're doing a list_empty() test on a list_head which
has actually been deleted from a list.  So it's possibly the
actual assertion in destroy_inode() which is a little bogus.

But the wierd thing is that this BUG only hit a single time,
after three hours of intensive testing.  If my theory is
right, the BUG should hit every time.   Will investigate further...



ksymoops 0.7c on i686 2.4.0-test12-pre3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test12-pre3/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Reading Oops report from the terminal
Dec  2 13:15:45 mnm kernel: invalid operand: 0000
Dec  2 13:15:45 mnm kernel: CPU:    0
Dec  2 13:15:45 mnm kernel: EIP:    0010:[<c014570e>]
Using defaults from ksymoops -t elf32-i386 -a i386
Dec  2 13:15:45 mnm kernel: EFLAGS: 00010282
Dec  2 13:15:45 mnm kernel: eax: 0000001a   ebx: c78686e0   ecx: 00000000   edx: 0000002f
Dec  2 13:15:45 mnm kernel: esi: c025b800   edi: cd950960   ebp: c7869160   esp: ce611f3c
Dec  2 13:15:45 mnm kernel: ds: 0018   es: 0018   ss: 0018
Dec  2 13:15:45 mnm kernel: Process dbench (pid: 13094, stackpage=ce611000)
Dec  2 13:15:45 mnm kernel: Stack: c021b7e5 c021b8a5 00000053 c78686e0 c0146916 c78686e0 c7869160 c78686e0
Dec  2 13:15:45 mnm kernel:        c0145096 c78686e0 00000000 ce610000 c013de4d c7869160 c7869160 c9b1e000
Dec  2 13:15:45 mnm kernel:        ce611fa4 c7869160 cd9509d0 c013df25 cd950960 c7869160 ce610000 bffff5ca
Dec  2 13:15:45 mnm kernel: Call Trace: [<c021b7e5>] [<c021b8a5>] [<c0146916>] [<c0145096>] [<c013de4d>] [<c013df25>
Dec  2 13:15:45 mnm kernel:        [<c010002b>]
Dec  2 13:15:45 mnm kernel: Code: 0f 0b 83 c4 0c 53 a1 10 d1 2a c0 50 e8 cd 3d fe ff 83 c4 08

>>EIP; c014570e <destroy_inode+1e/34>   <=====
Trace; c021b7e5 <tvecs+5a3d/1a3d8>
Trace; c021b8a5 <tvecs+5afd/1a3d8>
Trace; c0146916 <iput+18e/194>
Trace; c0145096 <d_delete+66/ac>
Trace; c013de4d <vfs_unlink+18d/1c0>
Trace; c013df25 <sys_unlink+a5/118>
Trace; c010002b <startup_32+2b/cb>
Code;  c014570e <destroy_inode+1e/34>
00000000 <_EIP>:
Code;  c014570e <destroy_inode+1e/34>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0145710 <destroy_inode+20/34>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0145713 <destroy_inode+23/34>
   5:   53                        push   %ebx
Code;  c0145714 <destroy_inode+24/34>
   6:   a1 10 d1 2a c0            mov    0xc02ad110,%eax
Code;  c0145719 <destroy_inode+29/34>
   b:   50                        push   %eax
Code;  c014571a <destroy_inode+2a/34>
   c:   e8 cd 3d fe ff            call   fffe3dde <_EIP+0xfffe3dde> c01294ec <kmem_cache_free+0/7c>
Code;  c014571f <destroy_inode+2f/34>
  11:   83 c4 08                  add    $0x8,%esp


1 warning issued.  Results may not be reliable.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
