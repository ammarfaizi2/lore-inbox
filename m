Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262790AbULQMM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbULQMM0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 07:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbULQMM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 07:12:26 -0500
Received: from web51510.mail.yahoo.com ([206.190.38.202]:23737 "HELO
	web51510.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262790AbULQMMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 07:12:21 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=1R+dUeXK0Cy+XeKjuniniHoCy9LWbZzV8aZvpBOdiqISeqa9TL2xThCGjhcw7chh/ctzA0WCQQDJlyFYpDa16Ysqt7O06OWfKwpDO/X498BRhQOhxRXctvD+fKRxPMFS4dgTxOdQBPyAtPDZM70QeRtLLyw+srmXhA1S9WXZ3Os=  ;
Message-ID: <20041217121220.9782.qmail@web51510.mail.yahoo.com>
Date: Fri, 17 Dec 2004 04:12:20 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: Issue on netconsole vs. Linux kernel oops
To: mpm@selenic.com
Cc: pmarques@grupopie.com, mingo@redhat.com, linux-os@chaos.analogic.com,
       linux-kernel@vger.kernel.org, ipsec-tools-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2004 at 10:55, Matt Mackall wrote:
>
> On Thu, Dec 16, 2004 at 10:48:27AM -0800, Park Lee 
> wrote:
> > Hi,
> > I'd like to use netconsole to send local Linux
> > kernel's final messages (i.e. oops) to remote 
> > machine when the kernel crashes. 
> > Now I can successfully use a built-in netconsole 
> > to send some loacl kernel messages to the remote 
> > machine.(the parameter I send to local kernel on 
> > kernel command line is 
> > "netconsole=@192.168.0.2/,514@192.168.0.1/", I run
> > syslogd in remote machine). For example, When the
> > local kernel is booting, it will send a message
> > "192.168.0.2 audit(1103247021.091:0): 
> > initialized" to remote machine through 
> > netconsole, and the syslogd on remote machine 
> > will write the message to /var/log/messages on 
> > remote machine.
> >  What CONFUSE me most is that when the kernel
> > crashes, there is NO message (oops) about the 
> > crash being wrote down by syslogd on remote 
> > machine to remote /var/log/messages file at all!! 
> >   But in the mean time, We can see the outputs of
> > tcpdump on the remote machine, they are some thing
> > like the following:
> >
> >01:36:56.692877 IP 192.168.0.2.6665 >
> >192.168.0.1.syslog: UDP, length 48
> >01:36:56.692930 IP 192.168.0.2.6665 >
> >192.168.0.1.syslog: UDP, length 29
> >01:36:56.692982 IP 192.168.0.2.6665 >
> >192.168.0.1.syslog: UDP, length 15
> >01:36:56.693034 IP 192.168.0.2.6665 >
> >192.168.0.1.syslog: UDP, length 9
> >01:36:56.693086 IP 192.168.0.2.6665 >
> >192.168.0.1.syslog: UDP, length 16
> >01:36:56.693121 IP 192.168.0.2.6665 >
> >192.168.0.1.syslog: UDP, length 16
> >   ... ...
> > From these messages, we can see that the 
> > netconsole actually have sent the final messages 
> > (oops) to remote machine when the local kernel 
> > crashed. But there are no corresponding messages 
> > recorded by syslogd on remote machine 
> > to /var/log/messages.
>
> From your description, it sounds like syslogd is at 
> fault. Try using netcat on the remote machine.

  Today, I have a try using netcat. But I found that
the problem still exist!
  By accident, I found that this problem is related to
native IPsec that runs between my local machine and
the remote machine. 
  I'm using IPsec-Tools ( which including racoon,
setkey) as the user-space tools for the native IPsec
of linux kernel. Only if I run the command "setkey -f
/etc/ipsec.conf" on the remote machine, the syslogd
(or netcat) running on the remote machine will unable
to record the messages that have been reached the
remote machine. If I'm not run this command on remote
machine, the syslogd/netcat will be able to record the
arrived messages. (the /etc/ipsec.conf on the remote
machine is shown in the end.)
  Then, CAN'T netconsole be used in the IPsec
environment (with IPsec-Tools)? How can we solve this
problem?

  Thank you.

PS.  
  The /etc/ipsec.conf on the remote machine (Just an
example).(I'm using racoon to automatically setup the
Security Associations.)

#!/usr/setkey -f

# Configuration for 192.168.0.1 (the remote machine)

# Flush the SAD and SPD
flush;
spdflush;

# Security policies
spdadd 192.168.0.1 192.168.0.2 any -P out ipsec
           esp/transport//require
           ah/transport//require;

spdadd 192.168.0.2 192.168.0.1 any -P in ipsec
           esp/transport//require
           ah/transport//require;



=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - 250MB free storage. Do more. Manage less. 
http://info.mail.yahoo.com/mail_250
