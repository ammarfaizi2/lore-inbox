Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318253AbSIEV7Z>; Thu, 5 Sep 2002 17:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318257AbSIEV7E>; Thu, 5 Sep 2002 17:59:04 -0400
Received: from stine.vestdata.no ([195.204.68.10]:29577 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S318253AbSIEV6R>; Thu, 5 Sep 2002 17:58:17 -0400
Date: Fri, 6 Sep 2002 00:02:49 +0200
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
Message-ID: <20020906000249.A10844@vestdata.no>
References: <1031186951.1684.205.camel@tiny> <20020905054008.GH24323@louise.pinerecords.com> <20020904.223651.79770866.davem@redhat.com> <20020905135442.A19682@namesys.com> <20020905174902.A32687@namesys.com> <1031234624.1726.224.camel@tiny> <20020905181721.D32687@namesys.com> <1031244334.1684.264.camel@tiny> <20020905212545.A5349@namesys.com> <20020905211849.GA3942@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020905211849.GA3942@pegasys.ws>; from jw@pegasys.ws on Thu, Sep 05, 2002 at 02:18:49PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 02:18:49PM -0700, jw schultz wrote:
> I'm assuming for the moment that the discussion here is
> about what to report to stat(2) and not how to deal with
> internal overflow (which should produce an error).
> 
> So what you are suggesting is that 
> <pseudocode>
> 	if (i.i_nlink > ST_NLINK_MAX)
> 		st.st_nlink = S_ISDIR(i.i_mode) ? 1 : ST_NLINK_MAX;
> </pseudocode>
> 
> I don't know the rationale for st_nlink == 1 on directories
> but it seems to me the thing to do is st_nlink == 0 on
> overflow regardless of type.  This simplifies the logic and
> eliminates the use a funky special value that gets in the
> way of supporting growth.

I believe nlink for directories and files are used differently, 
and thus may have to be handled differently as well.

Amongs other things nlink on directories are used when traversing 
directory-trees. If nlink=4 on a directory there must be 2
sub-directories, and you can stop looking once you've found the two.

By giving the incorrect nlink-number, applications using this
optimization will break.

Apperently some operatingsystems/filesystems (VMS?) report the special 
value of nlink=1 when the information is not available, and some
applications use this information to automaticly disable the
optimization. This is why reiserfs has returned nlink=1 for directories
with more than MAX_REISERFS_NLINK subdirectories.

Now, I've just checked the source of GNU find (v4.1.7) and it does _not_
recognize nlink=1 as a special value. (It works as long as there are
less than 2^32 subdirectories though, because it is looking for -1
subdirectories and it wraps)


I'm not sure exactly what nlink is used for in userspace for regular
files, so I don't know what value should be used when the real number 
doesn't fit in the interface.



(Of course new directories/hardlinks shouldn't be created at all once
the limit is exceeded, the above is only a workaround for people that
need it anyway :) )



-- 
Ragnar Kjørstad
