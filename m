Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271730AbTHHRhz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 13:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271731AbTHHRhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 13:37:55 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:61939 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S271730AbTHHRhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 13:37:52 -0400
Date: Fri, 8 Aug 2003 10:37:45 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: lkml <linux-kernel@vger.kernel.org>, phil-list@redhat.com
Subject: Re: NPTL v userland v LT (RH9+custom kernel problem)
Message-ID: <20030808103745.B30702@google.com>
References: <20030807013930.A26426@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030807013930.A26426@google.com>; from fcusack@fcusack.com on Thu, Aug 07, 2003 at 01:39:30AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 01:39:30AM -0700, Frank Cusack wrote:
> PAM prompts for the username and password, then pam_ldap appears to
> get stuck in a syslog call.  It doesn't actually call syslog(), but if
> I compare to a functional system, the working one opens /dev/log etc
> whereas the broken one does an rt_sigsuspend() and hangs until a SIGALRM
> is delivered (login having set this up before prompting for the password).
> That's from looking at strace; I haven't looked at ltrace or tried to
> run under the debugger yet.

Even without pam_ldap, I see it getting stuck.  'groups: files ldap' in
nsswitch.conf sets it off.  Here's an sshd that's hung, does this light
the a-ha bulb for anyone?

(gdb) bt
#0  0x40564845 in __pthread_sigsuspend () from /lib/i686/libpthread.so.0
#1  0x40564318 in __pthread_wait_for_restart_signal ()
   from /lib/i686/libpthread.so.0
#2  0x40565d30 in __pthread_alt_lock () from /lib/i686/libpthread.so.0
#3  0x40562d37 in pthread_mutex_lock () from /lib/i686/libpthread.so.0
#4  0x401df2fc in vsyslog () from /lib/i686/libc.so.6
#5  0x4024b4b7 in _log_err () from /lib/security/pam_unix.so
#6  0x40249039 in pam_sm_open_session () from /lib/security/pam_unix.so
#7  0x4003ac09 in pam_fail_delay () from /lib/libpam.so.0
#8  0x4003ad93 in _pam_dispatch () from /lib/libpam.so.0
#9  0x4003c978 in pam_open_session () from /lib/libpam.so.0
...

/fc
