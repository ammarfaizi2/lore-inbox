Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWA3PhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWA3PhN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 10:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWA3PhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 10:37:13 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:30620 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932336AbWA3PhL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 10:37:11 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: Recursive chmod/chown OOM kills box with 32MB RAM
Date: Mon, 30 Jan 2006 14:28:50 +0200
User-Agent: KMail/1.8.2
Cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
References: <200601281613.16199.vda@ilport.com.ua> <200601281811.35690.vda@ilport.com.ua> <43DDAE2D.6080300@namesys.com>
In-Reply-To: <43DDAE2D.6080300@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601301428.50220.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 January 2006 08:11, Hans Reiser wrote:
> Denis Vlasenko wrote:
> 
> >[CCing namesys]
> >
> >Narrowed it down to 100% reproducible case:
> >
> >	chown -Rc 0:<n> .
> >
> >in a top directory of tree containing ~21938 files
> >on reiser3 partition:
> >
> >	/dev/sdc3 on /.3 type reiserfs (rw,noatime)
> >
> >causes oom kill storm. "ls -lR", "find ." etc work fine.
> >
> >I suspected that it is a leak in winbindd libnss module,
> >but chown does not seem to grow larger in top, and also
> >running it under softlimit -m 400000 still causes oom kills

(typo, must be -m 40000000)

> >while chown's RSS stays below 4MB.
>
> Chris, would you like to handle this?


fs seems to be ok fsck-wise:

# mount -o remount,ro /.3
# reiserfsck /dev/sdc3
reiserfsck 3.6.11 (2003 www.namesys.com)

*************************************************************
** If you are using the latest reiserfsprogs and  it fails **
** please  email bug reports to reiserfs-list@namesys.com, **
** providing  as  much  information  as  possible --  your **
** hardware,  kernel,  patches,  settings,  all reiserfsck **
** messages  (including version),  the reiserfsck logfile, **
** check  the  syslog file  for  any  related information. **
** If you would like advice on using this program, support **
** is available  for $25 at  www.namesys.com/support.html. **
*************************************************************

Will read-only check consistency of the filesystem on /dev/sdc3
Will put log info to 'stdout'

Do you want to run this program?[N/Yes] (note need to type Yes if you do):Yes
###########
reiserfsck --check started at Mon Jan 30 14:11:15 2006
###########
Filesystem seems mounted read-only. Skipping journal replay.
Checking internal tree..finished
Comparing bitmaps..finished
Checking Semantic tree:
finished
No corruptions found
There are on the filesystem:
        Leaves 8075
        Internal nodes 52
        Directories 1792
        Other files 31865
        Data block pointers 1058363 (0 of them are zero)
        Safe links 0
###########
reiserfsck finished at Mon Jan 30 14:13:28 2006
###########

However, there is one strange thing: I cannot umount it.
Why? There is no open files.

# umount /.3
umount: /.3: device is busy
# lsof -nP | grep -F '/.3'
# lsof -nP | grep -F 'sdc'
# uname -a
Linux pegasus 2.6.14.6 #1 SMP Mon Jan 30 08:46:20 EET 2006 i686 unknown unknown GNU/Linux

--
vda
