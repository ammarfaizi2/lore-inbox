Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129175AbRBOVNe>; Thu, 15 Feb 2001 16:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129447AbRBOVNZ>; Thu, 15 Feb 2001 16:13:25 -0500
Received: from FACULTY-164.ubishops.ca ([207.162.104.164]:2820 "HELO
	thanatos.ubishops.ca") by vger.kernel.org with SMTP
	id <S129175AbRBOVNK>; Thu, 15 Feb 2001 16:13:10 -0500
Message-ID: <3A8C465D.5E2A118D@ubishops.ca>
Date: Thu, 15 Feb 2001 16:13:01 -0500
From: Thomas Hood <jdthood@ubishops.ca>
Reply-To: jdthoodREMOVETHIS@yahoo.co.uk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] to deal with bad dev->refcnt in unregister_netdevice()
In-Reply-To: <20010214092251.D1144@e-trend.de> <3A8AA725.7446DEA0@ubishops.ca> <20010214165758.L28359@e-trend.de> <20010214122244.H7859@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update on the "unregister_netdevice" bug ...

Arnaldo Carvalho de Melo has been valiantly trying in his
scarce free time to find the cause.  I haven't been able to
hunt effectively because I don't really understand the networking
code; however I have been experimenting to see what are the
exact conditions under which the failure occurs.  I modified
my kernel to print dev->refcnt in /proc/net/dev so that I
could see what the refcnt of eth0 is at any given moment.
One of the more interesting experiment logs is appended 
below.

Experimentation seems to show
1) It happens when ipx is used, specifically when 
   auto_interface=on and auto_primary=on
2) It happens only or especially when using DHCP
3) It happens only to PCMCIA ethernet cards

Thomas Hood
jdthood_AT_yahoo.co.uk

Linux 2.4.1-ac10
/etc/pcmcia/network disabled with an 'exit 0'

command                         refcnt  message
-------                         ------  -------
(boot)                               0
(I inserted Xircom card)             1
ifconfig eth0 up                     2
ipx_configure --auto_interface=on --auto_primary=on    2
ifconfig eth0 down                   0  "Freeing alive device c127ac8c, eth0"
cardctl eject                        ?  "unregister_netdevice: waiting for
   eth0 to become free. Usage count = 0
   Message from syslogd@thanatos at Wed Feb 14 12:51:26 2001 ...
   thanatos kernel: unregister_netdevice: waiting for eth0 to become free.
   Usage count = 0"
