Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265276AbTBRAKF>; Mon, 17 Feb 2003 19:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266936AbTBRAKF>; Mon, 17 Feb 2003 19:10:05 -0500
Received: from 12-211-138-234.client.attbi.com ([12.211.138.234]:64347 "EHLO
	vlad.geekizoid.com") by vger.kernel.org with ESMTP
	id <S265276AbTBRAKD>; Mon, 17 Feb 2003 19:10:03 -0500
Reply-To: <vlad@geekizoid.com>
From: "Vlad@geekizoid.com" <vlad@geekizoid.com>
To: "'Pavel Machek'" <pavel@suse.cz>, "'Larry McVoy'" <lm@work.bitmover.com>,
       "'Nicolas Pitre'" <nico@cam.org>, "'Larry McVoy'" <lm@bitmover.com>,
       "'lkml'" <linux-kernel@vger.kernel.org>
Subject: RE: bk2cvs [was Re: openbkweb-0.0]
Date: Mon, 17 Feb 2003 18:19:43 -0600
Message-ID: <006901c2d6e3$6fd36380$0200a8c0@wsl3>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <20030216225637.GE2546@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LRSE Hosting (me) will not participate in anything that doesn't have Larry
McVoy's full endorsement.

Sorry Pavel for the repeat message, I forgot to include everyone the first
time I sent this out.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Pavel Machek
Sent: Sunday, February 16, 2003 4:57 PM
To: Larry McVoy; Nicolas Pitre; Larry McVoy; lkml
Subject: bk2cvs [was Re: openbkweb-0.0]


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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

