Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbULMQyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbULMQyc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 11:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbULMQyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 11:54:32 -0500
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:64436 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261279AbULMQyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 11:54:19 -0500
Message-ID: <41BDC9CD.60504@austin.rr.com>
Date: Mon, 13 Dec 2004 10:56:45 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: cifs large write performance improvements to Samba
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current mainline (very recent 2.6.10-rc Linux tree) should be fine 
from memory leak perspective.  No such leaks have been reported AFAIK on 
current cifs code and certainly none that I have detected in heavy 
stress testing. 

I do need to add some additional filesystem tests to the regression test 
mix soon, and I have asked one  of the guys here  with a ppc64 box to 
run some more bigendian tests on it too.   The ltp has filesystems tests 
scatterred in multiple directories which I need to track down and setup 
scripts to automate (e.g. the sendfile tests are not in the same 
directory with other tests in testcases/kernel/fs, nor is the very 
useful "connectathon nfs" posix filesystem test suite)

The oops (referenced in your post) does need to be fixed of course, but 
since the code that would cause it is disabled (and only is broken to 
certain servers and is noted as broken in the TODO list, implying that 
it should not be turned on in /proc/fs/cifs) - I was considering it 
lower priority than the other issues recently fixed which have been 
consuming my time.  Fixing/adding support for extended security is 
getting closer to the top of the priority list now though.  If I can at 
least prevent the oops with a small change (even if it does not fully 
fix the spnego code) I will push that changeset in soon.   The userspace 
piece should be -- much -- easier to communicate with now that the 
kevents stuff is in.    Very high on the list as well is getting NTLMv2 
tested and working as many environments require it.  Figuring out the 
mysterious byte range lock failure which sometimes occurs on an unlock 
in locktest 7 (I noticed it starting after the nfs changes for the vfs 
posix locking a few months ago) and I have posted about before (Kernel 
panic - not syncing: Attempting to free lock with active blocklist) is a 
slightly higher priority.  Basically I need to figure out what is going 
on with the line in fs/locks.c?

       if (!list_empty <http://lxr.linux.no/ident?v=2.6.8.1;i=list_empty>(&fl->fl_block)
		 panic <http://lxr.linux.no/ident?v=2.6.8.1;i=panic>(/"Attempting to free lock with active block list"/);


Since I am not adding anything to the fl_block list intentionally, I 
need to find out what causes items to be added to the fl_block list (ie 
when the locks_insert_block and locks_delete_block call are made and why 
they sometimes happen differently in lock test 7 then in other byte 
range lock testcases in which unlock obviously works fine).

On the issue of regressing back to smbfs :)  There are a few things 
which can be done that would help.

1) Need to post an updated version of when to still use smbfs for an 
occassional mount (there are only a couple of cases in which smbfs has 
to be used now but they are important to some users - such as users who 
have to access an occassional old OS/2 or DOS server, or who need 
Kerberos), and I need to add it that chart to the fs/cifs/README and the 
project page etc.
2) Public view of the status of testing - the raw data needs to be 
posted regularly as kernel updated (and against five or six different 
server types) so users see what is broken in smbfs (and so users can see 
what posix issues are still being worked on cifs and any known 
problems).   smbfs fails about half of the filesystem tests that I have 
tried, due to stress issues, or because the tests requires better posix 
compliance or because of various smbfs stability fixes.

  If only someone could roll all of the key fs tests into a set of 
scripts which could generate one regularly updated set of test status 
chart ... one for each of XFS, JFS, ext3, Reiser3, CIFS (against various 
servers, Samba version etc), NFSv2, NFSv3, NFSv4 (against various 
servers), AFS but that would be a lot of work (not to run) but the first 
time writing/setup of the scripts to launch the tests in the right order 
since some failures may be expected (at least for the network 
filesystems) due to hard to implement features (missing fcntls, dnotify, 
get/setlease, differences in byte range lock semantics, lack of flock 
etc.) and also since the most sensible NFS, AFS and CIFS tests would 
involve more than one client (to test caching/oplock/token management 
semantics better) but no such fs tests AFAIK exist for Linux.

