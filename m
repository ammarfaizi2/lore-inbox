Return-Path: <linux-kernel-owner+w=401wt.eu-S1754303AbWLYIPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303AbWLYIPJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 03:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754307AbWLYIPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 03:15:09 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:47222 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754303AbWLYIPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 03:15:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=jXPGECqUMo/vANFkDVK9rh6I6mK/NQgKqkYUekqEhuDe/Ce4jrHnRYZKvIDPz+ZUaAoTXtZg9iORa1ADPG6OPf+Swo1lAlsjY58A1rH0Mx9CD35Rv6FYOyloBjQjCdMU4M/HobeM6um0xErLKJ71KNS+9egFwXyX/W2ufgd6ww0=
Date: Mon, 25 Dec 2006 17:14:53 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Hoang-Nam Nguyen <hnguyen@de.ibm.com>,
       Christoph Raisch <raisch@de.ibm.com>, akpm@osdl.org
Subject: [PATCH -mm] ehca: fix memleak on module unloading
Message-ID: <20061225081453.GC3869@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux-kernel@vger.kernel.org, Hoang-Nam Nguyen <hnguyen@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>, akpm@osdl.org
References: <20061219084248.GF4049@APFDCB5C> <20061221212202.GA23157@osiris.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061221212202.GA23157@osiris.ibm.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] ehca: fix memleak on module unloading

percpu data is not freed on module unloading.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
Cc: Christoph Raisch <raisch@de.ibm.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 drivers/infiniband/hw/ehca/ehca_irq.c |    2 ++
 1 file changed, 2 insertions(+)

Index: 2.6-mm/drivers/infiniband/hw/ehca/ehca_irq.c
===================================================================
--- 2.6-mm.orig/drivers/infiniband/hw/ehca/ehca_irq.c
+++ 2.6-mm/drivers/infiniband/hw/ehca/ehca_irq.c
@@ -757,6 +757,8 @@ void ehca_destroy_comp_pool(void)
 		if (cpu_online(i))
 			destroy_comp_task(pool, i);
 	}
+	free_percpu(pool->cpu_comp_tasks);
+	kfree(pool);
 #endif
 
 	return;
