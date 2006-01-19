Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWASJeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWASJeb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 04:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWASJea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 04:34:30 -0500
Received: from relay03.pair.com ([209.68.5.17]:4871 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1751390AbWASJe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 04:34:29 -0500
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: scsi cmd slab leak? (Was Re: [ck] Anyone been having OOM killer problems lately?)
Date: Thu, 19 Jan 2006 03:34:03 -0600
User-Agent: KMail/1.9
Cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
References: <200601181951.16708.chase.venters@clientec.com> <200601190316.05247.chase.venters@clientec.com> <200601192018.51972.kernel@kolivas.org>
In-Reply-To: <200601192018.51972.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_301zDNItS+EvNcH"
Message-Id: <200601190334.25712.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_301zDNItS+EvNcH
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 19 January 2006 03:18, Con Kolivas wrote:
> On Thursday 19 January 2006 20:15, Chase Venters wrote:
> > On Thursday 19 January 2006 01:49, Con Kolivas wrote:
> > > > 	Do I have something madly leaking in my kernel?
> > >
> > > Yes! post /proc/slabinfo
> >
> > (attached). Looks like quite a few scsi commands! Next steps?
>
> Inded it does
> scsi_cmd_cache    1547440 1547440    384   10    1 : tunables   54   27   
> 8 : slabdata 154744 154744      0
>
> This looks suspiciously large. To be absolutely certain, though, you have
> to reproduce the problem with a vanilla kernel, and no binary drivers
> anywhere. My patches don't touch the scsi code directly, but the only way
> to be certain is to use vanilla.

I'll have to try and get around to that soon - I'm currently busy with some 
various work and can't afford the time just yet :/.

Also, I just realized that I copied lkml and scsi without providing any useful 
context. Kernel is 2.6.15-ck1 with the Marvell sk98lin patch and (barf) 
nvidia.ko. I noticed after having the OOM killer make its rounds a few times 
that the slab layer was eating in excess of 600MB.

lspci:

00:00.0 Host bridge: Intel Corporation 915G/P/GV/GL/PL/910GL Processor to I/O 
Controller (rev 04)
00:01.0 PCI bridge: Intel Corporation 915G/P/GV/GL/PL/910GL PCI Express Root 
Port (rev 04)
00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High 
Definition Audio Controller (rev 03)
00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI 
Express Port 1 (rev 03)
00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI 
Express Port 2 (rev 03)
00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #1 (rev 03)
00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #2 (rev 03)
00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #3 (rev 03)
00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #4 (rev 03)
00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB2 EHCI Controller (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d3)
00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC Interface 
Bridge (rev 03)
00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
IDE Controller (rev 03)
00:1f.2 Class 0106: Intel Corporation 82801FR/FRW (ICH6R/ICH6RW) SATA 
Controller (rev 03)
00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus 
Controller (rev 03)
01:03.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 
Controller (PHY/Link)
01:04.0 Mass storage controller: <pci_lookup_name: buffer too small> (rev 13)
01:09.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
01:09.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (rev 
04)
01:09.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 04)
01:0a.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 Gigabit 
Ethernet Controller (rev 15)
04:00.0 VGA compatible controller: nVidia Corporation Unknown device 0092 (rev 
a1)

config.gz attached. I'd also like to note that I've been getting this in my 
ring buffer when attempting to burn CD's on a PX-716A:

(scsi0:A:4:0): No or incomplete CDB sent to device.
scsi0: Issued Channel A Bus Reset. 1 SCBs aborted
(scsi0:A:4:0): Unexpected busfree while idle
SEQADDR == 0x16a
(scsi0:A:4:0): No or incomplete CDB sent to device.
scsi0: Issued Channel A Bus Reset. 1 SCBs aborted
sr 0:0:4:0: SCSI error: return code = 0x70000
(scsi0:A:4:0): Unexpected busfree while idle
SEQADDR == 0x16a
(scsi0:A:4:0): No or incomplete CDB sent to device.
scsi0: Issued Channel A Bus Reset. 1 SCBs aborted
(scsi0:A:4:0): Unexpected busfree while idle
SEQADDR == 0x16a
(scsi0:A:4:0): No or incomplete CDB sent to device.
scsi0: Issued Channel A Bus Reset. 1 SCBs aborted
sr 0:0:4:0: SCSI error: return code = 0x70000
(scsi0:A:4:0): Unexpected busfree while idle
SEQADDR == 0x16a
(scsi0:A:4:0): No or incomplete CDB sent to device.
scsi0: Issued Channel A Bus Reset. 1 SCBs aborted

...but I don't think this is directly related, because this has been happening 
since at least 2.6.13 iirc. Just being thorough.

Apologies to lkml & scsi for the brief/confusing earlier message.

> Cheers,
> Con

Thanks,
Chase

--Boundary-00=_301zDNItS+EvNcH
Content-Type: application/x-gzip;
  name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config.gz"

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
Jof5C+ZF4GZZh8Fg+s0zdNIK9P8DwOZ76GOYAAA=

--Boundary-00=_301zDNItS+EvNcH--
