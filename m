Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbULBTzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbULBTzZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 14:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbULBTzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 14:55:25 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:56055 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261742AbULBTzU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 14:55:20 -0500
Subject: Re: [PATCH 4/6] Add dynamic context transition support to SELinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Darrel Goeddel <dgoeddel@trustedcs.com>
In-Reply-To: <20041202111859.A2357@build.pdx.osdl.net>
References: <1102002189.26015.107.camel@moss-spartans.epoch.ncsc.mil>
	 <20041202103456.O14339@build.pdx.osdl.net>
	 <1102013788.26015.192.camel@moss-spartans.epoch.ncsc.mil>
	 <20041202111859.A2357@build.pdx.osdl.net>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1102017022.26015.249.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Dec 2004 14:50:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-02 at 14:18, Chris Wright wrote:
> No, I was thinking of actually tracking the threads, since you know when
> they come and go.  One way would be to share task_security_struct via
> refcnt for threads, although this could get sticky.

Hmm...that would be a significant change, and I'm not clear that the
existing security_task_alloc() hook even allows for it (no clone_flags
passed to it).  ptrace_sid could also be an issue for sharing.

Note that the mm checking logic is already after one permission check
(setcurrent), which will only be allowed to the small set of privileged
processes that use this feature.  That acts as the gatekeeper for any
use of this feature, then the dyntransition check controls the possible
transitions among security contexts using this feature.  In the case of
exec-based transitions, the corresponding transition check is deferred
until the actual exec processing.  So even as it stands, arbitrary
processes aren't allowed to reach the code in question, which is better
than the [gs]etpriority cases.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

