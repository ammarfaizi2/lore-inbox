Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318186AbSHIHEQ>; Fri, 9 Aug 2002 03:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318188AbSHIHEQ>; Fri, 9 Aug 2002 03:04:16 -0400
Received: from dsl2.external.hp.com ([192.25.206.7]:16906 "EHLO
	dsl2.external.hp.com") by vger.kernel.org with ESMTP
	id <S318186AbSHIHEO>; Fri, 9 Aug 2002 03:04:14 -0400
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: PCI<->PCI bridges, transparent resource fix 
In-Reply-To: Message from Ivan Kokshaysky <ink@jurassic.park.msu.ru> 
   of "Thu, 08 Aug 2002 15:30:42 +0400." <20020808153042.B14158@jurassic.park.msu.ru> 
References: <20020807055456.61265482A@dsl2.external.hp.com> <20020806210220.24665@192.168.4.1> <benh@kernel.crashing.org> <20020807183025.BCB65482A@dsl2.external.hp.com>  <20020808153042.B14158@jurassic.park.msu.ru> 
Date: Fri, 09 Aug 2002 01:07:56 -0600
From: Grant Grundler <grundler@dsl2.external.hp.com>
Message-Id: <20020809070756.CDDBA482A@dsl2.external.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
> > It sounds easy to check at the top and in that case DTRT.
> > The "else" parts of later resource checks can go away.
> 
> Exactly.

I checked PCI 2.2 spec and "class code" is described in Appendix D.
For Base Class 6 (Bridges), Sub-Class 4 (PCI-PCI Bridges), Programming
Interface value of 0x01 says
	"Subtractive Decode PCI-to-PCI bridge. This interface code
	identifies the PCI-to-PCI bridge as a device that supports
	subtractive decoding in addition to all the currently defined
	functions of a PCI-to-PCI bridge."

Programming Interface byte is not specified for all other bridge types.
And the linux code isn't checking bridge type before calling
pci_read_bridges_bases().

Thinking maybe it's a defacto standard, I dumped the values
from my OB500 (< 1 year old), much older OB800, LPR1000, and
a prototype x86 machine (that's never going to be product *sigh*).
And none of these seem to have bit 1 set in Prog Interface byte.
(I was looking for 06xx01xx in the third u32)

I'm wondering if the LXR8000 I ditched earlier this year had such
a bridge. But I'll never know.

I'll try the patch anyway on the OB800. But it'll have to
wait until tomorrow. Past my bedtime here.

hth,
grant


OB500:
grundler <513>for i in */*; do echo -n $i " "; cat $i | od -Ax -t x4 | grep ^00000 | sed 's/^0* //'; done
00/00.0  71908086 22100106 06000003 00004000
00/01.0  71918086 0220001f 06040003 00018000
00/07.0  71108086 0280000f 06010002 00800000
00/07.1  71118086 02800005 01018001 00004000
00/07.2  71128086 02800005 0c030001 00004000
00/07.3  71138086 02800003 06800003 00000000
00/0a.0  ac50104c 02100007 06070001 0002a808
00/0b.0  605510b7 02100017 02000010 00805008
00/0b.1  100710b7 02100010 07800010 00005008
00/0d.0  1998125d 02900007 04010000 00004000
00/11.0  06481095 82900000 01018f01 00000000
01/00.0  4c4d1002 02900087 03000064 00004208
grundler <515>lspci | fgrep -i bridge
00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 03)
00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)

OB800:
00.0  01041004 22800006 06000003 00000000
01.0  01021004 0280000f 06040003 00010000
02.0  01011004 02800003 ff000002 00000000
03.0  000310c8 02800003 03000001 00000000
04.0  ac15104c 02000007 06070001 00824008
04.1  ac15104c 02000007 06070001 00824008
06.0  01051004 02800005 0d000002 00000000

00:00.0 Host bridge: VLSI Technology Inc 82C535 (rev 03)
00:01.0 PCI bridge: VLSI Technology Inc 82C534 (rev 03)
00:02.0 Class ff00: VLSI Technology Inc 82C532 (rev 02)
00:03.0 VGA compatible controller: Neomagic Corporation NM2093 [MagicGraph 128ZV] (rev 01)
00:04.0 CardBus bridge: Texas Instruments PCI1131 (rev 01)
00:04.1 CardBus bridge: Texas Instruments PCI1131 (rev 01)
00:06.0 IRDA controller: VLSI Technology Inc 82C147 (rev 02)
00:00.0 Host bridge: VLSI Technology Inc 82C535 (rev 03)
	Flags: bus master, medium devsel, latency 0


LPR1000:
00/00.0  71928086 02000106 06000002 00004000
00/04.0  71108086 0280000f 06010002 00800000
00/04.1  71118086 02800005 01018001 00002000
00/04.2  71128086 02800005 0c030001 00002000
00/04.3  71138086 02800003 06800002 00000000
00/07.0  00241011 02800147 06040002 00013908
00/08.0  90f0113f 02000002 07008004 00000000
00/09.0  905510b7 02100157 02000000 00005008
00/0d.0  00b81013 02000003 03000045 00000000
01/02.0  12298086 02900157 02000005 00004208
01/04.0  000c1000 02000157 01000001 0000f708
grundler <504>lspci | fgrep -i bridge
00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (AGP disabled) (rev 02)
00:04.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
00:04.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 02)
00:07.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 02)

ProtoFoster:
grundler@t11:/proc/bus/pci$ for i in */*; do echo -n $i " "; cat $i | od -Ax -t x4 | grep ^00000 | sed 's/^0* //'; done
00/00.0  00111166 00000000 06000022 00800010
00/00.1  00111166 00000000 06000000 00800010
00/00.2  00111166 00000000 06000000 00800010
00/00.3  00111166 00000000 06000000 00800010
00/02.0  25a115bc 02900157 ff000000 00804008
00/02.1  253115bc 02900143 ff000000 80804008
00/02.2  25a115bc 02900143 0c070000 00804008
00/03.0  12298086 02900157 0200000d 00004008
00/05.0  47521002 02900087 03000027 00004208
00/0f.0  02011166 22000147 06000093 00802000
00/0f.1  02121166 02000005 01018a93 00800000
00/0f.2  02201166 02900153 0c031005 00804008
00/0f.3  02251166 02000004 06010000 00800000
00/10.0  00101166 22b00002 06000003 00800000
00/10.2  00101166 22300002 06000003 00804000
00/11.0  00101166 22300002 06000003 00804000
00/11.2  00101166 22b00002 06000003 00800000
01/05.0  1219103c 04900000 08040012 00000000
19/04.0  03098086 04b00147 06040001 00014008
1a/02.0  00211000 02300157 01000001 00804808
1a/02.1  00211000 02300157 01000001 00804808

grundler@t11:/proc/bus/pci$ lspci | fgrep -i bridge
00:00.0 Host bridge: ServerWorks CMIC-HE (rev 22)
00:00.1 Host bridge: ServerWorks CMIC-HE
00:00.2 Host bridge: ServerWorks CMIC-HE
00:00.3 Host bridge: ServerWorks CMIC-HE
00:0f.0 Host bridge: ServerWorks CSB5 South Bridge (rev 93)
00:0f.3 ISA bridge: ServerWorks: Unknown device 0225
00:10.0 Host bridge: ServerWorks CIOB30 (rev 03)
00:10.2 Host bridge: ServerWorks CIOB30 (rev 03)
00:11.0 Host bridge: ServerWorks CIOB30 (rev 03)
00:11.2 Host bridge: ServerWorks CIOB30 (rev 03)
19:04.0 PCI bridge: Intel Corp.: Unknown device 0309 (rev 01)

