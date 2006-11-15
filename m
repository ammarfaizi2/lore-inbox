Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030715AbWKOREK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030715AbWKOREK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030713AbWKOREK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:04:10 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:59073 "EHLO omx1.sgi.com")
	by vger.kernel.org with ESMTP id S1030709AbWKOREI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:04:08 -0500
Date: Wed, 15 Nov 2006 11:06:34 -0600
From: "Bill O'Donnell" <billodo@sgi.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       Chris Friedhoff <chris@friedhoff.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 1/1] security: introduce fs caps
Message-ID: <20061115170633.GA21345@sgi.com>
References: <20061108222453.GA6408@sergelap.austin.ibm.com> <20061109061021.GA32696@sergelap.austin.ibm.com> <20061109103349.e58e8f51.chris@friedhoff.org> <20061113215706.GA9658@sgi.com> <20061114052531.GA20915@sergelap.austin.ibm.com> <20061114135546.GA9953@sgi.com> <20061114152307.GA7534@sergelap.austin.ibm.com> <455B0357.2050400@ak.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455B0357.2050400@ak.jp.nec.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2006 at 09:08:55PM +0900, KaiGai Kohei wrote:
| Serge E. Hallyn wrote:
| >Quoting Bill O'Donnell (billodo@sgi.com):
| >>8102  execve("/sbin/setfcaps", ["setfcaps", "cap_net_raw=ep", 
| >>"/bin/ping"], [/* 67 vars */]) = 0
|     - snip -
| >>8102  capget(0x19980330, 0, {0, 0, 0})  = -1 EINVAL (Invalid argument)
| >
| >I don't see why this capget is returning -EINVAL.  In fact I don't see
| >why it happens at all - cap_inode_setxattr would check
| >capable(CAP_SYS_ADMIN), but setxattr hasn't been called yet.  Looking at
| >both libcap and setfcaps.c, I don't see where the capget comes from.
| >
| >As for the -EINVAL, kernel/capability.c:sys_capget() returns -EINVAL if
| >the _LINUX_CAPABILITY_VERSION is wrong - you have 0x19980330 which is
| >correct - if pid < 0 - but you send in 0 - or if security_capget
| >returns -EINVAL, which cap_capget (and dummy_capget) don't do.
| >
| >Kaigai, do you have any ideas?
| 
| Bill said that he uses SLES10/ia64, so the version of libcap is different
| from Fedora Core's one. 'libcap-1.92-499.4.src.rpm' is bandled.
| 
| Then, I found a strange code in libcap-1.92-499.4.src.rpm.
| 
| The setfcaps calls cap_from_text() which is defined in libcap to parse
| the command line argument. It has the following function call chains:
| 
| cap_from_text()
|   -> cap_init()
|     -> _libcap_establish_api()

     - snip -

| capget() is called from _libcap_establish_api() with full-zeroed
| __user_cap_header_struct object at first time.
| The result of this, sys_capget() in kernel will return -EINVAL.
| (Why did strace say the first argument is 0x19980330?)
| 
| Probably, Bill didn't update libcap.so.
No, I didn't...
certify:~/libcap-1.10/progs # ls -altr /lib/libcap*
-rwxr-xr-x 1 root root 22672 2006-06-16 09:56 /lib/libcap.so.1.92
-rw-r--r-- 1 root root 53363 2006-11-13 16:04 /lib/libcap.so.1.10
lrwxrwxrwx 1 root root    14 2006-11-13 16:04 /lib/libcap.so.1 ->libcap.so.1.92
lrwxrwxrwx 1 root root    11 2006-11-13 16:04 /lib/libcap.so -> libcap.so.1

| 
| But I can't recommend Bill to update libcap immediately.
| As Hawk Xu said, it may cause a serious problem on the distro
| except Fedora Core 6. :(

What version of libcap is on FC6? 

| 
| I have to recommend to use 'fscaps-1.0-kg.i386.rpm' now.
| It includes the implementation of interaction between application and xattr.
| (Of couse, it's one of the features which should be provided by libcap.)

But that won't work on ia64 will it?

Thanks,
Bill


-- 
Bill O'Donnell
SGI
651.683.3079
billodo@sgi.com
