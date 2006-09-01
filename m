Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWIADnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWIADnp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 23:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWIADnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 23:43:45 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:51860 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751079AbWIADno
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 23:43:44 -0400
Message-ID: <44F7AC65.5050502@cn.ibm.com>
Date: Fri, 01 Sep 2006 11:43:33 +0800
From: Yao Fei Zhu <walkinair@cn.ibm.com>
Reply-To: walkinair@cn.ibm.com
Organization: IBM
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: David Chinner <dgc@sgi.com>, linux-kernel@vger.kernel.org,
       haveblue@us.ibm.com, xfs@oss.sgi.com
Subject: Re: kernel BUG in __xfs_get_blocks at fs/xfs/linux-2.6/xfs_aops.c:1293!
References: <44F67847.6030307@cn.ibm.com>	<20060831074742.GD807830@melbourne.sgi.com>	<44F6979C.4070309@cn.ibm.com>	<20060831081726.GV5737019@melbourne.sgi.com> <20060831015430.6df0d8ba.akpm@osdl.org>
In-Reply-To: <20060831015430.6df0d8ba.akpm@osdl.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>On Thu, 31 Aug 2006 18:17:26 +1000
>David Chinner <dgc@sgi.com> wrote:
>
>  
>
>>>BTW, I have CONFIG_PPC_64K_PAGES enabled.
>>>      
>>>
>>But that might be a good place to start. Can you see if you can
>>reproduce the problem without this config option set?
>>    
>>
>
>It would be useful to compare the compiler warning output for 64k pages
>versus that for smaller-pages.  
>
>Several quite worrisome-looking warnings are emitted from various parts of
>the kernel with 64k pages.  Related to arithmetic on short types.
>  
>
1. the config diff
blade10:/boot # diff config-2.6.18-rc5-ppc64 config-2.6.18-rc5-ppc64.64kp
4c4
< # Thu Aug 31 18:25:42 2006
---
 > # Thu Aug 31 21:18:52 2006
51c51
< CONFIG_LOCALVERSION="-ppc64"
---
 > CONFIG_LOCALVERSION="-ppc64.64kp"
173c173
< CONFIG_FORCE_MAX_ZONEORDER=13
---
 > CONFIG_FORCE_MAX_ZONEORDER=9
204c204
< # CONFIG_PPC_64K_PAGES is not set
---
 > CONFIG_PPC_64K_PAGES=y

2. the compiler warning diff
ltctest:~ # diff 4k.warning 64k.warning
0a1,5
 > kernel/power/pm.c:205: warning: ‘pm_register’ is deprecated 
(declared at kernel/power/pm.c:64)
 > kernel/power/pm.c:205: warning: ‘pm_register’ is deprecated 
(declared at kernel/power/pm.c:64)
 > kernel/power/pm.c:206: warning: ‘pm_send_all’ is deprecated 
(declared at kernel/power/pm.c:180)
 > kernel/power/pm.c:206: warning: ‘pm_send_all’ is deprecated 
(declared at kernel/power/pm.c:180)
 > fs/bio.c:169: warning: ‘idx’ may be used uninitialized in this 
function
8,13d12
< fs/bio.c:169: warning: ‘idx’ may be used uninitialized in this 
function
< kernel/power/pm.c:205: warning: ‘pm_register’ is deprecated 
(declared at kernel/power/pm.c:64)
< kernel/power/pm.c:205: warning: ‘pm_register’ is deprecated 
(declared at kernel/power/pm.c:64)
< kernel/power/pm.c:206: warning: ‘pm_send_all’ is deprecated 
(declared at kernel/power/pm.c:180)
< kernel/power/pm.c:206: warning: ‘pm_send_all’ is deprecated 
(declared at kernel/power/pm.c:180)
< fs/eventpoll.c:500: warning: ‘fd’ may be used uninitialized in 
this function
17a17,27
 > fs/eventpoll.c:500: warning: ‘fd’ may be used uninitialized in 
this function
 > fs/fat/inode.c:1227: warning: comparison is always false due to 
limited range of data type
 > fs/hfs/btree.c:243: warning: comparison is always false due to 
limited range of data type
 > fs/hfsplus/btree.c:235: warning: comparison is always false due to 
limited range of data type
 > fs/ocfs2/vote.c:774: warning: ‘response’ may be used 
uninitialized in this function
 > fs/ocfs2/dlm/dlmdomain.c:70: warning: format ‘%lu’ expects type 
‘long unsigned int’, but argument 7 has type ‘int’
 > fs/ocfs2/dlm/dlmdomain.c:70: warning: format ‘%lu’ expects type 
‘long unsigned int’, but argument 7 has type ‘int’
 > fs/ocfs2/dlm/dlmdomain.c:70: warning: format ‘%lu’ expects type 
‘long unsigned int’, but argument 7 has type ‘int’
 > fs/ocfs2/dlm/dlmdomain.c:918: warning: ‘response’ may be used 
uninitialized in this function
 > fs/udf/balloc.c:751: warning: ‘goal_eloc.logicalBlockNum’ may be 
used uninitialized in this function
 > fs/udf/super.c:1364: warning: ‘ino.partitionReferenceNum’ may be 
used uninitialized in this function
56a67,68
 > drivers/usb/core/devio.c:620: warning: comparison is always false due 
to limited range of data type
 > drivers/net/r8169.c:2131: warning: ‘txd’ may be used 
uninitialized in this function
59d70
< drivers/net/r8169.c:2131: warning: ‘txd’ may be used uninitialized 
in this function
70,73c81
< fs/ocfs2/vote.c:774: warning: ‘response’ may be used uninitialized 
in this function
< fs/ocfs2/dlm/dlmdomain.c:918: warning: ‘response’ may be used 
uninitialized in this function
< fs/udf/balloc.c:751: warning: ‘goal_eloc.logicalBlockNum’ may be 
used uninitialized in this function
< fs/udf/super.c:1364: warning: ‘ino.partitionReferenceNum’ may be 
used uninitialized in this function
---
 > net/key/af_key.c:403: warning: comparison is always false due to 
limited range of data type


