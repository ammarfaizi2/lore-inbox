Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbUCKVkq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 16:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbUCKVkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 16:40:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:5536 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261739AbUCKVkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 16:40:22 -0500
Date: Thu, 11 Mar 2004 13:42:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Flavio Bruno Leitner <fbl@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at kernel/timer.c:370!
Message-Id: <20040311134221.1ba3f910.akpm@osdl.org>
In-Reply-To: <20040311154331.GA1755@conectiva.com.br>
References: <20040305174049.GA1759@conectiva.com.br>
	<20040305150615.0ae07114.akpm@osdl.org>
	<20040311154331.GA1755@conectiva.com.br>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Flavio Bruno Leitner <fbl@conectiva.com.br> wrote:
>
> On Fri, Mar 05, 2004 at 03:06:15PM -0800, Andrew Morton wrote:
> > Flavio Bruno Leitner <fbl@conectiva.com.br> wrote:
> > >
> > > My laptop is an Acer TravelMate 630 and somewhere between 2.6.2 and 2.6.3-rc2 
> > > begins returning an oops right after boot.
> > > 
> > > kernel BUG at kernel/timer.c:370!
> > 
> > Oh fantastic.  Something scrogged the timer lists.
> > 
> > I suggest you try stripping your kernel config down the the bare minimum
> > which is needed to boot, see if that fixes it and if so, start
> > reintroducing things until you've worked out which driver is causing the
> > problem.
> 
> Done!
> 
> The oops happens when the patch is applied, just do ifconfig eth0 down 
> and ifconfig eth0 <with another ip>  up. The dhcp always get wrong ip, 
> so my rc.local run ifconfig down and up. Removing the patch, I can't 
> reproduce it anymore.
> 

Thanks for working that out.  Maybe we need to terminate those sysctl
tables.   Does this fix it?

---

 25-akpm/net/ipv4/devinet.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff -puN net/ipv4/devinet.c~devinet-ctl_table-fix net/ipv4/devinet.c
--- 25/net/ipv4/devinet.c~devinet-ctl_table-fix	Thu Mar 11 13:40:38 2004
+++ 25-akpm/net/ipv4/devinet.c	Thu Mar 11 13:40:53 2004
@@ -1210,11 +1210,11 @@ int ipv4_doint_and_flush_strategy(ctl_ta
 
 static struct devinet_sysctl_table {
 	struct ctl_table_header *sysctl_header;
-	ctl_table		devinet_vars[20];
-	ctl_table		devinet_dev[2];
-	ctl_table		devinet_conf_dir[2];
-	ctl_table		devinet_proto_dir[2];
-	ctl_table		devinet_root_dir[2];
+	ctl_table		devinet_vars[21];
+	ctl_table		devinet_dev[3];
+	ctl_table		devinet_conf_dir[3];
+	ctl_table		devinet_proto_dir[3];
+	ctl_table		devinet_root_dir[3];
 } devinet_sysctl = {
 	.devinet_vars = {
 		{
@@ -1372,6 +1372,7 @@ static struct devinet_sysctl_table {
 			.proc_handler	= &ipv4_doint_and_flush,
 			.strategy	= &ipv4_doint_and_flush_strategy,
 		},
+		{ .ctl_name = 0 }
 	},
 	.devinet_dev = {
 		{
@@ -1380,6 +1381,7 @@ static struct devinet_sysctl_table {
 			.mode		= 0555,
 			.child		= devinet_sysctl.devinet_vars,
 		},
+		{ .ctl_name = 0 }
 	},
 	.devinet_conf_dir = {
 	        {
@@ -1388,6 +1390,7 @@ static struct devinet_sysctl_table {
 			.mode		= 0555,
 			.child		= devinet_sysctl.devinet_dev,
 		},
+		{ .ctl_name = 0 }
 	},
 	.devinet_proto_dir = {
 		{
@@ -1396,6 +1399,7 @@ static struct devinet_sysctl_table {
 			.mode		= 0555,
 			.child 		= devinet_sysctl.devinet_conf_dir,
 		},
+		{ .ctl_name = 0 }
 	},
 	.devinet_root_dir = {
 		{
@@ -1404,6 +1408,7 @@ static struct devinet_sysctl_table {
 			.mode		= 0555,
 			.child		= devinet_sysctl.devinet_proto_dir,
 		},
+		{ .ctl_name = 0 }
 	},
 };
 

_

