Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTLOJZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 04:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbTLOJZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 04:25:26 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:56994 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263424AbTLOJZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 04:25:20 -0500
Message-ID: <3FDD7DFD.7020306@labs.fujitsu.com>
Date: Mon, 15 Dec 2003 18:25:17 +0900
From: Tsuchiya Yoshihiro <tsuchiya@labs.fujitsu.com>
Reply-To: tsuchiya@labs.fujitsu.com
Organization: Fujitsu Labs
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: filesystem bug?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ext2 and Ext3 filesystem go to inconsistent status by
simple test program on my system.

My test program is a script that extract a tar+gzip archive
twice and compare them, and remove one of the tree, and then
another extracting, and compare them again. A very simple test.

Following is an Ext2 result and the inode is filled by zero.
I think the inode becomes a badinode.

----
[root@dell04 tsuchiya]# ls -l /mnt/foo/ae/dir0/mozilla/layout/html/tests/table/bugs/bug2757.html
ls: /mnt/foo/ae/dir0/mozilla/layout/html/tests/table/bugs/bug2757.html: Input/output error


debugfs:  stat foo/ae/dir0/mozilla/layout/html/tests/table/bugs/bug2757.html
Inode: 1935297   Type: bad type    Mode:  0000   Flags: 0x0   Generation: 0
User:     0   Group:     0   Size: 0
File ACL: 0    Directory ACL: 0
Links: 0   Blockcount: 0
Fragment:  Address: 0    Number: 0    Size: 0
ctime: 0x00000000 -- Thu Jan  1 09:00:00 1970
atime: 0x00000000 -- Thu Jan  1 09:00:00 1970
mtime: 0x00000000 -- Thu Jan  1 09:00:00 1970
BLOCKS:

/dev/sda4 on /mnt type ext2 (rw)
----

I saw same thing on Ext3 before.

I use RedHat9 which kernel is 2.4.20-8 and I also tried
2.4.20-19.9(redhat kernel patch rpm).

I want to know whether it is a redhat kernel problem or a generic
Ext problem and on which version it is fixed.


Mkfs parameter is just default of /sbin/mkfs.ext2 and mkfs.ext3,
and I use DELL 1650's internal SCSI disks for this test:

----
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

blk: queue dfceb214, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: SEAGATE   Model: ST336607LC        Rev: DS04
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue dfceb414, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: SEAGATE   Model: ST336753LC        Rev: DX03
  Type:   Direct-Access                      ANSI SCSI revision: 03
----

I will attach my script. I use Mozilla's tar archive.
Edit the first three lines for your use.

In the example above, the inode structure was cleared by zero, and
some time the data area was broken. Also I saw an inode overwritten
by deleted inode(which nlink=0 and i_dtime is on).
My feeling is that the broken buffers were used for some other
purpose and destroyed without having right LOCK of the buffer.

Here is my script:
---
#!/bin/bash

TARGETPREFIX=/mnt/foo   # filesystem that will be tested
MOZSRC=/home/tsuchiya/src/mozilla-source-1.3.tar.gz     # tgz used for test
RDIR="/tmp/xcresult"    # result directory

function _xtract+compare {
        echo "extracting directory to be compared against for $1"
        TARGETDIR=$TARGETPREFIX/$1
        mkdir -p $TARGETDIR
        cd $TARGETDIR
        tar zxf $MOZSRC
        echo "$1 done .... now the job is started."
        RESULTS=$RDIR/$1

        echo "test result will be stored under $RESULTS"
        mkdir -p $RESULTS;

        for ((i=0; i < 100000; i++))
        do
                echo "$1:$i-th trial"

                echo "test dir is $TARGETDIR";
                mkdir -p $TARGETDIR;

                cd $TARGETDIR
                mkdir dir$i
                cd dir$i
                tar zxf $MOZSRC
                diff -rq $TARGETDIR/mozilla mozilla > $RESULTS/dir$i.result 2>&1
                DIFFSIZE=`ls -l $RESULTS/dir$i.result | awk '{print $5}'`
                if [ $DIFFSIZE != 0 ];
                then
                        echo "something wrong happened at $1:$i-th trial "
                        exit;
                else
                        rm $RESULTS/dir$i.result
                        echo "test $1:$i-th passed"
                fi
                rm -rf mozilla &
        done
}

for target in aa ab ac ad ae # af ag ah ai aj ak al am an
do
        _xtract+compare $target $RDIR &
done

---


Any information would be appreciated.

Thanks,
Yoshi
---
Yoshihiro Tsuchiya



