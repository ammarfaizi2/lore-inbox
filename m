Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVA0ClW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVA0ClW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 21:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbVA0Cii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 21:38:38 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:43924 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261954AbVA0Cdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 21:33:32 -0500
Message-ID: <41F8530C.6010305@comcast.net>
Date: Wed, 26 Jan 2005 21:33:48 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: /proc parent &proc_root == NULL?
References: <41F82218.1080705@comcast.net> <41F84313.4030509@osdl.org>
In-Reply-To: <41F84313.4030509@osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Randy.Dunlap wrote:
> John Richard Moser wrote:
> 
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> proc_misc_init() has both these lines in it:
>>
>> entry = create_proc_entry("kmsg", S_IRUSR, &proc_root);
>> proc_root_kcore = create_proc_entry("kcore", S_IRUSR, NULL);
>>
>> Both entries show up in /proc, as /proc/kmsg and /proc/kcore.  So I ask,
>> as I can't see after several minutes of examination, what's the
>> difference?  Why is NULL used for some and &proc_root used for others?
>>
>> I'm looking at 2.6.10
> 
> 
> create_proc_entry() passes &parent to proc_create().
> See proc_create():
> ...
> This is an error path:
>     if (!(*parent) && xlate_proc_name(name, parent, &fn) != 0)
>         goto out;
> but xlate_proc_name() searches for a /proc/.... and returns the
> all-but-final-part-of-name *parent (hope that makes some sense,
> see the comments above the function), so it returns &proc_root.
> 
> HTH.  If not, fire back.

create_proc_entry("kmsg", S_IRUSR, &proc_root);

So this is asking for proc_root to be filled?

create_proc_entry("kcore", S_IRUSR, NULL);

And this is just saying to shove it in proc's root?


I'm trying to locate a specific proc entry, using this lovely piece of
code I ripped off:

/*
 * Find a proc entry
 * Duplicated from remove_proc_entry()
 */
struct proc_dir_entry **get_proc_entry(const char *name, struct
proc_dir_entry *parent) {
        struct proc_dir_entry **p;
        const char *fn = name;
        int len;
        if (!parent && xlate_proc_name(name, &parent, &fn) != 0)
                goto out;
        len = strlen(fn);
        for (p = &parent->subdir; *p; p=&(*p)->next ) {
                if (!proc_match(len, fn, *p))
                        continue;
                return p;
        }
out:
        return NULL;
}


And I'm trying to figure out if, say, /proc/devices would be found by...

get_proc_entry("devices",NULL);
- -OR-
get_proc_entry("devices",&proc_root);

Oh well.  I'll figure it out eventually.  :)  I've already caused my
kernel to not boot :) figured it out too, it was that very function
above; I replaced a chunk of remove_proc_entry() with a modified version
of that and I'd busted it horribly so it didn't work.  Just more things
to remind me that I know not what it is I do.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+FMLhDd4aOud5P8RAp1XAJ9j+ezlZgYuXpTmeaNSlQcC3xkb+ACaAjA8
D3NEZH4Drey2nuMCXZwK6sE=
=o5P7
-----END PGP SIGNATURE-----
