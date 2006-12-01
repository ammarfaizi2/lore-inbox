Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031752AbWLAT2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031752AbWLAT2A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 14:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031750AbWLAT2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 14:28:00 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:5043 "EHLO omx1.sgi.com")
	by vger.kernel.org with ESMTP id S1031741AbWLAT17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 14:27:59 -0500
Date: Fri, 1 Dec 2006 13:28:58 -0600
From: "Bill O'Donnell" <billodo@sgi.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Chris Friedhoff <chris@friedhoff.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] Implement file posix capabilities
Message-ID: <20061201192858.GA4798@sgi.com>
References: <20061127170740.GA5859@sergelap.austin.ibm.com> <20061129112848.8e48267e.chris@friedhoff.org> <20061129204013.GA7228@sgi.com> <20061130180502.GA20345@sgi.com> <20061130225707.GA23379@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130225707.GA23379@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 04:57:07PM -0600, Serge E. Hallyn wrote:
| Quoting Bill O'Donnell (billodo@sgi.com):
| > The memory fault when setfcaps is run as noted in #4 below also occurs
| > on RHEL5 IA64 (2.6.18 kernel-2.6.18-1.2747.el5 with Serge's capability patch,
| > and Kaigai's userspace tools installed).
| > 
| > On Wed, Nov 29, 2006 at 02:40:13PM -0600, Bill O'Donnell wrote:
| > | Once again, running into problems when trying this patch on SLES-10 IA64,
| > | (Linux certify 2.6.18 #2 SMP PREEMPT Wed Nov 29 13:11:28 CST 2006 ia64)
| > |
| > | 1) replaced the ancient /lib/libcap.so.1.92 with less ancient libcap.so.1.10
| > |
| > | 2) successfully applied Serge's patch to SLES 2.6.18 sources and rebooted
| > |
| > | 3) installed Kaigai's userspace tools... no problems evident
| > |
| > | 4) ran setfcaps to see capabilities... (note Memory fault):
| > |
| > | certify:~/libcap-1.10 # setfcaps
| > | usage: setfcaps <capabilities> <file> ...
| > |         cap_chown, cap_dac_override, cap_dac_read_search, cap_fowner
| > | 	cap_fsetid, cap_kill, cap_setgid, cap_setuid
| > | 	cap_setpcap, cap_linux_immutable,
| > | 	cap_net_bind_service, cap_net_broadcast
| > |         cap_net_admin, cap_net_raw, cap_ipc_lock, cap_ipc_owner
| > | 	cap_sys_module, cap_sys_rawio, cap_sys_chroot, cap_sys_ptrace
| > | 	cap_sys_pacct, cap_sys_admin, cap_sys_boot, cap_sys_nice
| > | 	cap_sys_resource, cap_sys_time,
| > | 	cap_sys_tty_config, cap_mknod
| > |         cap_lease, cap_audit_write, cap_audit_controlMemory fault
| 
| Ah, this actually makes sense.  The setfcaps usage() statement does
| 
| 	for (i=0; _cap_names[i]; i++) {
| 		printf...
| 
| so it expects _cap_names to end with a terminating NULL, but that
| doesn't seem to be the case in cap_names.h in libcap.
| 
| KaiGai, perhaps setfcaps should do something like
| 
| diff setfcaps.c.orig setfcaps.c
| 25c25
| <     for (i=0; _cap_names[i]; i++)
| ---
| >     for (i=0; i<__CAP_BITS; i++)

I brute-force hardcoded the limit on this for loop (i< 31), and rebuilt
Kaigai's tools, and retested (again, on this RHEL5 IA64 target.  It all
works now.  I ran through Chris Friedhoff's "test protocol", and it
went swimmingly (http://www.friedhoff.org/fscaps.html).

Then I went back to my SLES-10 IA64 target, and repeated the fixup for
Kaigai's tools.  It now works, providing I changeout the antique 
libcap.so.92 for newer libcap.so.10 (why the version number is lower is 
beyond me).

So, for my limited IA64 test target set, the following are true, 
providing Serge's capabilities kernel patch is applied, and Kaigai's 
userspace tools are utilized (obviously with the brute-force hack 
to setfcaps.c):

1) RHEL5 - libcap.so.10 is "stock":  
   caps patch and hacked u-space tools PASS the tests.

2) SLES10 - libcap.so.92 is "stock": 
   caps patch and hacked u-space tools FAIL the tests.

3) SLES10 - "stock" libcap.so.92 replaced with newer libcap.so.10: 
   caps patch and hacked u-space tools PASS the tests.


The question that remains unanswered: why is SLES using such an old
libcap, and are they likely to replace it with the more accepted
version (libcap.so.10) soon?

Thanks,
-Bill

-- 
Bill O'Donnell
SGI
billodo@sgi.com
