Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262983AbUDARkL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 12:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbUDARiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 12:38:52 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:6804 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263000AbUDARis
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 12:38:48 -0500
Subject: Re: disable-cap-mlock
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, kenneth.w.chen@intel.com,
       Chris Wright <chrisw@osdl.org>
In-Reply-To: <20040401171625.GE791@holomorphy.com>
References: <20040401135920.GF18585@dualathlon.random>
	 <20040401164825.GD791@holomorphy.com>
	 <20040401165952.GM18585@dualathlon.random>
	 <20040401171625.GE791@holomorphy.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1080841071.25431.155.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 01 Apr 2004 12:37:51 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-01 at 12:16, William Lee Irwin III wrote:
> +static int capability_sysctl_capable(task_t *task, int cap)
> +{
> +	if (cap < 0 || cap >= ARRAY_SIZE(capability_sysctl_state))
> +		return -EINVAL;
> +	switch (capability_sysctl_state[cap]) {
> +		case CAPABILITY_SYSCTL_ROOT:
> +			if (current->uid == 0)
> +				return 0;
> +			/* fall through */

See dummy_capable for the root logic, i.e.:
       if (cap_is_fs_cap (cap) ? task->fsuid == 0 : task->euid == 0)
               return 0;

Note that you shouldn't assume that task == current.  The intent is to
support capability checks against other processes as well, e.g. the old
OOM killer code performed such checks as part of deciding which process
to kill.

Why fall through as opposed to just returning -EPERM?

What prevents any uid 0 process from changing these sysctl settings
(aside from SELinux, if you happen to use it and configure the policy
accordingly)?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

