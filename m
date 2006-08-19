Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422701AbWHSCCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422701AbWHSCCu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 22:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751622AbWHSCCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 22:02:50 -0400
Received: from victor.provo.novell.com ([137.65.250.26]:29376 "EHLO
	victor.provo.novell.com") by vger.kernel.org with ESMTP
	id S1751477AbWHSCCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 22:02:49 -0400
Message-ID: <44E6714C.3090707@novell.com>
Date: Fri, 18 Aug 2006 19:02:52 -0700
From: Crispin Cowan <crispin@novell.com>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "Serge E. Hallyn" <serue@us.ibm.com>, "Serge E. Hallyn" <serge@hallyn.com>,
       Nicholas Miell <nmiell@comcast.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org
Subject: Re: [RFC] [PATCH] file posix capabilities
References: <20060730011338.GA31695@sergelap.austin.ibm.com>	 <20060814220651.GA7726@sergelap.austin.ibm.com>	 <m1r6zirgst.fsf@ebiederm.dsl.xmission.com>	 <20060815020647.GB16220@sergelap.austin.ibm.com>	 <m13bbyr80e.fsf@ebiederm.dsl.xmission.com>	 <1155615736.2468.12.camel@entropy> <20060815114946.GA7267@vino.hallyn.com>	 <1155658688.1780.33.camel@moss-spartans.epoch.ncsc.mil>	 <20060816024200.GD15241@sergelap.austin.ibm.com> <1155734401.18911.33.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1155734401.18911.33.camel@moss-spartans.epoch.ncsc.mil>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley wrote:
> On Tue, 2006-08-15 at 21:42 -0500, Serge E. Hallyn wrote:
>   
>> But since file capabilities cannot survive an exec, analysis with a gui
>> which walks the fs could be pretty simple.
>>     
> Except that people actually want them to be inheritable (under certain
> conditions), just in a way that avoids the problems encountered in the
> past.  If you start on the path of making capabilities useful, you'll
> have to tackle that as well.
>   
Stephen makes a good point here.

Have you looked at how AppArmor handles POSIX Capabilities? It has these
advantages:

    * Whether a capability is inheritable or not is specified by policy,
      addressing Stephan's' point.
    * Does not depend on extended attributes, so becomes filesystem
      independent.
    * As I understand it, it resembles the Solaris "process rights"
      mechanism, and so (as Albert Cahalan suggested) will be less
      surprising to Solaris users transitioning to Linux.

Currently it is implemented as part of the AppArmor module, but I could
imagine it being busted out into a separate module. The main thing I
would wonder about is some kind of API so that policy engines like
AppArmor and SELinux could manipulate the POSIX capabilities.

> Actually, ptrace already performs a capability comparison (cap_ptrace).
> Wrt signals, it wasn't the communication channel that concerned me but
> the ability to interfere with the operation of a process running in the
> same uid but different capabilities, like stopping it at a critical
> point.  Likewise with many other task hooks - you wouldn't want to be
> able to depress the priority of a process running with greater
> capabilities.
>   
Is that a property of Serge's module? Or just a property of the basic
crappyness of the POSIX Capabilities idea in the first place?

> Also, think about the real benefits of capabilities, at least as defined
> in Linux.  The coarse granularity and the lack of any per-object support
> is a fairly significant deficiency there that is much better handled via
> TE.
Only if the user wants to buy all the way into TE. Making POSIX
Capabilities, TE, and AppArmor composeable choices seems like a good
goal. The question is whether POSIX Capabilities on their own are worth
while. But consider:

    * They are already there on their own, pulling POSIX Capabilities
      out seems like a non-option because too much already uses them.
    * They are nearly useless without some kind of management interface.
      Adding a decent management interface can only make it better.

Serge has proposed a reasonable model. I would like to suggest that
people, especially Serge, consider the AppArmor model as well before
deciding.

To quickly summarize the AppArmor model, you have an external policy
file that says that e.g. /usr/local/foo can have net_bind_service and
ipc_lock. This is a bit mask overlaid on top of whatever capabilities
the process already has, e.g. because it is UID 0 it has all of them. So
if someone runs /usr/local/foo as an unprivileged user, it has no
capabilities, and the bitmask does nothing. If someone runs
/usr/local/foo as root, then instead of all 32 capabilities, they get
only those 2.

>  At least some of the Linux capabilities lend themselves to easy
> privilege escalation to gaining other capabilities or effectively
> bypassing them.
>   
Certainly; cap_sys_admin effectively gives you ownership of the machine.
But that is fundamental to the POSIX Capabilities model, and not
something that Serge can change.

Crispin

-- 
Crispin Cowan, Ph.D.                      http://crispincowan.com/~crispin/
Director of Software Engineering, Novell  http://novell.com
     Hack: adroit engineering solution to an unanticipated problem
     Hacker: one who is adroit at pounding round pegs into square holes

