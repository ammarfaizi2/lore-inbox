Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422774AbWJLHIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422774AbWJLHIg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422775AbWJLHIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:08:35 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:37028 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1422774AbWJLHIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:08:34 -0400
Date: Thu, 12 Oct 2006 00:08:26 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in configfs
Message-ID: <20061012070826.GO7911@ca-server1.us.oracle.com>
Mail-Followup-To: Matt Helsley <matthltc@us.ibm.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Greg KH <gregkh@suse.de>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain> <20061010203511.GF7911@ca-server1.us.oracle.com> <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com> <20061010215808.GK7911@ca-server1.us.oracle.com> <1160527799.1674.91.camel@localhost.localdomain> <20061011012851.GR7911@ca-server1.us.oracle.com> <20061011220619.GB7911@ca-server1.us.oracle.com> <1160619516.18766.209.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160619516.18766.209.camel@localhost.localdomain>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 07:18:36PM -0700, Matt Helsley wrote:
> On Wed, 2006-10-11 at 15:06 -0700, Joel Becker wrote:
> > 	I suspect I was too harsh here.  Can you tell me what you are

	Btw, Mark says 'hi' and that we met at his Scotch tasting party.
I didn't realize this was you ;-)

> 	A little too harsh IMHO -- this isn't something I'm suggesting out of
> laziness, lack of thought, nor am I some corporate stooge unfamiliar
> with Linux. I am well aware of this mantra. I am also well aware that
> there are counterexamples in sysfs (which has the same mantra):
> 
> /sys/devices/pciXXXX:XX/XXXX:XX:XX.X/resource
> /sys/block/hda/stat
> /sys/block/hda/dev

	Sure, but mere existence doesn't make it right ;-)

> Each of these has more than one number in them. And they don't all use
> the same delimeter. So yes, parsing is required in existing sysfs files.
> And the parsing I'm proposing is simpler than that needed in the pci
> resource file.

	As sysfs grew, it became very clear that if you require parsing,
someone in userspace will get it wrong.  It's happened with pci
resources, etc.  What about people who say "I'll just add a field, no
one will notice" and everything breaks?  That's just not acceptible.
 
> 	In fact we've discussed the problem with you in the past (on ckrm-tech)
> and described what we're looking for. You suggested adding file(s) to
> sysfs that replace this attribute. It was an interesting suggestion but
> does not work because we have one of these lists for each item in
> configfs. I think all of this discussion is in the ckrm-tech list
> archives too (in MARC, possibly gmane, etc.).

	Sure it works.  You have one per resource group.  In
resource_group_make_object(), you sysfs_mkdir() the sysfs file.  There
is no technical limitation at all.  Now, it is nice that the pid list
lives in the configfs tree from a location standpoint.  Sure.  But is it
worth breaking the simplicity of configfs.  Greg says NO!  You say YES!
I say "I'm not sure".  And here we are.

> 	A patch would best explain what I'm proposing. But since I don't have a
> working patch yet I've tried to answer your questions below.

	Ok, some meat, good.

> Well that's sort of what we want. Not an array of u32s but a list of
> pids. Among other things Resource Groups uses configfs to let userspace
> create named groups of tasks. The list of pids describing the group of
> tasks can easily exceed one page in size when output via the members
> configfs attribute.

	And here we go.  In userspace, someone can't just do:

    ATTR=$(cat /sys/kernel/config/ckrm/myresource/attr)

because ATTR needs to be split and parsed.  And what if you decide to
change it from "<pid>\n" to "<pid> <tgid>\n" per line?  Oops, can't do
it, or you break an ABI.

> Since there are so many of them and they don't have the same lifetime
> characteristics as a configfs object we don't want to incur the space
> and complexity cost of creating and managing one configfs attribute per
> pid. At the same time, the groups themselves do have the lifetime of a
> configfs object and there are few of them.

	First, I agree that pids as an object each is very expensive.
If the groups are few, of course, creating a sysfs object per group
isn't that hard :-)

> Where's the large-attribute discussion going on?

	lkml and also offline, though we're bringing it back to lkml.
I'm going to cc this too, I hope you don't mind.

> 	WARNING: It's possible I've confused my configfs terminology a bit in
> my description below.

	I'll try and make do. :-)
 
> So for example we would have items with the following attributes:
> 
>         /sys/kernel/config/res_group/members:
>         1
>         2
>         3
>         4567

	Is this toplevel members file the "not part of any other group"
list?

>         /sys/kernel/config/res_group/mhelsleys_tasks/members:
>         4568
>         
>         /sys/kernel/config/res_group/jbeckers_tasks/members:
>         4569
> 
> 	This is how Resource Groups (formerly known as CKRM) currently
> implements the list -- as a single attribute with one pid printed per
> line. This doesn't fit the accepted OVPA rule and doesn't fit in one
> page on large systems with crazy numbers of tasks.
> 
> 	We've considered creating one attribute per pid but frankly it makes
> the rest of the code much nastier in every way (code complexity, memory
> use, locking, etc). We also considered your earlier suggestion of having
> a custom sysfs file for this. However it just doesn't fit: each list is
> different so we'd need one file per resource group. This naturally
> suggests mimicking the configfs tree in /sys but that's uniformly worse
> than one pid per attribute.

	How is this more complex?  One object per attribute is large,
but if the number of groups is "few" as you say above, isn't that
simpler?

> 	The OVPA rule exists for some very good reasons. We want to avoid the
> nightmares encountered with /proc. Specifically the nightmare of
> organizing and parsing all of those structure values. /proc files often
> incorporate too much structure into the body of the file and that in
> turn requires complex parsing; which tends to break compatibility as the
> structures they reflect change. (I've worked on some userspace C code
> that parses some /proc/sys/net files and, yes, it's nasty..)
> 
> 	Hence I think we could allow one value per line in addition to one
> value per attribute -- but only under very specific restrictions. The
> restrictions could be enforced by an additional configfs object which
> represents simple lists and lacks direct access to the char buffer.
> Also, unlike Chandra's seq_file patches, a different interface would
> avoid impacting existing uses of configfs.

	You're effectively suggesting that a specific attribute type of
"repeated value of type X".  No mixed types, no exploded structures,
just a "list of this attr" sort of thing.  This does fit my personal
requirement of avoiding a generic, abusable system.
	Greg, what do you think?

Joel

-- 

"Depend on the rabbit's foot if you will, but remember, it didn't
 help the rabbit."
	- R. E. Shay

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
