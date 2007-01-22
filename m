Return-Path: <linux-kernel-owner+w=401wt.eu-S1750771AbXAVMfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbXAVMfy (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 07:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbXAVMfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 07:35:54 -0500
Received: from puma.cosy.sbg.ac.at ([141.201.2.23]:36465 "EHLO
	puma.cosy.sbg.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbXAVMfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 07:35:53 -0500
Message-ID: <45B4AF98.2080407@cosy.sbg.ac.at>
Date: Mon, 22 Jan 2007 13:35:36 +0100
From: Michael Noisternig <mnoist@cosy.sbg.ac.at>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Joel Becker <Joel.Becker@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: configfs: return value for drop_item()/make_item()?
References: <45AF6D0C.8020600@cosy.sbg.ac.at> <20070118221249.GO27360@ca-server1.us.oracle.com>
In-Reply-To: <20070118221249.GO27360@ca-server1.us.oracle.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply again! See comments inline...

Joel Becker wrote:
>> I fully agree with the idea of configfs not being allowed to destroy
>> user-created objects. OTOH, while configfs is described as a filesystem
>> for user-created objects under user control, compared to sysfs as a
>> filesystem for kernel-created objects under kernel control, configfs
>> _does_ permit kernel-created objects in a limited way (by filling in
>> struct config_group->default_groups), and these objects can only be
>> destroyed again by the kernel, and not by the user.
> 
> 	They are not created by a kernel action.  They are created as a
> direct result of a user action.  The user must mkdir(2) the parent in
> the chain.  Only then do these default_groups appear.  Contrast sysfs,
> where filesystem structures can be added at any time, from any codepath,
> via the sysfs in-kernel API.

Sure, but what I meant to say was that the user, when creating a 
directory, did not request creation of such sub-directories, so I see 
them as created by the kernel.

If you argue that they are in fact created by the user because they are 
a direct result of a user action, then I can apply the same argument to 
this one example:

>> For another example, and directly related to above link, suppose
>> having an object with a number of attributes, one of them being
>> called 'type'. Dependent on the value of 'type' this object may
>> contain a particular type of sub-object (with type-dependent
>> attributes). E.g. 'type' may be empty | 'a' | 'b' | 'ab', then
>> dependent on this there should be 0 or 1 directories called 'a',
>> and 0 or 1 directories called 'b'. Doing it this way means that
>> while the user decides what sub-directory/-ies the object has, he
>> does not create them (directly) - it is the kernel which creates 
>> the object, and as such it is also the kernel only which is
>> permitted to destroy the object again - by the user writing a
>> different value to the 'type' attribute (or clearing it). sysconfs
>> could solve this.
> 
> This is precisely what configfs is designed to forbid. The kernel
> does not, ever, create configfs objects on its own. It does it as a
> result of userspace action.

No. The sub-directory only appears as a direct result of the user 
writing a value into the 'type' attribute. ;-)

> If you want the following:
> 
> # cd mydir
> # ls -l
> -rw-r--r-- 1 root root 0 2006-12-28 07:11 type
> # echo 'ab' > type
> # ls -l mydir
> drwxr-xr-x 2 root root 4096 2007-01-08 14:21 ab
> -rw-r--r-- 1 root root 2 2007-01-08 14:21 type
> # echo '' > type
> # ls -l mydir
> -rw-r--r-- 1 root root 0 2007-01-08 14:22 type
> 
> you're never going to get it from configfs. You should be using
> sysfs.

Hardly. sysfs doesn't allow the user creating directories. :>

>> As such I don't understand fully why one doesn't want to merge sysfs and
>> configfs (let's call it sysconfs for now) in such a way that it allows
>> _both_ user- and kernel-created objects, with user-objects only allowed
>> to be destroyed by the user and kernel-objects only by the kernel.
> 
> 	The programming interface is very, very different.  Check out
> historical messages on this topic:
> 
> http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg95708.html
> http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg95711.html
> http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg95714.html
> http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg95717.html

Well, you could still use type (user object/kernel object) dependent 
structure pointers?

>> Often however, what you want is that an object may contain 0 or 1 other
>> objects. If ->make_item()/make_group() would allow returning a
>> meaningful error code the kernel could deny creation of a 2nd object
>> other than by pretending to be out of memory.
> 
> 	You make a reasonable case that ENOMEM isn't always the error
> you want, but perhaps we can add a better umbrella error code?  I'm wary
> of introducing PTR_ERR() or any other complexity if we don't _need_ it.
> I'm all for thoughts on possibly compromises.

>> I was thinking about
>> ssize_t make_item(struct config_group *group, const char *name, struct
>> config_item **new_item)
>> with return value 0 meaning no-error.
> 
> 	Sure, it's another way to go, but it's effectively the same
> thing.

Well, you don't need PTR_ERR().

>> I was thinking about having symlinks in a directory and deriving the
>> order by the symlinks' filenames, too. I dismissed it originally for two
>> reasons. First, I didn't see how to keep the order when some link gets
>> deleted, e.g. there's 1,2,3 and then link 2 gets deleted. Now, thinking
>> about it again, I can simply keep a ordered linked list internally, and
>> therefrom remove the node for link 2. But it's still not perfect,
>> because how do I insert a link between filenames 1 and 2? Ok, I have to
>> delete all symlinks first and then rebuild them, and in the end it's
>> like rewriting a params_list attribute file... except that it's not
>> atomic. Second, a simple params_list file seems a lot more easy to
>> handle from the user perspective... simply open the file with an editor,
>> add or delete an entry, save it, close it. I don't know which method is
>> better, the one described here with a params/ subdirectory containing
>> symlinks with their order derived from their filenames, or method 2)
>> from below with simply having a params_list file where params entries
>> get renamed to <params removed> but are still valid until the user
>> rewrites the params_list file.
> 
> 	Why not both?  You need the reference, and the reference must
> come from a userspace action.  While a set of ordered names would be
> easy for some folks, maybe it isn't for you.  So, the userspace process
> first symlinks all dependant parameters, thus taking a reference.  Then,
> they write to params/order to order them.  If they remove a symlink, you
> just delete the dentry from params/order.
> 
>     # cd object/params
>     # ls -l
>     -rw-r--r-- 1 root root    0 2007-01-08 14:22 order
>     # ln -s ../../params/param1 .
>     # ln -s ../../params/param2 .
>     # ls -l
>     -rw-r--r-- 1 root root    0 2007-01-08 14:22 order
>     lrwxrwxrwx 1 root root   19 2007-01-08 15:30 param1 -> ../../params/param1
>     lrwxrwxrwx 1 root root   19 2007-01-08 15:30 param2 -> ../../params/param2
>     # cat order
>     # cat >order
>     param2
>     param1
>     ^D
>     # cat order
>     param2
>     param1
>     # rm param2
>     # ls -l
>     -rw-r--r-- 1 root root    0 2007-01-08 14:31 order
>     lrwxrwxrwx 1 root root   19 2007-01-08 15:30 param1 -> ../../params/param1
>     # cat order
>     param1
> 
> 	Note that you don't need a "<param2 deleted>" placeholder in
> 'order'.  Userspace explicitly removed the symlink, they should know
> what they did.

That's an interesting other solution, however it seems a bit redundant 
(params are referenced by links as well as in the 'order' attribute 
file) and not as simple as my method 2). I guess, for now, in lack of a 
convincing solution, I will implement method 2) as the one easiest to 
adapt to given my current code base.

> 	Well, I hope I've come up with a few ways of doing this that
> perhaps you'll either like or find inspiring.  One thing to remember is
> that, while I'm using shell commands to show the configfs operations, in
> reality there'd be a wrapper program for your user.  You want the actual
> user to be given a tool that speaks what they *want* to do, not how it
> actually gets done.

Hm, I had envisioned the user to fully configure the module via file 
system operations only. Now if the user is supposed to use a wrapper 
program this sheds a different light on all those 
what's-the-best-solution issues...

> Joel

Thanks, Michael

