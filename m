Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSHWXQ0>; Fri, 23 Aug 2002 19:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSHWXQ0>; Fri, 23 Aug 2002 19:16:26 -0400
Received: from ariel.yandex.ru ([213.180.193.62]:15114 "EHLO ariel.yandex.ru")
	by vger.kernel.org with ESMTP id <S314138AbSHWXQZ>;
	Fri, 23 Aug 2002 19:16:25 -0400
Subject: Bad IO APIC entry in MP table (code change proposal)
To: linux-kernel@vger.kernel.org
Date: Sat, 24 Aug 2002 03:20:24 +0400 (MSD)
From: "kosta" <kporotchkin@yandex.ru>
Reply-To: kporotchkin@yandex.ru
Message-Id: <3D66C338.000015.14456@ariel.yandex.ru>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ]
X-source-ip: 67.89.124.10
Content-Type: text/plain;
  charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all
It seems that kernel is not always protected against buggy BIOSes. I discovered this fact on custom x86 board which uses Intel 7500 chipset. This chipset supports up to 8 PCI buses (two on ICH IO hub and two on each P64H2 PCI hubs). In my case all this hubs are populated on board with the exception of one channel on last P64H2 hub. Each one of these channels has it's own IO APIC, so we have one of them unused.
The BIOS configures the IO APIC table entries for each IO APIC, puts right addresses in each entry, but "forgets" to change the flag of unused IO APIC to "~MPC_APIC_USABLE". The buggy entry (excepting the base address) is empty (i.e. filled with 0xff) then placed to MP table somewhere between the good entries. Kernel initialization procedure reads this entry, warns user about bad IO APIC ID, but continues to use it (I am talking about 2.4.17 version - maybe this behavior has already changed in 2.5.x tree?). This leads to wrong IRQ assignment for devices located on IO APICS which MP table entries are behind the buggy one. IRQs are growing in numbers (above 300) and later it's impossible to register an IRQ handler for these devices, as their IRQ numbers exceed 224.
Windows runs on such board without any problem.
I think that MP table parser should be changed. The bad IO APIC entry should not be taken into account, so all the rest of devices will work as usual.
I did this in my particular case inside the MP_ioapic_info function, but I am not sure that this will work for all Linux community. Probably the mpparse.c code maintainers can do this better (Ingo? Alan?).
Anyway, I think Linux should work better than Windows in a such cases, not worse
Thanks.

Kosta Porotchkin
