Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319255AbSIEWyN>; Thu, 5 Sep 2002 18:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319263AbSIEWyN>; Thu, 5 Sep 2002 18:54:13 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:9990 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S319255AbSIEWwh>; Thu, 5 Sep 2002 18:52:37 -0400
Date: Thu, 5 Sep 2002 15:57:06 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
Message-ID: <20020905225706.GC3942@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20020905054008.GH24323@louise.pinerecords.com> <20020904.223651.79770866.davem@redhat.com> <20020905135442.A19682@namesys.com> <20020905174902.A32687@namesys.com> <1031234624.1726.224.camel@tiny> <20020905181721.D32687@namesys.com> <1031244334.1684.264.camel@tiny> <20020905212545.A5349@namesys.com> <20020905211849.GA3942@pegasys.ws> <20020906000249.A10844@vestdata.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020906000249.A10844@vestdata.no>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2002 at 12:02:49AM +0200, Ragnar Kjørstad wrote:
> On Thu, Sep 05, 2002 at 02:18:49PM -0700, jw schultz wrote:
> > I'm assuming for the moment that the discussion here is
> > about what to report to stat(2) and not how to deal with
> > internal overflow (which should produce an error).
> > 
> > So what you are suggesting is that 
> > <pseudocode>
> > 	if (i.i_nlink > ST_NLINK_MAX)
> > 		st.st_nlink = S_ISDIR(i.i_mode) ? 1 : ST_NLINK_MAX;
> > </pseudocode>
> > 
> > I don't know the rationale for st_nlink == 1 on directories
> > but it seems to me the thing to do is st_nlink == 0 on
> > overflow regardless of type.  This simplifies the logic and
> > eliminates the use a funky special value that gets in the
> > way of supporting growth.
> 
> I believe nlink for directories and files are used differently, 
> and thus may have to be handled differently as well.
> 
> Amongs other things nlink on directories are used when traversing 
> directory-trees. If nlink=4 on a directory there must be 2
> sub-directories, and you can stop looking once you've found the two.
> 
> By giving the incorrect nlink-number, applications using this
> optimization will break.
> 
> Apperently some operatingsystems/filesystems (VMS?) report the special 
> value of nlink=1 when the information is not available, and some
> applications use this information to automaticly disable the
> optimization. This is why reiserfs has returned nlink=1 for directories
> with more than MAX_REISERFS_NLINK subdirectories.
> 
> Now, I've just checked the source of GNU find (v4.1.7) and it does _not_
> recognize nlink=1 as a special value. (It works as long as there are
> less than 2^32 subdirectories though, because it is looking for -1
> subdirectories and it wraps)

So a value of 0 would have the same effect.
(0 - 2 == -2 vs 1 - 2 == -1) Yes?

> 
> 
> I'm not sure exactly what nlink is used for in userspace for regular
> files, so I don't know what value should be used when the real number 
> doesn't fit in the interface.

I know it is used for reporting purposes such as ls -l.  It
would also used by archiving tools like cpio, tar and rsync
to identify files that may be linked so that not every file
must be checked against every previous file.  A smart
archiving tool would track the link count and remove entries
that have all links found so any value that isn't recognized
as an overflow indicator would tend to break things.  I see
the value of 0 as indicating "link count unsupported".

> (Of course new directories/hardlinks shouldn't be created at all once
> the limit is exceeded, the above is only a workaround for people that
> need it anyway :) )

It should not fail just because the type specified for
st_nlink has overflowed.  It should fail only if the FS or
kernel internals overflow.  Internally the kernel is moving
to an unsigned int.  I looked it up a recently and each
filesystem has it's own idea of a maximum number of links
and most of them are not just arbitrary  but even strange
such as 32000 or 0x7FFF - 1000.

The stat structure has already been left behind on this.
Eventually (3.0?) it should be updated to reflect the
changed internals.  This update has to be delayed because it
will break binary compatability of oodles of code.  I, at
least, don't think this is worth creating yet another
version of stat(2).

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
