Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261644AbSLaMJO>; Tue, 31 Dec 2002 07:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbSLaMJO>; Tue, 31 Dec 2002 07:09:14 -0500
Received: from mailproxy1.netcologne.de ([194.8.194.222]:8329 "EHLO
	mailproxy1.netcologne.de") by vger.kernel.org with ESMTP
	id <S261644AbSLaMJN> convert rfc822-to-8bit; Tue, 31 Dec 2002 07:09:13 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: =?iso-8859-1?q?J=F6rg=20Prante?= <joergprante@netcologne.de>
Reply-To: joergprante@netcologne.de
To: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: [PATCHSET] 2.4.21-pre2-jp15
Date: Tue, 31 Dec 2002 13:16:08 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, jp-kernel@infolinux.de, gorgo@itc.hu
References: <4.3.2.7.2.20021231104452.00aeaf00@pop.t-online.de>
In-Reply-To: <4.3.2.7.2.20021231104452.00aeaf00@pop.t-online.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212311316.08944.joergprante@netcologne.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Margit,

You are right, I missed the obvious case when preempt is disabled at all. An 
updated patch is here: http://infolinux.de/jp15/076_sysrq-preempt-log-fix-2

The proc_get_inode problem is for a long time now a vanilla kernel problem, 
since the early days of 2.4.

I assume the proc_get_inode function is considered not to be exported because 
the proc fs driver was likely to have race conditions, so Marcelo don't feel 
ok with fixing it. The comx driver is broken with proc fs.

Maybe Gergely Madarasz <gorgo@itc.hu> (comx Maintainer) is going to fix it. My 
favorite solution would be getting rid of proc_get_inode in 
drivers/net/wan/comx.c

Al Viro announced a rework of proc fs a long time ago, I don't know if the 
changes have been made.

http://www.cs.helsinki.fi/linux/linux-kernel/2001-24/0984.html

Willy Tarreau tried a fix in comx, but gave up:

http://www.cs.helsinki.fi/linux/linux-kernel/2002-25/0562.html

Some more URLs from Google:

http://www.cs.helsinki.fi/linux/linux-kernel/2001-12/0677.html
http://www.uwsg.iu.edu/hypermail/linux/kernel/0206.3/0466.html
http://www.cs.helsinki.fi/linux/linux-kernel/2002-37/0063.html
http://hypermail.idiosynkrasia.net/linux-kernel/archived/2002/week37/0122.html
http://www.van-dijk.net/linuxkernel/200218/0359.html.gz

etc.

>From the ChangeLog of 2.4.0prerelease-ac6
o       Fix proc_get_inode export (for comx)            (Hans Grobler)

:-)

Also, the code in comx don't seem to be clean according to this NULL checker 
tool. In fact, de->name is dereferenced without being checked.

[BUG] contra
/u2/engler/mc/oses/linux/2.4.4/drivers/net/wan/comx.c:920:comx_lookup: 
ERROR:INTERNAL_NULL:924:920: [type=set] (set at line 924) Dereferencing NULL 
ptr "de" illegally! [val=400]
{
	struct proc_dir_entry *de;
	struct inode *inode = NULL;

	if ((de = (struct proc_dir_entry *) dir->u.generic_ip) != NULL) {
Error --->
		for (de = de->subdir ; de ; de = de->next) {
			if ((de && de->low_ino) && 
			    (de->namelen == dentry->d_name.len) &&
			    (memcmp(dentry->d_name.name, de->name, 
Start --->
			    de->namelen) == 0))	{
			 	if ((inode = proc_get_inode(dir->i_sb, 
			 	    de->low_ino, de)) == NULL) { 
			 		printk(KERN_ERR "COMX: lookup error\n"); 

I don't have the hardware, so I can't help with a solid fix. While there is no 
good solution, I recommend to disable the driver.

Jörg

