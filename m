Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWDTT6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWDTT6O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 15:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWDTT6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 15:58:13 -0400
Received: from victor.provo.novell.com ([137.65.250.26]:7338 "EHLO
	victor.provo.novell.com") by vger.kernel.org with ESMTP
	id S1750953AbWDTT6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 15:58:12 -0400
Message-ID: <4447E7AC.8000204@novell.com>
Date: Thu, 20 Apr 2006 12:57:32 -0700
From: Crispin Cowan <crispin@novell.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Tony Jones <tonyj@suse.de>, linux-security-module@vger.kernel.org,
       chrisw@sous-sol.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <1145535423.3313.15.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1145535423.3313.15.camel@moss-spartans.epoch.ncsc.mil>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley wrote:
> On Wed, 2006-04-19 at 10:49 -0700, Tony Jones wrote: 
>   
>> AppArmor is an LSM security enhancement for the Linux kernel. The
>> primary goal of AppArmor is to make it easy for a system administrator
>> to control application behavior, enforcing that the application has
>> access to only the files and POSIX.1e draft capabilities it requires to
>> do its job. AppArmor deliberately uses this simple access control model
>> to make it as easy as possible for the administrator to manage the
>> policy, because the worst security of all is that which is never
>> deployed because it was too hard.
>>     
> The worst security is that which doesn't do what it claims to do, giving
> a false sense of security.  Which is precisely the problem with
> path-based access control; it makes the user think that he is protecting
> a given object, when in fact the object may be accessible by another
> means.
>   
Perhaps in some implementation, but not in AppArmor:

    * AppArmor access controls are bound to processes, not files. The
      control is to contain the subject, not shield the object.
    * AppArmor uses a white list, not a black list. "By another means"
      assumes that you have another means, and with the white list of
      accessible file names, you generally don't.

Please show a case where AppArmor is not doing what it claims to do, or
stop spreading the FUD.

Consider Lampson's classic access control matrix, where you have all
your subjects (processes doing the operations) across one edge, and all
your objects (files and processes being operated on) along the other
edge, and the matrix cells contain permitted operations. Lampson's
matrix is the maximally expressive form of access control, but it is so
large as to be unmanageable. All access control schemes are abstractions
on this space to simplify it to make it manageable.

AppArmor is a particular abstraction on this space, where we profile
each row (process) by what application it runs, and then list the
columns (files) it can access, and in what mode. This is the exact dual
of ACLs, which put access lists on a file of who can access them. This
makes AppArmor a kind of capability system (in the security theory-head
way, nothing to do with POSIX.1e "capabilities"). However, because
confined entities cannot pass around AppArmor permissions as first-class
objects, it is called an "ambient capability" system.

>> AppArmor chooses which security policy to enforce for a process at
>> exec() time by the executable image's pathname, in conjunction with any
>> policy enforced for the currently running executable.
>>     
> Multiple instances of the same program can't be distinguished? 
>   
They can be distinguished by the context you call them from. If your
policy says "/bin/foo px" then it uses the system profile for /bin/foo.
If your policy says "/bin/foo ix" then it inherits the parent's profile.
If your policy says "/bin/foo ux" then it executes unconstrained.

We are designing features to allow more ways to execute the same program
under different profiles in different contexts. But these features
require no new hooks, and so should not concern kernel developers, and
only be of interest to people who plan to use AppArmor.

>> AppArmor mediates access to the file system using absolute path names
>> with shell-syntax wildcards, so that "/srv/htdocs/** r" grants read
>> access to all files in /srv/htdocs.
>>     
> So you have an unbounded number of policies that can govern access to
> any given file object and the enforcement of the system policy is
> entirely dependent on the file tree structure and any process that can
> manipulate that structure.
No; to the contrary, the above policy means the same thing on every file
system: if any file matching /srv/htdocs/** exists, then the contained
process can access it.

On the other hand, SELinux policy describes whether or not one label can
access another, and the meaning of that policy is dependent on the
existence and state of the labels in the file system. Tar and restore
your directory tree and the SELinux policy meaning changes. Labels on
the filesystem can change over time; so that running:
  find / -exec ls -Z {} \; | grep httpd_user_content_t

will only show a snapshot of what would be allowed *right now*. So if
anything, SELinux is more sensitive to file system state than AppArmor,
and in any meaningful sense has many more possible policies enforced on
the system.

>   Further, what about runtime files generated
> in shared directories like /tmp, /var/run, ...
What about them? If your program needs access to /tmp and /var, then
your policy should grant it. The above is a single line out of a
profile. The Apache profile is about 150 lines.

AppArmor is sufficiently expressive that you can give permission to
create /tmp/foo but *not* /tmp/bar. In SELinux, applications can create
/tmp files and give them labels different than the default label, but
AFAIK, SELinux can only either grant or deny permission to create a file
in a given directory, and not which file you can create.

You might care about this because the semantics of /etc/hosts.allow are
rather different than /etc/mumblebarf.

>   And let's please
> separate user interface from kernel mechanism.  If you want to specify
> pathnames for fixed resources in a user-level config file, that is fine,
> but pathnames have historically been rejected as a suitable basis for
> the kernel for a reason, not just in the security space.  Why should
> this change?  Isn't this a fundamental design change to Linux?  
>   
Because pathname matching in the kernel is fundamentally what makes
AppArmor easy to use. It is also what prevents AppArmor from being
implemented on top of SELinux.

>>  AppArmor mediates access to POSIX.1e
>> Capabilities in that the process must both have e.g. "capability
>> net_bind_service" and intrinsically have that capability (usually by
>> being root) to be able to bind to privileged network ports. Thus a
>> confined process can not subvert AppArmor except as permitted by policy,
>>     
> Not sure what is meant by "subvert AppArmor" here.
"Compromise" means a confined process being able to modify or disable
AppArmor policy.

>   Bypass is certainly possible.
>   
An interesting claim. We disagree, other than possibly coding errors.
Can you provide an actual example of bypass?

>> AppArmor is *not* intended to protect every aspect of the system from
>> every other aspect of the system: the intended usage is that only a
>> small fraction of all programs on a Linux system will have AppArmor
>> profiles. Rather, AppArmor is intended to protect the system against a
>> particular threat.
>>     
> So the attacker knows precisely how to bypass it.  The attacker (beyond
> the script kiddies) isn't going to attack you at the point of strength;
> he will attack you where you are known to be weak.
>   
If you properly configured your system to confine all exposed programs,
then the attacker *must* start from a confined program, so this is a
non-issue.

Please keep in mind that our security goals are different from what
you've considered in the past; a system administrator will confine
programs that he or she considers are a higher than tolerable risk. We
provide an easy and reliable mechanism to confine software that poses
unreasonable risk. We do not try to provide provable information flow
properties.

>> For instance, to secure a machine against network attack, all programs
>> that face the network should be profiled. If all open network ports lead
>> to AppArmor profiles, then there is no way for the network attacker to
>> attack the machine, except as controlled by AppArmor policy. As a
>> convenience, AppArmor includes a netstat wrapper that reports all
>> programs with open network ports and their AppArmor profile status.
>>     
> Except that your internal unconfined programs/processes may nonetheless
> be subverted via the confined program, because:
> a) you aren't controlling all objects and operations, and
> b) you aren't controlling those internal programs/processes at all, so
> they are at risk of taking untrustworthy inputs from the "confined"
> ones, and
>   
That you could subvert a non-confined program from a confined program is
conjecture; you have to suppose that the non-confined program will
*listen* to assorted noise coming from the confined program. Certainly
you can build a covert channel that can leak data from a confined
process to a non-confined process, but only if the non-confined process
is listening. We mediate things like ptrace that would allow the
confined process to force the non-confined process to "listen".

And if you are concerned about a particular program being so sensitive
to its environment that it could be subverted, then confine it too.

Security is always a balance between convenience and, well, security :)
You can make an AppArmor system more secure and less convenient by
confining more programs and using more specific pathnames in the
profiles. Conversely, you can make it more convenient and less secure by
confining fewer programs and using path names with more wildcards.
Making the scalable decision between security and convenience available
to the user is an important feature of AppArmor.

> c) there is a high likelihood of interactions between those
> processes/programs in any real system, particularly in shared
> directories where paths aren't very useful as a distinguisher.
>   
How so? We find them to be a very useful distinguisher. Lots and lots of
people find them to be a very useful distinguisher. In fact, when
configuring AppArmor policy, our users have been surprised at what
exactly their (often in-house, usually proprietary) applications access
-- and have been grateful for a tool that can make these distinctions.

>>    2. AppArmor needs to re-construct the full path name of files to
>>       perform initial validation. Some of the LSM hooks that we mediate
>>       do not have vfsmount/nameidata passed. Our temporary workaround is
>>       to export the namespace_sem semaphore so we can safely walk the
>>       process's namespace to find a vfsmount with a root dentry matching
>>       the dentry we are trying to mediate. We believe a cleaner solution
>>       (such as passing a vfsmount or nameidata to all LSM hooks throughout
>>       the VFS layer) would be useful for audit, other LSMs, and
>>       potentially FUSE. As it is a fair amount of work to pass vfsmount or
>>       nameidata structures throughout the VFS, alternative suggestions
>>       and ideas are welcomed.
>>     
>
> Introduce new hooks at the proper location where the information is available.
>   
The usual response to a request for a new hook is "where is the user?"
We want AppArmor to be in-tree as a first-class user of LSM, and then we
can discuss new hooks, perhaps as an alternative to properly supplying
vfsmount or nameidata to all of the existing hooks, which ever is more
elegant and convenient to the kernel maintainers.

Crispin
-- 
Crispin Cowan, Ph.D.                      http://crispincowan.com/~crispin/
Director of Software Engineering, Novell  http://novell.com

