Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267741AbTBQXeS>; Mon, 17 Feb 2003 18:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267739AbTBQXdQ>; Mon, 17 Feb 2003 18:33:16 -0500
Received: from [195.39.17.254] ([195.39.17.254]:2308 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267719AbTBQXcZ>;
	Mon, 17 Feb 2003 18:32:25 -0500
Date: Sun, 16 Feb 2003 23:56:37 +0100
From: Pavel Machek <pavel@suse.cz>
To: Larry McVoy <lm@work.bitmover.com>, Nicolas Pitre <nico@cam.org>,
       Larry McVoy <lm@bitmover.com>, lkml <linux-kernel@vger.kernel.org>
Subject: bk2cvs [was Re: openbkweb-0.0]
Message-ID: <20030216225637.GE2546@elf.ucw.cz>
References: <20030214235724.GA24139@work.bitmover.com> <Pine.LNX.4.44.0302151207390.13273-100000@xanadu.home> <20030215181211.GA12315@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030215181211.GA12315@work.bitmover.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> All of this sounds great and is exactly what is already the plan.
> There is one missing item.  A consensus in the community that if we
> provide BK, the CVS mirror, bkbits hosting, in return the community
> agrees to leave off using BK to copy BK.
> 
> If what is being asked of us is more free service and engineering and
> we are getting nothing in return, that's a non-starter.

This might help you with engineering, and sourceforge.net is willing
to provide you the bandwidth. If you create an account on sf.net, I
can easily add you to the linux25 project.

Oh, and I believe we do not need exactly Larry for this, just someone
who uses bk anyway and is willing to supervise the scripts. [I'm
mostly on modem, and often go away for > week.]
								Pavel

[all2cvs script]
#!/bin/bash
A=$1
while [ $A -lt $2 ]; do
	A=$[$A+1]
	if [ ! -e ../data/1.$A ]; then
	    echo "Patch $A does not exist"
	    exit 1
	fi
	echo "Processing patch $A"
	../scripts/diff2cvs ../data/1.$A
	mv  ../data/1.$A  ../olddata/1.$A
	echo "Done processing $A"
	if [ -e ../data/STOP ]; then
		echo "Stopped at user request after $A"
		echo "Stopped at user request after $A" > ../data/STOP
		exit 1
	fi

	I=1; while [ $I -lt 50000 ]; do I=$[$I+1]; done
done
[bk2all]
#!/bin/bash
cd /home/riel/bk-kernel/linux-2.5
A=$1
while [ $A -lt $2 ]; do
	PREV=$A
	A=$[$A+1]

	echo "Processing patch $A"
	bk export -tpatch -r1.$PREV,1.$A > ~/bkdata/1.$A
done
[diff2cvs]
#!/bin/bash

fake() {
	eval $1
}

dir() {
	while [ ! -d $1 ]; do
		DIR=$1
		OLDDIR=foo
		while [ $OLDDIR != $DIR ]; do
			mkdir $DIR && fake "cvs add $DIR"
			OLDDIR=$DIR
			DIR=${DIR%/*}
		done
	done		
}

cat $1 | grep '^+++ ' | grep -v "/dev/null" | (
	while true; do
		read A B C || break
		FILE=${B#*/}
		if [ ! -e $FILE ]; then
			touch $FILE || dir ${FILE%/*}
			touch $FILE || echo "Could not create $FILE"
			touch $FILE || exit 1
			fake "cvs add -ko $FILE"
		fi
	done
)
cat $1 | patch -Esp1 || exit 3

cat $1 | grep '^--- ' | grep -v "/dev/null" | (
	while true; do
		read A B C || break
		FILE=${B#*/}
		if [ ! -e $FILE ]; then
			fake "cvs remove $FILE"
		fi
	done
)

cat $1 | grep '^#' > /tmp/delme.diff2cvs

fake "cvs -z 3 commit -F /tmp/delme.diff2cvs ."







-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
