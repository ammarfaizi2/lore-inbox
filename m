Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318161AbSIEVOT>; Thu, 5 Sep 2002 17:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318162AbSIEVOT>; Thu, 5 Sep 2002 17:14:19 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:60165 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S318161AbSIEVOS>; Thu, 5 Sep 2002 17:14:18 -0400
Date: Thu, 5 Sep 2002 14:18:49 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
Message-ID: <20020905211849.GA3942@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <3D76A6FF.509@namesys.com> <1031186951.1684.205.camel@tiny> <20020905054008.GH24323@louise.pinerecords.com> <20020904.223651.79770866.davem@redhat.com> <20020905135442.A19682@namesys.com> <20020905174902.A32687@namesys.com> <1031234624.1726.224.camel@tiny> <20020905181721.D32687@namesys.com> <1031244334.1684.264.camel@tiny> <20020905212545.A5349@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020905212545.A5349@namesys.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 09:25:45PM +0400, Oleg Drokin wrote:
> Hello!
> 
> On Thu, Sep 05, 2002 at 12:45:34PM -0400, Chris Mason wrote:
> > > > read the -noleaf description on the find man page to see why we need to
> > > > set the directory link count to 1 when we are lying to userspace about
> > > > the actual link count on directories. 
> > > 
> > > There is nothing about nlink == 1 means assume -noleaf, so it should not work
> > > with old way too, right? Have anybody verified? ;)
> > I remember that happening during the initial discussions for the link
> > patch.  1 was chosen as the best way to do it, since it was a flag to
> > various programs that the unix directory link convention was not being
> > followed.
> > > Actually patch might be easily modified to represent i_nlink == 1 for
> > > large directories, but still maintain correct on-disk nlink count.
> > Right.

I'm assuming for the moment that the discussion here is
about what to report to stat(2) and not how to deal with
internal overflow (which should produce an error).

So what you are suggesting is that 
<pseudocode>
	if (i.i_nlink > ST_NLINK_MAX)
		st.st_nlink = S_ISDIR(i.i_mode) ? 1 : ST_NLINK_MAX;
</pseudocode>

I don't know the rationale for st_nlink == 1 on directories
but it seems to me the thing to do is st_nlink == 0 on
overflow regardless of type.  This simplifies the logic and
eliminates the use a funky special value that gets in the
way of supporting growth.

An st_nlink value of 0 could only occur if you were doing an
fstat() on a deleted file so i doubt much would break on
this odd case.  Having said that no doubt someone will come
up with an example to prove me wrong :)

> Ok, I will come up with revised patch tomorrow and do 2.5 port (and
> advise Vitaly about reiserfsck part)

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
