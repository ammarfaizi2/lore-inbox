Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262981AbUDARod (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 12:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263006AbUDARoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 12:44:32 -0500
Received: from holomorphy.com ([207.189.100.168]:44974 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262981AbUDARoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 12:44:21 -0500
Date: Thu, 1 Apr 2004 09:44:05 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, kenneth.w.chen@intel.com,
       Chris Wright <chrisw@osdl.org>
Subject: Re: disable-cap-mlock
Message-ID: <20040401174405.GG791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>, kenneth.w.chen@intel.com,
	Chris Wright <chrisw@osdl.org>
References: <20040401135920.GF18585@dualathlon.random> <20040401164825.GD791@holomorphy.com> <20040401165952.GM18585@dualathlon.random> <20040401171625.GE791@holomorphy.com> <1080841071.25431.155.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080841071.25431.155.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 12:37:51PM -0500, Stephen Smalley wrote:
> See dummy_capable for the root logic, i.e.:
>        if (cap_is_fs_cap (cap) ? task->fsuid == 0 : task->euid == 0)
>                return 0;
> Note that you shouldn't assume that task == current.  The intent is to
> support capability checks against other processes as well, e.g. the old
> OOM killer code performed such checks as part of deciding which process
> to kill.

That's a bogon; thanks for checking.

On Thu, Apr 01, 2004 at 12:37:51PM -0500, Stephen Smalley wrote:
> Why fall through as opposed to just returning -EPERM?

It's a made-up thing, so the semantics are totally contrived. I had
in mind a "root bypasses all capability checks" thing. Maybe it should
die.


On Thu, Apr 01, 2004 at 12:37:51PM -0500, Stephen Smalley wrote:
> What prevents any uid 0 process from changing these sysctl settings
> (aside from SELinux, if you happen to use it and configure the policy
> accordingly)?

I'm aware it does some very unintelligent things to the security model,
e.g. anyone with fs-level access to these things can basically escalate
their capabilities to "everything". Maybe some kind of big fat warning
is in order.


-- wli


Index: mm4-2.6.5-rc3/security/sysctl_capable.c
===================================================================
--- mm4-2.6.5-rc3.orig/security/sysctl_capable.c	2004-04-01 09:07:36.000000000 -0800
+++ mm4-2.6.5-rc3/security/sysctl_capable.c	2004-04-01 09:41:41.000000000 -0800
@@ -145,7 +145,7 @@
 		return -EINVAL;
 	switch (capability_sysctl_state[cap]) {
 		case CAPABILITY_SYSCTL_ROOT:
-			if (current->uid == 0)
+			if (task->uid == 0)
 				return 0;
 			/* fall through */
 		case CAPABILITY_SYSCTL_ENABLED:
