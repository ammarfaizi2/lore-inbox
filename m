Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287574AbSAHCox>; Mon, 7 Jan 2002 21:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287577AbSAHCoo>; Mon, 7 Jan 2002 21:44:44 -0500
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:44935 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S287574AbSAHCoj>; Mon, 7 Jan 2002 21:44:39 -0500
Date: Mon, 7 Jan 2002 21:48:32 -0500
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020107214832.A11527@earthlink.net>
In-Reply-To: <20020106153854.A10824@earthlink.net> <20020107183937.40625026.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020107183937.40625026.skraw@ithnet.com>; from skraw@ithnet.com on Mon, Jan 07, 2002 at 06:39:37PM +0100
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> can you please try The Same Thing while copying large files around in the
> background (lets say 100MB files) and re-comment.
> 
> Thanks,
> Stephan

I used the script below to create 10 330 megabyte files; then cpio them
over to another filesystem while another process was constantly allocating
and writing to 85% of VM.  It did 77 iterations allocating about 1.6GB of
RAM during the time (10 * 330 * 2) MB worth of files were created and cpio'd.
The test took 53 minutes.

I do most of my work from console.  
http://home.earthlink.net/~rwhron/hardware/matrox.html

There was an obvious but not painful delay for interactive use during 
the test.  An X desktop would be less kind to the user.

Kernel: 2.4.17rc2aa2
Memory: 901804k/917504k available 
1027 MB swap.
Athlon 1333
(1) 40GB 7200 rpm IDE disk.

#!/bin/bash
# What does the VM do when copying big files and a memory hog is running.

cmd=${0##*/}
kern=$(uname -r)

typeset -i i
typeset -i j

log=${cmd}-${kern}.log
src=/usr/src/sources
dest=/opt/testing
mtest01=$src/l/ltp*206/testcases/bin/mtest01
percent=85	# vm to fill

uname -a > $log

# create memhog script to run during test
cat>memhog<<EOF
#!/bin/bash
while :
do	# allocate and write to $percent of virtual memory
	uptime
	head -3 /proc/meminfo
	egrep 'inode|dentry|buffer' /proc/slabinfo
	time $mtest01 -p $percent -w 2>&1
	head -3 /proc/meminfo
	egrep 'inode|dentry|buffer' /proc/slabinfo
done
EOF

# execute memhog in background
chmod +x memhog
/memhog >> $log 2>&1 &
mpid=$!

# timer
SECONDS=0
vmstat 15  >> $log &
updatedb
rm -rf $src/?/bigfile $dest
mkdir $dest
df -k /opt /usr/src >> $log

# create 10 big files
for ((i=0; i<=9; i++))
do	cat $src/[gbl]/*.{gz,bz2} > $src/$i/bigfile
done
ls -l $src/?/bigfile >> $log
size=$(ls -l $src/?/bigfile|awk '{print $5}'|uniq)
num=$(ls $src/?/bigfile|wc -w)

# copy the files
cd $src
find [0-9] -name bigfile|cpio -pdm $dest >> $log
sync
df -k /opt /usr/src
echo $SECONDS to create and copy $num $size byte files  >> $log

# kill memhog and vmstat
kill $! $mpid
rm -rf $src/?/bigfile $dest
echo "log is in $log"

-- 
Randy Hron

