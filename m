Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbUCAQ2v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 11:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbUCAQ2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 11:28:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17299 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261357AbUCAQ2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 11:28:47 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16451.25789.72815.763592@neuro.alephnull.com>
Date: Mon, 1 Mar 2004 11:28:45 -0500
From: Rik Faith <faith@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] Light-weight Auditing Framework
X-Key: 7EB57214; 958B 394D AD29 257E 553F  E7C7 9F67 4BE0 7EB5 7214
X-Url: http://www.redhat.com/
X-Mailer: VM 7.17; XEmacs 21.4; Linux 2.4.22-1.2163.nptl (neuro)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This note describes a patch against 2.6.4-rc1-bk2 that provides a
low-overhead system-call auditing framework for Linux that is usable by
LSM components (e.g., SELinux).  Comments will be appreciated.

The main goals were to provide system call auditing with 1) as low
overhead as possible, and 2) without duplicating functionality that is
already provided by SELinux (and/or other security infrastructures).
This framework will work "stand-alone", but is not designed to provide,
e.g., CAPP functionality without another security component in place.

There are two main parts, one that is always on (generic logging in
audit.c) and one that you can disable at boot- or run-time
(per-system-call auditing in auditsc.c).  The patch includes changes to
security/selinux/avc.c as an example of how system-call auditing can be
integrated with other code that identifies auditable events.

Logging:
    1) Uses a netlink socket for communication with user-space.  All
       messages are logged via the netlink socket if a user-space daemon
       is listening.  If not, the messages are logged via printk to the
       syslog daemon (by default).
    2) Messages can be dropped (optionally) based on message rate or
       memory use (this isn't fully integrated into the selinux/avc.c
       part of the patch: the avc.c code that currently does this can be
       eliminated).
    3) When some part of the kernel generates part of an audit record,
       the partial record is sent immediately to user-space, AND the
       system call "auditable" flag is automatically set for that call
       -- thereby producing extra information at syscall exit (if
       syscall auditing is enabled).

System-call auditing:
    1) At task-creation time, an audit context is allocated and linked
       off the task structure.
    2) At syscall entry time, if the audit context exists, information
       is filled in (syscall number, timestamp; but not arguments).
    3) During the system call, calls to getname() and path_lookup() are
       intercepted.  These routines are called when the kernel is
       actually looking up information that will be used to make the
       decision about whether the syscall will succeed or fail.  An
       effort has been made to avoid copying the information that
       getname generates, since getname is already making a
       kernel-private copy of the information.  [Note that storing
       copies of all syscall arguments requires complexity and overhead
       that arguably isn't needed.  With this patch, for example, if
       chroot("foo") fails because you are not root, "foo" will not
       appear in the audit record because the kernel determined the
       syscall cannot proceed before it ever needed to look up "foo".
       This approach avoids storing user-supplied information that could
       be misleading or unreliable (e.g., due to a cooperative
       shared-memory attack) in favor of reporting information actually
       used by the kernel.]
    4) At syscall exit time, if the "auditable" flag has been set (e.g.,
       because SELinux generated an avc record; or some other part of
       the kernel detected an auditable event), the syscall-part of the
       audit record is generated, including file names and inode numbers
       (if available).  Some of this information is currently
       complementary to the information that selinux/avc.c generates
       (e.g., file names and some inode numbers), but some is less
       complete (e.g., getname doesn't return a fully-qualified path,
       and this patch does not add the overhead of determining one).
       [Note that the complete audit record comes to userspace in
       pieces, which eliminates the need to store messages for
       arbitrarily long periods inside the kernel.]
    5) At task-exit time, the audit context is destroyed.

    At steps 1, 2, and 4, simple filtering can be done (e.g., a database
    role uid might have syscall auditing disabled for performance
    reasons).  The filtering is simple and could be made more complex.
    However, I tried to implement as much filtering as possible without
    adding significant overhead (e.g., d_path()).  In general, the audit
    framework should rely on some other kernel component (e.g., SELinux)
    to make the majority of the decisions about what is and is not
    auditable.

A few (obvious) things are not yet implemented:
    1) Filtering on syscall personality (i.e., i386 calls on x86_64).
    2) Multi-platform syscall support (currently syscall auditing has
       only been implemented on i386, x86_64, and ppc64).
    3) Documentation.

I have also written very crude user-space tools that can be used to test
the features provided (auditd-0.3.tar.gz).  This demo tarball, a
readme.txt (see for how to compile), and the patch (and more recent
patches?) are available from: http://people.redhat.com/faith/audit/


 arch/i386/kernel/entry.S         |    6 
 arch/i386/kernel/ptrace.c        |    8 
 arch/ppc64/kernel/entry.S        |   15 
 arch/ppc64/kernel/ptrace.c       |   27 -
 arch/x86_64/ia32/ia32entry.S     |   12 
 arch/x86_64/kernel/entry.S       |   21 
 arch/x86_64/kernel/ptrace.c      |   23 -
 fs/namei.c                       |   15 
 include/asm-i386/thread_info.h   |    5 
 include/asm-ppc64/thread_info.h  |    3 
 include/asm-x86_64/thread_info.h |    5 
 include/linux/audit.h            |  210 +++++++++
 include/linux/fs.h               |   10 
 include/linux/netlink.h          |    1 
 include/linux/sched.h            |    5 
 init/Kconfig                     |   20 
 kernel/Makefile                  |    2 
 kernel/audit.c                   |  771 ++++++++++++++++++++++++++++++++++
 kernel/auditsc.c                 |  872 +++++++++++++++++++++++++++++++++++++++
 kernel/fork.c                    |    9 
 security/selinux/avc.c           |  146 ++----
 security/selinux/include/avc.h   |    7 
 security/selinux/ss/services.c   |    2 
 23 files changed, 2065 insertions(+), 130 deletions(-)


Due to size, the patch is available from;
    http://people.redhat.com/faith/audit/audit-20040226.1411.patch


