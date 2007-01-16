Return-Path: <linux-kernel-owner+w=401wt.eu-S932471AbXAPIgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbXAPIgv (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 03:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbXAPIgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 03:36:51 -0500
Received: from rgminet02.oracle.com ([148.87.113.119]:43941 "EHLO
	rgminet02.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932473AbXAPIgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 03:36:49 -0500
Date: Tue, 16 Jan 2007 00:30:23 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Michael Noisternig <mnoist@cosy.sbg.ac.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: configfs: return value for drop_item()/make_item()?
Message-ID: <20070116083023.GE27360@ca-server1.us.oracle.com>
Mail-Followup-To: Michael Noisternig <mnoist@cosy.sbg.ac.at>,
	linux-kernel@vger.kernel.org
References: <45AB5D98.5000205@cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45AB5D98.5000205@cosy.sbg.ac.at>
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

On Mon, Jan 15, 2007 at 11:55:20AM +0100, Michael Noisternig wrote:
> I've posted this before but without getting any replies. Please, 
> somebody either give a (short) reply to this or simply explain why they 
> think this is OT or not worth answering...

	I'm sorry if I missed your previous post.  I've never ignored a
configfs post on purpose :-)

> Here's the issue... the configfs system can prevent a user from 
> _creating_ sub-directories in a certain directory (by not supplying 
> struct configfs_group_operations->make_item()/make_group()) but it 
> cannot prevent him from _removing_ sub-directories because struct 
> configfs_group_operations->drop_item() is void.

	This is intentional.  The entire point of configfs is to have
the lifetime controlled from userspace.  If the kernel can pin things
however it likes, we lose that property.

> Similarly, struct configfs_group_operations->make_item() does not permit 
> to return an error code, and as such it is impossible to 'check' the 
> type of sub-directory a user wants to create (with returning a 
> meaningful error code). This had already, unsuccessfully, been brought 
> up before on 2006-08-29 by J. Berg (see 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=115692319227688&w=2).

	I don't quite see how this link relates, but perhaps I'm not
understanding your entire question.  Currently, ->make_item() doesn't
allow an error code because that would involve the ERR_PTR() construct.
While that construct is quite useful, I'm always wary of adding
complexity.  Thus, the tradeoff would have to be worth it.
	What would you like to signify with a ->make_item() error code?
I don't see how it 'checks' a type of sub-directory.  A particular
config_group can only create a particular type of sub-directory, so I'm
confused.  Maybe some more explanation of what you are trying to do will
help me understand.  Then I can see how configfs fits with your needs
and where it may not.

> Please give some arguments why you think 
> configfs_group_operations->drop_item() should remain void.

	Very simply, the lifetime must be in the control of userspace.
That's precisely the point of configfs.  If you'd like the kernel to
control the lifetime, I suspect sysfs will be more to your liking.
configfs is not meant to replace sysfs, merely to coexist for things
that benefit from the configfs model and not the sysfs model.
	(More on the model and your problem near the bottom)

> (1)
> Say the user creates one object, let's say as objects/myobj1/. This 
> object is dependent on some (shared) parameters which the user created 
> under params/myparams1/. Now while myobj1/ is 'active', I don't want to 
> let the user remove myparams1/. I can prevent this by making the user 
> create a symlink(2) in the objects/myobj1/ directory to myparams1/, i.e. 
> objects/myobj1/params/ -> ../../params/myparams1/, to denote its use. 
> Now - if I have read the documentation correctly - the user cannot 
> remove myparams1/ without removing the params/ link first. So fine, so good.

	This will certainly work.

> (2)
> Next the user may create several objects which may be dependent on 
> several params objects. Now I can solve this by creating a default group 
> for each object, i.e. on myobj1 creation there is objects/myobj1/params/ 
> automatically. In that directory the user may create symlink(2)s to 
> several params/*/ dirs. Fine again.
> 
> (3)
> Now what I want is the list of params an object uses to be an ordered 
> list. I cannot do this because there is no intrinsic order in a 
> filesystem. I can get the order by instead having an attribute called 
> param_list which contains the ordered list of all params to use, e.g.

	Why does it need to be ordered?  Also, why can't the symlinks
have a naming convention of order?  Sure, someone hacking at it can
break that, but your tool that really does the work can create
objects/myobj1/params/param1 -> myparams2.  So the listing does have
meaning.  Just one possibility.

> However, this way I don't have any way to prevent the user from removing 
> params because configfs_group_operations->drop_item() is void and does 
> not allow me to return an error.

	Um, with the symlinks pinning the params, they'll not be
removed.  Unless you were creating a param_list without creating the
symlinks.

> 2)
> Keep a reference on each configfs object (e.g. params) in use, so when 
> the user removes it from configfs it is still present in memory. This, 
> however, requires to rename each according entry in every affected 
> param_list to <params removed> or similar... not a very user-friendly 
> way to deal with the situation.

	There are two ways to reference the params.  One is to let the
userspace program ask for the reference via symlink.  The other is in
your driver.  This has the property you describe above, that you have
to keep track of it after the user has asked for it to go away.
	This property is on purpose.  When a user asks for something to
go away, it needs to disappear from configfs before the rmdir(2)
returns.  It's gone, and it is no longer accessible from userspace.  The
lifetiming of userspace access is clear, cut, and dried.
	However, some objects need some time to die.  So the driver has
its own reference, and it schedules any cleanup and death later.  But
that death and cleanup should happen as soon as possible, because
userspace has asked for it.

> 3)
> Change configfs so a user cannot remove directories with additional 
> references on it.

	You mean kernel-side references.  Again, you are asking for the
kernel to control the lifetime.

> 4)
> Trace back every object that relies on the params object about to be 
> removed, and delete the according params entry from the object's 
> params_list automatically... a solution with potentially unexpected side 
> effects.

	This, as you are certainly aware, is a non-starter.  It just
won't work well.

	Let's break for a minute.  Let me try to restate all of this.
You have an interrelationship between a few configfs objects.  When a
[referrer -> reference] relationship is put together, you need to prevent
the reference from going away.  You've proposed a couple of methods that
boil down to "when the reference object knows it is being referred to,
it prevents itself from going away".
	Therein lies the rub.  configfs works by putting all of that in
userspace.  Lifetime decisions can only occur in userspace.  This allows
us a very clean lifetime from the userspace perspective.  It also means
that if we want to lock an object down, it has to happen in userspace.
	So, the object cannot "prevent itself from going away".  The
kernel side just can't do this.  Userspace, however, can.  You've
discussed the most common way configfs allows userspace to do this, the
symlink.  I believe your only problem was that of naming.  There's no
reason you can't populate a param_list file at the same time you respond
to ->allow_link().  Or, you could have userspace name the links in a
manner providing ordering.  These solve this problem without breaking
the configfs contract.
	Think about your requirements again.  Do you absolutely require
that some part of your kernel driver make a lifetime decision?  If so,
configfs isn't going to fit.  Can the lifetime decision be moved to
userspace?  If so, configfs should work just fine as-is, and you'll gain
the clean lifetime and simple manipulation that configfs provides.  I
hope it's the latter :-)

Joel

-- 

"I don't want to achieve immortality through my work; I want to
 achieve immortality through not dying."
        - Woody Allen

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
