Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316449AbSEOVii>; Wed, 15 May 2002 17:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316450AbSEOVig>; Wed, 15 May 2002 17:38:36 -0400
Received: from host194.steeleye.com ([216.33.1.194]:61189 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S316449AbSEOVi1>; Wed, 15 May 2002 17:38:27 -0400
Message-Id: <200205152138.g4FLcLb04842@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: Re: Changelogs on kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_19382350820"
Date: Wed, 15 May 2002 17:38:21 -0400
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_19382350820
Content-Type: text/plain; charset=us-ascii

lm@bitmover.com said:
> We've already built all the interfaces you need to do this, so would
> you be interested in writing the shell script that does it?  The
> interfaces you will want:

>         bk export -tpatch
>         bk import -tpatch
>         bk comments
>         bk changes -v

> You'll want this, I believe that you can take the output of this
> command and feed it into bk comments and have that be a noop.  If that
> works, this is what you need to save as the comments part of the
> patch, and now it's pretty trivial to move the patch backwards.

I've got a shell script which does this (I use it to take test patches from my 
build tree back to a pristine source for submission to linus).  I'm afraid 
it's a bit rough and ready, but it takes a given set of changes, wraps them up 
as patches, extracts the comments and applies them as patches to a different 
tree and then inserts the comments.  I wrote it a while ago, so it may be a 
little dusty and lacking in the newer bitkeeper features.

James



--==_Exmh_19382350820
Content-Type: text/plain ; name="bkexport"; charset=us-ascii
Content-Description: bkexport
Content-Disposition: attachment; filename="bkexport"

#!/bin/bash
#
##
# Author: James Bottomley
##
# Tool to backport from bitkeeper repositories
##
# $Id: bkexport,v 1.1 2002/03/16 15:50:50 jejb Exp $
##

usage() {
    echo "Usage: $0 {-C <change set list>|-R <repository>} <other repository>";
    exit 1;
}

tmp=/tmp/$$
tmpdiff=$tmp.diff
tmpfile=$tmp.file

if [ $# -ne 3 ]; then
    usage;
fi

case $1 in
    -C)		changeset=$2
		dir=$3;;

    -R)		changeset=`bk changes -d':REV:\n' -L $2|sort -n`
		dir=$3;;

    *)		usage;;
esac

if [ ! -d $dir ]; then
    echo "DIRECTORY $dir MUST EXIST" 2>&1
    exit 1;
fi

# get the changes

for c in $changeset; do
    echo "Applying ChangeSet $c"
    bk export -tpatch -du -r$c > $tmpdiff
    pushd $dir > /dev/null
    bk get -e `awk '/^diff/{print substr($3,3)}' < $tmpdiff`
    patch -p1 < $tmpdiff
    popd > /dev/null
    bk changes -v -n -d':GFILE: :REV:' -r$c | {
    while read file rev; do
	if [ "$file" = "ChangeSet" ]; then
	    continue
	fi
	echo "Applying change log for $file revision $rev"
	bk prs -h -d'$each(:C:){(:C:)\n}' -r$rev $file > $tmpfile
	pushd $dir > /dev/null
	bk ci -y"`cat $tmpfile`" $file
	popd > /dev/null
    done
    bk prs -h -d'$each(:C:){(:C:)\n}' -r$c ChangeSet > $tmpfile
    pushd $dir > /dev/null
    echo "Commiting ChangeSet $c"
    bk commit -d -Y$tmpfile
    popd > /dev/null
    }
done
rm -f $tmpdiff $tmpfile

--==_Exmh_19382350820--


