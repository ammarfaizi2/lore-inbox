Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290536AbSA3UER>; Wed, 30 Jan 2002 15:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290535AbSA3UD7>; Wed, 30 Jan 2002 15:03:59 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:32750 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S290528AbSA3UDz>;
	Wed, 30 Jan 2002 15:03:55 -0500
Date: Wed, 30 Jan 2002 13:03:19 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Larry McVoy <lm@work.bitmover.com>, Jeff Garzik <garzik@havoc.gtf.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        lm@bitmover.com
Subject: Re: real BK usage (was: A modest proposal -- We need a patch penguin)
Message-ID: <20020130130319.G763@lynx.adilger.int>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <garzik@havoc.gtf.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, lm@bitmover.com
In-Reply-To: <Pine.LNX.4.33.0201291641090.1747-100000@penguin.transmeta.com> <1012354692.1777.4.camel@stomata.megapathdsl.net> <20020130080504.JUTO18525.femail19.sdc1.sfba.home.com@there> <20020130034746.K32317@havoc.gtf.org> <a38ekv$1is$1@penguin.transmeta.com> <20020130050708.D11267@havoc.gtf.org> <20020130102458.B763@lynx.adilger.int> <20020130093459.P23269@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020130093459.P23269@work.bitmover.com>; from lm@bitmover.com on Wed, Jan 30, 2002 at 09:34:59AM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 30, 2002  09:34 -0800, Larry McVoy wrote:
> On Wed, Jan 30, 2002 at 10:24:59AM -0700, Andreas Dilger wrote:
> > Well, the one benefit of using SCCS directories (which are only 1/3
> > louder than CVS directories) is that tools like patch, make, ctags, emacs
> > (I believe), etc. already understand what they are and how to extract
> > the latest version of a file from there.  
> 
> Yup, I like 'em for that reason as well.  And you can do a
> 
> 	bk clean # removes all non-modified working files
> 	ls	 # should see nothing but SCCS/
> 
> to clean up all that extra cruft that invariably winds up in your tree.

OK, so how about adding (optional) .SCCS and .BitKeeper support to BK
for those that care about the "cleanliness" of the tree?

> > I would have to agree.  Ted uses BK for e2fsprogs, and there have been
> > several times when I try to send him a CSET, but he is unable to apply
> > it because it is missing dependencies, even though I know those prior
> > CSETs are actually independent changes that just happen to touch the
> > same files.
> 
> Please see the response to Ingo and see if you could do what I suggested
> there.  I believe that would work fine, if not, let me know.

Yes, technically it works fine, but practically not.  For example, I want
to test _all_ of the changes I make, and to test them each individually
is a lot of work.  Putting them all in the same tree, and testing them
as a group is a lot less work.  More importantly, this is how people do
their work in real life, so we don't want to change how people work to
fit the tool, but vice versa.

> > Also, (BK feature request time) there are times when I've done a 'bk citool'
> > and committed a bunch of changes into a CSET, and later on done some more
> > testing which revealed a bug or found that I'd forgotten to change the
> > man page to track the changes I made.  I'd much rather be able to merge
> > some more changes into the same CSET instead of creating a second CSET and
> > now have two CSETs to ship around for what is logically a single change.**
> 
> In the next release, there is a "bk fix -c" that does what you want.  It
> reedits the entire changeset, and preserves all your checkin comments. 
> You don't want to use this if the changeset has propogated out of your
> tree, but I use it all the time for exactly the situation you describe
> above.  It will be in bk-2.1.4.

Yes, I had thought about the CSET propogation issue also, but in my cases
it is generally not an issue.  If the CSET got a different version/ID than
the original, it would help avoid such issues also.

I suppose the parallel (if 'bk fix -c' doesn't allow it) would be to allow
splitting a CSET into smaller parts, so in case you committed two unrelated
changes to a single CSET (i.e. overzealousness in the 'bk citool' window),
you could unmerge them for separate inclusion if needed.

> > I think it would quickly become a nightmare if you had to submit (and
> > have accepted!) all of your changes to Linus IN ORDER.  As it stands now,
> > there are lots of discrete changes I have in my ext2 tree, and whenever
> > I get around to it or when people hit the same bug as me I generate a
> > patch, edit out the irrelevant parts, and send it out.***
> 
> Yeah, we know.  Read the other mails and tell me if you think that the 
> false dependency remove largely fixes this, somewhat fixes it, or doesn't
> help.

Yes, it is mostly the false dependency issue at work.  While avoiding this
on a per-file basis is a start, you really need to avoid it on a per-line
basis.

> > 2) Allow "proxy" CSETs to be included which say "the changes from adilger
> >    adilger@lynx.adilger.int|ChangeSet|20011226061040|56205 changed lines
> >    X-Y, Z of file fs/ext2/super.c" but doesn't actually contain those
> >    changes, so that the CSET dependency graph is still kept intact.  
> 
> In other words, "proxy" == "place holder".

Yes.

> This is doable but it makes synchronizing repositories quite a bit more
> complex.  I.e., if I pull from you and I have place holders and you have
> the real thing, should I get 'em or not?

I would say yes, always.  In my (limited) BK experience, when I pull I
generally want to get everything, and I push/send only specific things.
The proxies would only be needed if you didn't want everything.

> If the answer is always "or not", then this is a doable thing.  We'd
> need to modify the "bk takepatch" code path to do the right thing when
> given the real patch but that's doable as well.  Interesting idea, we
> could do this and it would be relatively fast to do, like a week or two.

Yes, the good thing about the proxy CSET idea is that it allows the
reciever to avoid the actual out-of-order patch application problems,
and still keeps the knowledge about per-line changes to a file.

As for what would happen when someone changes the lines that a proxy CSET
refers to, I would imagine that it would be like a merge where all of the
potential changes from the proxy are discarded.

> > It would also lose the BK CSET identification, which would tell the
> > original submitter (and his local repository) that the patch was applied,
> 
> We wouldn't lose it, we'd have to add some extra state to say it is in there
> but only as a placeholder, so keep bugging Linus.

This is out of context.  This was referring to applying CSETs as regular
patches, and is unrelated to the proxy CSET idea.

The mere fact that a proxy CSET might be visible (with submitter
identification) would be useful.  Some people might use the real CSETs
instead of the proxies (ala developing against -dj or -ac kernels instead
of -linus kernels) and it wouldn't introduce extra conflicts/merges later.
If they actually needed what Linus had as a proxy CSET, then it would be
grounds for merging that proxy for real.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

