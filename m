Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274234AbRJEWpg>; Fri, 5 Oct 2001 18:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274236AbRJEWp1>; Fri, 5 Oct 2001 18:45:27 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:43442 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S274234AbRJEWpW>;
	Fri, 5 Oct 2001 18:45:22 -0400
Date: Fri, 05 Oct 2001 23:45:46 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: 2.2.19 poor speed creating/deleting interfaces
Message-ID: <393662386.1002325546@[195.224.237.69]>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am looking at a VRRP implementation which is problematic
on large numbers of interfaces. The configuration has
over 300 interfaces, which, each being on their own
VLAN of the same physical interface, tend to change
state at the same time.

The VRRP stuff runs mostly as a kernel thread, which
on a state change, causes the VRRP virtual interface
to be added/removed. It does this via a call to
devinet_ioctl (with normal segment kludges), and
does (essentially) SIOCIFADDR, SIOCIFMASK, SIOCIFBRADDR,
on the virtual VLAN interface, and a SIOCADDMULTI(*) on
the main VLAN interface. On transition to VRRP backup,
it does the opposite (DELMULTI, the SOICIFFLAGS to
delete the interface).

It all works, but each interface addition / removal
takes over a tenth of a second. This isn't great
when you have over 300 of them and are trying to
do hot standby (>40 seconds for some VLANs is
not so hot).

I'm using Acenics, 2.2.19, patches for VRRP
VLAN, Acenic, to log rather less and not
try and load modules for VLAN interfaces.

Any idea what takes the time in interface
addition / removal and/or multicast addition / removal?

'All' the 300 odd kernel threads do is look
at a state machine, issue IOCTLs, queue
the odd packet, and call interruptible_sleep_on_timeout.
I would have thought the non-ioctl stuff should be efficient.

(*)=don't ask why I need to do this bit

--
Alex Bligh
