Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbTJNW5e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 18:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbTJNW5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 18:57:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:63110 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262061AbTJNW51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 18:57:27 -0400
X-Authenticated: #555711
From: "Sebastian Piecha" <spi@gmxpro.de>
To: Jim Keniston <jkenisto@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Date: Wed, 15 Oct 2003 00:57:28 +0200
MIME-Version: 1.0
Content-type: Multipart/Mixed; boundary=Message-Boundary-131
Subject: Re: How to wait for kernel messages?
Message-ID: <3F8C9B78.6957.17859BC3@localhost>
In-reply-to: <3F8C6576.464328CE@us.ibm.com>
X-mailer: Pegasus Mail for Windows (v4.12a)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Message-Boundary-131
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body

> On Mon, 13 Oct 2003, Sebastian Piecha wrote:
> 
> > I have some problems with one NIC. Due to lack of time as an
> > workaround I'd like to wait for the kernel message "NETDEV WATCHDOG:
> > eth0: transmit timed out" and ifconfig down/up the NIC.
> >
> > How can I trigger any action by such a kernel message? Do I have to
> > grep the kernel log?
> >

Thanks a lot for all the hints. I'm using now a fifo to which syslogd 
is logging kernel messages. A shell script greps the right message.

I attach the shell script inline for whom it may be interesting.


Mit freundlichen Gruessen/Best regards,
Sebastian Piecha

EMail: spi@gmxpro.de


--Message-Boundary-131
Content-type: text/plain; charset=US-ASCII
Content-disposition: inline
Content-description: Attachment information.

The following section of this message contains a file attachment
prepared for transmission using the Internet MIME message format.
If you are using Pegasus Mail, or any other MIME-compliant system,
you should be able to save it or view it from within your mailer.
If you cannot, please ask your system administrator for assistance.

   ---- File information -----------
     File:  check_nic.txt
     Date:  15 Oct 2003, 0:56
     Size:  771 bytes.
     Type:  Text

--Message-Boundary-131
Content-type: Application/Octet-stream; name="check_nic.txt"; type=Text
Content-disposition: attachment; filename="check_nic.txt"

#!/bin/bash

# Signalling
trap 'exit 0' SIGTERM
trap '' SIGHUP

# grep
arg1="NETDEV WATCHDOG: eth0: transmit timed out"
#arg2="dhcpd: receive_packet failed on eth0: Network is down"

# Syslog
tag=$0
prio="kern.err"

fifo=/var/log/check_nic

IFCONFIG=$(which ifconfig)
SLEEP=$(which sleep)
EGREP=$(which egrep)
DATE=$(which date)
HOSTNAME=$(which hostname)
LOGGER=$(which logger)

while true
do
        read line < $fifo
        echo $line | \
          $EGREP -e "$arg1" \
          > /dev/null 2>&1
        if [ $? -eq 0 ] ; then
                $IFCONFIG eth0 down
                $SLEEP 1
                $IFCONFIG eth0 up
                $LOGGER -t $tag -p $prio "eth0 down, restarting..." 
                $SLEEP 5
        fi
done
--Message-Boundary-131--
