Return-Path: <linux-kernel-owner+w=401wt.eu-S932612AbXARWTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbXARWTQ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 17:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbXARWTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 17:19:16 -0500
Received: from rgminet02.oracle.com ([148.87.113.119]:26612 "EHLO
	rgminet02.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932612AbXARWTP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 17:19:15 -0500
Date: Thu, 18 Jan 2007 14:12:49 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Michael Noisternig <mnoist@cosy.sbg.ac.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: configfs: return value for drop_item()/make_item()?
Message-ID: <20070118221249.GO27360@ca-server1.us.oracle.com>
Mail-Followup-To: Michael Noisternig <mnoist@cosy.sbg.ac.at>,
	linux-kernel@vger.kernel.org
References: <45AF6D0C.8020600@cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45AF6D0C.8020600@cosy.sbg.ac.at>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 01:50:20PM +0100, Michael Noisternig wrote:
> did you get my last reply? I hope you still consider it to be worthwhile
> to comment on. :)

	I didn't get it, I'm sorry.  I wonder what happened.  Did you
send it to me, linux-kernel, or both (both is preferred).

> And sorry for your double-reception of my last mail, I was unwittingly
> ignoring your follow-up-to setting.

	I filter dupes by Message-ID :-)

> -------- Original Message --------
> Subject: Re: configfs: return value for drop_item()/make_item()?
> From: Michael Noisternig
> Date: Tue Jan 16 2007 - 11:40:50 EST
> 
> I fully agree with the idea of configfs not being allowed to destroy
> user-created objects. OTOH, while configfs is described as a filesystem
> for user-created objects under user control, compared to sysfs as a
> filesystem for kernel-created objects under kernel control, configfs
> _does_ permit kernel-created objects in a limited way (by filling in
> struct config_group->default_groups), and these objects can only be
> destroyed again by the kernel, and not by the user.

	They are not created by a kernel action.  They are created as a
direct result of a user action.  The user must mkdir(2) the parent in
the chain.  Only then do these default_groups appear.  Contrast sysfs,
where filesystem structures can be added at any time, from any codepath,
via the sysfs in-kernel API.

> As such I don't understand fully why one doesn't want to merge sysfs and
> configfs (let's call it sysconfs for now) in such a way that it allows
> _both_ user- and kernel-created objects, with user-objects only allowed
> to be destroyed by the user and kernel-objects only by the kernel.

	The programming interface is very, very different.  Check out
historical messages on this topic:

http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg95708.html
http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg95711.html
http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg95714.html
http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg95717.html

	In addition, userspace would have no idea at any given time
whether they were dealing with kernel managed objects or user managed
ones.  So you'd confuse both the driver programmer *and* the userspace
programmer.

> One problem with configfs is that there is too little control over how
> many other objects a particular object may contain. IOW, an object may
> either contain
> - n sub-objects (n entries in ->default_groups), or
> - n..inf sub-objects (n entries in ->default_groups,
> ->make_item()/make_group() supplied)

	Clearly you can have 0..N sub-objects by returning NULL from
successive ->make_item() calls, but as you point out, that results in
ENOMEM, not the cleanest error for this case.

> Often however, what you want is that an object may contain 0 or 1 other
> objects. If ->make_item()/make_group() would allow returning a
> meaningful error code the kernel could deny creation of a 2nd object
> other than by pretending to be out of memory.

	You make a reasonable case that ENOMEM isn't always the error
you want, but perhaps we can add a better umbrella error code?  I'm wary
of introducing PTR_ERR() or any other complexity if we don't _need_ it.
I'm all for thoughts on possibly compromises.

> For another example, and directly related to above link, suppose having
> an object with a number of attributes, one of them being called 'type'.
> Dependent on the value of 'type' this object may contain a particular
> type of sub-object (with type-dependent attributes). E.g. 'type' may be
> empty | 'a' | 'b' | 'ab', then dependent on this there should be 0 or 1
> directories called 'a', and 0 or 1 directories called 'b'. Doing it this
> way means that while the user decides what sub-directory/-ies the object
> has, he does not create them (directly) - it is the kernel which creates
> the object, and as such it is also the kernel only which is permitted to
> destroy the object again - by the user writing a different value to the
> 'type' attribute (or clearing it). sysconfs could solve this.

	This is precisely what configfs is designed to forbid.  The
kernel does not, ever, create configfs objects on its own.  It does it
as a result of userspace action.  If you want the following:

    # cd mydir
    # ls -l
    -rw-r--r-- 1 root root    0 2006-12-28 07:11 type
    # echo 'ab' > type
    # ls -l mydir
    drwxr-xr-x 2 root root 4096 2007-01-08 14:21 ab
    -rw-r--r-- 1 root root    2 2007-01-08 14:21 type
    # echo '' > type
    # ls -l mydir
    -rw-r--r-- 1 root root    0 2007-01-08 14:22 type

you're never going to get it from configfs.  You should be using sysfs.

> Above problem could be solved in a different manner within the realms of
> configfs by not having a 'type' attribute, but the other way around
> defining the (implicit) type of the object by the user creating certain
> sub-directories ('a' and 'b'). I.e. if the user creates directory 'a'
> the object is of type a, if the user also creates 'b' then the object is
> of type ab. However, the user should not be permitted to create other
> objects than 'a' and 'b' - thus ->make_item()/make_group() should permit
> returning a meaningful error code.

	Or just returning an error, with the userspace program that
actually does the work interpretting it correctly.  Remember, while it
is convenient to be able to poke at configfs via the shell, real users
are going to be using a wrapper program (eg, OCFS2 users don't manually
add node information via mkdir(1) and echo(1), they use o2cb_ctl, which
does it for them via mkdir(2) and write(2)).
	Really, if you wanted to do this via configfs, you'd do
something like this:

    # cd /sys/kernel/config
    # ls -l
    # modprobe mymodule
    # ls -l
    drwxr-xr-x 2 root root 4096 2007-01-08 14:21 mymodule
    # cd mymodule
    # ls -l
    drwxr-xr-x 2 root root 4096 2007-01-08 14:21 a
    drwxr-xr-x 2 root root 4096 2007-01-08 14:21 b
    drwxr-xr-x 2 root root 4096 2007-01-08 14:21 ab
    # mkdir a/object
    # ls -l a
    drwxr-xr-x 2 root root 4096 2007-01-08 14:22 object
    # mkdir b/object
    mkdir: cannot create directory `b/object`: Out of memory

	So your types are explicit in the fact that you have
default_groups for type 'a', 'b', and 'ab'.  You create an object of
type 'a' via 'mkdir /sys/kernel/config/mymodule/a/object', and then you
can't create objects under 'b' or 'ab'.  When you 'rmdir a/object', now
you can make 'b/object'.
	You will notice, of course, the "Out of memory" error, because
it's only ENOMEM right now.  Here, we could come up with a better
umbrella error code, or the real wrapper program could say "I know this
means an object already exists".

> I was thinking about
> ssize_t make_item(struct config_group *group, const char *name, struct
> config_item **new_item)
> with return value 0 meaning no-error.

	Sure, it's another way to go, but it's effectively the same
thing.

> Well, I understand and agree to the philosophy... but I still don't know
> how to solve my problem elegantly... more below...

	Different problems (I'm sure you know that).  That's why I'm
taking the time to respond, though, I'd like to help you solve the
problem.

> It must be ordered because it's a priority list.

	Just curious, I can certainly see a use.

> I was thinking about having symlinks in a directory and deriving the
> order by the symlinks' filenames, too. I dismissed it originally for two
> reasons. First, I didn't see how to keep the order when some link gets
> deleted, e.g. there's 1,2,3 and then link 2 gets deleted. Now, thinking
> about it again, I can simply keep a ordered linked list internally, and
> therefrom remove the node for link 2. But it's still not perfect,
> because how do I insert a link between filenames 1 and 2? Ok, I have to
> delete all symlinks first and then rebuild them, and in the end it's
> like rewriting a params_list attribute file... except that it's not
> atomic. Second, a simple params_list file seems a lot more easy to
> handle from the user perspective... simply open the file with an editor,
> add or delete an entry, save it, close it. I don't know which method is
> better, the one described here with a params/ subdirectory containing
> symlinks with their order derived from their filenames, or method 2)
> from below with simply having a params_list file where params entries
> get renamed to <params removed> but are still valid until the user
> rewrites the params_list file.

	Why not both?  You need the reference, and the reference must
come from a userspace action.  While a set of ordered names would be
easy for some folks, maybe it isn't for you.  So, the userspace process
first symlinks all dependant parameters, thus taking a reference.  Then,
they write to params/order to order them.  If they remove a symlink, you
just delete the dentry from params/order.

    # cd object/params
    # ls -l
    -rw-r--r-- 1 root root    0 2007-01-08 14:22 order
    # ln -s ../../params/param1 .
    # ln -s ../../params/param2 .
    # ls -l
    -rw-r--r-- 1 root root    0 2007-01-08 14:22 order
    lrwxrwxrwx 1 root root   19 2007-01-08 15:30 param1 -> ../../params/param1
    lrwxrwxrwx 1 root root   19 2007-01-08 15:30 param2 -> ../../params/param2
    # cat order
    # cat >order
    param2
    param1
    ^D
    # cat order
    param2
    param1
    # rm param2
    # ls -l
    -rw-r--r-- 1 root root    0 2007-01-08 14:31 order
    lrwxrwxrwx 1 root root   19 2007-01-08 15:30 param1 -> ../../params/param1
    # cat order
    param1

	Note that you don't need a "<param2 deleted>" placeholder in
'order'.  Userspace explicitly removed the symlink, they should know
what they did.

> configfs should be a perfect fit for my purposes, as it's the user (and
> the user only) who creates and destroys the objects. The problem lies
> elsewhere. :/

	Well, I hope I've come up with a few ways of doing this that
perhaps you'll either like or find inspiring.  One thing to remember is
that, while I'm using shell commands to show the configfs operations, in
reality there'd be a wrapper program for your user.  You want the actual
user to be given a tool that speaks what they *want* to do, not how it
actually gets done.

> I'll give an example once more:
> I have a directory called 'statistics' in my module's main dir in the
> configfs tree. This directory will contain several attributes for
> statistical purposes. Normally you would place this object into sysfs
> because it's an object created by the kernel (->default_groups).
> However, I certainly don't want to rip apart the statistics dir from the
> rest of the module parameters. What this shows in my eyes is that (1)
> configfs _does_ create kernel objects, and (2) sysconfs might make sense.

	As I stated above, configfs does not allow objects to be created
in response to kernel actions.  Sure, configfs does the actual work of
filling out default_groups, and default_attrs, and even the object you
just called mkdir(2) on.  But it's all in response to a userspace
action.  That's what I mean by "user created".
	Something to remember is taht there is nothing wrong with
putting some pieces in configfs and some pieces in sysfs.  Really.  You
should be mostly hiding this from the user anyway.  configfs and sysfs
are userspace<->kernelspace interfaces.  They provide some nice
properties for the developer of kernel drivers needing a userspace
interface and the developer of a userspace program communicating with
kernelspace.  But if you want a real user, "Joe Hacker" as it work, to
see these things, you don't want them caring whether it's in configfs,
sysfs, procfs, ioctl(2), or mmap(2).  You want them using a tool.
	You and I are hackers.  We know that the kernel exposes our
laptop's batter info in /proc/acpi/battery/BAT0/state.  So we can do
'cat /proc/acpi/battery/BAT0/state' if we like.  But we're the
exception.  Almost everyone is going to do "acpitool -b".
	If you have your configuration in configfs and your statistics
in sysfs, it provides you a nice set of programming interfaces.  The
fact that your tool checks two places is irrelevant to your users.  They
just know to call 'michaelstool --stats' to get statistics, and
'michaelstool --config' to configure the driver.

Joel

-- 

 print STDOUT q
 Just another Perl hacker,
 unless $spring
	- Larry Wall

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
