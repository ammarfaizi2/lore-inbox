Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbWFAKY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWFAKY6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 06:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbWFAKY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 06:24:57 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:33643 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964942AbWFAKY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 06:24:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=T0Ghx8Tea8JfD40Xs98PY+XHhsAOXxo3ZefUVnscYaHR5QwucfLoaDlQ37wngRe65qHF4bsXwoar8vKBAHMYNrDv/u23zh0i0FAcgMbrzmqFK1XpjC5ExVpQ38L7DuIbqS+1iYovBJBMsa68B48E4hWFPx7/iSEH4aRMKd/oZZw=
Date: Thu, 1 Jun 2006 18:24:50 +0800
From: lepton <ytht.net@gmail.com>
To: lkm <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.16.19 Fix the bug of "return 0 instead of the error code in ipt_register_table"
Message-ID: <20060601102449.GA8572@gsy2.lepton.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There is a bug in ipt_register_table() in
net/ipv4/netfilter/ip_tables.c:

ipt_register_table() will return 0 instead of
the error code when xt_register_table() fails

Signed-off-by: Lepton Wu <ytht.net@gmail.com>

diff -prU 10 linux-2.6.16.19.oirg/net/ipv4/netfilter/ip_tables.c linux-2.6.16.19/net/ipv4/netfilter/ip_tables.c
--- linux-2.6.16.19.oirg/net/ipv4/netfilter/ip_tables.c	2006-05-31 08:31:44.000000000 +0800
+++ linux-2.6.16.19/net/ipv4/netfilter/ip_tables.c	2006-06-01 18:11:25.000000000 +0800
@@ -1235,21 +1235,22 @@ int ipt_register_table(struct xt_table *
 	ret = translate_table(table->name, table->valid_hooks,
 			      newinfo, loc_cpu_entry, repl->size,
 			      repl->num_entries,
 			      repl->hook_entry,
 			      repl->underflow);
 	if (ret != 0) {
 		xt_free_table_info(newinfo);
 		return ret;
 	}
 
-	if (xt_register_table(table, &bootstrap, newinfo) != 0) {
+	ret = xt_register_table(table, &bootstrap, newinfo);
+	if (ret) {
 		xt_free_table_info(newinfo);
 		return ret;
 	}
 
 	return 0;
 }
 
 void ipt_unregister_table(struct ipt_table *table)
 {
 	struct xt_table_info *private;
