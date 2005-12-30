Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbVL3Ikw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbVL3Ikw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 03:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbVL3Ikw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 03:40:52 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:39266 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751227AbVL3Ikv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 03:40:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=A5wOKcORz9jM2m4jvoEkZlvklXOjCdqSfvAfZI2LAS4+/oCVhoBlLQJliAlidDgeFqHPFvoPB2YlLonjRwwJUFitvzyHtsopjI+sMA1myWwlU36FKmNGZs+4kATm2sOC5D6vBKvxpYxnMs0D2hbwqGzYHRewyAOmQjaiMfrHv38=
Message-ID: <43B4F287.6080307@gmail.com>
Date: Fri, 30 Dec 2005 16:40:39 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@osdl.org, gregkh@suse.de, akpm@osdl.org
Subject: [PATCH] Fix user data corrupted by old value return of sysctl
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the user reads a sysctl entry which is of string type
  by sysctl syscall, this call probably corrupts the user data
  right after the old value buffer, the issue lies in sysctl_string
  seting 0 to oldval[len], len is the available buffer size
  specified by the user, obviously, this will write to the first
  byte of the user memory place immediate after the old value buffer
, the correct way is that sysctl_string doesn't set 0, the user
should do it by self in the program.

The following program verifies this point:

#include <linux/unistd.h>
#include <linux/types.h>
#include <linux/sysctl.h>
#include <errno.h>

_syscall1(int, _sysctl, struct __sysctl_args *, args);
int sysctl(int *name, int nlen, void *oldval, size_t *oldlenp,
            void *newval, size_t newlen)
{
         struct __sysctl_args args
		= {name,nlen,oldval,oldlenp,newval,newlen};

         return _sysctl(&args);
}

#define SIZE(x) sizeof(x)/sizeof(x[0])
#define OSNAMESZ 4

struct mystruct {
	char osname[OSNAMESZ];
	int target;
	int osnamelth;
} myos;

int name[] = { CTL_KERN, KERN_NODENAME };

int main(int argc, char * argv[])
{
	myos.target = 1;
	printf("target = %d\n", myos.target);
	myos.osnamelth = SIZE(myos.osname);
         if (sysctl(name, SIZE(name), myos.osname,
			&myos.osnamelth, 0, 0))
                 perror("sysctl");
	else {
                 printf("Current host name: %s\n", myos.osname);
	}
	printf("target = %d\n", myos.target);
         return 0;
}

Copy it to file sysctl-safe.c, then
$ hostname
mylocalmachine
$ gcc sysctl-safe.c
$ ./a.out
target = 1
Current host name: mylo
target = 0
$

After apply this patch:
$ hostname
mylocalmachine
$ gcc sysctl-safe.c
$ ./a.out
target = 1
Current host name: mylo
target = 1

Signed-off-by: Yi Yang <yang.y.yi@gmail.com>


--- a/kernel/sysctl.c.orig	2005-12-30 09:21:34.000000000 +0000
+++ b/kernel/sysctl.c	2005-12-30 15:58:15.000000000 +0000
@@ -2207,8 +2207,6 @@ int sysctl_string(ctl_table *table, int
  				len = table->maxlen;
  			if(copy_to_user(oldval, table->data, len))
  				return -EFAULT;
-			if(put_user(0, ((char __user *) oldval) + len))
-				return -EFAULT;
  			if(put_user(len, oldlenp))
  				return -EFAULT;
  		}



