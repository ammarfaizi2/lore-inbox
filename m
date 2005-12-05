Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbVLEXdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbVLEXdq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbVLEXdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:33:46 -0500
Received: from mail.suse.de ([195.135.220.2]:12936 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964867AbVLEXd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:33:27 -0500
From: Neil Brown <neilb@suse.de>
To: Jurriaan <thunder7@xs4all.nl>
Date: Tue, 6 Dec 2005 10:33:21 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17300.52801.734773.284847@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-mm1: raid related oops
In-Reply-To: message from jurriaan on Monday December 5
References: <20051205195004.GA11243@amd64.of.nowhere>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday December 5, thunder7@xs4all.nl wrote:
> Written by hand:
> 
> Null pointer dereference
> last sysfs file /block/md0/md/sync_action
> put_page

ohh dear, it seems that, unlike kfree, put_page doesn't like 'NULL' as
an argument.

You can try
------------------
diff ./mm/swap.c~current~ ./mm/swap.c
--- ./mm/swap.c~current~	2005-12-06 10:29:16.000000000 +1100
+++ ./mm/swap.c	2005-12-06 10:29:25.000000000 +1100
@@ -36,6 +36,8 @@ int page_cluster;
 
 void put_page(struct page *page)
 {
+	if (unlikely(page==NULL))
+		return;
 	if (unlikely(PageCompound(page))) {
 		page = (struct page *)page_private(page);
 		if (put_page_testzero(page)) {

-------------------
for now.  If Andrew doesn't like that I'll make the code in raid1
more careful (maybe I'll define put_page_unless_null :-)

Thanks for the testing and the report.

NeilBrown
