Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284210AbRLKXeZ>; Tue, 11 Dec 2001 18:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284198AbRLKXeN>; Tue, 11 Dec 2001 18:34:13 -0500
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:14749 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S284195AbRLKXd4>; Tue, 11 Dec 2001 18:33:56 -0500
Date: Tue, 11 Dec 2001 23:33:52 +0000 (GMT)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Hans Reiser <reiser@namesys.com>
cc: Nathan Scott <nathans@sgi.com>, Andreas Gruenbacher <ag@bestbits.at>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@oss.sgi.com
Subject: Re: reiser4 (was Re: [PATCH] Revised extended attributes  interface)
In-Reply-To: <3C1678ED.8090805@namesys.com>
Message-ID: <Pine.SOL.3.96.1011211225917.17160A-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2001, Hans Reiser wrote:
> Anton Altaparmakov wrote:
> >> *Hans Reiser wrote:
> >>
> >> What is your intended functional difference between extended 
> >> attributes and streams?
> >>
> >> None?
> >
> >
> > Differences in NTFS:
> >
> > - maximum size (EA limited to 64kiB, named stream 2^63 bytes) 
> 
> These are desirable limits to preserve?  For sure?  If so, then a 
> particular plugin can be written to restrict files to 64k, though I 
> shake my head at the thought.

You cannot not preserve them. At least not on NTFS! That is what the NTFS
specifications state (as visible from $AttrDef system file). I don't have
the option to change this.

> > - locality of storage (all EAs are stored in one so they are quicker 
> > to access when you need to access multiple EAs) 
> 
> arbitrarily aggregating files is a useful feature, there is no reason to 
> rigidly offer and require the feature for EAs only.

I was just stating a fact of how they are stored on NTFS, again something
I have no power to change.

> > - name namespace (Unicode names for named streams vs ASCII for EAs) 
> 
> Namespaces can be changed for the children of directories.  Plan9 guys 
> have done such things, and it is cool.
> 
> > - potential ability to compress/encrypt (EAs cannot do this, named 
> > streams could possibly and they certainly can be sparse, too which EAs 
> > cannot be) 
> 
> Well, I suppose you could allow restricting some files to not have 
> compression and sparseness, though it isn't exciting to me.
> >
> > - named streams have creation/modification/access/etc times associated 
> > with them, EAs don't 
> 
> I thought streams shared the stat data of the parent file?  

Yes, they do. Sorry, I got mixed up on that one point. I was thinking of
hard links rather than named streams (attribute $FILE_NAME rather than
$DATA).

> > How is that for a start? 
> 
> Not one reason cited is convincing to me.
> >
> >> Ok, let's assume none until I get your response.  (I can respond more 
> >> specifically
> >> after you correct me.)  Let me further go out on a limb,and guess 
> >> that you intend
> >> that extended attributes are meta-information about the object, and 
> >> streams
> >> are contained within the object.
> >
> > Streams are only within the inode if they are tiny, otherwise they are 
> > stored indirect just like normal file data. What they contain is 
> > complete specific to the creator. Same is valid for EAs, with the 
> > exception that all EAs are stored as one "stream" (for lack of a 
> > better word). 
> 
> I miss the point of the implementation details cited above.

You said that EAs contain meta-info and streams are contained within the
object (not sure what you mean there but anyway) and I was saying that
that is not true, even if in somewhat unclear words.

> >> In this case, a naming convention is quite sufficient to distinguish 
> >> them.
> >
> > Still think so? 
> 
> Yes.
> 
> > I don't.
> >
> >> Extended attributes can have names of the form filenameA/..extone.
> >>
> >> Streams can have names of the form filenameA/streamone.
> >>
> >> In other words, all meta-information about an object should by 
> >> convention
> >> (and only by convention, because people should live free, and because
> >> there is not always an obvious distinction between meta and contained
> >> information) be preceded by '..'
> >>
> >> Note that readdir should return neither stream names nor extended 
> >> attribute names,
> >> and the use of 'hidden' directory entries accomplishes this (ala 
> >> .snapshot
> >> for WAFL).
> >> *
> >> **
> >>   **
> >
> >
> > All the below quotes refering to *Curtis are actually from me, IIRC...
> >
> >> *Curtis:
> >> You can't possibly have both using the same API since you would then 
> >> get name collision on filesystems where both named streams and EAs 
> >> are supported.
> >> *
> >>   **
> >> **
> >>
> >> *Name distinctions are what you use to avoid name collisions, see above.
> >> *
> >
> >
> > Ok, that would work, BUT:
> >
> > (Again this is me not Curtis...)
> >
> >> *Curtis:
> >> (And I haven't even mentioned EAs and named streams attached to 
> >> actual _real_ directories yet.)
> >>
> >> *
> >>   **
> >> *I don't understand this.
> >
> >
> > Ok, I will try to explain. An inode is the real thing, not a file. 
> 
> In reiserfs we say object, and consider files and directories (and 
> symlinks, etc.) to be objects.  We don't have on-disk inodes.   Inodes 
> are implementation layer not semantic layer.  We should be talking about 
> semantic layer here I think.
> 
> > An inode can by definition be a file or a directory (or a symlink, or 
> > special device file, etc).
> >
> > Any of these (i.e. any inode) can have both named streams AND EAs 
> > attached to them on NTFS. So say I have a directory named MyDir and it 
> > contains a named stream called MyStream1 and an EA called MyEA1 and 
> > two files, one called MyStream1 and one called "..MyEA1".
> >
> > Now with your scheme of naming things, looking up MyDir/MyStream1 
> > matches both the file MyStream1 that is in the directory MyDir and the 
> > named stream MyStream1 belonging to the directory MyDir. - How do 
> > you/does one distinguish the two in your scheme?!? I can only see it 
> > makind a big BANG here... 
> 
> Well, gosh, okay, maybe you want to prepend ',,' to streams and '..' to 
> extended attributes.  I personally think Linux would only want to do so 
> when used as a fileserver emulating NTFS/SAMBA.  There is no enhancement 
> of user functionality from doing it for general purpose filesystems. 

Just wait until this functionality is available and watch all GUI things
start to use it en masse! I don't doubt that GNOME/KDE/replace with your
favourite window manager are going to hesitate to start putting in the
icon, the name, and whatnot inside EAs or inside named streams the instant
they are ubiquitously available and I think that makes a lot of sense too.
No doubt I will get flamed for saying this but all flames go to
/dev/null...

Both MacOS and as of recently Windows do this kind of stuff, too, and it
can't be long before Linux goes the same way, provided file systems
support the required features (i.e. EAs and/or named streams) so I
disagree with you this is only a compatibility thing. It might start out
as one but it will find real world applications very quickly...

>  Feel free to substitute anything you like for ',,', the choice of 
> naming convention is not the point.  You could even use ':':-).
> 
> It is important though that you not require ',,', ':', or '..' to have 
> these special meanings for all Linux namespaces, I hope that is understood.

The problem with making this flexible is that how does a user space
application find out what the current separators are? Will you be
introducing a get_name_spaces_of_this_inode syscall that needs to be
called on each inode before accessing EAs? And what if someone changes it
halfway through while you are reading EAs? That way lie dragons IMHO.

The proposed EA API which accesses EAs as EAs and not as files doesn't
suffer from any such problems.

> > Similarly, looking up MyDir/..MyEA1 matches both the file named 
> > "..MyEA1" and the EA MyEA1. BANG!
> >
> > And add a named stream actually named "..MyEA1" to MyDir and you have 
> > total salad!
> >
> > See the problem now? 
> 
> No, see above.
> 
> > I certainly fail to see how your naming scheme is going to cope with 
> > this... Perhaps I am missing something? 
> 
> Naming conventions are easy.  See above.

How so? You are begging the question by just saying it is easy. Please
answer what you do when there is a clash, which is bound to happen
eventually especially if you make the name space prefixes flexible.

Does the user just experience undefined behaviour? That would be
unacceptable IMHO.

> > Now if you have distinct APIs for EAs you have no problems on that 
> > side and if you don't use the slash but say the colon (like Windows 
> > does) for named streams you get rid of the named streams in 
> > directories problem, too. But then you need to forbid the ":" as an 
> > accepted character in the file name just like Windows does which is 
> > probably a reason not to use that API either...
> >
> >> *
> >> **
> >>   **
> >>
> >> *Curtis:
> >> Let's face it: EAs exist. They are _not_ files/directories so the API
> >> *
> >>   **
> >> *Is this an argument?
> >>
> >> EA's do not exist in Linux, and they should never exist as something 
> >> that is more than a file. Since they do not exist, you might as well 
> >> improve the filesystems you port to Linux while porting them.  APIs 
> >> shape an OS over the long term, and if done wrong they burden 
> >> generations after you with crud.
> >
> >
> > Like Microsoft is going to let me change the NTFS specifications to 
> > modify how EAs and named streams are stored. Dream on!
> >
> > But perhaps we are talking past each other: I am talking on-disk 
> > format / specifications. 
> 
> 
> I am NOT talking about on-disk format, I am talking about APIs and 
> naming conventions.  On disk format is entirely FS specific.  Live free 
> (errr, no, you are doing NTFS, live confined;-) ).....
> 
> > These exist and no, we cannot change those at all. You can do that 
> > with reiserfs as it is yours but all of us supporting existing file 
> > systems owned by corporations like Microsoft, SGI, etc, have to live 
> > with the specifications.
> >
> >> *
> >> **
> >>   **
> >> *Curtis:
> >> should not make them appear as files/directories. - You have to 
> >> consider that there are a lot of filesystems out there which are 
> >> already developed and which need to be supported. - Not everyone has 
> >> their own filesystem which they can change/extend the 
> >> specifications/implementation of at will.
> >> *
> >>   **
> >> *
> >> Yes they do.  It is all GPL'd.  Even XFS.  Do the underlying 
> >> infrastructure
> >> the right way, and I bet you'll be surprised at how little need there 
> >> really
> >> is for ea's done the wrong way. A user space library can cover
> >> over it all (causing only the obsolete programs using it to suffer 
> >> while they
> >> wait to fade away).
> >
> >
> > ?!? GPL has nothing to do with on-disk format and I doubt Microsoft 
> > would agree that the ntfs on-disk layout is GPL. It's a trade secret! 
> > Why do you think ntfs developers have to spend half their life using 
> > disassemblers and hexeditors?!? 
> 
> Did you file comments in the various MS legal battles going on?  You 
> should.....  (I know, there is only a small chance it will have an 
> effect, but..... )  they should be required to give you the info, and if 
> you don't demand it I bet they won't be so required.  Did you notice how 
> they are restricting things to only persons with a viable business in 
> the opinion of MS?

They are restricting a lot of things. From what I have seen so far they
will end up not showing anything to anybody at all. This settlement is
complete garbage. But we are getting off topic...

> >> *
> >> What would have happened if set theory had not just sets and 
> >> elements, but sets, elements, extended-attributes, and streams, and 
> >> you could not use the same operators on streams that you use on 
> >> elements?  It would have been crap as a theoretical model.  It does 
> >> real damage when you add things that require different operators to 
> >> the set of primitives. Closure is extremely important to design.  
> >> Don't do this.
> > Since we are going into analogies: You don't use a hammer to affix a 
> > screw and neither do you use a screwdriver to affix a nail...at least 
> > I don't. I think you are trying to use a large sledge hammer to put 
> > together things which do not fit together thus breaking them in the 
> > process. To use your own words: Don't do this. (-; Each is distinct 
> > and should be treated as such. </me ducks>
> >
> Programs will get written to use your API, and not work with reiserfs, 
> and will get written to use our API and not work with NTFS, and this is 
> bad....

Now that is true. And yes, it is bad. However it will be up to the
community to decide which API to use and at the moment there are several
fs using the "bestbits" API and only reiserfs (?) the "reiserfs" one...
And we all know from our very own $Deity that we don't design software, we
just write things and let evolution decide which is better. (((-;

> Thanks for the FS driver by the way, it is very useful to us dual-booters.

Thanks. (-: It is indeed, I being one of the dual-booters as well. (-:

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

