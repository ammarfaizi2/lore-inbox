Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135605AbRAHXNH>; Mon, 8 Jan 2001 18:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129805AbRAHXM5>; Mon, 8 Jan 2001 18:12:57 -0500
Received: from math.utk.edu ([128.169.244.124]:43529 "HELO
	mathsun1.math.utk.edu") by vger.kernel.org with SMTP
	id <S136167AbRAHXMo>; Mon, 8 Jan 2001 18:12:44 -0500
Message-ID: <20010108231238.3795.qmail@utkmath3.math.utk.edu>
To: Chris Mason <mason@suse.com>, reiserfs-list@namesys.com
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
From: Geoff Hoff <ghoff@math.utk.edu>
Subject: Re: [reiserfs-list] BUG at inode.c:371 
In-Reply-To: Your message of "Mon, 08 Jan 2001 10:42:10 EST."
             <65850000.978968530@tiny> 
Date: Mon, 08 Jan 2001 18:12:38 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have gotten this semi-reproducable bug three times already under the same
> > circumstances.  The bug happens at approximately the same time as I kill
> > xterms after user-mode linux has crashed and I am cleaning up what it has
> > left behind.  User mode linux is using a 1 gig file on a 6 gig reiser
> > filesystem.  After each BUG I have reformated the filesystem and recreated
> > the image I am operating on, so it doesn't seem to be some long term bug
> > in the on disk information that I am just running into.  For the specifics,
> > the first and second time I was running linux-2.4.0-prerelease with the
> > reiserfs-3.6.24 patch.  
> 
> Hmmm, could you try to reproduce under ext2?  I'll see what I can find on the
> reiserfs side.

The good? news is that it isn't a reiserfs specific problem.  The bad news
is it also happens with ext2.  This is what I was doing:  I have a 1GB image
file with the 74 megs that the first stage debian installer puts on the disk.
I make a few changes to it and then boot user mode linux on this image.  In
uml I continue the debian installation off of cdrom and as I say ok to the
final screen I get a "Kernel panic: Kernel mode fault at addr 0xbefffe90, ip
0x1009f315" from user-mode linux which is running as me, not as root.  I then
killall linux, which is the uml executable.  Afterward I do a killall xterm,
as uml spawns an xterm for each virtual console.  Immediately I get the BUG
message.  This is with uml-2.4.0-prerelease running on real 2.4.0-prerelease
with reiserfs-3.6.25 on either a reiser or ext2 filesystem.  I am not subscribed
to user-mode-linux-devel or linux-kernel, so cc me if I can provide any more
information.  Everything has been compiled with gcc-2.91.66.
The decoded bug is:

kernel BUG at inode.c:371!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0140c1b>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000001b   ebx: c3621240   ecx: 00000000   edx: 00000000
esi: 00076e57   edi: c3621240   ebp: c3621240   esp: c693bee0
ds: 0018   es: 0018   ss: 0018
Process xterm (pid: 3531, stackpage=c693b000)
Stack: c01cb3a4 c01cb424 00000173 c12c1800 c014b583 c3621240 c3621240 c01eff40 
       c3621240 c4821b60 c7ad7400 c38c2b40 00000116 0000001e 00000000 c1ac2c80 
       c014bce0 c014bd06 c3621240 c3621240 c01414de c3621240 c4821b60 c3621240 
Call Trace: [<c01cb3a4>] [<c01cb424>] [<c014b583>] [<c014bce0>] [<c014bd06>] [<c01414de>] [<c013f74e>] 
       [<c012ed70>] [<c012defc>] [<c0115dda>] [<c01163cf>] [<c0116536>] [<c0108d5f>] 
Code: 0f 0b 83 c4 0c 8b 83 f0 00 00 00 a8 10 75 26 68 75 01 00 00 

>>EIP; c0140c1b <clear_inode+33/e4>   <=====
Trace; c01cb3a4 <tvecs+52f8/c5a4>
Trace; c01cb424 <tvecs+5378/c5a4>
Trace; c014b583 <ext2_free_inode+a7/180>
Trace; c014bce0 <ext2_delete_inode+90/c8>
Trace; c014bd06 <ext2_delete_inode+b6/c8>
Trace; c01414de <iput+a6/154>
Trace; c013f74e <dput+ee/144>
Trace; c012ed70 <fput+78/d0>
Trace; c012defc <filp_close+5c/64>
Trace; c0115dda <put_files_struct+42/b0>
Trace; c01163cf <do_exit+b7/1f4>
Trace; c0116536 <sys_exit+e/10>
Trace; c0108d5f <system_call+33/38>
Code;  c0140c1b <clear_inode+33/e4>
00000000 <_EIP>:
Code;  c0140c1b <clear_inode+33/e4>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0140c1d <clear_inode+35/e4>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0140c20 <clear_inode+38/e4>
   5:   8b 83 f0 00 00 00         mov    0xf0(%ebx),%eax
Code;  c0140c26 <clear_inode+3e/e4>
   b:   a8 10                     test   $0x10,%al
Code;  c0140c28 <clear_inode+40/e4>
   d:   75 26                     jne    35 <_EIP+0x35> c0140c50 <clear_inode+68/e4>
Code;  c0140c2a <clear_inode+42/e4>
   f:   68 75 01 00 00            push   $0x175
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
