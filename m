Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293615AbSBZWHN>; Tue, 26 Feb 2002 17:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293618AbSBZWGy>; Tue, 26 Feb 2002 17:06:54 -0500
Received: from NODE1.HOSTING-NETWORK.COM ([66.186.193.1]:25353 "HELO
	hosting-network.com") by vger.kernel.org with SMTP
	id <S293615AbSBZWGr>; Tue, 26 Feb 2002 17:06:47 -0500
Subject: Natsemi Multicast rx problem, workaround
From: Torrey Hoffman <thoffman@arnor.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.21mdk 
Date: 26 Feb 2002 12:54:27 -0800
Message-Id: <1014756869.11691.56.camel@shire.arnor.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a note for the record regarding multicast receive using the
natsemi driver.  It may be of interest to the driver developers, but I'm
including lots of detail in hope of helping people who find this message
through google...

Summary: multicast rx using natsemi hashtable is flaky. Workaround is to
force all-multicast mode.

The long version:

We use the natsemi driver on TV-attached set top boxes to view UDP
multicast MPEG video streams.  Channel changing is via IGMP leave and
join.  Kernel is 2.4.recent + lowlatency patch.

The natsemi driver and hardware work together to use a hash table of
ethernet multicast addresses.  This hash table is rebuilt when the
kernel multicast code joins and leaves channels.  (Our application only
"watches" one channel at a time, thus the hash table only ever has two
entries - one is the broadcast address).

We noticed that about one in every five or six times, the hardware would
fail to "pick up" incoming multicast packets after a channel change. 
The IGMP join and leave packets were sent correctly, the multicast hash
table was rebuilt, but packets never showed up at the interface.  The
packets were definitely on the wire.  

(My theory is that the hardware flakes out if the multicast hash table
is being rewritten at the same time that the hardware is reading the
table.)

When our app notices that it isn't getting video, it retries the IGMP
join. This causes the hashtable to be rebuilt. This works but resulted
in inconsistent, slow channel changes.  Our application does a lot of
rapid joins and leaves (user is channel surfing) and it's annoying when
this happens.

The fix, at least for us, is to force the driver into "all-multicast
mode", all the time.  This is very easy - the driver as distributed
switches from the hashtable to all-multicast mode when more than 100
multicast channels are being received.  I just comment out that part of
the code so it is either in promiscuous mode or all-multicast, and never
uses the hashtable.

And that does it - channel changes are always fast now.  Unfortunately
this fix is not suitable for everyone. (We don't have lots of unwatched
multicast channels going by on the wire, so we don't need hardware
filtering, other users may not be so lucky.)

Hope this helps someone.

Torrey Hoffman
thoffman@arnor.net
torrey.hoffman@myrio.com



