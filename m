Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTJMFtY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 01:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbTJMFtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 01:49:24 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:39375 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261464AbTJMFtW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 01:49:22 -0400
Message-ID: <3F8A3CE0.4060705@namesys.com>
Date: Mon, 13 Oct 2003 09:49:20 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jw schultz <jw@pegasys.ws>
CC: linux-kernel@vger.kernel.org, vs@thebsh.namesys.com, nikita@namesys.com
Subject: Re: ReiserFS patch for updating ctimes of renamed files
References: <JIEIIHMANOCFHDAAHBHOIELODAAA.alex_a@caltech.edu> <20031012071447.GJ8724@pegasys.ws>
In-Reply-To: <20031012071447.GJ8724@pegasys.ws>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz wrote:

>On Sun, Oct 12, 2003 at 01:05:19AM -0500, Alex Adriaanse wrote:
>  
>
>>Hi,
>>
>>I ran into some trouble trying to do incremental backups with GNU tar
>>(using --listed-incremental) where renaming a file in between backups would
>>cause the file to disappear upon restoration.  When investigating the issue
>>I discovered that this doesn't happen on ext2, ext3, and tmpfs filesystems
>>but only on ReiserFS filesystems.  I also noticed that for example ext3
>>updates the affected file's ctime upon rename whereas ReiserFS doesn't, so
>>I'm thinking this causes tar to believe that the file existed before the
>>first backup was taking under the new name, and as a result it doesn't back
>>it up during the second backup.  So I believe ReiserFS needs to update
>>ctimes for renamed files in order for incremental GNU tar backups to work
>>reliably.
>>
>>I made some changes to the reiserfs_rename function that I *think* should
>>fix the problem.  However, I don't know much about ReiserFS's internals, and
>>I haven't been able to test them out to see if things work now since I can't
>>afford to deal with potential FS corruption with my current Linux box.
>>
>>I included a patch below against the 2.4.22 kernel with my changes.  Would
>>somebody mind taking a look at this to see if I did things right here (and
>>perhaps wouldn't mind testing it out either)?  If it works then I (and I'm
>>sure others who've experienced the same problem) would like to see the
>>changes applied to the next 2.4.x (and 2.6.x?) release.
>>    
>>
>
>Hmm.  I'm conflicted.
>
>rename(2) manpage:
>	Any other hard links to the file (as created using
>	link(2)) are unaffected.
>
>A change to ctime would affect the other links.
>
>stat(2) manpage:
>	The field st_ctime is changed by writing or by
>	setting inode information (i.e., owner, group, link
>	count, mode, etc.).
>
>I am not aware of any field in the inode structure that must
>be changed by an atomic rename.  Per documentation the only
>reason rename should update st_ctime is if it does a
>link+unlink sequence which would alter st_nlink briefly.
>
>On the other hand it does seem to me there ought to be some
>record that something about the inode changed.  st_ctime would
>be the only appropriate indicator.
>
>rename() SUSv3:
>	Some implementations mark for update the st_ctime
>	field of renamed files and some do not. Applications
>	which make use of the st_ctime field may behave
>	differently with respect to renamed files unless
>	they are designed to allow for either behavior.
>
>So reiserfs is on this point definitely standards conformant
>already.  A change could at best be seen as an enhancement.
>
>
>
>
>  
>
thanks Mr. Schultz, you saved us a lot of work in reviewing this issue.

In theory it is cleaner and purer to do it the way we did.  In practice, 
Alex's problem seems like a real one, and I don't know how hard it is to 
change tar to do the right thing.  We'll discuss it in a small seminar 
today.

-- 
Hans


