Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266175AbTCDW77>; Tue, 4 Mar 2003 17:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266473AbTCDW77>; Tue, 4 Mar 2003 17:59:59 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:2579 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S266175AbTCDW7y> convert rfc822-to-8bit; Tue, 4 Mar 2003 17:59:54 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: PCI hotplug question.
Date: Tue, 4 Mar 2003 17:10:16 -0600
Message-ID: <45B36A38D959B44CB032DA427A6E106404513370@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: proposed email to hot-plug guys
Thread-Index: AcLioMQqUNOPH/mASGSgc1RJgUxergAAJReQ
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Mathiasen, Torben" <Torben.Mathiasen@hp.com>,
       "Ni, Michael" <Michael.Ni@hp.com>, <greg@kroah.com>
X-OriginalArrivalTime: 04 Mar 2003 23:10:16.0604 (UTC) FILETIME=[37F365C0:01C2E2A3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We have gotten PCI hot-plug with the cciss driver nominally 
working, (Maybe I abuse the word "working" here.) with 
2.4.21pre5 kernel, and a patch from Torben, and some
changes we've made to cciss (mainly in the initialization
code, waiting for the board's firmware to become ready, etc.)

That is, we can press the pushbutton to power off the slot, and
the driver's remove_one function will be called, and powering
back up the slot, the driver's init_one function will be called.

However, once the button is pressed, the driver has no choice
but to remove the instance.  This means (as currently implemented)
the per-adapter structure is deallocated.  In essence, the driver
is presuming that when remove_one is called, it is because rmmod
was invoked.

In particular, the driver is not expecting any more i/o requests
to come in.  If this expectation is met, things are ok.  i/o can
be done prior to hot-unplug, and after hot-re-plug, but may not
be attempted during or between these events.

However, with PCI hot-plug, this expectation is not guaranteed (or even
all that likely) to be met.  For example, if the md driver is using the cciss 
driver (for multipath typically, since cciss is for hardware RAID), the md
driver expects one of two things to happen with its requests.  
1) they succeed or 2) they at least return with failure status.  

It does not expect that they will 
make the driver dereference a pointer which is now NULL.  In particular
PCI hot-unplugging the driver does not in any way tell the md driver not
to attempt any more i/o to that device.

So, the question is this.  For HBA drivers, block storage drivers in
particular, are there plans to make hot-unplugging behave similarly to
rmmod (checking that nobody has the device open before kicking
the driver out and so on) or, is it the driver's duty to defend 
against incoming i/o's to devices which may be yanked out from
underneath it whenever somebody presses the pushbutton?

Thanks for any thoughts.

-- steve

