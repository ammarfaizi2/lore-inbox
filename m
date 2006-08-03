Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbWHCNgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbWHCNgp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 09:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWHCNgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 09:36:44 -0400
Received: from mx.seekport.net ([195.27.215.87]:62856 "EHLO
	webmail.seekport.net") by vger.kernel.org with ESMTP
	id S932506AbWHCNgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 09:36:43 -0400
Message-ID: <44D1FBE1.9010002@seekport.biz>
Date: Thu, 03 Aug 2006 15:36:33 +0200
From: Daniel Kowalewski <d.kowalewski@seekport.biz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20060628 Debian/1.7.8-1sarge7.1
X-Accept-Language: German, de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: reproducible reiserfs bug with kernel 2.6.17
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SEEKPORT-Spam-Score: -100.8 (---------------------------------------------------)
X-SEEKPORT-Spam-Report: Anti-SPAM analysis details: (-100.8 points, 4.5 required) AWL=-0.228,BAYES_00=-2.599,BIZ_TLD=2.013,NO_RELAYS=-0.001,USER_IN_WHITELIST=-100 autolearn=no)
X-SEEKPORT-Scan-Signature: defcd7fa13959b2e7db4944b66d9da87
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Probably I stumbled on a reiserfs race condition bug.

I get an infinite loop of messages like
"ReiserFS: md1: warning: vs-13060: reiserfs_update_sd: stat data of object [3 29 0x0 SD] (nlink == 1) not found (pos 1)"
at a certain time when writing data to a reiser filesystem with our application.


With debug information for reiserfs enabled I get this dump:


REISERFS: panic (device Null superblock): reiserfs[1942]: assertion !( vn->vn_mode == 'i' || vn->vn_mode == 'p' ) failed at fs/reiserfs/fix_node.c:237:check_left: vs-8055: invalid mode or balance condition failed


ksymoops 2.4.9 on i686 2.6.17.7-seekport.  Options used
      -V (default)
      -K (specified)
      -L (specified)
      -O (specified)
      -m /boot/System.map-2.6.17.7-seekport (default)

kernel BUG at fs/reiserfs/prints.c:362!
CPU:    0
EIP:    0060:[<c01a4c81>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282   (2.6.17.7-seekport #2)
eax: 000000dc   ebx: c03bb680   ecx: 00000001   edx: 00000286
esi: 00000000   edi: 00000140   ebp: 00000005   esp: e68bd980
ds: 007b   es: 007b   ss: 0068
Stack: c03c7aa0 c03bb680 c05064c0 000006ac e68bdb00 e084a000 c019d270 00000000
        c03c4060 00000796 000000ed c03a0c5d ded24d54 00000005 e084a01c 00000000
        e68bdb00 000006ac 0000000f c019eedb e68bdb00 00000000 000006ac 00000004
Call Trace:
  <c019d270> check_left+0x103/0x23f  <c019eedb> ip_check_balance+0x304/0xcce
  <c013bc34> activate_page+0xa2/0xa4  <c01a101c> fix_nodes+0x1f6/0x581
  <c01b16fa> reiserfs_paste_into_item+0xf1/0x1f0  <c0199c2b> reiserfs_allocate_blocks_for_region+0xa7a/0x16ee
  <c01ac737> pathrelse+0x29/0x81  <c019b35c> reiserfs_prepare_file_region_for_write+0x346/0x96b
  <c019ad6f> reiserfs_submit_file_region_for_write+0x18c/0x24d  <c019c090> reiserfs_file_write+0x70f/0x769
  <c0134e03> file_read_actor+0x0/0xec  <c011426f> find_busiest_group+0xd6/0x305
  <c019b981> reiserfs_file_write+0x0/0x769  <c01517fc> vfs_write+0x9e/0x10d
  <c015193c> sys_write+0x51/0x80  <c0102be3> syscall_call+0x7/0xb
Code: 40 01 00 00 89 04 24 e8 ff fc ff ff 89 d8 85 f6 c7 44 24 08 c0 64 50 c0 c7 04 24 a0 7a 3c c0 0f 45 c7 89 44 24 04 e8 8c 5a f7 ff <0f> 0b 6a 01 33 bc 3b c0 85 f6 c7 44 24 08 c0 64 50 c0 c7 04 24



 >>>>EIP; c01a4c81 <reiserfs_panic+51/76>   <=====


 >>>>ebx; c03bb680 <__func__.0+a706/6614a>
 >>>>esp; e68bd980 <pg0+2639c980/3fadd400>


Trace; c019d270 <check_left+103/23f>
Trace; c013bc34 <activate_page+a2/a4>
Trace; c01b16fa <reiserfs_paste_into_item+f1/1f0>
Trace; c01ac737 <pathrelse+29/81>
Trace; c019ad6f <reiserfs_submit_file_region_for_write+18c/24d>
Trace; c0134e03 <file_read_actor+0/ec>
Trace; c019b981 <reiserfs_file_write+0/769>
Trace; c015193c <sys_write+51/80>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c01a4c56 <reiserfs_panic+26/76>
00000000 <_EIP>:
Code;  c01a4c56 <reiserfs_panic+26/76>
    0:   40                        inc    %eax
Code;  c01a4c57 <reiserfs_panic+27/76>
    1:   01 00                     add    %eax,(%eax)
Code;  c01a4c59 <reiserfs_panic+29/76>
    3:   00 89 04 24 e8 ff         add    %cl,0xffe82404(%ecx)
Code;  c01a4c5f <reiserfs_panic+2f/76>
    9:   fc                        cld
Code;  c01a4c60 <reiserfs_panic+30/76>
    a:   ff                        (bad)
Code;  c01a4c61 <reiserfs_panic+31/76>
    b:   ff 89 d8 85 f6 c7         decl   0xc7f685d8(%ecx)
Code;  c01a4c67 <reiserfs_panic+37/76>
   11:   44                        inc    %esp
Code;  c01a4c68 <reiserfs_panic+38/76>
   12:   24 08                     and    $0x8,%al
Code;  c01a4c6a <reiserfs_panic+3a/76>
   14:   c0 64 50 c0 c7            shlb   $0xc7,0xffffffc0(%eax,%edx,2)
Code;  c01a4c6f <reiserfs_panic+3f/76>
   19:   04 24                     add    $0x24,%al
Code;  c01a4c71 <reiserfs_panic+41/76>
   1b:   a0 7a 3c c0 0f            mov    0xfc03c7a,%al
Code;  c01a4c76 <reiserfs_panic+46/76>
   20:   45                        inc    %ebp
Code;  c01a4c77 <reiserfs_panic+47/76>
   21:   c7 89 44 24 04 e8 8c      movl   $0xfff75a8c,0xe8042444(%ecx)
Code;  c01a4c7e <reiserfs_panic+4e/76>
   28:   5a f7 ff

This decode from eip onwards should be reliable

Code;  c01a4c81 <reiserfs_panic+51/76>
00000000 <_EIP>:
Code;  c01a4c81 <reiserfs_panic+51/76>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c01a4c83 <reiserfs_panic+53/76>
    2:   6a 01                     push   $0x1
Code;  c01a4c85 <reiserfs_panic+55/76>
    4:   33 bc 3b c0 85 f6 c7      xor    0xc7f685c0(%ebx,%edi,1),%edi
Code;  c01a4c8c <reiserfs_panic+5c/76>
    b:   44                        inc    %esp
Code;  c01a4c8d <reiserfs_panic+5d/76>
    c:   24 08                     and    $0x8,%al
Code;  c01a4c8f <reiserfs_panic+5f/76>
    e:   c0 64 50 c0 c7            shlb   $0xc7,0xffffffc0(%eax,%edx,2)
Code;  c01a4c94 <reiserfs_panic+64/76>
   13:   04 24                     add    $0x24,%al

EIP: [<c01a4c81>] reiserfs_panic+0x51/0x76 SS:ESP 0068:e68bd980
  <c011cbbf> do_exit+0x375/0x37a  <c0103f7a> do_trap+0x0/0x108
  <c01042fb> do_invalid_op+0x0/0xc3  <c01043a9> do_invalid_op+0xae/0xc3
  <c011547f> __wake_up+0x40/0x56  <c01a4c81> reiserfs_panic+0x51/0x76
  <c011aab5> release_console_sem+0xb0/0xb2  <c011a8cb> vprintk+0x1a3/0x26a
  <c021a33c> vsprintf+0x27/0x2b  <c01036e3> error_code+0x4f/0x54
  <c01a4c81> reiserfs_panic+0x51/0x76  <c019d270> check_left+0x103/0x23f
  <c019eedb> ip_check_balance+0x304/0xcce  <c013bc34> activate_page+0xa2/0xa4
  <c01a101c> fix_nodes+0x1f6/0x581  <c01b16fa> reiserfs_paste_into_item+0xf1/0x1f0
  <c0199c2b> reiserfs_allocate_blocks_for_region+0xa7a/0x16ee  <c01ac737> pathrelse+0x29/0x81
  <c019b35c> reiserfs_prepare_file_region_for_write+0x346/0x96b  <c019ad6f> reiserfs_submit_file_region_for_write+0x18c/0x24d
  <c019c090> reiserfs_file_write+0x70f/0x769  <c0134e03> file_read_actor+0x0/0xec
  <c011426f> find_busiest_group+0xd6/0x305  <c019b981> reiserfs_file_write+0x0/0x769
  <c01517fc> vfs_write+0x9e/0x10d  <c015193c> sys_write+0x51/0x80
  <c0102be3> syscall_call+0x7/0xb
Warning (Oops_read): Code line not seen, dumping what data is available

 >>>>EIP; c01a4c81 <reiserfs_panic+51/76>   <=====

1 warning issued.  Results may not be reliable.


The occurrence of this error seems to depend on the amount of data. The same
process has run hundreds of times without any problems but with a slightly
different amount of data. On the other hand we had this error twice
on different servers with different data.

With the source data from an affected server I am able to reproduce the
error on another server so it is unlikely that this a hardware error.

With sequentially writing 1 GB files using dd on the same partition
the error does not appear.

Environment:
SUN v65x Server (Intel based) with
2 * 2.8 Ghz Intel Pentium 4/Xeon Processors
2 GB RAM
SCSI Adaptec AIC-7902 U320 onboard
SCSI disks in MD raid 0 or raid 1 mode
the kernel is vanilla 2.6.17.7
( 2.6.12.2 or 2.6.16.20 are also affected )
gcc is 3.3.5


Please cc me if possible, I'm not subscribed.

Thanks,

Daniel Kowalewski

-- 
Daniel Kowalewski
Seekport Internet Technologies GmbH
Fraunhoferstr. 17, 82152 Martinsried, Germany
d.kowalewski@seekport.biz www.seekport.com
