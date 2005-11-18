Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbVKRXB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbVKRXB1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 18:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVKRXB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 18:01:27 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:18580 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751093AbVKRXB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 18:01:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer;
        b=GLwJY/IlEZFimWOD5cC6+nmM8X79fLInAxKe78RP6fxj/I9VxdO+1hoeMcX6x2ihR/+nujXR320ZOCUjGIagt1n1gxZsfUgQgq9cnRx3W3egnWMp9XCH55o58bGFNzSkltTtHTTZzosemSQdkgDIDk24+wQv7MH40qG+uzkS1nY=
Subject: Re: 2.6.15-rc1-mm2 breaks strace
From: Badari Pulavarty <pbadari@gmail.com>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <200511182240.34512.bero@arklinux.org>
References: <200511182240.34512.bero@arklinux.org>
Content-Type: multipart/mixed; boundary="=-lMeMPxNdGokBs8S8u79I"
Date: Fri, 18 Nov 2005 15:00:35 -0800
Message-Id: <1132354835.24066.195.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lMeMPxNdGokBs8S8u79I
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Fri, 2005-11-18 at 22:40 +0100, Bernhard Rosenkraenzer wrote:
> 2.6.15-rc1-mm2 works nicely here, aside from the artsd stuff someone else 
> already reported, and an new issue with strace (last known working: 
> 2.6.14-mm2)
> 
> [bero@localhost bero]$ strace ls
> execve("/bin/ls", ["ls"], [/* 33 vars */]) = 0
> Segmentation fault
> [ls output without any traces beyond execve-ing ls displayed here]
> 
> Also interesting:
> [bero@localhost bero]$ strace strace ls
> execve("/usr/bin/strace", ["strace", "ls"], [/* 20 vars */]) = 0
> Segmentation fault
> execve("/bin/ls", ["ls"], [/* 20 vars */]) = 0
> [ls output without any traces displayed here]


Try Christoph's patch.

Thanks,
Badari



--=-lMeMPxNdGokBs8S8u79I
Content-Disposition: attachment; filename=ptrace-fix.patch
Content-Type: text/x-patch; name=ptrace-fix.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Looks like 2.6.15-rc1-mm1 has total crap in ptrace_get_task_struct
(and it looks like my fault because I sent out a wrong patch).

The patch below should fix it:

Index: linux-2.6/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/kernel/ptrace.c	2005-11-18 10:25:35.000000000 +0100
+++ linux-2.6/kernel/ptrace.c	2005-11-18 10:25:54.000000000 +0100
@@ -459,7 +459,7 @@
 	read_unlock(&tasklist_lock);
 	if (!child)
 		return ERR_PTR(-ESRCH);
-	return 0;
+	return child;
 }
 
 #ifndef __ARCH_SYS_PTRACE


--=-lMeMPxNdGokBs8S8u79I--

