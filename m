Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318725AbSHWJuS>; Fri, 23 Aug 2002 05:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318726AbSHWJuS>; Fri, 23 Aug 2002 05:50:18 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:36122 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S318725AbSHWJuQ>;
	Fri, 23 Aug 2002 05:50:16 -0400
Date: Fri, 23 Aug 2002 11:54:21 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: andre@linux-ide.org, ebiederm@xmission.com, jgarzik@mandrakesoft.com,
       linux-kernel@vger.kernel.org
Subject: Re: IDE-flash device and hard disk on same controller
Message-ID: <20020823095421.GB5649@win.tue.nl>
References: <200208230831.BAA02426@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208230831.BAA02426@adam.yggdrasil.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2002 at 01:31:09AM -0700, Adam J. Richter wrote:

> 	Can you provide a reference for this "31 second rule?"

Read e.g. ATA-6.

[If things work well, they may well be fast. But you are only entitled to conclude
that something is wrong after waiting for 31 s. In particular, if you want to
detect device 1 (the slave device), then only after 31 s you know that it is absent.]

See for example the Device power-on or hardware reset state diagram in 9.1.
Some random quotes:

1) Following a hardware reset or software reset, the following steps may be
used to reselect Device 1:
a) Write to the Device register with DEV bit set to one;
b) Using one or more of the Command Block registers that may be both written and
read, such as the Sector Count or LBA Low, write a data pattern other than 00h or
FFh to the register(s);
c) Read the register(s) written in step (b). If the data read is the same as the
data written, proceed to step (e);
d) Repeat steps (a) to (c) until the data matches in step (c) or until 31 s has past.
After 31 s the host may assume that Device 1 is not functioning properly;
e) Read the Status register and Error registers. Check the Status and Error register
contents for any error conditions that Device 1 may have posted.

In Standby mode the device is capable of responding to commands but the device
may take longer to complete commands than in the Idle mode. The time to respond
could be as long as 30 s.

In Sleep mode the device requires a hardware or software reset or a DEVICE RESET
command to be activated. The time to respond could be as long as 30 s.

Transition D0HR2b:D0HR3: When the sample indicates that PDIAG- is not asserted
and 31 s have elapsed since the negation of RESET- (SRST), the device shall set
bit 7 in the Error register and make a transition to the D0HR3: Set_status state.

D0SR3: Set_status State: All actions required in this state shall be completed
within 31 s.

D1HR1: Set_status State: This state is entered when the device has asserted DASP-.
When in this state the device shall complete any hardware initialization and
self-diagnostic testing begun in the Set DASP- state if not already completed.
The diagnostic code shall be placed in the Error register (see  Table 26).
If the device passed self-diagnostics, the device shall assert PDIAG-.
All actions required in this state shall be completed in 30 s.

D1SR2: Set_status State: (idem for SRST)

DI1: Device_Idle_S State:
When entering this state from a power-on, hardware, or software reset, if the device
does not implement the PACKET command feature set, the device shall set DRDY to one
within 30 s of entering this state. When entering this state from a power-on, hardware,
or software reset, if the device does implement the PACKET command feature set, the
device shall not set DRDY to one.

DI2: Device_Idle_NS State:
When entering this state from a power-on, hardware, or software reset, if the device
does not implement the PACKET command feature set, the device shall set DRDY to one
within 30 s of entering this state and shall release DASP- and PDIAG- with 31 s of
entering this state. When entering this state from a power-on, hardware, or software
reset, if the device does implement the PACKET command feature set, the device shall
not set DRDY to one.
