Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTJAOrw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbTJAOrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:47:51 -0400
Received: from ext-nat.kla-tencor.com ([192.146.1.254]:64913 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262386AbTJAOrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:47:45 -0400
Subject: Re: File Permissions are incorrect. Security flaw in Linux
From: "Lisa R. Nelson" <lisanels@cableone.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1065044031.2158.23.camel@wynken.reefedge.com>
References: <1065012013.4078.2.camel@lisaserver>
	 <1065044031.2158.23.camel@wynken.reefedge.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1065019077.2995.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 01 Oct 2003 08:37:58 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, ok, I get it... It was an oversight on my part.  But I'm sure
surprised about some of the hostile replies I received.  So much for a
friendly group.  People should remember that there's ALWAYS someone that
knows more that YOU.  In my case it was about permissions, what is it in
your case?  Microsoft scores points on being friendly... Yuck...
Microsoft....

On Wed, 2003-10-01 at 15:33, Sam Baskinger wrote: 
> The behavior you observed is in conformance with the POSIX specification
> for the unlink() system call.  POSIX is one of the standard which Linux
> seeks to comply with.
> 
> Do note that many unix implementations do not follow all standards
> believing that they are making things "safer" or "better."  If you see a
> different behavior on Solaris then perhaps this is one of those design
> choices SUN made.
> 
> I'm sorry you had to type that long email. :-)
> 
> Sam
> 
> On Wed, 2003-10-01 at 08:40, Lisa R. Nelson wrote:
> > [1.] One line summary of the problem:    
> > A low level user can delete a file owned by root and belonging to group
> > root even if the files permissions are 744.  This is not in agreement
> > with Unix, and is a major security issue.
> > 
> > [2.] Full description of the problem/report: 
> >     Permissions on a file basis take precedence over directory
> > permissions (for most cases), but in Linux they do not.  In order to
> > secure a file, you have to secure the directory which effects all files
> > within it.  
> >     As user 'lisa', I do all my work on my server.  One task is to move
> > pictures from my digital camera to my server picture directory that is
> > wide open to everyone.  All users can create sub-folders and put
> > pictures in there.  But every hour I have a cron job run that changes
> > the ownership to root, and sets the permissions to 644 on all files in
> > that directory structure.  Thinking the files could no longer be altered
> > by anyone but root (as would be the case in unix), and found anyone
> > could delete them.  That's when I discovered this major bug.
> >     I verified this on a sun station today, by simply creating a file in
> > a wide open directory with 444 permissions and was then able to delete
> > it after the "Ok to delete write-protected file(y/n), but could NOT
> > delete a similar file with the same permissions owned by root...  As it
> > should be...
> > Try this:
> > 
> > [lisa@localhost lisa]$ su - root
> > Password:
> > [root@localhost root]# cd /
> > [root@localhost /]# mkdir junk
> > [root@localhost /]# chmod 777 junk
> > [root@localhost /]# ls -l
> > total 225
> > ...
> > drwxrwxrwx    2 root     root         4096 Sep 29 07:30 junk
> > ...
> > [root@localhost /]#
> > [root@localhost /]# cd junk
> > [root@localhost junk]# ls .. > rootfile
> > [root@localhost junk]# ls -l
> > total 4
> > -rw-r--r--    1 root     root           95 Sep 29 07:31 rootfile
> > [root@localhost junk]# cp rootfile rootfile2
> > [root@localhost junk]# cp rootfile rootfile3
> > [root@localhost junk]# ls -l
> > total 12
> > -rw-r--r--    1 root     root           95 Sep 29 07:31 rootfile
> > -rw-r--r--    1 root     root           95 Sep 29 07:32 rootfile2
> > -rw-r--r--    1 root     root           95 Sep 29 07:32 rootfile3
> > [root@localhost junk]# chmod 444 rootfile2
> > [root@localhost junk]# chmod 000 rootfile3
> > [root@localhost junk]# ls -l
> > total 12
> > -rw-r--r--    1 root     root           95 Sep 29 07:31 rootfile
> > -r--r--r--    1 root     root           95 Sep 29 07:32 rootfile2
> > --    1 root     root           95 Sep 29 07:32 rootfile3
> > [root@localhost junk]#exit
> > [lisa@localhost lisa]$ cd /junk
> > [lisa@localhost junk]$ ls -l
> > total 12
> > -rw-r--r--    1 root     root           95 Sep 29 07:31 rootfile
> > -r--r--r--    1 root     root           95 Sep 29 07:32 rootfile2
> > --    1 root     root           95 Sep 29 07:32 rootfile3
> > [lisa@localhost junk]$
> > [lisa@localhost junk]$ rm root*
> > rm: remove write-protected regular file `rootfile'? y
> > rm: remove write-protected regular file `rootfile2'? y
> > rm: remove write-protected regular file `rootfile3'? y
> > [lisa@localhost junk]$ ls -l
> > total 0
> > [lisa@localhost junk]$
> > Notice that all three files that 'lisa' does not have write permissions
> > to are gone!  
> > 
> > 
> > [3.] Keywords (i.e., modules, networking, kernel):
> > kernel file permissions security
> > 
> > [4.] Kernel version (from /proc/version): 
> > [root@localhost proc]# cat version
> > Linux version 2.4.20-20.9 (root@rwbp4) (gcc version 3.2.2 20030222 (Red
> > Hat Linux 3.2.2-5)) #1 Wed Aug 20 17:41:55 EDT 2003
> > [root@localhost proc]#
> > 
> > [5.] Output of Oops.. message
> > None 
> > [6.] A small shell script or example
> > See Above
> > 
> > http://www.auburn.edu/oit/software/os/unix_files.html
> > http://www.dartmouth.edu/~rc/help/faq/permissions.html
> > http://www.december.com/unix/tutor/permissions.html
> > http://www.itc.virginia.edu/desktop/web/permissions/
> > 
> > 

-- 

Lisa R. Nelson <lisanels@cableone.net>
