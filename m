Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWB1DU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWB1DU0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 22:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWB1DU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 22:20:26 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:60650 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932148AbWB1DU0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 22:20:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PJbPYhhvZorWcOzBgRpa8RlsuVcPzsgKMQzzSWzBsDL+HH6Dk931HChexrEgPbkf7XtsIbQhpGIhfIhx2ZCklWC1HQ1XUwx8lBTXJFzhUZ3UIpYE2m8ffTVu0jJU3v/U7YBOSlAt2UrQ7CpTxY6W9t2XjX8DWbjbPvlpkaoWwBI=
Message-ID: <489ecd0c0602271920u7c0fc0b6p8a8cef0f408c6f3b@mail.gmail.com>
Date: Tue, 28 Feb 2006 11:20:23 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Replace "vmalloc_node" with "vmalloc" for no-mmu architectures in oprofile driver
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  This is a fix to the oprofile driver. It calls "vmalloc_node()" but
no-mmu CPUs do not have that function. "vmalloc()" is OK for no-mmu
CPUs.

Signed-off-by: Luke Yang <luke.adi@gmail.com>

Index: linux-2.6/drivers/oprofile/cpu_buffer.c
===================================================================
--- linux-2.6/drivers/oprofile/cpu_buffer.c     2006-02-16
16:16:35.000000000 +0800
+++ linux-2.6/drivers/oprofile/cpu_buffer.c     2006-02-16
16:20:58.000000000 +0800
@@ -51,9 +51,13 @@

        for_each_online_cpu(i) {
                struct oprofile_cpu_buffer * b = &cpu_buffer[i];
-
+
+#ifdef MMU
                b->buffer = vmalloc_node(sizeof(struct op_sample) * buffer_size,
                        cpu_to_node(i));
+#else
+               b->buffer = vmalloc(sizeof(struct op_sample) * buffer_size);
+#endif
                if (!b->buffer)
                        goto fail;

--
Best regards,
Luke Yang
magic.yyang@gmail.com; luke.adi@gmail.com
