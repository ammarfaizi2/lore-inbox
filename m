Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315266AbSEaNUN>; Fri, 31 May 2002 09:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315267AbSEaNUM>; Fri, 31 May 2002 09:20:12 -0400
Received: from smtp01ffm.de.uu.net ([192.76.144.150]:18771 "EHLO
	smtp01ffm.de.uu.net") by vger.kernel.org with ESMTP
	id <S315266AbSEaNUM>; Fri, 31 May 2002 09:20:12 -0400
From: Roland Fehrenbacher <Roland.Fehrenbacher@transtec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15607.30844.526469.488274@transtec.de>
Date: Fri, 31 May 2002 15:19:56 +0200
To: linux-kernel@vger.kernel.org
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Seth, Rohit" <rohit.seth@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        "Hugh Dickins" <hugh@veritas.com>, pk@q-leap.com
Subject: Re: Q: backport of the free_pgtables tlb fixes to 2.4
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

we actually also ran into this bug on a dual xeon (2GHz
Prestonia) with Hyperthreading enabled. Without Hyperthreading, it was hard to
reproduce the problem. The following script (requires bash >=  2.0.5) provokes
the problem in a very short time. With the patch from Intel, the problem is
gone (patched into 2.4.18), no side effects discovered so far.

Thanks to Hugh Dickins <hugh@veritas.com> for pointing out the patch to us.

Cheers,

Roland

Here is the script:
-----------------------
#!/bin/sh

# Small script to provoke a SIGSEV on SMP machines with kernel problem
# requires bash > 2.0.5. The script fails e.g. on dual xeon systems without
# Intel patch (Message title: Illegal instruction failures fixes for 2.4.18 in # kernel mailing list, 22.5.2002).
# Script simply executes a couple of mktemp loops in the background, and tries
# to read the generated file back.
# 

# Author: Roland Fehrenbacher, rf@q-leap.com
base_out=/tmp/test-sigsev
maxprocs=5

myname=`basename $0`
pids=""
files=""

trap 'killall $myname; rm -f $files ${base_out}??????;' 0 1 2 3 15

for (( num=1; num <= $maxprocs; num++ )); do
  while true; do 
    file=`mktemp ${base_out}XXXXXX` || { echo mktemp failed; break; }
    cat $file || { echo open $file failed; break; }
    rm -f $file
  done > ${base_out}-${num}.out 2>&1 &
  pids="$pids $!"
  files="$files ${base_out}-${num}.out"
done

printf "PIDS running = $pids\n--\n"
printf "No further output should appear if no bug is present. Run script for\n"
printf "a couple of hours to be sure everything is ok. Ctrl-C to stop.\n--\n"

i=1
while true; do
  echo $i: ok >> ${base_out}-${num}.out
  for pid in $pids; do 
    ps -p $pid > /dev/null 2>&1 || \
      { echo "count = $i: Pid $pid died" >> ${base_out}-${num}.out; \
	pids=`echo $pids | sed -e s/$pid//g`; }
  done
  sleep 10
  ((i++))
done &

files="$files ${base_out}-${num}.out"

sleep 1
tail -f $files | grep "count ="

