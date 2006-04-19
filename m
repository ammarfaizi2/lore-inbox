Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWDSVLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWDSVLV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 17:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWDSVLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 17:11:21 -0400
Received: from victor.provo.novell.com ([137.65.250.26]:50644 "EHLO
	victor.provo.novell.com") by vger.kernel.org with ESMTP
	id S1751230AbWDSVLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 17:11:20 -0400
Message-ID: <4446A74F.5010100@novell.com>
Date: Wed, 19 Apr 2006 14:10:39 -0700
From: Crispin Cowan <crispin@novell.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yuichi Nakamura <ynakam@gwu.edu>
CC: "Serge E. Hallyn" <serue@us.ibm.com>, Kurt Garloff <garloff@suse.de>,
       Christoph Hellwig <hch@infradead.org>, Gerrit Huizenga <gh@us.ibm.com>,
       James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
References: <20060417225525.GA17463@infradead.org> <E1FVfGt-0003Wy-00@w-gerrit.beaverton.ibm.com> <20060418115819.GB8591@infradead.org> <20060418213833.GC5741@tpkurt.garloff.de> <20060419121034.GE20481@sergelap.austin.ibm.com> <e133c9da8fcba.8fcbae133c9da@gwu.edu>
In-Reply-To: <e133c9da8fcba.8fcbae133c9da@gwu.edu>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yuichi Nakamura wrote:
> "Serge E. Hallyn" wrote:
>   
>> Have you ever tried, at 4pm some afternoon, sitting in a room with 
>> somepaper and implementing the AA user interface on top of selinux?
>>     
> We've implemented AppArmor like configuration on top of SELinux.
> SELinux Policy Editor(http://seedit.sourceforge.net/) does this.
>   
This is a fascinating piece of work. A compiler to compile
(approximately) AppArmor policies into SELinux policies.

> Above is converted into SELinux Policy language.
> Types, allow rules,domain transision rules are generated.
>   
Does it label the file system as well? If not, then the path names you
can specify with different access rights would be very limited. If so,
then any change to the policy requires a relabellings.

> It works, and can also restrict IPC and privilege other than POSIX
> capability(because it is based on SELinux).
>   
We have plans to enhance AppArmor to mediate IPC and network access.
Some of these plans are constrained by the limits of LSM, and once
AppArmor is in-tree, we hope to propose some LSM enhancements to make
that work better.

> However, path-name based configuration can not be achieved on SELinux in
> following cases.
> 1) Files on file system that does not support xattr(such as sysfs)
>    SELinux policy editor handles all files as same on such file systems.
>   
More than just sysfs. All network attached storage (NFS mounted file
systems) cannot support xattr. One could imagine supporting xattr for
Linux-based NFS servers, but that just won't work for non-linux storage
servers.

As a consequence, SELinux policies can only grant all-or-nothing access
to the entire NFS-mounted file system. This is a big deal for larger
data centers, where everything is in network attached storage, and Linux
is fighting its way in. Pathname based access control gives you much
finer granularity of access control on which NFS mounted files an
application can access.

Note that the insecurity of NFS due to lack of authentication is
irrelevant here. Access controls on an NFS server would be insecure
because the clients are spoofable. However, what AppArmor does is
constrain an application on the NFS client with respect to which
*imported* files it can access.

> 2) Files that are dynamically created/deleted(inode number is not fixed).
>    Example is files on /tmp and /etc/mtab. SELinux Policy Editor is
> using file type transition to configure access control for them.
>   
This also is an important distinction. AppArmor can specify policy for
files that don't exist yet. SELinux can specify policy for files that
don't exist yet, but only in so far as you can write TE rules for labels
that do exist, and will be applied to the files when they are created.

Suppose we want to write a profile for fingerd. In AppArmor, the rule
would be "/home/*/.plan r" to grant read access to everyone's .plan
file. Some people don't have a .plan file, but they do create them ad
hoc as time goes on. What does seedit do in that case?

A more problematic case in classic SELinux is personal public_html
directories
http://fedora.redhat.com/docs/selinux-apache-fc3/sn-simple-setup.html

The goal is to allow Apache to access everyone's public_html directory,
but not the rest of their homedir files. The problem is that each file
can only have a *single* label on it, and so what label to put on
public_html directories and their contents?

    * If you choose user_homedir_t then either
          o Apache cannot access public_html directories at all, or
          o Apache gets access to all user homedir contents, including
            potentially nasty secrets. Not so nice to have your personal
            secrets leaked out through the web server.
    * If you choose httpd_sys_content_t then either
          o Users cannot access their own public_html directories, which
            is useless, or
          o Users can write to the system web pages, which means any
            user can change the system home page.

None of the above alternatives are pretty. To solve this problem in a
labeled system, you would have to have some way of attaching more than
one label to a single file. You can fake that by creating a software MUX
that encodes multiple labels into a single label, but that creates an
explosion in the number of labels. You have to have a new MUX for every
system daemon that needs to access homedir contents. There is also the
problem that the public_html directory might be removed and re-created
by the user, resulting in it automatically inheriting the user_homedir_t
label.

This page http://fedora.redhat.com/docs/selinux-faq-fc5/#id2978458
solves the problem by labeling public_html with httpd_user_content_t.
This eliminates the need for a MUX by applying the same label to all
user public_html directories. But it is unclear which applications can
author httpd_user_content_t content -- and i'm not sure if users are
allowed to relabel their files.

Or you can use an AppArmor rule of "/home/*/public_html/** r".

Crispin
-- 
Crispin Cowan, Ph.D.                      http://crispincowan.com/~crispin/
Director of Software Engineering, Novell  http://novell.com

