Return-Path: <linux-kernel-owner+w=401wt.eu-S1161319AbXAHPuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161319AbXAHPuh (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 10:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161320AbXAHPuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 10:50:37 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36382 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161319AbXAHPug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 10:50:36 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tobias Diedrich <ranma+kernel@tdiedrich.de>,
       Yinghai Lu <yinghai.lu@amd.com>, Andrew Morton <akpm@osdl.org>,
       Adrian Bunk <bunk@stusta.de>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] x86_64 io_apic: Implement remove_pin_to_irq
References: <5986589C150B2F49A46483AC44C7BCA490733F@ssvlexmb2.amd.com>
	<86802c440701022223q418bd141qf4de8ab149bf144b@mail.gmail.com>
	<20070108005556.GA2542@melchior.yamamaya.is-a-geek.org>
	<Pine.LNX.4.64.0701071708240.3661@woody.osdl.org>
Date: Mon, 08 Jan 2007 08:49:36 -0700
In-Reply-To: <Pine.LNX.4.64.0701071708240.3661@woody.osdl.org> (Linus
	Torvalds's message of "Sun, 7 Jan 2007 17:09:17 -0800 (PST)")
Message-ID: <m1lkkdikmn.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To try different irq routing combinations so we can make an informed
guess as to how to route irqs when the BIOS gets it wrong we need
the ability to modify our irq routing data structures.

This adds remove_pin_to_irq which removes the mapping from and apic pin
to an irq.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/io_apic.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index 2a1dcd5..7365f5f 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -286,6 +286,29 @@ static void add_pin_to_irq(unsigned int irq, int apic, int pin)
 	entry->pin = pin;
 }
 
+static void remove_pin_to_irq(unsigned int irq, int apic, int pin)
+{
+	struct irq_pin_list *entry = irq_2_pin + irq;
+
+	BUG_ON(irq >= NR_IRQS);
+
+	while (entry->next && ((entry->apic != apic) || (entry->pin != pin)))
+		entry = irq_2_pin + entry->next;
+
+	if (entry->pin == apic && entry->pin == pin) {
+		if (entry->next) {
+			struct irq_pin_list *next = irq_2_pin + entry->next;
+			*entry = *next;
+			next->pin = -1;
+			next->apic = -1;
+			next->next = 0;
+		} else {
+			entry->pin = -1;
+			entry->apic = -1;
+		}
+	}
+}
+
 
 #define DO_ACTION(name,R,ACTION, FINAL)					\
 									\
-- 
1.4.4.1.g278f

