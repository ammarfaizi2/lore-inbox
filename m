Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbVLaJNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbVLaJNM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 04:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbVLaJNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 04:13:12 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:20370 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751050AbVLaJNL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 04:13:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VFFDfwCTjBXqcepwQMBjEIOmLkSQNk6rAMn6wrAu2B6Xt/yPpYn3imPfdJni1oyZ2gqO3hqYEGBmIS9Fr8anRlW6DR/eTlkRXq/mjgkGJAp+dZdoTJa9HSUQtFQqh49PHKHz4trbRWKPPT/T07vFeiH6KPmPSawaRZWXsSqaT9M=
Message-ID: <2cd57c900512310113i5467a258s@mail.gmail.com>
Date: Sat, 31 Dec 2005 17:13:09 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Yi Yang <yang.y.yi@gmail.com>
Subject: Re: [PATCH] Fix user data corrupted by old value return of sysctl
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, gregkh@suse.de,
       akpm@osdl.org
In-Reply-To: <43B4F287.6080307@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43B4F287.6080307@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/12/30, Yi Yang <yang.y.yi@gmail.com>:
> If the user reads a sysctl entry which is of string type
>   by sysctl syscall, this call probably corrupts the user data
>   right after the old value buffer, the issue lies in sysctl_string
>   seting 0 to oldval[len], len is the available buffer size
>   specified by the user, obviously, this will write to the first
>   byte of the user memory place immediate after the old value buffer
> , the correct way is that sysctl_string doesn't set 0, the user
> should do it by self in the program.
>
> The following program verifies this point:
>
> #include <linux/unistd.h>
> #include <linux/types.h>
> #include <linux/sysctl.h>
> #include <errno.h>
>
> _syscall1(int, _sysctl, struct __sysctl_args *, args);
> int sysctl(int *name, int nlen, void *oldval, size_t *oldlenp,
>             void *newval, size_t newlen)
> {
>          struct __sysctl_args args
>                 = {name,nlen,oldval,oldlenp,newval,newlen};
>
>          return _sysctl(&args);
> }
>
> #define SIZE(x) sizeof(x)/sizeof(x[0])
> #define OSNAMESZ 4
>
> struct mystruct {
>         char osname[OSNAMESZ];
>         int target;
>         int osnamelth;
> } myos;
>
> int name[] = { CTL_KERN, KERN_NODENAME };
>
> int main(int argc, char * argv[])
> {
>         myos.target = 1;
>         printf("target = %d\n", myos.target);
>         myos.osnamelth = SIZE(myos.osname);
>          if (sysctl(name, SIZE(name), myos.osname,
>                         &myos.osnamelth, 0, 0))
>                  perror("sysctl");
>         else {
>                  printf("Current host name: %s\n", myos.osname);
>         }
>         printf("target = %d\n", myos.target);
>          return 0;
> }
>
> Copy it to file sysctl-safe.c, then
> $ hostname
> mylocalmachine
> $ gcc sysctl-safe.c
> $ ./a.out
> target = 1
> Current host name: mylo
> target = 0
> $
>
> After apply this patch:
> $ hostname
> mylocalmachine
> $ gcc sysctl-safe.c
> $ ./a.out
> target = 1
> Current host name: mylo

You didn't set the trailing '\0', I wonder how your printf did work
properly ever. You've just been lucky or something.

-- Coywolf


> target = 1
>
> Signed-off-by: Yi Yang <yang.y.yi@gmail.com>
>
>
> --- a/kernel/sysctl.c.orig      2005-12-30 09:21:34.000000000 +0000
> +++ b/kernel/sysctl.c   2005-12-30 15:58:15.000000000 +0000
> @@ -2207,8 +2207,6 @@ int sysctl_string(ctl_table *table, int
>                                 len = table->maxlen;
>                         if(copy_to_user(oldval, table->data, len))
>                                 return -EFAULT;
> -                       if(put_user(0, ((char __user *) oldval) + len))
> -                               return -EFAULT;
>                         if(put_user(len, oldlenp))
>                                 return -EFAULT;
>                 }
>
>
>
--
Coywolf Qi Hunt
