Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318230AbSIFBgx>; Thu, 5 Sep 2002 21:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318231AbSIFBgx>; Thu, 5 Sep 2002 21:36:53 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:22278 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S318230AbSIFBgv>; Thu, 5 Sep 2002 21:36:51 -0400
Date: Thu, 5 Sep 2002 18:41:22 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
Message-ID: <20020906014122.GE3942@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20020905135442.A19682@namesys.com> <20020905174902.A32687@namesys.com> <1031234624.1726.224.camel@tiny> <20020905181721.D32687@namesys.com> <1031244334.1684.264.camel@tiny> <20020905212545.A5349@namesys.com> <20020905211849.GA3942@pegasys.ws> <20020906000249.A10844@vestdata.no> <20020905225706.GC3942@pegasys.ws> <20020906020138.A23940@vestdata.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020906020138.A23940@vestdata.no>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2002 at 02:01:38AM +0200, Ragnar Kjørstad wrote:
> On Thu, Sep 05, 2002 at 03:57:06PM -0700, jw schultz wrote:
> > > Now, I've just checked the source of GNU find (v4.1.7) and it does _not_
> > > recognize nlink=1 as a special value. (It works as long as there are
> > > less than 2^32 subdirectories though, because it is looking for -1
> > > subdirectories and it wraps)
> > 
> > So a value of 0 would have the same effect.
> > (0 - 2 == -2 vs 1 - 2 == -1) Yes?
> 
> Yes, it will. For GNU find.
> 
> But the reasoning for using nlink==1 is that that's how "all non-unix
> filesystems" behaved, so applications out there could potentially check
> for it. 

But we aren't talking about filesystems with different ideas
about directory linking.  We are talking about directories
with an overflowed link-count.

> > I know it is used for reporting purposes such as ls -l.  It
> > would also used by archiving tools like cpio, tar and rsync
> > to identify files that may be linked so that not every file
> > must be checked against every previous file.  A smart
> > archiving tool would track the link count and remove entries
> > that have all links found so any value that isn't recognized
> > as an overflow indicator would tend to break things.  I see
> > the value of 0 as indicating "link count unsupported".
> 
> Hmm, yes. Values of 1 or NLINK_MAX would definitively confuse such
> applications. But then again, so would a value of 0 unless they know
> it's meaning.

The value of 1 can't be used for regular files because it
would mean the file doesn't need checking for other links.
Coding for NLINK_MAX would mean the apps would have to
adjust every time NLINK_MAX changed.  Yes, it could be done
through #define in stat.h.  It is a corner case right now
but these apps could know that

	1 == no other links
	>1 == known number of other links
	0 == unknown number of other links

And the code would work on other systems with different or
no overflow/limit.  So far as i know Linux is the only OS
that is allowing the creation of more links than 32767.
These apps are going to need to cope with this sooner or
later.  Allowing nlinks to overflow st_nlink is going to
break them.  Using 0 would mean that the application code to
handle this corner case would simply never get invoked on
other platforms without requiring build options.  Sure 1 is
a red flag for directories (if you can spot it) but any
value greater than 0 is potentially valid for files.

That is why i lean toward 0.  It is a clear indication that
the value is meaningless.  It also sticks out like a sore
thumb.  If i do an ls -l and see 0 i will know i've got a
reporting overflow without having to remember what the exact
limit is.  This way i can do a 'find -links 0' and spot
directories and files with more links than fit etc.  The
application code to cope with it won't break or require
special handling on other platforms.

So you see why i dislike NLINK_MAX and it just makes sens to me
to use the same for files and directories.  Filesystems that
don't support hardlinks have been stuffing 1 into st_nlink
for both file and directories (treating them identically).
I am essentially saying we should treat files and directories
the same on overflow.  We just shouldn't use some value that
in future could represent reality.  Hence 0.  So far i
haven't heard any reason why not.

NOTE: 
	Allowing the creation of links that exceed the capacity of
	stat(2) to report will break utilities.  There should be a
	system wide tunable that allows restricting link creation to
	a maximum number until the tools catch up.  This tunable
	would only affect link creation causing link(2) to set errno
	to EMLINK.  A mount option might be OK too.
	This limit should not affect pseudo filesystems like
	proc or driverfs.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
