Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbTAPKv0>; Thu, 16 Jan 2003 05:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266200AbTAPKv0>; Thu, 16 Jan 2003 05:51:26 -0500
Received: from angband.namesys.com ([212.16.7.85]:35719 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S265077AbTAPKvZ>; Thu, 16 Jan 2003 05:51:25 -0500
Date: Thu, 16 Jan 2003 14:00:15 +0300
From: Oleg Drokin <green@namesys.com>
To: linux-kernel@vger.kernel.org
Cc: eazgwmir@umail.furryterror.org, viro@math.psu.edu, nikita@namesys.com
Subject: [2.4] VFS locking problem during concurrent link/unlink 
Message-ID: <20030116140015.A17612@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Debugging reiserfs problem that can be demonstrated with script created by
   Zygo Blaxell, I started to wonder if the problem presented is indeed reiserfs
   fault and not VFS.
   Though the Zygo claims script only produces problems on reiserfs, I am trying
   it now myself on ext2 (which will take some time).

   Debugging shows that reiserfs_link is sometimes called for inodes whose
   i_nlink is zero (and all corresponding data is deleted already).
   So my current guess of what's going on is this:

   process 1                      process 2
   sys_unlink("a/b")		  sys_link("a/b", "c/d");
   down(inode of ("a"));	  down(inode of "c");
				  
   lock_kernel()
   reiserfs_unlink("a/b")
     decreases i_nlink of a/b to zero
     and removes name "b" from "a"
   unlock_kernel()
   d_delete("a/b")
(*)
				   lock_kernel()
				   reiserfs_link()
					at this point we do usual stuff,
					but inode's n_nlink is zero and
					file data already removed which
				        indicates reiserfs_delete_inode()
					was already called at (*)
				   unlock_kernel()

   So my question is "Is it really ok that sys_link/vfs_link does not
   take semaphore on parent dir of original path?", or should we
   actually put a workaround in reiserfs code to avoid such a situation?

Bye,
    Oleg
PS: Here's the script:
#!/bin/bash

# Create an empty filesystem:

mkreiserfs -f -f /dev/hdb2
mount /dev/hdb2 /data1 -t reiserfs

cd /data1

# Script used to control the load average.  Note that as written the loops
# below will keep spawning new processes, so we need some way to throttle
# them.  Change the '-lt 10' to another number to change the number
# of processes.

cat <<'LC' > loadcheck && chmod 755 loadcheck
#!/bin/sh
read av1 av5 av15 rest < /proc/loadavg
echo -n "Load Average: $av1 ... "
av1=${av1%.*}
if [ $av1 -lt 10 ]; then
        echo OK
        exit 0
else
        echo "Whoa, Nellie!"
        exit 1
fi
LC
# Create directories used by test
mkdir foo bar
mkdir foo/etc foo/usr foo/var

# Start up some rsyncs.  I use /etc, /usr, and /var because there's a
# good mixture of files with some hardlinks between them, and on a normal
# Linux system some of them change from time to time.

while sleep 1m; do
        ./loadcheck || continue;
        for x in usr etc var; do
                rsync -avxHS --delete /$x/. foo/$x/. &
        done;
done &
# Start up some cp -al's and rm -rf's.  Note there are two concurrent
# sets of 'cp's and two concurrent sets of 'rm's, and each of those
# has different instances of 'cp' and 'rm' running at different times.
for x in  1 2; do
        while sleep 1m; do
                ./loadcheck || continue;
                cp -al foo bar/`date +%s` &
        done &
        while sleep 1m; do
                ./loadcheck || continue;
                for x in bar/*; do
                        rm -rf $x;
                        sleep 1m;
                done &
        done &
done &



