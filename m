Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316964AbSFFNeJ>; Thu, 6 Jun 2002 09:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316968AbSFFNeI>; Thu, 6 Jun 2002 09:34:08 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:27797 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S316964AbSFFNdO>; Thu, 6 Jun 2002 09:33:14 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [RFC] 4KB stack + irq stack for x86
To: bcrl@redhat.com
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF4D14A3A3.6910F5CD-ONC1256BD0.004905F5@de.ibm.com>
From: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Date: Thu, 6 Jun 2002 15:32:48 +0200
X-MIMETrack: Serialize by Router on D12ML028/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 06/06/2002 15:32:58
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:

>Which is, honestly, a bug. The IO subsystem should not be capable of
>engaging in such deep recursion. ext2/ext3 barely allocate anything
>on the stack (0x90 bytes at most in only a couple of calls), the vm
>is in a similar state, and even the network stack's largest allocations
>are in syscalls and timer code. Face it, the majority of code that is
>or could cause problems are things that probably need fixing anyways.

Just FYI here's a stack trace of a real-world stack overflow
situation we caught on s390 (before we switched to separate
interrupt stacks).

What goes on is this:  system call does copy_from_user, which causes
a page fault, which goes through mm, filesystem, and buffer cache code,
calls alloc_pages there, which is out of memory and goes through
try_to_free_pages and the whole swap-out stack.  At this time an
interrupt hits, followed by softirq processing.  This runs the complete
TCP/IP stack and network device driver.  This finally calls into kfree,
which is the last straw ...  (Of course another interrupt could still
have occured at this point.)

Of course, the situation is particularly bad on s390, because every
function call needs at least 96 bytes on the stack (due to the register
save areas required by our ABI).

48 kfree                        [0x3bfae] SP=0x31ae7c8, FP=0x31ae828, SIZE=112
47 skb_release_data+170        [0x1ad632] SP=0x31ae838, FP=0x31ae898, SIZE=96
46 kfree_skbmem+54             [0x1ad672] SP=0x31ae898, FP=0x31ae8f8, SIZE=104
45 __kfree_skb+262             [0x1ad7ea] SP=0x31ae900, FP=0x31ae960, SIZE=96
44 lcs_txpacket+712            [0x18b63c] SP=0x31ae960, FP=0x31ae9c0, SIZE=120
43 qdisc_restart+184           [0x1b9ec0] SP=0x31ae9d8, FP=0x31aea38, SIZE=104
42 dev_queue_xmit+466          [0x1b18fe] SP=0x31aea40, FP=0x31aeaa0, SIZE=96
41 ip_output+340               [0x1c3cd8] SP=0x31aeaa0, FP=0x31aeb00, SIZE=96
40 ip_build_and_send_pkt+542   [0x1c38fe] SP=0x31aeb00, FP=0x31aeb60, SIZE=104
39 tcp_v4_send_synack+196      [0x1dbde8] SP=0x31aeb68, FP=0x31aebc8, SIZE=96
38 tcp_v4_conn_request+1030    [0x1dc25e] SP=0x31aebc8, FP=0x31aec28, SIZE=536
37 tcp_rcv_state_process+308   [0x1d44c4] SP=0x31aede0, FP=0x31aee40, SIZE=104
36 tcp_v4_do_rcv+292           [0x1dcb0c] SP=0x31aee48, FP=0x31aeea8, SIZE=96
35 tcp_v4_rcv+1436             [0x1dd124] SP=0x31aeea8, FP=0x31aef08, SIZE=96
34 ip_local_deliver+370        [0x1c090e] SP=0x31aef08, FP=0x31aef68, SIZE=96
33 ip_rcv+1122                 [0x1c0e26] SP=0x31aef68, FP=0x31aefc8, SIZE=112
32 net_rx_action+634           [0x1b241a] SP=0x31aefd8, FP=0x31af038, SIZE=144
31 do_softirq+168               [0x23ac8] SP=0x31af068, FP=0x31af0c8, SIZE=112
30 io_return_bh                 [0x13f96] SP=0x31af0d8, FP=0x31af138, SIZE=248
29 try_to_swap_out              [0x3dac8] SP=0x31af1d0, FP=0x31af230, SIZE=104
28 swap_out_pmd+320             [0x3de9c] SP=0x31af238, FP=0x31af298, SIZE=104
27 swap_out_vma+208             [0x3df8c] SP=0x31af2a0, FP=0x31af300, SIZE=144
26 swap_out_mm+130              [0x3e05a] SP=0x31af330, FP=0x31af390, SIZE=96
25 swap_out+268                 [0x3e19c] SP=0x31af390, FP=0x31af3f0, SIZE=96
24 refill_inactive+158          [0x3fbf2] SP=0x31af3f0, FP=0x31af450, SIZE=96
23 do_try_to_free_pages+132     [0x3fcb4] SP=0x31af450, FP=0x31af4b0, SIZE=96
22 try_to_free_pages+66         [0x3feaa] SP=0x31af4b0, FP=0x31af510, SIZE=96
21 __alloc_pages+580            [0x40f3c] SP=0x31af510, FP=0x31af570, SIZE=104
20 _alloc_pages+54              [0x40cee] SP=0x31af578, FP=0x31af5d8, SIZE=96
19 grow_buffers+140             [0x4dcb8] SP=0x31af5d8, FP=0x31af638, SIZE=96
18 refill_freelist+96           [0x4a7f4] SP=0x31af638, FP=0x31af698, SIZE=96
17 getblk+644                   [0x4b1d0] SP=0x31af698, FP=0x31af6f8, SIZE=96
16 bread+56                     [0x4b69c] SP=0x31af6f8, FP=0x31af758, SIZE=104
15 ext2_get_branch+156          [0x74fa0] SP=0x31af760, FP=0x31af7c0, SIZE=104
14 ext2_get_block+202           [0x753d2] SP=0x31af7c8, FP=0x31af828, SIZE=208
13 block_read_full_page+320     [0x4c788] SP=0x31af898, FP=0x31af8f8, SIZE=144
12 ext2_readpage+46             [0x758c6] SP=0x31af928, FP=0x31af988, SIZE=96
11 read_cluster_nonblocking+346 [0x34d52] SP=0x31af988, FP=0x31af9e8, SIZE=96
10 filemap_nopage+576           [0x36600] SP=0x31af9e8, FP=0x31afa48, SIZE=112
 9 do_no_page+142               [0x3198a] SP=0x31afa58, FP=0x31afab8, SIZE=96
 8 handle_mm_fault+262          [0x31bd6] SP=0x31afab8, FP=0x31afb18, SIZE=120
 7 do_page_fault+722            [0x12d5a] SP=0x31afb30, FP=0x31afb90, SIZE=104
 6 pgm_dn                       [0x13ef8] SP=0x31afb98, FP=0x31afbf8, SIZE=248
 5 tcp_sendmsg                 [0x1c9ed0] SP=0x31afc90, FP=0x31afcf0, SIZE=176
 4 inet_sendmsg+84             [0x1ea538] SP=0x31afd40, FP=0x31afda0, SIZE=96
 3 sock_sendmsg+132            [0x1a97c8] SP=0x31afda0, FP=0x31afe00, SIZE=120
 2 sock_write+186              [0x1a9a1e] SP=0x31afe18, FP=0x31afe78, SIZE=136
 1 sys_write+214                [0x47d2e] SP=0x31afea0, FP=0x31aff00, SIZE=104
 0 pgm_system_call+34           [0x138c0] SP=0x31aff08, FP=0x31aff68, SIZE=248


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com

