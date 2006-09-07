Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWIGOR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWIGOR5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 10:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWIGOR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 10:17:57 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:57984 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932165AbWIGORz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 10:17:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l5iUQoZbdGrYb60cAL54wyNUy9rZdIRWIRhBAoOupWLYyN/mQYZX9TX/bKmwSnUHe3oy6HGDF7XQw8tTUBog3LpwfS9RVPWmamt5sQ5z7nNdnlCZVgffIBkNBUaOp16yhScyP7G49+jFclMOkxZUVvmN5WvvVn+sF7TS3Z6OiuQ=
Message-ID: <9a8748490609070717q6ed9111ckdc3de025dc44938b@mail.gmail.com>
Date: Thu, 7 Sep 2006 16:17:53 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "David Chinner" <dgc@sgi.com>
Subject: Re: Wrong free space reported for XFS filesystem
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
In-Reply-To: <20060906230238.GJ5737019@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490609060154ye8730b0n16e23524010a35e4@mail.gmail.com>
	 <20060906230238.GJ5737019@melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/06, David Chinner <dgc@sgi.com> wrote:
> On Wed, Sep 06, 2006 at 10:54:34AM +0200, Jesper Juhl wrote:
> > For your information;
> >
> > I've been running a bunch of benchmarks on a 250GB XFS filesystem.
> > After the benchmarks had run for a few hours and almost filled up the
> > fs, I removed all the files and did a "df -h" with interresting
> > results :
> >
> > /dev/mapper/Data1-test
> >                     250G  -64Z  251G 101% /mnt/test
> >
> > "df -k"  reported this :
> >
> > /dev/mapper/Data1-test
> >                     262144000 -73786976294838202960 262147504 101% /mnt/test
> ....
> > The filesystem is mounted like this :
> >
> > /dev/mapper/Data1-test on /mnt/test type xfs
> > (rw,noatime,ihashsize=64433,logdev=/dev/Log1/test_log,usrquota)
>
> So the in-core accounting has underflowed by a small amount but the
> on disk accounting is correct.
>
> We've had a few reports of this that I know of over the past couple of years,
> but we've never managed to find a reproducable test case for it.
>
> Can you describe what benchmark you were runnin, wht kernel you were
> using

The kernel is 2.6.18-rc6 SMP

> and whether any of the tests hit  an ENOSPC condition?
>
That I don't know.

The script I was running is this one :

###-----[ cut here ]-----
#!/bin/bash

DIR=/mnt/test
DIR1=random
DIR2=bigfiles
DIR3=smallfiles
BONNIEDIR=bonnie
RACERDIR=racer
WRIGGLERDIR=wriggler
IOZONEDIR=iozone

cd $DIR
rm -rf -- *

mkdir $DIR1
cd $DIR1
while true; do
        cd $DIR/$DIR1
        for i in `seq 1 100`; do
                touch -- "`head --bytes 15 /dev/urandom`";
        done >/dev/null 2>&1
        find . | while read i; do mv -f -- "$i" "`head --bytes 16
/dev/urandom`"; done >/dev/null 2>&1
        rm -f -- *
        sleep 1
done >/dev/null 2>&1 &

while true; do
        cd $DIR/$DIR1
        for i in `seq 1 100`; do
                touch -- "`head --bytes 25 /dev/urandom`";
        done >/dev/null 2>&1
        find . | while read i; do mv -f -- "$i" "`head --bytes 30
/dev/urandom`"; done >/dev/null 2>&1
        rm -f -- *
        sleep 2
done >/dev/null 2>&1 &

cd $DIR
mkdir $DIR/$BONNIEDIR
mkdir $DIR/$RACERDIR
mkdir $DIR/$WRIGGLERDIR
mkdir $DIR/$IOZONEDIR
mkdir $DIR/$DIR2
mkdir $DIR/$DIR3

while true; do
(cd /usr/local/racer ; sh ./racer-lustre.sh  >/dev/null 2>&1); done
>/dev/null 2>&1 &

while true; do
        (cd $DIR/$IOZONEDIR ; /usr/local/iozone/iozone -a >/dev/null 2>&1);
done >/dev/null 2>&1 &

while true; do
        (chown nobody $DIR/$BONNIEDIR ; cd $DIR/$BONNIEDIR ;
/usr/local/bonnie++/sbin/bonnie++ -u nobody >/dev/null 2>&1);
done >/dev/null 2>&1 &

while true; do
        (cd $DIR/$WRIGGLERDIR ; /usr/local/diskWriggler/diskWriggler
-n 500 -2K -o $DIR/$WRIGGLERDIR  >/dev/null 2>&1);
done >/dev/null 2>&1 &

while true; do
        (cd $DIR/$DIR2 ; dd if=/dev/zero of=$DIR/$DIR2/biggie bs=10M
count=15000  >/dev/null 2>&1; sync ; rm -f $DIR/$DIR2/biggie );
done >/dev/null 2>&1 &

while true; do
        (cd $DIR/$DIR3 ; export SIZE=$(($RANDOM*200000/32767)) ; dd
if=/dev/urandom of=$DIR/$DIR3/$SIZE bs=2048 count=$SIZE  >/dev/null
2>&1; rm -f -- $DIR/$D
IR3/* );
done >/dev/null 2>&1 &

while true; do
        for i in `seq 60 300`; do sleep $i; sync; done ;
done >/dev/null 2>&1 &

while true; do
        for i in `seq 7 21`; do sleep $i; find $DIR; done ;
done >/dev/null 2>&1 &

while true; do date ; echo "tests running"; sleep 300; done

###-----[ cut here ]-----


/usr/local/racer/ holds this test script :
ftp://ftp.lustre.org/pub/benchmarks/racer-lustre.tar.gz
The script is modified to use /mnt/test/racer for its tests.

/usr/local/iozone/ holds iozone version 3.263

/usr/local/bonnie++/ holds bonnie++ version 1.03

/usr/local/diskWriggler/ holds diskWriggler version 1.0.1


> Also, in future can you cc xfs@oss.sgi.com on XFS bug reports?
>
I keep forgetting, sorry. I'll try harder to remember :)


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
