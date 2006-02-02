Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWBBUqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWBBUqY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 15:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWBBUqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 15:46:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9489 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932233AbWBBUqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 15:46:23 -0500
Date: Thu, 2 Feb 2006 21:48:42 +0100
From: Jens Axboe <axboe@suse.de>
To: Dave Airlie <airlied@linux.ie>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [git pull] drm patches for 2.6.16
Message-ID: <20060202204842.GK4215@suse.de>
References: <Pine.LNX.4.58.0602020913460.19173@skynet> <Pine.LNX.4.64.0602020749510.21884@g5.osdl.org> <Pine.LNX.4.58.0602022037360.3377@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0602022037360.3377@skynet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02 2006, Dave Airlie wrote:
> 
> > >
> > > commit 30e2fb188194908e48d3f27a53ccea6740eb1e98
> > > Author: Dave Airlie <airlied@starflyer.(none)>
> > > Date:   Thu Feb 2 19:37:46 2006 +1100
> > >
> > >     sem2mutex: drivers/char/drm/
> > >
> > >     From: Arjan van de Ven <arjan@infradead.org>
> >
> > A lot of your commits have this structure.
> >
> > What do you use to apply these emails? It _looks_ like the emails are
> > well-behaved ("From:" at the top), yet your Author: information is wrong
> > and whatever script you used to do it missed it.
> >
> > 		Linus
> >
> 
> I mostly apply the patches + any cleanups (most of the patches I get from
> DRM CVS needs whitespace cleanups - damn X hackers) so I usually just
> write the commit message by hand from the mail when I check the stuff in,
> 
> I don't know of any way when doing hand commits to easily change the
> author without messing with environment variables...

I have a set of really cheasy ag-* git scripts to help with this sort of
thing. This is ag-commit. If you just do ag-commit, it'll use the
defined author/committer. If I need to commit a patch that eg Linus did
(hah, fat chance!), I'll just do ag-commit -a "Linus Torvalds
<torvalds@osdl.org>". -c is for committer (which I never ended up using,
since that's always me), and you can write the changelog up front as
changelog.txt if you choose (which I never ended up using either).

I'm sure there are better ways, but it works fine for me.


#!/bin/bash

TEMP=`getopt -o a:c: --long a-long:,c-long:: -- "$@"`
eval set -- "$TEMP"

AUTHOR="Jens Axboe"
AUTHOR_EMAIL="axboe@suse.de"
COMMITTER="Jens Axboe"
COMMITTER_EMAIL="axboe@suse.de"

while true; do
	case "$1" in
		-a|--a-long)
			AUTHOR=`echo $2 | cut -d '<' -f 1`
			AUTHOR_EMAIL=`echo $2 | cut -d '<' -f 2 | sed s/">"//g`
			shift 2;;
		-c|--c-long)
			COMMITTER=`echo $2 | cut -d '<' -f 1`
			COMMITTER_EMAIL=`echo $2 | cut -d '<' -f 2 | sed s/">"//g`
			shift 2;;
		--) shift; break;;
		*) echo "error"; exit 1;;
	esac
done

if [ x"$AUTHOR" == 'x' ]; then
	echo bad author
	exit 1
fi
if [ x"$AUTHOR_EMAIL" == 'x' ]; then
	echo bad author email
	exit 1
fi
if [ x"$COMMITTER" == 'x' ]; then
	echo bad committer
	exit 1
fi
if [ x"$COMMITTER_EMAIL" == 'x' ]; then
	echo bad commiter email
	exit 1
fi

GIT_AUTHOR_NAME="$AUTHOR"
GIT_AUTHOR_EMAIL="$AUTHOR_EMAIL"
GIT_COMMITTER_NAME="$COMMITTER"
GIT_COMMITTER_EMAIL="$COMMITTER_EMAIL"

export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL

echo "Committing: $GIT_AUTHOR_NAME/$GIT_AUTHOR_EMAIL, $GIT_COMMITTER_NAME/$GIT_COMMITTER_EMAIL"

#git-commit-tree `git-write-tree` -p $(cat .git/HEAD) < changelog.txt > .git/HEAD

if [ -f changelog.txt ]; then
	git commit -m changelog.txt
	rm -rf changelog.txt
else
	git commit
fi

unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL

-- 
Jens Axboe

