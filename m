Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261575AbTCOVWW>; Sat, 15 Mar 2003 16:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261578AbTCOVWW>; Sat, 15 Mar 2003 16:22:22 -0500
Received: from pasky.ji.cz ([62.44.12.54]:32506 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S261575AbTCOVV5>;
	Sat, 15 Mar 2003 16:21:57 -0500
Date: Sat, 15 Mar 2003 22:32:46 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Daniel Phillips <phillips@arcor.de>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Zack Brown <zbrown@tumblerings.org>, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030315213246.GD31875@pasky.ji.cz>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Daniel Phillips <phillips@arcor.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Zack Brown <zbrown@tumblerings.org>, linux-kernel@vger.kernel.org
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030311184043.GA24925@renegade> <22230000.1047408397@flay> <20030311192639.E72163C5BE@mx01.nexgo.de> <20030314122903.GC8057@zaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030314122903.GC8057@zaurus.ucw.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Fri, Mar 14, 2003 at 01:29:03PM CET, I got a letter,
where Pavel Machek <pavel@ucw.cz> told me, that...
> Hi!
> 
> > You can wave your wand, and the soft changeset will turn into a universal 
> > diff or a BK changeset.  But it's obviously a lot cleaner, extensible, 
> > flexible and easier to process automatically than a text diff.  It's an 
> > internal format, so it can be improved from time to time with little or no 
> > breakage.
> > 
> > Did that make sense?
> 
> Yes.
> 
> Some kind of better-patch is badly needed.
> 
> What kind of data would have to be in soft-changeset?
> * unique id of changeset
> * unique id of previous changeset
> (two previous if it is merge)
> ? or would it be better to have here
> whole path to first change?
> * commit comment
> * for each file:
> ** diff -u of change
> ** file's unique id
> ** in case of rename: new name (delete is rename to special dir)
> ** in case of chmod/chown: new permissions
> ** per-file comment
> 
> ? How to handle directory moves?
> 
> Does it seem sane? Any comments?

Sounds almost sane (except the requirement for -u, it should be probably
possible to use the same scale of diff types as now </nitpicking>). When
already doing -u, it should probably also mention the original name of the file
in case of move/rename and especially the original chmod/chown
permissions/ownership. About chown, I'm not that sure ownership should be
recorded/carried, given that normal users can't even chown, and probably the
usernames won't exist on the system anyway. Maybe making that an optional
feature which the patching subject may ignore.

Whole separate issue is how to generate the unique ids. First, we need unique
ids for people, that shouldn't be that difficult. In fact, email should do
quite well, as it does for BitKeeper or arch. Interesting thing could happen
when someone's email is going to change and he wants to use the new one.
Probably when changing this information in his repository, the old one should
be kept as an "alias" and sent along with any updates near the new one --- I
believe the backlog shouldn't even reach any dangerous length, for standard
communication some sane upper threshold (like 5) could be set and more would be
sent only in direct communication and only in case of conflicts.

Changeset unique id should probably include author of that changeset and time
(with seconds precision) of commiting such a changeset to the [original]
repository [of the changeset]. However some insane scripts could make, checkin
and commit several changesets in line fast enough or so, thus you want
something else in the id as well, which could further differentiate commitins
happenning at same time. Checksum of the changeset changes (in some suitable
form) would do. Now, if you want to annoy Larry, separate the fields by '|'s
and you could get something familiar.

File's unique id is a little harder. The best thing to do is probably to
identify file by its origin. The file appeared in some changeset, we have
already unique ids for changesets. And the file appeared under some original
name there, which has to be unique inside of one changeset. Thus take changeset
unique id and add another field there, the original file name under which it
appeared in that changeset. It should be still unique and also cheap to look up
--- you have only to look for changes in that one changeset, look up the
particular file in the list of files appearing there and you should keep some
file name -> "virtual inode" number mapping near the files anyway.

What do you think?

Kind regards,

-- 
 
				Petr "Pasky" Baudis
.
The pure and simple truth is rarely pure and never simple.
		-- Oscar Wilde
.
Stuff: http://pasky.ji.cz/
