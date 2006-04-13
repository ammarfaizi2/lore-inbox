Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWDMSRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWDMSRK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 14:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWDMSRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 14:17:10 -0400
Received: from xenotime.net ([66.160.160.81]:51082 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932369AbWDMSRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 14:17:09 -0400
Date: Thu, 13 Apr 2006 11:19:36 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: <tyler@agat.net>
Cc: rusty@rustcorp.com.au, gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kmod optimization
Message-Id: <20060413111936.3d035771.rdunlap@xenotime.net>
In-Reply-To: <20060413180345.GA10910@Starbuck>
References: <20060413180345.GA10910@Starbuck>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2006 20:03:45 +0200 tyler@agat.net wrote:

> Hi,
> 
> the request_mod functions try to load automatically a module by running
> a user mode process helper (modprobe).
> 
> The user process is launched even if the module is already loaded. I
> think it would be better to test if the module is already loaded.

Please try not to use attachments: it makes it more difficult
to review and comment on code (so I'll paste it here).


+	/* We don't to load the module if it's already loaded */
+	spin_lock_irqsave(&modlist_lock, flags);
+	if (is_loaded(module_name)) {
+		return -EEXIST;
+	}
+	spin_unlock_irqrestore(&modlist_lock, flags);

Need to do spin_unlock_irqrestore() even if is_loaded() is true.

+/* Test if a module is loaded : must hold module_mutex */
+int is_loaded(const char *module_name);
+{
+	struct module *mod = find_module(module_name);
+
+	if (!mod) {
+		return 1;
+	}

Don't use braces when not needed.
Why not make this function inline and put it into a header file?

---
~Randy
