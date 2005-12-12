Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbVLLMM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbVLLMM0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 07:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVLLMM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 07:12:26 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17307 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751244AbVLLMMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 07:12:25 -0500
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, ink@jurassic.park.msu.ru, linux-kernel@vger.kernel.org,
       rth@twiddle.net, davej@redhat.com, zwane@arm.linux.org.uk, ak@suse.de,
       ashok.raj@intel.com
Subject: Re: [PATCH] alpha build pm_power_off hack
References: <20051211232428.18286.40968.sendpatchset@sam.engr.sgi.com>
	<m1y82qany7.fsf@ebiederm.dsl.xmission.com>
	<20051211222404.d35f990c.pj@sgi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 12 Dec 2005 05:10:34 -0700
In-Reply-To: <20051211222404.d35f990c.pj@sgi.com> (Paul Jackson's message of
 "Sun, 11 Dec 2005 22:24:04 -0800")
Message-ID: <m1u0dea539.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> writes:

> Eric wrote:
>> Taking a quick glance at alpha causes me to think we always
>> want pm_power_off to be non null on alpha.
>
> So I presume you think that some alpha person should write
> such a function?

Sorry I had about 5 minutes to do something when this issue
came up and unfortunately I knew how to solve it cleanly :(
So I wrote the patch.  It was my hope that by putting it into
-mm I could sucker someone with some time into doing fixing
the architectures that broke.

I think what we want is one of the too patches below.  Basically
something that just sets pm_power_off to a non NULL value is
enough to continue the alphas current behaviour.

> I can't quite guess whether you are agreeing with my patch,
> or disagreeing with it.

Disagreeing in saying it didn't quite go far enough pm_power_off
should be initialized on alpha.

> At the very least, I don't want to leave the crosstools build
> of alpha with a default config broken.

That is a good point.  But I really don't want to see a fix that
just blindly fixes a build issue.  When it takes about 10 minutes
to audit machine_power_off and see what really needs to be done.

To that extent I have hacked up your patch two different ways
one of them should be usable.  I'm just not certain which non-zero
initializer I like better.  The second setting pm_power_off to
machine_power_off is what the powerpc port currently does.

Eric


---

 arch/alpha/kernel/process.c |    5 +++++
 1 files changed, 5 insertions(+)

--- 2.6.15-rc5-mm2.orig/arch/alpha/kernel/process.c 2005-12-11
15:07:52.000000000 -0800
+++ 2.6.15-rc5-mm2/arch/alpha/kernel/process.c 2005-12-11 15:09:33.000000000
-0800
@@ -43,6 +43,11 @@
 #include "proto.h"
 #include "pci_impl.h"
 
+/*
+ * Power off function, alpha doesn't use but we should
+ * always call machine_power_off.
+ */
+void (*pm_power_off)(void) = ERR_PTR(-EINVAL);
+
 void
 cpu_idle(void)
 {

---

 arch/alpha/kernel/process.c |    5 +++++
 1 files changed, 5 insertions(+)

--- 2.6.15-rc5-mm2.orig/arch/alpha/kernel/process.c 2005-12-11
15:07:52.000000000 -0800
+++ 2.6.15-rc5-mm2/arch/alpha/kernel/process.c 2005-12-11 15:09:33.000000000
-0800
@@ -43,6 +43,11 @@
 #include "proto.h"
 #include "pci_impl.h"
 
+/*
+ * Power off function, alpha doesn't use but we should
+ * always call machine_power_off.
+ */
+void (*pm_power_off)(void) = machine_power_off;
+
 void
 cpu_idle(void)
 {



