Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292938AbSCJSTs>; Sun, 10 Mar 2002 13:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292972AbSCJSTi>; Sun, 10 Mar 2002 13:19:38 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:50448 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S292938AbSCJSTW>; Sun, 10 Mar 2002 13:19:22 -0500
Message-ID: <3C8BCE86.17A5F7E8@namesys.com>
Date: Sun, 10 Mar 2002 21:22:14 +0000
From: Edward Shushkin <edward@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.5.4-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: system_lists@nullzone.org
CC: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] Opss! on 2.5.6 with ReiserFS
In-Reply-To: <5.1.0.14.2.20020310165035.00caf5c0@192.168.2.131>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

system_lists@nullzone.org wrote:
> 
> Hi there,
> 
>     i got a 'Opss' on my PII (one of my fileservers) just changing the
> kernel version from 2.5.5 to .6

Reiserfs in linux >= 2.5.6-pre3 does have broken stuff in journal area due to vfs cleanups.
Please wait, or apply this:

--- linux-2.5.6-pre3/fs/reiserfs/journal.c.orig Thu Mar  7 12:44:43 2002
+++ linux-2.5.6-pre3/fs/reiserfs/journal.c      Thu Mar  7 13:53:36 2002
@@ -1960,8 +1960,7 @@
                SB_ONDISK_JOURNAL_DEVICE( super ) ?
                to_kdev_t(SB_ONDISK_JOURNAL_DEVICE( super )) : super -> s_dev;  
        /* there is no "jdev" option and journal is on separate device */
-       if( ( !jdev_name || !jdev_name[ 0 ] ) && 
-           SB_ONDISK_JOURNAL_DEVICE( super ) ) {
+       if( ( !jdev_name || !jdev_name[ 0 ] ) ) {
                journal -> j_dev_bd = bdget( kdev_t_to_nr( jdev ) );
                if( journal -> j_dev_bd )
                        result = blkdev_get( journal -> j_dev_bd, 
@@ -1976,9 +1975,6 @@
                return result;
        }
 
-       /* no "jdev" option and journal is on the host device */
-       if( !jdev_name || !jdev_name[ 0 ] )
-               return 0;
        journal -> j_dev_file = filp_open( jdev_name, 0, 0 );
        if( !IS_ERR( journal -> j_dev_file ) ) {
                struct inode *jdev_inode;


Thanks,
Edward
