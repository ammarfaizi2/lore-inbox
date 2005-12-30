Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbVL3IhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbVL3IhV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 03:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbVL3IhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 03:37:21 -0500
Received: from xproxy.gmail.com ([66.249.82.198]:44615 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751223AbVL3IhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 03:37:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=dOx5OMOkL3A0UvioETNdCz5M3Klg8oA6SKDgXoYUW0GDRuFfM2sxYFU0tcJGyD3z7FCfFfC1LPMwD5dMhjqV9uS6NLxM84wnGPPrykpCmzCL6vL1ISv5+S8t3VSHSaWYlaQI1CK42eYhNAUOYEg8u3Oz2AekR2emS8u8IyKcjmk=
Message-ID: <43B4F1B6.6080106@gmail.com>
Date: Fri, 30 Dec 2005 16:37:10 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@osdl.org, gregkh@suse.de, akpm@osdl.org
Subject: [PATCH] Fix false old value return of sysctl
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For current sysctl syscall, if the user wants to get
the old value of a sysctl entry and set a new value
for it by once sysctl syscall, the old value is always
  overwriten by the new value if the sysctl entry is of
  string type and if the user sets its strategy  to
sysctl_string. This issue lies in the strategy being run
  twice if the strategy is set to sysctl_string, the general
strategy sysctl_string always returns 0 if success.

Such strategy routines as sysctl_jiffies and sysctl_jiffies_ms
  return 1 because they do read and write for the sysctl entry.
The strategy routine sysctl_string return 0 although it actually
  read and write the sysctl entry.

According to my analysis, if a strategy routine do read and write,
  it should return 1, if it just does some necessary check but not
  read and write, it should return 0, for example sysctl_intvec.

The following program verifies this point:

#include <linux/unistd.h>
#include <linux/types.h>
#include <linux/sysctl.h>
#include <errno.h>

_syscall1(int, _sysctl, struct __sysctl_args *, args);
int sysctl(int *name, int nlen, void *oldval, size_t *oldlenp,
            void *newval, size_t newlen)
{
         struct __sysctl_args args =
		{name,nlen,oldval,oldlenp,newval,newlen};

         return _sysctl(&args);
}

#define SIZE(x) sizeof(x)/sizeof(x[0])
#define OSNAMESZ 100

struct mystruct {
         char osname[OSNAMESZ];
         int osnamelth;
} myos;

int name[] = { CTL_KERN, KERN_NODENAME };

int main(int argc, char * argv[])
{
         if (argc != 2) {
                 exit(0);
         }

         myos.osnamelth = SIZE(myos.osname);
         if (sysctl(name, SIZE(name), myos.osname, &myos.osnamelth,
			 argv[1], strlen(argv[1])))
                 perror("sysctl");
         else {
                 printf("Old host name: %s\n", myos.osname);
                 printf("New host name: %s\n", argv[1]);
         }
         return 0;
}

Copy it to file sysctl-test.c, then
$ hostname
mylocalmachine
$ gcc sysctl-test.c
$ ./a.out another
Old host name: another
New host name: another
$

After apply this patch:
$ hostname
mylocalmachine
$ gcc sysctl-test.c
$ ./a.out another
Old host name: mylocalmachine
New host name: another

Signed-off-by: Yi Yang <yang.y.yi@gmail.com>

--- a/kernel/sysctl.c.orig	2005-12-30 09:21:34.000000000 +0000
+++ b/kernel/sysctl.c	2005-12-30 15:08:03.000000000 +0000
@@ -2223,7 +2223,7 @@ int sysctl_string(ctl_table *table, int
  			len--;
  		((char *) table->data)[len] = 0;
  	}
-	return 0;
+	return 1;
  }

  /*



