Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290236AbSA3R2G>; Wed, 30 Jan 2002 12:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290235AbSA3R0q>; Wed, 30 Jan 2002 12:26:46 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:8958 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S289990AbSA3RZT>;
	Wed, 30 Jan 2002 12:25:19 -0500
Date: Wed, 30 Jan 2002 10:24:59 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        lm@bitmover.com
Subject: Re: real BK usage (was: A modest proposal -- We need a patch penguin)
Message-ID: <20020130102458.B763@lynx.adilger.int>
Mail-Followup-To: Jeff Garzik <garzik@havoc.gtf.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, lm@bitmover.com
In-Reply-To: <Pine.LNX.4.33.0201291641090.1747-100000@penguin.transmeta.com> <1012354692.1777.4.camel@stomata.megapathdsl.net> <20020130080504.JUTO18525.femail19.sdc1.sfba.home.com@there> <20020130034746.K32317@havoc.gtf.org> <a38ekv$1is$1@penguin.transmeta.com> <20020130050708.D11267@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020130050708.D11267@havoc.gtf.org>; from garzik@havoc.gtf.org on Wed, Jan 30, 2002 at 05:07:08AM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 09:33:19AM +0000, Linus Torvalds wrote:
> I still dislike some things (those SHOUTING SCCS files) in bk, and let's
> be honest: I've used CVS, but I've never really used BK. Larry has given
> me the demos, and I actually decided to re-do the examples, but it takes
> time and effort to get used to new tools, and I'm a bit worried that
> I'll find other things to hate than just those loud filenames.

Well, the one benefit of using SCCS directories (which are only 1/3
louder than CVS directories) is that tools like patch, make, ctags, emacs
(I believe), etc. already understand what they are and how to extract
the latest version of a file from there.  If these tools were changed
to also recognize .SCCS dirs, then BK could eventually follow suit, but
it would be impractical until they are widely available.*

On Jan 30, 2002  05:07 -0500, Jeff Garzik wrote:
> One issue I'm interested in, and Larry and I have chatted about this a
> couple times, is making sure that the "standard" patch flow isn't
> affected... and what I mean by that is out-of-order and/or modified
> patches.

I would have to agree.  Ted uses BK for e2fsprogs, and there have been
several times when I try to send him a CSET, but he is unable to apply
it because it is missing dependencies, even though I know those prior
CSETs are actually independent changes that just happen to touch the
same files.

It is double-plus bad when those changes are not just ones I've forgotten,
but ones that I know Ted does not want to have in his tree, or are not
in a state where I want to send them to him yet.  This makes me keep
several local repositories - pristine, changes for Ted, changes for me,
etc.  Not fatal, but not as easy as keeping a single tree and pulling
out diffs as needed.

Also, (BK feature request time) there are times when I've done a 'bk citool'
and committed a bunch of changes into a CSET, and later on done some more
testing which revealed a bug or found that I'd forgotten to change the
man page to track the changes I made.  I'd much rather be able to merge
some more changes into the same CSET instead of creating a second CSET and
now have two CSETs to ship around for what is logically a single change.**

I think it would quickly become a nightmare if you had to submit (and
have accepted!) all of your changes to Linus IN ORDER.  As it stands now,
there are lots of discrete changes I have in my ext2 tree, and whenever
I get around to it or when people hit the same bug as me I generate a
patch, edit out the irrelevant parts, and send it out.***

Granted, it is hard to keep distributed BK repositories consistent if you
apply patches out of order, but at the same time, this is how development
works in real life.  Two solutions I can see to this:

1) Allow out-of-order CSET application (maybe with some sort of warning
   that Linus can turn off, because _every_ CSET he would get would be
   missing dependencies from somebody's tree).
2) Allow "proxy" CSETs to be included which say "the changes from adilger
   adilger@lynx.adilger.int|ChangeSet|20011226061040|56205 changed lines
   X-Y, Z of file fs/ext2/super.c" but doesn't actually contain those
   changes, so that the CSET dependency graph is still kept intact.  The
   proxies would clearly be marked as such in the repository.  You would
   (at proxy CSET creation time) validate that these proxies in fact DO NOT
   change any of the same lines that the later CSET changes (saves you from
   sending a patch that won't merge).  Later on, you can really send those
   CSETs to replace the proxies, or if there are conflicting changes in
   the upstream tree it is up to you to resolve them.

> Obviously this wouldn't apply if you fed BK patches into GNU patch, and
> then issued the commit from there...  but that way is a bit lossy, since
> you would need to recreate rename information among other things.

It would also lose the BK CSET identification, which would tell the
original submitter (and his local repository) that the patch was applied,
and when Linus sent out new patches/CSETs, the original submitter would
have to manually resolve these conflicts each time.  Maybe if BK had a
feature like patch, which says 'It appears that the changes in this CSET
have already been applied in <foo>, let's use <foo> instead'.

Cheers, Andreas

(*)  Larry, time to submit patches now so we can use BK for 2.7 ;-)
(**) Maybe I just don't know enough about how to use BK.  There are also
     a lot of distributed database issues involved of which I'm unaware.
(***)Maybe this is just another manifestation of fixes getting lost
     because they need a lot of attention to get into the kernel.
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

