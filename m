Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbTEKPkG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 11:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbTEKPkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 11:40:05 -0400
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:43936 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S261722AbTEKPjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 11:39:46 -0400
Date: Sun, 11 May 2003 19:52:27 +0400
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: oops and memory leak with uml-patch-2.5.67-1
Message-ID: <20030511155227.GB14542@tentacle.sectorb.msk.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Organization: Moscow State Univ., Dept. of Mechanics and Mathematics
X-Operating-System: Linux 2.4.21-pre2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

Hi!

I tried to play with development kernels (v 2.5.67 and 2.5.69) with UML
but found that they are unusable to me.

Here's what I get with 2.5.67 + uml-patch-2.5.67-1 just after boot

uml1:~# uname -a
Linux uml1.sectorb.msk.ru 2.5.67-1um #1 SMP Sat May 10 15:31:43 MSD 2003
i686 un
known
uml1:~# cat /proc/meminfo 
MemTotal:        28360 kB
MemFree:         18576 kB
Buffers:           708 kB
Cached:           3712 kB
SwapCached:          0 kB
Active:           3864 kB
Inactive:         1508 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        28360 kB
LowFree:         18576 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:             204 kB
Writeback:           0 kB
Mapped:           2184 kB
Slab:             1432 kB
Committed_AS:     1120 kB
PageTables:        124 kB
ReverseMaps:      1450
uml1:~# cat /proc/slabinfo | grep task
task_struct          144    144   1724   36   36    2 :   54   27

Now starting test load:

uml1:~# while /bin/true ; do /bin/true ; done

After a minute I get OOM and oops:

Out of Memory: Killed process 129 (atd).
buffer layer error at fs/buffer.c:127
Pass this trace through ksymoops for reporting
Call Trace: [<a0078bbe>] [<a0078ce3>] [<a000bfa7>] [<a002fd2c>]
[<a002fd2c>] 
   [<a007aacb>] [<a00fc16c>] [<a007b3e1>] [<a00bfe1c>] [<a005a987>]
[<a00c01d5>]
 
   [<a00bfe1c>] [<a005d775>] [<a0010e40>] [<a0010e34>] [<a0010e40>]
[<a020a27f>]
 
   [<a020a27f>] [<a0016b3f>] [<a0016af1>] [<a005dfd7>] [<a0016ad6>]
[<a000c452>]
 
   [<a000c427>] [<a000bfa7>] [<a002b260>] [<a0019324>] [<a001a18a>]
[<a0016b28>]
 
   [<a005e1af>] [<a005e08c>] [<a0077440>] [<a0077647>] [<a00160f3>]
[<a0016032>]
 
   [<a0077784>] [<a0010dc9>] [<a00777f3>] [<a0018fc5>] [<a0010e40>]
[<a0010e34>]
 
   [<a0010e40>] [<a0010e34>] [<a001504a>] [<a001907a>] [<a0019071>]
[<a00169e9>]
 
   [<a0010e8c>] [<a001a0f9>] [<a001a0e9>] [<a0018379>] [<a0018358>]
[<a0016a0b>]
 
   [<a020a188>] 
Out of Memory: Killed process 137 (bash).
bash: page allocation failure. order:2, mode:0xd0

Decoded oops and kernel config attached.
After that it can be found that all memory is gone:

uml1:~# cat /proc/meminfo 
MemTotal:        28360 kB
MemFree:           640 kB
Buffers:            52 kB
Cached:            468 kB
SwapCached:          0 kB
Active:           1112 kB
Inactive:          372 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        28360 kB
LowFree:           640 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:           1344 kB
Slab:             3672 kB
Committed_AS:     1032 kB
PageTables:        112 kB
ReverseMaps:       359
uml1:~# cat /proc/slabinfo | grep task
task_struct         1368   1368   1724  342  342    2 :   54   27


I have tried to merge uml-patch with kernel 2.5.69, it runs and gives no
oops, but memory leak is still there.

I'm willing to run any tests and to help debugging someway but I don't
know how to start.

:wq
                                        With best regards, 
                                           Vladimir Savkin. 


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline; filename=OOPS-DECODED

$ ksymoops -v ./linux -K -L -O -M < ../OOPS1 
ksymoops 2.4.5 on i686 2.4.21-pre2.  Options used
     -v ./linux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -M (specified)

Call Trace: [<a0078bbe>] [<a0078ce3>] [<a0079945>] [<a000bfa7>] [<a002fd2c>] 
   [<a002fd2c>] [<a007aacb>] [<a00fc16c>] [<a007b3e1>] [<a00bfe1c>] [<a005a987>] 
   [<a00c01d5>] [<a00bfe1c>] [<a005d775>] [<a013a977>] [<a013aa88>] [<a020a27f>] 
   [<a0016b3f>] [<a002b1e9>] [<a0016af1>] [<a005dfd7>] [<a0016ad6>] [<a000c427>] 
   [<a002b260>] [<a0019324>] [<a000bfa7>] [<a001a18a>] [<a0016b28>] [<a005e1af>] 
   [<a005e08c>] [<a0077440>] [<a0077647>] [<a00160f3>] [<a0016032>] [<a0077784>] 
   [<a0010dc9>] [<a00777f3>] [<a0018fc5>] [<a0010e40>] [<a0010e34>] [<a001504a>] 
   [<a001907a>] [<a0019071>] [<a00169e9>] [<a0010e8c>] [<a001a0f9>] [<a001a0e9>] 
   [<a0018379>] [<a0018358>] [<a0016a0b>] [<a020a188>] 
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; a0078bbe <__buffer_error+3e/40>
Trace; a0078ce3 <__wait_on_buffer+6f/b0>
Trace; a0079945 <create_buffers+21/9c>
Trace; a000bfa7 <region_va+13/24>
Trace; a002fd2c <autoremove_wake_function+0/40>
Trace; a002fd2c <autoremove_wake_function+0/40>
Trace; a007aacb <__block_prepare_write+31b/440>
Trace; a00fc16c <radix_tree_node_alloc+1c/6c>
Trace; a007b3e1 <block_prepare_write+21/38>
Trace; a00bfe1c <ext2_get_block+0/350>
Trace; a005a987 <add_to_page_cache+4f/104>
Trace; a00c01d5 <ext2_prepare_write+19/1c>
Trace; a00bfe1c <ext2_get_block+0/350>
Trace; a005d775 <generic_file_aio_write_nolock+9dd/11cc>
Trace; a013a977 <kfree_skbmem+6f/a0>
Trace; a013aa88 <__kfree_skb+e0/e8>
Trace; a020a27f <sigemptyset+2f/3c>
Trace; a0016b3f <__do_copy+17/1c>
Trace; a002b1e9 <os_map_memory+39/50>
Trace; a0016af1 <__do_user_copy+41/78>
Trace; a005dfd7 <generic_file_write_nolock+73/90>
Trace; a0016ad6 <__do_user_copy+26/78>
Trace; a000c427 <map_memory+1b/50>
Trace; a002b260 <os_unmap_memory+14/2f>
Trace; a0019324 <fix_range+164/1f8>
Trace; a000bfa7 <region_va+13/24>
Trace; a001a18a <__do_copy_from_user+2a/44>
Trace; a0016b28 <__do_copy+0/1c>
Trace; a005e1af <generic_file_writev+33/48>
Trace; a005e08c <generic_file_write+0/5c>
Trace; a0077440 <do_readv_writev+bc/36c>
Trace; a0077647 <do_readv_writev+2c3/36c>
Trace; a00160f3 <flush_tlb_range+23/34>
Trace; a0016032 <flush_tlb_page+22/24>
Trace; a0077784 <vfs_writev+4c/50>
Trace; a0010dc9 <change_sig+45/64>
Trace; a00777f3 <sys_writev+2b/40>
Trace; a0018fc5 <execute_syscall_tt+121/188>
Trace; a0010e40 <change_signals+58/80>
Trace; a0010e34 <change_signals+4c/80>
Trace; a001504a <execute_syscall+26/28>
Trace; a001907a <syscall_handler_tt+4a/98>
Trace; a0019071 <syscall_handler_tt+41/98>
Trace; a00169e9 <usr2_handler+1d/20>
Trace; a0010e8c <unblock_signals+10/14>
Trace; a001a0f9 <Letext+9d/f6>
Trace; a001a0e9 <Letext+8d/f6>
Trace; a0018379 <finish_fork_handler+12d/130>
Trace; a0018358 <finish_fork_handler+10c/130>
Trace; a0016a0b <sig_handler+1f/34>
Trace; a020a188 <__restore+0/8>


1 warning issued.  Results may not be reliable.


--E39vaYmALEf/7YXx
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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
C00BCdF5p76wPt38H4R55h9MIAAA

--E39vaYmALEf/7YXx--
