Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754579AbWKHMmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579AbWKHMmg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 07:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754578AbWKHMmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 07:42:36 -0500
Received: from mivlgu.ru ([81.18.140.87]:25577 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S1754579AbWKHMmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 07:42:35 -0500
Date: Wed, 8 Nov 2006 15:42:29 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Chris Wright <chrisw@sous-sol.org>
Cc: Zack Weinberg <zackw@panix.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC PATCH: apply security_syslog() only to the syslog()
 syscall, not to /proc/kmsg
Message-Id: <20061108154229.eb6d4626.vsu@altlinux.ru>
In-Reply-To: <20061108102037.GA6602@sequoia.sous-sol.org>
References: <eb97335b0611072016y51e1625hcd6504fddfe9aa6c@mail.gmail.com>
	<20061108102037.GA6602@sequoia.sous-sol.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.2; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__8_Nov_2006_15_42_29_+0300_iLnLG.wxngx=LeZr"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__8_Nov_2006_15_42_29_+0300_iLnLG.wxngx=LeZr
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 8 Nov 2006 02:20:37 -0800 Chris Wright wrote:

> * Zack Weinberg (zackw@panix.com) wrote:
> > Presently, the security checks for syslog(2) apply also to access to
> > /proc/kmsg, because /proc/kmsg's file_operations functions just call
> > do_syslog, and the call to security_syslog is in do_syslog, not
> > sys_syslog.  [The only callers of do_syslog are sys_syslog and
> > kmsg_{read,poll,open,release}.]  This has the effect, with the default
> > security policy, that no matter what the file permissions on
> > /proc/kmsg are, only a process with CAP_SYS_ADMIN can actually open or
> > read it.  [Yes, if you open /proc/kmsg as root and then drop
> > privileges, subsequent reads on that fd fail.]  In consequence, if one
> > wishes to run klogd as an unprivileged user, one is forced to jump
> > through awkward hoops - for example, Ubuntu's /etc/init.d/klogd
> > interposes a root-privileged "dd" process and a named pipe between
> > /proc/kmsg and the actual klogd.

And ALT Linux uses exactly the same patch as you have posted :)

klogd starts as root, opens /proc/kmsg, then chroots to a directory
which contains just the dev/log socket and drops all privileges.

> The act of reading from /proc/kmsg alters the state of the ring buffer.
> This is not the same as smth like dmesg, which simply dumps the messages.
> That's why only getting current size and dumping are treated as
> less-privileged.

But in order to read from /proc/kmsg, you need to open() it first - and
that operation is restricted both by DAC checks on /proc/kmsg and by
do_syslog(1,NULL,0) call in kmsg_open().  (However, the patch by Zack
effectively removes that access check, which is probably not good for
SELinux.)

> > I propose to move the security_syslog() check from do_syslog to
> > sys_syslog, so that the syscall remains restricted to CAP_SYS_ADMIN in
> > the default policy, but /proc/kmsg is governed by its file
> > permissions.  With the attached patch, I can run klogd as an
> > unprivileged user, having changed the ownership of /proc/kmsg to that
> > user before starting it, and it still works.  Equally, I can leave the
> > ownership alone but modify klogd to get messages from stdin, start it
> > with stdin open on /proc/kmsg (again unprivileged) and it works.
> >
> > I think this is safe in the default security policy - /proc/kmsg
> > starts out owned by root and mode 400 - but I am not sure of the
> > impact on SELinux or other alternate policy frameworks.
>
> SELinux doesn't distinguish the entrypoint to the ringbuffer,
> so this patch would break its current behaviour.

Then what would you think about another solution:

 1) When sys_syslog() is called with commands 2 (read) or 9 (get unread
    count), additionally call security_syslog(1) to check that the
    process has permissions to open the kernel log.  This change by
    itself will not make any difference, because all existing
    implementations of the security_ops->syslog hook treat the operation
    codes 1, 2 and 9 the same way.

 2) Change cap_syslog() and dummy_syslog() to permit commands 2 and 9
    for unprivileged users, in addition to 3 and 10 which are currently
    permitted.  This will not really permit access through sys_syslog()
    due to the added security_syslog(1) check, but if a process somehow
    got access to an open file descriptor for /proc/kmsg, it would be
    able to read from it.  Also, because selinux_syslog() is not
    changed, under SELinux the process will still need to have
    additional privileges even if it has /proc/kmsg open.

Two patches will follow.

--Signature=_Wed__8_Nov_2006_15_42_29_+0300_iLnLG.wxngx=LeZr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFUdC4W82GfkQfsqIRAqXvAJ95rQSQx0wrl6TY0E9lj6fJZntqIgCeKCjo
xtSWpXRaYZt+l6HCBRzklJI=
=qcqh
-----END PGP SIGNATURE-----

--Signature=_Wed__8_Nov_2006_15_42_29_+0300_iLnLG.wxngx=LeZr--
