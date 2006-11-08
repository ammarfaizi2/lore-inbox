Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965230AbWKHKSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965230AbWKHKSQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 05:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965335AbWKHKSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 05:18:16 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:50886 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S965230AbWKHKSP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 05:18:15 -0500
Date: Wed, 8 Nov 2006 02:20:37 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Zack Weinberg <zackw@panix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC PATCH: apply security_syslog() only to the syslog() syscall, not to /proc/kmsg
Message-ID: <20061108102037.GA6602@sequoia.sous-sol.org>
References: <eb97335b0611072016y51e1625hcd6504fddfe9aa6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb97335b0611072016y51e1625hcd6504fddfe9aa6c@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zack Weinberg (zackw@panix.com) wrote:
> Presently, the security checks for syslog(2) apply also to access to
> /proc/kmsg, because /proc/kmsg's file_operations functions just call
> do_syslog, and the call to security_syslog is in do_syslog, not
> sys_syslog.  [The only callers of do_syslog are sys_syslog and
> kmsg_{read,poll,open,release}.]  This has the effect, with the default
> security policy, that no matter what the file permissions on
> /proc/kmsg are, only a process with CAP_SYS_ADMIN can actually open or
> read it.  [Yes, if you open /proc/kmsg as root and then drop
> privileges, subsequent reads on that fd fail.]  In consequence, if one
> wishes to run klogd as an unprivileged user, one is forced to jump
> through awkward hoops - for example, Ubuntu's /etc/init.d/klogd
> interposes a root-privileged "dd" process and a named pipe between
> /proc/kmsg and the actual klogd.

The act of reading from /proc/kmsg alters the state of the ring buffer.
This is not the same as smth like dmesg, which simply dumps the messages.
That's why only getting current size and dumping are treated as
less-privileged.

> I propose to move the security_syslog() check from do_syslog to
> sys_syslog, so that the syscall remains restricted to CAP_SYS_ADMIN in
> the default policy, but /proc/kmsg is governed by its file
> permissions.  With the attached patch, I can run klogd as an
> unprivileged user, having changed the ownership of /proc/kmsg to that
> user before starting it, and it still works.  Equally, I can leave the
> ownership alone but modify klogd to get messages from stdin, start it
> with stdin open on /proc/kmsg (again unprivileged) and it works.
> 
> I think this is safe in the default security policy - /proc/kmsg
> starts out owned by root and mode 400 - but I am not sure of the
> impact on SELinux or other alternate policy frameworks.

SELinux doesn't distinguish the entrypoint to the ringbuffer,
so this patch would break its current behaviour.

thanks,
-chris
