Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268724AbUHaPe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268724AbUHaPe0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 11:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268726AbUHaPeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 11:34:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53376 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268724AbUHaPeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 11:34:02 -0400
Date: Tue, 31 Aug 2004 11:33:43 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH]SELinux performance improvement by RCU (Re: RCU issue
 with SELinux)
In-Reply-To: <066f01c48e82$f4ec3530$f97d220a@linux.bs1.fc.nec.co.jp>
Message-ID: <Xine.LNX.4.44.0408311125370.27231-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've performed some benchmarking and profiling of these patches, comparing 
the vanilla kernel with SELinux disabled, the same with SELinux enabled, 
and then SELinux enabled with the RCU patches.

The benchmarks I used are apachebench, lmbench, dbench and webstone.

It seems that the patches are providing good scalability from around four
CPUs and up, although baseline performance has not been significantly 
improved.

This benchmarking also confirms some suspected network-specific
performance issues, which need addressing separately.  e.g. port and node 
caches need to be implemented.

Results + before/after profiling below.


- James
-- 
James Morris
<jmorris@redhat.com>



test system : 8 way 900 MHz Xeon, 4G RAM, 3 x gigabit interfaces.

orig     = vanilla 2.6.8.1 kernel
nec1     = 2.6.8.1 kernel with nec patches
disabled = SELinux is disabled
enabled  = SELinux is enabled (strict policy)

----------------------------------------------------------------------------
apachebench
----------------------------------------------------------------------------

Configuration: 5k file 100k times via localhost.

Transfer rate in MB/s:

# Clients       1       2       4       8
-------------------------------------------------
orig disabled : 12.269  22.339  23.610  20.867
orig enabled  :  9.319  16.594  17.532  16.322
nec1 enabled  :  9.783  17.573  18.373  17.006


----------------------------------------------------------------------------
dbench
----------------------------------------------------------------------------

Configuration: standard client.txt, ext2, average of 10 runs each.

Througput in MB/s:

# Clients       1      2      3      4      5      6      7      8
----------------------------------------------------------------------
orig disabled : 156.8  279.2  383.7  470.0  547.9  610.5  651.7  713.7
orig enabled  : 146.2  260.0  359.1  418.8  450.3  503.6  489.5  446.2
nec1 enabled  : 146.1  261.7  356.9  451.1  515.3  596.5  629.4  684.2


----------------------------------------------------------------------------
Webstone 2.5
----------------------------------------------------------------------------

Configuration:
- two physical clients, each with private gigabit to server.
- standard fileset
- two mins per run, one iteration

Server throughput in Mb/s:

# Clients        2      4       8       16      32
---------------------------------------------------------
orig disabled  : 66.55  302.40  380.16  421.40  434.08
orig enabled   : 64.96  276.34  358.87  388.73  389.43
nec1 enabled   : 64.33  282.50  367.29  403.66  409.65
---------------------------------------------------------


----------------------------------------------------------------------------
lmbench 3.0
----------------------------------------------------------------------------

Basic system parameters
------------------------------------------------------------------------------
Host                 OS Description              Mhz  tlb  cache  mem   scal
                                                     pages line   par   load
                                                           bytes  
--------- ------------- ----------------------- ---- ----- ----- ------ ----
xeon4.lab orig--disable       i686-pc-linux-gnu  898          32           1
xeon4.lab orig--enable        i686-pc-linux-gnu  898          32           1
xeon4.lab nec1--enable        i686-pc-linux-gnu  898          32           1

Processor, Processes - times in microseconds - smaller is better
------------------------------------------------------------------------------
Host                 OS  Mhz null null      open slct sig  sig  fork exec sh  
                             call  I/O stat clos TCP  inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
xeon4.lab orig--disable  898 0.24 0.40 5.13 5.90 25.2 0.99 3.98 185. 1006 2853
xeon4.lab orig--enable   898 0.24 0.81 8.62 9.91 23.1 0.99 3.97 189. 1038 3027
xeon4.lab nec1--enable   898 0.24 0.75 8.54 9.65 23.1 0.99 4.02 187. 987. 3073

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------------------
Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                         ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ------ ------ ------ ------ ------ ------- -------
xeon4.lab orig--disable   11.3   21.5   20.1   17.3   14.0    11.4    10.8
xeon4.lab orig--enable    21.0   28.2   26.4   17.5   21.3 8.92000    17.4
xeon4.lab nec1--enable    11.4   27.2 2.5600   13.1   24.0 7.62000    11.8

*Local* Communication latencies in microseconds - smaller is better
---------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
xeon4.lab orig--disable  11.3  26.2 25.6              52.2        95.
xeon4.lab orig--enable   21.0  26.5 45.1              97.2       148.
xeon4.lab nec1--enable   11.4  27.6 45.8              71.5       142.

File & VM system latencies in microseconds - smaller is better
-------------------------------------------------------------------------------
Host                 OS   0K File      10K File     Mmap    Prot   Page   100fd
                        Create Delete Create Delete Latency Fault  Fault  selct
--------- ------------- ------ ------ ------ ------ ------- ----- ------- -----
xeon4.lab orig--disable   31.5   23.5   86.3   48.1  1778.0 0.228 2.03950  16.9
xeon4.lab orig--enable    55.7   36.0  111.7   57.5  1668.0 0.288 1.99780  15.8
xeon4.lab nec1--enable    55.3   35.0  112.8   56.3  1715.0 0.160 2.03220  15.6

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
xeon4.lab orig--disable 519. 163. 181.  226.9  256.9  134.3  128.1 257. 199.7
xeon4.lab orig--enable  513. 163. 122.  226.4  256.9  134.3  129.5 256. 197.5
xeon4.lab nec1--enable  504. 294. 121.  226.7  257.2  134.1  129.7 257. 200.4


----------------------------------------------------------------------------
Profiling
----------------------------------------------------------------------------

apachebench (8 clients, 100k iter, 5k file, localhost):

orig-enable:

253368 total                                      0.1025
187668 default_idle                             2932.3125
  6024 avc_has_perm_noaudit                      12.5500
  4124 security_port_sid                         25.7750
  3784 finish_task_switch                        29.5625
  2899 .text.lock.avc                            14.7157
  1717 tcp_v4_rcv                                 0.7107
  1462 __wake_up                                 18.2750
  1032 avc_audit                                  0.3395
  1023 ip_queue_xmit                              0.6208
   984 selinux_socket_sock_rcv_skb                1.3667
   927 tcp_transmit_skb                           0.5315
   788 __kfree_skb                                2.3452
   750 __copy_user_intel                          4.2614
   680 security_node_sid                          2.6562
   657 netif_rx                                   1.4159
   653 tcp_recvmsg                                0.3549
   644 alloc_skb                                  2.5156
   582 ip_finish_output2                          1.1734
   563 __d_lookup                                 1.8520
   541 tcp_rcv_established                        0.2348
   539 tcp_poll                                   1.2957
   524 sel_netif_lookup                           2.0469
   523 avc_has_perm                               4.2520
   517 __mod_timer                                1.5387
   513 atomic_dec_and_lock                        7.7727
   506 sysenter_past_esp                          4.4779
   500 skb_release_data                           3.4722
   493 dev_queue_xmit                             0.6556
   490 kmem_cache_alloc                           6.1250
   482 lock_sock                                  6.0250
   474 try_to_wake_up                             0.6733
   461 __kmalloc                                  3.2014
   425 fget                                       6.6406
   413 tcp_clean_rtx_queue                        0.4232
   413 __copy_to_user_ll                          3.6875
   408 sel_netif_find                             6.3750
   405 .text.lock.sock                            2.6299
   403 skb_copy_bits                              0.6458
   398 kmem_cache_free                            4.1458
  
nec1-enable:

232223 total                                      0.0940
177690 default_idle                             2776.4062
  3729 finish_task_switch                        29.1328
  3656 security_port_sid                         22.8500
  1545 tcp_v4_rcv                                 0.6395
  1422 __wake_up                                 17.7750
   979 selinux_socket_sock_rcv_skb                1.3597
   924 ip_queue_xmit                              0.5607
   903 tcp_transmit_skb                           0.5178
   863 avc_lookup                                 4.4948
   752 __copy_user_intel                          4.2727
   722 memcpy                                    11.2812
   720 __kfree_skb                                2.1429
   714 avc_has_perm_noaudit                       2.2313
   676 tcp_recvmsg                                0.3674
   632 netif_rx                                   1.3621
   598 security_node_sid                          2.3359
   595 alloc_skb                                  2.3242
   547 __mod_timer                                1.6280
   507 __d_lookup                                 1.6678
   489 sysenter_past_esp                          4.3274
   485 skb_release_data                           3.3681
   484 tcp_rcv_established                        0.2101
   480 tcp_poll                                   1.1538
   474 ip_finish_output2                          0.9556
   468 try_to_wake_up                             0.6648
   467 atomic_dec_and_lock                        7.0758
   431 avc_has_perm                               3.5328
   420 tcp_create_openreq_child                   0.3125
   415 lock_sock                                  5.1875
   414 __copy_to_user_ll                          3.6964
   410 skb_copy_bits                              0.6571
   410 sel_netif_lookup                           1.6016
   407 fget                                       6.3594
   398 .text.lock.sock                            2.5844
   397 tcp_clean_rtx_queue                        0.4068
   397 dev_queue_xmit                             0.5279
   392 do_gettimeofday                            1.8846
   362 sel_netif_find                             5.6562
   362 selinux_ip_postroute_last                  0.5518


dbench (8 clients, 10 iter):

orig-enable:

432070 total                                      0.1749
125306 .text.lock.avc                           636.0711
 48451 __copy_user_intel                        275.2898
 34015 __copy_user_zeroing_intel                193.2670
 30862 avc_has_perm_noaudit                      64.2958
 27203 __copy_to_user_ll                        242.8839
 26618 __copy_from_user_ll                      237.6607
 21745 avc_audit                                  7.1530
 18133 default_idle                             283.3281
  6536 __d_lookup                                21.5000
  4034 link_path_walk                             1.0962
  3782 find_get_page                             47.2750
  3280 atomic_dec_and_lock                       49.6970
  2982 do_generic_mapping_read                    2.8673
  2931 kmap_atomic                               20.3542
  2504 __block_prepare_write                      2.3712
  2483 path_lookup                                6.7473
  1860 inode_has_perm                            12.9167
  1847 buffered_rmqueue                           3.3952
  1719 generic_file_aio_write_nolock              0.5165
  1713 file_move                                 26.7656
  1441 avc_has_perm                              11.7154
  1258 current_kernel_time                       15.7250
  1225 sysenter_past_esp                         10.8407
  1198 generic_commit_write                       8.3194
  1165 __find_get_block                           6.0677
  1123 put_page                                   7.7986
  1097 wake_up_page                              13.7125
  1092 page_address                               6.2045
  1074 find_lock_page                             6.1023
  1039 selinux_file_permission                    2.5975
  1030 __block_commit_write                       4.9519
   952 kmem_cache_free                            9.9167
   931 kmem_cache_alloc                          11.6375
   916 do_page_cache_readahead                    2.2019
   899 in_group_p                                 7.0234
   855 block_invalidatepage                       3.5625
   845 file_read_actor                            3.5208
   800 selinux_inode_permission                   3.8462
   782 find_get_pages                             6.9821

nec1-enable:

275604 total                                      0.1115
 55272 __copy_user_intel                        314.0455
 36716 __copy_user_zeroing_intel                208.6136
 29933 __copy_from_user_ll                      267.2589
 29544 __copy_to_user_ll                        263.7857
 25789 default_idle                             402.9531
  4419 __d_lookup                                14.5362
  3636 find_get_page                             45.4500
  2800 do_generic_mapping_read                    2.6923
  2788 avc_has_perm_noaudit                       8.7125
  2768 link_path_walk                             0.7522
  2766 __block_prepare_write                      2.6193
  2706 path_lookup                                7.3533
  2549 kmap_atomic                               17.7014
  2282 atomic_dec_and_lock                       34.5758
  1935 buffered_rmqueue                           3.5570
  1745 generic_file_aio_write_nolock              0.5243
  1614 inode_has_perm                            11.2083
  1344 generic_commit_write                       9.3333
  1238 current_kernel_time                       15.4750
  1190 sysenter_past_esp                         10.5310
  1184 file_move                                 18.5000
  1172 __find_get_block                           6.1042
  1141 wake_up_page                              14.2625
  1098 avc_lookup                                 5.7188
  1083 __block_commit_write                       5.2067
  1033 put_page                                   7.1736
  1027 in_group_p                                 8.0234
  1018 find_lock_page                             5.7841
   992 page_address                               5.6364
   990 selinux_file_permission                    2.4750
   930 memcpy                                    14.5312
   888 block_invalidatepage                       3.7000
   855 file_read_actor                            3.5625
   846 kmem_cache_free                            8.8125
   828 free_hot_cold_page                         2.8750
   809 kmem_cache_alloc                          10.1125
   798 find_get_pages                             7.1250
   793 ext2_free_branches                         1.5988
   774 avc_has_perm                               6.3443
  


