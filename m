Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWJMXhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWJMXhn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 19:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbWJMXhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 19:37:43 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:26305 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752000AbWJMXhm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 19:37:42 -0400
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in
	configfs
From: Matt Helsley <matthltc@us.ibm.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
In-Reply-To: <20061012070826.GO7911@ca-server1.us.oracle.com>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
	 <20061010203511.GF7911@ca-server1.us.oracle.com>
	 <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com>
	 <20061010215808.GK7911@ca-server1.us.oracle.com>
	 <1160527799.1674.91.camel@localhost.localdomain>
	 <20061011012851.GR7911@ca-server1.us.oracle.com>
	 <20061011220619.GB7911@ca-server1.us.oracle.com>
	 <1160619516.18766.209.camel@localhost.localdomain>
	 <20061012070826.GO7911@ca-server1.us.oracle.com>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Fri, 13 Oct 2006 16:37:38 -0700
Message-Id: <1160782659.18766.549.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 00:08 -0700, Joel Becker wrote:
> On Wed, Oct 11, 2006 at 07:18:36PM -0700, Matt Helsley wrote:
> > On Wed, 2006-10-11 at 15:06 -0700, Joel Becker wrote:

<snip>
 
> > /sys/devices/pciXXXX:XX/XXXX:XX:XX.X/resource
> > /sys/block/hda/stat
> > /sys/block/hda/dev
> 
> 	Sure, but mere existence doesn't make it right ;-)
>
> > Each of these has more than one number in them. And they don't all use
> > the same delimeter. So yes, parsing is required in existing sysfs files.
> > And the parsing I'm proposing is simpler than that needed in the pci
> > resource file.
> 
> 	As sysfs grew, it became very clear that if you require parsing,
> someone in userspace will get it wrong.  It's happened with pci
> resources, etc.  What about people who say "I'll just add a field, no
> one will notice" and everything breaks?  That's just not acceptible.

	I agree. And that means introducing new ABIs should have a high barrier
to acceptance. But in my opinion it also shouldn't prohibit carefully
considered deviation from the guidelines.
 
> > 	In fact we've discussed the problem with you in the past (on ckrm-tech)
> > and described what we're looking for. You suggested adding file(s) to
> > sysfs that replace this attribute. It was an interesting suggestion but
> > does not work because we have one of these lists for each item in
> > configfs. I think all of this discussion is in the ckrm-tech list
> > archives too (in MARC, possibly gmane, etc.).
> 
> 	Sure it works.  You have one per resource group.  In
> resource_group_make_object(), you sysfs_mkdir() the sysfs file.  There

	That's the easy part. Next we need to make the pid attribute whenever a
new task is created. And delete it when the task dies. And move it
around whenever it changes groups. Is there rename() support in /sys? If
not, would changes to allow rename() be acceptable (I'm worried it would
impact alot of assumptions made in the existing code)?

> is no technical limitation at all.  Now, it is nice that the pid list
> lives in the configfs tree from a location standpoint.  Sure.  But is it
> worth breaking the simplicity of configfs.  Greg says NO!  You say YES!
> I say "I'm not sure".  And here we are.

	Consider that having two very similar (but not symlinked!) trees in
both /sys/ ... /res_group and /sys/kernel/config/res_group could be
rather confusing to userspace programmers and users alike.

	It would be strange because when you rmdir a group
in /sys/kernel/config/res_group... a directory in /sys would also
disappear. Yet you can't mkdir or rmdir the /sys dirs. And to edit the
group resources you'd be editting stuff in configfs but to add or remove
tasks to the group you'd be mv'ing stuff in /sys..

> > 	A patch would best explain what I'm proposing. But since I don't have a
> > working patch yet I've tried to answer your questions below.
> 
> 	Ok, some meat, good.
> 
> > Well that's sort of what we want. Not an array of u32s but a list of
> > pids. Among other things Resource Groups uses configfs to let userspace
> > create named groups of tasks. The list of pids describing the group of
> > tasks can easily exceed one page in size when output via the members
> > configfs attribute.
> 
> 	And here we go.  In userspace, someone can't just do:
> 
>     ATTR=$(cat /sys/kernel/config/ckrm/myresource/attr)

Hmm, that suggests a good point. While some one *can* do that or:

ATTR=( $(cat /sys/kernel/config/ckrm/myresource/attr) )

the space available for environment variables is limited. So attempting
to store a large (What's "large"?) attribute in an environment variable
is a potentially buggy practice. This is a significant problem affecting
large attributes in general.

> because ATTR needs to be split and parsed.  And what if you decide to
> change it from "<pid>\n" to "<pid> <tgid>\n" per line?  Oops, can't do
> it, or you break an ABI.

	Once we have the pid the rest is easily reachable. I think Paul
Jackson's response -- we can add but not change existing files -- is the
best answer here.

> > Since there are so many of them and they don't have the same lifetime
> > characteristics as a configfs object we don't want to incur the space
> > and complexity cost of creating and managing one configfs attribute per
> > pid. At the same time, the groups themselves do have the lifetime of a
> > configfs object and there are few of them.
> 
> 	First, I agree that pids as an object each is very expensive.
> If the groups are few, of course, creating a sysfs object per group
> isn't that hard :-)

	One per group isn't hard or very expensive -- but that's not the issue
I was bringing up. One per pid is expensive because we'd need to alloc
and associate that object with the task. And then, if we're tearing down
all resource groups (the root group) we need to iterate over all the
tasks and free the object. We'd also need to free the object when the
task is freed. Those can race so we'd need some locking...

This is much more complex than being allowed to print out one pid per
line.

<snip>

> > 	WARNING: It's possible I've confused my configfs terminology a bit in
> > my description below.
> 
> 	I'll try and make do. :-)
>  
> > So for example we would have items with the following attributes:
> > 
> >         /sys/kernel/config/res_group/members:
> >         1
> >         2
> >         3
> >         4567
> 
> 	Is this toplevel members file the "not part of any other group"
> list?

Yes. They all are -- a pid can only be in one members file. Pids 1, 2,
3, 4567 won't show up in any other members file.

> >         /sys/kernel/config/res_group/mhelsleys_tasks/members:
> >         4568

pid 4568 won't show up in any other members file.
         
> >         /sys/kernel/config/res_group/jbeckers_tasks/members:
> >         4569

etc.

> > 	We've considered creating one attribute per pid but frankly it makes
> > the rest of the code much nastier in every way (code complexity, memory
> > use, locking, etc). We also considered your earlier suggestion of having
> > a custom sysfs file for this. However it just doesn't fit: each list is
> > different so we'd need one file per resource group. This naturally
> > suggests mimicking the configfs tree in /sys but that's uniformly worse
> > than one pid per attribute.
> 
> 	How is this more complex?  One object per attribute is large,
> but if the number of groups is "few" as you say above, isn't that
> simpler?

	There are two parts to the complexity: code complexity and the number
of userspace pieces to deal with. I think that in both of these
categories the OVPA approach is more complex. Here's how I see it:

                      |Complexity of|
                      | OVPA | OVPL |
----------------------+------+------+
Code                  | more | less |
                      |      |      |
Number of filesystems |      |      |
  reflecting resource |  2   |  1   |
  group hierarchy     |      |      |
                      |      |      |
Attribute             | less | more |
     complexity       |      |      |
----------------------+------+------+
Total                 | more | less |

I think the "more" in the OVPL column is much much smaller than the
"more" in the OVPA column. Lastly the OVPL code can be shared while the
OVPA code most likely cannot be shared.

> > 	The OVPA rule exists for some very good reasons. We want to avoid the
> > nightmares encountered with /proc. Specifically the nightmare of
> > organizing and parsing all of those structure values. /proc files often
> > incorporate too much structure into the body of the file and that in
> > turn requires complex parsing; which tends to break compatibility as the
> > structures they reflect change. (I've worked on some userspace C code
> > that parses some /proc/sys/net files and, yes, it's nasty..)
> > 
> > 	Hence I think we could allow one value per line in addition to one
> > value per attribute -- but only under very specific restrictions. The
> > restrictions could be enforced by an additional configfs object which
> > represents simple lists and lacks direct access to the char buffer.
> > Also, unlike Chandra's seq_file patches, a different interface would
> > avoid impacting existing uses of configfs.
> 
> 	You're effectively suggesting that a specific attribute type of
> "repeated value of type X".  No mixed types, no exploded structures,
> just a "list of this attr" sort of thing.  This does fit my personal
> requirement of avoiding a generic, abusable system.

Exactly.

Cheers,
	-Matt Helsley

