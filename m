Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264886AbTAPEJk>; Wed, 15 Jan 2003 23:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266794AbTAPEJk>; Wed, 15 Jan 2003 23:09:40 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:30884 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264886AbTAPEJi>;
	Wed, 15 Jan 2003 23:09:38 -0500
Message-ID: <3E263285.2000204@us.ibm.com>
Date: Wed, 15 Jan 2003 20:18:13 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: lots of calls to __write/read_lock_failed
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running a webserver benchmark on 2.5.57, I saw some things in the 
profiles that I wasn't familliar with.  Here's readprofile | sort | tail:

    717 handle_IRQ_event                           7.7935
    732 do_gettimeofday                            5.4627
    755 __wake_up                                 10.7857
   1089 del_timer                                 11.8370
   1112 add_timer                                  7.8310
   1500 system_call                               34.0909
   1847 schedule                                   2.4759
   1873 kmap_atomic                               12.8288
267475 __write_lock_failed                     8358.5938
379837 __read_lock_failed                     18991.8500
1044613 poll_idle                             18010.5690
1704762 total                                    10.9631

I added a section at the ends of _raw_write_lock and _raw_read_lock 
that look like this:

{
         static int count = 0;
         if( ++count%50000 == 0 ) {
                 printk("%s:%s() %d\n", __stringify(KBUILD_BASENAME),
				__FUNCTION__, count );
                 dump_stack();
         }
}


  file_table:_raw_read_lock() 3300000
  Call Trace:
   [<c0152469>] fget+0x9d/0xa0
   [<c0152b27>] sys_fsync+0x21/0xbe
   [<c0151b53>] sys_writev+0x47/0x56
   [<c010931f>] syscall_call+0x7/0xb

filemap:_raw_read_lock() 1450000
  Call Trace:
   [<c0136937>] do_generic_mapping_read+0x411/0x43e
   [<c0136d98>] file_send_actor+0x0/0x74
   [<c0136e74>] generic_file_sendfile+0x68/0x76
   [<c0136d98>] file_send_actor+0x0/0x74
   [<c0151d48>] do_sendfile+0x1e6/0x28a
   [<c0136d98>] file_send_actor+0x0/0x74
   [<c0151e50>] sys_sendfile+0x64/0xcc
   [<c010931f>] syscall_call+0x7/0xb

  ip_output:_raw_read_lock() 2000000
  Call Trace:
   [<c02c90b2>] ip_finish_output2+0x154/0x226
   [<c02c7466>] ip_queue_xmit+0x3dc/0x4ce
   [<c011c71a>] default_wake_function+0x32/0x3e
   [<c011c75e>] __wake_up_common+0x38/0x58
   [<c02ddf24>] tcp_v4_send_check+0x54/0xe2
   [<c02d81b6>] tcp_transmit_skb+0x2be/0x448
   [<c02d54ca>] tcp_data_queue+0x23a/0x830
   [<c02da693>] tcp_send_ack+0x81/0xb2
   [<c02d68d1>] tcp_rcv_established+0x249/0x70e
   [<c02defd1>] tcp_v4_do_rcv+0x12d/0x132
   [<c02df452>] tcp_v4_rcv+0x47c/0x50c
   [<c02c4363>] ip_local_deliver_finish+0x9f/0x19e
   [<c02c4674>] ip_rcv_finish+0x212/0x29f
   [<c02b410e>] netif_receive_skb+0xc2/0x17c
   [<c02b4245>] process_backlog+0x7d/0x10c
   [<c02b4395>] net_rx_action+0xc1/0x178
   [<c01248e7>] do_softirq+0xb7/0xba
   [<c010b390>] do_IRQ+0xec/0xf8
   [<c0106eca>] default_idle+0x0/0x2e

time:_raw_write_lock() 1350000
Call Trace:
  [<c010f321>] timer_interrupt+0x99/0x9c
  [<c010b150>] handle_IRQ_event+0x38/0x5c
  [<c010b330>] do_IRQ+0x8c/0xf8
  [<c0106eca>] default_idle+0x0/0x2e
  [<c0106eca>] default_idle+0x0/0x2e
  [<c0109c8c>] common_interrupt+0x18/0x20
  [<c0106eca>] default_idle+0x0/0x2e
  [<c0106eca>] default_idle+0x0/0x2e
  [<c0106ef4>] default_idle+0x2a/0x2e
  [<c0106f6b>] cpu_idle+0x39/0x42
  [<c01212a5>] printk+0x15d/0x190

-- 
Dave Hansen
haveblue@us.ibm.com

