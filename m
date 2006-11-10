Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424301AbWKJATZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424301AbWKJATZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 19:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424303AbWKJATZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 19:19:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:40708 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1424301AbWKJATY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 19:19:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=tzbFuysgWpfzZsqOTNRSwDd9DI1b8YgqCz7fXX9wYeEyoJRAamMY6rnQusIAFctMEYeyRnP4NtPUX67/VFqDlt3gdgJ/xdYgw98rEJNtJWhlBFhzRfwbeAtDcgk+qq2jeTGzsadRdraffQnSnvPnCfwjZn1stPavtIe3QPzTBWI=
Message-ID: <4807377b0611091619v6bfe17f4tbcbb64db0ab8ea9@mail.gmail.com>
Date: Thu, 9 Nov 2006 16:19:22 -0800
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
Subject: Re: Intel 82559 NIC corrupted EEPROM
Cc: auke-jan.h.kok@intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, hpa@zytor.com, saw@saw.sw.com.sg
In-Reply-To: <45533801.7000809@privacy.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_65524_3589564.1163117962597"
References: <454B7C3A.3000308@privacy.net> <454BF0F1.5050700@zytor.com>
	 <45506C9A.5010009@privacy.net> <4551B7B8.8080601@privacy.net>
	 <4807377b0611080926x21bd6326xc5e7683100d20948@mail.gmail.com>
	 <45533801.7000809@privacy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_65524_3589564.1163117962597
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 11/9/06, John <me@privacy.net> wrote:
> > The second thought is that the adapter is in D3, and something about
> > your kernel or the driver doesn't successfully wake it up to D0.
>
> On my NICs, the EEPROM ID (Word 0Ah) is set to 0x40a2.
> Thus DDPD (bit 6) is set to 0.
>
> DDPD is the "Disable Deep Power Down while PME is disabled" bit.
> 0 - Deep Power Down is enabled in D3 state while PME-disabled.
> 1 - Deep Power Down disabled in D3 state while PME-disabled.
> This bit should be set to 1b if a TCO controller is being used via the
> SMB because it requires receive functionality at all power states.
>
> Are you suggesting I try and set DDPD to 1?
> Or is this completely unrelated?

This may be related but I doubt it.  Something is strange about how
memory is being mapped in your system.  whatever is creating the
problem moved when you changed the kernel version.  I'm wondering if
there is a device collision at e5302000.  I'm not convinced at this
point it is e100's fault.

can you send output of cat /proc/iomem

> > An indication of this would be looking at lspci -vv before/after
> > loading the driver.
>
> $ diff -u lspci_vv_before_e100.txt lspci_vv_after_e100.txt
> --- lspci_vv_before_e100.txt    2006-11-09 14:51:30.000000000 +0100
> +++ lspci_vv_after_e100.txt     2006-11-09 14:51:30.000000000 +0100
> @@ -74,21 +74,20 @@
>          Expansion ROM at 20000000 [disabled] [size=1M]
>          Capabilities: [dc] Power Management version 2
>                  Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
> -               Status: D0 PME-Enable+ DSel=0 DScale=2 PME-
> +               Status: D0 PME-Enable- DSel=0 DScale=2 PME-

okay when the driver loads it is clearing PME enable, but not
re-enabling it when it unloads.  That is pretty much expected.

>   00:09.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro
> 100] (rev 08)
>          Subsystem: Intel Corporation EtherExpress PRO/100B (TX)
> -       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
> +       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>          Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>  >TAbort- <TAbort- <MAbort- >SERR- <PERR-

pci_enable_device should be enabling io,mem,busmaster, they are
probably being disabled when the driver errors out of init.  maybe you
should add a call to  pci_set_power_state(dev, PCI_D0); before the
call to e100_reset

> > Also, after loading/unloading eepro100 does the e100 driver work?
>
> No.

now that is really odd.

> > A third idea is look for a master abort in lspci after e100 fails to
> > load.
>
> I don't understand that one.

There isn't one, MAbort+ would be showing in the above lspci output.

The all 0xffffffff returns when you read registers is a sure sign the
hardware either isn't at the address specified or is in a power down
state.  The only other option i can think of is that something else is
intercepting memory reads and writes.

try something like the attached patch, compile tested only:

------=_Part_65524_3589564.1163117962597
Content-Type: application/octet-stream; name=e100_debug.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eubudvqt
Content-Disposition: attachment; filename="e100_debug.patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2UxMDAuYyBiL2RyaXZlcnMvbmV0L2UxMDAuYwppbmRl
eCBjZTg1MGYxLi42OWU2MmZkIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC9lMTAwLmMKKysrIGIv
ZHJpdmVycy9uZXQvZTEwMC5jCkBAIC0yNTg1LDYgKzI1ODUsOSBAQCAjZW5kaWYKIAluaWMtPm1z
Z19lbmFibGUgPSAoMSA8PCBkZWJ1ZykgLSAxOwogCXBjaV9zZXRfZHJ2ZGF0YShwZGV2LCBuZXRk
ZXYpOwogCisJZXJyID0gcGNpX3NldF9wb3dlcl9zdGF0ZShwZGV2LCBQQ0lfRDApOworCXByaW50
aygiIGUxMDAgZGVidWc6IHVuYWJsZSB0byBzZXQgcG93ZXIgc3RhdGUgKGVycm9yICVkKVxuIiwg
ZXJyKTsKKwogCWlmKChlcnIgPSBwY2lfZW5hYmxlX2RldmljZShwZGV2KSkpIHsKIAkJRFBSSU5U
SyhQUk9CRSwgRVJSLCAiQ2Fubm90IGVuYWJsZSBQQ0kgZGV2aWNlLCBhYm9ydGluZy5cbiIpOwog
CQlnb3RvIGVycl9vdXRfZnJlZV9kZXY7CkBAIC0yNjE3LDYgKzI2MjAsMjQgQEAgI2VuZGlmCiAJ
CWdvdG8gZXJyX291dF9mcmVlX3JlczsKIAl9CiAKKwkvKiBxdWljayByZWdpc3RlciB0ZXN0ICov
CisJeworCQl2b2lkIF9faW9tZW0gKmlvYmFzZSA9ICBwY2lfaW9tYXAocGRldiwgMSwgcGNpX3Jl
c291cmNlX2xlbihwZGV2LCAxKSk7CisJCXUzMiBpb3JlZywgaW9tZW07CisKKwkJaWYgKCFpb2Jh
c2UpCisJCQlnb3RvIG5vdHdvcmtpbmc7CisKKwkJaW9yZWcgPSBpb3JlYWQzMihpb2Jhc2UpOwor
CQlpb21lbSA9IHJlYWRiKCZuaWMtPmNzci0+c2NiLnN0YXR1cyk7CisKKwkJcHJpbnRrKCJlMTAw
IGRlYnVnOiByZWFkICUwOFgvJTA4WCBmcm9tIHRoZSBzYW1lIHJlZ2lzdGVyXG4iLCBpb3JlZywg
aW9tZW0pOworCisJCXBjaV9pb3VubWFwKHBkZXYsIGlvYmFzZSk7CisJCisJfQorbm90d29ya2lu
ZzoKKwogCWlmKGVudC0+ZHJpdmVyX2RhdGEpCiAJCW5pYy0+ZmxhZ3MgfD0gaWNoOwogCWVsc2UK

------=_Part_65524_3589564.1163117962597--
