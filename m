Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbUK0GXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbUK0GXD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 01:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbUKZTMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:12:35 -0500
Received: from pop.gmx.net ([213.165.64.20]:30693 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261891AbUKZTLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:11:53 -0500
X-Authenticated: #24160434
Message-ID: <41A8C673.7050007@gmx.ch>
Date: Sat, 27 Nov 2004 18:24:51 +0000
From: simon schuler <simon.schuler@gmx.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040115
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] Fix linux/types.h for compiling with -ansi
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a symple little patch to apply:
when including <linux/types.h> in a program and compiling with 'gcc 
-ansi' gcc complains:
`In file included from test.c:1:
/usr/include/linux/types.h:162: error: parse error before "__le64"
/usr/include/linux/types.h:163: error: parse error before "__be64"`

These lines are:
typedef __u64 __bitwise __le64;
typedef __u64 __bitwise __be64;

__u64 isn't defined in include/asm-386/types.h when __STRICT_ANSI__ is 
defined (as always when calling gcc -ansi):
#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
typedef __signed__ long long __s64;
typedef unsigned long long __u64;
#endif

The following patch for linux-2.6.10-rc2 solves the problem:
(The patch wouldn't be needed for some 64Bit architectures, but i didn't 
find an easy way of sorting these out)

diff -up include/linux/types.h include/linux/newtypes.h
--- include/linux/types.h        2004-11-27 17:19:25.509948024 +0000
+++ include/linux/types.h_new     2004-11-27 17:24:18.630386944 +0000
@@ -157,8 +157,10 @@ typedef __u16 __bitwise __le16;
 typedef __u16 __bitwise __be16;
 typedef __u32 __bitwise __le32;
 typedef __u32 __bitwise __be32;
+#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
 typedef __u64 __bitwise __le64;
 typedef __u64 __bitwise __be64;
+#endif

 struct ustat {
        __kernel_daddr_t        f_tfree;

