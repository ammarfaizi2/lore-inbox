Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268987AbUIMVim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268987AbUIMVim (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 17:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268914AbUIMVgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 17:36:15 -0400
Received: from mail03.powweb.com ([66.152.97.36]:35850 "EHLO mail03.powweb.com")
	by vger.kernel.org with ESMTP id S268985AbUIMVed convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 17:34:33 -0400
From: "David Dabbs" <david@dabbs.net>
To: "'ReiserFS List'" <reiserfs-list@namesys.com>,
       <linux-kernel@vger.kernel.org>
Cc: <viro@parcelfarce.linux.theplanet.co.uk>,
       "'Alex Zarochentsev'" <zam@namesys.com>
Subject: Re: [PATCH] use S_ISDIR() in link_path_walk() to decide whether the last path component is a directory
Date: Mon, 13 Sep 2004 16:34:15 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcSZ2Wr/B6Nedt+kRzGeuLC3soNW6Q==
Message-Id: <20040913213429.6813115CA8@mail03.powweb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>viro wrote
>On Mon, Sep 13, 2004 at 11:49:22AM +0400, Alex Zarochentsev wrote:
> Hi,
> 
> This patch does not allow open(name, O_DIRECTORY) to be successful for
> non-directories in reiser4.  It replaces ->i_op->lookup != NULL "is dir"
> check for the last path component by explicit S_ISDIR(->i_mode) check. 
> 
> Regardless to reiser4, S_ISDIR() looks more clear there.
>
>The only objection here is that right now we are guaranteed that cwd and
>root of every task have non-NULL ->lookup().  With your patch all we have
>is S_ISDIR().
>
>So we either need to check for non-NULL ->lookup() before the beginning of
>loop in link_path_walk() or split the flag in two.  I would rather do the
>former...
> 

I'm working on something similar, but with alternate pathname resolution
when the path begins with exactly two slashes. Only pseudocode here because
I do not have access to my box:

In path_lookup()

    if (*name == '/') {
       if (*(name+1)=='/' && *(name+2)==':') {
          name+=3;
          nd->flags &= LOOKUP_SLASHSLASH
          if (*name!='/')
            goto relative;
       }
    

In link_path_walk()
    When LOOKUP_SLASHSLASH, handle names as follows:

    If this !S_ISDIR()

       next.name  Behavior 
       ------------------------------------------------------
       .          Same if i_op && i_op->lookup, else -ENOTDIR.
       ..         Same.
       ...        Okay if i_op && i_op->lookup, else -ENOTDIR.
       otherwise  Fails with -ENOENT.
       
    If S_ISDIR()
       any        Same behavior


I tested the //: & flag code and this works (in my limited testing yesterday
with bash and some test programs). 

This should limit "hybrid" file-directories to only one valid subdirectory,
the "special metadata" directory. Thus, if a new/modified app wants to
create/access metadata, it would do something like the following:

   # relative path
   cd /test
   touch foo.txt	
   mkdir foo.txt/...     # FAILS
   mkdir //:foo.txt/...
   echo JayRandom > //:foo.txt/.../Author

   # absolute path
   echo blahblah > //:/test/foo.txt/.../Title

   mkdir testdir
   mkdir //:testdir/...
   echo no > //:testdir/.../VirusScan

Yes, this means that a) ... is "removed" from the namespace and b) directory
metadata directories are visible to naïve applications/users while those for
files are not. But it does provide "metadata-aware" apps/users a consistent
way to access this info for both files and directories without resorting to
openat(). Since SuS provides for "implementation-specific" pathname
resolution when pathnames begin with exactly two slashes this should be
legal(?), if desired.

This doesn't address the issue of "active" metadata objects such as reiser4
provides e.g. foo.txt/metas/perms. That's a different discussion. 


David



