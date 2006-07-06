Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbWGFHm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWGFHm1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 03:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWGFHm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 03:42:27 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:28546 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S964971AbWGFHm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 03:42:26 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: Linux 2.4.33-rc2
Date: Thu, 06 Jul 2006 17:42:17 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <dhdpa2pat94ssieedvjaj2m1n8265t19at@4ax.com>
References: <20060621192756.GB13559@dmt> <20060703220736.GA272@1wt.eu> <0e6ma2961ro2evtrnacgmla7j52j738q76@4ax.com> <20060705205137.GA25913@1wt.eu>
In-Reply-To: <20060705205137.GA25913@1wt.eu>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2006 22:51:37 +0200, Willy Tarreau <w@1wt.eu> wrote:

>Hi,
>
>On Wed, Jul 05, 2006 at 11:51:35AM +1000, Grant Coady wrote:
>> On Tue, 4 Jul 2006 00:07:36 +0200, Willy Tarreau <w@1wt.eu> wrote:
>> 
>> >On Wed, Jun 21, 2006 at 04:27:56PM -0300, Marcelo Tosatti wrote:
>> > 
>> >> Willy Tarreau:
>> >>       Fix vfs_unlink/NFS NULL pointer dereference
>> >
>> >Marcelo, I'm not sure this one is perfect yet. Today, while packaging
>> >a lot of files for our distro at work, I came up with a problem where
>> >deleting a file on NFS, and later simply accessing (read/write/create)
>> >a file on the NFS file system did block. However, I could kill all the
>> >offending processes. This was after a full day of mkdir/create/open/
>> >unlink... (tens of thoudands of those), so it is not much reproduceable.
>> >
>> >I could not unmount the NFS anymore, while other users had no problem.
>> >Rebooting the client solved the problem. I caught an RPC trace (attached),
>> >not sure if it can help. I must say that I'm also running Trond's NFS
>> >patches which I suspected first, but with which I never encountered a
>> >single problem for years.
>> >
>> >The fact that the problem appeared during an rm -rf made me think about
>> >the vfs_unlink() patch. I went to read it again an I'm wondering if we
>> >have not inserted a new problem (please forgive my ignorance here) :
>> >
>> >in 2.4.32, we had the following sequence :
>> >        down(&dir->i_zombie);
>> >        if (may_delete(dir, dentry, 0) != 0) return;
>> >        lock_kernel();
>> >        error = dir->i_op->unlink(dir, dentry);
>> >        unlock_kernel();
>> >        if (!error)
>> >              d_delete(dentry);
>> >        up(&dir->i_zombie);
>> >        if (!error)
>> >                inode_dir_notify(dir, DN_DELETE);
>> >
>> >
>> >int 2.4.33-rc2, we have :
>> >        if (may_delete(dir, dentry, 0) != 0) return;
>> >        inode = dentry->d_inode;
>> >
>> >        atomic_inc(&inode->i_count);
>> >        double_down(&dir->i_zombie, &inode->i_zombie);
>> > 
>> >        lock_kernel();
>> >        error = dir->i_op->unlink(dir, dentry);
>> >        unlock_kernel();
>> >
>> >        double_up(&dir->i_zombie, &inode->i_zombie);
>> >        iput(inode);
>> >
>> >        if (!error) {
>> >                d_delete(dentry);
>> >                inode_dir_notify(dir, DN_DELETE);
>> >        }
>> >
>> >What I notice is that in 2.4.32, d_delete(dentry) was performed
>> >between down(&dir->i_zombie) and up(&dir->i_zombie), while now
>> >it's completely outside. I wonder if this can cause race conditions
>> >or not, but at least, I'm sure that we have changed the locking
>> >sequence, which might have some impact.
>> >
>> >Do you think I'm searching in the wrong direction ? I worry a
>> >bit, because getting a deadlock after only one day, it's a bit
>> >early :-/
>> >
>> Assuming you mean something like the patch below?  Doesn't cause any 
>> problems (yet, still testing) like eat files or segfault here as 
>> reported for -rc1 +/- various patches ;)
>> 
>> Cheers,
>> Grant.
>> --- linux-2.4.33-rc2/fs/namei.c	2006-06-22 07:27:47.000000000 +1000
>> +++ linux-2.4.33-rc2b/fs/namei.c	2006-07-05 11:43:19.000000000 +1000
>> @@ -1497,13 +1497,14 @@
>>  			lock_kernel();
>>  			error = dir->i_op->unlink(dir, dentry);
>>  			unlock_kernel();
>> +			if (!error)
>> +				d_delete(dentry);
>>  		}
>>  	}
>>  	double_up(&dir->i_zombie, &inode->i_zombie);
>>  	iput(inode);
>>  
>>  	if (!error) {
>> -		d_delete(dentry);
>>  		inode_dir_notify(dir, DN_DELETE);
>>  	}
>>  	return error;
>
>after a full day of stress-test of multiple parallel tar xUf, and ffsb at
>full CPU load, I could not reproduce the problem on the exact same kernel
>I first saw it on. So I think I had bad luck and the problem is not related
>to the vfs_unlink() patch, so unless anyone else reports a problem or tells
>us why it is right or wrong, it would seem reasonable to keep it as it is
>in -rc2.

Hi Willy,

Got this with unpatched -rc2, tosh is NFS server, niner is client:

grant@niner:/home/nfstest$ ls -l
total 228474
drwxr-xr-x  19 grant wheel       680 2006-03-20 16:53 linux-2.6.16/
-rw-r--r--   1 grant wheel 233953280 2006-07-05 18:27 linux-2.6.16.tar
drwxr-xr-x  19 grant wheel       680 2006-03-20 16:53 linux-2.6.16b/
grant@niner:/home/nfstest$ x=0; while [ ! $(diff -rq linux-2.6.16 linux-2.6.16b) ]; do ((x++)); echo "trial $x"; rm -rf linux-2.6.16b; mv linux-2.6.16 linux-2.6.16b; tar xf linux-2.6.16.tar; done
trial 1
...
trial 29
rm: cannot remove directory `linux-2.6.16b/drivers/cdrom': Directory not empty
-bash: [: too many arguments
grant@niner:/home/nfstest$ ls -l
total 228474
drwxr-xr-x  19 grant wheel       680 2006-03-20 16:53 linux-2.6.16/
-rw-r--r--   1 grant wheel 233953280 2006-07-05 18:27 linux-2.6.16.tar
drwxr-xr-x   4 grant wheel       104 2006-07-06 11:01 linux-2.6.16b/
grant@niner:/home/nfstest$ rm -rf linux-2.6.16b/

The 'rm -rf linux-2.6.16b' completed okay, a mystery?  

This is with two slow (500MHz) boxen with -rc2.
Only idea I get from logs is during the test:

Jul  5 19:01:19 niner kernel: nfs: server tosh not responding, still trying
Jul  5 19:01:19 niner kernel: nfs: server tosh OK

... about one pair each 2 to 5 mins

Jul  6 11:16:08 niner kernel: nfs: server tosh not responding, still trying
Jul  6 11:16:08 niner kernel: nfs: server tosh OK
Jul  6 11:26:57 niner -- MARK --
Jul  6 11:46:57 niner -- MARK --

Other pair of boxen with patched -rc2 completed 146 trials overnight along 
with compiling 2.4 kernel over NFS as well since morning, 64 completed. 
No 'server not responding messages' logged.

I'll change the two running boxen to straight -rc2 and see if catch 
anything.  

Grant.
