Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265608AbTATLB2>; Mon, 20 Jan 2003 06:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265643AbTATLB2>; Mon, 20 Jan 2003 06:01:28 -0500
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:58754
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id <S265608AbTATLB0>; Mon, 20 Jan 2003 06:01:26 -0500
Message-ID: <3E2BD926.1080503@tupshin.com>
Date: Mon, 20 Jan 2003 03:10:30 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel bug in jfs, kernel 2.4.21-pre3-ac4 + recent listfix
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to have encountered a jfs meets nfs kernel bug, unrelated to the 
recently fixed problems in 2.4.21-pre3-ac4.

A little background on what went on before this, as it seems quite relevant.

I was nfs sharing(kernel nfs) a jfs volume /data/old which is on an lvm 
partition (lvm1, not lvm2).

I did an lvextend on the partition, and then tried to extend the jfs 
partition, while it was nfs shared (though nothing was actively reading 
or writing to it).
The mount -o remount,resize command failed to extend the volume (note 
the first "jfs_extendfs: volume hasn't grown, returning") message below.
I then unmounted the volume from the machines that had it nfs mounted, 
and un-nfs-exported it. I then tried to remount,resize again, and had 
the same problem(note second message). I then unmounted the jfs 
partition completely, and it failed to mount it, claiming  incorrect 
partition type, yadda yadda.  Fsck.jfs was run, and didn't report any 
problems, but after running it, I was now able to mount the partition 
again, and resize it succesfully.

I then re-exported it, nfs-mounted it remotely, and tried to copy files 
to it: kaboom...machine up, but BUG reported and access to filesystem hangs.

FWIW, volume was exported (rw,sync), and mounted 
(rsize=8192,wsize=8192,hard,nolock,intr), the nolock because I had 
earlier in the evening been having problems getting locks on nfs 
exported jfs volumes.

Ahh...pushing the sanity envelope...always fun.

-Tupshin


Jan 20 02:41:23 testing kernel: jfs_extendfs: volume hasn't grown, returning
Jan 20 02:41:55 testing rpc.mountd: authenticated unmount request from 
172.16.1.1:876 for /data/old (/data/old)
Jan 20 02:42:03 testing rpc.mountd: authenticated unmount request from 
172.16.1.50:925 for /data/old (/data/old)
Jan 20 02:42:07 testing kernel: jfs_extendfs: volume hasn't grown, returning
Jan 20 02:43:11 testing rpc.mountd: Caught signal 15, un-registering and 
exiting.
Jan 20 02:43:11 testing kernel: nfsd: last server has exited
Jan 20 02:43:11 testing kernel: nfsd: unexporting all filesystems
Jan 20 02:43:28 testing kernel: resize option for remount only
Jan 20 02:44:53 testing kernel: VFS: brelse: Trying to free free buffer
Jan 20 02:45:10 testing rpc.mountd: Caught signal 15, un-registering and 
exiting.
Jan 20 02:45:10 testing kernel: nfsd: last server has exited
Jan 20 02:45:10 testing kernel: nfsd: unexporting all filesystems
Jan 20 02:45:20 testing rpc.mountd: authenticated mount request from 
172.16.1.1:934 for /data/old (/data/old)
Jan 20 02:45:24 testing rpc.mountd: authenticated mount request from 
172.16.1.50:926 for /data/old (/data/old)
Jan 20 02:47:16 testing kernel: assert(hint < mapSize)

Jan 20 02:47:16 testing kernel: kernel BUG at jfs_dmap.c:760!
Jan 20 02:47:16 testing kernel: invalid operand: 0000
Jan 20 02:47:16 testing kernel: CPU:    0
Jan 20 02:47:16 testing kernel: EIP:    0010:[dbAlloc+150/1312] 
Tainted: PF
Jan 20 02:47:16 testing kernel: EFLAGS: 00013286
Jan 20 02:47:16 testing kernel: eax: 00000017   ebx: 0079ffff   ecx: 
c5c4e02c   edx: f72c1f7c
Jan 20 02:47:16 testing kernel: esi: 00000000   edi: 00000000   ebp: 
e29f57c0   esp: f2eedc58
Jan 20 02:47:16 testing kernel: ds: 0018   es: 0018   ss: 0018
Jan 20 02:47:16 testing kernel: Process nfsd (pid: 4243, stackpage=f2eed000)
Jan 20 02:47:16 testing kernel: Stack: c03504b1 c035069f 00000000 
c0202680 ebce61b4 00000004 c01e78c0 00000000
Jan 20 02:47:16 testing kernel:        00000000 00000004 00000002 
00000000 dd1f6000 f72c38c0 ebce6100 00000004
Jan 20 02:47:16 testing kernel:        00000000 007a0000 e0364000 
00000000 e29f57c0 c01f3b6f ebce6100 0079ffff
Jan 20 02:47:16 testing kernel: Call Trace:    [__get_metapage+640/752] 
[jfs_readpage+0/32] [diNewExt+479/1632] [diAllocExt+190/640] 
[diAllocAG+88/224]
Jan 20 02:47:16 testing kernel: Code: 0f 0b f8 02 94 06 35 c0 8b 44 24 
30 8b 48 34 39 4c 24 28 0f
Using defaults from ksymoops -t elf32-i386 -a i386


 >>ecx; c5c4e02c <_end+579aea8/3859eefc>
 >>edx; f72c1f7c <_end+36e0edf8/3859eefc>
 >>ebp; e29f57c0 <_end+2254263c/3859eefc>
 >>esp; f2eedc58 <_end+32a3aad4/3859eefc>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
    2:   f8                        clc
Code;  00000003 Before first symbol
    3:   02 94 06 35 c0 8b 44      add    0x448bc035(%esi,%eax,1),%dl
Code;  0000000a Before first symbol
    a:   24 30                     and    $0x30,%al
Code;  0000000c Before first symbol
    c:   8b 48 34                  mov    0x34(%eax),%ecx
Code;  0000000f Before first symbol
    f:   39 4c 24 28               cmp    %ecx,0x28(%esp,1)
Code;  00000013 Before first symbol
   13:   0f 00 00                  sldtl  (%eax)

