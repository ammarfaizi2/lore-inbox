Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263601AbTCUMbO>; Fri, 21 Mar 2003 07:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263603AbTCUMbN>; Fri, 21 Mar 2003 07:31:13 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:31763 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S263601AbTCUMbM>;
	Fri, 21 Mar 2003 07:31:12 -0500
Date: Fri, 21 Mar 2003 13:42:13 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Torsten Foertsch <torsten.foertsch@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: current->fs->root vs. current->fs->altroot
Message-ID: <20030321124213.GA9434@win.tue.nl>
References: <200303211116.44735.torsten.foertsch@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303211116.44735.torsten.foertsch@gmx.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 11:16:41AM +0100, Torsten Foertsch wrote:

> can someone please explain the difference between a task's root and altroot.

[below a fragment of some old docs:]

A <tt>struct fs_struct</tt> determines the interpretation
of pathnames referred to by a process (and also, somewhat
illogically, contains the umask). The typical reference
is <tt>current->fs</tt>. The definition lives in <tt>fs_struct.h</tt>:
<tscreen><verb>
struct fs_struct {
        atomic_t count;
        rwlock_t lock;
        int umask;
        struct dentry * root, * pwd, * altroot;
        struct vfsmount * rootmnt, * pwdmnt, * altrootmnt;
};
</verb></tscreen>

Semantics of <tt>root</tt> and <tt>pwd</tt> are clear.
Remains to discuss <tt>altroot</tt>.

<sect1>altroot<p>
In order to support emulation of different operating systems
like BSD and SunOS and Solaris, a small wart has been added
to the <tt>walk_init_root</tt> code that finds the root directory
for a name lookup.

The <tt>altroot</tt> field of an <tt>fs_struct</tt>
is usually NULL. It is a function of the personality
and the current root, and the <tt>sys_personality</tt>
and <tt>sys_chroot</tt> system calls call <tt>set_fs_altroot()</tt>.

The effect is determined at kernel compile time.
One can define <tt>__emul_prefix()</tt> in <tt>&lt;asm/namei.h&gt;</tt>
as some pathname, say <tt>"usr/gnemul/myOS/"</tt>.
The default is NULL, but some architectures have a
definition depending on <tt>current->personality</tt>.
If this prefix is non-NULL, and the corresponding file is found,
then <tt>set_fs_altroot()</tt> will set the <tt>altroot</tt>
and <tt>altrootmnt</tt> fields of <tt>current->fs</tt>
to dentry and vfsmnt of that file.

A subsequent lookup of a pathname starting with '/' will now
first try to use the altroot. If that fails the usual root is used.

