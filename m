Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313012AbSDKXVZ>; Thu, 11 Apr 2002 19:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313014AbSDKXVZ>; Thu, 11 Apr 2002 19:21:25 -0400
Received: from h52544c185a20.ne.client2.attbi.com ([24.147.41.41]:18697 "EHLO
	luna.pizzashack.org") by vger.kernel.org with ESMTP
	id <S313012AbSDKXVY>; Thu, 11 Apr 2002 19:21:24 -0400
Date: Thu, 11 Apr 2002 19:21:23 -0400
From: xystrus <xystrus@haxm.com>
To: linux-kernel@vger.kernel.org
Subject: link() security
Message-ID: <20020411192122.F5777@pizzashack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

If this subject has been beaten to death in the past, a link to the
discussion is really all I need...

Is there a good reason why a user can successfully link() a file to
which they do not have any access?

Here's a scenario:

Many linux systems, like Slackware and SuSE, favor the permissions
1777 for the mail spool directory.  This is a good policy from a
security perspective, as it prevents mail utilities from requiring
SUID/SGID root or mail privileges to create a user's spool and/or lock
files.

Now, people often point to several problems with this scheme.  Such
as the following:

 * users can create an unlimited number of files in this directory,
   potentially using up all availabile inodes

 * users can use the spool as scratch space, and potentially fill up
   the spool filesystem

 * users can create links to other users' spool files.

The first two really are very minor problems in comparison to a
potential security breach (priviledge elevation), and can be solved
with quota and/or site policy.  Troublesome users who ignore policy
can be dealt with appropriately.

The last one is a bit sticky though.  As a regular user, I can create
a hard link to someone's spool file, and call it whatever I want.
This isn't a major problem, because the resulting link retains the
permissions and ownership of the original file; therefore a user who
does this can't gain access to anything they didn't already have
access to...  However, it certainly can constitute an abuse of
resources and/or site policy.

There are cases where this can be a security problem though; and
what's more, there's no apparent way to identify who created the link,
since the link retains ownership of the original file.  If, for
example, a malicious user noticed that a particular new user's spool
file had not been created, he could link(mymailbox, newusermailbox).
And now (ignoring locking issues in the spool area), one of two things
will happen:

 a) if the mail delivery programs run with privileges (despite not
    needing to with 1777 permissions on the spool), the new user's
    mail will be delivered to the malicious user's spool.

 b) if they don't run with privileges, a mail delivery error should
    result, alerting the system administrators to the problem.

Either way, this isn't really a great situation.  But here's the worst
part:  a malicious user can frame someone, say another user they hold
a grudge against, as having done this.  Since the link() call succeeds
regardless of permissions on the file, the malicious user can also
call link(framedusermailbox, newusermailbox)!  The system
administration team has no way to identify who created the file.  They
can't even look and see who was on at time of creation, because the
creation time is the same as that of the original file.  Worse still,
system administrators who are not aware of this behavior of link() may
mistakenly believe that the file was created by the framed user, and
recommend expulsion or termination of their employment/access/whatever
on that basis.

I've tested that this works on Red Hat 7.1 with pristine 2.4.17
sources and using the ln command.  I have not actually written a
program that calls link() in this manner.  However the ln command is
not SUID, so I can imagine no other way this would work...

In my opinion, the solution to this problem is to check that the file
being linked is owned by the UID of the calling process, or that the
UID is root (or that the process has the appropriate capabilities -- a
facility that I'm not overly familiar with).  If not, the call to
link() should fail with EACCES or EPERM.


Thanks,
Xy

