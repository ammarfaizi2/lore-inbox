Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317454AbSG1Xeg>; Sun, 28 Jul 2002 19:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317457AbSG1Xeg>; Sun, 28 Jul 2002 19:34:36 -0400
Received: from mallaury.noc.nerim.net ([62.4.17.82]:16397 "HELO
	mallaury.noc.nerim.net") by vger.kernel.org with SMTP
	id <S317454AbSG1Xef>; Sun, 28 Jul 2002 19:34:35 -0400
Message-ID: <3D448052.4070805@inet6.fr>
Date: Mon, 29 Jul 2002 01:37:54 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>, Lei-Chun Chang <lcchang@sis.com.tw>,
       Andre Hedrick <andre@linuxdiskcert.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: SiS 5513 ATA133 support patch for 2.4.19-rc3-ac3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Marcelo, I was mistaken when I told you that the patch (adding ATA133
support and bringing sis5513.c from v0.13 to v0.14) only brought
performance enhancements.

The matter is far more complicated.
Background:
- sis5513.c v0.13 looks only for a set of known northbridge PCI IDs 
instead of using a more fine probing,
- SiS started to produce separate northbridge/southbridge chips.

 From earliest bugreports I believed updated southbridges came
with new northbriges too (reports indicated "646" for 645DX and thus the 
driver didn't recognised the chip and fallbacked to original SiS5513 
mode -> no data corruption) and didn't bother.

Today I received a report for v0.13 with a *645* ID for a 645DX. This ID 
is recognised as only ATA100-capable -> data corruption occured (problem 
solved with v0.14).

So I'm now sure we will have data corruption with v0.13 (we overclock 
the IDE UDMA writes for problematic configurations).

A workaround would be to remove support for problematic PCI IDs in v0.13.

*But* I guess we have an unresolvable problem in v0.13 with latest 
southbridges (962/963): the register layout changed completely. Unlike 
previous chipsets, fallback to sis5513 mode could fail. I guess that the 
master of the primary controller would be fine when the registers aren't 
relocated (may be BIOS dependant or even worse, having booted another OS 
dependant). But all other IDE devices could be screwed up and all of 
them can be if the registers have been remapped.
The only workaround for this is a v0.14 with enough time for tests.

Before releasing 2.4.19 I think we should either :
- completely remove the affected northbridges (645, 650, 745, 750) 
support in v0.13, this is a simple patch. Then we wait for 2.4.20 to 
include v0.14.
- put v0.14 in.

 From past experiences we need 2 weeks of availability of code in
the AC/pre kernels before the wave of meaningful bugreports ends.

LB.

