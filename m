Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbVCOBmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVCOBmw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 20:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVCOBmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 20:42:52 -0500
Received: from mail.autoweb.net ([198.172.237.26]:20486 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S262195AbVCOBmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 20:42:45 -0500
Date: Mon, 14 Mar 2005 20:42:35 -0500
From: Ryan Anderson <ryan@michonline.com>
To: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] Automatically append a semi-random version for BK users
Message-ID: <20050315014235.GD5318@mythryan2.michonline.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Ryan Anderson <ryan@michonline.com>
References: <20050309080638.GW7828@mythryan2.michonline.com> <20050314224317.GB31437@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050314224317.GB31437@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Snipping a bit as I go, thanks for the feedback, Sam.

On Mon, Mar 14, 2005 at 11:43:17PM +0100, Sam Ravnborg wrote:
> On Wed, Mar 09, 2005 at 03:06:38AM -0500, Ryan Anderson wrote:
> > Two approachs are present here, a Perl version that is setup to handle
> > other automatic version appends (i.e, a CVS version shouldn't be much
> > effort to add), and a simplistic shell version that depends on "md5sum".
> > Both approaches generate the same hash.
> 
> Please skip the shell version - add a note in Kconfig that enabling this
> option requires perl.

Thanks.  That makes this much easier to do.

> >  #export	INSTALL_PATH=/boot
> >  
> > +# If CONFIG_LOCALVERSION_AUTO is set, we automatically perform some tests
> > +# and try to determine if the current source tree is a release tree, of any sort,
> > +# or if is a pure development tree.
> > +# A 'release tree' is any tree with a BitKeeper TAG associated with it.
> > +# The primary goal of this is to make it safe for a native BitKeeper user to
> > +# build a release tree (i.e, 2.6.9) and also to continue developing against the
> > +# current Linus tree, without having the Linus tree overwrite the 2.6.9 tree 
> > +# when installed.
> > +#
> > +# (In the future, CVS and SVN support will be added as well.)
> > +
> > +ifeq ($(CONFIG_LOCALVERSION_AUTO),y)
> > +	ifeq ($(shell ls -d $(srctree)/BitKeeper 2>/dev/null),$(srctree)/BitKeeper)
> > +		localversion-bk := $(shell $(srctree)/scripts/setlocalversion.sh $(srctree) $(objtree))
> > +		LOCALVERSION := $(LOCALVERSION)$(localversion-bk)
> > +	endif
> > +endif
> Move the logic to determine the SCM system into the perl script.
> And do not assume bk, select more generic names.

Ok, simple enough to do.

> Also use:
> ifdef CONFIG_LOCALVERSION_AUTO
> like in rest of Makefile.
> 
> Something like this:
> ifdef CONFIG_LOCALVERSION_AUTO
>     LOCALVERSION += $(CONFIG_SHELL) $(srctree)/scripts/setlocalversion.sh $(srctree)
> endif
> note - perl script does not use objtree.

I forget why I had that there - I'll remove it.

> diff -Nru a/scripts/setlocalversion b/scripts/setlocalversion
> > --- /dev/null	Wed Dec 31 16:00:00 196900
> > +++ b/scripts/setlocalversion	2005-03-09 02:51:15 -05:00

> > +
> > +# We are going to use the following commands to try and determine if
> > +# this repository is at a Version boundary (i.e, 2.6.10 vs 2.6.10 + some patches)
> > +# We currently assume that all meaningful version boundaries are marked by a tag.
> > +# We don't care what the tag is, just that something exists.
> > +
> > +#ryan@mythryan2 ~/dev/linux/local$ T=`bk changes -r+ -k`
> > +#ryan@mythryan2 ~/dev/linux/local$ bk prs -h -d':TAG:\n' -r$T
> - to be deleted?

I'll simply rewrite as a better explanation of what's going on, for the
poor Perl neophytes. :)

> > +
> > +sub do_bk_checks {
> > +	chdir($srctree);
> > +	my $changeset = `bk changes -r+ -k`;
> > +	chomp $changeset;
> > +	my $tag = `bk prs -h -d':TAG:' -r'$changeset'`;
> > +
> > +	printf("ChangeSet Key = '%s'\nTAG = '%s'\n", $changeset, $tag) if ($debug > 0);
> > +
> > +	if (length($tag) == 0) {
> if this imply that this is not a release tree then please write so - to
> be consistent with comment in top-level makefile.
> Thats good for poor sould like me that does not know perl.

Ok, I think I've made what's going on much more apparent in my revised
version.

> > +		# We do not have a tag at the Top of Tree, so we need to generate a localversion file
> > +		# We'll use the given $changeset as input into this.
> > +		my $localversion = Digest::MD5::md5_hex($changeset);
> > +		$localversion = substr($localversion,0,8);
> > +
> > +		printf("localversion = '%s'\n",$localversion) if ($debug > 0);
> > +
> > +		push @LOCALVERSIONS, "BK" . $localversion;
> > +
> > +	}
> > +}
> > +
> > +
> > +if ( -d "BitKeeper" ) {
> > +	my $bk = `which bk`;
> > +	chomp $bk;
> > +	if (length($bk) != 0) {
> > +		do_bk_checks();
> > +	}
> > +}
> And this part should be prepared for cvs+svn.

I was going to implement the CVS version tonight, but I can't seem to
find the bk2cvs tree (Google is failing).

I'll send an incremental patch when I do track it down, for now, I'll
reply to this with my new version.

Again, thanks for the feedback.

-- 

Ryan Anderson
  sometimes Pug Majere
