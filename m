Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVEYW7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVEYW7T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 18:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVEYW7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 18:59:18 -0400
Received: from mail.dvmed.net ([216.237.124.58]:42966 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261592AbVEYW7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 18:59:08 -0400
Message-ID: <42950334.9090402@pobox.com>
Date: Wed, 25 May 2005 18:59:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Netdev <netdev@oss.sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patches try2] 2.6.x net driver updates
References: <4294BD9C.2050105@pobox.com> <Pine.LNX.4.58.0505251200040.2307@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505251200040.2307@ppc970.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------000909010807040906020109"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000909010807040906020109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Wed, 25 May 2005, Jeff Garzik wrote:
> 
>>Does this work better?
> 
> 
> Looks good.

Groovy.


> If this was automated, are your changes to git-pull-script generic enough 
> to be useful for others, or did you do a totally specialized one for just 
> the "lots of heads in the same directory" case?

Not specialized at all.  I do one pull at a time, so git-pull-script 
suffices with a simple addition to call git-resolve-script with the 
branch as $4, and a simple addition to git-resolve-script to add 'branch 
$foo' to merge_msg.  See attached (note the patch includes my earlier 
'optimization' patch).

On this last run, I actually just ignored git-pull-script and simply ran 
git-resolve-script -- since all my objects are in-tree already, I don't 
need the fetch step:

git-resolve-script $(cat .git/HEAD ) $(cat .git/refs/heads/amd8111) \
    /spare/repo/netdev-2.6 amd8111

	Jeff



--------------000909010807040906020109
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

--- git-resolve-script	2005-05-25 15:21:32.772604549 -0400
+++ /usr/local/bin/git-resolve-script	2005-05-25 13:30:59.568504275 -0400
@@ -7,6 +7,7 @@
 head="$1"
 merge="$2"
 merge_repo="$3"
+merge_name=${4:-HEAD}
 
 : ${GIT_DIR=.git}
 : ${GIT_OBJECT_DIRECTORY="${SHA1_FILE_DIRECTORY-"$GIT_DIR/objects"}"}
@@ -20,7 +21,7 @@
 # but we do want it.
 #
 if [ "$merge_repo" == "" ]; then
-	echo "git-resolve-script <head> <remote> <merge-repo-name>"
+	echo "git-resolve-script <head> <remote> <merge-repo-name> <branch-name>"
 	exit 1
 fi
 
@@ -39,23 +40,23 @@
 	echo "Destroying all noncommitted data!"
 	echo "Kill me within 3 seconds.."
 	sleep 3
-	git-read-tree -m $merge && git-checkout-cache -f -u -a
+	git-read-tree -m $merge && git-checkout-cache -f -a && git-update-cache --refresh
 	echo $merge > "$GIT_DIR"/HEAD
 	git-diff-tree -p ORIG_HEAD HEAD | diffstat -p1
 	exit 0
 fi
 echo "Trying to merge $merge into $head"
 git-read-tree -m $common $head $merge
-merge_msg="Merge of $merge_repo"
+merge_msg="Merge of $merge_repo branch $merge_name"
 result_tree=$(git-write-tree  2> /dev/null)
 if [ $? -ne 0 ]; then
 	echo "Simple merge failed, trying Automatic merge"
 	git-merge-cache git-merge-one-file-script -a
-	merge_msg="Automatic merge of $merge_repo"
+	merge_msg="Automatic merge of $merge_repo branch $merge_name"
 	result_tree=$(git-write-tree) || exit 1
 fi
 result_commit=$(echo "$merge_msg" | git-commit-tree $result_tree -p $head -p $merge)
 echo "Committed merge $result_commit"
 echo $result_commit > "$GIT_DIR"/HEAD
-git-checkout-cache -f -u -a
+git-checkout-cache -f -a && git-update-cache --refresh
 git-diff-tree -p ORIG_HEAD HEAD | diffstat -p1

--------------000909010807040906020109--
