Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424306AbWKJAkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424306AbWKJAkU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 19:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424316AbWKJAkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 19:40:20 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:15427 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1424306AbWKJAkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 19:40:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=LFqV5eocdrI4mPL8Gys4+fjVvDbgaA1nyQKUqPxHS2FiK1vBv0AT+ccvbytRuOov8P4FY44GDmNDL9lsmhTspkunq3cw3MqBGO1gkgDuEG89Ybsmf91X7HWTlsHmqPZgghw6Baw0z0jkYFf+RzVKCUV0Tu6cSYlTE6DPWcloMbA=
Message-ID: <eb97335b0611091640i5bc149a5yb32f8f8581af3648@mail.gmail.com>
Date: Thu, 9 Nov 2006 16:40:03 -0800
From: "Zack Weinberg" <zackw@panix.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: RFC PATCH: apply security_syslog() only to the syslog() syscall, not to /proc/kmsg
Cc: "Chris Wright" <chrisw@sous-sol.org>, "Sergey Vlasov" <vsu@altlinux.ru>,
       linux-kernel@vger.kernel.org, jmorris@namei.org
In-Reply-To: <1163105609.12241.395.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <eb97335b0611072016y51e1625hcd6504fddfe9aa6c@mail.gmail.com>
	 <20061108102037.GA6602@sequoia.sous-sol.org>
	 <20061108154229.eb6d4626.vsu@altlinux.ru>
	 <20061109041400.GB6602@sequoia.sous-sol.org>
	 <1163083837.12241.282.camel@moss-spartans.epoch.ncsc.mil>
	 <eb97335b0611090808q4738d29ai88da69aab97a84aa@mail.gmail.com>
	 <1163090431.12241.358.camel@moss-spartans.epoch.ncsc.mil>
	 <eb97335b0611090939x7afbca7fkb5da56a15f0895c0@mail.gmail.com>
	 <1163105609.12241.395.camel@moss-spartans.epoch.ncsc.mil>
X-Google-Sender-Auth: d42c4281e29af5a3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/06, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Thu, 2006-11-09 at 09:39 -0800, Zack Weinberg wrote:
> >  An open fd on /proc/kmsg
> > (with my changes applied) offers strictly fewer privileges than
> > SYSTEM__SYSLOG_MOD (no access to opcodes 4 and 5), and with SELinux
> > active, you can't get that open fd without having had
> > SYSTEM__SYSLOG_MOD at some prior time.
>
> Sure you can.  You can inherit or receive a descriptor opened by another
> process that had that permission (and even accidental descriptor leakage
> isn't as uncommon as you might think; SELinux has turned up numerous
> cases of it).

See, from my perspective, being able to pass this fd around is a
*feature*.  It lets me do things like

start-stop-daemon --start --chuid klog --chroot /var/run/klogd --exec
/sbin/klogd -- -x -P - -o - < /proc/kmsg > /dev/log

(hypothetical, does not work with unpatched klogd)

Being able to open /proc/kmsg subject only to standard DAC checks is
*also* a feature in my book.  In short, what you are saying reads to
me as "I don't want you to do the very thing you are trying to do."

I also think we wouldn't be having this discussion in the first place
if it weren't that /proc/kmsg was historically implemented on top of
sys_syslog() which *has* to do permission checks on the
read-equivalent, 'cos anyone can call that without having done any
open-equivalent first.

[...]
> > I see this as bringing /proc/kmsg in line with standard Unix file
> > permission semantics, overall.
>
> It may fit with Linux DAC checking, but it isn't what we want for MAC.
> You also have to be careful about drawing an analogy to typical Linux
> permission checking, since this is proc rather than a normal filesystem.

So let me back off and try to explain again what my goals are here.

I want to be able to run klogd as an unprivileged user, under the
default security model, possibly in a chroot jail; in particular it
should have to keep neither uid 0 nor CAP_SYS_ADMIN in order to read
from /proc/kmsg.  The logical way to accomplish this, to my mind, is
to subject /proc/kmsg to the normal Unix DAC checks and no more.  From
that reference frame, I see security_syslog as relevant to the
syslog() system call, which doesn't *have* DAC to rely on, and not to
/proc/kmsg.

Now, I see that the SELinux model is rather different, but I'm asking
you to consider the possibility of using the same "label" stuff for
/proc/kmsg that is used for all other file-based permissions in
SELinux.  If it would make it easier, I am prepared to do the
gruntwork of turning the thing into a misc character device or
something like that.  That way, security_syslog() could still be only
about access control for the syslog() system call.

Note that I'm perfectly fine with needing to apply special privileges
to klogd in a SELinux universe -- it's just that in the default model
one might as well not bother dropping privileges if one has to leave
CAP_SYS_ADMIN asserted.

> > But that mapping is itself a security policy decision, and could
> > plausibly need to be done differently in different security modules...
>
> Even the set of security hook interfaces and placements impose some
> limits on security policies that can be implemented.  But just as those
> hooks can be adjusted over time for the needs of new modules, the
> mapping can be adjusted over time as needed.  No harm done, and some
> benefit.

Hmm, okay, so the existing groupings that selinux/hooks.c has make
sense to me, except I'd split up SYSTEM__SYSLOG_MOD a bit ...

#define KLOG_CLOSE           0  /* Close the log  */
#define KLOG_OPEN            1  /* Open the log  */
#define KLOG_READ            2  /* Read from the log (klogd) */
#define KLOG_GET_UNREAD      9  /* Return number of unread characters */

 -> "can be klogd"

#define KLOG_READ_ALL        3  /* Read history of log messages (dmesg) */
#define KLOG_GET_SIZE       10  /* Return size of log buffer */

 -> "can be dmesg"

#define KLOG_READ_CLEAR_ALL  4  /* Read and clear history of log messages */
#define KLOG_CLEAR           5  /* Clear history of log messages */

 -> "can clear message history"

#define KLOG_DISABLE_CONSOLE 6  /* Disable printk's to console */
#define KLOG_ENABLE_CONSOLE  7  /* Enable printk's to console */
#define KLOG_SET_CONSOLE_LVL 8  /* Set level of messages printed to console */

 -> "can adjust console loglevel"

(#defines taken from the local <linux/syslog.h> that I've made up;
currently "can be klogd" and "can clear message history" are lumped
together; perhaps one should need both "can be dmesg" and "can clear
message history" for READ_CLEAR_ALL, but that might be too picky)

zw
