Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291309AbSBMCMW>; Tue, 12 Feb 2002 21:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291310AbSBMCMN>; Tue, 12 Feb 2002 21:12:13 -0500
Received: from [63.231.122.81] ([63.231.122.81]:37206 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S291309AbSBMCLz>;
	Tue, 12 Feb 2002 21:11:55 -0500
Date: Tue, 12 Feb 2002 19:08:34 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Larry McVoy <lm@bitmover.com>, Ingo Molnar <mingo@elte.hu>,
        Tom Rini <trini@kernel.crashing.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020212190834.W9826@lynx.turbolabs.com>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Larry McVoy <lm@bitmover.com>, Ingo Molnar <mingo@elte.hu>,
	Tom Rini <trini@kernel.crashing.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Alexander Viro <viro@math.psu.edu>,
	Rob Landley <landley@trommello.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020130092529.O23269@work.bitmover.com> <Pine.LNX.4.33L.0202122058150.12554-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33L.0202122058150.12554-100000@imladris.surriel.com>; from riel@conectiva.com.br on Tue, Feb 12, 2002 at 08:59:34PM -0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 12, 2002  20:59 -0200, Rik van Riel wrote:
> On Wed, 30 Jan 2002, Larry McVoy wrote:
> > and then you added one change below that, multiple times.  If you were to
> > combine all of those changes in a BK tree, it would look like
> >
> > 			[older changes]
> > 			      v
> > 			  [2.5.3-pre4]
> > 			      v
> > 			  [2.5.3-pre5]
> >   [sched1] [sched2] [sched3] [sched4] [sched5] [sched6] [sched7]
> 
> I'm porting rmap to 2.5 now, doing just this.
> 
> One thing I noticed was that the space usage of all the
> bk trees I'm using in order to keep the different changes
> individually pullable is about 1.5 GB now.

Is this using "bk clone -l" or just "bk clone"?  I would _imagine_
that since the rmap changes are fairly localized that you would only
get multiple copies of a limited number of files, and it wouldn't
increase the size of each repository very much.

As Larry mentioned, you could re-merge these trees.  The following script
will probably be enough, since we don't want/need to compare all files
in each tree, only SCCS and BitKeeper files that are in the same place
in the heirarchy.  Very lightly tested - Larry will have to tell me if
it is OK to hard-link everything in SCCS and BitKeeper repositories,
or if there are some files that should be ignored.

On my e2fsprogs tree, it takes 12s to relink a clone to its parent,
saving 12/19MB = 63% reduction in space per clone.

Cheers, Andreas
=========================== bkrelink =====================================
#!/bin/sh
# A script to relink files in BitKeeper repositories if they were not
# created with "bk clone -l" or if the same changes were made to both
# repositories.
#
# Andreas Dilger <adilger@turbolabs.com>  02/12/2002

PROG=bkrelink

usage() {
	echo "usage: $PROG <parent BK tree> <clone BK tree>" 1>&2 && exit 1
}

[ $# -ne 2 ] && usage
[ ! -d "$1/BitKeeper" ] && usage
[ ! -d "$2/BitKeeper" ] && usage

PTREE=$1
CTREE=$2

#DEBUG=1
say() {
	[ "$DEBUG" ] && echo "$*"
	return 0
}

do_link() {
	echo "$PROG: hard-linking $2 to $1"
	ln -f $1 $2
}

# We need to do some ugly things with the find processes to keep the relative
# paths correct in each tree.  Likewise, | read will run in a separate process
# so we need to do the checks in a subshell so all the stat fields are set.
(cd $CTREE
say "$PROG: finding in $CTREE" 1>&2
find . -type d \( -name BitKeeper -o -name SCCS \) ) | while read DIR; do
(cd $CTREE/$DIR
say "$PROG: looking in $CTREE/$DIR" 1>&2
find . -type f ) | while read FILE; do
 	PFILE=$PTREE/$DIR/$FILE
 	CFILE=$CTREE/$DIR/$FILE

	say "$PROG: checking $CFILE, $PFILE"

	[ ! -f "$PFILE" ] && say "$PROG: $PFILE not found" && continue
	[ ! -f "$CFILE" ] && say "$PROG: $CFILE not found" && continue

	[ "$DEBUG" ] && stat -t $PFILE && stat -t $CFILE
	stat -t $PFILE | { read JNK PSZ JNK JNK PUSR PGRP PDEV PINO PLINK JNK
	stat -t $CFILE | { read JNK CSZ JNK JNK CUSR CGRP CDEV CINO CLINK JNK

	# do the easy test (size compare) first
	[ $CSZ != $PSZ ] && say "size mismatch: $CSZ != $PSZ" && continue
	# can't hard link across devices
	[ $CDEV != $PDEV ] && say "dev mismatch: $CDEV != $PDEV" && continue
	# already hard linked (same device number, same inode numer)
	[ $CINO == $PINO ] && say "ino match: $CINO == $PINO" && continue
	[ $CUSR != $PUSR ] && say "user mismatch: $CUSR != $PUSR" && continue
	[ $CGRP != $PGRP ] && say "group mismatch: $CGRP != $PGRP" && continue

	#echo "$PROG: comparing $CFILE, $PFILE"

	cmp --quiet $CFILE $PFILE || continue

	# We try to have only a single target against which we link.
	# If in doubt, move links towards the specified parent.
	if [ $CLINK -eq 1 ]; then
		do_link $PFILE $CFILE
	elif [ $PLINK -eq 1 ]; then
		do_link $CFILE $PFILE
	else
		do_link $PFILE $CFILE
	fi
	}
	}
done
done
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

