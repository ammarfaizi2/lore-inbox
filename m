Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbUL3DIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbUL3DIw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 22:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbUL3DIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 22:08:52 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:47877 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261528AbUL3DIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 22:08:38 -0500
Message-ID: <41D37216.3010504@conectiva.com.br>
Date: Thu, 30 Dec 2004 01:12:22 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Organization: Conectiva S.A.
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mateusz Berezecki <mateuszb@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: include/linux/ipv6.h  error?
References: <41D34E16.2040503@gmail.com>
In-Reply-To: <41D34E16.2040503@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------030008030904000503080902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030008030904000503080902
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Mateusz Berezecki wrote:
> inet_sk(__sk) returns pointer to inet_sock structure which has pinet6 
> field defined
> or not defined depending on kernel configuration during compilation time
> 
> #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
>        struct ipv6_pinfo       *pinet6;
> #endif
> 
> the function below causes compilation error in kernel configs with 
> neither CONFIG_IPV6 nor
> CONFIG_IPV6_MODULE defined.
> 
> should these functions be included between
> #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> 
> static inline struct ipv6_pinfo * inet6_sk(const struct sock *__sk)
> {
>        return inet_sk(__sk)->pinet6;
> }
> 
> static inline struct raw6_opt * raw6_sk(const struct sock *__sk)
> {
>        return &((struct raw6_sock *)__sk)->raw6;
> }
> #endif
> 
> 
> ?? or should the #ifdef directive be removed from ipv6.h header file?

My fault, sorry... James Bottomley already pointed this out to me and I already
sent a fix to David Miller, CCed to netdev, here for convenience. It only
happens when you don't select IPV6.

I kindly suggest that such reports, related to networking development, at
least be CCed to netdev@oss.sgi.com.

- Arnaldo

--------------030008030904000503080902
Content-Type: text/plain;
 name="inet6_sk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="inet6_sk.patch"

===== include/linux/ipv6.h 1.23 vs edited =====
--- 1.23/include/linux/ipv6.h	2004-12-27 23:56:33 -02:00
+++ edited/include/linux/ipv6.h	2004-12-29 20:22:45 -02:00
@@ -273,6 +273,7 @@
 	struct ipv6_pinfo inet6;
 };
 
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
 static inline struct ipv6_pinfo * inet6_sk(const struct sock *__sk)
 {
 	return inet_sk(__sk)->pinet6;
@@ -283,7 +284,6 @@
 	return &((struct raw6_sock *)__sk)->raw6;
 }
 
-#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
 #define __ipv6_only_sock(sk)	(inet6_sk(sk)->ipv6only)
 #define ipv6_only_sock(sk)	((sk)->sk_family == PF_INET6 && __ipv6_only_sock(sk))
 #else

--------------030008030904000503080902--
