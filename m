Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVAGQJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVAGQJv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 11:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVAGQJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 11:09:50 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:20944 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261480AbVAGQI5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 11:08:57 -0500
Subject: Re: SCSI aic7xxx driver: Initialization Failure over a kdump reboot
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Lukasz Kosewski <lkosewsk@nit.ca>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>,
       linux scsi <linux-scsi@vger.kernel.org>,
       dipankar sarma <dipankar@in.ibm.com>, linux-os@analogic.com,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <41DEA2E8.8030701@nit.ca>
References: <1105014959.2688.296.camel@2fwv946.in.ibm.com>
	 <1105013524.4468.3.camel@laptopd505.fenrus.org>
	 <20050106195043.4b77c63e.akpm@osdl.org> <41DE15C7.6030102@nit.ca>
	 <41DEA2E8.8030701@nit.ca>
Content-Type: text/plain
Organization: 
Message-Id: <1105116758.2688.447.camel@2fwv946.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Jan 2005 22:22:38 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-07 at 20:25, Lukasz Kosewski wrote:
> Lukasz Kosewski wrote:
> > Andrew Morton wrote:
> > 
> >>> looks like the following is happening:
> >>> the controller wants to send an irq (probably from previous life)
> >>> then suddenly the driver gets loaded
> >>> * which registers an irq handler
> >>> * which does pci_enable_device()
> >>> and .. the irq goes through. the irq handler just is not yet 
> >>> expecting this irq, so
> >>> returns "uh dunno not mine"
> >>> the kernel then decides to disable the irq on the apic level
> >>> and then the driver DOES need an irq during init
> >>> ... which never happens.
> >>>

Well, in last 4-5 trials I did not see this problem. Everything is same
except we had just opened the box once to checkout few things.

Probably "noirqdebug" boot time parameter can be a stop gap solution
over a kdump boot, which will make sure irq is not disabled even if
unhandled interrupts are there. Assuming driver will be able to
initialize after this and hence undesired interrupt generation shall be
stopped.

> >>
> >>
> >> yes, that's exactly what e100 was doing on my laptop last month.  Fixed
> >> that by arranging for the NIC to be reset before the call to
> >> pci_set_master().
> 
> After reading this again when I /wasn't/ semi-comatose, I retract my 
> statement insofar as it wouldn't help you (but I think it's still rather 
> necessary) :)
> 
> The system did exactly what I'm talking about (which it didn't do for 
> me, possibly because the board/processor didn't support APIC).  I guess 
> my question to you is:  do you have other devices sharing this 
> interrupt?  In other words, are you /sure/ that it's the adaptec 
> controller which is setting the interrupt line high?

I am not sure about this. Following are two contradictory observations.

1. Remove the adaptec controller support and everything works fine. It
might mean that it was adapted controller only which was generating
spurious interrupts.

2. There are two more SCSI Controllers in the system and first one is
managing all the six hard disks in the system.

05:07.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev
07)
05:07.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev
07)

These also could be potential source of interrupts as after a successful
reboot with kdump, these also are sharing irq 9.

Following is a snapshot of /proc/interrupts over a kdump boot with
"noirqdebug"

           CPU0       CPU1
  0:     109474          0          XT-PIC  timer
  1:          8          0          XT-PIC  i8042
  2:          0          0          XT-PIC  cascade
  4:        385          0          XT-PIC  serial
  8:          1          0          XT-PIC  rtc
  9:      25588          0          XT-PIC  aic7xxx, ioc0, ioc1
 12:        100          0          XT-PIC  i8042
 14:         19          0          XT-PIC  ide0



In normal boot, I don't see any other device connected to irq 9. (I am
not sure if this irq number can change over reboot)

Following is a snapshot of /proc/interrupts over a normal boot.

           CPU0       CPU1
  0:      95314          0    IO-APIC-edge  timer
  1:          9          0    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  4:        498          0    IO-APIC-edge  serial
  8:          2          0    IO-APIC-edge  rtc
 12:        100          0    IO-APIC-edge  i8042
 14:         20          0    IO-APIC-edge  ide0
 18:       1155          0   IO-APIC-level  eth0
 24:         30          0   IO-APIC-level  aic7xxx
 27:       1946          0   IO-APIC-level  ioc0
 28:         29          0   IO-APIC-level  ioc1
NMI:          0          0
LOC:      94835      96567
ERR:          0
MIS:          0


Does that conclude anything that who is/was the potential source?

Vivek


