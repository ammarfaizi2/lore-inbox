Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbULHUeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbULHUeO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 15:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbULHUeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 15:34:14 -0500
Received: from mail.nextweb.net ([216.237.6.33]:47116 "EHLO mail.nextweb.net")
	by vger.kernel.org with ESMTP id S261357AbULHUdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 15:33:41 -0500
Subject: PROBLEM: incorrect return value checks from kernel_read()
From: Katrina Tsipenyuk <ytsipenyuk@fortifysoftware.com>
Reply-To: katrina@fortifysoftware.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Fortify Software
Message-Id: <1102538553.5383.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 08 Dec 2004 12:42:33 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux developers,
                                                                                                                                                             
Fortify Software engineering team has looked at linux-2.6.10-rc2
and performed static analysis of the code. We have discovered several
instances of the same potential vulnerability in the kernel code.
Below we provide a more detailed description of the issues.
                                                                                                                                                             
[1.] We have found several instances of incorrect return value checks
from kernel_read().
[2.] Checking whether the return value from kernel_read() is
non-negative is not enough. kernel_read() function returns the number of
bytes that have actually been read, which could be different from the
number of bytes requested to be read (indicated by the fourth
parameter). If the number of bytes read differs from the number of bytes
requested, and an appropriate check is omitted, the wrong assumption is
made as to what the contents of the destination buffer used for reading
are. This could lead to unexpected / non-deterministic program behavior,
which is especially unpleasant for the kernel. We have noticed the same
problem in several different places. Considering the fact that in other
cases, the return from kernel_read() is correctly validated, these are
definite bugs.
                                                                                                                                                             
1) fs/binfmt_misc.c:
                                                                                                                                                             
...
187:  bprm->file = interp_file;
188:  if (fmt->flags & MISC_FMT_CREDENTIALS) {
189:          /*
190:           * No need to call prepare_binprm(), it's already been
191:           * done.  bprm->buf is stale, update from interp_file.
192:           */
193:          memset(bprm->buf, 0, BINPRM_BUF_SIZE);
194:          retval = kernel_read(bprm->file, 0, bprm->buf,
BINPRM_BUF_SIZE);
195:  } else
196:          retval = prepare_binprm (bprm);
197:
198:  if (retval < 0)
199:          goto _error;
...
                                                                                                                                                             
Here, return value from kernel_read() is assigned to retval on line 194,
and then on line 198 retval is incorrectly validated.
                                                                                                                                                             
The same is true for prepare_binprm() function, since it returns
kernel_read(). Therefore, in the example above, the return from
prepare_binprm() assigned to retval on line 196, is also incorrectly
validated on line 198.
                                                                                                                                                             
fs/exec.c:
                                                                                                                                                             
...
874: int prepare_binprm(struct linux_binprm *bprm)
875: {
...
918:        return kernel_read(bprm->file,0,bprm->buf,BINPRM_BUF_SIZE);
919: }
...
                                                                                                                                                             
2) fs/exec.c:
                                                                                                                                                             
...
1016:    retval = prepare_binprm(bprm);
1017:    if (retval<0)
1018:            return retval;
...
                                                                                                                                                             
Here, return value from prepare_binprm() is assigned to retval on line
1016, and then on line 1017 retval is incorrectly validated.
                                                                                                                                                             
3) fs/exec.c:
                                                                                                                                                             
...
1132:   retval = prepare_binprm(bprm);
1133:   if (retval < 0)
1134:           goto out;
...
                                                                                                                                                             
Here, return value from prepare_binprm() is assigned to retval on line
1132, and then on line 1133 retval is incorrectly validated.
                                                                                                                                                             
4) fs/binfmt_script.c:
                                                                                                                                                             
...
93:   retval = prepare_binprm(bprm);
94:   if (retval < 0)
95:           return retval;
...
                                                                                                                                                             
Here, return value from prepare_binprm() is assigned to retval on line
93, and then on line 94 retval is incorrectly validated.
                                                                                                                                                             
5) fs/compat.c:
                                                                                                                                                             
...
1442:   retval = prepare_binprm(bprm);
1443:   if (retval < 0)
1444:           goto out;
...
                                                                                                                                                             
Here, return value from prepare_binprm() is assigned to retval on line
1442, and then on line 1443 retval is incorrectly validated.
                                                                                                                                                             
6) fs/binfmt_em86.c:
                                                                                                                                                             
...
91:   retval = prepare_binprm(bprm);
92:   if (retval < 0)
93:           return retval;
...
                                                                                                                                                             
Here, return value from prepare_binprm() is assigned to retval on line
91, and then on line 92 retval is incorrectly validated.
                                                                                                                                                             
[3.] Note that in fs/binfmt_elf.c there are several other uses
of kernel_read() -- lines 337, 537, 586, 630, 971, 994 -- where
appropriate checks are made, and appropriate actions are taken in case
of failure, e.g. an error code is returned.
                                                                                                                                                             
[4.] Fixing the above issues should be trivial and quick. One just needs
to perform correct success / failure checks on the return from
kernel_read() and prepare_binprm(), making sure that the return value
equals the fourth parameter, and take appropriate actions depending on
the situation: return an error code, panic, etc. One could even refer to
other occurrences of kernel_read() and prepaer_binprm() to see what
actions should be taken in various cases. Some line numbers are provided
in [3.].
                                                                                                                                                             
[5.] For a detailed explanation of related issues, refer to
http://lwn.net/Articles/110486/.
                                                                                                                                                             
                                                                                                                                                             
                Sincerely,
                                                                                                                                                             
                        Fortify Software Team

