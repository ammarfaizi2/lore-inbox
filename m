Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265661AbTFXEmp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 00:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265664AbTFXEmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 00:42:45 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:36324 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265661AbTFXEmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 00:42:42 -0400
Message-ID: <3EF7DA0E.7010504@nortelnetworks.com>
Date: Tue, 24 Jun 2003 00:56:46 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bug report(s) for 2.5.7[23]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sometime between 2.5.65 and 2.5.72 something changed with ppp.  When I 
close down my pppoe connection with /etc/rc.d/init.d/stop, it seems to 
be reliably left with a spurious refcount on ppp0.

The usual occurance instance of this (on 2.5.72) generates logs like the 
following:


Jun 24 00:07:00 doug adsl-stop: Killing pppd
Jun 24 00:07:00 doug pppd[787]: Terminating on signal 15.
Jun 24 00:07:00 doug adsl-stop: Killing adsl-connect
Jun 24 00:07:00 doug pppd[787]: Connection terminated.
Jun 24 00:07:00 doug pppd[787]: Connect time 1.3 minutes.
Jun 24 00:07:00 doug pppd[787]: Sent 902 bytes, received 588 bytes.
Jun 24 00:07:03 doug pppoe[790]: Session 3601 terminated -- received 
PADT from peer
Jun 24 00:07:03 doug pppoe[790]: Sent PADT

Message from syslogd@doug at Tue Jun 24 00:07:10 2003 ...
doug kernel: unregister_netdevice: waiting for ppp0 to become free. 
Usage count = 1
Jun 24 00:07:10 doug kernel: unregister_netdevice: waiting for ppp0 to 
become free. Usage count = 1
Jun 24 00:07:11 doug ntpd[1103]: sendto(132.246.168.148): Invalid argument
Jun 24 00:07:15 doug smb: smbd -HUP succeeded
Jun 24 00:07:15 doug smbd[1520]: [2003/06/24 00:07:15, 0] 
smbd/server.c:open_sockets(238)
Jun 24 00:07:15 doug smbd[1520]:   Got SIGHUP
Jun 24 00:07:20 doug kernel: unregister_netdevice: waiting for ppp0 to 
become free. Usage count = 1

Message from syslogd@doug at Tue Jun 24 00:07:50 2003 ...
doug last message repeated 4 times
Jun 24 00:08:00 doug last message repeated 4 times




This continues on until the machine is rebooted.  One time on the 
current bk kernel (which I think is supposed to be 2.5.73 but actually 
has 2.5.72 in the version) I got the following, but I was not able to 
reproduce it:






Jun 23 23:59:36 doug adsl-stop: Killing pppd
Jun 23 23:59:36 doug pppd[782]: Terminating on signal 15.
Jun 23 23:59:36 doug adsl-stop: Killing adsl-connect
Jun 23 23:59:36 doug pppd[782]: Connection terminated.
Jun 23 23:59:36 doug pppd[782]: Connect time 56.1 minutes.
Jun 23 23:59:36 doug pppd[782]: Sent 153791 bytes, received 1458873 bytes.
Jun 23 23:59:39 doug pppoe[784]: Session 1154 terminated -- received 
PADT from peer
Jun 23 23:59:39 doug pppoe[784]: Sent PADT
Jun 23 23:59:46 doug kernel: unregister_netdevice: waiting for ppp0 to 
become free. Usage count = 1
Jun 23 23:59:47 doug pppd[1801]: pppd 2.4.1 started by root, uid 0
Jun 23 23:59:47 doug pppoe[1802]: PPP session is 3357
Jun 23 23:59:56 doug kernel: unregister_netdevice: waiting for ppp0 to 
become free. Usage count = 1
Jun 24 00:00:16 doug last message repeated 2 times
Jun 24 00:00:18 doug pppoe[1802]: Session 3357 terminated -- received 
PADT from peer
Jun 24 00:00:18 doug pppoe[1802]: Sent PADT
Jun 24 00:00:18 doug kernel: Badness in local_bh_enable at 
kernel/softirq.c:109
Jun 24 00:00:18 doug kernel: Call Trace:
Jun 24 00:00:18 doug kernel:  [<c0129d38>] local_bh_enable+0x88/0x90
Jun 24 00:00:18 doug kernel:  [<c0307b31>] ppp_async_push+0x151/0x350
Jun 24 00:00:18 doug kernel:  [<c01825d1>] cached_lookup+0x21/0x80
Jun 24 00:00:18 doug kernel:  [<c0307281>] ppp_asynctty_wakeup+0x31/0x60
Jun 24 00:00:18 doug kernel:  [<c02c68b5>] pty_unthrottle+0x55/0x60
Jun 24 00:00:18 doug kernel:  [<c02c13fa>] check_unthrottle+0x3a/0x40
Jun 24 00:00:18 doug kernel:  [<c02c15f4>] n_tty_flush_buffer+0x14/0x50
Jun 24 00:00:18 doug kernel:  [<c02c6c2e>] pty_flush_buffer+0x5e/0x60
Jun 24 00:00:18 doug kernel:  [<c02bc299>] do_tty_hangup+0x619/0x7f0
Jun 24 00:00:18 doug kernel:  [<c01ba3ff>] devpts_pty_kill+0x3f/0x5a
Jun 24 00:00:18 doug kernel:  [<c02be158>] release_dev+0x598/0x5d0
Jun 24 00:00:18 doug kernel:  [<c03fc000>] sock_queue_rcv_skb+0x1f0/0x3b0
Jun 24 00:00:18 doug kernel:  [<c015848e>] zap_pmd_range+0x4e/0x70
Jun 24 00:00:18 doug kernel:  [<c01584f1>] unmap_page_range+0x41/0x70
Jun 24 00:00:18 doug kernel:  [<c02be6f5>] tty_release+0x95/0x1b0
Jun 24 00:00:18 doug kernel:  [<c016fb68>] __fput+0x78/0xc0
Jun 24 00:00:18 doug kernel:  [<c016fba7>] __fput+0xb7/0xc0
Jun 24 00:00:18 doug kernel:  [<c016dbea>] filp_close+0x15a/0x220
Jun 24 00:00:18 doug kernel:  [<c0126819>] put_files_struct+0x69/0xd0
Jun 24 00:00:18 doug kernel:  [<c0127be1>] do_exit+0x3e1/0x9d0
Jun 24 00:00:18 doug kernel:  [<c0128205>] sys_exit+0x15/0x20
Jun 24 00:00:18 doug kernel:  [<c010a28b>] syscall_call+0x7/0xb
Jun 24 00:00:18 doug kernel:
Jun 24 00:00:26 doug kernel: unregister_netdevice: waiting for ppp0 to 
become free. Usage count = 1
Jun 24 00:00:31 doug su(pam_unix)[1923]: authentication failure; 
logname=chris uid=501 euid=0 tty= ruser=chris rhost=  user=root
Jun 24 00:00:36 doug kernel: unregister_netdevice: waiting for ppp0 to 
become free. Usage count = 1
Jun 24 00:00:36 doug su(pam_unix)[1925]: session opened for user root by 
chris(uid=501)
Jun 24 00:00:46 doug kernel: unregister_netdevice: waiting for ppp0 to 
become free. Usage count = 1
Jun 24 00:00:56 doug kernel: unregister_netdevice: waiting for ppp0 to 
become free. Usage count = 1
Jun 24 00:01:06 doug kernel: unregister_netdevice: waiting for ppp0 to 
become free. Usage count = 1
Jun 24 00:01:16 doug su(pam_unix)[1722]: session closed for user root
Jun 24 00:01:16 doug kernel: unregister_netdevice: waiting for ppp0 to 
become free. Usage count = 1
Jun 24 00:01:26 doug kernel: unregister_netdevice: waiting for ppp0 to 
become free. Usage count = 1



Anyone have any ideas what's going on here?  I guess the next step is to 
try and narrow it down to exactly the specific version that caused the 
problem, but I'm not sure how to get a particular release with bitkeeper.


Thanks,

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

