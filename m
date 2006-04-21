Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWDUNbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWDUNbO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 09:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWDUNbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 09:31:14 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:36261 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S932157AbWDUNbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 09:31:12 -0400
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Crispin Cowan <crispin@novell.com>
Cc: James Morris <jmorris@namei.org>, Tony Jones <tonyj@suse.de>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <4447E7AC.8000204@novell.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <1145535423.3313.15.camel@moss-spartans.epoch.ncsc.mil>
	 <4447E7AC.8000204@novell.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 21 Apr 2006 09:34:31 -0400
Message-Id: <1145626471.21749.108.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 12:57 -0700, Crispin Cowan wrote:
> Perhaps in some implementation, but not in AppArmor:
> 
>     * AppArmor access controls are bound to processes, not files. The
>       control is to contain the subject, not shield the object.
>     * AppArmor uses a white list, not a black list. "By another means"
>       assumes that you have another means, and with the white list of
>       accessible file names, you generally don't.
> 
> Please show a case where AppArmor is not doing what it claims to do, or
> stop spreading the FUD.

I'm not the one spreading FUD.

If you read one of AppArmor's whitelist profiles and conclude that
because /etc/shadow is not listed in it, your shadow password data is
protected against reading via a compromise of that program, then you
might find yourself unpleasantly surprised.  You can't tell that from
any AppArmor profile; you only know that if said process tries to open
the path "/etc/shadow", it should be denied access.  You don't know
whether any other path in that same profile might ever refer to that
same file, or whether the shadow data might be exposed to said process
via a non-file object (e.g. shared memory) being used by programs
legitimately accessing the shadow data, or whether said process might be
able to compromise another process on the same system via an
uncontrolled mechanism and gain access in that manner.

End users aren't going to recognize this limitation unless you spell it
out in your end user documentation.  They will believe that their shadow
password data is now safe, because they've read the very simple profile
for their program and it doesn't include "/etc/shadow" anywhere.  They
will be disappointed when they find that their shadow password data has
leaked.  And please don't assume that this only applies to
confidentiality/secrecy concerns; the same reasoning applies to
protecting the integrity of their systems.

> Consider Lampson's classic access control matrix, where you have all
> your subjects (processes doing the operations) across one edge, and all
> your objects (files and processes being operated on) along the other
> edge, and the matrix cells contain permitted operations. Lampson's
> matrix is the maximally expressive form of access control, but it is so
> large as to be unmanageable. All access control schemes are abstractions
> on this space to simplify it to make it manageable.
> 
> AppArmor is a particular abstraction on this space, where we profile
> each row (process) by what application it runs, and then list the
> columns (files) it can access, and in what mode.

There is an assumption in the access matrix that the subjects and
objects are accurately and unambiguously identified.  That is achieved
when the subjects and objects are labeled by the kernel and the labels
are used for the access control, or when unique identifiers are used for
the subject and object and used for the access control.  It is not
achieved via pathnames.  Therein lies the problem.  

> > So you have an unbounded number of policies that can govern access to
> > any given file object and the enforcement of the system policy is
> > entirely dependent on the file tree structure and any process that can
> > manipulate that structure.
> No; to the contrary, the above policy means the same thing on every file
> system: if any file matching /srv/htdocs/** exists, then the contained
> process can access it.

That seems to miss my point, which was that a single file object (i.e.
inode) may be accessible under multiple paths, and thus a single process
that accesses it may get different permissions depending on which path
it used, yielding multiple policies for the same object.  And
rearrangement of the file tree alters the effective policy that is
applied to a given file object, as it is path-based rather than
object-based.

> On the other hand, SELinux policy describes whether or not one label can
> access another, and the meaning of that policy is dependent on the
> existence and state of the labels in the file system.

No, the meaning of the policy is not dependent on the filesystem state;
you can analyze the policy separate from the filesystem state and know
definitively whether or not e.g. high integrity data can ever be
corrupted by a low integrity source, or whether secret data can ever be
leaked to an insecure sink.  The policy is in terms of abstractions /
security equivalence classes, because you are trying to enforce higher
level security goals re confidentiality and integrity, not just whether
program X can read file F.

>  Tar and restore
> your directory tree and the SELinux policy meaning changes. Labels on
> the filesystem can change over time; so that running:
>   find / -exec ls -Z {} \; | grep httpd_user_content_t
> 
> will only show a snapshot of what would be allowed *right now*. So if
> anything, SELinux is more sensitive to file system state than AppArmor,
> and in any meaningful sense has many more possible policies enforced on
> the system.

No, the meaning of the policy doesn't change.  The precise set of
objects that fall within a given security equivalence class can change
subject to the control of the policy (so even such changes fall within
the scope of an analysis of the policy, and do not alter the information
flow analysis).  Now, if your concern is with file relabeling, I'd agree
that isn't desirable.  The goal is to ensure that data is labeled
correctly when it is created, and preserved throughout its lifetime.
File relabeling is usually an indication of a defect in policy or
userspace, and should be gradually eradicated from the normal runtime
operation of the system.

> 
> >   Further, what about runtime files generated
> > in shared directories like /tmp, /var/run, ...
> What about them? If your program needs access to /tmp and /var, then
> your policy should grant it. The above is a single line out of a
> profile. The Apache profile is about 150 lines.

Runtime files often don't have well-defined names, e.g. randomly
generated components, pids, arbitrary choices of users, etc.  So
path-based configuration runs into problems, whereas labeled objects
reflect the security properties of their creators and thus already are
protected properly.

> AppArmor is sufficiently expressive that you can give permission to
> create /tmp/foo but *not* /tmp/bar. In SELinux, applications can create
> /tmp files and give them labels different than the default label, but
> AFAIK, SELinux can only either grant or deny permission to create a file
> in a given directory, and not which file you can create.

In SELinux, newly created files are labeled in accordance with policy
and reflect the security properties of their creators.
Thus, /tmp/xyGp98x if created by sendmail would have a different
security label than the same path if created by named, and policy can
ensure that only the appropriate process can access that file.

> You might care about this because the semantics of /etc/hosts.allow are
> rather different than /etc/mumblebarf.

Yes, but this can be addressed either by providing distinct tools for
manipulation of objects that require distinct protection (and
configuring policy to label the objects created by those tools
accordingly), or by just instrumenting your basic editing tools to
preserve security attributes in the same way they already preserve file
modes or ACLs (a fair amount of which has been done for SELinux in at
least some distros, albeit not complete).  More work?  Sure.  But the
right technical approach.  

> >   And let's please
> > separate user interface from kernel mechanism.  If you want to specify
> > pathnames for fixed resources in a user-level config file, that is fine,
> > but pathnames have historically been rejected as a suitable basis for
> > the kernel for a reason, not just in the security space.  Why should
> > this change?  Isn't this a fundamental design change to Linux?  
> >   
> Because pathname matching in the kernel is fundamentally what makes
> AppArmor easy to use. It is also what prevents AppArmor from being
> implemented on top of SELinux.

But it is also fundamentally contrary to the Unix (and more so Linux)
model, IMHO.  Naturally, not my call to make, but it seems problematic,
as this kind of approach has been rejected before.

> 
> >   Bypass is certainly possible.
> >   
> An interesting claim. We disagree, other than possibly coding errors.
> Can you provide an actual example of bypass?

I'm not talking about implementation bugs in AppArmor; I mean the
incomplete mediation and inaccurate basis of security decisions in
AppArmor.  Examples given already include the subversion of the system
via an uncontrolled mechanism like local IPC or being able to access the
same data under another path.  That is a bypass of the intended
protection (or at least the protection that would be expected by your
users, barring a big fat disclaimer on your product literature).

> > So the attacker knows precisely how to bypass it.  The attacker (beyond
> > the script kiddies) isn't going to attack you at the point of strength;
> > he will attack you where you are known to be weak.
> >   
> If you properly configured your system to confine all exposed programs,
> then the attacker *must* start from a confined program, so this is a
> non-issue.

But that doesn't help when you don't control all operations (hence
bypass via uncontrolled mechanisms) and when your basis of control is
ambiguous.

> Please keep in mind that our security goals are different from what
> you've considered in the past; a system administrator will confine
> programs that he or she considers are a higher than tolerable risk. We
> provide an easy and reliable mechanism to confine software that poses
> unreasonable risk. We do not try to provide provable information flow
> properties.

If you can't control information flow, then you can't provide any real
confidentiality or integrity guarantees.  If I wanted a reliable
mechanism with minimal impact on userspace and didn't want to use
SELinux for some reason, I'd use a virtualization technique, not
AppArmor.

> That you could subvert a non-confined program from a confined program is
> conjecture; you have to suppose that the non-confined program will
> *listen* to assorted noise coming from the confined program.

That isn't unlikely.  As just one trivial example, malicious symlink
attacks are all about tricking a more privileged program into relying on
untrustworthy inputs.

> And if you are concerned about a particular program being so sensitive
> to its environment that it could be subverted, then confine it too.

AppArmor doesn't seem to generalize too well to full system protection.

> Security is always a balance between convenience and, well, security :)
> You can make an AppArmor system more secure and less convenient by
> confining more programs and using more specific pathnames in the
> profiles. Conversely, you can make it more convenient and less secure by
> confining fewer programs and using path names with more wildcards.
> Making the scalable decision between security and convenience available
> to the user is an important feature of AppArmor.

But you are limited in your achievable security by the mechanism in
AppArmor (again, incomplete mediation and inaccurate basis for security
decisions).  SELinux provides genuine scalability here, from a minimal
targeted policy through a highly strict one, all with the same
mechanism.

> > c) there is a high likelihood of interactions between those
> > processes/programs in any real system, particularly in shared
> > directories where paths aren't very useful as a distinguisher.
> >   
> How so? We find them to be a very useful distinguisher. Lots and lots of
> people find them to be a very useful distinguisher. In fact, when
> configuring AppArmor policy, our users have been surprised at what
> exactly their (often in-house, usually proprietary) applications access
> -- and have been grateful for a tool that can make these distinctions.

For fixed resources, paths are ok (in userspace config files, not kernel
mechanism).  But for runtime files created in shared directories, the
name is often dynamically generated or arbitrarily selected, and doesn't
tell us anything about the real security properties.

> The usual response to a request for a new hook is "where is the user?"
> We want AppArmor to be in-tree as a first-class user of LSM, and then we
> can discuss new hooks, perhaps as an alternative to properly supplying
> vfsmount or nameidata to all of the existing hooks, which ever is more
> elegant and convenient to the kernel maintainers.

Usually you have to fix your implementation before you can get it
in-tree.  We had to do that for SELinux, e.g. migrating from our own
file labeling implementation to using xattrs.  I would argue that your
current implementation is a misuse of the current LSM interfaces.  Not
my call to make, of course, but if that is the prevailing opinion, you
should have to rework your implementation first, and get the necessary
dependencies in place.  All of which presumes that a path-based
mechanism is acceptable at all (again, not my call to make).
 
-- 
Stephen Smalley
National Security Agency

