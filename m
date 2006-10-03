Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWJCKGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWJCKGs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 06:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWJCKGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 06:06:48 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:47017 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964865AbWJCKGr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 06:06:47 -0400
Message-ID: <45223633.4020009@fr.ibm.com>
Date: Tue, 03 Oct 2006 12:06:43 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@openvz.org>, Pavel Emelianov <xemul@openvz.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] IPC namespace core
References: <200610021601.k92G13mT003934@hera.kernel.org> <1159866174.3438.66.camel@pmac.infradead.org>
In-Reply-To: <1159866174.3438.66.camel@pmac.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> On Mon, 2006-10-02 at 16:01 +0000, Linux Kernel Mailing List wrote:
>> commit 25b21cb2f6d69b0475b134e0a3e8e269137270fa
>> tree cd9c3966408c0ca5903249437c35ff35961de544
>> parent c0b2fc316599d6cd875b6b8cafa67f03b9512b4d
>> author Kirill Korotaev <dev@openvz.org> 1159780699 -0700
>> committer Linus Torvalds <torvalds@g5.osdl.org> 1159801042 -0700
>>
>> [PATCH] IPC namespace core
>>
>> This patch set allows to unshare IPCs and have a private set of IPC objects
>> (sem, shm, msg) inside namespace.  Basically, it is another building block of
>> containers functionality.
>>
>> This patch implements core IPC namespace changes:
>> - ipc_namespace structure
>> - new config option CONFIG_IPC_NS
>> - adds CLONE_NEWIPC flag
>> - unshare support
>>
>> [clg@fr.ibm.com: small fix for unshare of ipc namespace]
>> [akpm@osdl.org: build fix]
>> Signed-off-by: Pavel Emelianov <xemul@openvz.org>
>> Signed-off-by: Kirill Korotaev <dev@openvz.org>
>> Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
>> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
>> Signed-off-by: Andrew Morton <akpm@osdl.org>
>> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
>> --- a/include/linux/ipc.h
>> +++ b/include/linux/ipc.h
>> @@ -2,6 +2,7 @@ #ifndef _LINUX_IPC_H
>>  #define _LINUX_IPC_H
>>  
>>  #include <linux/types.h>
>> +#include <linux/kref.h>
>>  
>>  #define IPC_PRIVATE ((__kernel_key_t) 0)  
>>  
> 
> You need to move the #include down the file by about 50 lines so it
> lands inside the existing #ifdef __KERNEL__.
> 
> All those signed-off-bys and _none_ of you managed to notice that
> <linux/kref.h> doesn't exist in the headers we export to userspace,
> despite the fact that just running 'make headers_check' would have
> shouted at you about it?
> 
> Bad hacker. No biscuit.

No biscuit ! That can not be ! patch bellow.

thanks for spotting this. 

C.

This patches fixes #ifdef __KERNEL__ .

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
---
 include/linux/Kbuild    |    2 +-
 include/linux/ipc.h     |    3 ++-
 include/linux/utsname.h |   17 +++++++++++------
 3 files changed, 14 insertions(+), 8 deletions(-)

Index: 2.6.18-mm3/include/linux/ipc.h
===================================================================
--- 2.6.18-mm3.orig/include/linux/ipc.h
+++ 2.6.18-mm3/include/linux/ipc.h
@@ -2,7 +2,6 @@
 #define _LINUX_IPC_H
 
 #include <linux/types.h>
-#include <linux/kref.h>
 
 #define IPC_PRIVATE ((__kernel_key_t) 0)  
 
@@ -52,6 +51,8 @@ struct ipc_perm
 
 #ifdef __KERNEL__
 
+#include <linux/kref.h>
+
 #define IPCMNI 32768  /* <= MAX_INT limit for ipc arrays (including sysctl changes) */
 
 /* used by in-kernel data structures */
Index: 2.6.18-mm3/include/linux/utsname.h
===================================================================
--- 2.6.18-mm3.orig/include/linux/utsname.h
+++ 2.6.18-mm3/include/linux/utsname.h
@@ -1,11 +1,6 @@
 #ifndef _LINUX_UTSNAME_H
 #define _LINUX_UTSNAME_H
 
-#include <linux/sched.h>
-#include <linux/kref.h>
-#include <linux/nsproxy.h>
-#include <asm/atomic.h>
-
 #define __OLD_UTS_LEN 8
 
 struct oldold_utsname {
@@ -35,6 +30,13 @@ struct new_utsname {
 	char domainname[65];
 };
 
+#ifdef __KERNEL__
+
+#include <linux/sched.h>
+#include <linux/kref.h>
+#include <linux/nsproxy.h>
+#include <asm/atomic.h>
+
 struct uts_namespace {
 	struct kref kref;
 	struct new_utsname name;
@@ -86,4 +88,7 @@ static inline struct new_utsname *init_u
 }
 
 extern struct rw_semaphore uts_sem;
-#endif
+
+#endif /* __KERNEL__ */
+
+#endif /* _LINUX_UTSNAME_H */
Index: 2.6.18-mm3/include/linux/Kbuild
===================================================================
--- 2.6.18-mm3.orig/include/linux/Kbuild
+++ 2.6.18-mm3/include/linux/Kbuild
@@ -158,7 +158,6 @@ header-y += toshiba.h
 header-y += ultrasound.h
 header-y += un.h
 header-y += utime.h
-header-y += utsname.h
 header-y += video_decoder.h
 header-y += video_encoder.h
 header-y += videotext.h
@@ -336,6 +335,7 @@ unifdef-y += unistd.h
 unifdef-y += usb_ch9.h
 unifdef-y += usbdevice_fs.h
 unifdef-y += user.h
+unifdef-y += utsname.h
 unifdef-y += videodev2.h
 unifdef-y += videodev.h
 unifdef-y += wait.h

