Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbUAOGjf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 01:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbUAOGjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 01:39:35 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:37254 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262041AbUAOGjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 01:39:32 -0500
Message-ID: <40063583.3000000@labs.fujitsu.com>
Date: Thu, 15 Jan 2004 15:38:59 +0900
From: Tsuchiya Yoshihiro <tsuchiya@labs.fujitsu.com>
Reply-To: tsuchiya@labs.fujitsu.com
Organization: Fujitsu Labs
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, dlion2004@sina.com.cn,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: filesystem bug?
References: <3FDD7DFD.7020306@labs.fujitsu.com>	 <1071582242.5462.1.camel@sisko.scot.redhat.com> <3FDF7BE0.205@jpl.nasa.gov>		 <3FDF95EB.2080903@labs.fujitsu.com> <3FE0E5C6.5040008@labs.fujitsu.com>	 <1071782986.3666.323.camel@sisko.scot.redhat.com>	 <3FE62999.90309@labs.fujitsu.com>  <3FE67362.2070704@labs.fujitsu.com> <1072094621.1967.6.camel@sisko.scot.redhat.com> <3FE8F079.7010906@labs.fujitsu.com> <3FEA1C91.2010302@labs.fujitsu.com>
In-Reply-To: <3FEA1C91.2010302@labs.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I tried ramdisk again with more running process, and the script failed very
early just like Mr Dlion reported previously. It is about 20 minutes on 
my machines.

1. The script use nvi-1.79 tar ball
2. Prepare 64MB ramdisk, and mkfs on it.
3. edit the first three lines and run the script below(its name is xc-1.2)
4. wait half an hour and see the result will be in /tmp/xcresult

Thanks,
Yoshi
--------------------------------
#!/bin/bash

TARGETPREFIX=/mnt/foo   # filesystem that will be tested
#MOZSRC=/home/tsuchiya/src/mozilla-source-1.3.tar.gz    # tgz used for test
MOZSRC=/home/tsuchiya/src/nvi-1.79.tar.gz       # tgz used for test
RDIR="/tmp/xcresult"    # result directory
#SOURCE=mozilla
SOURCE=nvi-1.79

ERRORF=$RDIR/ERROR
INOFILE=$RDIR/INOF

touch $ERRORF

function _xtract+compare {
        echo "extracting directory to be compared against for $1"
        TARGETDIR=$TARGETPREFIX/$1
        mkdir -p $TARGETDIR
        cd $TARGETDIR
        tar zxf $MOZSRC
        echo "$1 done .... now the job is started."
# new
#       touch $INOFILE
        pwd >> $INOFILE-$1
        ls -lid $SOURCE >> $INOFILE-$1

        RESULTS=$RDIR/$1
        echo "test result will be stored under $RESULTS"
        mkdir -p $RESULTS;
#       echo "test dir is $TARGETDIR";
        mkdir -p $TARGETDIR;

        for ((i=0; i < 100000; i++))    # ext2/3 limit 32000
        do

                cd $TARGETDIR
                mkdir $TARGETDIR/dirXC$i
                cd $TARGETDIR/dirXC$i > $RDIR/CD-ERR-$1 2>&1

                if [ -s $RDIR/CD-ERR-$1 ]
                then
                        echo "something wrong happened at $1:$i-th trial "
                        df > $RDIR/DF-$1
                        exit;
                fi

                tar zxf $MOZSRC >> $ERRORF

#                echo "test dir for $TARGETDIR" >> $INOFILE-$1
                ls -lid $SOURCE >> $INOFILE-$1

                diff -rq $TARGETDIR/$SOURCE $TARGETDIR/dirXC$i/$SOURCE > 
$RESULT
S/dirXC$i.result 2>&1
                DIFFSIZE=`ls -l $RESULTS/dirXC$i.result | awk '{print $5}'`
                if [ $DIFFSIZE != 0 ];
                then
                        echo "something wrong happened at $1:$i-th trial "
                        df > $RDIR/DF-$1
                        exit;
                else
                        rm $RESULTS/dirXC$i.result
                        echo "test $1:$i-th passed"
                fi

                cd ..
                rm -rf $TARGETDIR/dirXC$i &
        done
}

for target in aa ab ac ad ae af #ag ah ai aj ak al am an
do
        _xtract+compare $target $RDIR &
done

--
Yoshihiro Tsuchiya



