Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263592AbUFBSlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbUFBSlg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 14:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263799AbUFBSlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 14:41:36 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:9411 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263592AbUFBSlc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 14:41:32 -0400
Subject: Re: 2.6.7-rc2: open() hangs on ReiserFS with SELinux enabled
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Dmitry Baryshkov <mitya@school.ioffe.ru>
Cc: lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@redhat.com>,
       mason@suse.com, jeffm@suse.com
In-Reply-To: <20040602174810.GA31263@school.ioffe.ru>
References: <20040602174810.GA31263@school.ioffe.ru>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1086201647.15871.135.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 02 Jun 2004 14:40:47 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-02 at 13:48, Dmitry Baryshkov wrote:
> Hello,
> 
> I tried enabling SELinux on my Linux-box, using ReiserFS as /, kernel
> 2.6.7-rc2.
> 
> After relabeling and rebooting in non-enforcing mode everything worked
> well, exept the fact, that new files on reiserfs filesystems don't get
> security attributes.
> 
> So I added 'fs_use_xattr reiserfs system_u:object_r:fs_t;' to the policy,
> rebooted and found, that mount hangs during opening of /etc/mtab~<pid>
> (even in non-enforcing mode).
> 
> If I remove that line from SELinux policy, systems boots up OK.
> 
> Here are last lines from #strace mount / -o remount :
> 
> === Cut ===
> open("/etc/mtab~202", O_WRONLY|O_CREAT|O_LARGEFILE, 0600audit(1085949484.378:0): avc:  denied  { write } for  pid=202 exe=/bin/mount name=etc dev=hda5 ino=91 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:etc_t tclass=dir
> audit(1085949484.378:0): avc:  denied  { add_name } for  pid=202 exe=/bin/mount name=etc dev=hda5 ino=91 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:etc_t tclass=dir
> audit(1085949484.378:0): avc:  denied  { create } for  pid=202 exe=/bin/mount name=mtab~202 dev=hda5 ino=91 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:etc_t tclass=file
> === Cut ===
> 
> Tell me, if I need to provide any additional info.

The mount process shouldn't be in kernel_t, although that shouldn't
cause a hang.  Is /sbin/init labeled properly?  Are you using the
patched /sbin/init that loads policy and then re-execs itself into the
proper security domain?

What output did you get from SELinux during initialization, particularly
for hda5?

When the mount process is hung, what output do you get from pressing
ALT-SysRq-t after enabling sysrq (echo 1 > /proc/sys/kernel/sysrq)?

Most likely location for a hang would be when post_create invokes
inode->i_op->setxattr to set the attribute on the newly created file. 
Inode semaphore is taken around the call, as per other invocations of
inode->i_op->setxattr.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

