Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbUCEBGI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 20:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbUCEBGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 20:06:08 -0500
Received: from mail1.speakeasy.net ([216.254.0.201]:22473 "EHLO
	mail1.speakeasy.net") by vger.kernel.org with ESMTP id S262141AbUCEBGC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 20:06:02 -0500
Date: Thu, 4 Mar 2004 19:05:41 -0600 (CST)
From: Matthew Strait <quadong@users.sourceforge.net>
X-X-Sender: straitm@dsl093-017-216.msp1.dsl.speakeasy.net
To: Patrick McHardy <kaber@trash.net>
cc: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: [PATCH] matching any helper in ipt_helper.c
In-Reply-To: <4047A42E.6080307@trash.net>
Message-ID: <Pine.LNX.4.60.0403041821010.21790@dsl093-017-216.msp1.dsl.speakeasy.net>
References: <Pine.LNX.4.60.0403031947450.8957@dsl093-017-216.msp1.dsl.speakeasy.net>
 <40469E10.7080100@trash.net> <Pine.LNX.4.60.0403032150000.8957@dsl093-017-216.msp1.dsl.speakeasy.net>
 <4046BFB9.809@trash.net> <Pine.LNX.4.60.0403041500280.10634@dsl093-017-216.msp1.dsl.speakeasy.net>
 <4047A42E.6080307@trash.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It seems like I'd have to make significantly more invasive changes than
> > are really called for to get it to accept an empty string.  What do you
> > think?
>
> You just need to remove the check for empty strings in ipt_helper.c:
>
>         /* verify that we actually should match anything */
>         if ( strlen(info->name) == 0 )
>                 return 0;

Silly me, I assumed that the error was generated in user space.  Ok.  In
that case, let's forget translating "any" to "", because that just makes
the output of "iptables -L" confusing.  Sound good?

Kernel patch:

--- ipt_helper.c.old    2004-03-03 21:34:05.000000000 -0600
+++ ipt_helper.c        2004-03-04 18:38:32.234521176 -0600
@@ -68,8 +68,11 @@
        DEBUGP("master's name = %s , info->name = %s\n",
                exp->expectant->helper->name, info->name);

-       ret = !strncmp(exp->expectant->helper->name, info->name,
-                      strlen(exp->expectant->helper->name)) ^ info->invert;
+       if(info->name[0] == '\0') /* special case meaning "any" */
+               ret = !info->invert;
+       else
+               ret = !strncmp(exp->expectant->helper->name, info->name,
+                              strlen(exp->expectant->helper->name)) ^ info->invert;
 out_unlock:
        READ_UNLOCK(&ip_conntrack_lock);
        return ret;
@@ -89,10 +92,6 @@
        if (matchsize != IPT_ALIGN(sizeof(struct ipt_helper_info)))
                return 0;

-       /* verify that we actually should match anything */
-       if ( strlen(info->name) == 0 )
-               return 0;
-
        return 1;
 }




And documentational changes in iptables:

--- libipt_helper.c.old 2004-03-03 21:39:07.000000000 -0600
+++ libipt_helper.c     2004-03-04 18:31:54.156038304 -0600
@@ -15,6 +15,7 @@
        printf(
 "helper match v%s options:\n"
 "[!] --helper string        Match helper identified by string\n"
+"                           (or any helper if string is \"\")"
 "\n",
 IPTABLES_VERSION);
 }


--- iptables.8.old      2004-03-04 18:35:11.994962216 -0600
+++ iptables.8  2004-03-04 18:34:38.263090240 -0600
@@ -458,6 +458,8 @@
 For other ports append -portnr to the value, ie. "ftp-2121".
 .PP
 Same rules apply for other conntrack-helpers.
+.PP
+If string is "", it will match any packet related to a conntrack-helper.
 .RE
 .SS icmp
 This extension is loaded if `--protocol icmp' is specified.  It

