Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269761AbUICT7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269761AbUICT7b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 15:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269764AbUICT7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:59:05 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:65108 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S269761AbUICTy3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:54:29 -0400
Message-ID: <4138CBEF.9000909@cs.aau.dk>
Date: Fri, 03 Sep 2004 21:54:23 +0200
From: =?ISO-8859-1?Q?Kristian_S=F8rensen?= <ks@cs.aau.dk>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040814)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: umbrella-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Umbrella-devel] Re: Getting full path from dentry in LSM hooks
References: <41385FA5.806@cs.aau.dk> <20040903133238.A4145@infradead.org> <413865B4.7080208@cs.aau.dk> <20040903140449.A4253@infradead.org> <41386FB7.2060804@cs.aau.dk> <20040903150111.A4884@infradead.org>
In-Reply-To: <20040903150111.A4884@infradead.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Fri, Sep 03, 2004 at 03:20:55PM +0200, Kristian Sørensen wrote:
> 
>>But we do not have a struct file - just an inode or a dentry :((
> 
> 
> Then you can't generate a full path.
> 
> 
>>We are working on a project called Umbrella, (umbrella.sf.net) which 
>>implements processbased mandatory accesscontrol in the Linux kernel. 
>>This access control is controlled by "restriction", e.g. by restricting 
>>  some process from accessing any given file or directory.
>>
>>E.g. if a root owned process is restricted from accessing /var/www, and 
>>the process is compromised by an attacker, no mater what he does, he 
>>would not be able to access this directory.
> 
> 
> mount --bind /var/www /home/joe/p0rn/, and then?
Actually this "attack" is avoided, because restrictions are enherited, 
from parent proces to its children.

Okay, this is how it works in basic:

------------------
ks@qbox:~/umbrella-devel/userspace
$ touch /tmp/a

ks@qbox:~/umbrella-devel/userspace
$ ./umbrella_restricted_sh

sh-2.05b$ touch /tmp/a
touch: setting times of `/tmp/a': Operation not permitted

sh-2.05b$ exit
Restricted child died
Thank you for testing!
Concider joining the development at http://umbrella.sourceforge.net
------------------

- the "umbrella_restricted_sh" just forks a new shell, which is 
restricted from /tmp

Now let's try your suggestion:


------------------------
root@qbox:~/umbrella-devel/userspace
$ id
uid=0(root) gid=0(root) 
groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel),11(floppy),20(dialout),26(tape),27(video)

root@qbox:~/umbrella-devel/userspace
$ mkdir new-tmp

root@qbox:~/umbrella-devel/userspace
$ mount --bind /tmp new-tmp

root@qbox:~/umbrella-devel/userspace
$ mount
/dev/discs/disc1/part2 on / type ext3 (rw)
none on /dev type devfs (rw)
none on /proc type proc (rw)
none on /sys type sysfs (rw)
none on /dev/pts type devpts (rw)
/dev/discs/disc0/part1 on /home type ext3 (rw)
/dev/discs/disc0/part2 on /media type ext3 (rw)
none on /dev/shm type tmpfs (rw)
none on /proc/bus/usb type usbfs (rw)
/tmp on /home/ks/umbrella-devel/userspace/new-tmp type none (rw,bind)

root@qbox:~/umbrella-devel/userspace
$ ./umbrella_restricted_sh

sh-2.05b# touch /tmp/a
touch: setting times of `/tmp/a': Operation not permitted

sh-2.05b# touch new-tmp/a
touch: setting times of `new-tmp/a': Operation not permitted

sh-2.05b# ls new-tmp/
ls: new-tmp/: Operation not permitted

sh-2.05b# exit
Restricted child died
Thank you for testing!
Concider joining the development at http://umbrella.sourceforge.net
------------------------

As you can see, the bind-mount fails to succeed in accessing the files 
in /tmp.



Best regards, Kristian.
