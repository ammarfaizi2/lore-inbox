Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751531AbWE0N4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbWE0N4c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 09:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbWE0N4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 09:56:32 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57017 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751530AbWE0N4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 09:56:32 -0400
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, drepper@redhat.com,
       akpm <akpm@osdl.org>, serue@us.ibm.com, sam@vilain.net, clg@fr.ibm.com,
       dev@sw.ru
Subject: Re: [PATCH] POSIX-hostname up to 255 characters
References: <20060525204534.4068e730.rdunlap@xenotime.net>
	<m1zmh5b129.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0605261758001.13225@shark.he.net>
	<Pine.LNX.4.58.0605270027070.29434@shark.he.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 27 May 2006 07:54:38 -0600
In-Reply-To: <Pine.LNX.4.58.0605270027070.29434@shark.he.net> (Randy
 Dunlap's message of "Sat, 27 May 2006 00:36:23 -0700 (PDT)")
Message-ID: <m13bev8tep.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> writes:

>> > "Randy.Dunlap" <rdunlap@xenotime.net> writes:
>> >
>> > > This patch is against 2.6.17-rc5, for review/comments, please.
>> > > It won't apply to -mm since Andrew has merged the uts-namespace patches.
>> > > I'll see about merging it with those patches next.
>> > > ---
>
> Per Eric's comments:
>
> 1.  use existing sys_gethostname() and sys_sethostname().
>
> 2.  add sys_uname_long() to read struct long_utsname;
>
> 3.  removed EXPORT_SYMBOL()s

I have to confess I am still uneasy with sys_uname_long.

The problem is that we have several revisions of this system
call almost always simply to accommodate long string lengths,
and the new interface doesn't seem any less susceptible to
handling longer strings than the old one.

Could we do something like:
long sys_unamev(int count, char __user **name, size_t name_len)
{
        char *table[] = {
		system_utsname.sysname,
                system_utsname.nodename,
                system_utsname.release,
                system_utsname.version,
                system_utsname.machine,
                system_utsname.domainname,
        };
        char __user *data;
        long error;
        long len;
        int i;

	down_read(&uts_sem);

        error = -EINVAL;     
        if (count > 6)
        	goto out;

        len = sizeof(char __user *) * count;
        for (i = 0; i < count; i++) {
 		len += strlen(table[i]) + 1;
        }

        error = -ERANGE;
        if (len > name_len)
        	goto out;

        error = -EFAULT;
        if (!name)
        	goto out;
        if (!access_ok(VERIFY_WRITE, name, name_len))
        	goto out;

        error = 0;
        data = (char __user *)&name[count];
        for (i = 0; i < count; i++) {
        	size_t len = strlen(table[i]) + 1;
                error |= __put_user(data, name[i]);
                error |= __copy_to_user(data, table[i], len);
                data += len;
        }
out:
	up_read(&uts_sem);
        return error;
}

And then in user space we can do.
struct utsname {
       char *sysname;
       char *nodename;
       char *release;
       char *version;
       char *machine;
       char *domainname;
       char buf[4096 - (sizeof(char *)*6)];
};

int uname(struct utsname *buf)
{
        return sys_unamev(6, buf, sizeof(*buf));
}

Eric
