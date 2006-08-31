Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWHaGy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWHaGy1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 02:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWHaGy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 02:54:27 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:8587 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750835AbWHaGy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 02:54:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SvjHP3+IQTCKU4XPL/dg04wt5f2O9YLYwB3I17bc1nQUN41/dCf4GQBMR9iyk5PMsgPSIwaWGtYiXW1RrjogyQeZYuNOIhNjzF0ZsyVuBsU8ZKPSmQ0IYomEWn0FDRG15/yx+Zis6etuTDJAXO9p2zaFhw9cklG/FdGrGCX8kts=
Message-ID: <ccbc91640608302354x66f802bdi34fd61b12603d5db@mail.gmail.com>
Date: Thu, 31 Aug 2006 06:54:26 +0000
From: "=?GB2312?B?tq22rdmp?=" <doublefacer007@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM:
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I has found a bug that is caused by dead lock on ip_nat_ftp module
in linux kernel 2.4.27 on SMP machine.
   My workaround of testing is as following:
   I create a router by iptables ,FTP client and FTP server for testing.
     client machine ip: 192.168.1.3/32 ,gateway 192.168.1.10/32
     server machine ip: 192.168.2.3/32,gateway 192.168.2.10/32
     router machine with tow NICs,
       eth0:192.168.1.10/32
       eth1:192.168.2.10/32
  Testing flow:
    on router:
      echo 1 > /proc/sys/net/ipv4/ip_forward
      modprobe ip_nat_ftp
      iptables -t nat -A POSTROUTING -s 192.168.1.3 -p tcp --dport 21
-o eth1 -j SNAT --to-source 192.168.2.10
    on client:
       I use a benchmark tool to create ftp sessions with the  remote
FTP server.In the session,includes ftp control connections and data
connections.The sending rate is about 500 sessions/10s.
    When the num of conntrack is up to 15000,I rmmod the ip_nat_ftp
and ip_conntrack _ftp modules by typing "modprobe -r ip_nat_ftp"
command and then the kernel is dead locked.

I think that the dead lock is caused by ip_conntrack_lock and
ip_nat_lock.When I rmmod the ip_nat_ftp module, the function flow is
as following:
ip_nat_helper_unregister->ip_ct_selective_cleanup->get_next_corpse(ip_conntrack_lock)
 ->kill_helper(ip_nat_lock)
But the kernel there is another flow is as following:
ip_nat_fn(ip_nat_lock)->ip_nat_setup_info->ip_conntrack_alter_reply(ip_conntrack_lock)
