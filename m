Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWFKRwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWFKRwy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 13:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWFKRwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 13:52:54 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:28553 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP
	id S1750719AbWFKRwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 13:52:54 -0400
Mime-Version: 1.0
Message-Id: <a06230918c0b207f6d762@[129.98.90.227]>
Date: Sun, 11 Jun 2006 13:52:21 -0400
To: linux-kernel@vger.kernel.org
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Kernel 2.6.17-rc5 under amd64 may be hanging I/O, [Was] Re: [Q]
 What would cause fsck running on a drbd device to just stop?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that kernel 2.6.17-rc5 under amd64 may be hanging I/O
processes spontaneously at random.

Our setup here uses drbd (ver. 0.7.19), which is a network RAID
kernel module, and initially I was fscking (ext3) filesystems, which
are on drbd devices, and the fsck just stopped spontaneously on the
two of them.

Today, I tried copying a directory on the command line with cp -a on
this computer (on a drbd-managed device) and then in mid-copy I tried
to abort the process with control-C. It did not abort. I tried
killing it with kill and then with kill -9. It turns out that the
process had died, but is still left in ps.

Anyway, I tried bringing down the peer and bringing it back up and it stalled.

I also had an emerge sync (i.e., the Gentoo update mechanism) going
and it too got stuck, but it doesn't, or at least shouldn't affect
drbd disks, implying this is not a drbd bug, but a kernel bug.

>* what are the numbers in /proc/drbd

This is how it appears long after the copy hang and I stopped and
just restarted drbd on the peer. The output from then hanging
computer:


version: 0.7.19 (api:78/proto:74)
SVN Revision: 2212 build by root@thewarehouse1, 2006-05-28 17:54:59
   0: cs:SyncSource st:Primary/Secondary ld:Consistent
      ns:844864 nr:0 dw:325684 dr:940453 al:200 bm:123 lo:0 pe:0 ua:13 ap:0
          [===================>] sync'ed:100.0% (52/52)K
          stalled
   1: cs:SyncSource st:Primary/Secondary ld:Consistent
      ns:41686716 nr:0 dw:41166664 dr:57457996 al:76392 bm:94 lo:0 
pe:0 ua:0 ap:0
          [===================>] sync'ed:100.0% (120/120)K
          stalled
   2: cs:SyncSource st:Primary/Secondary ld:Consistent
      ns:45970636 nr:0 dw:45451468 dr:27302312 al:45571 bm:63 lo:0 
pe:0 ua:0 ap:0
          [===================>] sync'ed:100.0% (1020/1020)K
          stalled
   3: cs:PausedSyncS st:Primary/Secondary ld:Consistent
      ns:284957716 nr:0 dw:284450048 dr:251121904 al:266659 bm:759 lo:0
pe:0 ua:0 ap:0
   4: cs:WFReportParams st:Primary/Unknown ld:Consistent
      ns:92534448 nr:0 dw:133197016 dr:64860944 al:157353 bm:21176
lo:19 pe:0 ua:0 ap:0
   5: cs:WFReportParams st:Primary/Unknown ld:Consistent
      ns:64605420 nr:0 dw:64085232 dr:54424576 al:132822 bm:121 lo:6
pe:0 ua:0 ap:0
   6: cs:Connected st:Primary/Secondary ld:Consistent
      ns:88661276 nr:0 dw:88141084 dr:43618112 al:123587 bm:122 lo:0
pe:0 ua:0 ap:0
   7: cs:PausedSyncS st:Primary/Secondary ld:Consistent
      ns:79213408 nr:0 dw:78693368 dr:42392908 al:184445 bm:128 lo:0
pe:0 ua:0 ap:0
   8: cs:WFReportParams st:Primary/Unknown ld:Consistent
      ns:114288948 nr:0 dw:114035536 dr:113012216 al:80028 bm:2102 lo:2
pe:0 ua:0 ap:0

>* get the wchan of the stuck processes
>    via top, or ps -eo pid,wchan:40,comm, or cat /proc/<pid>/wchan
>>      (not only the fsck, but everything that may be
      related, so fs-related kernel threads, vm-related
>      kernel threads, drbd-related kernel-threads).


   PID WCHAN                                    COMMAND         STAT
      1 select                                   init            Ss
      2 migration_thread                         migration/0     S
      3 ksoftirqd                                ksoftirqd/0     SN
      4 watchdog                                 watchdog/0      S
      5 migration_thread                         migration/1     S
      6 ksoftirqd                                ksoftirqd/1     SN
      7 watchdog                                 watchdog/1      S
      8 worker_thread                            events/0        S<
      9 worker_thread                            events/1        S<
     10 worker_thread                            khelper         S<
     11 worker_thread                            kthread         S<
     16 worker_thread                            kblockd/0       S<
     17 worker_thread                            kblockd/1       S<
     18 serio_thread                             kseriod         S<
    108 drbd_al_begin_io                         kswapd0         D
    109 drbd_al_begin_io                         kswapd1         D
    110 worker_thread                            aio/0           S<
    111 worker_thread                            aio/1           S<
    746 scsi_error_handler                       scsi_eh_0       S<
    750 worker_thread                            ata/0           S<
    751 worker_thread                            ata/1           S<
    774 worker_thread                            kpsmoused       S<
   1380 worker_thread                            kmirrord        S<
   1918 scsi_error_handler                       scsi_eh_1       S<
   2136 kjournald                                kjournald       S<
   2801 select                                   udevd           S<s
   3842 kjournald                                kjournald       S<
   3844 kjournald                                kjournald       S<
   5638 sys_poll                                 metalog         Ss
   5639 syslog                                   metalog         S
   6597 select                                   sshd            Ss
   6767 sk_wait_data                             drbd0_receiver  S
   6769 sk_wait_data                             drbd1_receiver  S
   6771 sk_wait_data                             drbd7_receiver  S
   6773 sk_wait_data                             drbd2_receiver  S
   6775 sk_wait_data                             drbd3_receiver  S
   6777 drbd_determin_dev_size                   drbd8_receiver  D
   6779 drbd_determin_dev_size                   drbd4_receiver  D
   6781 drbd_determin_dev_size                   drbd5_receiver  D
   6783 sk_wait_data                             drbd6_receiver  S
   7013 sys_poll                                 heartbeat       SLs
   7035 pipe_wait                                heartbeat       SL
   7036 sys_poll                                 heartbeat       SL
   7037 skb_recv_datagram                        heartbeat       SL
   7184 wait                                     mon             S
   7327 skb_recv_datagram                        portsentry      Ss
   7329 skb_recv_datagram                        portsentry      Ss
   7444 select                                   master          Ss
   7459 select                                   qmgr            S
   7589 hrtimer_nanosleep                        cron            Ss
   7717 read_chan                                agetty          Ss+
   7718 read_chan                                agetty          Ss+
   7719 read_chan                                agetty          Ss+
   7720 read_chan                                agetty          Ss+
   7721 read_chan                                agetty          Ss+
   7722 read_chan                                agetty          Ss+
   8923 kjournald                                kjournald       S<
   8971 kjournald                                kjournald       S<
   9019 kjournald                                kjournald       S<
   9067 kjournald                                kjournald       S<
   9115 drbd_al_begin_io                         kjournald       D<
   9163 kjournald                                kjournald       S<
   9211 kjournald                                kjournald       S<
   9259 kjournald                                kjournald       S<
   9307 drbd_al_begin_io                         kjournald       D<
   9438 select                                   atalkd          S
   9544 select                                   smbd            Ss
   9548 pause                                    smbd            S
   9554 select                                   nmbd            Ss
   9688 select                                   mysqld          Ssl
   9901 select                                   cnid_metad      S
   9910 select                                   afpd            S
11332 compat_sys_nanosleep                     retroclient     Ss
11333 sys_poll                                 retroclient     S
11335 compat_sys_nanosleep                     retroclient     S
11336 inet_csk_accept                          retroclient     S
11337 skb_recv_datagram                        retroclient     S
11344 inet_csk_accept                          retroclient     S
11345 skb_recv_datagram                        retroclient     S
11352 inet_csk_accept                          retroclient     S
11353 skb_recv_datagram                        retroclient     S
11360 inet_csk_accept                          retroclient     S
11365 compat_sys_nanosleep                     retroclient     S
11908 select                                   cnid_dbd        S
   8270 select                                   smbd            S
10289 drbd_al_begin_io                         smbd            D
31891 select                                   smbd            S
29010 drbd_al_begin_io                         smbd            D
24530 select                                   smbd            S
32250 pdflush                                  pdflush         S
19751 drbd_al_begin_io                         pdflush         D
   3856 sk_wait_data                             afpd            S
   8543 select                                   smbd            S
11364 sk_wait_data                             afpd            S
27917 sk_wait_data                             afpd            S
27918 select                                   cnid_dbd        S
22538 select                                   smbd            S
12830 select                                   smbd            S
17962 select                                   smbd            S
23331 select                                   smbd            S
28361 select                                   smbd            S
28411 wait                                     bash            S
   3404 select                                   smbd            S
13660 select                                   smbd            S
23339 sk_wait_data                             afpd            S
27168 kjournald                                kjournald       S<
25449 select                                   smbd            S
28328 select                                   smbd            S
32490 select                                   apache2         Ss
24761 skb_recv_datagram                        apache2         S
24764 inet_csk_accept                          apache2         S
24765 inet_csk_accept                          apache2         S
24766 inet_csk_accept                          apache2         S
24767 inet_csk_accept                          apache2         S
24768 inet_csk_accept                          apache2         S
   2091 select                                   smbd            S
10197 select                                   smbd            S
10832 select                                   smbd            S
15513 select                                   smbd            S
19215 select                                   smbd            S
19585 select                                   smbd            S
19761 drbd_al_begin_io                         smbd            D
21619 inet_csk_accept                          apache2         S
21620 inet_csk_accept                          apache2         S
30680 select                                   smbd            S
31724 select                                   smbd            S
32105 sk_wait_data                             afpd            S
   8343 select                                   smbd            S
17100 sk_wait_data                             afpd            S
14374 compat_sys_nanosleep                     retroclient     S
14376 get_write_access                         retropds.23     D
14397 pipe_wait                                retroclient     S
27942 pipe_wait                                cron            S
27943 wait                                     bash            Ss
27944 wait                                     run-crons       S
27973 wait                                     hotbackup_daily S
27976 wait                                     hotbackup_daily S
28053 pipe_wait                                sendmail        S
28056 unix_stream_recvmsg                      postdrop        S
28058 sync_buffer                              mv              D
28509 get_write_access                         find            D
28512 pipe_wait                                sort            S
28514 pipe_wait                                sed             S
12803 wait                                     slocate         S
12804 vfs_readdir                              updatedb        DN
28845 drbd_al_begin_io                         smbd            D
   2145 drbd_al_begin_io                         smbd            D
   2885 select                                   smbd            S
   3571 select                                   smbd            S
   5313 select                                   smbd            S
   5417 drbd_al_begin_io                         smbd            D
   5444 drbd_al_begin_io                         mon             D
   5468 drbd_al_begin_io                         smbd            D
   6218 wait                                     bash            S
   6237 drbd_al_begin_io                         cp              D
   6332 wait                                     bash            S
   6340 vfs_unlink                               rm              D
   6390 select                                   smbd            S
   6499 vfs_readdir                              ls              D
   6595 sk_wait_data                             afpd            S
   6947 log_wait_commit                          cnid_dbd        D
   7084 sk_wait_data                             afpd            S
   7136 drbd_al_begin_io                         smbd            D
   7149 select                                   smbd            S
   7213 drbd_al_begin_io                         afpd            D
   7754 drbd_al_begin_io                         smbd            D
   7757 drbd_al_begin_io                         afpd            D
   7758 drbd_al_begin_io                         smbd            D
   7764 select                                   smbd            S
   7771 pipe_wait                                cron            S
   7772 wait                                     bash            Ss
   7773 drbd_al_begin_io                         run-crons       D
   7778 drbd_al_begin_io                         afpd            D
   8002 select                                   smbd            S
   8088 select                                   smbd            S
   8220 drbd_al_begin_io                         afpd            D
   8222 log_wait_for_space                       cnid_dbd        D
   8482 drbd_al_begin_io                         emerge          D
   9451 select                                   smbd            S
   9575 drbd_al_begin_io                         afpd            D
   9613 wait                                     mail.alert      S
   9614 unix_stream_recvmsg                      sendmail        S
   9616 drbd_al_begin_io                         postdrop        D
   9633 sk_wait_data                             afpd            S
   9697 select                                   pickup          S
   9918 drbd_al_begin_io                         emerge          D
   9924 drbd_al_begin_io                         sshd            D
   9936 unix_stream_recvmsg                      sshd            Ss
   9941 select                                   sshd            S
   9942 wait                                     bash            Ss
   9951 unix_stream_recvmsg                      sshd            Ss
   9956 select                                   sshd            S
   9957 wait                                     bash            Ss
   9962 read_chan                                bash            S+
10126 drbd_thread_setup                        drbd6_worker    S
10136 select                                   smbd            S
10142 sk_wait_data                             drbd6_asender   S
10143 sk_wait_data                             drbd0_asender   S
10144 sk_wait_data                             drbd2_asender   S
10145 sk_wait_data                             drbd1_asender   S
10146 sk_wait_data                             drbd3_asender   S
10147 sk_wait_data                             drbd7_asender   S
10163 -                                        ps              R+

>* get a backtrace of the stuck processess
>    e.g. echo t > /proc/sysrq-trigger
>    (again, everything that may be related)
>    note that these are not necessarily reliable,
>   but may be helpful to understand whats going on.


The above and remaining portions of this post are available entirely 
online at 
http://www.kennedy.aecom.yu.edu/misc/kernel_2.6.17-rc5_drbd_hanging_io.html
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
