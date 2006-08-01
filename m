Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWHAQms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWHAQms (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 12:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWHAQms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 12:42:48 -0400
Received: from ms-smtp-01.rdc-kc.rr.com ([24.94.166.115]:11970 "EHLO
	ms-smtp-01.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S1750779AbWHAQms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 12:42:48 -0400
Subject: PROBLEM: PCI/Intel 82945 trouble on Toshiba M400 notebook
From: Elias Holman <eholman@holtones.com>
Reply-To: eholman@holtones.com
To: linux-kernel@vger.kernel.org
In-Reply-To: <1153832603.3141.29.camel@parachute.holtones.com>
References: <1153832603.3141.29.camel@parachute.holtones.com>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 11:43:02 -0500
Message-Id: <1154450582.3078.18.camel@parachute.holtones.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I submitted an email a week or so ago about a hang on boot due to a null
pointer dereference.  The problem started in 2.6.17-rc2 and continues
through 2.6.18-rc3.  I did some more digging on this problem hoping to
spark some interest.  I've narrowed the problem down to the following
code in pci_read_bases:

for(pos=0; pos<howmany; pos = next) {
.
.
.
pci_read_config_dword(dev, reg, &l);
//hang happens here on first attempt to write
pci_write_config_dword(dev, reg, ~0);

At that point, the device being accessed is the intel graphics hardware,
specifically, if you print out the vendor and device ID, you get:

vendor: 0x8086 = intel
device: 0x27A2 = PCI_DEVICE_ID_INTEL_82945GM_IG

I assume the issue is actually with this driver, but I don't understand
driver loading and the kernel architecture well enough to know where to
look next.  The device appears to be at two locations on the bus based
on my understanding of what lspci is telling me.  It appears to hang
when it is being accessed via 00:02.0; I'm basing this on some debug
messages I put in.

Following is the output of lspci -vvv for this device run on 2.6.17-rc1,
and the relevant text of my original email.  Any assistance or pointers
anyone can offer would be greatly appreciated.

00:02.0 VGA compatible controller: Intel Corporation Mobile Integrated
Graphics Controller (rev 03) (prog-if 00 [VGA])
        Subsystem: Toshiba America Info Systems Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at ffd80000 (32-bit, non-prefetchable)
[size=512K]
        Region 1: I/O ports at cff8 [size=8]
        Region 2: Memory at e0000000 (32-bit, prefetchable) [size=256M]
        Region 3: Memory at ffd40000 (32-bit, non-prefetchable)
[size=256K]
        Capabilities: [90] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable-
                Address: 00000000  Data: 0000
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 Display controller: Intel Corporation Mobile Integrated Graphics
Controller (rev 03)
        Subsystem: Toshiba America Info Systems Unknown device 0001
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at 55000000 (32-bit, non-prefetchable)
[disabled] [size=512K]
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



On Tue, 2006-07-25 at 08:03 -0500, Elias Holman wrote:
> I have a Toshiba Portege M400 tablet notebook that will not boot due to
> a null pointer dereference.  This problem appears to have been
> introduced between 2.6.17-rc1 and rc2.  I have tried many kernels since
> then with no better luck, up to 2.6.18-rc2.  I apologize if this issue
> has been addressed via a patch or otherwise and I have not seen it, but
> a search of the mailing list archives turned up nothing except that this
> problem was informally reported on June 21st by Herbert Rosmanith, but
> he chose not to submit a full report for whatever reason.  From his
> email:
> 
> "I just had to examine
> a notebook which had problems with our software: a
> "toshiba portege m400". 2.4 seems to work so far, as does 2.6.16.
> I also tried 2.6.17, but get a strange problem: it simply hangs
> after writing "PCI: probing hardware" (or similar). A closer look
> reveals that it hangs in drivers/pci/probe.c, in pci_read_bases. What's
> exactly going on, I don't know..."

> I can get further into the boot process by specifying pci=off, although
> then acpi has trouble.  If I specify pci=off and acpi=off, then it gets
> even further, but eventually has trouble mounting the root filesystem.
> 
> I am currently running what appears to be a stable configuration on
> 2.6.17-rc1 with no issue.  I am happy to provide any more debugging
> information that someone might need.
-- 
Eli


