Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWFBFCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWFBFCP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 01:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWFBFCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 01:02:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18894 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750875AbWFBFCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 01:02:14 -0400
Date: Thu, 1 Jun 2006 22:06:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2
Message-Id: <20060601220629.4d81801a.akpm@osdl.org>
In-Reply-To: <20060602122311.fbfe6c4b.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	<20060602122311.fbfe6c4b.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2006 12:23:11 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> On ia64 + make allmodconfig
> 
>   CC      kernel/sysctl.o
> kernel/sysctl.c:305: error: braced-group within expression allowed only inside a function
> kernel/sysctl.c:314: warning: type defaults to `int' in declaration of `ia64_intri_res'
> kernel/sysctl.c:314: warning: data definition has no type or storage class
> kernel/sysctl.c:314: error: syntax error before '}' token
> kernel/sysctl.c:323: warning: type defaults to `int' in declaration of `ia64_intri_res'
> kernel/sysctl.c:323: warning: data definition has no type or storage class
> kernel/sysctl.c:323: error: syntax error before '}' token
> kernel/sysctl.c:332: warning: type defaults to `int' in declaration of `ia64_intri_res'
> kernel/sysctl.c:332: warning: data definition has no type or storage class
> kernel/sysctl.c:332: error: syntax error before '}' token
> kernel/sysctl.c:341: warning: type defaults to `int' in declaration of `ia64_intri_res'
> kernel/sysctl.c:341: warning: data definition has no type or storage class
> kernel/sysctl.c:341: error: syntax error before '}' token
> kernel/sysctl.c:98: warning: 'ngroups_max' defined but not used
> kernel/sysctl.c:1810: warning: 'proc_do_utsns_string' defined but not used

yup, thanks.


From: Andrew Morton <akpm@osdl.org>

Don't try to evaluate `current' at compile time - ia64 explodes.

Cc: Sam Vilain <sam.vilain@catalyst.net.nz>
Cc: Serge E. Hallyn <serue@us.ibm.com>
Cc: Kirill Korotaev <dev@openvz.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>
Cc: Andrey Savochkin <saw@sw.ru>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 kernel/sysctl.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -puN kernel/sysctl.c~namespaces-utsname-sysctl-hack-cleanup-2-fix kernel/sysctl.c
--- 25/kernel/sysctl.c~namespaces-utsname-sysctl-hack-cleanup-2-fix	Fri Jun  2 12:43:07 2006
+++ 25-akpm/kernel/sysctl.c	Fri Jun  2 12:45:35 2006
@@ -302,7 +302,7 @@ static ctl_table kern_table[] = {
 		.procname	= "ostype",
 		.data		= NULL,
 		/* could maybe use __NEW_UTS_LEN here? */
-		.maxlen		= sizeof(current->nsproxy->uts_ns->name.sysname),
+		.maxlen		= FIELD_SIZEOF(struct new_utsname, sysname),
 		.mode		= 0444,
 		.proc_handler	= &proc_do_utsns_string,
 		.strategy	= &sysctl_string,
@@ -311,7 +311,7 @@ static ctl_table kern_table[] = {
 		.ctl_name	= KERN_OSRELEASE,
 		.procname	= "osrelease",
 		.data		= NULL,
-		.maxlen		= sizeof(current->nsproxy->uts_ns->name.release),
+		.maxlen		= FIELD_SIZEOF(struct new_utsname, release),
 		.mode		= 0444,
 		.proc_handler	= &proc_do_utsns_string,
 		.strategy	= &sysctl_string,
@@ -320,7 +320,7 @@ static ctl_table kern_table[] = {
 		.ctl_name	= KERN_VERSION,
 		.procname	= "version",
 		.data		= NULL,
-		.maxlen		= sizeof(current->nsproxy->uts_ns->name.version),
+		.maxlen		= FIELD_SIZEOF(struct new_utsname, version),
 		.mode		= 0444,
 		.proc_handler	= &proc_do_utsns_string,
 		.strategy	= &sysctl_string,
@@ -329,7 +329,7 @@ static ctl_table kern_table[] = {
 		.ctl_name	= KERN_NODENAME,
 		.procname	= "hostname",
 		.data		= NULL,
-		.maxlen		= sizeof(current->nsproxy->uts_ns->name.nodename),
+		.maxlen		= FIELD_SIZEOF(struct new_utsname, nodename),
 		.mode		= 0644,
 		.proc_handler	= &proc_do_utsns_string,
 		.strategy	= &sysctl_string,
@@ -338,7 +338,7 @@ static ctl_table kern_table[] = {
 		.ctl_name	= KERN_DOMAINNAME,
 		.procname	= "domainname",
 		.data		= NULL,
-		.maxlen		= sizeof(current->nsproxy->uts_ns->name.domainname),
+		.maxlen		= FIELD_SIZEOF(struct new_utsname, domainname),
 		.mode		= 0644,
 		.proc_handler	= &proc_do_utsns_string,
 		.strategy	= &sysctl_string,
_

