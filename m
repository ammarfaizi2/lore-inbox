Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWAMEaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWAMEaG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 23:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWAMEaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 23:30:06 -0500
Received: from canuck.infradead.org ([205.233.218.70]:39352 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S964816AbWAMEaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 23:30:05 -0500
Subject: Re: [PATCH] [5/6] Handle TIF_RESTORE_SIGMASK for i386
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, drepper@redhat.com,
       David Howells <dhowells@redhat.com>
In-Reply-To: <20060112195950.60188acf.akpm@osdl.org>
References: <1136923488.3435.78.camel@localhost.localdomain>
	 <1136924357.3435.107.camel@localhost.localdomain>
	 <20060112195950.60188acf.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 04:30:05 +0000
Message-Id: <1137126606.3085.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 19:59 -0800, Andrew Morton wrote:
> applied, or with all of David's patches applied, an FC5-test1 machine hangs
> during the login process (local vt or sshd).  An FC1 machine doesn't
> exhibit the problem.

So the 'successful' login reported at 19:21:45 never actually completed
and gave you a shell?

I can't make out which process it is that's misbehaving... and your
login was pid 2292 but I don't see your SysRq-T output going up that
far. Am I missing something?

I note you're running auditd -- FC5-test1 enabled syscall auditing by
default. Does the problem persist if you prevent the auditd initscript
from starting up? If so, let's turn auditing back on and actually make
use of it -- assuming the offending process is actually one of your own
after the login has changed uid, can you set an audit rule to log all
syscalls from your own userid? (add '-Aexit,always -Fuid=500'
to /etc/audit.rules, assuming 500 is your own uid). Then show me the
appropriate section from /var/log/audit/audit.log. 

I tested both with and without audit on PPC -- David, did you test this
patch with auditing enabled on i386?

Will attempt to reproduce locally... I've _also_ seen login hangs on
current linus trees but they've been different (and on that machine I
haven't had the TIF_RESTORE_SIGMASK patches either). It happens on disk
activity though -- after 'rpm -i <kernelpackage>' the whole machine
locks up and I have no more file system access. If your SysRq-T got to
the disk, I suspect you aren't seeing the same problem.

-- 
dwmw2

