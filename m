Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030411AbWKOMMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbWKOMMZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 07:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbWKOMMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 07:12:25 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:62367 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1030393AbWKOMMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 07:12:23 -0500
Message-ID: <455B0357.2050400@ak.jp.nec.com>
Date: Wed, 15 Nov 2006 21:08:55 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: "Bill O'Donnell" <billodo@sgi.com>, Chris Friedhoff <chris@friedhoff.org>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 1/1] security: introduce fs caps
References: <20061108222453.GA6408@sergelap.austin.ibm.com> <20061109061021.GA32696@sergelap.austin.ibm.com> <20061109103349.e58e8f51.chris@friedhoff.org> <20061113215706.GA9658@sgi.com> <20061114052531.GA20915@sergelap.austin.ibm.com> <20061114135546.GA9953@sgi.com> <20061114152307.GA7534@sergelap.austin.ibm.com>
In-Reply-To: <20061114152307.GA7534@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Serge.

Serge E. Hallyn wrote:
> Quoting Bill O'Donnell (billodo@sgi.com):
>> 8102  execve("/sbin/setfcaps", ["setfcaps", "cap_net_raw=ep", "/bin/ping"], [/* 67 vars */]) = 0
     - snip -
>> 8102  capget(0x19980330, 0, {0, 0, 0})  = -1 EINVAL (Invalid argument)
> 
> I don't see why this capget is returning -EINVAL.  In fact I don't see
> why it happens at all - cap_inode_setxattr would check
> capable(CAP_SYS_ADMIN), but setxattr hasn't been called yet.  Looking at
> both libcap and setfcaps.c, I don't see where the capget comes from.
> 
> As for the -EINVAL, kernel/capability.c:sys_capget() returns -EINVAL if
> the _LINUX_CAPABILITY_VERSION is wrong - you have 0x19980330 which is
> correct - if pid < 0 - but you send in 0 - or if security_capget
> returns -EINVAL, which cap_capget (and dummy_capget) don't do.
> 
> Kaigai, do you have any ideas?

Bill said that he uses SLES10/ia64, so the version of libcap is different
from Fedora Core's one. 'libcap-1.92-499.4.src.rpm' is bandled.

Then, I found a strange code in libcap-1.92-499.4.src.rpm.

The setfcaps calls cap_from_text() which is defined in libcap to parse
the command line argument. It has the following function call chains:

cap_from_text()
   -> cap_init()
     -> _libcap_establish_api()

---- the definition of _libcap_establish_api() ----
void _libcap_establish_api(void)
{
     struct __user_cap_header_struct ch;
     struct __user_cap_data_struct cs;

     if (_libcap_kernel_version) { <-- _libcap_kernel_version is 0 initially.
         _cap_debug("already identified kernal api 0x%.8x",
                    _libcap_kernel_version);
         return;
     }

     memset(&ch, 0, sizeof(ch));
     memset(&cs, 0, sizeof(cs));

     (void) capget(&ch, &cs);  <-- (?)

     switch (ch.version) {

     case 0x19980330:
         _libcap_kernel_version = 0x19980330;
         _libcap_kernel_features = CAP_FEATURE_PROC;
         break;

     case 0x19990414:
         _libcap_kernel_version = 0x19990414;
         _libcap_kernel_features = CAP_FEATURE_PROC|CAP_FEATURE_FILE;
         break;

     default:
         _libcap_kernel_version = 0x00000000;
         _libcap_kernel_features = 0x00000000;
     }

     _cap_debug("version: %x, features: %x\n",
                _libcap_kernel_version, _libcap_kernel_features);
}
---------------------------------------------------

capget() is called from _libcap_establish_api() with full-zeroed
__user_cap_header_struct object at first time.
The result of this, sys_capget() in kernel will return -EINVAL.
(Why did strace say the first argument is 0x19980330?)

Probably, Bill didn't update libcap.so.

But I can't recommend Bill to update libcap immediately.
As Hawk Xu said, it may cause a serious problem on the distro
except Fedora Core 6. :(

I have to recommend to use 'fscaps-1.0-kg.i386.rpm' now.
It includes the implementation of interaction between application and xattr.
(Of couse, it's one of the features which should be provided by libcap.)

Thanks,
-- 
Open Source Software Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>
