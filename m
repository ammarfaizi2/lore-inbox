Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVDJBBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVDJBBV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 21:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVDJBBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 21:01:21 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:8312 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261172AbVDJBBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 21:01:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=EDzA4+EWHy1G9vbyMSKLeiyQ+MMYqobh0OnuZHXQpGgIaz5oA2xlukXD4NNbRi/ADVwBqfMAVmRd0pZDsOjkN0B1YX0acBAkApGcN8Sudxj7cmVbBVS0qBsjGqJEWTIiJOotR1u07ZxW9pGryVPmIrkapTsTUEsfn48GA4Nrxdo=
Message-ID: <cce9e37e05040918012ef0f7ab@mail.gmail.com>
Date: Sun, 10 Apr 2005 02:01:12 +0100
From: Phillip Lougher <phil.lougher@gmail.com>
Reply-To: Phillip Lougher <phil.lougher@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>, ross@jose.lug.udel.edu,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: Kernel SCM saga..
Cc: rddunlap@osdl.org, Phil Lougher <phillip@lougher.demon.co.uk>
In-Reply-To: <20050409025357.GA9052@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	 <20050408041341.GA8720@taniwha.stupidest.org>
	 <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
	 <20050408071720.GA23128@jose.lug.udel.edu>
	 <Pine.LNX.4.58.0504080758420.28951@ppc970.osdl.org>
	 <20050409025357.GA9052@pasky.ji.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 9, 2005 3:53 AM, Petr Baudis <pasky@ucw.cz> wrote:

>   FWIW, I made few small fixes (to prevent some trivial usage errors to
> cause cache corruption) and added scripts gitcommit.sh, gitadd.sh and
> gitlog.sh - heavily inspired by what already went through the mailing
> list. Everything is available at http://pasky.or.cz/~pasky/dev/git/
> (including .dircache, even though it isn't shown in the index), the
> cumulative patch can be found below. The scripts aim to provide some
> (obviously very interim) more high-level interface for git.

I did a bit of playing about with the changelog generate script,
trying to produce a faster version.  The attached version uses a
couple of improvements to be a lot faster (e.g. no recursion in the
common case of one parent).

FWIW it is 7x faster than makechlog.sh (4.342 secs vs 34.129 secs) and
28x faster than gitlog.sh (4.342 secs vs 2 mins 4 secs) on my
hardware.  You mileage may of course vary.

Regards

Phillip

--------------------------------------
#!/bin/sh

changelog() {
        local parents new_parent
        declare -a new_parent

        new_parent[0]=$1
        parents=1

        while [ $parents -gt 0 ]; do
                parent=${new_parent[$((parents-1))]}
                echo $parent >> $TMP
                cat-file commit $parent > $TMP_FILE

                echo me $parent
                cat $TMP_FILE
                echo -e "\n--------------------------\n"

                parents=0
                while read type text; do
                        if [ $type = 'committer' ]; then
                                break;
                        elif [ $type = 'parent' ] &&
                                        ! grep -q $text $TMP ; then
                                new_parent[$parents]=$text
                                parents=$((parents+1))
                        fi
                done < $TMP_FILE

                i=0
                while [ $i -lt $((parents-1)) ]; do
                        changelog ${new_parent[$i]}
                        i=$((i+1))
                done
        done
}

TMP=`mktemp`
TMP_FILE=`mktemp`

base=$1
if [ ! "$base" ]; then
        base=$(cat .dircache/HEAD)
fi
changelog $base
rm -rf $TMP $TMP_FILE
