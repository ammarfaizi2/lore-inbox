Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbVJJB0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbVJJB0O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 21:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbVJJB0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 21:26:14 -0400
Received: from send.forptr.21cn.com ([202.105.45.48]:6801 "HELO 21cn.com")
	by vger.kernel.org with SMTP id S932319AbVJJB0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 21:26:14 -0400
Message-ID: <4349C375.4010106@21cn.com>
Date: Mon, 10 Oct 2005 09:27:17 +0800
From: Yan Zheng <yanzheng@21cn.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Question about CONFIG_IPV6_SUBTREES
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AIMC-AUTH: yanzheng
X-AIMC-MAILFROM: yanzheng@21cn.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

In ip6_fib.c, fib6_lookup_1() does't make sense to me with 
CONFIG_IPV6_SUBTREES enable. It seem to only match source address when 
fib6_node has subtree. So I write a patch to show my opinion. 
unfortunately, this changes don't cooperate with  BACKTRACK() in route.c.

Can somebody explain the exact meaning of CONFIG_IPV6_SUBTREES!

Thanks.


--- linux-2.6.14-rc3-git8/net/ipv6/ip6_fib.c    2005-10-10 
08:57:40.000000000 +0800
+++ linux/net/ipv6/ip6_fib.c    2005-10-10 08:53:44.000000000 +0800
@@ -616,21 +616,6 @@
       }

       while ((fn->fn_flags & RTN_ROOT) == 0) {
-#ifdef CONFIG_IPV6_SUBTREES
-               if (fn->subtree) {
-                       struct fib6_node *st;
-                       struct lookup_args *narg;
-
-                       narg = args + 1;
-
-                       if (narg->addr) {
-                               st = fib6_lookup_1(fn->subtree, narg);
-
-                               if (st && !(st->fn_flags & RTN_ROOT))
-                                       return st;
-                       }
-               }
-#endif

               if (fn->fn_flags & RTN_RTINFO) {
                       struct rt6key *key;
@@ -639,7 +624,24 @@
                                       args->offset);

                       if (ipv6_prefix_equal(&key->addr, args->addr, 
key->plen))
-                               return fn;
+#ifdef CONFIG_IPV6_SUBTREES
+                               if (fn->subtree) {
+                                       struct fib6_node *st;
+                                       struct lookup_args *narg;
+
+                                       narg = args + 1;
+
+                                       if (narg->addr) {
+                                               st = 
fib6_lookup_1(fn->subtree, narg);
+
+                                               if (st && !(st->fn_flags 
& RTN_ROOT))
+                                                       return st;
+                                               if (fn->subtree->leaf != 
&ip6_null_entry)
+                                                       return fn->subtree;
+                                       }
+                               } else
+#endif
+                                       return fn;
               }

               fn = fn->parent;


