Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUAAKr0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 05:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbUAAKr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 05:47:26 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:6662 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S261188AbUAAKrY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 05:47:24 -0500
Date: Thu, 1 Jan 2004 02:47:17 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: File change notification
Message-ID: <20040101104717.GA1373@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <3FF2FC85.5070906@lambda-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3FF2FC85.5070906@lambda-computing.de>
User-Agent: Mutt/1.3.27i
X-Message-Flag: If you're running Outlook, look out!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 05:42:45PM +0100, Rüdiger Klaehn wrote:
> Hi everybody.
> 
> This is my first post to lkml, so please be patient with me
> 
> I have been wondering for some time why there is no decent file change 
> notification mechanism in linux. Is there some deep philosophical reason 
> for this, or is it just that nobody has found the time to implement it? 
> If it is the latter, I am willing to implement it as long there is a 
> chance to get this accepted into the mainstream kernel.
> 
> Is there already somebody working on this problem? I know a few efforts 
> that try to do something similar, but they all work by intercepting 
> every single system call that has to do with files, and they are thus 
> not very fast. See for example
> <http://www.bangstate.com/software.html#changedfiles>
> <http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/openxdsm/openxdsm/eventmodule/> 
> 
> 
> The dnotify mechanism is very limited since it requires a file handle, 
> it is not working for whole directory trees and it does not report much 
> useful information. For example to watch for changes in the /home tree 
> you would have to open every single directory in the tree, which would 
> probably not even work since it would require more than the maximum 
> number of file handles. If you have a directory with many files in it, 
> the only thing dnotify tells you is that something has changed in the 
> directory, so you have to rescan the whole directory to find out which 
> file has changed. Kind of defeats the purpose of change notification...
> 
> What I would like to have would be some way to watch for certain changes 
> anywhere in a whole tree or even the whole file system. This new 
> mechanism should have no measurable performance impact and should log 
> all information that is readily available. The amount of new code in 
> kernel space should be as small as possible. So complicated stuff like 
> pattern matching would have to happen in user space.
> 
> I wrote some experimental mechanism yesterday. Whenever a file is 
> accessed or changed, I write all easily available information to a ring 
> buffer which is presented to user space as a device. The information 
> that is easily available is the inode number of the file or directory 
> that has changed, the inode number of the directory in which the change 
> took place, and in most cases the name of the dentry of the file that 
> has changed.

hmm...


#ln tree1/sub/dir/file tree2/sub/dir/file
#watch_tree tree1 &
#do_something_to tree2/sub/dir/file

A dnotify can potentially know about open, chown, chmod,
utimes and possibly link of the files by watching the paths
and cwd; meaning it won't know about alternate paths.  How
is it to know about read, write, fchown, fchmod and
truncate?

Perhaps someone else has a more fertile imagination but
short of looking up all the file inode numbers of the tree
in question and watching that whole list this sounds futile.
