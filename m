Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268135AbUIKMa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268135AbUIKMa0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 08:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268136AbUIKMa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 08:30:26 -0400
Received: from open.hands.com ([195.224.53.39]:46488 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S268135AbUIKM3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 08:29:55 -0400
Date: Sat, 11 Sep 2004 13:41:06 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6 NETFILTER] new netfilter module ipt_program.c
Message-ID: <20040911124106.GD24787@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: sss
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

decided to put this into a separate module.  based on ipt_owner.c.
does full program's pathname.  like ipt_owner, only suitable for
outgoing connections.

userspace-netfilter-patch sent to bugs.debian.org (270852).

as was kindly pointed out already, dealing with per-program
per-packet filtering is at least O(N*M) and some cacheing
would help.

... but it's better than O(N*M*L) in userspace (in fireflier's
present ip_queueing userspace code).

issue of where new function proc_task_dentry_lookup() should
go is still outstanding and i don't have the knowledge or authority
to say or even advise most appropriate location.

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=f

Index: net/ipv4/netfilter/Kconfig
===================================================================
RCS file: /cvsroot/selinux/nsa/linux-2.6/net/ipv4/netfilter/Kconfig,v
retrieving revision 1.1.1.7
diff -u -u -r1.1.1.7 Kconfig
--- net/ipv4/netfilter/Kconfig	13 May 2004 18:03:22 -0000	1.1.1.7
+++ net/ipv4/netfilter/Kconfig	11 Sep 2004 12:17:53 -0000
@@ -256,6 +256,15 @@
 
 	  To compile it as a module, choose M here.  If unsure, say N.
 
+config IP_NF_MATCH_PROGRAM
+	tristate "Full program pathname match support"
+	depends on IP_NF_IPTABLES
+	help
+	  Packet program name matching allows you to match locally-generated packets
+	  based on the full path name of the program that generated them.
+
+	  To compile it as a module, choose M here.  If unsure, say N.
+
 config IP_NF_MATCH_OWNER
 	tristate "Owner match support"
 	depends on IP_NF_IPTABLES
Index: net/ipv4/netfilter/Makefile
===================================================================
RCS file: /cvsroot/selinux/nsa/linux-2.6/net/ipv4/netfilter/Makefile,v
retrieving revision 1.1.1.3
diff -u -u -r1.1.1.3 Makefile
--- net/ipv4/netfilter/Makefile	13 May 2004 18:03:22 -0000	1.1.1.3
+++ net/ipv4/netfilter/Makefile	11 Sep 2004 12:17:53 -0000
@@ -50,6 +50,7 @@
 obj-$(CONFIG_IP_NF_MATCH_PKTTYPE) += ipt_pkttype.o
 obj-$(CONFIG_IP_NF_MATCH_MULTIPORT) += ipt_multiport.o
 obj-$(CONFIG_IP_NF_MATCH_OWNER) += ipt_owner.o
+obj-$(CONFIG_IP_NF_MATCH_PROGRAM) += ipt_program.o
 obj-$(CONFIG_IP_NF_MATCH_TOS) += ipt_tos.o
 
 obj-$(CONFIG_IP_NF_MATCH_RECENT) += ipt_recent.o
Index: security/selinux/hooks.c

--qDbXVdCdHGoSgWSk
Content-Type: text/x-chdr; charset=us-ascii
Content-Disposition: attachment; filename="ipt_program.h"

#ifndef _IPT_PROGRAM_H
#define _IPT_PROGRAM_H

/* lkcl: whilst most people would care about path names being their
 * full length; whilst some people would want code that allocated
 * the program name in a dynamic size buffer, i don't give a stuff:
 * i just need something that works, and 256 chars is plenty to
 * fit "/usr/lib/mozilla-firefox/bin/firefox-bin" and "/usr/bin/lynx"
 * and "/usr/bin/kdeinit".
 */
#define IPT_PROGNAME_SZ 256

struct ipt_program_info {

	char full_exe_path[IPT_PROGNAME_SZ];

    u_int8_t invert;	/* flags */
};

#endif /*_IPT_PROGRAM_H*/

--qDbXVdCdHGoSgWSk
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="ipt_program.c"

/* Kernel module to match the program name tied to sockets associated with
   locally generated outgoing packets.
   
   */

/*
 * (C) 2004 Luke Kenneth Casson Leighton <lkcl@lkcl.net>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * Module based on ipt_owner.c, by Mark Boucher.
 *
 * (C) 2000 Marc Boucher <marc@mbsi.ca>
 */

#include <linux/module.h>
#include <linux/skbuff.h>
#include <linux/file.h>
#include <linux/rwsem.h>
#include <linux/mount.h>
#include <linux/dcache.h>
#include <linux/string.h>
#include <linux/sched.h>
#include <net/sock.h>

#include <linux/netfilter_ipv4/ipt_program.h>
#include <linux/netfilter_ipv4/ip_tables.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Luke Kenneth Casson Leighton <lkcl@lkcl.net>");
MODULE_DESCRIPTION("iptables program match");

/* lkcl: this function is in fs/proc/base.c.  it's a generic function
 * derived from proc_exe_link().  it's inappropriate to leave that
 * function in fs/proc/base.c.  but i don't care: i don't have the
 * knowledge to say where it should go.  therefore i'm leaving
 * it in fs/proc/base.c.
 */
extern int proc_task_dentry_lookup(struct task_struct *task,
		                           struct dentry **dentry, 
								   struct vfsmount **mnt);

/*
 * look up the dentry (for the inode) of the task's executable,
 * plus lookup the mountpoint of the filesystem from where that
 * executable came from.   then do exactly the same socket checking
 * that all the other checks seem to be doing.
 */
static int proc_exe_check(struct task_struct *task, 
		                  const char *prog_full_name)
{
    int result;
	struct vfsmount *mnt;
    struct dentry *dentry;
	char exe_path[IPT_PROGNAME_SZ];
	char *p;

	result = proc_task_dentry_lookup(task, &dentry, &mnt);
	if (result != 0)
		return result;

	/* turn the task info (dentry + mountpoint) into a program name... */
	p = d_path(dentry, mnt, exe_path, sizeof(exe_path));
    if (p == ERR_PTR(-ENAMETOOLONG))
		return -1;

    printk("ipt_program: program name %s\n", prog_full_name);
	return strncmp(p, prog_full_name, sizeof(exe_path));
}

static int
match_inode(const struct sk_buff *skb, const char *prog_full_name)
{
	struct task_struct *g, *p;
	struct files_struct *files;
	int i;

	read_lock(&tasklist_lock);
	do_each_thread(g, p) {

		if (proc_exe_check(p, prog_full_name))
			continue;

        //printk("ipt_program: program name %s matched, now looking for socket...\n", prog_full_name);

		task_lock(p);
		files = p->files;
		if(files) {
			spin_lock(&files->file_lock);
			for (i=0; i < files->max_fds; i++) {
				if (fcheck_files(files, i) ==
				    skb->sk->sk_socket->file) {
					spin_unlock(&files->file_lock);
					task_unlock(p);
					read_unlock(&tasklist_lock);
					printk("ipt_program: program name %s matched\n", prog_full_name);
					return 1;
				}
			}
			spin_unlock(&files->file_lock);
		}
		task_unlock(p);
	} while_each_thread(g, p);
	read_unlock(&tasklist_lock);
	return 0;
}


static int
match(const struct sk_buff *skb,
      const struct net_device *in,
      const struct net_device *out,
      const void *matchinfo,
      int offset,
      int *hotdrop)
{
	const struct ipt_program_info *info = matchinfo;

    printk("ipt_program...\n");

	if (!skb->sk || !skb->sk->sk_socket || !skb->sk->sk_socket->file)
	{
    	printk("ipt_program: not enough info, no sk, no sk_socket, no file\n");
		return 0;
	}

	if (!match_inode(skb, info->full_exe_path) ^
		    !!info->invert)
		return 0;

	return 1;
}

static int
checkentry(const char *tablename,
           const struct ipt_ip *ip,
           void *matchinfo,
           unsigned int matchsize,
           unsigned int hook_mask)
{
        if (hook_mask
            & ~((1 << NF_IP_LOCAL_OUT) | (1 << NF_IP_POST_ROUTING))) {
                printk("ipt_program: warning - code based on ipt_owner, which is only valid for LOCAL_OUT or POST_ROUTING.  continuing at your own risk!\n");
                /*return 0;*/
        }

	if (matchsize != IPT_ALIGN(sizeof(struct ipt_program_info))) {
		printk("Matchsize %u != %Zu\n", matchsize,
		       IPT_ALIGN(sizeof(struct ipt_program_info)));
		return 0;
	}

	return 1;
}

static struct ipt_match program_match = {
	.name		= "program",
	.match		= &match,
	.checkentry	= &checkentry,
	.me		= THIS_MODULE,
};

static int __init init(void)
{
	return ipt_register_match(&program_match);
}

static void __exit fini(void)
{
	ipt_unregister_match(&program_match);
}

module_init(init);
module_exit(fini);

--qDbXVdCdHGoSgWSk--
