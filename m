Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272695AbTHPKGU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 06:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272691AbTHPKGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 06:06:20 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:51722 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272692AbTHPKGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 06:06:17 -0400
Date: Sat, 16 Aug 2003 11:06:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: scsi proc_info called unconditionally
Message-ID: <20030816110616.A26667@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <20030816084409.GA8038@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030816084409.GA8038@suse.de>; from olh@suse.de on Sat, Aug 16, 2003 at 10:44:09AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 10:44:09AM +0200, Olaf Hering wrote:
> 
> Why is ->proc_info() called when the function pointer is NULL?

Looks like the check for it's presence got lost in

	[PATCH] Correct removal of procfs host enteries [1/2]

Here's a trivial patch to get it back:


--- 1.32/drivers/scsi/scsi_proc.c	Thu Jul 31 10:31:51 2003
+++ edited/drivers/scsi/scsi_proc.c	Sat Aug 16 10:31:37 2003
@@ -81,6 +81,9 @@
 
 void scsi_proc_hostdir_add(struct scsi_host_template *sht)
 {
+	if (!sht->proc_info)
+		return;
+
 	down(&global_host_template_sem);
 	if (!sht->present++) {
 		sht->proc_dir = proc_mkdir(sht->proc_name, proc_scsi);
@@ -96,6 +99,9 @@
 
 void scsi_proc_hostdir_rm(struct scsi_host_template *sht)
 {
+	if (!sht->proc_info)
+		return;
+
 	down(&global_host_template_sem);
 	if (!--sht->present && sht->proc_dir) {
 		remove_proc_entry(sht->proc_name, proc_scsi);

