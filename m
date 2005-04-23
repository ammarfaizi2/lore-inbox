Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVDWOWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVDWOWc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 10:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVDWOWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 10:22:32 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20445 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261594AbVDWOW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 10:22:27 -0400
Subject: Re: Git-commits mailing list feed.
From: David Woodhouse <dwmw2@infradead.org>
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <426A4669.7080500@ppp0.net>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>
	 <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>
	 <426A4669.7080500@ppp0.net>
Content-Type: text/plain
Date: Sun, 24 Apr 2005 00:21:22 +1000
Message-Id: <1114266083.3419.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.3 (/)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (0.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 UPPERCASE_25_50        message body is 25-50% uppercase
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-23 at 14:58 +0200, Jan Dittmer wrote:
> I didn't found above mentioned post, so I hacked up a cruel script
> myself. It relies on ketchup (www.selenic.com/ketchup)
> to retrieve the current base version. Also it requires git's
> `checkout-cache --prefix=` to work properly.

Thanks... but it seems a little excessive. I was thinking of something
much simpler; along the lines of...

#!/bin/sh

STAGE=/staging/dwmw2/git

cd /home/dwmw2/git/snapshot-2.6

git pull || exit 1

LASTRELEASE=`ls -rt .git/tags | grep -v git | grep -v MailDone | tail -1`
LASTTAG=`ls -rt .git/tags | grep -v MailDone | tail -1`

CURCOMMIT=`commit-id`
LASTCOMMIT=`cat .git/tags/$LASTTAG`
RELCOMMIT=`cat .git/tags/$LASTRELEASE`

[ "$LASTCOMMIT" = "$CURCOMMIT" ] && exit 0

CURTREE=`tree-id $CURCOMMIT`
#LASTTREE=`tree-id $LASTCOMMIT`
RELTREE=`tree-id $RELCOMMIT`

if echo $LASTTAG | grep -q -- -git ; then
	OLDGITNUM=`echo $LASTTAG | sed s/^.*-git//`
	NEWGITNUM=`expr $OLDGITNUM + 1`
	NEWTAG=`echo $LASTTAG | sed s/-git$OLDGITNUM/-git$NEWGITNUM/`
else
	NEWTAG=$LASTTAG-git1
fi

echo $commit-id > $STAGE/$NEWTAG.id
# This is, unfortunately, in chronological order. Walking the tree would
# be better.
git log $CURCOMMIT ^$RELCOMMIT > $STAGE/$NEWTAG.log
git diff -r $RELTREE -r $CURTREE | gzip -9 > $STAGE/patch-$NEWTAG.gz

echo $CURCOMMIT > .git/tags/$NEWTAG


-- 
dwmw2

