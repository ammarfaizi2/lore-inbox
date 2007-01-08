Return-Path: <linux-kernel-owner+w=401wt.eu-S932103AbXAHWuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbXAHWuv (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 17:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbXAHWuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 17:50:51 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41214 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103AbXAHWuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 17:50:50 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Tobias Diedrich" <ranma+kernel@tdiedrich.de>,
       "Adrian Bunk" <bunk@stusta.de>, "Andi Kleen" <ak@suse.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Lu, Yinghai" <yinghai.lu@amd.com>
Subject: [PATCH] x86_64 ioapic: check_timer_pin Don't add_pin_to_irq if it is already there.
References: <5986589C150B2F49A46483AC44C7BCA490736D@ssvlexmb2.amd.com>
Date: Mon, 08 Jan 2007 15:50:14 -0700
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA490736D@ssvlexmb2.amd.com>
	(Yinghai Lu's message of "Mon, 8 Jan 2007 13:46:49 -0800")
Message-ID: <m1fyalgml5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Lu, Yinghai" <yinghai.lu@amd.com> writes:

>>Any updates to add_pin_to_irq are wrong.  It works fine.  If there
>>is something wrong we need to fix remove_pin_to_irq.
>
>>What is the problem you see?  Sorry I'm dense at the moment.

> In the check_timer_pin, irq_from_pin could return 0, it mean some entry
> is for IRQ0 already.
> The add_pin_to_irq could add another same entry for it again.

Yep.  My oversight.  Here is the trivial patch to fix it.  I don't
see how we could hit this case but if we are going to allow for it
we should handle it correctly.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/io_apic.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index 4891959..cc8e9a4 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -1687,7 +1687,8 @@ static int check_timer_pin(int apic, int pin)
 	idx = update_irq0_entry(apic, pin);
 
 	/* Add an entry in irq_to_pin */
-	add_pin_to_irq(0, apic, pin);
+	if (irq != 0)
+		add_pin_to_irq(0, apic, pin);
 
 	/* Now setup the irq */
 	setup_IO_APIC_irq(apic, pin, idx, 0);
-- 
1.4.4.1.g278f


