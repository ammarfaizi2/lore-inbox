Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317373AbSGXQHh>; Wed, 24 Jul 2002 12:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317388AbSGXQHh>; Wed, 24 Jul 2002 12:07:37 -0400
Received: from [195.39.17.254] ([195.39.17.254]:12928 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317373AbSGXQHf>;
	Wed, 24 Jul 2002 12:07:35 -0400
Date: Wed, 24 Jul 2002 18:09:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: ANNOUNCE: bitkeeper to CVS gateway
Message-ID: <20020724160941.GA8180@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've created some scripts usefull for doing bitkeeper 2 cvs
gateway. I'm currently running them on nl.linux.org (as you can see
from the close look). I have not yet figured out how to export
resulting CVS to the world.

[These scripts are in CVS at www.sf.net/projects/linux25.]

Hopefully this will be usefull to someone...
							Pavel

bk2all:

#!/bin/bash
cd /home/riel/bk-kernel/linux-2.5
A=$1
while [ $A -lt $2 ]; do
	PREV=$A
	A=$[$A+1]

	echo "Processing patch $A"
	bk export -tpatch -r1.$PREV,1.$A > ~/bkdata/1.$A
done

diff2cvs:

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

all2cvs:

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

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
