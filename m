Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262429AbVA0Df2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbVA0Df2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 22:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbVA0Df2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 22:35:28 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:29835 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262429AbVA0De6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 22:34:58 -0500
Message-ID: <41F86176.3010000@comcast.net>
Date: Wed, 26 Jan 2005 22:35:18 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: /proc parent &proc_root == NULL?
References: <41F82218.1080705@comcast.net> <41F84313.4030509@osdl.org> <41F8530C.6010305@comcast.net> <20050127031539.GK8859@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050127031539.GK8859@parcelfarce.linux.theplanet.co.uk>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Al Viro wrote:
> On Wed, Jan 26, 2005 at 09:33:48PM -0500, John Richard Moser wrote:
> 
>>create_proc_entry("kmsg", S_IRUSR, &proc_root);
>>
>>So this is asking for proc_root to be filled?
>>
>>create_proc_entry("kcore", S_IRUSR, NULL);
>>
>>And this is just saying to shove it in proc's root?
> 
> 
> NULL is equivalent to &proc_root in that context; moreover, it's better
> style - drivers really shouldn't be refering to what is procfs-private
> object.
> 
> 
>>I'm trying to locate a specific proc entry, using this lovely piece of
>>code I ripped off:
> 
> 
> That's not something allowed outside of procfs code - lifetime rules
> alone make that a Very Bad Idea(tm).  If that's just debugging - OK,
> but if your code really uses that stuff, I want details on the intended
> use.  In that case your design is almost certainly asking for trouble.
> 

I'm trying to implement parts of grsecurity on top of a framework
similar to LSM (i.e. ripoff) that I wrote as an academic endeavor to
find out how stuff works and get some real-life kernel coding experience.

This particular problem pertains to proc_misc.c and trying to create a
hook for some grsecurity protections that alter the modes on certain
/proc entries.  The chunk of the patch I'm trying to immitate is:


diff -urNp linux-2.6.10/fs/proc/proc_misc.c linux-2.6.10/fs/proc/proc_misc.c
- --- linux-2.6.10/fs/proc/proc_misc.c    2004-12-24 16:34:00 -0500
+++ linux-2.6.10/fs/proc/proc_misc.c    2005-01-08 15:53:52 -0500
@@ -582,6 +582,8 @@ static void create_seq_entry(char *name,
 void __init proc_misc_init(void)
 {
        struct proc_dir_entry *entry;
+       int gr_mode = 0;
+
        static struct {
                char *name;
                int (*read_proc)(char*,char**,off_t,int,int*,void*);
@@ -596,9 +598,13 @@ void __init proc_misc_init(void)
 #ifdef CONFIG_STRAM_PROC
                {"stram",       stram_read_proc},
 #endif
+#ifndef CONFIG_GRKERNSEC_PROC_ADD
                {"devices",     devices_read_proc},
+#endif
                {"filesystems", filesystems_read_proc},
+#ifndef CONFIG_GRKERNSEC_PROC_ADD
                {"cmdline",     cmdline_read_proc},
+#endif
                {"locks",       locks_read_proc},
                {"execdomains", execdomains_read_proc},
                {NULL,}
@@ -606,27 +612,45 @@ void __init proc_misc_init(void)
        for (p = simple_ones; p->name; p++)
                create_proc_read_entry(p->name, 0, NULL, p->read_proc,
NULL);

+#ifdef CONFIG_GRKERNSEC_PROC_USER
+       gr_mode = S_IRUSR;
+#elif CONFIG_GRKERNSEC_PROC_USERGROUP
+       gr_mode = S_IRUSR | S_IRGRP;
+#endif
+#ifdef CONFIG_GRKERNSEC_PROC_ADD
+       create_proc_read_entry("devices", gr_mode, NULL,
&devices_read_proc, NULL);
+       create_proc_read_entry("cmdline", gr_mode, NULL,
&cmdline_read_proc, NULL);
+#endif
+
        proc_symlink("mounts", NULL, "self/mounts");

        /* And now for trickier ones */
        entry = create_proc_entry("kmsg", S_IRUSR, &proc_root);
        if (entry)
                entry->proc_fops = &proc_kmsg_operations;
+#ifdef CONFIG_GRKERNSEC_PROC_ADD
+       create_seq_entry("cpuinfo", gr_mode, &proc_cpuinfo_operations);
+#else
        create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
+#endif
        create_seq_entry("partitions", 0, &proc_partitions_operations);
        create_seq_entry("stat", 0, &proc_stat_operations);
        create_seq_entry("interrupts", 0, &proc_interrupts_operations);
+#ifdef CONFIG_GRKERNSEC_PROC_ADD
+
create_seq_entry("slabinfo",S_IWUSR|gr_mode,&proc_slabinfo_operations);
+#else

create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
+#endif
        create_seq_entry("buddyinfo",S_IRUGO,
&fragmentation_file_operations);
        create_seq_entry("vmstat",S_IRUGO, &proc_vmstat_file_operations);
        create_seq_entry("diskstats", 0, &proc_diskstats_operations);
 #ifdef CONFIG_MODULES
- -       create_seq_entry("modules", 0, &proc_modules_operations);
+       create_seq_entry("modules", gr_mode, &proc_modules_operations);
 #endif
 #ifdef CONFIG_SCHEDSTATS
        create_seq_entry("schedstat", 0, &proc_schedstat_operations);
 #endif
- -#ifdef CONFIG_PROC_KCORE
+#if defined(CONFIG_PROC_KCORE) && !defined(CONFIG_GRKERNSEC_PROC_ADD)
        proc_root_kcore = create_proc_entry("kcore", S_IRUSR, NULL);
        if (proc_root_kcore) {
                proc_root_kcore->proc_fops = &proc_kcore_operations;


The above I've been trying to create a security hook for to test out.
I've learned much already, like that breaking proc breaks your system
and causes panics.  :)

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+GF1hDd4aOud5P8RAvwKAJ9nPyuifIDloGyNGwNMuCfGvXMKswCgkIHE
kCr8U80DJJWfRSVJTZbXaMs=
=MDiz
-----END PGP SIGNATURE-----
