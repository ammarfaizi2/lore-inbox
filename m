Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129380AbQKQBTI>; Thu, 16 Nov 2000 20:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131507AbQKQBS7>; Thu, 16 Nov 2000 20:18:59 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:52468 "HELO
	halfway.linuxcare.com.au") by vger.kernel.org with SMTP
	id <S131010AbQKQBSq>; Thu, 16 Nov 2000 20:18:46 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: More modutils: It's probably worse. 
In-Reply-To: Your message of "Wed, 15 Nov 2000 10:27:43 +1100."
             <11900.974244463@ocs3.ocs-net> 
Date: Fri, 17 Nov 2000 11:48:30 +1100
Message-Id: <20001117004830.ABA3B813F@halfway.linuxcare.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <11900.974244463@ocs3.ocs-net> you write:
> On 14 Nov 2000 11:42:42 -0800, 
> "H. Peter Anvin" <hpa@zytor.com> wrote:
> >Seriously, though, I don't see any reason modprobe shouldn't accept
> >funky filenames.  There is a standard way to do that, which is to have
> >an argument consisting of the string "--"; this indicates that any
> >further arguments should be considered filenames and not options.
> 
> The original exploit had nothing to do with filenames masquerading as
> options, it was: ping6 -I ';chmod o+w .'.  Then somebody pointed out
> that -I '-C/my/config/file' could be abused as well.  '--' fixes the
> second exploit but not the first.

Yes, modprobe code is stupid (execing insmod without "--").  Of
course, the passing of flags to modprobe is pretty broken too (the
kernel shouldn't assume anything about modprobe, otherwise why bother
with the /proc entry?)

But the kernel should be fixed for future:

--- working-2.4.0-test11-5/kernel/kmod.c.~1~	Wed Oct  4 15:17:12 2000
+++ working-2.4.0-test11-5/kernel/kmod.c	Fri Nov 17 11:44:09 2000
@@ -133,7 +133,7 @@
 static int exec_modprobe(void * module_name)
 {
 	static char * envp[] = { "HOME=/", "TERM=linux", "PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
-	char *argv[] = { modprobe_path, "-s", "-k", (char*)module_name, NULL };
+	char *argv[] = { modprobe_path, "-s", "-k", "--", (char*)module_name, NULL };
 	int ret;
 
 	ret = exec_usermodehelper(modprobe_path, argv, envp);
--
Hacking time.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
