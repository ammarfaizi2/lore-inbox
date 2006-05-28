Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWE1Sa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWE1Sa0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 14:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWE1Sa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 14:30:26 -0400
Received: from xenotime.net ([66.160.160.81]:31917 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750835AbWE1SaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 14:30:25 -0400
Date: Sun, 28 May 2006 11:32:59 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, akpm@osdl.org,
       serue@us.ibm.com, sam@vilain.net, clg@fr.ibm.com, dev@sw.ru
Subject: Re: [PATCH] POSIX-hostname up to 255 characters
Message-Id: <20060528113259.6a60c351.rdunlap@xenotime.net>
In-Reply-To: <m13bev8tep.fsf@ebiederm.dsl.xmission.com>
References: <20060525204534.4068e730.rdunlap@xenotime.net>
	<m1zmh5b129.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0605261758001.13225@shark.he.net>
	<Pine.LNX.4.58.0605270027070.29434@shark.he.net>
	<m13bev8tep.fsf@ebiederm.dsl.xmission.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 May 2006 07:54:38 -0600 Eric W. Biederman wrote:

> "Randy.Dunlap" <rdunlap@xenotime.net> writes:
> 
> >> > "Randy.Dunlap" <rdunlap@xenotime.net> writes:
> >> >
> >> > > This patch is against 2.6.17-rc5, for review/comments, please.
> >> > > It won't apply to -mm since Andrew has merged the uts-namespace patches.
> >> > > I'll see about merging it with those patches next.
> >> > > ---
> >
> > Per Eric's comments:
> >
> > 1.  use existing sys_gethostname() and sys_sethostname().
> >
> > 2.  add sys_uname_long() to read struct long_utsname;
> >
> > 3.  removed EXPORT_SYMBOL()s
> 
> I have to confess I am still uneasy with sys_uname_long.
> 
> The problem is that we have several revisions of this system
> call almost always simply to accommodate long string lengths,
> and the new interface doesn't seem any less susceptible to
> handling longer strings than the old one.

so you want an interface that is self-describing and extensible?

There are lots of syscalls that require struct pointers
from userspace... that users can get wrong.

Ulrich, do you have any comments/suggestions about this from
the userspace/lib perspective?


> Could we do something like:
> long sys_unamev(int count, char __user **name, size_t name_len)
> {
>         char *table[] = {
> 		system_utsname.sysname,
>                 system_utsname.nodename,
>                 system_utsname.release,
>                 system_utsname.version,
>                 system_utsname.machine,
>                 system_utsname.domainname,
>         };
>         char __user *data;
>         long error;
>         long len;
>         int i;
> 
> 	down_read(&uts_sem);
> 
>         error = -EINVAL;     
>         if (count > 6)
>         	goto out;
> 
>         len = sizeof(char __user *) * count;
>         for (i = 0; i < count; i++) {
>  		len += strlen(table[i]) + 1;
>         }
> 
>         error = -ERANGE;
>         if (len > name_len)
>         	goto out;
> 
>         error = -EFAULT;
>         if (!name)
>         	goto out;
>         if (!access_ok(VERIFY_WRITE, name, name_len))
>         	goto out;
> 
>         error = 0;
>         data = (char __user *)&name[count];
>         for (i = 0; i < count; i++) {
>         	size_t len = strlen(table[i]) + 1;
>                 error |= __put_user(data, name[i]);
>                 error |= __copy_to_user(data, table[i], len);
>                 data += len;
>         }
> out:
> 	up_read(&uts_sem);
>         return error;
> }
> 
> And then in user space we can do.
> struct utsname {
>        char *sysname;
>        char *nodename;
>        char *release;
>        char *version;
>        char *machine;
>        char *domainname;
>        char buf[4096 - (sizeof(char *)*6)];
> };
> 
> int uname(struct utsname *buf)
> {
>         return sys_unamev(6, buf, sizeof(*buf));
> }

---
~Randy
