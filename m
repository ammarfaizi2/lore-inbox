Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbVCaET5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVCaET5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 23:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVCaETv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 23:19:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48359 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261954AbVCaER5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 23:17:57 -0500
Message-ID: <424B79E6.90300@pobox.com>
Date: Wed, 30 Mar 2005 23:17:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: sean <seandarcy2@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: BK snapshots removed from kernel.org?
References: <200503271414.33415.nbensa@gmx.net> <20050327210218.GA1236@ip68-4-98-123.oc.oc.cox.net> <200503281226.48146.nbensa@gmx.net> <4248258A.1060604@osdl.org> <d2fr2e$lvo$1@sea.gmane.org> <424B72CC.8030801@osdl.org>
In-Reply-To: <424B72CC.8030801@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------020601040609060906060507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020601040609060906060507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Randy.Dunlap wrote:
> sean wrote:
> 
>> Randy.Dunlap wrote:
>>
>>>
>>> Did you look in
>>> http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/old/ ?
>>>
>>
>> Yes I did.
>>
>> Latest is 2.6.12-rc1-bk2, March 26.
>>
>> None since then?
> 
> 
> I can't explain it other than "the snapshots are broken."
> All I do is look around for them, and behold, just look in
> 
> http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/
> 
> for the 2.6.11.6-bk snapshots.
> 
> It's confusing and it needs to be fixed....
> 
> Jeff, is there some way that I can help to fix this,
> with the requirement (for me) that I not be required to use BK?
> I'll munge scripts or whatever...
> but I guess that I'll also need a kernel.org account to do that.

Should hopefully just be changing get-version.pl ...

	Jeff, still catching up from trip+engagement



--------------020601040609060906060507
Content-Type: text/plain;
 name="get-version.pl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="get-version.pl"

#!/usr/bin/perl -w

use strict;
use Getopt::Std;

my (%opts, $mode, $s);

getopts('me', \%opts);

if ($opts{m}) {
	$mode = 0;
} elsif ($opts{e}) {
	$mode = 1;
} else {
	die "usage: get-version.pl [-e | -m]\n";
}

$s = <>;
chomp $s;
my @line = split(/\./, $s);

my ($kmicro, $kextra);

if ($#line == 3) {
	$kmicro = $line[2];
	$kextra = "." . $line[3];
} else {
	my @more = split(/-/, $line[2]);
	if ($#more == 1) {
		$kmicro = $more[0];
		$kextra = "-" . $more[1];
	} elsif (($#more == 0) && ($line[2] =~ /\d+/)) {
		$kmicro = $more[0];
		$kextra = "";
	} else {
		die "invalid extraversion parse";
	}
}

if ($mode) {
	$s = $kextra;
} else {
	$s = $kmicro;
}

printf("%s\n", $s) unless ($s eq "");

exit(0);



--------------020601040609060906060507
Content-Type: application/x-sh;
 name="snapshot.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="snapshot.sh"

#!/bin/sh

cd ~

export BK_LICENSE=ACCEPTED

kmajor=2
kminor=$1

date=`date '+%b%Y'`
log=~/log/snapshot-2$kminor-$date.log
bktmp=~/tmp
repo="$bktmp/linux-$kmajor.$kminor"
dontdiff=~/lib/dontdiff
snapbase="/pub/linux/kernel/v2.$kminor/snapshots"
tmpzpatch="$bktmp/patch-$kmajor.$kminor.gz"
tmppatch="$bktmp/patch-$kmajor.$kminor"
tmplog="$bktmp/patch-$kmajor.$kminor.log"
tmpkey="$bktmp/patch-$kmajor.$kminor.key"
homerepo=~/repo/linux-$kmajor.$kminor
getver=/home/jgarzik/bin/get-version.pl

#
# clean up any previous run leavings, timestamp start of this run
#
rm -rf $repo $tmppatch $tmpzpatch $tmplog $tmpkey
echo "" >> $log
echo "" >> $log
date >> $log

#
# pull updates, if any, into $homerepo. default 'bk parent' is used
#
cd $homerepo
echo pull >> $log
bk pull -q 2>&1 >> $log
bk changes -k | head -1 > $tmpkey

#
# discover most recent kernel version
#
tmptagver=`bk changes | grep 'TAG: v' | head -1 | awk '{print $2}'`
kmicro=`echo $tmptagver | $getver -m`
kextra=`echo $tmptagver | $getver -e`
kversion="$kmajor.$kminor.$kmicro$kextra"
snapdir="$snapbase"		# /$kversion
echo "found kernel version $kversion" >> $log

#
# find and destroy old snapshots, where "old" is defined as any snapshot
# for a kernel prior to the current one
#
echo "checking for old snapshots" >> $log
rm -f $bktmp/tmp*
ls $snapdir | grep patch | grep -v "$kversion" > $bktmp/tmp1
if [ -s $bktmp/tmp1 ]; then
	echo "moving old snapshots:" >> $log
	cat $bktmp/tmp1 >> $log

	( cd $snapdir ; mv `cat $bktmp/tmp1` "$snapdir/old" )
fi
rm -f $bktmp/tmp*

#
# figure out snapshot number of snapshot being created
#
snapnum=1
prevsnap=x
while [ -f "$snapdir/patch-$kversion-bk$snapnum.gz" ]
do
	prevsnap=$snapnum
	snapnum=`expr $snapnum + 1`
done
echo "creating snapshot number $snapnum, previous: $prevsnap" >> $log

snapfn="$snapdir/patch-$kversion-bk$snapnum.gz"
prevsnaplog="$snapdir/patch-$kversion-bk$prevsnap.log"
snaplog="$snapdir/patch-$kversion-bk$snapnum.log"
snapkey="$snapdir/patch-$kversion-bk$snapnum.key"

#
# see if there are any changes yet in a new kernel version
#
bk export -tpatch -h -T -du -rv$kversion, > $tmppatch
if [ ! -s "$tmppatch" ]; then
	echo "no BK-only changes yet, skipping snapshot" >> $log
	rm -rf $repo $tmppatch $tmpzpatch $tmplog $tmpkey
	exit 0
fi
rm -f $tmppatch

#
# create changelog for BK-only change,s and use that
# output as metric for deciding if this snapshot would be equal
# to the previous one
#
echo "generating change log" >> $log
bk changes -rv$kversion.. > $tmplog

if [ -f "$prevsnaplog" ]; then
	if cmp -s "$prevsnaplog" "$tmplog"
	then
		echo "no change in patches, skipping snapshot" >> $log
		rm -rf $repo $tmpzpatch $tmplog $tmpkey
		exit 0
	fi
fi

#
# create a throwaway clone, that will contain our EXTRAVERSION update
#
echo clone >> $log
bk clone -ql $homerepo $repo 2>&1 >> $log

#
# update EXTRAVERSION/SUBLEVEL
#
cd $repo
echo "hacking makefile" >> $log
bk edit -q Makefile 2>&1 >> $log
sed -e "s/^SUBLEVEL.*=.*$/SUBLEVEL = $kmicro/g" < Makefile > x
mv x Makefile
sed -e "s/^EXTRAVERSION.*=.*$/EXTRAVERSION = $kextra-bk$snapnum/g" < Makefile > x
mv x Makefile
bk delta "-yrelease bk$snapnum" -q Makefile 2>&1 >> $log
bk commit "-yrelease bk$snapnum" -q 2>&1 >> $log

#
# generate GNU patch snapshot, containing all changes past
# the point of the last released kernel
#
echo "generating and compressing patch" >> $log
bk export -tpatch -h -T -du -rv$kversion, | gzip -9c > $tmpzpatch

#
# log info about the patch, and send it out to FTP site
#
echo "patch file details:" >> $log
ls -l $tmpzpatch 2>&1 >> $log
md5sum $tmpzpatch 2>&1 >> $log

echo "moving patch and cleaning up" >> $log
mv $tmpzpatch $snapfn
mv $tmplog $snaplog
mv $tmpkey $snapkey
cd ~
rm -rf $repo
exit 0


--------------020601040609060906060507--
