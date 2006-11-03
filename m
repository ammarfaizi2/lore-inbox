Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753365AbWKCSRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365AbWKCSRR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 13:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753366AbWKCSRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 13:17:17 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:12526 "EHLO
	fmmailgate03.web.de") by vger.kernel.org with ESMTP
	id S1753365AbWKCSRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 13:17:16 -0500
Message-ID: <01a501c6ff74$6fc52c80$962e8d52@aldipc>
From: "roland" <devzero@web.de>
To: <linux-net@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: unregister_netdevice: waiting for eth0 to become free
Date: Fri, 3 Nov 2006 19:18:17 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi list,

I have come across a problem on a SLES8 (2.4 kernel based) system today.

getting "unregister_netdevice: waiting for eth0 to become free" on shutdown 
and the shutdown got stuck at this point. needed to do a hard reset to 
continue.

by some search via google/vmware-forum i found a hint very soon (this was 
for RedHat, but also worked with SLES)

------------------------------------------------
In many Linux distributions, if IPv6 is enabled, VMware Tools cannot be 
configured with vmware-config-tools.pl after installation. In this case,
VMware Tools is unable to set the network device correctly for the virtual 
machine, and displays a message similar to
Unloading pcnet32 module
unregister_netdevice: waiting for eth0 to become free
This message repeats continuously until you reboot the virtual machine. To 
prevent this problem in virtual machines running Linux, disable IPv6 before 
installing VMware Tools.
To disable IPv6 in a virtual machine running Linux:
1 If the file /etc/sysconfig/network contains the line NETWORKING_IPV6=yes, 
change the line to NETWORKING_IPV6=no.

2 In the file /etc/modules.conf, add the following lines:
alias ipv6 off
alias net-pf-10 off

After you disable IPv6, you should be able to install and configure VMware 
Tools successfully.
------------------------------------------------

this solved my shutdown problem.  (network driver wasn`t pcnet32 but vmxnet 
, which is a vmware specific network device)

anyway - i wondered about this "waiting to become free".
this is just a workaround, not a solution.
what if i needed to use ipv6 ?

before i disabled ipv6 (as it is being recommended) , i tried some manual 
steps to disable ipv6, but failed.

don`t have the sles8 here at home, but trying to disable ipv6 "manually" on 
a newer system gives a similar error:

vserver1:~ # rmmod ipv6
ERROR: Module ipv6 is in use by ip6t_REJECT
vserver1:~ # rmmod ip6t_REJECT
ERROR: Module ip6t_REJECT is in use

ok - rmmod telling me, that ip6t_REJECT is in use.

but - what/who is using it ?

i disabled all network services for which lsof had shown that they had an 
ipv6 socket open, i also did "ifconfig sit0 down", which seems to be a ipv6 
related network device, but still having ip6t_REJECT in use.

now my questions:

- how  can i determine what "component" (i.e. one of userspace app, device, 
kernel-thread....whatever) is using a module, so i`m able to unload that 
module ?
- is there sort of "lsof" for kernel modules ?
- what is causing the unregister_netdevice to fail ? is it an older bug 
which has been resolved in later kernels ?

i`m quite sure, that i have seen this issue in the past, more then once and 
not related to vmware.
so, this is why i`m reporting it here and asking for help

regards
roland 

