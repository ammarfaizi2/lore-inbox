Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269504AbUHZUJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269504AbUHZUJZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269554AbUHZUGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:06:40 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:51302 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S269551AbUHZUAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:00:51 -0400
Date: Thu, 26 Aug 2004 21:00:41 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Len Brown <len.brown@intel.com>
cc: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc1 Latitude APM suspend freeze
Message-ID: <Pine.LNX.4.44.0408261949110.3367-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Been suffering APM suspend freezes with 2.6.9-rc1 on Dell Latitude C610.
Now found that you have removed local_apic_kills_bios(),
which existed precisely to protect against that.

Perhaps my UP .config, inherited down four years of oldconfig,
was silly to be saying (APIC and ACPI mentions only):

CONFIG_X86_GOOD_APIC=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_ACPI is not set

for this machine.  I've updated it to:

CONFIG_X86_GOOD_APIC=y
# CONFIG_X86_UP_APIC is not set
# CONFIG_ACPI is not set

and it looks like the laptop can now do APM suspend safely again [*].

I'm open-minded as to whether you've done a good cleanup and I had
a stupid .config; or you've changed things around (perhaps assuming
CONFIG_ACPI=y?), liable to cause lots of APM suspend grief in 2.6.9.

Hugh

[*] Well, only its first APM suspend has been safe with a vanilla
kernel, ever since the vsyscall page was introduced: later resumes often
wiping the vital sysenter MSRs.  Seemed to come down to prior resume not
seeing its resume event, and I've patched apm.c to deal with that ever
since (resume doesn't need an event to know it's resuming).

So far, since running without CONFIG_X86_UP_APIC, I've not seen my
warning message of that case: so it's possible the config change will
prove to fix that issue too, which would strengthen the case in your
favour.  Too soon to tell: somehow it rarely happened when trying to
test for it, only when doing real-life suspend and resume.

