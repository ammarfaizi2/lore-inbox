Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284970AbSAZHGX>; Sat, 26 Jan 2002 02:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288878AbSAZHGO>; Sat, 26 Jan 2002 02:06:14 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:19879 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S284970AbSAZHFx>; Sat, 26 Jan 2002 02:05:53 -0500
Date: Sat, 26 Jan 2002 09:01:52 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Dave Jones <davej@suse.de>, Alexander Viro <viro@math.psu.edu>
Subject: [PATCH] Oops on mounting CD as UFS
Message-ID: <Pine.LNX.4.44.0201260855520.22162-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, Dave, Linus, Al
	This definately falls under the "Don't do that" category, but my 
box oopsed when i tried to mount a cd as UFS (You don't really wanna hear 
the details). It happened to me initially on my main box (2.4.18-pre3), so 
i reproduced the oops on my 2.5.2-pre3 test box. This, gentlemen, is the 
tale of a wandering hobo called sb->s_blocksize and his short-lived foray 
into the linux kernel

fs/ufs/super.c
ufs_read_super()
{
again:
	sb_set_blocksize(sb, block_size); <== [1]
	ubh = ubh_bread_uspi (uspi, sb,...
[...]
[1] We should have checked the return value!

fs/ufs/util.c
ubh_bread_uspi ()
{
<snip>
	if (!(USPI_UBH->bh[i] = sb_bread(sb, fragment + i)));
<snip>

include/linux/fs.h
sb_bread(struct super_block *sb, int block)
{
	return __bread(sb->s_bdev, block, sb->s_blocksize);
}

fs/buffer.c
struct buffer_head * __bread(struct block_device *bdev, int block, int 
size)
{
	struct buffer_head * bh = __getblk(bdev, block, size);
<snip>

struct buffer_head * __getblk(struct block_device *bdev, sector_t block, 
int size)
{
<snip>
		if (!grow_buffers(bdev, block, size)) <==
<snip>

static int grow_buffers(struct block_device *bdev, unsigned long block, 
int size)
{
<snip>
	/* Size must be within 512 bytes and PAGE_SIZE */
	if (size < 512 || size > PAGE_SIZE)
		BUG();	<== *Tadow* size is 0, hobo dude dies here
<snip>

Patch for 2.5.3-pre5
--- linux-2.5.3-pre5/fs/ufs/super.c.orig	Sat Jan 26 08:41:33 2002
+++ linux-2.5.3-pre5/fs/ufs/super.c	Sat Jan 26 08:42:51 2002
@@ -597,7 +597,10 @@
 	}
 	
 again:	
-	sb_set_blocksize(sb, block_size);
+	if (!sb_set_blocksize(sb, block_size)) {
+		printk(KERN_ERR "UFS: failed to set blocksize\n");
+		goto failed;
+	}
 
 	/*
 	 * read ufs super block from device

Patch for 2.4.18-pre7
--- linux-2.4.18-pre7/fs/ufs/super.c.orig	Sat Jan 26 08:52:35 2002
+++ linux-2.4.18-pre7/fs/ufs/super.c	Sat Jan 26 08:53:18 2002
@@ -597,7 +597,11 @@
 	}
 	
 again:	
-	set_blocksize (sb->s_dev, block_size);
+	if (!set_blocksize (sb->s_dev, block_size)) {
+		printk(KERN_ERR "UFS: failed to set blocksize\n");
+		goto failed;
+	}
+
 	sb->s_blocksize = block_size;
 
 	/*

The Oops..
invalid operand: 0000
CPU:    0
EIP:    0010:[<c014e51e>]    Not tainted
EFLAGS: 00010282
eax: 0000001d   ebx: 00001640   ecx: c031eea4   edx: 00001c31
esi: 00000008   edi: 00000000   ebp: c156df18   esp: c87b1d98
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 970, stackpage=c87b1000)
Stack: c02eaf0f 00000894 00000000 c9a6d0c4 00000000 00003634 00000000 
00000008 
       c156df18 00000002 c014c4f7 c156df18 00000008 00000000 00000000 
00000000 
       c8c37a00 c014c807 c156df18 00000008 00000000 cc8d48ee c87b1dfc 
c037bca0 
Call Trace: [<c014c4f7>] [<c014c807>] [<cc8d48ee>] [<c0209584>] 
[<cc8d726d>] 
   [<c011a44b>] [<cc8d50ee>] [<c01ea216>] [<c01ea234>] [<c01529be>] 
[<c015119b>] 
   [<cc8da24c>] [<c015146b>] [<cc8da24c>] [<c0167f96>] [<c01185a0>] 
[<c01091dc>] 
   [<c016825b>] [<c01680ac>] [<c01688bf>] [<c01090eb>] 

Code: 0f 0b 59 5b b9 ff ff ff ff 89 f6 8d bc 27 00 00 00 00 41 89 

>>EIP; c014e51e <grow_buffers+6e/e0>   <=====
Trace; c014c4f7 <__getblk+27/40>
Trace; c014c807 <__bread+17/80>
Trace; cc8d48ee <[ufs]ufs_parse_options+29e/2c0>
Trace; c0209584 <blk_get_queue+24/30>
Trace; cc8d726d <[ufs]ubh_bread_uspi+5d/c0>
Trace; c011a44b <__wake_up+7b/e0>
Trace; cc8d50ee <[ufs]ufs_read_super+39e/e80>
Trace; c01ea216 <vsprintf+16/20>
Trace; c01ea234 <sprintf+14/20>
Trace; c01529be <bdevname+2e/40>
Trace; c015119b <get_sb_bdev+29b/360>
Trace; cc8da24c <[ufs]ufs_fs_type+0/34>
Trace; c015146b <do_kern_mount+5b/110>
Trace; cc8da24c <[ufs]ufs_fs_type+0/34>
Trace; c0167f96 <do_add_mount+76/140>
Trace; c01185a0 <do_page_fault+0/5e0>
Trace; c01091dc <error_code+34/3c>
Trace; c016825b <do_mount+15b/180>
Trace; c01680ac <copy_mount_options+4c/a0>
Trace; c01688bf <sys_mount+df/180>
Trace; c01090eb <system_call+33/38>
Code;  c014e51e <grow_buffers+6e/e0>
00000000 <_EIP>:
Code;  c014e51e <grow_buffers+6e/e0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c014e520 <grow_buffers+70/e0>
   2:   59                        pop    %ecx
Code;  c014e521 <grow_buffers+71/e0>
   3:   5b                        pop    %ebx
Code;  c014e522 <grow_buffers+72/e0>
   4:   b9 ff ff ff ff            mov    $0xffffffff,%ecx
Code;  c014e527 <grow_buffers+77/e0>
 9:   89 f6                     mov    %esi,%esi
Code;  c014e529 <grow_buffers+79/e0>
   b:   8d bc 27 00 00 00 00      lea    0x0(%edi,1),%edi
Code;  c014e530 <grow_buffers+80/e0>
  12:   41                        inc    %ecx
Code;  c014e531 <grow_buffers+81/e0>
  13:   89 00                     mov    %eax,(%eax)



