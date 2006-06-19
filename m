Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWFSFEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWFSFEI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 01:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWFSFEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 01:04:08 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:7632 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750835AbWFSFEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 01:04:06 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Linux 2.4.33-rc1
Date: Mon, 19 Jun 2006 15:03:58 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <fvbc92higiliou420n3ctjfecdl5leb49o@4ax.com>
References: <20060616181419.GA15734@dmt> <hka6925bl0in1f3jm7m4vh975a64lcbi7g@4ax.com> <20060618133718.GA2467@dmt> <ksib9210010mt9r3gjevi3dhlp4biqf59k@4ax.com> <20060618223736.GA4965@1wt.eu> <dmlb92lmehf2jufjuk8emmh63afqfmg5et@4ax.com> <20060619040152.GB2678@1wt.eu>
In-Reply-To: <20060619040152.GB2678@1wt.eu>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="--=_u1cc92h4fqemi4p2e0qk6b06eua3pa79c0.MFSBCHJLHS"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----=_u1cc92h4fqemi4p2e0qk6b06eua3pa79c0.MFSBCHJLHS
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 19 Jun 2006 06:01:52 +0200, Willy Tarreau <w@1wt.eu> wrote:

>On Mon, Jun 19, 2006 at 09:07:03AM +1000, Grant Coady wrote:
>> On Mon, 19 Jun 2006 00:37:36 +0200, Willy Tarreau <w@1wt.eu> wrote:
>> 
>> >Hi Grant,
>> >
>> >On Mon, Jun 19, 2006 at 08:25:06AM +1000, Grant Coady wrote:
>> >> On Sun, 18 Jun 2006 10:37:18 -0300, Marcelo Tosatti <marcelo@kvack.org> wrote:
>> >> 
>> >> >Can you please try the attached patch.
>> >> >
>> >> >Grab a reference to the victim inode before calling vfs_unlink() to avoid
>> >> >it vanishing under us.
>> >> >
>> >> >diff --git a/fs/namei.c b/fs/namei.c
>> >> >index 42cce98..7993283 100644
>> >> >--- a/fs/namei.c
>> >> >+++ b/fs/namei.c
>> >> >@@ -1509,6 +1509,7 @@ asmlinkage long sys_unlink(const char * 
>> >> > 	char * name;
>> >> > 	struct dentry *dentry;
>> >> > 	struct nameidata nd;
>> >> >+	struct inode *inode = NULL;
>> >> > 
>> >> > 	name = getname(pathname);
>> >> > 	if(IS_ERR(name))
>> >> >@@ -1527,11 +1528,16 @@ asmlinkage long sys_unlink(const char * 
>> >> > 		/* Why not before? Because we want correct error value */
>> >> > 		if (nd.last.name[nd.last.len])
>> >> > 			goto slashes;
>> >> >+		inode = dentry->d_inode;
>> >> >+		if (inode)
>> >> >+			atomic_inc(&inode->i_count);
>> >> > 		error = vfs_unlink(nd.dentry->d_inode, dentry);
>> >> > 	exit2:
>> >> > 		dput(dentry);
>> >> > 	}
>> >
>> >Could you add this line here, because your oops still looks like the NULL
>> >is close to this area :
>> >
>> >+       printk(KERN_DEBUG "nd.dentry->d_inode = %p\n", nd.dentry->d_inode);
>> 
>> It didn't get there for the segfault case, gets there for local file 
>> delete 
>> 
>> After:
>> grant@sempro:~$ dmesg >dmesg
>> grant@sempro:~$ rm dmesg
>> 
>> Jun 19 08:49:17 sempro kernel: nd.dentry->d_inode = f73f4b80
>> 
>> After:
>> grant@sempro:~$ dmesg >/home/share/dmesg-test
>> grant@sempro:~$ rm /home/share/dmesg-test
>> Segmentation fault
>> 
>> Nothing reported by debug or syslog, oops in messages.
>
>Thanks. Then, could you send us your 'namei.o' file please ? Mine does
>not produce the same content as yours and it makes it difficult to find
>the exact position in the code.

gzipped, attached.

Cheers,
Grant.

----=_u1cc92h4fqemi4p2e0qk6b06eua3pa79c0.MFSBCHJLHS
Content-Type: application/octet-stream; name=fs-namei.o.gz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=fs-namei.o.gz

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
fwO7RoSJwE8AAA==

----=_u1cc92h4fqemi4p2e0qk6b06eua3pa79c0.MFSBCHJLHS--
