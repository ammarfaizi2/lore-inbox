Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267542AbTGRTRs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 15:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270272AbTGRTRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 15:17:48 -0400
Received: from ip-66-80-117-3.nyc.megapath.net ([66.80.117.3]:22744 "EHLO
	longsword.omniti.com") by vger.kernel.org with ESMTP
	id S267542AbTGRTRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 15:17:46 -0400
Message-ID: <3F184E06.5070200@omniti.com>
Date: Fri, 18 Jul 2003 15:44:06 -0400
From: Robert Scussel <listuser@omniti.com>
Reply-To: rscuss@omniti.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel OOPS
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Background Information:

  We are currently writing about 1MB per second of data, and creating 
and deleting about 600+ inodes per second.  The following OOPS shows 
that the problem occurs in the 2.4.20-18.7smp kernel.  Tracing the code, 
it appears that if inode_has_buffers(inode) returns true then the BUG is 
thrown.

We are running with ext3 fs, and my guess would be that the problem 
exists in one of the following situations:

  The process grows, to the point where it is using more memory, and it 
tickles something in the virtual memory which corrupts the 
inode->i_dirty_buffers list so that the i_dirty_buffers are in fact not 
empty.  ( This is a conjecture based on the fact that the ext3 
journaling doesn't store the i_dirty_buffers info with the inode itself ).
 
  The other possibility is that such a high I/O rate is somehow 
corrupting the journaling, causeing the same type of issue.

Any hints/suggestions/input  would be appreciated.

Thanks

------------[ cut here ]------------
kernel BUG at inode.c:126!
invalid operand: 0000
e1000 ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables
usb-ohci usbcore ext3 jbd aacraid sd_mod scsi_mod  
CPU:    0
EIP:    0010:[<c015b840>]    Not tainted
EFLAGS: 00010202

EIP is at destroy_inode [kernel] 0x10 (2.4.20-18.7smp)
eax: 00000001   ebx: d913ab80   ecx: 00000001   edx: d913ab80
esi: d913ab80   edi: f8859b00   ebp: dd330a80   esp: c4667ef8
ds: 0018   es: 0018   ss: 0018
Process ecelerity (pid: 17532, stackpage=c4667000)
Stack: d913ab80 c015d0f5 d913ab80 ffffffff e41d2980 dd330b00 c024a7cc
dd330a80 
       d913ab80 e41d2980 c015aec6 d913ab80 dd330b00 c4666000 fffffff0
e41d2980 
       c4666000 00000000 c01530f0 dd330a80 00000000 d6706780 c4667f9c
e41d2980 
Call Trace:   [<c015d0f5>] iput [kernel] 0x275 (0xc4667efc))
[<c015aec6>] d_delete [kernel] 0x66 (0xc4667f20))
[<c01530f0>] vfs_unlink [kernel] 0x1e0 (0xc4667f40))
[<c0150b80>] cached_lookup [kernel] 0x10 (0xc4667f58))
[<c0151c3a>] lookup_hash [kernel] 0x4a (0xc4667f68))
[<c01531b9>] sys_unlink [kernel] 0x89 (0xc4667f88))
[<c0108be3>] system_call [kernel] 0x33 (0xc4667fc0))


Code: 0f 0b 7e 00 ba 95 25 c0 8b 83 9c 00 00 00 8b 40 20 8b 40 04 



