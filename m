Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292476AbSBZRzB>; Tue, 26 Feb 2002 12:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292485AbSBZRyw>; Tue, 26 Feb 2002 12:54:52 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:9201 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S292478AbSBZRyg>;
	Tue, 26 Feb 2002 12:54:36 -0500
Date: Tue, 26 Feb 2002 10:54:06 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Martin Dalecki <dalecki@evision-ventures.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020226105406.I12832@lynx.adilger.int>
Mail-Followup-To: Martin Dalecki <dalecki@evision-ventures.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <fa.n4lfl6v.h4chor@ifi.uio.no> <05cb01c1be1e$c490ba00$1a01a8c0@allyourbase> <20020225172048.GV20060@matchmail.com> <02022518330103.01161@grumpersII> <a5f7s4$2o1$1@cesium.transmeta.com> <20020226160544.GD4393@matchmail.com> <3C7BB9A3.30408@evision-ventures.com> <20020226164316.GH4393@matchmail.com> <3C7BBDE2.8050207@evision-ventures.com> <20020226170520.GJ4393@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020226170520.GJ4393@matchmail.com>; from mfedyk@matchmail.com on Tue, Feb 26, 2002 at 09:05:20AM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 26, 2002  09:05 -0800, Mike Fedyk wrote:
> On Tue, Feb 26, 2002 at 05:54:58PM +0100, Martin Dalecki wrote:
> > For the educated user it was always a pain
> > in the you know where, to constantly run out of quota space due to
> > file versioning.
> 
> Ahh, so we'd need to chown the files to root (or a configurable user and
> group) to get around the quota issue.

Well, I don't agree with changing file ownership, because _any_ way around
the quota system will be exploited by users (e.g. deleting files temporarily
to gain more space, and hope they aren't destroyed before they need them
again).  It also opens a huge can of worms security wise, because it may
be possible for one user to undelete files belonging to another user if
you are not super careful.

No, I would have the unlink wrapper/daemon be quota-aware, and if a user
is getting close to filling their quota then it would delete more of that
user's files from the undelete directory, just as if the entire fs was
getting full or the user had hit their preconfigured limit for maximum
undelete size or versions of a file.  Since the unlink call will never
_increase_ the amount of disk used by a user (it is simply a rename()
in disguise) this in itself can't be the cause a quota problem.

The only potential problem would be if the cleanup daemon dies.  In that
case, a user should still be able to do something like "unrm --purge" to
manually clean up his files in the undelete tree (or "unrm -ls <filespec>"
to show files and "unrm -d <file...>" to really delete individual ones).

For people who don't want to have undelete at all (for whatever reason)
can always have something like "max_undelete=0" in their .unrmrc file,
or just not use it in the first place.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

