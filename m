Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130564AbQKCSOK>; Fri, 3 Nov 2000 13:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130565AbQKCSOA>; Fri, 3 Nov 2000 13:14:00 -0500
Received: from big-relay-1.ftel.co.uk ([192.65.220.123]:50064 "EHLO
	old-callisto.ftel.co.uk") by vger.kernel.org with ESMTP
	id <S130564AbQKCSNw>; Fri, 3 Nov 2000 13:13:52 -0500
To: Rob Landley <telomerase@yahoo.com>
Cc: Philippe Troin <phil@fifi.org>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 255.255.255.255 won't broadcast to multiple NICs
In-Reply-To: <20001103173316.17356.qmail@web5201.mail.yahoo.com>
From: Paul Flinders <P.Flinders@ftel.co.uk>
Date: 03 Nov 2000 18:11:15 +0000
In-Reply-To: Rob Landley's message of "Fri, 3 Nov 2000 09:33:16 -0800 (PST)"
Message-ID: <thvn1fhsz7g.fsf@solar-flare.ftel.co.uk>
User-Agent: Gnus/5.0804 (Gnus v5.8.4) XEmacs/21.2 (Shinjuku)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rob Landley <telomerase@yahoo.com> writes:
> 3) Java sucks in many ways.  Today's way is that it
> never occurred to Sun that a machine might have more
> than one IP address assigned to it, so
> InetAddress.getLocalHost() returns exactly one
> address.  Unfortunately, just about EVERY machine has
> two interfaces defined, the other one being loopback
> on 127.0.0.1, and natrually the loopback is the one
> that getLocalHost() returns.  (Since it's the one that
> we pretty much already know the address of anyway, and
> querying it is therefore useless, that's the one it
> queries.  Thank you Sun.)  There is no way to query
> the current machine's interfaces without resorting to
> native code.

I faced this problem a while ago - in the end I cheated and
put this bit of code in a shell script used to start the
application

    NET_ADDRESSES=`/sbin/ifconfig   |                         \
                   awk '/^[^   ].*HWaddr/ { HWaddr=$5; next;}
                        /^[^        ]/ { HWaddr=0; }
                        /^[         ].*addr:/ { if (HWaddr != 0) { printf("-Dethaddr.%s=%s -Dnetmask.%s=%s ",substr($2,6),HWaddr,substr($2,6),substr($4,6)); } } END {print;}'`

including ${NET_ADDRESSES} in the java command line sets
up a set of defines, one per interface. For example

-Dethaddr.172.16.1.1=00:00:0A:BC:CD:78 -Dnetmask.172.16.1.1=255.255.0.0

which you can use via System.getProperty() and System.getProperties()

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
