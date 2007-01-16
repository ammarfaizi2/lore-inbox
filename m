Return-Path: <linux-kernel-owner+w=401wt.eu-S1751303AbXAPQkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbXAPQkX (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 11:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbXAPQkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 11:40:22 -0500
Received: from puma.cosy.sbg.ac.at ([141.201.2.23]:52667 "EHLO
	puma.cosy.sbg.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbXAPQkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:40:21 -0500
Message-ID: <45AD0062.9030603@cosy.sbg.ac.at>
Date: Tue, 16 Jan 2007 17:42:10 +0100
From: Michael Noisternig <mnoist@cosy.sbg.ac.at>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: Joel Becker <Joel.Becker@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: configfs: return value for drop_item()/make_item()?
References: <45AB5D98.5000205@cosy.sbg.ac.at> <20070116083023.GE27360@ca-server1.us.oracle.com>
In-Reply-To: <20070116083023.GE27360@ca-server1.us.oracle.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I'm sorry if I missed your previous post.  I've never ignored a
> configfs post on purpose :-)

Well, thanks a lot for the reply! :)

>> Here's the issue... the configfs system can prevent a user from 
>> _creating_ sub-directories in a certain directory (by not supplying 
>> struct configfs_group_operations->make_item()/make_group()) but it 
>> cannot prevent him from _removing_ sub-directories because struct 
>> configfs_group_operations->drop_item() is void.
> 
> 	This is intentional.  The entire point of configfs is to have
> the lifetime controlled from userspace.  If the kernel can pin things
> however it likes, we lose that property.

I fully agree with the idea of configfs not being allowed to destroy 
user-created objects. OTOH, while configfs is described as a filesystem 
for user-created objects under user control, compared to sysfs as a 
filesystem for kernel-created objects under kernel control, configfs 
_does_ permit kernel-created objects in a limited way (by filling in 
struct config_group->default_groups), and these objects can only be 
destroyed again by the kernel, and not by the user.

As such I don't understand fully why one doesn't want to merge sysfs and 
configfs (let's call it sysconfs for now) in such a way that it allows 
_both_ user- and kernel-created objects, with user-objects only allowed 
to be destroyed by the user and kernel-objects only by the kernel.

I'll explain more shortly, and also the connection with...

>> Similarly, struct configfs_group_operations->make_item() does not permit 
>> to return an error code, and as such it is impossible to 'check' the 
>> type of sub-directory a user wants to create (with returning a 
>> meaningful error code). This had already, unsuccessfully, been brought 
>> up before on 2006-08-29 by J. Berg (see 
>> http://marc.theaimsgroup.com/?l=linux-kernel&m=115692319227688&w=2).

One problem with configfs is that there is too little control over how 
many other objects a particular object may contain. IOW, an object may 
either contain
   - n sub-objects (n entries in ->default_groups), or
   - n..inf sub-objects (n entries in ->default_groups, 
->make_item()/make_group() supplied)

Often however, what you want is that an object may contain 0 or 1 other 
objects. If ->make_item()/make_group() would allow returning a 
meaningful error code the kernel could deny creation of a 2nd object 
other than by pretending to be out of memory.

For another example, and directly related to above link, suppose having 
an object with a number of attributes, one of them being called 'type'. 
Dependent on the value of 'type' this object may contain a particular 
type of sub-object (with type-dependent attributes). E.g. 'type' may be 
empty | 'a' | 'b' | 'ab', then dependent on this there should be 0 or 1 
directories called 'a', and 0 or 1 directories called 'b'. Doing it this 
way means that while the user decides what sub-directory/-ies the object 
has, he does not create them (directly) - it is the kernel which creates 
the object, and as such it is also the kernel only which is permitted to 
destroy the object again - by the user writing a different value to the 
'type' attribute (or clearing it). sysconfs could solve this.

Above problem could be solved in a different manner within the realms of 
configfs by not having a 'type' attribute, but the other way around 
defining the (implicit) type of the object by the user creating certain 
sub-directories ('a' and 'b'). I.e. if the user creates directory 'a' 
the object is of type a, if the user also creates 'b' then the object is 
of type ab. However, the user should not be permitted to create other 
objects than 'a' and 'b' - thus ->make_item()/make_group() should permit 
returning a meaningful error code.

> 	I don't quite see how this link relates, but perhaps I'm not
> understanding your entire question.  Currently, ->make_item() doesn't
> allow an error code because that would involve the ERR_PTR() construct.
> While that construct is quite useful, I'm always wary of adding
> complexity.  Thus, the tradeoff would have to be worth it.

I was thinking about
   ssize_t make_item(struct config_group *group, const char *name, 
struct config_item **new_item)
with return value 0 meaning no-error.

>> Please give some arguments why you think 
>> configfs_group_operations->drop_item() should remain void.
> 
> 	Very simply, the lifetime must be in the control of userspace.
> That's precisely the point of configfs.  If you'd like the kernel to
> control the lifetime, I suspect sysfs will be more to your liking.
> configfs is not meant to replace sysfs, merely to coexist for things
> that benefit from the configfs model and not the sysfs model.
> 	(More on the model and your problem near the bottom)

Well, I understand and agree to the philosophy... but I still don't know 
how to solve my problem elegantly... more below...

> 
>> (1)
>> Say the user creates one object, let's say as objects/myobj1/. This 
>> object is dependent on some (shared) parameters which the user created 
>> under params/myparams1/. Now while myobj1/ is 'active', I don't want to 
>> let the user remove myparams1/. I can prevent this by making the user 
>> create a symlink(2) in the objects/myobj1/ directory to myparams1/, i.e. 
>> objects/myobj1/params/ -> ../../params/myparams1/, to denote its use. 
>> Now - if I have read the documentation correctly - the user cannot 
>> remove myparams1/ without removing the params/ link first. So fine, so good.
> 
> 	This will certainly work.
> 
>> (2)
>> Next the user may create several objects which may be dependent on 
>> several params objects. Now I can solve this by creating a default group 
>> for each object, i.e. on myobj1 creation there is objects/myobj1/params/ 
>> automatically. In that directory the user may create symlink(2)s to 
>> several params/*/ dirs. Fine again.
>>
>> (3)
>> Now what I want is the list of params an object uses to be an ordered 
>> list. I cannot do this because there is no intrinsic order in a 
>> filesystem. I can get the order by instead having an attribute called 
>> param_list which contains the ordered list of all params to use, e.g.
> 
> 	Why does it need to be ordered?  Also, why can't the symlinks
> have a naming convention of order?  Sure, someone hacking at it can
> break that, but your tool that really does the work can create
> objects/myobj1/params/param1 -> myparams2.  So the listing does have
> meaning.  Just one possibility.

It must be ordered because it's a priority list.

I was thinking about having symlinks in a directory and deriving the 
order by the symlinks' filenames, too. I dismissed it originally for two 
reasons. First, I didn't see how to keep the order when some link gets 
deleted, e.g. there's 1,2,3 and then link 2 gets deleted. Now, thinking 
about it again, I can simply keep a ordered linked list internally, and 
therefrom remove the node for link 2. But it's still not perfect, 
because how do I insert a link between filenames 1 and 2? Ok, I have to 
delete all symlinks first and then rebuild them, and in the end it's 
like rewriting a params_list attribute file... except that it's not 
atomic. Second, a simple params_list file seems a lot more easy to 
handle from the user perspective... simply open the file with an editor, 
add or delete an entry, save it, close it. I don't know which method is 
better, the one described here with a params/ subdirectory containing 
symlinks with their order derived from their filenames, or method 2) 
from below with simply having a params_list file where params entries 
get renamed to <params removed> but are still valid until the user 
rewrites the params_list file.

>> 2)
>> Keep a reference on each configfs object (e.g. params) in use, so when 
>> the user removes it from configfs it is still present in memory. This, 
>> however, requires to rename each according entry in every affected 
>> param_list to <params removed> or similar... not a very user-friendly 
>> way to deal with the situation.
> 
> 	There are two ways to reference the params.  One is to let the
> userspace program ask for the reference via symlink.  The other is in
> your driver.  This has the property you describe above, that you have
> to keep track of it after the user has asked for it to go away.

Yes, these are exactly the two possible methods I see and describe above.

> 	This property is on purpose.  When a user asks for something to
> go away, it needs to disappear from configfs before the rmdir(2)
> returns.  It's gone, and it is no longer accessible from userspace.  The
> lifetiming of userspace access is clear, cut, and dried.
> 	However, some objects need some time to die.  So the driver has
> its own reference, and it schedules any cleanup and death later.  But
> that death and cleanup should happen as soon as possible, because
> userspace has asked for it.

Yes, I agree with the methodology, it's exactly how a filesystem is 
expected to handle such situtation. OTOH, the behavior for configfs 
files referenced by symlinks is already different.

> 	Let's break for a minute.  Let me try to restate all of this.
> You have an interrelationship between a few configfs objects.  When a
> [referrer -> reference] relationship is put together, you need to prevent
> the reference from going away.  You've proposed a couple of methods that
> boil down to "when the reference object knows it is being referred to,
> it prevents itself from going away".
> 	Therein lies the rub.  configfs works by putting all of that in
> userspace.  Lifetime decisions can only occur in userspace.  This allows
> us a very clean lifetime from the userspace perspective.  It also means
> that if we want to lock an object down, it has to happen in userspace.
> 	So, the object cannot "prevent itself from going away".  The
> kernel side just can't do this.  Userspace, however, can.  You've
> discussed the most common way configfs allows userspace to do this, the
> symlink.  I believe your only problem was that of naming.  There's no
> reason you can't populate a param_list file at the same time you respond
> to ->allow_link().  Or, you could have userspace name the links in a
> manner providing ordering.  These solve this problem without breaking
> the configfs contract.

See above. I still don't know what would be an optimal solution.

> 	Think about your requirements again.  Do you absolutely require
> that some part of your kernel driver make a lifetime decision?  If so,
> configfs isn't going to fit.  Can the lifetime decision be moved to
> userspace?  If so, configfs should work just fine as-is, and you'll gain
> the clean lifetime and simple manipulation that configfs provides.  I
> hope it's the latter :-)

configfs should be a perfect fit for my purposes, as it's the user (and 
the user only) who creates and destroys the objects. The problem lies 
elsewhere. :/

OTOH, I don't see why configfs and sysfs cannot (should not) be merged 
as described above for sysconfs.

I'll give an example once more:
I have a directory called 'statistics' in my module's main dir in the 
configfs tree. This directory will contain several attributes for 
statistical purposes. Normally you would place this object into sysfs 
because it's an object created by the kernel (->default_groups). 
However, I certainly don't want to rip apart the statistics dir from the 
rest of the module parameters. What this shows in my eyes is that (1) 
configfs _does_ create kernel objects, and (2) sysconfs might make sense.

> Joel

Thanks again!
   Michael
