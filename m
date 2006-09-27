Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWI0DLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWI0DLQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 23:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWI0DLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 23:11:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44268 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932329AbWI0DLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 23:11:15 -0400
Date: Tue, 26 Sep 2006 20:11:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, adurbin@google.com
Subject: Re: 2.6.18-mm1
Message-Id: <20060926201104.1bb1a193.akpm@osdl.org>
In-Reply-To: <m1mz8mqd4a.fsf@ebiederm.dsl.xmission.com>
References: <20060924040215.8e6e7f1a.akpm@osdl.org>
	<m1mz8mqd4a.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2006 20:04:05 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> When I apply:
> x86_64-mm-insert-ioapics-and-local-apic-into-resource-map
> 
> My e1000 fails to initializes and complains about a bad eeprom checksum.
> I haven't tracked this down to root cause yet and I am in the process of building
> 2.6.18-mm1 with just that patch reverted to confirm that is the only cause.
> 
> I could not see anything obvious in the patch.  I don't have a clue the patch
> could be triggering the problem I'm seeing.
> 
> At a quick visual diff I'm not seeing any other differences in the kernel boot
> logs, or in /proc/iomem.

This bit looks fishy:

 GSI 17 sharing vector 0x4A and IRQ 17
 PCI->APIC IRQ transform: 0000:05:0c.0[A] -> IRQ 17
+PCI: Cannot allocate resource region 8 of bridge 0000:00:02.0
+PCI: Cannot allocate resource region 8 of bridge 0000:01:00.0
+PCI: Cannot allocate resource region 8 of bridge 0000:01:00.2
+PCI: Cannot allocate resource region 0 of device 0000:01:00.1
+PCI: Cannot allocate resource region 0 of device 0000:01:00.3
+PCI: Cannot allocate resource region 0 of device 0000:03:04.0
+PCI: Cannot allocate resource region 0 of device 0000:03:04.1
 PCI-GART: No AMD northbridge found.
 PCI: Bridge: 0000:01:00.0
   IO window: disabled.
-  MEM window: fe000000-fe0fffff
+  MEM window: e2000000-e20fffff
   PREFETCH window: fd000000-fdffffff
 PCI: Bridge: 0000:01:00.2
   IO window: 1000-1fff
-  MEM window: fe100000-fe1fffff
+  MEM window: e2100000-e21fffff
   PREFETCH window: disabled.
 PCI: Bridge: 0000:00:02.0
   IO window: 1000-1fff
-  MEM window: fe000000-fe2fffff
+  MEM window: e2000000-e22fffff
   PREFETCH window: fd000000-fdffffff
 PCI: Bridge: 0000:00:06.0
   IO window: disabled.
@@ -123,17 +131,17 @@
 PCI: Bridge: 0000:00:1e.0
   IO window: 2000-2fff
   MEM window: fb000000-fc0fffff
-  PREFETCH window: e2000000-e20fffff


Wanna hack into arch/i386/pci/i386.c:pcibios_allocate_bus_resources() and
see what is conflicting with what?
