Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265630AbUAKBDT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 20:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265634AbUAKBDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 20:03:19 -0500
Received: from pat.uio.no ([129.240.130.16]:48601 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S265630AbUAKBDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 20:03:10 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Increase recursive symlink limit from 5 to 8
References: <E1AeMqJ-00022k-00@minerva.hungry.com>
From: Petter Reinholdtsen <pere@hungry.com>
Date: 11 Jan 2004 02:03:01 +0100
In-Reply-To: <E1AeMqJ-00022k-00@minerva.hungry.com>
Message-ID: <2flllofnvp6.fsf@saruman.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.9, required 12,
	BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Petter Reinholdtsen]
> The comment in do_follow_link() do not match the code.  The comment
> explain that the limit for recursive symlinks are 8, but the code
> limit it to 5.  This is the current comment:

Hm, I wrote the following test script to test the current limit on
different unixes, and was surprised by the differences.  And, my
previous claim that RedHat must have increased this limit was wrong.
The test on RedHat showed that it had the same limit as Debian.  Not
sure why the symlinks in question seemed to be working on RedHat.

  Linux:         Symlink limit seem to be 6 path entities.
  AIX:           Symlink limit seem to be 21 path entities.
  HP-UX:         Symlink limit seem to be 21 path entities.
  Solaris:       Symlink limit seem to be 21 path entities.
  Irix:          Symlink limit seem to be 31 path entities.
  Mac OS X:      Symlink limit seem to be 33 path entities.
  Tru64 Unix:    Symlink limit seem to be 65 path entities.

I really think this limit should be increased in Linux.  Not sure how
high it should go, but from 5 to somewhere between 20 and 64 seem like
a good idea to me.

Petri Koistinen suggested that I sent my patch to
<URL:http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/>.
I'll do that, replacing 5 with 64 instead of 8.  No need to have any
lower limit than Tru64 Unix, I figure.

This is the test program I used:

#!/bin/sh
#
# Author: Petter Reinholdtsen
# Date:   2004-01-11
#
# Script to detect the kernels "recursive" symlink limit.  This seem
# to differ from Unix to Unix, and from version to version.

TMPDIR=test

error() {
    echo $1
    exit 1
}

mkdir $TMPDIR || error "Unable to create $TMPDIR/"
(
    cd $TMPDIR
    for limit in `seq 1 10`; do
	last=foo
	echo "Limit $limit" > foo
	for n in `seq  $limit` ; do
	    ln -s $last $n
	    last="$n"
	done
	cat $last > /dev/null 2>&1 || error "Symlink limit seem to be $limit path entities."
	for n in `seq  $limit` ; do
	    rm $n
	done
    done
)
rm -rf $TMPDIR
