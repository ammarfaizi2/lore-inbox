Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263687AbUD0CVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbUD0CVN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 22:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263688AbUD0CVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 22:21:13 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.145]:48649 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S263687AbUD0CVI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 22:21:08 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Subject: 2.4.26 oops in i810_audio on HP Pavilion zd7100
Date: Mon, 26 Apr 2004 19:21:06 -0700
Message-ID: <128D60D434C15C4ABE1A4E78E03BC1CF081930FB@mail-sc-9.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4.26 oops in i810_audio on HP Pavilion zd7100
Thread-Index: AcQr/kwETU54Bp+IRC2FbKGLdOHMHw==
From: "I-Gene Leong" <ileong@nvidia.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm attempting to get sound working on an HP Pavilion zd7100. I get this
on driver init:

Intel 810 + AC97 Audio, version 0.24, 18:44:49 Apr 26 2004
i810: Intel ICH5 found at IO 0x1c80 and 0x1400, MEM 0xd0000c00 and
0xd0000800, IRQ 10
i810: Intel ICH5 mmio at 0xe0b10c00 and 0xe0b12800
i810_audio: Primary codec has ID 0
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 0
ac97_codec: AC97 Modem codec, id: CXT48 (Unknown)
i810_audio: codec 0 is a softmodem - skipping.
Unable to handle kernel NULL pointer dereference at virtual address
00000024
 printing eip:
c01e3fb2
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01e3fb2>]    Not tainted
EFLAGS: 00010246
eax: ffffffff   ebx: 00000000   ecx: dff6a580   edx: c15ec800
esi: 000001f0   edi: 00000000   ebp: dff6a580   esp: dff6df00
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=dff6d000)
Stack: 00000282 00000246 00000246 00000032 dff6a580 000001f0 00000000
00000000
       c02a5646 dff6a580 ffffffff 00000000 00000a04 00000282 c1587388
dff6a580
       dff6a580 dff6a5b0 c15ec800 00000000 00000000 00000001 00000000
c15ec800
Call Trace:    [<c01ea605>] [<c01ea6ac>] [<c0105000>] [<c0105080>]
[<c01073ce>]
  [<c0105070>]

Code: 8b 43 24 8b 48 08 85 c9 75 27 0f b7 82 16 02 00 00 83 e0 fb
 <0>Kernel panic: Attempted to kill init!

Windows reports the laptop has a Conexant AC-Link audio codec.

I did some digging around with EIP and found it was dying in
i810_set_spdif_output. The actual assembly source from the beginning of
the function:

000E3F90  83EC20            sub esp,byte +0x20
000E3F93  896C241C          mov [esp+0x1c],ebp
000E3F97  8B6C2424          mov ebp,[esp+0x24]
000E3F9B  897C2418          mov [esp+0x18],edi
000E3F9F  31FF              xor edi,edi
000E3FA1  895C2410          mov [esp+0x10],ebx
000E3FA5  89742414          mov [esp+0x14],esi
000E3FA9  8B5504            mov edx,[ebp+0x4]
000E3FAC  8B9AF0010000      mov ebx,[edx+0x1f0]
000E3FB2  8B4324            mov eax,[ebx+0x24]
000E3FB5  8B4808            mov ecx,[eax+0x8]
000E3FB8  85C9              test ecx,ecx
000E3FBA  7527              jnz 0xe3fe3

Comparing this against the C source, I would hazard a guess that
state->card->ac97_codec[0] is null. Wonder if this has something to do
with the detection of the modem codec.

I'd do further digging but I'm not familiar at all with i810_audio.

Please cc me on all replies. Thanks.
- I-Gene
