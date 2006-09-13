Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751615AbWIMGRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbWIMGRg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 02:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbWIMGRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 02:17:36 -0400
Received: from smtpout.mac.com ([17.250.248.177]:11724 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751614AbWIMGRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 02:17:35 -0400
In-Reply-To: <ee8589$e70$1@taverner.cs.berkeley.edu>
References: <20060907182304.GA10686@danisch.de> <45073B2B.4090906@lsrfire.ath.cx> <ee7m7r$6qr$1@taverner.cs.berkeley.edu> <20060913043319.GH541@1wt.eu> <ee8589$e70$1@taverner.cs.berkeley.edu>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1BB4231A-7D69-4A77-A050-1C633BDFA545@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: R: Linux kernel source archive vulnerable
Date: Wed, 13 Sep 2006 02:17:30 -0400
To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAQAAA+k=
X-Language-Identified: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 13, 2006, at 01:34:01, David Wagner wrote:
> Willy Tarreau  wrote:
>> The initial reason is that Linus now uses the "git-tar-tree" command
>> which creates the full tar archive from the tree. It does not use  
>> tar,
>> it know how to produce the tar format itself. The command has to set
>> permissions on the files, and by default, it sets full permissions to
>> the files.
>
> Ahh, thanks for the explanation.  That's helpful.
>
> So it sounds like git-tar-tree has a bug; its default isn't setting
> meaningful permissions on the files that it puts into the tar archive.
> I hope the maintainers of git-tar-tree will consider fixing this bug.

Let me reiterate:  This is not a bug!

Here are a few facts:

1)  When I run "touch foo", the "touch" command uses permissions  
0666, which are modified by my umask before hitting the FS.  (same  
behavior for all UIDs)

2)  When I run "gcc -c foo.c -o foo.o", the "gcc" command uses  
permissions 0666, which are modified by my umask before hitting the  
FS.  (same behavior for all UIDs)

3)  When I run "vim foo.c", the "vim" command uses permissions 0666  
for new files, which are modified by my umask before hitting the FS.   
(same behavior for all UIDs)

4)  When I run "tar -xvf foo.tar" as a normal user, the "tar" command  
uses permissions from the archive for new files, which are modified  
by my umask before hitting the FS.

5)  Do you see the pattern here?


Now when I run that tar command as root, for some reason they assume  
that just because my UID is 0 I want to try to ignore my umask while  
extracting my j_random.tar file.  How does this follow from the  
behavior of any other programs mentioned above?

The program "git-tar-tree" has no bug.  It creates the tar archive  
such that when extracted as a normal user the users' umask is applied  
exactly as for every other standard program.  If anything the "bug"  
is in tar assuming that every archive file extracted as UID 0 is a  
backup, or in the admin assuming that tar doesn't behave differently  
when run as UID 0.

Cheers,
Kyle Moffett

