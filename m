Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264103AbUKZVSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264103AbUKZVSc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 16:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264005AbUKZVO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 16:14:56 -0500
Received: from mailrelay.tu-graz.ac.at ([129.27.3.7]:17217 "EHLO
	mailrelay02.tugraz.at") by vger.kernel.org with ESMTP
	id S264117AbUKZVMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 16:12:48 -0500
From: Christian Mayrhuber <christian.mayrhuber@gmx.net>
To: reiserfs-list@namesys.com
Subject: Re: file as a directory
Date: Fri, 26 Nov 2004 22:13:57 +0100
User-Agent: KMail/1.7.1
Cc: Hans Reiser <reiser@namesys.com>,
       Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-kernel@vger.kernel.org
References: <2c59f00304112205546349e88e@mail.gmail.com> <1101379820.2838.15.camel@grape.st-and.ac.uk> <41A773CD.6000802@namesys.com>
In-Reply-To: <41A773CD.6000802@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411262213.58242.christian.mayrhuber@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 November 2004 19:19, Hans Reiser wrote:
> For the case Peter cites, yes, it does add clutter to the pathname to 
> say "..metas" (actually, it is "...." now in the current reiser4, not 
> "..metas").  This is because you aren't looking for metafile 
> information, you are looking for a subset and describing the subset, and 
> that just requires a file-directory plugin that can handle the name of 
> that subset and parse the file to find it.
> 

Regarding namespace unification + XPath:
For files: cat /etc/passwd/[. = "joe"] should work like in XPath.
But what to do with directories?
Would 'cat /etc/[. = "passwd"]' output the contents of the passwd file
or does it mean to output the file '[. = "passwd"]'?
If the first is the case then you have to prohibit filenames looking 
like '[foo bar]'.

If the shells wouldn't like * for themself, I'd suggest something like
cat /etc/*[. = "passwd"]
This means: list all contents and show the ones where filename = "passwd".

For the contents of /etc/passwd the following could become possible:
'cat /etc/passwd/*[. = "joe"]
'cat /etc/passwd/*[@shell = "/bin/tcsh"]
The XPath could behave similiar as if applied to the following XML:
<entries>
  <root passwd="x" shell="/bin/sh" .... />
  ...
  <joe passwd="x" shell="/bin/tcsh" uid="500" gid="500" .... />
</entries>
The output from the cat's above return the line of joe's entry:
joe:x:500:500:joe:/home/joe:/bin/tcsh

To change all tcsh entries to bash:
echo -n "/bin/bash" > /etc/passwd/*[@shell = "/bin/tcsh"]/@shell

I hope I'm not offending, but my impression is now that
XPath stuff fits better into some shell providing
a XPath view of the filesystem, than into the kernel.

--------------------------------------------------------------------

What about mapping the contents of files into "pure" posix namespace?
XML is basically a tree, too.
Notes: 
1) "...." below is the entry to reiser4 namespace.
2) # denotes a shell command
For example:

# cd /etc/passwd/
# ls -a *
. .. .... joe root
# cd joe
# ls
gid home passwd shell uid
# cat shell
/bin/tcsh
# cd ../....
# ls 
plugins 

I guess an implementation in reiser4 would require some
mime-type/file extension dispatcher plus a special
directory plugin for each mime-type.

-- 
lg, Chris

